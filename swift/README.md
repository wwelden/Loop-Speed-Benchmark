# Merge Sort Implementation in Swift

This directory contains a Swift implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.swift`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support

### Key Features

- Type-safe implementation with Swift generics
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Support for various data types (numbers, strings)
- Error handling for file operations
- Memory safety guarantees

## Usage

### Running the Program

```bash
swift src/merge_sort.swift <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
swift -D DEBUG src/merge_sort.swift
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

- Swift 5.0 or higher
- Standard library only (no external dependencies)

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages Swift's memory management:
- Automatic reference counting
- Efficient array operations
- No manual memory management required
- Value semantics

### Type Safety

The implementation uses Swift's type system:
- Generic type support
- Protocol constraints
- Type inference
- Value types

### Modern Swift Features

The implementation uses modern Swift features:
- Generics
- Protocols
- Extensions
- Optionals
- Error handling with do-catch
- File handling
- Command-line argument handling
- String interpolation

### Error Handling

The implementation includes comprehensive error handling for:
- File operations (reading, writing)
- Invalid input parameters
- Command-line argument validation
- Data parsing errors
- IO errors
