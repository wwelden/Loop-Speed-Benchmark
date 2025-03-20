#!/bin/bash

# Script to migrate existing implementations to the new structure

# Source common utilities
source "$(dirname "$(dirname "$0")")/utils/common.sh"

echo -e "${BLUE}Starting migration of existing implementations...${NC}"

# Set up directories
OLD_DIR="$(dirname "$(dirname "$0")")/.."
NEW_DIR="$(dirname "$(dirname "$0")")"

# Check if MergeSort and SpeedTest directories exist
if [ ! -d "$OLD_DIR/MergeSort" ] || [ ! -d "$OLD_DIR/SpeedTest" ]; then
    echo -e "${RED}Error: MergeSort or SpeedTest directory not found.${NC}"
    exit 1
fi

# Function to migrate a language implementation
migrate_implementation() {
    local lang=$1
    local algo=$2
    local src_dir=$3
    local dest_dir=$4

    echo -e "${YELLOW}Migrating $lang implementation for $algo...${NC}"

    # Create destination directory
    mkdir -p "$dest_dir/$lang/src"

    # Check if source directory exists
    if [ ! -d "$src_dir" ]; then
        echo -e "${RED}Source directory $src_dir not found. Skipping.${NC}"
        return
    fi

    # Copy files
    if [ "$algo" == "merge_sort" ]; then
        # For merge sort
        if [ -f "$src_dir/src/merge_sort.py" ] || [ -f "$src_dir/src/MergeSort.java" ] || [ -f "$src_dir/src/merge_sort.cpp" ]; then
            cp -r "$src_dir/src/"* "$dest_dir/$lang/src/"
            echo -e "${GREEN}Migrated $lang implementation for $algo${NC}"
        else
            echo -e "${RED}No $algo implementation found for $lang. Skipping.${NC}"
        fi
    elif [ "$algo" == "binary_search" ]; then
        # For binary search
        if [ -f "$src_dir/src/binary_search.py" ] || [ -f "$src_dir/src/BinarySearch.java" ] || [ -f "$src_dir/src/binary_search.cpp" ]; then
            cp -r "$src_dir/src/"* "$dest_dir/$lang/src/"
            echo -e "${GREEN}Migrated $lang implementation for $algo${NC}"
        else
            echo -e "${RED}No $algo implementation found for $lang. Skipping.${NC}"
        fi
    fi
}

# Migrate implementations for each language and algorithm
languages=(
    "python"
    "java"
    "javascript:js"
    "typescript"
    "go"
    "c"
    "cpp"
    "php"
    "perl"
    "lua"
    "rust"
    "swift"
    "assembly:asm"
    "bash"
    "csharp"
    "haskell"
    "kotlin"
    "zig"
    "r"
    "scala"
)

for lang_mapping in "${languages[@]}"; do
    # Extract language name and directory name
    IFS=':' read -r lang_name dir_name <<< "$lang_mapping"
    if [ -z "$dir_name" ]; then
        dir_name=$lang_name
    fi

    # Migrate merge sort implementation
    migrate_implementation "$lang_name" "merge_sort" "$OLD_DIR/MergeSort/$dir_name" "$NEW_DIR/algorithms/merge_sort/implementations"

    # Migrate binary search implementation
    migrate_implementation "$lang_name" "binary_search" "$OLD_DIR/MergeSort/$dir_name" "$NEW_DIR/algorithms/binary_search/implementations"
done

echo -e "${GREEN}Migration completed!${NC}"
echo "Please check the implementations and make any necessary adjustments."
echo "You may need to update some file paths or configurations in the implementations."

exit 0
