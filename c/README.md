# Binary Search in C

This directory contains a C implementation of the binary search algorithm.

## Requirements
- GCC or Clang compiler
- Make (optional, for building)

## Project Structure
```
c/
├── src/
│   └── binary_search.c
├── tests/
│   └── binary_search_test.c
└── README.md
```

## Compilation
```bash
# Compile main implementation
gcc -o binary_search src/binary_search.c

# Compile tests
gcc -o binary_search_test tests/binary_search_test.c
```

## Running the Code

### Running the main implementation
```bash
./binary_search
```

### Running the tests
```bash
./binary_search_test
```

## Implementation Details
The implementation includes:
- Comprehensive documentation
- Null pointer checks
- Array length validation
- Size_t for array indices to handle large arrays
- Const correctness
- Proper error handling (returns -1 for not found)
- Safe array access

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Handles NULL input
- Efficient memory usage
- Type-safe implementation with size_t
- Safe array bounds checking

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
- NULL input handling
