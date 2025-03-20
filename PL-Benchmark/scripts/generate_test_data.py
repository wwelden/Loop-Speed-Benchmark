#!/usr/bin/env python3

"""
Script to generate test data for algorithm benchmarks.
Supports generating both sorted arrays for binary search and
unsorted arrays for sorting algorithms.
"""

import sys
import os
import random
import argparse

def generate_random_numbers(size, min_val=-500000, max_val=500000, output_file="random_numbers.txt"):
    """Generate a list of random numbers for sorting algorithms."""
    with open(output_file, "w") as f:
        for _ in range(size):
            f.write(f"{random.randint(min_val, max_val)}\n")
    print(f"Generated {size} random numbers in {output_file}")

def generate_sorted_array(size, min_val=1, max_val=1000000, output_file="sorted_array.txt"):
    """Generate a sorted array of integers for binary search tests."""
    numbers = []
    step = max(1, (max_val - min_val) // size)

    # Generate roughly evenly distributed numbers
    for i in range(size):
        num = min_val + i * step + random.randint(0, step - 1)
        numbers.append(num)

    # Ensure the array is sorted
    numbers.sort()

    # Write to file
    with open(output_file, "w") as f:
        for num in numbers:
            f.write(f"{num}\n")

    print(f"Generated {size} sorted numbers in {output_file}")

def generate_search_targets(array_file, count=100, output_file="search_targets.txt"):
    """Generate search targets for binary search, some present in the array and some not."""
    # Read the array
    with open(array_file, "r") as f:
        array = [int(line.strip()) for line in f]

    # Generate targets
    targets = []

    # 50% of targets are present in the array
    present_count = count // 2
    if array:
        for _ in range(present_count):
            targets.append(random.choice(array))

    # 50% of targets are not present
    if array:
        min_val = min(array)
        max_val = max(array)
        for _ in range(count - present_count):
            # Generate a number that's likely not in the array
            while True:
                num = random.randint(min_val, max_val)
                if num not in array:
                    targets.append(num)
                    break
    else:
        # If array is empty, just generate random numbers
        for _ in range(count - present_count):
            targets.append(random.randint(-1000000, 1000000))

    # Write to file
    with open(output_file, "w") as f:
        for target in targets:
            f.write(f"{target}\n")

    print(f"Generated {count} search targets in {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Generate test data for algorithm benchmarks")
    parser.add_argument("algorithm", choices=["binary_search", "merge_sort"], help="Algorithm type to generate data for")
    parser.add_argument("--size", type=int, default=100000, help="Size of the generated array")
    parser.add_argument("--min", type=int, default=-500000, help="Minimum value in the array")
    parser.add_argument("--max", type=int, default=500000, help="Maximum value in the array")
    parser.add_argument("--output", type=str, default=None, help="Output file name")
    parser.add_argument("--targets", type=int, default=100, help="Number of search targets (binary search only)")

    args = parser.parse_args()

    # Set default output file if not specified
    if args.output is None:
        if args.algorithm == "binary_search":
            args.output = "sorted_array.txt"
        else:
            args.output = "random_numbers.txt"

    # Generate data based on algorithm type
    if args.algorithm == "binary_search":
        generate_sorted_array(args.size, args.min, args.max, args.output)
        # Also generate search targets
        generate_search_targets(args.output, args.targets, "search_targets.txt")
    else:  # merge_sort
        generate_random_numbers(args.size, args.min, args.max, args.output)

    print(f"Data generation completed for {args.algorithm}")

if __name__ == "__main__":
    main()
