package main

import (
	"math/rand"
	"time"
)

func merge(arr []int, left, mid, right int) {
	n1 := mid - left + 1
	n2 := right - mid

	// Create temp arrays
	L := make([]int, n1)
	R := make([]int, n2)

	// Copy data to temp arrays
	for i := 0; i < n1; i++ {
		L[i] = arr[left+i]
	}
	for j := 0; j < n2; j++ {
		R[j] = arr[mid+1+j]
	}

	// Merge the temp arrays back into arr
	i := 0
	j := 0
	k := left

	for i < n1 && j < n2 {
		if L[i] <= R[j] {
			arr[k] = L[i]
			i++
		} else {
			arr[k] = R[j]
			j++
		}
		k++
	}

	// Copy remaining elements of L
	for i < n1 {
		arr[k] = L[i]
		i++
		k++
	}

	// Copy remaining elements of R
	for j < n2 {
		arr[k] = R[j]
		j++
		k++
	}
}

func mergeSort(arr []int, left, right int) {
	if left < right {
		mid := left + (right-left)/2
		mergeSort(arr, left, mid)
		mergeSort(arr, mid+1, right)
		merge(arr, left, mid, right)
	}
}

func generateRandomArray(size int) []int {
	arr := make([]int, size)
	for i := 0; i < size; i++ {
		arr[i] = rand.Intn(1000) + 1
	}
	return arr
}

func main() {
	rand.Seed(time.Now().UnixNano())
	size := 1000

	// Run 100 times with different random arrays
	for i := 0; i < 100; i++ {
		arr := generateRandomArray(size)
		mergeSort(arr, 0, size-1)
	}
}
