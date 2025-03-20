#!/bin/bash

# Make the script executable
chmod +x implementations/*/*.sh

# Create results directory if it doesn't exist
mkdir -p results

# Function to run a benchmark and get real time
run_benchmark() {
    local lang=$1
    local cmd=$2
    echo "Running $lang benchmark..."
    { time $cmd; } 2>&1 | grep real | awk '{print $2}'
}

# Run all benchmarks and collect results
{
    echo "Language,Time"

    # JavaScript
    run_benchmark "JavaScript" "node implementations/javascript/mergesort.js"

    # TypeScript
    run_benchmark "TypeScript" "ts-node implementations/typescript/mergesort.ts"

    # Java
    run_benchmark "Java" "java -cp implementations/java Mergesort"

    # C
    run_benchmark "C" "./implementations/c/mergesort"

    # C++
    run_benchmark "C++" "./implementations/cpp/mergesort"

    # Haskell
    run_benchmark "Haskell" "./implementations/haskell/mergesort"

    # Zig
    run_benchmark "Zig" "./implementations/zig/mergesort"

    # C#
    run_benchmark "C#" "dotnet run --project implementations/csharp/mergesort.csproj"

    # Swift
    run_benchmark "Swift" "./implementations/swift/mergesort"

    # Lua
    run_benchmark "Lua" "lua implementations/lua/mergesort.lua"

    # Scala
    run_benchmark "Scala" "scala implementations/scala/Mergesort.scala"

    # Bash
    run_benchmark "Bash" "./implementations/bash/mergesort.sh"

    # PHP
    run_benchmark "PHP" "php implementations/php/mergesort.php"

    # Rust
    run_benchmark "Rust" "./implementations/rust/target/release/mergesort"

    # Python
    run_benchmark "Python" "python3 implementations/python/mergesort.py"

    # Perl
    run_benchmark "Perl" "perl implementations/perl/mergesort.pl"

    # Assembly
    run_benchmark "Assembly" "./implementations/assembly/mergesort"

    # Go
    run_benchmark "Go" "./implementations/go/mergesort"

    # Kotlin
    run_benchmark "Kotlin" "kotlin -cp implementations/kotlin MergesortKt"

    # R
    run_benchmark "R" "Rscript implementations/r/mergesort.R"
} | sort -t',' -k2 -n > benchmark_results.csv

echo "Benchmarks completed. Results saved to benchmark_results.csv"
