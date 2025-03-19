package main

import "testing"

func TestBinarySearch(t *testing.T) {
	tests := []struct {
		name     string
		arr      []int
		target   int
		expected int
	}{
		{"target in middle", []int{1, 2, 3, 4, 5}, 3, 2},
		{"target at start", []int{1, 2, 3, 4, 5}, 1, 0},
		{"target at end", []int{1, 2, 3, 4, 5}, 5, 4},
		{"target not present", []int{1, 2, 3, 4, 5}, 6, -1},
		{"empty array", []int{}, 1, -1},
		{"single element", []int{1}, 1, 0},
		{"negative numbers", []int{-5, -3, -1, 0, 2}, -3, 1},
		{"duplicate elements", []int{1, 2, 2, 2, 3}, 2, 1},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := BinarySearch(tt.arr, tt.target)
			if result != tt.expected {
				t.Errorf("BinarySearch(%v, %d) = %d; want %d",
					tt.arr, tt.target, result, tt.expected)
			}
		})
	}
}
