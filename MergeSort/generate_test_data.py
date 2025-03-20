#!/usr/bin/env python3

import random
import sys

def generate_test_data(size=10000000000, range_start=-10000000000, range_end=10000000000):
    """Generate a sorted array of random integers."""
    numbers = sorted(random.sample(range(range_start, range_end), size))
    return numbers

def write_test_data(numbers, filename='test_data.txt'):
    """Write the test data to a file."""
    with open(filename, 'w') as f:
        f.write('\n'.join(map(str, numbers)))

def main():
    if len(sys.argv) > 1:
        size = int(sys.argv[1])
    else:
        size = 10000000000

    print(f"Generating {size} random integers...")
    numbers = generate_test_data(size)
    write_test_data(numbers)
    print(f"Test data written to test_data.txt")

if __name__ == '__main__':
    main()
