#!/usr/bin/env python3

import argparse
import random
import os
import sys

def parse_args():
    parser = argparse.ArgumentParser(description='Generate test data for benchmarking')
    parser.add_argument('--output', type=str, default=None,
                      help='Output file path (default: based on algorithm)')
    parser.add_argument('--count', type=int, default=10000,
                      help='Number of elements to generate (default: 10000)')
    parser.add_argument('--min', type=int, default=1,
                      help='Minimum value (default: 1)')
    parser.add_argument('--max', type=int, default=1000000,
                      help='Maximum value (default: 1000000)')
    parser.add_argument('--algorithm', type=str, default='all',
                      choices=['all', 'merge_sort', 'binary_search'],
                      help='Algorithm to generate data for (default: all)')
    return parser.parse_args()

def generate_merge_sort_data(count, min_val, max_val):
    """Generate random unsorted data for merge sort"""
    return [random.randint(min_val, max_val) for _ in range(count)]

def generate_binary_search_data(count, min_val, max_val):
    """Generate sorted data for binary search"""
    data = [random.randint(min_val, max_val) for _ in range(count)]
    return sorted(data)

def generate_search_targets(data, count=100):
    """Generate search targets for binary search"""
    # 70% existing values, 30% non-existing values
    existing_count = int(count * 0.7)
    non_existing_count = count - existing_count

    # Select random existing values
    existing_targets = random.sample(data, min(existing_count, len(data)))

    # Generate non-existing values
    data_set = set(data)
    min_val, max_val = min(data), max(data)
    non_existing_targets = []

    while len(non_existing_targets) < non_existing_count:
        val = random.randint(min_val, max_val)
        if val not in data_set:
            non_existing_targets.append(val)

    # Combine and shuffle
    all_targets = existing_targets + non_existing_targets
    random.shuffle(all_targets)

    return all_targets

def write_to_file(data, filepath):
    """Write data to file, one number per line"""
    with open(filepath, 'w') as f:
        for num in data:
            f.write(f"{num}\n")
    print(f"Generated {len(data)} numbers and saved to {filepath}")

def main():
    args = parse_args()

    # Get project root directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)

    # Generate data for merge sort
    if args.algorithm in ['all', 'merge_sort']:
        merge_sort_data = generate_merge_sort_data(args.count, args.min, args.max)
        merge_sort_file = args.output if args.output and args.algorithm == 'merge_sort' else os.path.join(project_root, 'benchmark_input.txt')
        write_to_file(merge_sort_data, merge_sort_file)

    # Generate data for binary search
    if args.algorithm in ['all', 'binary_search']:
        binary_search_data = generate_binary_search_data(args.count, args.min, args.max)
        binary_search_file = args.output if args.output and args.algorithm == 'binary_search' else os.path.join(project_root, 'binary_search_input.txt')
        write_to_file(binary_search_data, binary_search_file)

        # Generate search targets
        targets = generate_search_targets(binary_search_data)
        targets_file = os.path.join(project_root, 'binary_search_targets.txt')
        write_to_file(targets, targets_file)

if __name__ == "__main__":
    main()
