#!/bin/bash

# Script to initialize the PL-Benchmark directory structure

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Initializing PL-Benchmark directory structure..."

# Create directory structure
mkdir -p "$SCRIPT_DIR/algorithms/binary_search/benchmark"
mkdir -p "$SCRIPT_DIR/algorithms/binary_search/build"
mkdir -p "$SCRIPT_DIR/algorithms/binary_search/implementations"

mkdir -p "$SCRIPT_DIR/algorithms/merge_sort/benchmark"
mkdir -p "$SCRIPT_DIR/algorithms/merge_sort/build"
mkdir -p "$SCRIPT_DIR/algorithms/merge_sort/implementations"

mkdir -p "$SCRIPT_DIR/scripts"
mkdir -p "$SCRIPT_DIR/utils"
mkdir -p "$SCRIPT_DIR/results/binary_search"
mkdir -p "$SCRIPT_DIR/results/merge_sort"

# Create language implementation directories for both algorithms
languages=(
    "assembly"
    "bash"
    "c"
    "cpp"
    "csharp"
    "go"
    "haskell"
    "java"
    "javascript"
    "kotlin"
    "lua"
    "perl"
    "php"
    "python"
    "r"
    "rust"
    "scala"
    "swift"
    "typescript"
    "zig"
)

for lang in "${languages[@]}"; do
    mkdir -p "$SCRIPT_DIR/algorithms/binary_search/implementations/$lang/src"
    mkdir -p "$SCRIPT_DIR/algorithms/merge_sort/implementations/$lang/src"
    echo "Created directory structure for $lang"
done

# Make sure all scripts are executable
if [ -f "$SCRIPT_DIR/run.sh" ]; then
    chmod +x "$SCRIPT_DIR/run.sh"
fi

if [ -f "$SCRIPT_DIR/activate_venv.sh" ]; then
    chmod +x "$SCRIPT_DIR/activate_venv.sh"
fi

find "$SCRIPT_DIR/scripts" -name "*.sh" -o -name "*.py" -exec chmod +x {} \;
find "$SCRIPT_DIR/algorithms" -name "*.sh" -exec chmod +x {} \;

echo "Directory structure initialized successfully!"
echo "Now you can run: ./run.sh"
exit 0
