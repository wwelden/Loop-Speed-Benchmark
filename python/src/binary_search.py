from typing import List, Optional

def binary_search(arr: List[int], target: int) -> Optional[int]:
    """
    Performs binary search to find the index of target in a sorted array.

    Args:
        arr: A sorted list of integers
        target: The value to search for

    Returns:
        The index of target if found, None otherwise

    Time Complexity: O(log n)
    Space Complexity: O(1)
    """
    if not arr:
        return None

    left, right = 0, len(arr) - 1

    while left <= right:
        mid = (left + right) // 2

        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1

    return None

# Example usage
if __name__ == "__main__":
    # Test cases
    test_cases = [
        ([1, 2, 3, 4, 5], 3),      # Target in middle
        ([1, 2, 3, 4, 5], 1),      # Target at start
        ([1, 2, 3, 4, 5], 5),      # Target at end
        ([1, 2, 3, 4, 5], 6),      # Target not present
        ([], 1),                    # Empty array
        ([1], 1),                   # Single element
    ]

    for arr, target in test_cases:
        result = binary_search(arr, target)
        print(f"Array: {arr}, Target: {target}, Result: {result}")
