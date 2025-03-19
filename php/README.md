# Binary Search in PHP

This is an implementation of the binary search algorithm in PHP. The implementation includes comprehensive documentation and test cases.

## Requirements

- PHP 7.4 or higher
- PHPUnit for running tests (optional)

## Project Structure

```
php/
├── src/
│   └── binary_search.php
├── tests/
│   └── binary_search_test.php
└── README.md
```

## Running the Code

### Running the Main Implementation

```bash
php src/binary_search.php
```

### Running the Tests

```bash
phpunit tests/binary_search_test.php
```

## Implementation Details

The implementation includes:
- Comprehensive documentation
- Type hints and return type declarations
- Proper error handling
- Support for both integer and string arrays
- Efficient array operations

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Handles duplicate elements (returns first occurrence)
- Supports string arrays
- Proper error handling for null input

## Complexity Analysis

- Time Complexity: O(log n)
- Space Complexity: O(1)

## Test Cases

The implementation includes test cases for:
- Target in the middle of the array
- Target at the start of the array
- Target at the end of the array
- Target not present in the array
- Empty array
- Single element array
- Negative numbers
- Duplicate elements
- String arrays
- Null input handling
