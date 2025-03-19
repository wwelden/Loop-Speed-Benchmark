# Binary Search in Perl

This is a Perl implementation of the binary search algorithm.

## Requirements

- Perl 5.x or higher
- `strict` and `warnings` modules (included in standard Perl distribution)

## Project Structure

```
perl/
├── src/
│   └── binary_search.pl
└── README.md
```

## Running

```bash
perl src/binary_search.pl <input_file>
```

## Implementation Details

The implementation features:
- Modern Perl best practices with `strict` and `warnings`
- Array references for efficient memory usage
- Clean error handling with `die` statements
- File handling with proper resource management

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient array access using array references

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
