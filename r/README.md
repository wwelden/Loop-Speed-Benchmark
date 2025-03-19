# Algorithms in R

This directory contains implementations of various algorithms in R.

## Requirements

- R (version 4.0.0 or higher recommended)
- Rscript (included with R installation)

## Project Structure

```
r/
├── src/
│   ├── binary_search.R
│   └── merge_sort.R
└── README.md
```

## Running

### Binary Search
```bash
Rscript src/binary_search.R <input_file>
```

### Merge Sort
```bash
Rscript src/merge_sort.R <input_file>
```

## Implementation Details

### Binary Search
The binary search implementation features:
- Pure R implementation using base R functions
- Efficient vector operations
- Clean error handling with `stop()` function
- Proper file I/O using `readLines()`

### Merge Sort
The merge sort implementation features:
- Pure R implementation using base R functions
- Efficient vector operations and array splitting
- Clean error handling with `stop()` function
- Proper file I/O using `readLines()` and `writeLines()`
- In-place merging for better memory efficiency

## Features

### Binary Search
- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient array access using R's vector operations

### Merge Sort
- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Stable sorting algorithm
- Efficient array splitting and merging
- Memory-efficient implementation

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

## Test Cases

Both implementations include test cases for:
- Empty arrays
- Single element arrays
- Multiple element arrays
- Negative numbers
- Duplicate elements
- Large arrays (1 million elements)
