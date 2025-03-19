# Binary Search in Lua

A binary search implementation in Lua with comprehensive testing.

## Requirements

- Lua 5.1 or higher

## Project Structure

```
lua/
├── src/
│   └── binary_search.lua
├── tests/
│   └── binary_search_test.lua
└── README.md
```

## Building and Running

1. Run the main program:
```bash
lua src/binary_search.lua
```

2. Run the tests:
```bash
lua tests/binary_search_test.lua
```

## Implementation Details

- Comprehensive documentation using LuaDoc comments
- Proper error handling
- Type checking
- Efficient table operations
- Zero-based array indexing

## Features

- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Returns nil for not found
- Efficient memory usage
- Type-safe implementation

## Complexity

- Time Complexity: O(log n)
- Space Complexity: O(1)

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
