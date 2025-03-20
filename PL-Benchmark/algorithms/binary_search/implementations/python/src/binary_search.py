#!/usr/bin/env python3

import sys
import time

def binary_search(arr, target):
    left, right = 0, len(arr) - 1

    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1

    return -1  # Target not found

def main():
    if len(sys.argv) < 3:
        print("Usage: python binary_search.py <input_file> <targets_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    targets_file = sys.argv[2]

    try:
        # Read sorted array
        with open(input_file, 'r') as f:
            numbers = [int(line.strip()) for line in f if line.strip()]

        # Read targets
        with open(targets_file, 'r') as f:
            targets = [int(line.strip()) for line in f if line.strip()]

        # Search for each target
        found = 0
        not_found = 0
        results = []

        for target in targets:
            index = binary_search(numbers, target)
            if index != -1:
                found += 1
                results.append(f"{target}: Found at index {index}")
            else:
                not_found += 1
                results.append(f"{target}: Not found")

        # Write results
        with open('binary_search_results.txt', 'w') as f:
            for result in results:
                f.write(f"{result}\n")

        print(f"Search results: found {found}, not found {not_found}")
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
