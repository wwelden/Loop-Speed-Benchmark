#!/bin/bash

# Common utility functions for PL-Benchmark

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to generate random numbers for merge sort
generate_random_numbers() {
    local size=$1
    local output_file=$2
    local min=${3:--500000}
    local max=${4:-500000}
    local range=$((max - min + 1))

    for ((i=0; i<size; i++)); do
        echo $((RANDOM % range + min)) >> "$output_file"
    done
}

# Function to generate sorted array with random element for binary search
generate_sorted_array() {
    local size=$1
    local output_file=$2
    local min=${3:-1}
    local max=${4:-1000000}
    local step=$((max / size))

    for ((i=0; i<size; i++)); do
        echo $((min + i * step + RANDOM % step)) >> "$output_file"
    done

    # Sort the array to ensure it's properly sorted
    sort -n -o "$output_file" "$output_file"
}

# Function to run benchmark for a language
run_benchmark() {
    local lang=$1
    local cmd=$2
    local compile_cmd=$3
    local input_file=$4
    local runs=${5:-100}
    local output_dir=${6:-"./results"}
    local algorithm=${7:-"unknown"}

    echo -e "${YELLOW}Benchmarking $lang implementation...${NC}"

    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"

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
        for ((i=1; i<=runs; i++)); do
            # Run the command
            if ! eval "$cmd"; then
                echo -e "${RED}Failed to run $lang${NC}"
                return 1
            fi

            # Progress indicator
            if ((i % 10 == 0)); then
                echo -n "."
            fi
        done
        echo
    ); } 2> "$output_dir/${lang}_time.txt"

    # Extract real execution time
    local total_time=$(grep real "$output_dir/${lang}_time.txt" | awk '{print $2}')
    local avg_time=$(echo "scale=6; $total_time/$runs" | bc)

    # Print results
    echo -e "${GREEN}$lang:${NC}"
    echo "Total time: $total_time seconds"
    echo "Average time per run: $avg_time seconds"
    echo "----------------------------------------"

    # Save results to CSV
    echo "$lang,$algorithm,$total_time,$avg_time,$runs" >> "$output_dir/results.csv"

    # Clean up
    rm -f "$output_dir/${lang}_time.txt"
}

# Function to check all dependencies
check_dependencies() {
    local deps=(
        "javac:Java compiler"
        "java:Java runtime"
        "python3:Python 3"
        "node:Node.js"
        "npm:Node Package Manager"
        "go:Go compiler"
        "gcc:GNU C Compiler"
        "g++:GNU C++ Compiler"
        "php:PHP interpreter"
        "perl:Perl interpreter"
        "lua:Lua interpreter"
        "cargo:Rust package manager"
        "rustc:Rust compiler"
        "swiftc:Swift compiler"
        "nasm:Netwide Assembler"
        "dotnet:.NET SDK"
        "ghc:Glasgow Haskell Compiler"
        "kotlinc:Kotlin compiler"
        "zig:Zig compiler"
        "Rscript:R interpreter"
    )

    echo -e "${BLUE}Checking dependencies...${NC}"
    local missing=0

    for dep in "${deps[@]}"; do
        local cmd="${dep%%:*}"
        local desc="${dep#*:}"

        if command_exists "$cmd"; then
            echo -e "${GREEN}✓ $desc${NC}"
        else
            echo -e "${RED}✗ $desc${NC}"
            missing=$((missing + 1))
        fi
    done

    if [ $missing -gt 0 ]; then
        echo -e "${YELLOW}Warning: $missing dependencies are missing${NC}"
    else
        echo -e "${GREEN}All dependencies are installed!${NC}"
    fi
}

# Detect OS for platform-specific commands
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Get correct flags for Assembly based on OS
get_asm_flags() {
    local os=$(detect_os)
    if [[ "$os" == "linux" ]]; then
        echo "-f elf64"
    elif [[ "$os" == "macos" ]]; then
        echo "-f macho64"
    elif [[ "$os" == "windows" ]]; then
        echo "-f win64"
    else
        echo "-f elf64"  # Default to ELF format
    fi
}

# Get correct linker command based on OS
get_linker_cmd() {
    local os=$(detect_os)
    local obj_file=$1
    local out_file=$2

    if [[ "$os" == "linux" ]]; then
        echo "ld -o $out_file $obj_file"
    elif [[ "$os" == "macos" ]]; then
        echo "ld -o $out_file $obj_file -lSystem -syslibroot $(xcrun -show-sdk-path) -e _main -arch x86_64"
    elif [[ "$os" == "windows" ]]; then
        echo "link $obj_file /OUT:$out_file"
    else
        echo "ld -o $out_file $obj_file"  # Default linker command
    fi
}

# Export functions
export -f command_exists
export -f generate_random_numbers
export -f generate_sorted_array
export -f run_benchmark
export -f check_dependencies
export -f detect_os
export -f get_asm_flags
export -f get_linker_cmd
