# Merge Sort Implementation in Kotlin

This directory contains a Kotlin implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort implementation is located in `src/MergeSort.kt`. The algorithm has the following characteristics:

- Time Complexity: O(n log n)
- Space Complexity: O(n)
- Stable sorting algorithm
- Generic type support
- In-place sorting

### Key Features

- Generic implementation using Kotlin's type system
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Built-in sorting verification
- KDoc documentation
- Null safety

## Building and Running

### Prerequisites

- Kotlin 1.5 or higher
- JDK 11 or higher

### Building

```bash
kotlinc src/MergeSort.kt -include-runtime -d merge_sort.jar
```

### Running

To sort a file:
```bash
java -jar merge_sort.jar <input_file>
```

To run tests:
```bash
DEBUG=1 java -jar merge_sort.jar
```

## Implementation Structure

The implementation consists of several key components:

1. `MergeSort` class:
   - `mergeSort`: Main sorting function
   - `merge`: Helper function for merging sorted arrays
   - `isSorted`: Function to verify sorting

2. `Tests` object:
   - `runTests`: Test suite execution
   - Comprehensive test cases

### Type System

The implementation uses Kotlin's type system features:
- Generic type parameters
- Type constraints (Comparable)
- Null safety
- Type inference

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
```kotlin
val testCases = listOf(
    "Empty array" to { sorter.mergeSort(emptyArray<Int>()).isEmpty() },
    "Single element" to { sorter.mergeSort(arrayOf(1)).contentEquals(arrayOf(1)) },
    "Two elements" to { sorter.mergeSort(arrayOf(2, 1)).contentEquals(arrayOf(1, 2)) },
    "Multiple elements" to {
        sorter.mergeSort(arrayOf(5, 3, 8, 4, 2))
            .contentEquals(arrayOf(2, 3, 4, 5, 8))
    },
    "Duplicate elements" to {
        sorter.mergeSort(arrayOf(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5))
            .contentEquals(arrayOf(1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9))
    },
    "Negative numbers" to {
        sorter.mergeSort(arrayOf(-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5))
            .contentEquals(arrayOf(-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9))
    },
    "Large array" to {
        val largeArray = Array(1000) { it }
        sorter.isSorted(sorter.mergeSort(largeArray))
    },
    "Strings" to {
        sorter.mergeSort(arrayOf("banana", "apple", "cherry"))
            .contentEquals(arrayOf("apple", "banana", "cherry"))
    }
)
```

## Performance Considerations

The implementation is optimized for Kotlin:
- Efficient array operations
- Generic type specialization
- Memory-efficient merging
- In-place array operations

### Memory Management

- Efficient array copying
- No unnecessary object creation
- Proper array size management
- Garbage collection optimization

### Kotlin Features

The implementation uses modern Kotlin features:
- Generic types
- Extension functions
- Null safety
- Type inference
- Object declarations
- Property access
- String templates

## Error Handling

The implementation includes:
- Type safety
- Null safety
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
java -jar merge_sort.jar input.txt
```

3. Check the sorted output:
```bash
cat sorted_data.txt
```

## Notes

- The implementation is designed for Kotlin/JVM
- Uses Kotlin's type system for safety
- Supports any comparable type
- Efficient memory usage
- Comprehensive documentation
