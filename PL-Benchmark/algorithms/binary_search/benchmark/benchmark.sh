#!/bin/bash

# Benchmark script for binary search algorithm

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ALGORITHM_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$(dirname "$ALGORITHM_DIR")")"

# Source the common utilities using absolute path
source "$PROJECT_ROOT/utils/common.sh"

# Activate virtual environment if it exists
if [ -f "$PROJECT_ROOT/venv/bin/activate" ]; then
    source "$PROJECT_ROOT/venv/bin/activate"
fi

# Set up variables
IMPLEMENTATIONS_DIR="$ALGORITHM_DIR/implementations"
RESULTS_DIR="$SCRIPT_DIR/results"
INPUT_FILE="$SCRIPT_DIR/input.txt"
SIZE=100000
RUNS=100
ALGORITHM="binary_search"

# Create results directory
mkdir -p "$RESULTS_DIR"

# Initialize results CSV with header
echo "language,algorithm,total_time,avg_time,runs" > "$RESULTS_DIR/results.csv"

# Generate input data (sorted array)
echo "Generating test data..."
generate_sorted_array $SIZE "$INPUT_FILE"

# Check dependencies
check_dependencies

# Run benchmarks for all language implementations
echo -e "${BLUE}Starting binary search benchmarks...${NC}"
echo "----------------------------------------"

# Java implementation
if [ -d "$IMPLEMENTATIONS_DIR/java" ]; then
    run_benchmark "Java" "java -cp $IMPLEMENTATIONS_DIR/java/src BinarySearch $INPUT_FILE" \
        "javac -d $IMPLEMENTATIONS_DIR/java/src $IMPLEMENTATIONS_DIR/java/src/BinarySearch.java" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Python implementation
if [ -d "$IMPLEMENTATIONS_DIR/python" ]; then
    run_benchmark "Python" "python3 $IMPLEMENTATIONS_DIR/python/src/binary_search.py $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# JavaScript implementation
if [ -d "$IMPLEMENTATIONS_DIR/javascript" ]; then
    if [ ! -d "$IMPLEMENTATIONS_DIR/javascript/node_modules" ]; then
        echo "Setting up JavaScript dependencies..."
        (cd "$IMPLEMENTATIONS_DIR/javascript" && npm init -y && npm install)
    fi
    run_benchmark "JavaScript" "node $IMPLEMENTATIONS_DIR/javascript/src/binary_search.js $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# TypeScript implementation
if [ -d "$IMPLEMENTATIONS_DIR/typescript" ]; then
    if [ ! -d "$IMPLEMENTATIONS_DIR/typescript/node_modules" ]; then
        echo "Setting up TypeScript dependencies..."
        (cd "$IMPLEMENTATIONS_DIR/typescript" && npm install)
    fi
    run_benchmark "TypeScript" "node $IMPLEMENTATIONS_DIR/typescript/dist/binary_search.js $INPUT_FILE" \
        "cd $IMPLEMENTATIONS_DIR/typescript && npm run build" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Go implementation
if [ -d "$IMPLEMENTATIONS_DIR/go" ]; then
    run_benchmark "Go" "go run $IMPLEMENTATIONS_DIR/go/src/binary_search.go $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# C implementation
if [ -d "$IMPLEMENTATIONS_DIR/c" ]; then
    run_benchmark "C" "$IMPLEMENTATIONS_DIR/c/src/binary_search $INPUT_FILE" \
        "gcc -O2 -o $IMPLEMENTATIONS_DIR/c/src/binary_search $IMPLEMENTATIONS_DIR/c/src/binary_search.c" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# C++ implementation
if [ -d "$IMPLEMENTATIONS_DIR/cpp" ]; then
    run_benchmark "C++" "$IMPLEMENTATIONS_DIR/cpp/src/binary_search $INPUT_FILE" \
        "g++ -O2 -std=c++11 -o $IMPLEMENTATIONS_DIR/cpp/src/binary_search $IMPLEMENTATIONS_DIR/cpp/src/binary_search.cpp" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# PHP implementation
if [ -d "$IMPLEMENTATIONS_DIR/php" ]; then
    run_benchmark "PHP" "php $IMPLEMENTATIONS_DIR/php/src/binary_search.php $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Perl implementation
if [ -d "$IMPLEMENTATIONS_DIR/perl" ]; then
    run_benchmark "Perl" "perl $IMPLEMENTATIONS_DIR/perl/src/binary_search.pl $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Lua implementation
