#!/usr/bin/env python3

import unittest
from typing import List
from merge_sort import merge_sort

def is_sorted(arr: List) -> bool:
    """
    Helper function to check if a list is sorted

    Args:
        arr: The list to check

    Returns:
        True if the list is sorted, False otherwise
    """
    return all(arr[i] <= arr[i + 1] for i in range(len(arr) - 1))

class TestMergeSort(unittest.TestCase):
    def test_empty_list(self):
        arr = []
        result = merge_sort(arr)
        self.assertEqual(result, [])
        self.assertTrue(is_sorted(result))

    def test_single_element(self):
        arr = [1]
        result = merge_sort(arr)
        self.assertEqual(result, [1])
        self.assertTrue(is_sorted(result))

    def test_two_elements(self):
        arr = [2, 1]
        result = merge_sort(arr)
        self.assertEqual(result, [1, 2])
        self.assertTrue(is_sorted(result))

    def test_multiple_elements(self):
        arr = [5, 3, 8, 4, 2]
        result = merge_sort(arr)
        self.assertEqual(result, [2, 3, 4, 5, 8])
        self.assertTrue(is_sorted(result))

    def test_duplicate_elements(self):
        arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        result = merge_sort(arr)
        self.assertTrue(is_sorted(result))

    def test_negative_numbers(self):
        arr = [-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5]
        result = merge_sort(arr)
        self.assertTrue(is_sorted(result))

    def test_large_list(self):
        import random
        size = 1000
        arr = [random.randint(0, 999) for _ in range(size)]
        result = merge_sort(arr)
        self.assertTrue(is_sorted(result))

    def test_strings(self):
        arr = ["banana", "apple", "cherry", "date", "elderberry"]
        result = merge_sort(arr)
        self.assertTrue(is_sorted(result))

    def test_mixed_types(self):
        with self.assertRaises(TypeError):
            merge_sort([1, "two", 3.0])

if __name__ == '__main__':
    unittest.main()
