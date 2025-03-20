#!/bin/bash

# Function to measure execution time
run_benchmark() {
    local name=$1
    local cmd=$2
    echo "Running $name benchmark..."
    local start=$(date +%s.%N)
    eval $cmd
    local end=$(date +%s.%N)
    local runtime=$(printf "%.3f" $(echo "$end - $start" | bc))
    echo "$name,$runtime" >> results.csv
    echo "$name took $runtime seconds"
}

# Create results file
echo "Implementation,Time" > results.csv

# Run each implementation
# Python
run_benchmark "Python" "python3 implementations/python/mergesort.py"

# JavaScript
run_benchmark "JavaScript" "node implementations/javascript/mergesort.js"

# Java
run_benchmark "Java" "(cd implementations/java && java Mergesort)"

# C
run_benchmark "C" "implementations/c/mergesort"

# C++
run_benchmark "C++" "implementations/cpp/mergesort"

# Rust
run_benchmark "Rust" "implementations/rust/target/release/mergesort"

# Go
run_benchmark "Go" "implementations/go/mergesort"

# Swift
run_benchmark "Swift" "implementations/swift/mergesort"

# Lua
run_benchmark "Lua" "lua implementations/lua/mergesort.lua"

# PHP
run_benchmark "PHP" "php implementations/php/mergesort.php"

# Perl
run_benchmark "Perl" "perl implementations/perl/mergesort.pl"

# R
run_benchmark "R" "Rscript implementations/r/mergesort.R"

# Kotlin
run_benchmark "Kotlin" "java -jar implementations/kotlin/Mergesort.jar"

# C#
run_benchmark "C#" "dotnet implementations/csharp/bin/Release/net7.0/mergesort.dll"

# TypeScript
run_benchmark "TypeScript" "node implementations/typescript/mergesort.js"

# Scala
run_benchmark "Scala" "scala implementations/scala/Mergesort"

# Bash
run_benchmark "Bash" "bash implementations/bash/mergesort.sh"

# Assembly
run_benchmark "Assembly" "implementations/assembly/mergesort"

# Zig
run_benchmark "Zig" "implementations/zig/mergesort"

# Sort results by execution time and format with 3 decimal places
echo -e "\nResults sorted by execution time:"
sort -t',' -k2 -n results.csv | while IFS=, read -r name time; do
    printf "%-15s %-.3f\n" "$name" "$time"
done
