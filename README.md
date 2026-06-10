# LoopSpeed2

A benchmarking project that compares how different programming languages perform on the same CPU-bound nested-loop workload. Every implementation runs the identical algorithm with the identical source-level pattern, so the differences you see come from the language implementation, not the code.

![performance_comparison](https://github.com/user-attachments/assets/8651199a-1f6d-4267-865b-077c02e2a5fa)
![detailed_performance](https://github.com/user-attachments/assets/c50c4a3a-ad8c-49ac-8afe-53e35cea45e2)

## Project Overview

Each language implements the same loop-based computation: 10,000 outer iterations, each performing 100,000 modulo-and-add operations against an array element (one billion operations total). The divisor `u` comes from the command line so compilers cannot constant-fold the work away.

### Core Algorithm Pseudocode

```python
# Input: u (user-provided number)
# Output: Single array element value

# Initialize
r = random number between 0 and 9999
a = array of 10000 zeros

# Main computation
for i in range(10000):
    for j in range(100000):
        a[i] = a[i] + (j % u)  # Simple modulo operation and addition
    a[i] += r  # Add random value to each element

# Return result
return a[r]  # Return single element from array
```

Every standard implementation performs the array read/write inside the inner loop, exactly as written above — no local accumulator variables, no precomputed sums. For input 7, the result is always `299995 + r`, which makes it easy to spot an implementation that isn't doing the real work.

## Supported Languages

- Assembly (ARM64 macOS; hand-written hot loop, libc for I/O)
- Bash — pure Bash exists in `bash/` but is disabled by default (10⁹ interpreted shell operations take hours)
- Bash (via C) — openly cheats by compiling and running the C implementation; see below
- C
- C++
- C# (.NET)
- Go (plus a parallelized `GoOptimized` variant; see below)
- Haskell (GHC, compiled with `-O2`)
- Java
- JavaScript (Node)
- Kotlin
- Lua (interpreter and LuaJIT)
- Perl
- PHP
- Python
- R
- Ruby
- Rust
- Scala
- Swift
- TypeScript (compiled with tsc, run on Node)
- Zig

Languages whose toolchains aren't installed are skipped automatically.

## Prerequisites

- A Unix-like environment (the assembly implementation is ARM64-macOS-specific; everything else is portable)
- Compilers/interpreters for whichever languages you want to benchmark
- [hyperfine](https://github.com/sharkdp/hyperfine) — optional but recommended; the runner falls back to bash's builtin `time` without it
- Python 3 with matplotlib for the visualizations

## Quick Start

```bash
# Run the benchmarks (default input value: 7).
# Prints per-language stats and writes results.csv
./run_loops.sh 7

# Chart the results
python3 -m venv venv && source venv/bin/activate
pip install matplotlib
python3 visualize_performance.py --csv results.csv

# Or let the script run the benchmarks itself
python3 visualize_performance.py 7

# Scaling analysis across several input values (fast languages only by default)
python3 visualize_performance.py --scaling 3 5 7 9 11
```

Generated files: `results.csv`, `performance_comparison.png`, `detailed_performance.png`, and (in scaling mode) `scaling_analysis.png`.

A full run including the slow interpreters (Python, Perl, Ruby, R, plain Lua) takes a long time — R alone can take the better part of an hour. Use `ONLY`/`SKIP` to control which languages run.

## Runner Options

`run_loops.sh` accepts the input value as its only argument and reads these environment variables:

| Variable | Default | Meaning |
|----------|---------|---------|
| `RUNS` | `3` | Timed runs per language |
| `WARMUP` | `1` | Untimed warmup runs per language |
| `ONLY` | _(unset)_ | Comma-separated list of languages to run, e.g. `ONLY="C,Rust,Go"` |
| `SKIP` | _(unset)_ | Comma-separated list of languages to skip |
| `RESULTS_FILE` | `results.csv` | Where to write the CSV (`language,mean_s,min_s,max_s,runs`) |

Example:

```bash
ONLY="C,C++,Rust,Go,Zig" RUNS=5 ./run_loops.sh 7
```

The input value must be between 1 and 40000. Above ~43000 the per-element sum exceeds 2³¹, so languages using 32-bit accumulators (C, Rust, Zig, JavaScript's `Int32Array`, …) would overflow while big-integer languages like Python computed different values.

## Methodology & Caveats

- Each language gets `WARMUP` untimed runs followed by `RUNS` timed runs; the CSV records mean, min, and max.
- When hyperfine is installed it does the timing (with proper statistical output); otherwise the runner uses bash's builtin `time`.
- Timings are **whole-process wall-clock times**: they include interpreter/VM startup. That's negligible for a C binary but meaningful for JVM languages (~0.1–0.4 s of JVM startup for Java/Kotlin, plus the Scala CLI launcher for Scala). Treat small differences between JVM languages accordingly.
- JIT-compiled runtimes (JVM, .NET, V8, LuaJIT) may also spend part of the measured time warming up their JIT within each process.
- Results depend on hardware, OS, compiler versions, and system load. Compare languages within one run on one machine, not across machines.

## Optimized Variants

Two deliberately non-standard implementations are included. Both still produce the correct result, but read their numbers with the caveats in mind:

### GoOptimized
Performs the **same 10⁹ operations** as the standard Go version, with two implementation-level optimizations: the outer loop is split across all CPU cores, and each element's sum accumulates in a local variable instead of array reads/writes. It demonstrates what idiomatic-but-tuned code in the same language buys you — the algorithm is unchanged.

### Bash (via C)
Pure Bash is hopeless for this workload, so `bashOptimized/loop.sh` openly cheats: it compiles the project's own `c/loop.c` with `gcc -O3` and runs that. Its number mostly measures gcc's compile time plus the C runtime — it's included as a joke with a footnote, not as a Bash result.

## JIT Compilation

Several implementations run on JIT-compiling runtimes:

- **LuaJIT**: the same `lua/loop.lua` source, run under LuaJIT instead of the Lua interpreter
- **JavaScript / TypeScript**: V8's optimizing JIT via Node
- **Java / Kotlin / Scala**: HotSpot JVM with adaptive JIT
- **C#**: .NET runtime JIT

JIT compilation improves hot-loop performance dramatically, but introduces warm-up cost inside each measured process — part of why interpreted-with-JIT languages land between the AOT-compiled and purely interpreted groups.

## Project Structure

- `run_loops.sh` — compiles whatever toolchains are available, times each implementation, writes `results.csv`
- `visualize_performance.py` — turns `results.csv` into charts; can also drive the runner (including scaling sweeps)
- One directory per language (`c/`, `python/`, `rust/`, …) containing a single `loop.*` implementation
- `goOptimized/`, `bashOptimized/` — the two non-standard variants described above
- `bash/` — the pure-Bash implementation, disabled by default

Build artifacts (binaries, jars, `.class` files, `csharp/bin`, `rust/target`, …) are gitignored.

## Contributing

Feel free to contribute by:
1. Adding implementations in new languages — keep the array read/write inside the inner loop so the comparison stays fair
2. Adding interesting runtime variants (PyPy, Bun, Deno, GraalVM, …)
3. Improving the visualization capabilities
4. Improving documentation

## License

This project is open source and available under the MIT License.
