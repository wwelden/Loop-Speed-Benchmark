# LoopSpeed2

A comprehensive benchmarking project that compares the performance of various programming languages when executing computationally intensive loops. This project helps developers understand the performance characteristics of different programming languages in a controlled environment.

![performance_comparison](https://github.com/user-attachments/assets/8651199a-1f6d-4267-865b-077c02e2a5fa)
![detailed_performance](https://github.com/user-attachments/assets/c50c4a3a-ad8c-49ac-8afe-53e35cea45e2)

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
- C# (JIT)
- Go (standard and optimized)
- Haskell
- Java
- JavaScript
- Kotlin
- Lua (JIT and AOT)
- Perl (JIT and AOT)
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
- Virtual environment (recommended for Python dependencies)

## Quick Start Example

Here's exactly what you need to run to get the visualization working:

```bash
# 1. Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate  # On macOS/Linux
# or
.\venv\Scripts\activate  # On Windows

# 2. Install required packages
pip install matplotlib numpy

# 3. Run the visualization (using default input value of 7)
python visualize_performance.py

# 4. For scaling analysis with specific input values
python visualize_performance.py --scaling 3 5 7 9 11

# 5. When done, deactivate the virtual environment
deactivate
```

The script will generate two visualization files:
- `performance_comparison.png`: Basic performance comparison
- `detailed_performance.png`: Detailed categorization of results

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

1. Set up and activate the Python virtual environment:
   ```bash
   # Create virtual environment
   python3 -m venv venv

   # Activate virtual environment
   # On macOS/Linux:
   source venv/bin/activate
   # On Windows:
   .\venv\Scripts\activate

   # Install required packages
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

4. When done, you can deactivate the virtual environment:
   ```bash
   deactivate
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

## JIT Compilation

Some implementations in this project utilize Just-In-Time (JIT) compilation to improve performance:

- **LuaJIT**: An optimized version of Lua that uses JIT compilation
- **Perl JIT**: Perl implementation using the JIT compiler (via `-MO=JIT` flag)
- **JavaScript**: Modern JavaScript engines (V8, SpiderMonkey) use JIT compilation
- **Java**: Uses the HotSpot JVM with adaptive JIT compilation
- **C#**: Uses the .NET runtime with JIT compilation

JIT compilation can significantly improve performance by:
- Compiling frequently executed code paths to native machine code
- Optimizing code based on runtime behavior
- Reducing interpretation overhead
- Enabling dynamic optimization based on actual usage patterns

Note that JIT compilation may introduce warm-up overhead, where the first few runs might be slower as the JIT compiler analyzes and optimizes the code.

## Optimization Techniques

This project showcases various optimization techniques in different language implementations. Some notable examples include:

### HaskellOptimized
- Uses unboxed vectors (`Data.Vector.Unboxed`) for better memory layout
- Implements strict evaluation with `BangPatterns` language extension
- Uses more efficient loop constructs
- Compiled with `-O2 -funbox-strict-fields -fllvm` flags for maximum performance

### SwiftOptimized
- Uses `UnsafeMutableBufferPointer` for direct memory access
- Pre-calculates modulo results to avoid repetitive calculations
- Implements batch processing with stride for better cache utilization
- Compiled with `-O -whole-module-optimization` flags
- Uses memory management techniques like `defer` for proper cleanup

### GoOptimized
- Uses more efficient data structures
- Implements loop unrolling for better performance
- Takes advantage of Go's compiler optimization flags

### BashOptimized
- Uses built-in operations over external calls
- Reduces subshell usage
- Minimizes command substitution overhead

Optimization principles applied across languages:
1. **Memory optimization**: Efficient data structures and memory layouts
2. **Algorithm optimization**: Better algorithms and loop patterns
3. **Compiler optimization**: Using language-specific compiler flags
4. **Cache optimization**: Improving cache locality and reducing cache misses
5. **Instruction-level parallelism**: Loop unrolling and vectorization where applicable

## Contributing

Feel free to contribute by:
1. Adding implementations in new languages
2. Optimizing existing implementations
3. Improving the visualization capabilities
4. Adding more detailed documentation

## License

This project is open source and available under the MIT License.
