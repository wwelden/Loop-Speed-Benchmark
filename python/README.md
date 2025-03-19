# Binary Search in Python

This directory contains a Python implementation of the binary search algorithm.

## Requirements
- Python 3.6 or higher
- pytest (for running tests)

## Installation
```bash
pip install pytest
```

## Running the Code

### Running the main implementation
```bash
python src/binary_search.py
```

### Running the tests
```bash
pytest tests/test_binary_search.py -v
```

## Implementation Details
The implementation uses Python's type hints for better code clarity and includes comprehensive docstrings. The binary search algorithm has:
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
