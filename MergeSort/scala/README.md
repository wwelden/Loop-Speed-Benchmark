# Merge Sort Implementation in Scala

This directory contains a Scala implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/MergeSort.scala`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Generic type support
- Type-safe implementation

### Key Features

- Generic implementation using Scala's type system
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Built-in sorting verification
- ScalaDoc documentation
- Type safety through type classes

## Building and Running

### Prerequisites

- Scala 2.13 or higher
- SBT (Scala Build Tool)

### Building

```bash
sbt compile
```

### Running

To sort a file:
```bash
sbt "run <input_file>"
```

To run tests:
```bash
DEBUG=1 sbt "run"
```

## Implementation Structure

The implementation consists of several key objects:

1. `MergeSort` object:
   - `mergeSort`: Main sorting function
   - `merge`: Helper function for merging sorted arrays
   - `isSorted`: Function to verify sorting

2. `Main` object:
   - Command-line interface
   - File I/O operations

3. `Tests` object:
   - Test suite execution
   - Comprehensive test cases

### Type System

The implementation uses Scala's type system features:
- Generic type parameters
- Type classes (Ordering)
- Type inference
- Implicit parameters

## Testing

The implementation includes comprehensive tests for:
- Empty arrays
- Single-element arrays
- Two-element arrays
- Multiple elements
- Duplicate elements
- Negative numbers
- Large arrays
- String arrays

### Test Cases

The test suite covers various scenarios:
```scala
val testCases = List(
  "Empty array" -> (MergeSort.mergeSort(Array.empty[Int]).isEmpty),
  "Single element" -> (MergeSort.mergeSort(Array(1)).sameElements(Array(1))),
  "Two elements" -> (MergeSort.mergeSort(Array(2, 1)).sameElements(Array(1, 2))),
  "Multiple elements" -> (
    MergeSort.mergeSort(Array(5, 3, 8, 4, 2))
      .sameElements(Array(2, 3, 4, 5, 8))
  ),
  "Duplicate elements" -> (
    MergeSort.mergeSort(Array(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5))
      .sameElements(Array(1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9))
  ),
  "Negative numbers" -> (
    MergeSort.mergeSort(Array(-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5))
      .sameElements(Array(-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9))
  ),
  "Large array" -> {
    val largeArray = (1 to 1000).toArray
    MergeSort.isSorted(MergeSort.mergeSort(largeArray))
  },
  "Strings" -> (
    MergeSort.mergeSort(Array("banana", "apple", "cherry"))
      .sameElements(Array("apple", "banana", "cherry"))
  )
)
```

## Performance Considerations

The implementation is optimized for Scala:
- Efficient array operations
- Generic type specialization
- Memory-efficient merging
- Type class resolution

### Memory Management

- Efficient array copying
- No unnecessary object creation
- Proper array size management
- Garbage collection optimization

### Scala Features

The implementation uses modern Scala features:
- Type classes
- Generic types
- Pattern matching
- Implicit parameters
- Object declarations
- String interpolation
- Collection operations

## Error Handling

The implementation includes:
- Type safety
- Array bounds checking
- Input validation
- File handling
- Test result verification

## Example Usage

1. Create an input file with numbers (one per line):
```bash
echo -e "5\n3\n8\n4\n2" > input.txt
```

2. Run the merge sort:
```bash
sbt "run input.txt"
```

3. Check the sorted output:
```bash
cat sorted_data.txt
```

## Notes

- The implementation is designed for Scala/JVM
- Uses Scala's type system for safety
- Supports any type with an Ordering instance
- Efficient memory usage
- Comprehensive documentation
