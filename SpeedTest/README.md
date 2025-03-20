# Programming Language MergeSort Benchmarks

This project implements MergeSort in various programming languages and benchmarks their performance.

## Project Structure

```
implementations/
├── javascript/
├── typescript/
├── java/
├── c/
├── cpp/
├── haskell/
├── zig/
├── csharp/
├── swift/
├── lua/
├── scala/
├── bash/
├── php/
├── rust/
├── python/
├── perl/
├── assembly/
├── go/
├── kotlin/
└── r/
```

## Running the Benchmarks

To run all benchmarks:

```bash
./run_benchmarks.sh
```

This will:
1. Run each implementation 100 times on 100 different unsorted arrays
2. Measure the execution time using the Unix `time` command
3. Sort the results by execution time
4. Output the results to `benchmark_results.csv`

## Requirements

- Node.js (for JavaScript/TypeScript)
- Java JDK
- GCC/Clang (for C/C++)
- GHC (for Haskell)
- Zig compiler
- .NET SDK (for C#)
- Swift compiler
- Lua interpreter
- Scala/SBT
- PHP
- Rust compiler
- Python 3
- Perl
- NASM (for Assembly)
- Go compiler
- Kotlin compiler
- R interpreter
