# Merge Sort Implementation in C++

This directory contains a C++ implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.cpp`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Template-based implementation for type flexibility

### Key Features

- Template-based implementation supporting multiple data types
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Modern C++ features and idioms
- Exception-safe implementation
- RAII principles for resource management

## Usage

### Compiling the Code

```bash
g++ -std=c++11 -o merge_sort src/merge_sort.cpp
g++ -std=c++11 -o merge_sort_test src/merge_sort_test.cpp
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

- Empty vectors
- Single-element vectors
- Two-element vectors
- Multiple-element vectors
- Vectors with duplicate elements
- Vectors with negative numbers
- Large random vectors (1000 elements)
- Different data types (int, double, string)

## Dependencies

- C++11 or higher
- Standard C++ Library

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages C++'s RAII principles:
- Automatic memory management with `std::vector`
- Exception-safe resource handling
- No manual memory management required

### Type Safety

The template-based implementation provides:
- Type safety at compile time
- Support for any comparable data type
- No runtime type checking overhead

### Modern C++ Features

The implementation uses modern C++ features:
- Range-based for loops
- Template metaprogramming
- RAII principles
- Standard library containers and algorithms
- Exception safety
