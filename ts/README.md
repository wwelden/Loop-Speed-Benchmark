# Binary Search in TypeScript

This directory contains a TypeScript implementation of the binary search algorithm.

## Requirements
- Node.js 14 or higher
- npm (Node Package Manager)
- TypeScript 4.0 or higher

## Installation
```bash
npm install
npm install --save-dev @types/jest
```

## Running the Code

### Compiling TypeScript
```bash
npm run build
```

### Running the main implementation
```bash
npm start
```

### Running the tests
```bash
npm test
```

## Implementation Details
The implementation includes:
- Full TypeScript type safety
- Comprehensive JSDoc documentation
- Type checking with TypeScript annotations
- Example usage in documentation
- Proper error handling (returns -1 for not found)
- Null/undefined checking with type assertions

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Handles null/undefined input with type safety
- Efficient memory usage
- Type-safe array operations

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
- Null/undefined input handling with type safety
