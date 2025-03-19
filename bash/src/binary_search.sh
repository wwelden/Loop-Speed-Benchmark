#!/bin/bash

# Binary Search Implementation in Bash
#
# Parameters:
#   $1 - Target value to search for
#   $2... - Sorted array of integers
#
# Returns:
#   Index of target if found, -1 otherwise
#
# Time Complexity: O(log n)
# Space Complexity: O(1)

binary_search() {
    local target=$1
    shift
    local arr=("$@")
    local left=0
    local right=$((${#arr[@]} - 1))

    # Handle empty array
    if [ ${#arr[@]} -eq 0 ]; then
        echo -1
        return
    fi

    while [ $left -le $right ]; do
        local mid=$(( (left + right) / 2 ))
        local mid_val=${arr[$mid]}

        if [ $mid_val -eq $target ]; then
            echo $mid
            return
        elif [ $mid_val -lt $target ]; then
            left=$((mid + 1))
        else
            if [ $mid -eq 0 ]; then
                break
            fi
            right=$((mid - 1))
        fi
    done

    echo -1
}

# Read numbers from file into array
read_numbers() {
    local filename=$1
    local arr=()
    while IFS= read -r line; do
        arr+=("$line")
    done < "$filename"
    echo "${arr[@]}"
}

# Main function
main() {
    local filename=${1:-test_data.txt}
    local numbers=($(read_numbers "$filename"))

    # Test with a few values
    local test_values=(
        "${numbers[${#numbers[@]}/2]}"  # Middle value
        "${numbers[0]}"                 # First value
        "${numbers[${#numbers[@]}-1]}"  # Last value
        "-999999"                      # Value not in array
    )

    for target in "${test_values[@]}"; do
        result=$(binary_search "$target" "${numbers[@]}")
        echo "Target: $target, Result: $result"
    done
}

main "$@"
