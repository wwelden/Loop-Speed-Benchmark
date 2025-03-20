# Merge Sort Implementation in Rust

This directory contains a Rust implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/main.rs`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support

### Key Features

- Type-safe implementation with Rust generics
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Support for various data types (numbers, strings)
- Error handling for file operations
- Memory safety guarantees

## Usage

### Building the Project

```bash
cargo build
```

### Running the Program

```bash
cargo run -- <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
cargo test
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

- Rust 1.56 or higher
- Standard library only (no external dependencies)

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

### Memory Management

The implementation leverages Rust's memory management:
- Zero-cost abstractions
- Efficient vector operations
- No manual memory management required
- Ownership and borrowing system

### Type Safety

The implementation uses Rust's type system:
- Generic type support
- Trait bounds
- Type inference
- Zero-cost abstractions

### Modern Rust Features

The implementation uses modern Rust features:
- Generics
- Traits
- Slices
- Iterators
- Result type for error handling
- File handling with BufReader
- Command-line argument handling

### Error Handling

The implementation includes comprehensive error handling for:
- File operations (reading, writing)
- Invalid input parameters
- Command-line argument validation
- Data parsing errors
- IO errors
