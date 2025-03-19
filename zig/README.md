# Binary Search in Zig

A generic binary search implementation in Zig with comprehensive testing.

## Requirements

- Zig 0.11.0 or higher

## Project Structure

```
zig/
├── src/
│   └── binary_search.zig
├── tests/
│   └── binary_search_test.zig
└── README.md
```

## Building and Running

1. Build the project:
```bash
zig build
```

2. Run the main program:
```bash
zig run src/binary_search.zig
```

3. Run the tests:
```bash
zig test tests/binary_search_test.zig
```

## Implementation Details

- Generic implementation using comptime type parameters
- Comprehensive documentation
- Proper error handling using optional types
- Type-safe implementation
- Efficient slice operations

## Features

- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Works with any comparable type
- Returns ?usize for type safety
- Zero-copy implementation using slices

## Complexity

- Time Complexity: O(log n)
- Space Complexity: O(1)

## Test Cases

The implementation includes tests for:
- Target in middle of array
- Target at start of array
- Target at end of array
- Target not present in array
- Empty array
- Single element array
- Negative numbers
- Duplicate elements
