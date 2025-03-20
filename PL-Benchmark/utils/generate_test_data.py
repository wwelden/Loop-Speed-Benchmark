#!/usr/bin/env python3

import argparse
import random
import os
import sys
from pathlib import Path

def parse_args():
    parser = argparse.ArgumentParser(description='Generate test data for benchmarking')
    parser.add_argument('--output', type=str, default='benchmark_input.txt',
                      help='Output file path (default: benchmark_input.txt)')
    parser.add_argument('--count', type=int, default=10000,
                      help='Number of elements to generate (default: 10000)')
    parser.add_argument('--min', type=int, default=1,
                      help='Minimum value (default: 1)')
    parser.add_argument('--max', type=int, default=1000000,
                      help='Maximum value (default: 1000000)')
    parser.add_argument('--algorithm', type=str, default='all',
                      choices=['all', 'merge_sort', 'binary_search'],
                      help='Algorithm to generate data for (default: all)')
    parser.add_argument('--sorted', action='store_true',
                      help='Generate sorted data (for binary search)')
    parser.add_argument('--seed', type=int, default=None,
                      help='Random seed for reproducibility')
    return parser.parse_args()

def generate_random_numbers(count, min_val, max_val, sorted_output=False, seed=None):
    """Generate random integers between min_val and max_val."""
    if seed is not None:
        random.seed(seed)

    numbers = [random.randint(min_val, max_val) for _ in range(count)]

    if sorted_output:
        numbers.sort()

    return numbers

def generate_merge_sort_data(count, min_val, max_val, seed=None):
    """Generate data suitable for merge sort benchmarking."""
    return generate_random_numbers(count, min_val, max_val, False, seed)

def generate_binary_search_data(count, min_val, max_val, seed=None):
    """Generate data suitable for binary search benchmarking."""
    # For binary search, we need sorted data
    return generate_random_numbers(count, min_val, max_val, True, seed)

def generate_binary_search_targets(count, data, num_targets=100, seed=None):
    """Generate search targets for binary search."""
    if seed is not None:
        random.seed(seed)

    # 70% existing values, 30% non-existing values
    existing_count = int(num_targets * 0.7)
    non_existing_count = num_targets - existing_count

    # Sample from existing data
    existing_targets = random.sample(data, min(existing_count, len(data)))

    # Generate non-existing values
    all_data_set = set(data)
    non_existing_targets = []

    min_val = min(data)
    max_val = max(data)

    while len(non_existing_targets) < non_existing_count:
        val = random.randint(min_val, max_val)
        if val not in all_data_set:
            non_existing_targets.append(val)
            all_data_set.add(val)

    # Combine and shuffle
    all_targets = existing_targets + non_existing_targets
    random.shuffle(all_targets)

    return all_targets

def write_to_file(numbers, filename):
    """Write numbers to a file, one per line."""
    with open(filename, 'w') as f:
        for num in numbers:
            f.write(f"{num}\n")
    print(f"Generated {len(numbers)} numbers and saved to {filename}")

def main():
    args = parse_args()

    # Get the project root directory
    script_path = Path(os.path.abspath(__file__))
    project_root = script_path.parent.parent

    if args.output.startswith('/'):
        # Absolute path
        output_path = args.output
    else:
        # Relative path
        output_path = os.path.join(project_root, args.output)

    # Set up directory structure if needed
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Generate data based on algorithm
    if args.algorithm in ['all', 'merge_sort']:
        # Generate merge sort data
        merge_sort_data = generate_merge_sort_data(args.count, args.min, args.max, args.seed)
        merge_sort_output = output_path if args.algorithm == 'merge_sort' else os.path.join(project_root, 'benchmark_input.txt')
        write_to_file(merge_sort_data, merge_sort_output)

    if args.algorithm in ['all', 'binary_search']:
        # Generate binary search data (sorted)
        binary_search_data = generate_binary_search_data(args.count, args.min, args.max, args.seed)
        binary_search_output = output_path if args.algorithm == 'binary_search' else os.path.join(project_root, 'binary_search_input.txt')
        write_to_file(binary_search_data, binary_search_output)

        # Generate search targets
        binary_search_targets = generate_binary_search_targets(args.count, binary_search_data, 100, args.seed)
        binary_search_targets_output = os.path.join(os.path.dirname(binary_search_output), 'binary_search_targets.txt')
        write_to_file(binary_search_targets, binary_search_targets_output)

    return 0

if __name__ == "__main__":
    sys.exit(main())
