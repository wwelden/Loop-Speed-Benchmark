#!/bin/bash

# Main script to run the entire PL-Benchmark suite

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "PL-Benchmark Runner"
echo "===================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check Python version
if command_exists python3; then
    PYTHON_CMD="python3"
elif command_exists python; then
    PYTHON_CMD="python"
else
    echo "Error: Python is not installed. Please install Python 3.8 or higher."
    exit 1
fi

# Check Python version meets requirements
PY_VERSION=$($PYTHON_CMD -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
PY_MAJOR=$(echo $PY_VERSION | cut -d. -f1)
PY_MINOR=$(echo $PY_VERSION | cut -d. -f2)

if [ "$PY_MAJOR" -lt 3 ] || [ "$PY_MAJOR" -eq 3 -a "$PY_MINOR" -lt 8 ]; then
    echo "Error: Python 3.8 or higher is required. You have $PY_VERSION."
    exit 1
fi

# Set up virtual environment if it doesn't exist
VENV_DIR="$SCRIPT_DIR/venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Setting up Python virtual environment..."
    $PYTHON_CMD -m venv "$VENV_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create virtual environment. Please install venv module."
        exit 1
    fi

    # Create activation script
    cat > "$SCRIPT_DIR/activate_venv.sh" << EOF
#!/bin/bash
# Script to activate the Python virtual environment
source "$VENV_DIR/bin/activate"
echo "Python virtual environment activated. Run 'deactivate' to exit."
EOF
    chmod +x "$SCRIPT_DIR/activate_venv.sh"
fi

# Activate virtual environment
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
    echo "Python virtual environment activated."
else
    echo "Error: Virtual environment activation script not found."
    exit 1
fi

# Install required Python packages
echo "Installing required Python packages..."
pip install --upgrade pip
pip install matplotlib pandas numpy
if [ $? -ne 0 ]; then
    echo "Error: Failed to install required Python packages."
    exit 1
fi

# Initialize directory structure if needed
if [ ! -d "$SCRIPT_DIR/algorithms" ]; then
    echo "Initializing directory structure..."
    bash "$SCRIPT_DIR/init_structure.sh"
fi

# Check if migration is needed
if [ ! -d "$SCRIPT_DIR/algorithms/merge_sort/implementations/assembly/src" ] && [ -d "$SCRIPT_DIR/asm/src" ]; then
    echo "Migrating existing implementations..."
    bash "$SCRIPT_DIR/migrate_implementations.sh"
fi

# Ensure all scripts are executable
chmod +x "$SCRIPT_DIR/scripts"/*.sh 2>/dev/null || true
chmod +x "$SCRIPT_DIR/utils"/*.py 2>/dev/null || true
chmod +x "$SCRIPT_DIR/algorithms/merge_sort/benchmark"/*.sh 2>/dev/null || true
chmod +x "$SCRIPT_DIR/algorithms/binary_search/benchmark"/*.sh 2>/dev/null || true

# Create benchmark scripts for each algorithm
mkdir -p "$SCRIPT_DIR/scripts"
mkdir -p "$SCRIPT_DIR/algorithms/merge_sort/benchmark"
mkdir -p "$SCRIPT_DIR/algorithms/binary_search/benchmark"

# Generate test data if it doesn't exist
if [ ! -f "$SCRIPT_DIR/benchmark_input.txt" ]; then
    echo "Generating test data..."
    if [ -f "$SCRIPT_DIR/utils/generate_test_data.py" ]; then
        $PYTHON_CMD "$SCRIPT_DIR/utils/generate_test_data.py"
    else
        echo "Warning: Test data generator not found. Benchmark may fail."
    fi
fi

# Main menu
while true; do
    clear
    echo "PL-Benchmark Runner"
    echo "===================="
    echo "1) Run all benchmarks"
    echo "2) Run merge sort benchmarks"
    echo "3) Run binary search benchmarks"
    echo "4) Generate test data"
    echo "5) Visualize results"
    echo "6) Initialize/migrate project structure"
    echo "7) Check dependencies"
    echo "8) Quit"
    echo ""
    read -p "Enter your choice (1-8): " choice

    case $choice in
        1)
            echo "Running all benchmarks..."
            if [ -f "$SCRIPT_DIR/scripts/run_all_benchmarks.sh" ]; then
                bash "$SCRIPT_DIR/scripts/run_all_benchmarks.sh"
            else
                echo "Error: All benchmarks script not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "Running merge sort benchmarks..."
            if [ -f "$SCRIPT_DIR/algorithms/merge_sort/benchmark/run_benchmark.sh" ]; then
                bash "$SCRIPT_DIR/algorithms/merge_sort/benchmark/run_benchmark.sh"
            else
                echo "Merge sort benchmark script not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "Running binary search benchmarks..."
            if [ -f "$SCRIPT_DIR/algorithms/binary_search/benchmark/run_benchmark.sh" ]; then
                bash "$SCRIPT_DIR/algorithms/binary_search/benchmark/run_benchmark.sh"
            else
                echo "Binary search benchmark script not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "Generating test data..."
            if [ -f "$SCRIPT_DIR/utils/generate_test_data.py" ]; then
                $PYTHON_CMD "$SCRIPT_DIR/utils/generate_test_data.py"
                echo "Test data generated successfully."
            else
                echo "Test data generator not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "Visualizing results..."
            if [ -f "$SCRIPT_DIR/utils/visualize_results.py" ]; then
                if [ -f "$SCRIPT_DIR/results/merge_sort/benchmark_results.csv" ]; then
                    $PYTHON_CMD "$SCRIPT_DIR/utils/visualize_results.py" \
                        --results "$SCRIPT_DIR/results/merge_sort/benchmark_results.csv" \
                        --output "$SCRIPT_DIR/results/merge_sort/visualization.html"
                    echo "Merge sort visualization generated."

                    # Open in browser if possible
                    if command -v open > /dev/null; then
                        open "$SCRIPT_DIR/results/merge_sort/visualization.html"
                    elif command -v xdg-open > /dev/null; then
                        xdg-open "$SCRIPT_DIR/results/merge_sort/visualization.html"
                    elif command -v start > /dev/null; then
                        start "$SCRIPT_DIR/results/merge_sort/visualization.html"
                    fi
                else
                    echo "No benchmark results found. Please run benchmarks first."
                fi
            else
                echo "Visualization script not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        6)
            echo "Initializing/migrating project structure..."
            bash "$SCRIPT_DIR/init_structure.sh"
            bash "$SCRIPT_DIR/migrate_implementations.sh"
            echo "Project structure initialized/migrated successfully."
            read -p "Press Enter to continue..."
            ;;
        7)
            echo "Checking dependencies..."
            if [ -f "$SCRIPT_DIR/utils/check_dependencies.py" ]; then
                $PYTHON_CMD "$SCRIPT_DIR/utils/check_dependencies.py"
                echo "Dependency check completed."
            else
                echo "Dependency checker not found."
            fi
            read -p "Press Enter to continue..."
            ;;
        8)
            echo "Exiting..."
            deactivate 2>/dev/null || true
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 8."
            read -p "Press Enter to continue..."
            ;;
    esac
done
