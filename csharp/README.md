# Merge Sort Implementation in C#

This directory contains a C# implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/MergeSort.cs`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support

### Key Features

- Type-safe implementation with C# generics
- Comprehensive test coverage using MSTest
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Support for various data types (numbers, strings)
- Error handling for file operations
- LINQ integration for efficient data processing

## Usage

### Building the Project

```bash
dotnet build
```

### Running the Program

```bash
dotnet run -- <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
dotnet test
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
- Null array handling

## Dependencies

- .NET 6.0 or higher
- MSTest for testing
- Standard library only (no external dependencies)

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages C#'s memory management:
- Automatic memory management
- Efficient array operations
- No manual memory management required
- LINQ optimizations

### Type Safety

The implementation uses C#'s type system:
- Generic type support
- Interface constraints
- Type inference
- Null safety

### Modern C# Features

The implementation uses modern C# features:
- Generics
- LINQ
- Null-conditional operators
- String interpolation
- Exception handling
- File handling
- Command-line argument handling

### Error Handling

The implementation includes comprehensive error handling for:
- File operations (reading, writing)
- Invalid input parameters
- Command-line argument validation
- Data parsing errors
- Null reference handling
