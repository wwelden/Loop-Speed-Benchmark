#!/bin/bash

# Script to run all benchmarks

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." &> /dev/null && pwd )"

# Create necessary directories
mkdir -p "$PROJECT_ROOT/results"

# Activate virtual environment if it exists
if [ -f "$PROJECT_ROOT/venv/bin/activate" ]; then
    source "$PROJECT_ROOT/venv/bin/activate"
fi

# Generate test data if needed
if [ ! -f "$PROJECT_ROOT/benchmark_input.txt" ] || [ ! -f "$PROJECT_ROOT/binary_search_input.txt" ]; then
    echo "Generating test data..."
    if [ -f "$PROJECT_ROOT/utils/generate_test_data.py" ]; then
        python3 "$PROJECT_ROOT/utils/generate_test_data.py"
    else
        echo "Error: Test data generator not found."
        exit 1
    fi
fi

# Run merge sort benchmarks
echo "Running merge sort benchmarks..."
if [ -f "$PROJECT_ROOT/algorithms/merge_sort/benchmark/run_benchmark.sh" ]; then
    bash "$PROJECT_ROOT/algorithms/merge_sort/benchmark/run_benchmark.sh"
else
    echo "Error: Merge sort benchmark script not found."
    exit 1
fi

# Run binary search benchmarks
echo "Running binary search benchmarks..."
if [ -f "$PROJECT_ROOT/algorithms/binary_search/benchmark/run_benchmark.sh" ]; then
    bash "$PROJECT_ROOT/algorithms/binary_search/benchmark/run_benchmark.sh"
else
    echo "Error: Binary search benchmark script not found."
    exit 1
fi

# Generate combined results
echo "Generating combined results..."
if [ -f "$PROJECT_ROOT/results/merge_sort/summary.csv" ] && [ -f "$PROJECT_ROOT/results/binary_search/summary.csv" ]; then
    # Create combined directory
    mkdir -p "$PROJECT_ROOT/results/combined"

    # Create combined file with header
    echo "language,algorithm,average_time" > "$PROJECT_ROOT/results/combined/combined_results.csv"

    # Add merge sort results
    tail -n +2 "$PROJECT_ROOT/results/merge_sort/summary.csv" | \
    awk -F, '{print $1",merge_sort,"$2}' >> "$PROJECT_ROOT/results/combined/combined_results.csv"

    # Add binary search results
    tail -n +2 "$PROJECT_ROOT/results/binary_search/summary.csv" | \
    awk -F, '{print $1",binary_search,"$2}' >> "$PROJECT_ROOT/results/combined/combined_results.csv"

    echo "Combined results saved to $PROJECT_ROOT/results/combined/combined_results.csv"

    # Generate visualizations if the tool exists
    if [ -f "$PROJECT_ROOT/utils/visualize_results.py" ]; then
        echo "Generating visualizations..."
        python3 "$PROJECT_ROOT/utils/visualize_results.py" --results "$PROJECT_ROOT/results/combined/combined_results.csv" --output "$PROJECT_ROOT/results/combined/visualization.html"
        echo "Visualization saved to $PROJECT_ROOT/results/combined/visualization.html"
    fi
else
    echo "Warning: Could not generate combined results. One or both summary files are missing."
fi

# Try to open the results in a browser if possible
if [ -f "$PROJECT_ROOT/results/combined/visualization.html" ]; then
    echo "Opening results visualization..."
    if command -v open > /dev/null; then
        open "$PROJECT_ROOT/results/combined/visualization.html"
    elif command -v xdg-open > /dev/null; then
        xdg-open "$PROJECT_ROOT/results/combined/visualization.html"
    elif command -v start > /dev/null; then
        start "$PROJECT_ROOT/results/combined/visualization.html"
    else
        echo "Please open the results file manually: $PROJECT_ROOT/results/combined/visualization.html"
    fi
fi

# Deactivate virtual environment if it was activated
if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
fi

echo "All benchmarks completed successfully!"
exit 0
