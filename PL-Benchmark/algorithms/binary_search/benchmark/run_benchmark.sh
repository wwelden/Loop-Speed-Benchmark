#!/bin/bash

# Benchmark script for binary search algorithm

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/../../.." &> /dev/null && pwd )"

# Configuration
NUM_RUNS=10
INPUT_FILE="$PROJECT_ROOT/binary_search_input.txt"
TARGETS_FILE="$PROJECT_ROOT/binary_search_targets.txt"
RESULTS_DIR="$PROJECT_ROOT/results/binary_search"
IMPLEMENTATIONS_DIR="$PROJECT_ROOT/algorithms/binary_search/implementations"
BUILD_DIR="$PROJECT_ROOT/algorithms/binary_search/build"

# Create necessary directories
mkdir -p "$RESULTS_DIR"
mkdir -p "$BUILD_DIR"

# Ensure test data exists
if [ ! -f "$INPUT_FILE" ] || [ ! -f "$TARGETS_FILE" ]; then
    echo "Input or targets file does not exist. Generating test data..."
    if [ -f "$PROJECT_ROOT/utils/generate_test_data.py" ]; then
        python3 "$PROJECT_ROOT/utils/generate_test_data.py" --algorithm binary_search
    else
        echo "Error: Test data generator not found."
        exit 1
    fi
fi

# Activate virtual environment if it exists
if [ -f "$PROJECT_ROOT/venv/bin/activate" ]; then
    source "$PROJECT_ROOT/venv/bin/activate"
fi

# Results file
RESULTS_FILE="$RESULTS_DIR/benchmark_results.csv"
echo "language,run,time_seconds" > "$RESULTS_FILE"

# Function to run a benchmark for a language
run_benchmark() {
    local language=$1
    local cmd=$2
    echo "Benchmarking $language implementation..."

    for ((run=1; run<=$NUM_RUNS; run++)); do
        echo "  Run $run/$NUM_RUNS..."
        # Measure execution time
        start_time=$(date +%s.%N)
        eval "$cmd"
        end_time=$(date +%s.%N)
        execution_time=$(echo "$end_time - $start_time" | bc)
        echo "$language,$run,$execution_time" >> "$RESULTS_FILE"
    done

    # Calculate average time
    avg_time=$(awk -F, -v lang="$language" '$1==lang {sum+=$3; count++} END {print sum/count}' "$RESULTS_FILE")
    echo "  Average time for $language: $avg_time seconds"
}

