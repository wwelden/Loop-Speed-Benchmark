# Merge Sort Implementation in TypeScript

This directory contains a TypeScript implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/merge_sort.ts`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation

### Key Features

- Type-safe implementation using TypeScript
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge function

## Usage

### Running Tests

```bash
npm test
```

### Sorting a File

```bash
npm start -- <input_file>
```

The sorted output will be written to `sorted_data.txt`.

## Testing

The implementation includes comprehensive tests covering:

- Empty arrays
- Single-element arrays
- Two-element arrays
- Multiple-element arrays
- Arrays with duplicate elements
- Arrays with negative numbers
- Large random arrays (1000 elements)

## Dependencies

- TypeScript
- Jest (for testing)
- ts-node (for running TypeScript directly)

## Installation

```bash
npm install
```

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.
