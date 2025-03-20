#!/bin/bash

# Script to migrate existing implementations to the new directory structure

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Migrating existing implementations to new directory structure..."

# Make sure the directory structure exists first
if [ -f "$SCRIPT_DIR/init_structure.sh" ]; then
    bash "$SCRIPT_DIR/init_structure.sh"
else
    echo "Error: init_structure.sh not found!"
    exit 1
fi

# Function to migrate implementations
migrate_implementation() {
    local algo=$1
    local lang=$2
    local src_dir=$3
    local dest_dir="$SCRIPT_DIR/algorithms/$algo/implementations/$lang/src"

    if [ -d "$src_dir" ]; then
        echo "Migrating $lang $algo implementation..."

        # Create target directory if it doesn't exist
        mkdir -p "$dest_dir"

        # Copy all files from source to destination
        if cp -r "$src_dir"/* "$dest_dir" 2>/dev/null; then
            echo "Successfully migrated $lang $algo implementation."
        else
            echo "Warning: No files found in $src_dir to migrate."
        fi
    else
        echo "Skipping $lang $algo implementation (directory not found)."
    fi
}

# Migrate merge sort implementations
echo "Migrating merge sort implementations..."

migrate_implementation "merge_sort" "assembly" "$SCRIPT_DIR/asm/src"
migrate_implementation "merge_sort" "bash" "$SCRIPT_DIR/bash/src"
migrate_implementation "merge_sort" "c" "$SCRIPT_DIR/c/src"
migrate_implementation "merge_sort" "cpp" "$SCRIPT_DIR/cpp/src"
migrate_implementation "merge_sort" "csharp" "$SCRIPT_DIR/csharp/src"
migrate_implementation "merge_sort" "go" "$SCRIPT_DIR/go/src"
migrate_implementation "merge_sort" "haskell" "$SCRIPT_DIR/haskell/src"
migrate_implementation "merge_sort" "java" "$SCRIPT_DIR/java/src"
migrate_implementation "merge_sort" "javascript" "$SCRIPT_DIR/javascript/src"
migrate_implementation "merge_sort" "kotlin" "$SCRIPT_DIR/kotlin/src"
migrate_implementation "merge_sort" "lua" "$SCRIPT_DIR/lua/src"
migrate_implementation "merge_sort" "perl" "$SCRIPT_DIR/perl/src"
migrate_implementation "merge_sort" "php" "$SCRIPT_DIR/php/src"
migrate_implementation "merge_sort" "python" "$SCRIPT_DIR/python/src"
migrate_implementation "merge_sort" "r" "$SCRIPT_DIR/r/src"
migrate_implementation "merge_sort" "rust" "$SCRIPT_DIR/rust/src"
migrate_implementation "merge_sort" "scala" "$SCRIPT_DIR/scala/src"
migrate_implementation "merge_sort" "swift" "$SCRIPT_DIR/swift/src"
migrate_implementation "merge_sort" "typescript" "$SCRIPT_DIR/typescript/src"
migrate_implementation "merge_sort" "zig" "$SCRIPT_DIR/zig/src"

# Migrate binary search implementations
echo "Migrating binary search implementations..."

migrate_implementation "binary_search" "assembly" "$SCRIPT_DIR/asm/binary_search"
migrate_implementation "binary_search" "bash" "$SCRIPT_DIR/bash/binary_search"
migrate_implementation "binary_search" "c" "$SCRIPT_DIR/c/binary_search"
migrate_implementation "binary_search" "cpp" "$SCRIPT_DIR/cpp/binary_search"
migrate_implementation "binary_search" "csharp" "$SCRIPT_DIR/csharp/binary_search"
migrate_implementation "binary_search" "go" "$SCRIPT_DIR/go/binary_search"
migrate_implementation "binary_search" "haskell" "$SCRIPT_DIR/haskell/binary_search"
migrate_implementation "binary_search" "java" "$SCRIPT_DIR/java/binary_search"
migrate_implementation "binary_search" "javascript" "$SCRIPT_DIR/javascript/binary_search"
migrate_implementation "binary_search" "kotlin" "$SCRIPT_DIR/kotlin/binary_search"
migrate_implementation "binary_search" "lua" "$SCRIPT_DIR/lua/binary_search"
migrate_implementation "binary_search" "perl" "$SCRIPT_DIR/perl/binary_search"
migrate_implementation "binary_search" "php" "$SCRIPT_DIR/php/binary_search"
migrate_implementation "binary_search" "python" "$SCRIPT_DIR/python/binary_search"
migrate_implementation "binary_search" "r" "$SCRIPT_DIR/r/binary_search"
migrate_implementation "binary_search" "rust" "$SCRIPT_DIR/rust/binary_search"
migrate_implementation "binary_search" "scala" "$SCRIPT_DIR/scala/binary_search"
migrate_implementation "binary_search" "swift" "$SCRIPT_DIR/swift/binary_search"
migrate_implementation "binary_search" "typescript" "$SCRIPT_DIR/typescript/binary_search"
migrate_implementation "binary_search" "zig" "$SCRIPT_DIR/zig/binary_search"

# Migrate benchmark scripts
if [ -f "$SCRIPT_DIR/benchmark.sh" ]; then
    mkdir -p "$SCRIPT_DIR/scripts"
    cp "$SCRIPT_DIR/benchmark.sh" "$SCRIPT_DIR/scripts/old_benchmark.sh"
    echo "Copied original benchmark.sh to scripts/old_benchmark.sh for reference"
fi

if [ -f "$SCRIPT_DIR/generate_test_data.py" ]; then
    mkdir -p "$SCRIPT_DIR/utils"
    cp "$SCRIPT_DIR/generate_test_data.py" "$SCRIPT_DIR/utils/"
    echo "Copied generate_test_data.py to utils directory"
fi

# Ensure scripts are executable
find "$SCRIPT_DIR/scripts" -name "*.sh" -exec chmod +x {} \;
find "$SCRIPT_DIR/utils" -name "*.py" -exec chmod +x {} \;

echo "Migration completed successfully!"
echo "The new structure has been created and existing implementations have been migrated."
echo "You can now run the benchmarks using the new scripts in the 'scripts' directory."
exit 0
