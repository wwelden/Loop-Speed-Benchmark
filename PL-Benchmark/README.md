# PL-Benchmark

A comprehensive benchmarking suite for comparing algorithm implementations across multiple programming languages.

## Overview

PL-Benchmark provides a framework for implementing, testing, and benchmarking algorithms across various programming languages. The project is designed to help developers understand performance characteristics of different languages and their implementations.

Current algorithms implemented:
- Merge Sort
- Binary Search

## Project Structure

```
PL-Benchmark/
├── algorithms/
│   ├── binary_search/
│   │   ├── benchmark/
│   │   ├── build/
│   │   └── implementations/
│   │       ├── assembly/
│   │       ├── bash/
│   │       ├── c/
│   │       └── ... (other languages)
│   └── merge_sort/
│       ├── benchmark/
│       ├── build/
│       └── implementations/
│           ├── assembly/
│           ├── bash/
│           ├── c/
│           └── ... (other languages)
├── results/
│   ├── binary_search/
│   └── merge_sort/
├── scripts/
├── utils/
├── init_structure.sh
├── migrate_implementations.sh
├── run.sh
└── venv/
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/username/PL-Benchmark.git
   cd PL-Benchmark
   ```

2. Run the setup and benchmark:
   ```bash
   ./run.sh
   ```

3. Follow the interactive menu to run benchmarks, generate test data, or visualize results.

## Prerequisites

- Python 3.8 or higher
- Language compilers/interpreters for languages you want to benchmark
- Basic build tools (Make, Git, etc.)

## Running Benchmarks

The project includes a user-friendly script to run benchmarks:

```bash
./run.sh
```

This will:
1. Set up a Python virtual environment
2. Install necessary dependencies
3. Initialize the directory structure
4. Present a menu of options

You can also run benchmarks for specific algorithms directly:

```bash
# Run merge sort benchmarks
./algorithms/merge_sort/benchmark/run_benchmark.sh

# Run binary search benchmarks (when implemented)
./algorithms/binary_search/benchmark/run_benchmark.sh
```

## Adding New Implementations

To add a new language implementation:

1. Create a directory in the appropriate algorithm's implementations folder
   ```bash
   mkdir -p algorithms/merge_sort/implementations/your_language/src
   ```

2. Add your implementation in the src directory
3. Ensure your implementation:
   - Takes input file path as command line argument
   - Writes sorted output to a file
   - Returns 0 on success

## Visualizing Results

After running benchmarks, results are saved in the `results` directory. You can visualize them using:

```bash
python utils/visualize_results.py --results results/merge_sort/benchmark_results.csv --output results/merge_sort/visualization.html
```

This generates both HTML and PNG visualizations of the benchmark results.

## Troubleshooting

If you encounter issues:

1. Check dependencies:
   ```bash
   python utils/check_dependencies.py
   ```

2. Ensure all scripts are executable:
   ```bash
   chmod +x run.sh
   chmod +x algorithms/*/benchmark/*.sh
   chmod +x utils/*.py
   ```

3. Review error messages in the benchmark output

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-language`)
3. Commit your changes (`git commit -am 'Add some language'`)
4. Push to the branch (`git push origin feature/new-language`)
5. Submit a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to all contributors who have implemented algorithms in various languages
- Inspired by various language comparison projects
