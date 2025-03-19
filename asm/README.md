# Binary Search in x86_64 Assembly

This is an x86_64 Assembly implementation of the binary search algorithm, specifically for macOS.

## Requirements

- NASM (Netwide Assembler)
- macOS operating system (for the specific calling conventions and system calls)
- C standard library (for file I/O and printf)

## Project Structure

```
asm/
├── src/
│   └── binary_search.asm
└── README.md
```

## Compilation

```bash
nasm -f macho64 src/binary_search.asm && ld -o binary_search src/binary_search.o
```

## Running

```bash
./binary_search <input_file>
```

## Implementation Details

The implementation features:
- Pure x86_64 assembly code
- System V AMD64 ABI calling convention
- Efficient register usage
- Direct memory access for array operations
- Integration with C standard library for I/O

## Features

- Handles empty arrays
- Handles single element arrays
- Supports negative numbers
- Returns first occurrence for duplicate elements
- Efficient memory access using direct addressing

## Time Complexity

- O(log n) - Binary search divides the search space in half with each iteration

## Space Complexity

- O(1) - Only uses a constant amount of extra space regardless of input size

## Technical Details

- Uses x86_64 registers efficiently (rax, rdi, rsi, rdx, r8, r9)
- Implements proper stack frame management
- Follows macOS system calling conventions
- Uses C standard library for file operations and output formatting

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

## Notes

This implementation is specific to macOS x86_64 systems. For other operating systems or architectures, modifications to the system calls and calling conventions would be necessary.
