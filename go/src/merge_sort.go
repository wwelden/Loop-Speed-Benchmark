package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// Comparable is an interface for types that can be compared
type Comparable interface {
	Less(other Comparable) bool
}

// Int implements Comparable for integers
type Int int

func (i Int) Less(other Comparable) bool {
	return i < other.(Int)
}

// String implements Comparable for strings
type String string

func (s String) Less(other Comparable) bool {
	return s < other.(String)
}

// MergeSort sorts a slice of Comparable elements using merge sort algorithm
// Time complexity: O(n log n)
// Space complexity: O(n)
func MergeSort[T Comparable](arr []T) []T {
	if len(arr) <= 1 {
		return arr
	}

	// Split array into two halves
	mid := len(arr) / 2
	left := arr[:mid]
	right := arr[mid:]

	// Recursively sort both halves
	return merge(MergeSort(left), MergeSort(right))
}

// merge combines two sorted slices into a single sorted slice
func merge[T Comparable](left, right []T) []T {
	result := make([]T, 0, len(left)+len(right))
	i, j := 0, 0

	// Compare elements from both slices and merge them
	for i < len(left) && j < len(right) {
		if left[i].Less(right[j]) {
			result = append(result, left[i])
			i++
		} else {
			result = append(result, right[j])
			j++
		}
	}

	// Copy remaining elements from left slice
	result = append(result, left[i:]...)

	// Copy remaining elements from right slice
	result = append(result, right[j:]...)

	return result
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Please provide a file path as an argument")
		os.Exit(1)
	}

	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var numbers []Int

	// Read numbers from file
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" {
			continue
		}
		num, err := strconv.Atoi(line)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error parsing number: %v\n", err)
			os.Exit(1)
		}
		numbers = append(numbers, Int(num))
	}

	// Sort the array
	sortedNumbers := MergeSort(numbers)

	// Write sorted numbers back to file
	outputFile, err := os.Create("sorted_data.txt")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating output file: %v\n", err)
		os.Exit(1)
	}
	defer outputFile.Close()

	writer := bufio.NewWriter(outputFile)
	for _, num := range sortedNumbers {
		fmt.Fprintln(writer, num)
	}
	writer.Flush()
}
