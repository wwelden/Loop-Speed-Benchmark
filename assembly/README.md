# Binary Search in x86_64 Assembly

A binary search implementation in x86_64 assembly language using NASM syntax.

## Requirements

- NASM (Netwide Assembler)
- GCC (for linking)
- Linux x86_64 system (for System V ABI)

## Project Structure

```
assembly/
├── src/
│   └── binary_search.asm
└── README.md
```

## Building and Running

1. Assemble the program:
```bash
nasm -f elf64 src/binary_search.asm -o binary_search.o
```

2. Link the program:
```bash
gcc -no-pie binary_search.o -o binary_search
```

3. Run the program:
```bash
./binary_search
```

## Implementation Details

- Uses System V ABI calling convention
- Proper stack frame management
- Efficient register usage
- Direct memory access
- Optimized comparisons

## Features

- Handles empty arrays
- Handles single element arrays
- Handles negative numbers
- Handles duplicate elements (returns first occurrence)
- Efficient memory access
- Zero-copy implementation
- Direct register operations

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

## Notes

- This implementation is optimized for x86_64 architecture
- Uses System V ABI calling convention
- Assumes 32-bit integers
- Requires NASM assembler
- Tested on Linux systems
