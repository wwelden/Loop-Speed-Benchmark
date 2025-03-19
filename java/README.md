# Merge Sort Implementation in Java

This directory contains a Java implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/MergeSort.java`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Recursive implementation

### Key Features

- Object-oriented implementation
- Comprehensive test coverage using JUnit
- Command-line interface for file-based sorting
- Modular design with separate merge function
- Efficient memory usage with array operations

## Usage

### Compiling the Code

```bash
javac src/*.java
```

### Running the Program

```bash
java -cp src MergeSort <input_file>
```

The sorted output will be written to `sorted_data.txt`.

### Running Tests

```bash
javac -cp .:junit-4.13.jar:hamcrest-core-1.3.jar src/*.java
java -cp .:junit-4.13.jar:hamcrest-core-1.3.jar org.junit.runner.JUnitCore MergeSortTest
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

## Dependencies

- Java Development Kit (JDK) 8 or higher
- JUnit 4 for testing

## Performance Considerations

The implementation uses a recursive approach which is clean and easy to understand. For very large datasets, an iterative approach might be more memory-efficient, but for most practical purposes, this implementation provides a good balance of readability and performance.

The implementation uses `Arrays.copyOfRange()` for array splitting, which creates new arrays. For memory-critical applications, an in-place merge sort implementation might be preferred.
