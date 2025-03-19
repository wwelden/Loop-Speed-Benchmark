#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to generate random numbers
generate_random_numbers() {
    local size=$1
    local output_file=$2
    for ((i=0; i<size; i++)); do
        echo $((RANDOM % 1000000 - 500000)) >> "$output_file"
    done
}

# Function to compile and run benchmark for a language
run_benchmark() {
    local lang=$1
    local cmd=$2
    local compile_cmd=$3
    local input_file="benchmark_input.txt"
    local size=10000  # Size of each array

    echo -e "${YELLOW}Benchmarking $lang implementation...${NC}"

    # Compile if needed
    if [ -n "$compile_cmd" ]; then
        echo "Compiling $lang..."
        if ! eval "$compile_cmd"; then
            echo -e "${RED}Failed to compile $lang${NC}"
            return 1
        fi
    fi

    # Use time command to measure total execution time
    { time -p (
        for ((i=1; i<=100; i++)); do
            # Generate a new random input file
            generate_random_numbers $size "$input_file"

            # Run the command
            if ! eval "$cmd"; then
                echo -e "${RED}Failed to run $lang${NC}"
                return 1
            fi

            # Clean up
            rm -f "$input_file"

            # Progress indicator
            if ((i % 10 == 0)); then
                echo -n "."
            fi
        done
        echo
    ); } 2> time_output.txt

    # Extract real execution time
    local total_time=$(grep real time_output.txt | awk '{print $2}')
    local avg_time=$(echo "scale=6; $total_time/100" | bc)

    # Print results
    echo -e "${GREEN}$lang:${NC}"
    echo "Total time: $total_time seconds"
    echo "Average time per run: $avg_time seconds"
    echo "----------------------------------------"

    # Clean up
    rm -f time_output.txt
}

# Create benchmark directory if it doesn't exist
mkdir -p benchmark_results

# Check for required compilers and interpreters
echo "Checking dependencies..."
for cmd in javac java python3 node npm go gcc g++ php perl lua cargo swiftc cobc; do
    if ! command_exists "$cmd"; then
        echo -e "${RED}Warning: $cmd is not installed${NC}"
    fi
done

# Run benchmarks for each language
echo -e "${YELLOW}Starting merge sort benchmarks...${NC}"
echo "----------------------------------------"

run_benchmark "Java" "java -cp java/src MergeSort benchmark_input.txt" \
    "javac -d java/src java/src/MergeSort.java"

run_benchmark "Python" "python3 python/src/merge_sort.py benchmark_input.txt"

# JavaScript setup
if [ ! -d "js/node_modules" ]; then
    echo "Setting up JavaScript dependencies..."
    cd js && npm init -y && npm install && cd ..
fi
run_benchmark "JavaScript" "node js/src/merge_sort.js benchmark_input.txt"

# TypeScript setup
if [ ! -d "typescript/node_modules" ]; then
    echo "Setting up TypeScript dependencies..."
    cd typescript && npm init -y && npm install typescript ts-node @types/node && cd ..
fi
# run_benchmark "TypeScript" "ts-node typescript/src/merge_sort.ts benchmark_input.txt" \
#     "cd typescript && npx tsc src/merge_sort.ts && cd .."

run_benchmark "Go" "go run go/src/merge_sort.go benchmark_input.txt"

run_benchmark "C" "./c/src/merge_sort benchmark_input.txt" \
    "gcc -o c/src/merge_sort c/src/merge_sort.c"

run_benchmark "C++" "./cpp/src/merge_sort benchmark_input.txt" \
    "g++ -std=c++11 -o cpp/src/merge_sort cpp/src/merge_sort.cpp"

run_benchmark "PHP" "php php/src/merge_sort.php benchmark_input.txt"

run_benchmark "Perl" "perl perl/src/merge_sort.pl benchmark_input.txt"

run_benchmark "Lua" "lua lua/src/merge_sort.lua benchmark_input.txt"

# Rust setup
if [ ! -f "rust/Cargo.toml" ]; then
    echo "Setting up Rust project..."
    cd rust && cargo init && cd ..
fi
run_benchmark "Rust" "./rust/target/release/merge_sort benchmark_input.txt" \
    "cd rust && cargo build --release && cd .."

# Swift setup
run_benchmark "Swift" "./swift/src/merge_sort benchmark_input.txt" \
    "swiftc -O swift/src/merge_sort.swift -o swift/src/merge_sort"

# Clean up
rm -f benchmark_input.txt

echo -e "${GREEN}Benchmark completed!${NC}"
