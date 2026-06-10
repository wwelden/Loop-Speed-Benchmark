package main

import (
	"fmt"
	"math/rand"
	"os"
	"runtime"
	"strconv"
	"sync"
)

// Performs the same work as go/loop.go (10k x 100k modulo additions) with two
// implementation-level optimizations: the outer loop is split across all CPU
// cores, and each element's sum accumulates in a local variable instead of
// repeated array reads/writes. The algorithm itself is unchanged.
func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Please provide a number as command line argument")
		os.Exit(1)
	}

	input, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Fprintln(os.Stderr, "Please provide a valid integer")
		os.Exit(1)
	}

	if input == 0 {
		fmt.Fprintln(os.Stderr, "Please provide a non-zero integer")
		os.Exit(1)
	}

	r := rand.Intn(10000)   // Get a random number 0 <= r < 10k
	a := make([]int, 10000) // Array of 10k elements initialized to 0

	workers := runtime.NumCPU()
	chunk := (10000 + workers - 1) / workers

	var wg sync.WaitGroup
	for w := 0; w < workers; w++ {
		start := w * chunk
		end := min(start+chunk, 10000)
		if start >= end {
			break
		}
		wg.Add(1)
		go func(start, end int) {
			defer wg.Done()
			for i := start; i < end; i++ { // this worker's share of the 10k outer iterations
				sum := 0
				for j := 0; j < 100000; j++ { // 100k inner loop iterations, per outer loop iteration
					sum += j % input // Simple sum
				}
				a[i] = sum + r // Add a random value to each element in array
			}
		}(start, end)
	}
	wg.Wait()

	fmt.Println(a[r]) // Print out a single element from the array
}
