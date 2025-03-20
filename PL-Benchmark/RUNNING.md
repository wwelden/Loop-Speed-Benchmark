# Running the PL-Benchmark Project

This document provides detailed instructions on how to run the PL-Benchmark project.

## Prerequisites

Before running the benchmarks, you need to ensure you have the necessary dependencies installed:

1. **Python 3.8+**: Required for test data generation and visualization
2. **Various language compilers/interpreters**: For the specific languages you want to benchmark
3. **Git**: For cloning the repository (if you haven't done so already)

## Quick Start

For the simplest way to run all benchmarks:

```bash
cd PL-Benchmark
./run.sh
```

This script will:
1. Create a Python virtual environment if needed
2. Install required Python packages
3. Make all scripts executable
4. Run all benchmarks
5. Open the results in your default browser (if possible)

## Step-by-Step Guide

If you prefer to run things manually, follow these steps:

### 1. Set up the Python environment

```bash
cd PL-Benchmark
source ./activate_venv.sh
```

### 2. Check Dependencies

```bash
./scripts/check_dependencies.sh
```

This will show you which language compilers and interpreters are installed on your system.

### 3. Run Specific Algorithm Benchmarks

For merge sort:
```bash
cd algorithms/merge_sort/benchmark
./benchmark.sh
```

For binary search:
```bash
cd algorithms/binary_search/benchmark
./benchmark.sh
```

### 4. Run All Benchmarks

```bash
./scripts/run_all_benchmarks.sh
```

### 5. Visualize Results

The results are automatically visualized after running the benchmarks, but you can also generate visualizations manually:

```bash
python3 ./scripts/visualize_results.py ./results/all_results.csv
```

## Understanding the Results

The benchmarks generate several result files:

1. `results/all_results.csv`: Raw benchmark data
2. `results/comparison_table.csv`: Comparison table in CSV format
3. `results/comparison_table.html`: Interactive HTML comparison table
4. `results/[algorithm]_comparison.png`: Bar charts comparing language performance

## Troubleshooting

### Common Issues:

1. **Missing Dependencies**: Run `./scripts/check_dependencies.sh` to see which dependencies you need to install.

2. **Path Issues**: If you encounter "file not found" errors, make sure you're running the scripts from the correct directory. The `run.sh` script should be run from the main project directory.

3. **Permission Denied**: If you get "permission denied" errors, make sure the scripts are executable:
   ```bash
   chmod +x ./run.sh
   chmod +x ./scripts/*.sh ./scripts/*.py
   chmod +x ./algorithms/*/benchmark/*.sh
   ```

4. **Python Module Issues**: If you see errors about missing Python modules, make sure you've activated the virtual environment:
   ```bash
   source ./activate_venv.sh
   ```

### Getting Help

If you encounter any issues not covered here, please:

1. Check the project documentation for additional information
2. Open an issue on the project repository
3. Contact the project maintainers for assistance

## Running Without Migration

If you want to run benchmarks without migrating from the old structure:

1. Make sure the directory structure is correct:
   ```
   PL-Benchmark/
   ├── algorithms/
   │   ├── binary_search/
   │   │   ├── benchmark/
   │   │   ├── build/
   │   │   └── implementations/
   │   ├── merge_sort/
   │   │   ├── benchmark/
   │   │   ├── build/
   │   │   └── implementations/
   ├── scripts/
   ├── utils/
   └── results/
   ```

2. Add your implementations to the appropriate directories
3. Run the benchmarks as described above
