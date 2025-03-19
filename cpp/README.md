# Binary Search in C++

This directory contains a C++ implementation of the binary search algorithm using templates.

## Requirements
- C++11 or higher
- A C++ compiler (GCC, Clang, or MSVC)

## Project Structure
```
cpp/
├── src/
│   └── binary_search.cpp
├── tests/
│   └── binary_search_test.cpp
└── README.md
```

## Compilation
```bash
# Compile main implementation
g++ -std=c++11 -o binary_search src/binary_search.cpp

# Compile tests
g++ -std=c++11 -o binary_search_test tests/binary_search_test.cpp
```

## Running the Code

### Running the main implementation
```bash
./binary_search
```

### Running the tests
```bash
./binary_search_test
```

## Implementation Details
The implementation includes:
- Template-based implementation for type flexibility
- Comprehensive documentation
- STL vector usage for dynamic arrays
- Proper error handling (returns -1 for not found)
- Type-safe implementation
- Support for any comparable type

## Features
- Generic implementation using templates
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Works with any comparable type (integers, strings, etc.)
- Efficient memory usage with STL containers
- Type-safe implementation
- Safe array bounds checking

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
- String arrays
- Different data types
