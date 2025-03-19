# Binary Search in Haskell

A generic binary search implementation in Haskell with comprehensive testing.

## Requirements

- GHC (Glasgow Haskell Compiler) 8.0 or higher
- Cabal (Haskell package manager)

## Project Structure

```
haskell/
├── src/
│   └── BinarySearch.hs
├── tests/
│   └── BinarySearchTest.hs
└── README.md
```

## Building and Running

1. Build the project:
```bash
ghc -o binary_search src/BinarySearch.hs
```

2. Run the main program:
```bash
./binary_search
```

3. Run the tests:
```bash
ghc -o binary_search_test tests/BinarySearchTest.hs
./binary_search_test
```

## Implementation Details

- Generic implementation using type class constraints
- Comprehensive documentation with examples
- Proper handling of edge cases
- Type-safe implementation
- Efficient list operations

## Features

- Handles empty lists
- Handles single element lists
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Works with any comparable type
- Returns Maybe Int for type safety

## Complexity

- Time Complexity: O(log n)
- Space Complexity: O(1)

## Test Cases

The implementation includes tests for:
- Target in middle of array
- Target at start of array
- Target at end of array
- Target not present in array
- Empty list
- Single element list
- Negative numbers
- Duplicate elements
