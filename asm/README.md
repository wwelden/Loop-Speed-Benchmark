# Merge Sort in x86_64 Assembly

This is an x86_64 Assembly implementation of the merge sort algorithm, specifically for macOS.

## Requirements

- NASM (Netwide Assembler)
- macOS operating system (for the specific calling conventions and system calls)
- C standard library (for file I/O and printf)

## Project Structure

```
assembly/
├── src/
│   └── merge_sort.asm
└── README.md
```

## Compilation

```bash
nasm -f macho64 src/merge_sort.asm && ld -o merge_sort src/merge_sort.o
```

## Running

```bash
./merge_sort <input_file>
```

## Implementation Details

The implementation features:
- Pure x86_64 assembly code
- System V AMD64 ABI calling convention
- Efficient register usage
- Direct memory access for array operations
- Integration with C standard library for I/O
- Recursive merge sort implementation
- Stable sorting algorithm

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Maintains stability for duplicate elements
- Efficient memory access using direct addressing
- Built-in sorting verification
- Comprehensive test suite

## Time Complexity

- O(n log n) - Merge sort divides the array in half recursively and merges sorted halves

## Space Complexity

- O(n) - Uses additional space for temporary array during merging

## Technical Details

- Uses x86_64 registers efficiently (rax, rdi, rsi, rdx, r8, r9)
- Implements proper stack frame management
- Follows macOS system calling conventions
- Uses C standard library for file operations and output formatting
- Efficient array copying and merging operations
- Proper register preservation during recursion
- Optimized memory access patterns

## Memory Management

- Uses stack for recursion
- Efficient register usage
- Temporary array for merging
- Proper stack frame management
- Memory alignment considerations
- Cache-friendly array access

## Test Cases

The implementation includes test cases for:
- Empty arrays
- Single element arrays
- Two element arrays
- Multiple elements
- Arrays with duplicate elements
- Arrays with negative numbers
- Large random arrays
- String arrays

## Example Test Array

```
5, 3, 8, 4, 2, 1, 9, 7, 6, 0
```

## Notes

This implementation is specific to macOS x86_64 systems. For other operating systems or architectures, modifications to the system calls and calling conventions would be necessary.

Key considerations:
- Stack size limits recursion depth
- Memory alignment is important for performance
- Register usage follows x86_64 calling conventions
- Maximum array size is limited by available memory
- Proper error handling for file operations
- Efficient array operations using direct addressing