# Function to build and benchmark Assembly implementation
benchmark_assembly() {
    if [ -d "$IMPLEMENTATIONS_DIR/assembly/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/assembly"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            nasm -f macho64 "$IMPLEMENTATIONS_DIR/assembly/src/binary_search.asm" -o "$BUILD_DIR/assembly/binary_search.o"
            gcc -o "$BUILD_DIR/assembly/binary_search" "$BUILD_DIR/assembly/binary_search.o"
        else
            # Linux
            nasm -f elf64 "$IMPLEMENTATIONS_DIR/assembly/src/binary_search.asm" -o "$BUILD_DIR/assembly/binary_search.o"
            gcc -no-pie -o "$BUILD_DIR/assembly/binary_search" "$BUILD_DIR/assembly/binary_search.o"
        fi

        # Run benchmark
        if [ -f "$BUILD_DIR/assembly/binary_search" ]; then
            run_benchmark "assembly" "$BUILD_DIR/assembly/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "Assembly build failed."
        fi
    else
        echo "Assembly implementation not found."
    fi
}

# Function to build and benchmark C implementation
benchmark_c() {
    if [ -d "$IMPLEMENTATIONS_DIR/c/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/c"
        gcc -O2 "$IMPLEMENTATIONS_DIR/c/src/binary_search.c" -o "$BUILD_DIR/c/binary_search"

        # Run benchmark
        if [ -f "$BUILD_DIR/c/binary_search" ]; then
            run_benchmark "c" "$BUILD_DIR/c/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "C build failed."
        fi
    else
        echo "C implementation not found."
    fi
}

# Function to build and benchmark C++ implementation
benchmark_cpp() {
    if [ -d "$IMPLEMENTATIONS_DIR/cpp/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/cpp"
        g++ -O2 "$IMPLEMENTATIONS_DIR/cpp/src/binary_search.cpp" -o "$BUILD_DIR/cpp/binary_search"

        # Run benchmark
        if [ -f "$BUILD_DIR/cpp/binary_search" ]; then
            run_benchmark "cpp" "$BUILD_DIR/cpp/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "C++ build failed."
        fi
    else
        echo "C++ implementation not found."
    fi
}

# Function to build and benchmark C# implementation
benchmark_csharp() {
    if [ -d "$IMPLEMENTATIONS_DIR/csharp/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/csharp"
        cd "$IMPLEMENTATIONS_DIR/csharp/src"
        dotnet build -c Release
        cd "$PROJECT_ROOT"

        # Run benchmark
        if [ -f "$IMPLEMENTATIONS_DIR/csharp/src/bin/Release/net6.0/binary_search.dll" ]; then
            run_benchmark "csharp" "dotnet $IMPLEMENTATIONS_DIR/csharp/src/bin/Release/net6.0/binary_search.dll $INPUT_FILE $TARGETS_FILE"
        else
            echo "C# build failed."
        fi
    else
        echo "C# implementation not found."
    fi
}

# Function to build and benchmark Go implementation
benchmark_go() {
    if [ -d "$IMPLEMENTATIONS_DIR/go/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/go"
        go build -o "$BUILD_DIR/go/binary_search" "$IMPLEMENTATIONS_DIR/go/src/binary_search.go"

        # Run benchmark
        if [ -f "$BUILD_DIR/go/binary_search" ]; then
            run_benchmark "go" "$BUILD_DIR/go/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "Go build failed."
        fi
    else
        echo "Go implementation not found."
    fi
}

# Function to build and benchmark Java implementation
benchmark_java() {
    if [ -d "$IMPLEMENTATIONS_DIR/java/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/java"
        javac -d "$BUILD_DIR/java" "$IMPLEMENTATIONS_DIR/java/src/BinarySearch.java"

        # Run benchmark
        if [ -f "$BUILD_DIR/java/BinarySearch.class" ]; then
            run_benchmark "java" "java -cp $BUILD_DIR/java BinarySearch $INPUT_FILE $TARGETS_FILE"
        else
            echo "Java build failed."
        fi
    else
        echo "Java implementation not found."
    fi
}

# Function to build and benchmark JavaScript implementation
benchmark_javascript() {
    if [ -d "$IMPLEMENTATIONS_DIR/javascript/src" ]; then
        # JavaScript doesn't need to be built
        if [ -f "$IMPLEMENTATIONS_DIR/javascript/src/binary_search.js" ]; then
            run_benchmark "javascript" "node $IMPLEMENTATIONS_DIR/javascript/src/binary_search.js $INPUT_FILE $TARGETS_FILE"
        else
            echo "JavaScript implementation not found."
        fi
    else
        echo "JavaScript implementation not found."
    fi
}

# Function to build and benchmark TypeScript implementation
benchmark_typescript() {
    if [ -d "$IMPLEMENTATIONS_DIR/typescript/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/typescript"
        tsc --outDir "$BUILD_DIR/typescript" "$IMPLEMENTATIONS_DIR/typescript/src/binary_search.ts"

        # Run benchmark
        if [ -f "$BUILD_DIR/typescript/binary_search.js" ]; then
            run_benchmark "typescript" "node $BUILD_DIR/typescript/binary_search.js $INPUT_FILE $TARGETS_FILE"
        else
            echo "TypeScript build failed."
        fi
    else
        echo "TypeScript implementation not found."
    fi
}

# Function to build and benchmark Python implementation
benchmark_python() {
    if [ -d "$IMPLEMENTATIONS_DIR/python/src" ]; then
        # Python doesn't need to be built
        if [ -f "$IMPLEMENTATIONS_DIR/python/src/binary_search.py" ]; then
            run_benchmark "python" "python3 $IMPLEMENTATIONS_DIR/python/src/binary_search.py $INPUT_FILE $TARGETS_FILE"
        else
            echo "Python implementation not found."
        fi
    else
        echo "Python implementation not found."
    fi
}

# Function to build and benchmark Bash implementation
benchmark_bash() {
    if [ -d "$IMPLEMENTATIONS_DIR/bash/src" ]; then
        # Bash doesn't need to be built
        if [ -f "$IMPLEMENTATIONS_DIR/bash/src/binary_search.sh" ]; then
            # Make sure it's executable
            chmod +x "$IMPLEMENTATIONS_DIR/bash/src/binary_search.sh"
            run_benchmark "bash" "bash $IMPLEMENTATIONS_DIR/bash/src/binary_search.sh $INPUT_FILE $TARGETS_FILE"
        else
            echo "Bash implementation not found."
        fi
    else
        echo "Bash implementation not found."
    fi
}

# Function to build and benchmark Rust implementation
benchmark_rust() {
    if [ -d "$IMPLEMENTATIONS_DIR/rust/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/rust"
        cd "$IMPLEMENTATIONS_DIR/rust"
        cargo build --release
        cd "$PROJECT_ROOT"

        # Run benchmark
        if [ -f "$IMPLEMENTATIONS_DIR/rust/target/release/binary_search" ]; then
            run_benchmark "rust" "$IMPLEMENTATIONS_DIR/rust/target/release/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "Rust build failed."
        fi
    else
        echo "Rust implementation not found."
    fi
}

# Function to build and benchmark Swift implementation
benchmark_swift() {
    if [ -d "$IMPLEMENTATIONS_DIR/swift/src" ]; then
        # Build
        mkdir -p "$BUILD_DIR/swift"
        swiftc -O "$IMPLEMENTATIONS_DIR/swift/src/binary_search.swift" -o "$BUILD_DIR/swift/binary_search"

        # Run benchmark
        if [ -f "$BUILD_DIR/swift/binary_search" ]; then
            run_benchmark "swift" "$BUILD_DIR/swift/binary_search $INPUT_FILE $TARGETS_FILE"
        else
            echo "Swift build failed."
        fi
    else
        echo "Swift implementation not found."
    fi
}

# Run all benchmarks
echo "Running binary search benchmarks..."

# Run individual language benchmarks
benchmark_assembly
benchmark_c
benchmark_cpp
benchmark_csharp
benchmark_go
benchmark_java
benchmark_javascript
benchmark_typescript
benchmark_python
benchmark_bash
benchmark_rust
benchmark_swift

# Generate summary
echo "Generating summary..."
echo "Language,Average Time (seconds)" > "$RESULTS_DIR/summary.csv"
awk -F, '{
    if (NR > 1) {
        data[$1] += $3;
        count[$1]++;
    }
}
END {
    for (lang in data) {
        printf "%s,%.6f\n", lang, data[lang]/count[lang];
    }
}' "$RESULTS_FILE" | sort -t, -k2,2n >> "$RESULTS_DIR/summary.csv"

# Print summary
echo ""
echo "Results Summary:"
echo "================"
column -t -s, "$RESULTS_DIR/summary.csv"
echo ""
echo "Detailed results saved to: $RESULTS_FILE"
echo "Summary saved to: $RESULTS_DIR/summary.csv"

# Visualize results if the script exists
if [ -f "$PROJECT_ROOT/utils/visualize_results.py" ]; then
    echo "Generating visualization..."
    python3 "$PROJECT_ROOT/utils/visualize_results.py" --results "$RESULTS_FILE" --output "$RESULTS_DIR/benchmark_visualization.html"
    echo "Visualization saved to: $RESULTS_DIR/benchmark_visualization.html"
fi

# Deactivate virtual environment if it was activated
if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
fi

echo "Benchmark completed successfully!"
exit 0
