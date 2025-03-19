# Binary Search in C#

A binary search implementation in C# with comprehensive testing.

## Requirements

- .NET 6.0 or higher
- xUnit for testing

## Project Structure

```
csharp/
├── src/
│   └── BinarySearch.cs
├── tests/
│   └── BinarySearchTests.cs
└── README.md
```

## Building and Running

1. Build the project:
```bash
dotnet build
```

2. Run the main program:
```bash
dotnet run --project src
```

3. Run the tests:
```bash
dotnet test
```

## Implementation Details

- Comprehensive XML documentation
- Proper exception handling
- Null checks
- Type-safe implementation
- Efficient array operations

## Features

- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Throws ArgumentNullException for null input
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
- Null input handling with exception