if [ -d "$IMPLEMENTATIONS_DIR/lua" ]; then
    run_benchmark "Lua" "lua $IMPLEMENTATIONS_DIR/lua/src/binary_search.lua $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Rust implementation
if [ -d "$IMPLEMENTATIONS_DIR/rust" ]; then
    if [ ! -f "$IMPLEMENTATIONS_DIR/rust/Cargo.toml" ]; then
        echo "Setting up Rust project..."
        (cd "$IMPLEMENTATIONS_DIR/rust" && cargo init)
    fi
    run_benchmark "Rust" "$IMPLEMENTATIONS_DIR/rust/target/release/binary_search $INPUT_FILE" \
        "cd $IMPLEMENTATIONS_DIR/rust && cargo build --release" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Swift implementation
if [ -d "$IMPLEMENTATIONS_DIR/swift" ]; then
    run_benchmark "Swift" "$IMPLEMENTATIONS_DIR/swift/src/binary_search $INPUT_FILE" \
        "swiftc -O -o $IMPLEMENTATIONS_DIR/swift/src/binary_search $IMPLEMENTATIONS_DIR/swift/src/binary_search.swift" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Assembly implementation
if [ -d "$IMPLEMENTATIONS_DIR/assembly" ]; then
    # Get OS-specific assembly flags
    ASM_FLAGS=$(get_asm_flags)
    OBJ_FILE="$IMPLEMENTATIONS_DIR/assembly/src/binary_search.o"
    OUT_FILE="$IMPLEMENTATIONS_DIR/assembly/src/binary_search"
    LINKER_CMD=$(get_linker_cmd "$OBJ_FILE" "$OUT_FILE")

    run_benchmark "Assembly" "$IMPLEMENTATIONS_DIR/assembly/src/binary_search $INPUT_FILE" \
        "nasm $ASM_FLAGS $IMPLEMENTATIONS_DIR/assembly/src/binary_search.asm -o $OBJ_FILE && $LINKER_CMD" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Bash implementation
if [ -d "$IMPLEMENTATIONS_DIR/bash" ]; then
    run_benchmark "Bash" "bash $IMPLEMENTATIONS_DIR/bash/src/binary_search.sh $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# C# implementation
if [ -d "$IMPLEMENTATIONS_DIR/csharp" ]; then
    run_benchmark "C#" "dotnet $IMPLEMENTATIONS_DIR/csharp/src/bin/Release/net8.0/binary_search.dll $INPUT_FILE" \
        "cd $IMPLEMENTATIONS_DIR/csharp/src && dotnet build -c Release" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Haskell implementation
if [ -d "$IMPLEMENTATIONS_DIR/haskell" ]; then
    run_benchmark "Haskell" "$IMPLEMENTATIONS_DIR/haskell/src/BinarySearch $INPUT_FILE" \
        "ghc -O2 $IMPLEMENTATIONS_DIR/haskell/src/BinarySearch.hs -o $IMPLEMENTATIONS_DIR/haskell/src/BinarySearch" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Kotlin implementation
if [ -d "$IMPLEMENTATIONS_DIR/kotlin" ]; then
    run_benchmark "Kotlin" "java -jar $IMPLEMENTATIONS_DIR/kotlin/src/binary_search.jar $INPUT_FILE" \
        "kotlinc $IMPLEMENTATIONS_DIR/kotlin/src/binary_search.kt -include-runtime -d $IMPLEMENTATIONS_DIR/kotlin/src/binary_search.jar" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Zig implementation
if [ -d "$IMPLEMENTATIONS_DIR/zig" ]; then
    run_benchmark "Zig" "$IMPLEMENTATIONS_DIR/zig/src/binary_search $INPUT_FILE" \
        "zig build-exe $IMPLEMENTATIONS_DIR/zig/src/binary_search.zig -femit-bin=$IMPLEMENTATIONS_DIR/zig/src/binary_search -O ReleaseFast" \
        "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# R implementation
if [ -d "$IMPLEMENTATIONS_DIR/r" ]; then
    run_benchmark "R" "Rscript $IMPLEMENTATIONS_DIR/r/src/binary_search.R $INPUT_FILE" \
        "" "$INPUT_FILE" "$RUNS" "$RESULTS_DIR" "$ALGORITHM"
fi

# Clean up
rm -f "$INPUT_FILE"

echo -e "${GREEN}Benchmark completed!${NC}"
echo -e "Results saved to $RESULTS_DIR/results.csv"

exit 0
