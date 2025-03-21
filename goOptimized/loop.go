package main

import (
	"fmt"
	"math/rand"
	"os"
	"runtime"
	"strconv"
	"sync"
	"sync/atomic"
	"time"
)

// Pre-calculate modulo sums for better performance
func calculateModSums(input int) []int64 {
	modSums := make([]int64, input)
	for i := 0; i < input; i++ {
		sum := int64(0)
		// Use a more efficient modulo calculation
		for j := 0; j < 100000; j++ {
			sum += int64(j % input)
		}
		modSums[i] = sum
	}
	return modSums
}

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

	// Set GOMAXPROCS to use all available CPU cores
	runtime.GOMAXPROCS(runtime.NumCPU())

	// Initialize random number generator
	rand.Seed(time.Now().UnixNano())
	r := rand.Intn(10000)

	// Pre-calculate modulo sums
	modSums := calculateModSums(input)

	// Use a more efficient array allocation
	a := make([]int64, 10000)

	// Use work stealing for better load balancing
	numWorkers := runtime.NumCPU()
	chunkSize := 10000 / numWorkers
	if chunkSize == 0 {
		chunkSize = 1
	}

	var wg sync.WaitGroup
	wg.Add(numWorkers)

	// Create a work queue
	type work struct {
		start, end int
	}
	workChan := make(chan work, numWorkers)

	// Start workers
	for i := 0; i < numWorkers; i++ {
		go func() {
			defer wg.Done()
			for w := range workChan {
				for j := w.start; j < w.end; j++ {
					// Use atomic operations for thread safety
					atomic.AddInt64(&a[j], modSums[j%input]+int64(r))
				}
			}
		}()
	}

	// Distribute work
	for i := 0; i < numWorkers; i++ {
		start := i * chunkSize
		end := start + chunkSize
		if i == numWorkers-1 {
			end = 10000
		}
		workChan <- work{start: start, end: end}
	}
	close(workChan)

	wg.Wait()
	fmt.Println(a[r])
}
