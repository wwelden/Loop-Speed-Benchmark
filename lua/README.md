# Merge Sort Implementation in Lua

This directory contains a Lua implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort algorithm is implemented with the following characteristics:
- Time complexity: O(n log n)
- Space complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Generic type support (works with numbers and strings)

## Key Features

- Pure Lua implementation with no external dependencies
- Efficient memory usage with table operations
- Built-in sorting verification
- Command-line interface for file-based sorting
- Comprehensive test suite
- Support for various data types
- Error handling for file operations
- Memory safety through garbage collection

## Usage

### Prerequisites
- Lua 5.1 or higher
- Standard Lua libraries

### Building and Running

To run the program with an input file:
```bash
lua src/merge_sort.lua <input_file>
```

To run the tests:
```bash
DEBUG=1 lua src/merge_sort.lua
```

## Implementation Structure

The implementation consists of several key functions:

1. `mergeSort`: Main sorting function that implements the merge sort algorithm
2. `merge`: Helper function that merges two sorted arrays
3. `isSorted`: Utility function to verify if an array is sorted
4. `readNumbersFromFile`: Function to read numbers from a file
5. `writeNumbersToFile`: Function to write sorted numbers to a file
6. `main`: Entry point for command-line execution
7. `runTests`: Comprehensive test suite

## Testing

The implementation includes comprehensive tests for various scenarios:
- Empty arrays
- Single-element arrays
- Two-element arrays
- Multiple elements
- Arrays with duplicate elements
- Arrays with negative numbers
- Large arrays (1000 elements)
- String arrays

## Performance Considerations

1. **Memory Usage**:
   - Uses Lua tables for dynamic arrays
   - Creates temporary arrays during merging
   - Relies on Lua's garbage collection

2. **Algorithm Efficiency**:
   - O(n log n) time complexity
   - O(n) space complexity
   - Stable sorting algorithm

3. **Lua-Specific Optimizations**:
   - Uses local variables for better performance
   - Minimizes table creation and garbage collection
   - Efficient array operations using table methods

## Memory Management

1. **Table Operations**:
   - Uses table.insert and table.remove for array operations
   - Creates temporary tables during merging
   - Relies on Lua's garbage collection for cleanup

2. **File Handling**:
   - Proper file opening and closing
   - Line-by-line reading for memory efficiency
   - Buffered writing for better performance

## Type Safety

1. **Input Validation**:
   - Type checking for numeric inputs
   - Array bounds checking
   - File existence verification

2. **Error Handling**:
   - File operation errors
   - Invalid input parameters
   - Command-line argument validation
   - Data parsing errors

## Modern Lua Features

1. **Language Features**:
   - Local variables for better performance
   - Table operations
   - String formatting
   - Environment variables

2. **Code Organization**:
   - Modular function design
   - Clear separation of concerns
   - Comprehensive documentation

## Error Handling

The implementation includes error handling for:
- File operations (open, read, write)
- Invalid input parameters
- Command-line argument validation
- Data parsing errors
- Array bounds checking

## Example Usage

1. Create an input file with numbers (one per line):
```
5
3
8
4
2
```

2. Run the program:
```bash
lua src/merge_sort.lua input.txt
```

3. Check the output file (sorted_data.txt):
```
2
3
4
5
8
```

## Notes

- The implementation is designed to be efficient and maintainable
- Uses Lua's built-in features for optimal performance
- Includes comprehensive error handling
- Provides detailed documentation
- Supports both numeric and string sorting
