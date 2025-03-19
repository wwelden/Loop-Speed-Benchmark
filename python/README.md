# Merge Sort Implementation in Python

This directory contains a Python implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.py`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support

### Key Features

- Type-safe implementation with Python type hints
- Comprehensive test coverage using unittest
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Support for various data types (int, float, str)
- Exception handling for file operations
- Modern Python features and idioms

## Usage

### Running the Program

```bash
python src/merge_sort.py <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
python -m unittest src/merge_sort_test.py
```

## Testing

The implementation includes comprehensive tests covering:

- Empty lists
- Single-element lists
- Two-element lists
- Multiple-element lists
- Lists with duplicate elements
- Lists with negative numbers
- Large random lists (1000 elements)
- String lists
- Type safety checks

## Dependencies

- Python 3.6 or higher
- Standard library only (no external dependencies)

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages Python's memory management:
- Automatic memory management
- Efficient list operations
- No manual memory management required

### Type Safety

The implementation uses Python type hints:
- Generic type support with TypeVar
- Parameter type annotations
- Return type annotations
- List type hints

### Modern Python Features

The implementation uses modern Python features:
- Type hints
- Context managers (with statements)
- List comprehensions
- Generator expressions
- Exception handling
- File handling with context managers
