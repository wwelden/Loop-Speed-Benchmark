# Binary Search in R

This is an R implementation of the binary search algorithm.

## Requirements

- R (version 4.0.0 or higher recommended)
- Rscript (included with R installation)

## Project Structure

```
r/
├── src/
│   └── binary_search.R
└── README.md
```

## Running

```bash
Rscript src/binary_search.R <input_file>
```

## Implementation Details

The implementation features:
- Pure R implementation using base R functions
- Efficient vector operations
- Clean error handling with `stop()` function
- Proper file I/O using `readLines()`

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient array access using R's vector operations

## Time Complexity

- O(log n) - Binary search divides the search space in half with each iteration

## Space Complexity

- O(1) - Only uses a constant amount of extra space regardless of input size

## Test Cases

The implementation includes test cases for:
- Target in middle of array
- Target at start of array
- Target at end of array
- Target not in array
- Empty array
- Single element array
- Negative numbers
- Duplicate elements
