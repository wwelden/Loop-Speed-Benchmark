package main

import (
	"testing"
)

func isSorted[T Comparable](arr []T) bool {
	for i := 1; i < len(arr); i++ {
		if !arr[i-1].Less(arr[i]) {
			return false
		}
	}
	return true
}

func TestEmptyArray(t *testing.T) {
	arr := []Int{}
	result := MergeSort(arr)
	if len(result) != 0 {
		t.Error("Expected empty array")
	}
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestSingleElement(t *testing.T) {
	arr := []Int{1}
	result := MergeSort(arr)
	if len(result) != 1 || result[0] != 1 {
		t.Error("Expected [1]")
	}
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestTwoElements(t *testing.T) {
	arr := []Int{2, 1}
	result := MergeSort(arr)
	expected := []Int{1, 2}
	if len(result) != 2 || result[0] != expected[0] || result[1] != expected[1] {
		t.Error("Expected [1, 2]")
	}
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestMultipleElements(t *testing.T) {
	arr := []Int{5, 3, 8, 4, 2}
	result := MergeSort(arr)
	expected := []Int{2, 3, 4, 5, 8}
	for i, v := range result {
		if v != expected[i] {
			t.Errorf("Expected %v, got %v", expected, result)
			return
		}
	}
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestDuplicateElements(t *testing.T) {
	arr := []Int{3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5}
	result := MergeSort(arr)
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestNegativeNumbers(t *testing.T) {
	arr := []Int{-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5}
	result := MergeSort(arr)
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestLargeArray(t *testing.T) {
	arr := make([]Int, 1000)
	for i := range arr {
		arr[i] = Int(i % 1000)
	}
	result := MergeSort(arr)
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}

func TestStrings(t *testing.T) {
	arr := []String{"banana", "apple", "cherry", "date", "elderberry"}
	result := MergeSort(arr)
	if !isSorted(result) {
		t.Error("Array should be sorted")
	}
}
