# Merge Sort Implementation in Bash

This directory contains a Bash implementation of the merge sort algorithm, along with comprehensive tests and documentation.

## Implementation Details

The merge sort algorithm is implemented with the following characteristics:
- Time complexity: O(n log n)
- Space complexity: O(n)
- Stable sorting algorithm
- Recursive implementation
- Handles various data types (integers)

## Key Features

- Pure Bash implementation with no external dependencies
- Comprehensive test coverage
- Command-line interface for file-based sorting
- Modular design with separate merge and sort functions
- Support for various data types
- Error handling for file operations
- Memory efficient implementation

## Usage

To run the program with an input file:
```bash
bash src/merge_sort.sh <input_file>
```

To run the tests:
```bash
DEBUG=1 bash src/merge_sort.sh
```

## Testing

The implementation includes comprehensive tests for various scenarios:
- Empty arrays
- Single-element arrays
- Two-element arrays
- Multiple elements
- Arrays with duplicate elements
- Arrays with negative numbers
- Large random arrays (1000 elements)

## Dependencies

- Bash 4.0 or higher
- No external dependencies required

## Performance Considerations

- The recursive approach provides a good balance between readability and performance
- Memory usage is optimized by using local variables
- Array operations are performed efficiently using Bash's built-in array features

## Memory Management

- Uses local variables to prevent global namespace pollution
- Efficient array slicing and concatenation
- Proper cleanup of temporary variables

## Type Safety

- Input validation for numeric values
- Array bounds checking
- Proper handling of empty arrays

## Modern Bash Features

- Array manipulation
- Local variables
- Command substitution
- Process substitution
- Arithmetic expansion
- Parameter expansion

## Error Handling

- File existence checks
- Input parameter validation
- Command-line argument validation
- Data parsing error handling
- IO error handling

## Example Usage

1. Create an input file with numbers (one per line):
```bash
echo -e "5\n3\n8\n4\n2" > input.txt
```

2. Run the merge sort:
```bash
bash src/merge_sort.sh input.txt
```

3. Check the sorted output:
```bash
cat sorted_data.txt
```

## Notes

- The implementation is designed to work with numeric input
- The output is written to `sorted_data.txt` in the current directory
- The script requires execute permissions (`chmod +x src/merge_sort.sh`)
