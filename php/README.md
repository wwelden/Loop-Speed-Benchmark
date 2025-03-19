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

# Merge Sort Implementation in PHP

This directory contains a PHP implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.php`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation

### Key Features

- Type-safe implementation with PHP 7+ type hints
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Modern PHP features and idioms
- Exception handling for file operations
- Support for both numeric and string sorting

## Usage

### Running the Program

```bash
php src/merge_sort.php <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
php src/merge_sort_test.php
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
- String arrays

## Dependencies

- PHP 7.0 or higher
- Standard PHP Library

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages PHP's memory management:
- Automatic memory management
- Efficient array operations
- No manual memory management required

### Type Safety

The implementation uses PHP 7+ type hints:
- Parameter type declarations
- Return type declarations
- Array type hints
- Strict type checking

### Modern PHP Features

The implementation uses modern PHP features:
- Type declarations
- Return type declarations
- Array destructuring
- Arrow functions
- Null coalescing operator
- Exception handling
