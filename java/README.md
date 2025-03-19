# Binary Search in Java

This directory contains a Java implementation of the binary search algorithm.

## Requirements
- Java 8 or higher
- JUnit 4 for testing

## Project Structure
```
java/
├── src/
│   └── BinarySearch.java
├── tests/
│   └── BinarySearchTest.java
└── README.md
```

## Compilation
```bash
javac -cp .:junit-4.13.jar:hamcrest-core-1.3.jar src/BinarySearch.java tests/BinarySearchTest.java
```

## Running the Code

### Running the main implementation
```bash
java -cp src BinarySearch
```

### Running the tests
```bash
java -cp .:junit-4.13.jar:hamcrest-core-1.3.jar org.junit.runner.JUnitCore tests.BinarySearchTest
```

## Implementation Details
The implementation includes:
- Comprehensive JavaDoc documentation
- Proper exception handling
- Null checks
- Example usage in documentation
- JUnit test cases
- Static utility method

## Features
- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Throws IllegalArgumentException for null input
- Efficient memory usage
- Type-safe implementation

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
- Null input handling with exception
