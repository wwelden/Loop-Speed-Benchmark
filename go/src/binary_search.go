package main

import "fmt"

// BinarySearch performs binary search to find the index of target in a sorted array.
// Returns -1 if the target is not found.
//
// Parameters:
//   - arr: A sorted slice of integers
//   - target: The value to search for
//
// Returns:
//   - The index of target if found, -1 otherwise
//
// Time Complexity: O(log n)
// Space Complexity: O(1)
func BinarySearch(arr []int, target int) int {
	if len(arr) == 0 {
		return -1
	}

	left, right := 0, len(arr)-1

	for left <= right {
		mid := (left + right) / 2

		switch {
		case arr[mid] == target:
			return mid
		case arr[mid] < target:
			left = mid + 1
		default:
			right = mid - 1
		}
	}

	return -1
}

func main() {
	// Test cases
	testCases := []struct {
		arr    []int
		target int
	}{
		{[]int{1, 2, 3, 4, 5}, 3}, // Target in middle
		{[]int{1, 2, 3, 4, 5}, 1}, // Target at start
		{[]int{1, 2, 3, 4, 5}, 5}, // Target at end
		{[]int{1, 2, 3, 4, 5}, 6}, // Target not present
		{[]int{}, 1},              // Empty array
		{[]int{1}, 1},             // Single element
	}

	for _, tc := range testCases {
		result := BinarySearch(tc.arr, tc.target)
		fmt.Printf("Array: %v, Target: %d, Result: %d\n", tc.arr, tc.target, result)
	}
}
