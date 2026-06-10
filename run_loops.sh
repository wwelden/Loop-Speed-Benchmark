#!/bin/bash
# Compile and benchmark the loop implementations in every language present.
#
# Usage:   ./run_loops.sh [input]            (default input: 7)
#
# Environment variables:
#   RUNS=N           timed runs per language (default 3)
#   WARMUP=N         untimed warmup runs per language (default 1)
#   ONLY="A,B"       run only these languages (comma-separated labels)
#   SKIP="A,B"       skip these languages (comma-separated labels)
#   RESULTS_FILE=f   CSV output path (default results.csv)
#
# Timing uses hyperfine when installed (recommended), otherwise bash's
# builtin `time`. Results are printed to the terminal and written as CSV:
#   language,mean_s,min_s,max_s,runs

export LC_ALL=C

# --- Input validation ---
if [ $# -eq 0 ]; then
    INPUT=7
    echo "No input provided, using default value: $INPUT"
else
    INPUT=$1
fi

if ! [[ "$INPUT" =~ ^[0-9]+$ ]] || [ "$INPUT" -lt 1 ]; then
    echo "Error: input must be a positive integer, got '$INPUT'" >&2
    exit 1
fi

# Several implementations accumulate in 32-bit integers; above ~43000 the
# per-element sum exceeds 2^31 and languages with wider integers would
# silently compute different results.
if [ "$INPUT" -gt 40000 ]; then
    echo "Error: input must be <= 40000 (larger values overflow 32-bit accumulators)" >&2
    exit 1
fi

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$WORKSPACE_DIR" || exit 1

RUNS=${RUNS:-3}
WARMUP=${WARMUP:-1}
ONLY=${ONLY:-}
SKIP=${SKIP:-}
RESULTS_FILE=${RESULTS_FILE:-results.csv}

print_header() {
    echo "============================================"
    echo "$1"
    echo "============================================"
}

# --- Compilation ---
print_header "Compiling programs..."

# compile_if <label> <required tool> <source file> <command...>
compile_if() {
    local lang=$1 tool=$2 src=$3
    shift 3
    [ -f "$src" ] || return 0
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Skipping $lang ($tool not installed)"
        return 0
    fi
    echo "Compiling $lang..."
    "$@" || echo "warning: $lang compilation failed" >&2
}

compile_if "C"        gcc     c/loop.c         gcc -O3 c/loop.c -o c/loop
compile_if "C++"      g++     cpp/loop.cpp     g++ -O3 cpp/loop.cpp -o cpp/loop
compile_if "Swift"    swiftc  swift/loop.swift swiftc -O -o swift/loop swift/loop.swift
compile_if "Haskell"  ghc     haskell/Loop.hs  ghc -O2 haskell/Loop.hs -o haskell/loop
compile_if "Java"     javac   java/Loop.java   javac java/Loop.java
compile_if "Kotlin"   kotlinc kotlin/Loop.kt   kotlinc kotlin/Loop.kt -include-runtime -d kotlin/loop.jar
compile_if "Scala"    scalac  scala/Loop.scala scalac scala/Loop.scala -d scala/loop.jar
compile_if "Assembly" clang   asm/loop.asm     clang asm/loop.asm -o asm/loop

if [ -f csharp/Loop.cs ] && command -v dotnet >/dev/null 2>&1; then
    echo "Compiling C#..."
    (cd csharp && dotnet publish -c Release -o ./bin >/dev/null) || echo "warning: C# compilation failed" >&2
fi

if [ -f go/loop.go ] && command -v go >/dev/null 2>&1; then
    echo "Compiling Go..."
    (cd go && CGO_ENABLED=0 go build -ldflags="-s -w" loop.go) || echo "warning: Go compilation failed" >&2
fi

if [ -f goOptimized/loop.go ] && command -v go >/dev/null 2>&1; then
    echo "Compiling GoOptimized..."
    (cd goOptimized && CGO_ENABLED=0 go build -ldflags="-s -w" loop.go) || echo "warning: GoOptimized compilation failed" >&2
fi

if [ -f rust/Cargo.toml ] && command -v cargo >/dev/null 2>&1; then
    echo "Compiling Rust..."
    (cd rust && cargo build --release --quiet) || echo "warning: Rust compilation failed" >&2
fi

if [ -f ts/loop.ts ] && command -v tsc >/dev/null 2>&1; then
    echo "Compiling TypeScript..."
    # tsc needs ts/node_modules for @types/node; newer tsc versions also
    # reject per-file compilation when a tsconfig.json is present (TS5112),
    # so build the project with its config.
    if [ ! -d ts/node_modules ] && command -v npm >/dev/null 2>&1; then
        (cd ts && npm ci --silent --no-audit --no-fund) || echo "warning: npm ci for TypeScript failed" >&2
    fi
    tsc -p ts || echo "warning: TypeScript compilation failed" >&2
fi

if [ -f zig/loop.zig ] && command -v zig >/dev/null 2>&1; then
    echo "Compiling Zig..."
    (cd zig && zig build-exe loop.zig -O ReleaseFast) || echo "warning: Zig compilation failed" >&2
fi

# --- Timing ---
print_header "Running performance tests..."
echo "Input: $INPUT | warmup runs: $WARMUP | timed runs: $RUNS"

HAVE_HYPERFINE=0
if command -v hyperfine >/dev/null 2>&1; then
    HAVE_HYPERFINE=1
    echo "Timing with hyperfine"
else
    echo "Timing with bash's builtin time (install hyperfine for better statistics)"
fi
echo

echo "language,mean_s,min_s,max_s,runs" > "$RESULTS_FILE"

# in_csv_list <needle> <comma-separated list>
in_csv_list() {
    case ",$2," in
        *,"$1",*) return 0 ;;
        *) return 1 ;;
    esac
}

