# PL-Benchmark Project Overview

## Project Reorganization

This document describes the reorganization of the programming language benchmark project.

### Old Structure
The project was previously organized with two main directories:
- `MergeSort/`: Containing implementations of merge sort in different languages
- `SpeedTest/`: Containing benchmarking scripts and results

This structure had several limitations:
1. No clear separation between different algorithms
2. Inconsistent naming and organization across language implementations
3. Duplicated benchmark code
4. Limited automation for testing and reporting

### New Structure
The project has been reorganized into a more structured format:

```
PL-Benchmark/
├── algorithms/
│   ├── binary_search/
│   │   ├── benchmark/
│   │   ├── build/
│   │   └── implementations/
│   │       ├── c/
│   │       ├── cpp/
│   │       └── ...
│   ├── merge_sort/
│   │   ├── benchmark/
│   │   ├── build/
│   │   └── implementations/
│   │       ├── c/
│   │       ├── cpp/
│   │       └── ...
│   └── ...
├── scripts/
├── utils/
├── venv/
└── results/
```

Benefits of the new structure:
1. **Clear separation of algorithms**: Each algorithm has its own directory
2. **Consistent implementation structure**: All languages follow the same organization
3. **Centralized utilities**: Common code is shared through the utils directory
4. **Automated benchmarking**: Scripts for running all benchmarks and visualizing results
5. **Better results organization**: Structured output for easier comparison
6. **Cross-platform compatibility**: OS detection for platform-specific code
7. **Python environment isolation**: Virtual environment for required Python packages

## Environment Management

The project now includes a dedicated Python virtual environment for isolating dependencies:

1. **Virtual Environment**: Located in `venv/` directory
2. **Activation Script**: `activate_venv.sh` for easy environment setup
3. **Auto-activation**: Scripts automatically activate the environment when needed

This ensures that the project can run without interfering with system-wide Python packages.

## Path Management

All scripts now use absolute paths to ensure proper operation regardless of the current working directory:

1. **BASH_SOURCE-based paths**: Scripts determine their location using BASH_SOURCE
2. **PROJECT_ROOT variable**: All paths are calculated relative to the project root
3. **Auto-detection**: Directory detection with error handling

This makes the project more robust and easier to run from any location.

## Utility Scripts

The project includes several utility scripts:

1. **check_dependencies.sh**: Checks for required language compilers and interpreters
2. **generate_test_data.py**: Generates test data for benchmarking
3. **run_all_benchmarks.sh**: Runs benchmarks for all algorithms
4. **visualize_results.py**: Creates charts and tables from benchmark results
5. **migrate_implementations.sh**: Helps migrate from old structure to new
6. **run.sh**: Main script for running all benchmarks with proper setup

## Common Utilities

Shared functions are provided in `utils/common.sh`:
- Color formatting for terminal output
- OS detection for platform-specific commands
- Functions for generating test data
- Benchmark execution helpers
- Dependency checking

## Running Benchmarks

Each algorithm has its own benchmark script in `algorithms/[algorithm]/benchmark/benchmark.sh` that:
1. Generates appropriate test data
2. Compiles implementations if needed
3. Runs benchmarks for each language
4. Records and reports results

To run all benchmarks:
```bash
./run.sh
```

## Migration

The `migrate_implementations.sh` script helps move existing code from the old structure to the new one. It:
1. Identifies language implementations in the old structure
2. Creates appropriate directories in the new structure
3. Copies files maintaining their organization
4. Reports on the success or failure of each migration

## Troubleshooting

The project now includes comprehensive troubleshooting information in the RUNNING.md file, covering common issues such as:
1. Missing dependencies
2. Path problems
3. Permission issues
4. Python module errors

## Next Steps

1. Complete migration of all implementations
2. Add unit tests for each implementation
3. Add more algorithms (sorting, searching, dynamic programming, etc.)
4. Add a web interface for viewing results
5. Implement continuous integration for automated benchmarking
