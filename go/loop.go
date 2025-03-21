package main

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"time"
)

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

	rand.Seed(time.Now().UnixNano()) // Seed the random number generator
	r := rand.Intn(10000)            // Get a random number 0 <= r < 10k
	a := make([]int, 10000)          // Array of 10k elements initialized to 0

	for i := 0; i < 10000; i++ { // 10k outer loop iterations
		sum := 0                      // Keep running sum in a local variable
		for j := 0; j < 100000; j++ { // 100k inner loop iterations
			sum += j % input // Accumulate in local variable
		}
		a[i] = sum + r // Single array write per outer iteration
	}

	fmt.Println(a[r]) // Print out a single element from the array
}
