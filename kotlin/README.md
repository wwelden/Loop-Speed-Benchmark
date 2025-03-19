# Binary Search in Kotlin

This is a Kotlin implementation of the binary search algorithm.

## Requirements

- Kotlin compiler (`kotlinc`)
- Java Runtime Environment (JRE)

## Project Structure

```
kotlin/
├── src/
│   └── binary_search.kt
└── README.md
```

## Compilation

```bash
kotlinc src/binary_search.kt -include-runtime -d binary_search.jar
```

## Running

```bash
java -jar binary_search.jar <input_file>
```

## Implementation Details

The implementation features:
- Null safety through Kotlin's type system
- Functional programming features with immutable lists
- Clean and concise syntax using Kotlin's `when` expression
- Proper error handling for file operations

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient array access using Kotlin's List interface

## Time Complexity

- O(log n) - Binary search divides the search space in half with each iteration

## Space Complexity

- O(1) - Only uses a constant amount of extra space regardless of input size

## Test Cases

The implementation includes test cases for:
- Target in middle of array
- Target at start of array
- Target at end of array
- Target not in array
- Empty array
- Single element array
- Negative numbers
- Duplicate elements
