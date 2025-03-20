#!/usr/bin/env python3

"""
Merge sort implementation in Python
Time complexity: O(n log n)
Space complexity: O(n)
"""

from typing import List, TypeVar, Generic

T = TypeVar('T')

def merge_sort(arr: List[T]) -> List[T]:
    """
    Sorts a list using merge sort algorithm

    Args:
        arr: The list to sort

    Returns:
        The sorted list
    """
    if len(arr) <= 1:
        return arr

    # Split list into two halves
    mid = len(arr) // 2
    left = arr[:mid]
    right = arr[mid:]

    # Recursively sort both halves
    left = merge_sort(left)
    right = merge_sort(right)

    # Merge the sorted halves
    return merge(left, right)

def merge(left: List[T], right: List[T]) -> List[T]:
    """
    Helper function to merge two sorted lists

    Args:
        left: First sorted list
        right: Second sorted list

    Returns:
        Merged sorted list
    """
    result = []
    i = j = 0

    # Compare elements from both lists and merge them
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    # Copy remaining elements from left list
    result.extend(left[i:])

    # Copy remaining elements from right list
    result.extend(right[j:])

    return result

def main():
    import sys

    if len(sys.argv) < 2:
        print("Please provide a file path as an argument", file=sys.stderr)
        sys.exit(1)

    try:
        # Read numbers from file
        with open(sys.argv[1], 'r') as f:
            numbers = [int(line.strip()) for line in f if line.strip()]

        # Sort the list
        sorted_numbers = merge_sort(numbers)

        # Write sorted numbers back to file
        with open('sorted_data.txt', 'w') as f:
            for num in sorted_numbers:
                f.write(f"{num}\n")

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
