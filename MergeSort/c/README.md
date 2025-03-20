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

# Merge Sort Implementation in C

This directory contains a C implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.c`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation

### Key Features

- Memory-efficient implementation with proper allocation/deallocation
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Dynamic array resizing for file input
- Error handling for file operations and memory allocation

## Usage

### Compiling the Code

```bash
gcc -o merge_sort src/merge_sort.c
gcc -o merge_sort_test src/merge_sort_test.c
```

### Running the Program

```bash
./merge_sort <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
./merge_sort_test
```

## Testing

The implementation includes comprehensive tests covering:

- Empty arrays
- Single-element arrays
- Two-element arrays
- Multiple-element arrays
- Arrays with duplicate elements
- Arrays with negative numbers
- Large random arrays (1000 elements)

## Dependencies

- GCC or compatible C compiler
- Standard C library

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

The implementation uses dynamic memory allocation for temporary arrays during the merge process. For memory-critical applications, an in-place merge sort implementation might be preferred.

### Memory Management

The implementation includes proper memory management:
- Dynamic allocation for input array with automatic resizing
- Temporary arrays for merge operations
- Proper deallocation of all allocated memory
- Error handling for allocation failures

### Error Handling

The implementation includes comprehensive error handling for:
- File operations (opening, reading, writing)
- Memory allocation failures
- Invalid input parameters
- Command-line argument validation
