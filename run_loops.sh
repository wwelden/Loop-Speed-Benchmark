#!/bin/bash

# Default value and input validation
if [ $# -eq 0 ]; then
    INPUT=7
    echo "No input provided, using default value: $INPUT"
else
    INPUT=$1
fi

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$WORKSPACE_DIR" || exit 1

# Function to print header
print_header() {
    echo "============================================"
    echo "$1"
    echo "============================================"
}

# Compile necessary programs
print_header "Compiling programs..."

# Function to compile if source exists
compile_if_exists() {
    local lang=$1
    local src=$2
    local cmd=$3

    if [ -f "$src" ]; then
        echo "Compiling $lang..."
        eval "$cmd"
    fi
}

# C#
if [ -f "csharp/Loop.cs" ]; then
    echo "Compiling C#..."
    (cd csharp && dotnet publish -c Release -o ./bin)
fi

# C
compile_if_exists "C" "c/loop.c" "gcc -O3 c/loop.c -o c/loop"

# C++
compile_if_exists "C++" "cpp/loop.cpp" "g++ -O3 cpp/loop.cpp -o cpp/loop"

# Go
if [ -f "go/loop.go" ]; then
    echo "Compiling Go..."
    (cd go && CGO_ENABLED=0 GOGC=off go build -ldflags="-s -w" loop.go)
fi

# GoOptimized
if [ -f "goOptimized/loop.go" ]; then
    echo "Compiling GoOptimized..."
    (cd goOptimized && CGO_ENABLED=0 GOGC=off go build -ldflags="-s -w" loop.go)
fi

# Rust
if [ -f "rust/Cargo.toml" ]; then
    echo "Compiling Rust..."
    (cd rust && cargo build --release)
fi

# Java
compile_if_exists "Java" "java/Loop.java" "javac java/Loop.java"

# Kotlin
if [ -f "kotlin/Loop.kt" ]; then
    echo "Compiling Kotlin..."
    kotlinc kotlin/Loop.kt -include-runtime -d kotlin/loop.jar
fi

# Scala
if [ -f "scala/Loop.scala" ]; then
    echo "Compiling Scala..."
    scalac scala/Loop.scala -d scala/loop.jar
fi

# TypeScript
if [ -f "ts/loop.ts" ]; then
    echo "Compiling TypeScript..."
    (cd ts && tsc loop.ts)
fi

# Zig
if [ -f "zig/loop.zig" ]; then
    echo "Compiling Zig..."
    (cd zig && zig build-exe loop.zig -O ReleaseFast)
fi

# Assembly
compile_if_exists "Assembly" "asm/loop.asm" "clang -nostartfiles -o asm/loop asm/loop.asm -e _start"

# AssemblyOptimized
# compile_if_exists "AssemblyOptimized" "asmOptimized/loop.asm" "clang -nostartfiles -o asmOptimized/loop asmOptimized/loop.asm -e _start"

print_header "Running performance tests..."

# Function to run and time a command if executable exists
run_test() {
    local lang=$1
    local cmd=$2
    local check_file=$3

    if [ -f "$check_file" ] || command -v "$(echo "$cmd" | cut -d' ' -f1)" >/dev/null 2>&1; then
        echo -n "$lang: "
        { time $cmd $INPUT > /dev/null; } 2>&1 | grep real | awk '{print $2}'
    fi
}

# Run tests for compiled languages
run_test "Assembly" "./asm/loop" "asm/loop"
# run_test "AssemblyOptimized" "./asmOptimized/loop" "asmOptimized/loop"
run_test "C" "./c/loop" "c/loop"
run_test "Zig" "./zig/loop" "zig/loop"
run_test "Rust" "./rust/target/release/loop_speed" "rust/target/release/loop_speed"
run_test "Go" "./go/loop" "go/loop"
run_test "GoOptimized" "./goOptimized/loop" "goOptimized/loop"
run_test "C++" "./cpp/loop" "cpp/loop"
run_test "C#" "./csharp/bin/Loop" "csharp/bin/Loop"
run_test "Java" "java -cp java Loop" "java/Loop.class"
run_test "Kotlin" "java -jar kotlin/loop.jar" "kotlin/loop.jar"
run_test "Scala" "scala scala/loop.jar" "scala/loop.jar"
run_test "TypeScript" "node ts/loop.js" "ts/loop.js"

# Run tests for interpreted languages
run_test "Haskell" "runhaskell haskell/Loop.hs" "haskell/Loop.hs"
run_test "JavaScript" "node js/loop.js" "js/loop.js"
run_test "Lua" "lua lua/loop.lua" "lua/loop.lua"
run_test "LuaJIT" "luajit lua/loop.lua" "lua/loop.lua"
run_test "PHP" "php php/loop.php" "php/loop.php"
run_test "Python" "python3 python/loop.py" "python/loop.py"
run_test "Perl" "perl perl/loop.pl" "perl/loop.pl"
run_test "Perl JIT" "perl -MO=JIT perl/loop_jit.pl" "perl/loop_jit.pl"
run_test "R" "Rscript r/loop.r" "r/loop.r"
run_test "Ruby" "ruby ruby/loop.rb" "ruby/loop.rb"
run_test "BashOptimized" "bash bashOptimized/loop.sh" "bashOptimized/loop.sh"
# run_test "Bash" "bash bash/loop.sh" "bash/loop.sh"

print_header "Tests completed"
