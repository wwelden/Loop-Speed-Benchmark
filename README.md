# LoopSpeed2

A comprehensive benchmarking project that compares the performance of various programming languages when executing computationally intensive loops. This project helps developers understand the performance characteristics of different programming languages in a controlled environment.

## Project Overview

This project implements a standardized loop-based computation in multiple programming languages to compare their performance. The core algorithm performs nested loops with array operations, which is a common pattern in many real-world applications.

### Core Algorithm Pseudocode

```python
# Input: u (user-provided number)
# Output: Single array element value

# Initialize
r = random number between 0 and 9999
a = array of 10000 zeros

# Main computation
for i in range(10000):
    for j in range(100000):
        a[i] = a[i] + (j % u)  # Simple modulo operation and addition
    a[i] += r  # Add random value to each element

# Return result
return a[r]  # Return single element from array
```

## Supported Languages

The project includes implementations in the following languages:
- Assembly (asm)
- Bash
- C
- C++
- C#
- Go (standard and optimized)
- Haskell
- Java
- JavaScript
- Kotlin
- Lua
- Perl
- PHP
- Python
- R
- Ruby
- Rust
- Scala
- Swift
- TypeScript
- Zig

## Prerequisites

To run the benchmarks, you'll need:
- A Unix-like environment (Linux, macOS, etc.)
- Various language compilers and interpreters installed
- Python 3.x (for visualization)

## Running the Benchmarks

### Basic Usage

1. Clone the repository
2. Make the run script executable:
   ```bash
   chmod +x run_loops.sh
   ```
3. Run the benchmarks:
   ```bash
   ./run_loops.sh [input_number]
   ```
   If no input number is provided, it defaults to 7.

### With Visualization

To generate performance visualizations:

1. Install Python dependencies:
   ```bash
   pip install matplotlib numpy
   ```

2. Run the visualization script:
   ```bash
   python visualize_performance.py [input_number]
   ```

3. For scaling analysis:
   ```bash
   python visualize_performance.py --scaling [input_values...]
   ```

## Output

The script will:
1. Compile all necessary programs
2. Run the benchmarks
3. Display execution times for each language
4. Generate visualizations (if using the visualization script)

## Visualization Features

The visualization script provides:
- Bar chart comparison of execution times
- Detailed visualization by language category (Compiled, JVM-based, Scripting)
- Scaling analysis across different input values
- Performance comparison with logarithmic scale for better visualization of large differences

## Project Structure

- `run_loops.sh`: Main script to compile and run all implementations
- `visualize_performance.py`: Python script for generating performance visualizations
- Language-specific directories (e.g., `c/`, `python/`, `rust/`, etc.): Contain implementations in each language
- `asmOptimized/`: Contains optimized assembly implementation
- `goOptimized/`: Contains optimized Go implementation

## Notes

- The benchmark focuses on CPU-intensive operations
- Results may vary based on:
  - Hardware specifications
  - Operating system
  - Compiler versions
  - System load
- Some languages may require specific compiler flags or runtime environments

## Contributing

Feel free to contribute by:
1. Adding implementations in new languages
2. Optimizing existing implementations
3. Improving the visualization capabilities
4. Adding more detailed documentation

## License

This project is open source and available under the MIT License.
