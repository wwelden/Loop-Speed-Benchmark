#!/bin/bash

# Implementation of merge sort algorithm in Bash
# Time complexity: O(n log n)
# Space complexity: O(n)

# Function to merge two sorted arrays
merge() {
    local left=("$@")
    local right=("${left[@]:$1}")
    local left_size=$1
    local right_size=${#right[@]}
    local result=()
    local i=0
    local j=0

    # Compare elements from both arrays and merge them
    while ((i < left_size && j < right_size)); do
        if ((left[i] <= right[j])); then
            result+=("${left[i]}")
            ((i++))
        else
            result+=("${right[j]}")
            ((j++))
        fi
    done

    # Copy remaining elements from left array
    while ((i < left_size)); do
        result+=("${left[i]}")
        ((i++))
    done

    # Copy remaining elements from right array
    while ((j < right_size)); do
        result+=("${right[j]}")
        ((j++))
    done

    echo "${result[@]}"
}

# Function to sort an array using merge sort
merge_sort() {
    local arr=("$@")
    local size=${#arr[@]}

    # Base case: array of size 0 or 1 is already sorted
    if ((size <= 1)); then
        echo "${arr[@]}"
        return
    fi

    # Split array into two halves
    local mid=$((size / 2))
    local left=("${arr[@]:0:mid}")
    local right=("${arr[@]:mid}")

    # Recursively sort both halves
    local sorted_left=($(merge_sort "${left[@]}"))
    local sorted_right=($(merge_sort "${right[@]}"))

    # Merge the sorted halves
    merge "${sorted_left[@]}" "${sorted_right[@]}"
}

# Check if file path is provided
if [ $# -lt 1 ]; then
    echo "Please provide a file path as an argument" >&2
    exit 1
fi

# Read numbers from file
if [ ! -f "$1" ]; then
    echo "File not found: $1" >&2
    exit 1
fi

# Read numbers into array
mapfile -t numbers < "$1"

# Sort the array
sorted_numbers=($(merge_sort "${numbers[@]}"))

# Write sorted numbers back to file
printf "%s\n" "${sorted_numbers[@]}" > sorted_data.txt

# Test function to check if array is sorted
is_sorted() {
    local arr=("$@")
    local size=${#arr[@]}
    for ((i=1; i<size; i++)); do
        if ((arr[i-1] > arr[i])); then
            return 1
        fi
    done
    return 0
}

# Run tests if DEBUG is set
if [ "${DEBUG:-0}" = "1" ]; then
    echo "Running tests..."

    # Test empty array
    empty_result=($(merge_sort))
    if [ ${#empty_result[@]} -eq 0 ] && is_sorted "${empty_result[@]}"; then
        echo "Empty array test passed"
    else
        echo "Empty array test failed"
    fi

    # Test single element
    single_result=($(merge_sort 1))
    if [ ${#single_result[@]} -eq 1 ] && [ "${single_result[0]}" = "1" ] && is_sorted "${single_result[@]}"; then
        echo "Single element test passed"
    else
        echo "Single element test failed"
    fi

    # Test two elements
    two_result=($(merge_sort 2 1))
    if [ ${#two_result[@]} -eq 2 ] && [ "${two_result[0]}" = "1" ] && [ "${two_result[1]}" = "2" ] && is_sorted "${two_result[@]}"; then
        echo "Two elements test passed"
    else
        echo "Two elements test failed"
    fi

    # Test multiple elements
    multiple_result=($(merge_sort 5 3 8 4 2))
    if [ ${#multiple_result[@]} -eq 5 ] && is_sorted "${multiple_result[@]}"; then
        echo "Multiple elements test passed"
    else
        echo "Multiple elements test failed"
    fi

    # Test duplicate elements
    duplicate_result=($(merge_sort 3 1 4 1 5 9 2 6 5 3 5))
    if is_sorted "${duplicate_result[@]}"; then
        echo "Duplicate elements test passed"
    else
        echo "Duplicate elements test failed"
    fi

    # Test negative numbers
    negative_result=($(merge_sort -3 1 -4 1 -5 9 -2 6 -5 3 -5))
    if is_sorted "${negative_result[@]}"; then
        echo "Negative numbers test passed"
    else
        echo "Negative numbers test failed"
    fi

    # Test large array
    large_array=()
    for ((i=0; i<1000; i++)); do
        large_array+=($((i % 1000)))
    done
    large_result=($(merge_sort "${large_array[@]}"))
    if is_sorted "${large_result[@]}"; then
        echo "Large array test passed"
    else
        echo "Large array test failed"
    fi

    echo "All tests completed"
fi
