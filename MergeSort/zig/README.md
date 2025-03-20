# Algorithms in Zig

This directory contains implementations of various algorithms in Zig.

## Requirements

- Zig (version 0.11.0 or higher recommended)

## Project Structure

```
zig/
├── src/
│   ├── binary_search.zig
│   └── merge_sort.zig
└── README.md
```

## Running

### Binary Search
```bash
zig build-exe -o binary_search src/binary_search.zig && ./binary_search <input_file>
```

### Merge Sort
```bash
zig build-exe -o merge_sort src/merge_sort.zig && ./merge_sort <input_file>
```

## Implementation Details

### Binary Search
The binary search implementation features:
- Pure Zig implementation using standard library
- Strong type system and compile-time checks
- Efficient array access
- Proper error handling with try/catch

### Merge Sort
The merge sort implementation features:
- Pure Zig implementation using standard library
- Memory safety with explicit allocator
- Efficient array slicing
- Proper resource cleanup with defer
- In-place merging with temporary array

## Features

### Binary Search
- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient array access using Zig's slice syntax

### Merge Sort
- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Stable sorting algorithm
- Memory-efficient implementation with explicit allocation
- Proper resource cleanup

## Time Complexity

### Binary Search
- O(log n) - Binary search divides the search space in half with each iteration

### Merge Sort
- O(n log n) - Merge sort divides the array in half recursively and merges sorted halves

## Space Complexity

### Binary Search
- O(1) - Only uses a constant amount of extra space regardless of input size

### Merge Sort
- O(n) - Requires additional space to store the merged arrays during the merge step

## Memory Management

Zig's implementation features explicit memory management:
- Uses a general purpose allocator for dynamic memory
- Properly frees allocated memory with defer
- Handles file resources with defer
- Uses buffered I/O for efficient file operations

## Test Cases

Both implementations include test cases for:
- Empty arrays
- Single element arrays
- Multiple element arrays
- Negative numbers
- Duplicate elements
- Large arrays (1 million elements)
