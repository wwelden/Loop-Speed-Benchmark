# Binary Search in JavaScript

This directory contains a JavaScript implementation of the binary search algorithm.

## Requirements
- Node.js 14 or higher
- npm (Node Package Manager)

## Installation
```bash
npm install
```

## Running the Code

### Running the main implementation
```bash
node src/binary_search.js
```

### Running the tests
```bash
npm test
```

## Implementation Details
The implementation includes:
- Comprehensive JSDoc documentation
- Type checking with JSDoc annotations
- Example usage in documentation
- Proper error handling (returns -1 for not found)
- Null/undefined checking

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Handles null/undefined input
- Efficient memory usage

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
- Null/undefined input handling
