# Binary Search in Go

This directory contains a Go implementation of the binary search algorithm.

## Requirements
- Go 1.16 or higher

## Running the Code

### Running the main implementation
```bash
go run src/binary_search.go
```

### Running the tests
```bash
go test ./tests -v
```

## Implementation Details
The implementation includes:
- Comprehensive documentation
- Idiomatic Go code style
- Table-driven tests
- Proper error handling (returns -1 for not found)
- Zero-copy implementation using slices

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Efficient memory usage with slices

## Time Complexity
O(log n)

## Space Complexity
O(1)

## Test Cases
The implementation includes test cases for:
- Target value present in the middle of the array
- Target value at the start of the array
- Target value at the end of the array
- Target value not present in the array
- Empty array
- Single element array
- Array with negative numbers
- Array with duplicate elements