# run_test <label> <command string> <required file>
run_test() {
    local lang=$1 cmd=$2 check_file=$3

    if [ -n "$ONLY" ] && ! in_csv_list "$lang" "$ONLY"; then return; fi
    if [ -n "$SKIP" ] && in_csv_list "$lang" "$SKIP"; then return; fi

    # The binary/interpreter must exist...
    local first_word=${cmd%% *}
    case "$first_word" in
        ./*|/*) [ -x "$first_word" ] || return ;;
        *) command -v "$first_word" >/dev/null 2>&1 || return ;;
    esac
    # ...and so must the compiled artifact or source it runs
    [ -f "$check_file" ] || return

    local mean min max
    if [ "$HAVE_HYPERFINE" -eq 1 ]; then
        local csv_tmp
        csv_tmp=$(mktemp)
        if ! hyperfine --style none --warmup "$WARMUP" --runs "$RUNS" \
                --export-csv "$csv_tmp" -- "$cmd $INPUT" >/dev/null 2>&1; then
            echo "$lang: failed to run" >&2
            rm -f "$csv_tmp"
            return
        fi
        # hyperfine CSV columns: command,mean,stddev,median,user,system,min,max
        IFS=, read -r _ mean _ _ _ _ min max < <(tail -n 1 "$csv_tmp")
        rm -f "$csv_tmp"
    else
        local i t times=""
        for ((i = 0; i < WARMUP; i++)); do
            if ! $cmd "$INPUT" >/dev/null 2>&1; then
                echo "$lang: failed to run" >&2
                return
            fi
        done
        for ((i = 0; i < RUNS; i++)); do
            t=$( { TIMEFORMAT='%R'; time $cmd "$INPUT" >/dev/null 2>/dev/null; } 2>&1 )
            if [ $? -ne 0 ] || [ -z "$t" ]; then
                echo "$lang: failed to run" >&2
                return
            fi
            times="$times $t"
        done
        read -r mean min max < <(echo "$times" | awk '{
            min = $1; max = $1; sum = 0
            for (i = 1; i <= NF; i++) { sum += $i; if ($i < min) min = $i; if ($i > max) max = $i }
            printf "%f %f %f", sum / NF, min, max
        }')
    fi

    # Normalize to fixed precision for display and CSV
    read -r mean min max < <(awk -v m="$mean" -v lo="$min" -v hi="$max" \
        'BEGIN { printf "%.4f %.4f %.4f", m, lo, hi }')

    printf '%-14s %ss  (min %s, max %s, n=%s)\n' "$lang:" "$mean" "$min" "$max" "$RUNS"
    echo "$lang,$mean,$min,$max,$RUNS" >> "$RESULTS_FILE"
}

# Compiled languages
run_test "Assembly"     "./asm/loop"                        "asm/loop"
run_test "C"            "./c/loop"                          "c/loop"
run_test "Zig"          "./zig/loop"                        "zig/loop"
run_test "Rust"         "./rust/target/release/loop_speed"  "rust/target/release/loop_speed"
run_test "Go"           "./go/loop"                         "go/loop"
run_test "GoOptimized"  "./goOptimized/loop"                "goOptimized/loop"
run_test "C++"          "./cpp/loop"                        "cpp/loop"
run_test "Swift"        "./swift/loop"                      "swift/loop"
run_test "Haskell"      "./haskell/loop"                    "haskell/loop"
run_test "C#"           "./csharp/bin/Loop"                 "csharp/bin/Loop"
run_test "Java"         "java -cp java Loop"                "java/Loop.class"
run_test "Kotlin"       "java -jar kotlin/loop.jar"         "kotlin/loop.jar"
run_test "Scala"        "scala scala/loop.jar --"           "scala/loop.jar"
run_test "TypeScript"   "node ts/loop.js"                   "ts/loop.js"

# Interpreted languages
run_test "JavaScript"   "node js/loop.js"                   "js/loop.js"
run_test "Lua"          "lua lua/loop.lua"                  "lua/loop.lua"
run_test "LuaJIT"       "luajit lua/loop.lua"               "lua/loop.lua"
run_test "PHP"          "php php/loop.php"                  "php/loop.php"
run_test "Python"       "python3 python/loop.py"            "python/loop.py"
run_test "Perl"         "perl perl/loop.pl"                 "perl/loop.pl"
run_test "R"            "Rscript r/loop.r"                  "r/loop.r"
run_test "Ruby"         "ruby ruby/loop.rb"                 "ruby/loop.rb"
run_test "Bash (via C)" "bash bashOptimized/loop.sh"        "bashOptimized/loop.sh"
# Pure Bash is disabled by default: 10^9 interpreted shell operations take hours.
# run_test "Bash"       "bash bash/loop.sh"                 "bash/loop.sh"

print_header "Tests completed"
echo "Results written to $RESULTS_FILE"
