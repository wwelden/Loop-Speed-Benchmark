#!/bin/bash

# Generate a large sorted array (1 million elements)
echo "Generating test data..."
python3 -c "
import random
with open('test_data.txt', 'w') as f:
    numbers = sorted(random.sample(range(-1000000, 1000000), 1000000))
    f.write('\n'.join(map(str, numbers)))
"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to run a test and return execution time
run_test() {
    local lang=$1
    local cmd=$2
    local compiler=$3

    if [ -n "$compiler" ] && ! command_exists "$compiler"; then
        echo "Skipping $lang (compiler not found: $compiler)" >&2
        return 1
    fi

    echo "Running $lang..." >&2
    local time_output=$(time -p $cmd 2>&1)
    local real_time=$(echo "$time_output" | grep real | awk '{print $2}')
    if [ -n "$real_time" ]; then
        printf "%s\t%s\n" "$lang" "$real_time"
    fi
}

# Run tests for each language
echo "Running benchmarks..."

# Create temporary file to store results
results_file=$(mktemp)

# Run tests and collect results
for test in \
    "JavaScript:node js/src/binary_search.js test_data.txt:node" \
    "TypeScript:ts-node ts/src/binary_search.ts test_data.txt:ts-node" \
    "Java:java -cp java/src BinarySearch test_data.txt:javac" \
    "C:gcc -o c/binary_search c/src/binary_search.c && ./c/binary_search test_data.txt:gcc" \
    "C++:g++ -std=c++11 -o cpp/binary_search cpp/src/binary_search.cpp && ./cpp/binary_search test_data.txt:g++" \
    "Haskell:ghc -o haskell/binary_search haskell/src/binary_search.hs && ./haskell/binary_search test_data.txt:ghc" \
    "Zig:zig build-exe -o zig/binary_search zig/src/binary_search.zig && ./zig/binary_search test_data.txt:zig" \
    "CSharp:dotnet run --project csharp/src/binary_search.csproj test_data.txt:dotnet" \
    "Swift:swiftc -o swift/binary_search swift/src/binary_search.swift && ./swift/binary_search test_data.txt:swiftc" \
    "Lua:lua lua/src/binary_search.lua test_data.txt:lua" \
    "Scala:scalac -d scala/target/scala/classes scala/src/main/scala/BinarySearch.scala && scala -cp scala/target/scala/classes binarysearch.BinarySearch test_data.txt:scalac" \
    "Bash:./bash/src/binary_search.sh test_data.txt:bash" \
    "PHP:php php/src/binary_search.php test_data.txt:php" \
    "Rust:rustc -o rust/binary_search rust/src/binary_search.rs && ./rust/binary_search test_data.txt:rustc" \
    "Python:python3 python/src/binary_search.py test_data.txt:python3" \
    "Go:go run go/src/binary_search.go test_data.txt:go" \
    "Kotlin:kotlinc kotlin/src/binary_search.kt -include-runtime -d kotlin/binary_search.jar && java -jar kotlin/binary_search.jar test_data.txt:kotlinc" \
    "Perl:perl perl/src/binary_search.pl test_data.txt:perl" \
    "Assembly:nasm -f macho64 asm/src/binary_search.asm && ld -o asm/binary_search asm/src/binary_search.o && ./asm/binary_search test_data.txt:nasm" \
    "R:Rscript r/src/binary_search.R test_data.txt:Rscript"
do
    IFS=: read -r lang cmd compiler <<< "$test"
    output=$(run_test "$lang" "$cmd" "$compiler")
    if [ $? -eq 0 ]; then
        echo "$output" >> "$results_file"
    fi
done

# Print results using Python for better formatting
python3 -c '
import sys

print("\nResults (sorted by execution time):")
print("----------------------------------------")
print("{:<15}\t{}".format("Language", "Time (seconds)"))
print("----------------------------------------")

results = []
with open("'"$results_file"'") as f:
    for line in f:
        try:
            parts = line.strip().split("\t")
            if len(parts) >= 2:
                lang = parts[0]
                time = float(parts[1])
                results.append((lang, time))
        except (ValueError, IndexError):
            continue

for lang, time in sorted(results, key=lambda x: x[1]):
    print("{:<15}\t{:.2f}".format(lang, time))
sys.stdout.flush()
'

# Cleanup
rm -f test_data.txt "$results_file"
