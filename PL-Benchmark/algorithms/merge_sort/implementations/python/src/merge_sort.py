#!/usr/bin/env python3

import sys
import time

def merge_sort(arr):
    if len(arr) <= 1:
        return arr

    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])

    return merge(left, right)

def merge(left, right):
    result = []
    i, j = 0, 0

    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])
    return result

def main():
    if len(sys.argv) < 3:
        print("Usage: python merge_sort.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, 'r') as f:
            numbers = [int(line.strip()) for line in f if line.strip()]

        sorted_numbers = merge_sort(numbers)

        with open(output_file, 'w') as f:
            for num in sorted_numbers:
                f.write(f"{num}\n")

        print(f"Sorted {len(numbers)} numbers and saved to {output_file}")
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
