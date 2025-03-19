# Binary Search in Rust

This directory contains a Rust implementation of the binary search algorithm.

## Requirements
- Rust 1.30.0 or higher
- Cargo (Rust's package manager)

## Running the Code

### Running the main implementation
```bash
cargo run
```

### Running the tests
```bash
cargo test
```

## Implementation Details
The implementation includes:
- Comprehensive documentation with examples
- Type safety with Rust's type system
- Proper error handling using `Option<usize>`
- Inline tests using Rust's testing framework
- Safe array access with bounds checking

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Zero-copy implementation using slices
- Idiomatic Rust code with proper error handling

## Time Complexity
O(log n)

## Space Complexity
O(1)

## Test Cases
The implementation includes test cases for:
- Target value present in the middle of the array
- Target value at the start of the array
- Target value at the end of the array
- Target value not present in the array
- Empty array
- Single element array
- Array with negative numbers
- Array with duplicate elements
