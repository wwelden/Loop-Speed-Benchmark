# Binary Search in Scala

A generic binary search implementation in Scala with comprehensive testing.

## Requirements

- Scala 2.13 or higher
- sbt (Scala Build Tool)
- ScalaTest for testing

## Project Structure

```
scala/
├── src/
│   ├── main/
│   │   └── scala/
│   │       └── BinarySearch.scala
│   └── test/
│       └── scala/
│           └── BinarySearchTest.scala
└── README.md
```

## Building and Running

1. Build the project:
```bash
sbt compile
```

2. Run the main program:
```bash
sbt run
```

3. Run the tests:
```bash
sbt test
```

## Implementation Details

- Generic implementation using type class constraints
- Comprehensive documentation
- Proper error handling
- Type-safe implementation
- Efficient array operations

## Features

- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Works with any comparable type
- Returns -1 for not found
- Handles null arrays
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
- String arrays
- Null array handling
