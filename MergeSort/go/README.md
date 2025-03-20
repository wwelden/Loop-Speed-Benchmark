# Merge Sort Implementation in Go

This directory contains a Go implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.go`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support

### Key Features

- Type-safe implementation with Go generics
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Support for various data types (numbers, strings)
- Error handling for file operations
- Efficient memory management with slices

## Usage

### Running the Program

```bash
go run src/merge_sort.go <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
go test ./src/...
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

- Go 1.18 or higher (for generics support)
- Standard library only (no external dependencies)

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages Go's memory management:
- Efficient slice operations
- Automatic memory management
- No manual memory management required
- Zero-copy slice operations where possible

### Type Safety

The implementation uses Go's type system:
- Generic type support
- Interface-based type constraints
- Type assertions
- Custom type implementations

### Modern Go Features

The implementation uses modern Go features:
- Generics
- Type constraints
- Slice operations
- Error handling
- Defer statements
- File handling with bufio
- Command-line argument handling

### Error Handling

The implementation includes comprehensive error handling for:
- File operations (reading, writing)
- Invalid input parameters
- Command-line argument validation
- Data parsing errors
- Type conversion errors
