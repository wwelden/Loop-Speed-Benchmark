#!/usr/bin/env python3
"""Visualize LoopSpeed benchmark results.

run_loops.sh writes per-language timings to results.csv; this script turns
that CSV into charts.

Usage:
    python3 visualize_performance.py [input]          # run benchmarks, then chart
    python3 visualize_performance.py --csv results.csv  # chart an existing CSV
    python3 visualize_performance.py --scaling 3 5 7 9 11  # scaling line chart

The runner's environment variables (RUNS, WARMUP, ONLY, SKIP) pass straight
through, e.g.:  ONLY="C,Rust,Go" python3 visualize_performance.py 7
"""

import argparse
import csv
import os
import subprocess
import sys

try:
    import matplotlib

    matplotlib.use("Agg")  # render to files; no GUI needed
    import matplotlib.pyplot as plt
except ImportError:
    sys.exit("matplotlib is required: pip install matplotlib")

RESULTS_FILE = "results.csv"

CATEGORIES = {
    "Assembly": "Compiled",
    "C": "Compiled",
    "C++": "Compiled",
    "Zig": "Compiled",
    "Rust": "Compiled",
    "Go": "Compiled",
    "GoOptimized": "Compiled",
    "Swift": "Compiled",
    "Haskell": "Compiled",
    "C#": "VM / JIT",
    "Java": "VM / JIT",
    "Kotlin": "VM / JIT",
    "Scala": "VM / JIT",
    "JavaScript": "VM / JIT",
    "TypeScript": "VM / JIT",
    "LuaJIT": "VM / JIT",
    "Python": "Interpreted",
    "Perl": "Interpreted",
    "PHP": "Interpreted",
    "Ruby": "Interpreted",
    "R": "Interpreted",
    "Lua": "Interpreted",
    "Bash": "Interpreted",
}


def read_results(path):
    """Read the runner's CSV into a list of dicts sorted by mean time."""
    if not os.path.exists(path):
        sys.exit(f"No results file at '{path}'. Run ./run_loops.sh first or pass --csv.")
    rows = []
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            try:
                rows.append(
                    {
                        "lang": row["language"],
                        "mean": float(row["mean_s"]),
                        "min": float(row["min_s"]),
                        "max": float(row["max_s"]),
                    }
                )
            except (KeyError, ValueError):
                continue  # skip malformed lines
    if not rows:
        sys.exit(f"'{path}' contains no results.")
    rows.sort(key=lambda r: r["mean"])
    return rows


def run_benchmarks(input_val, extra_env=None):
    """Run run_loops.sh and return the parsed results."""
    env = dict(os.environ)
    if extra_env:
        env.update(extra_env)
    results_file = env.get("RESULTS_FILE", RESULTS_FILE)
    proc = subprocess.run(["bash", "run_loops.sh", str(input_val)], env=env)
    if proc.returncode != 0:
        sys.exit(f"run_loops.sh failed with exit code {proc.returncode}")
    return read_results(results_file)


def bar_chart(rows, output_file="performance_comparison.png"):
    """Horizontal bar chart of mean times with min/max error bars."""
    langs = [r["lang"] for r in rows]
    means = [r["mean"] for r in rows]
    err_lo = [r["mean"] - r["min"] for r in rows]
    err_hi = [r["max"] - r["mean"] for r in rows]

    fig_height = max(4, 0.4 * len(rows) + 2)
    plt.figure(figsize=(12, fig_height))
    plt.barh(langs, means, xerr=[err_lo, err_hi], color="skyblue", capsize=3)
    for i, r in enumerate(rows):
        plt.text(r["max"] + max(means) * 0.01, i, f'{r["mean"]:.3f}s', va="center")
    plt.gca().invert_yaxis()  # fastest on top
    plt.xlabel("Execution time (seconds, mean with min/max range)")
    plt.title("Loop Performance Comparison Across Languages")
    plt.tight_layout()
    plt.savefig(output_file, dpi=150)
    plt.close()
    print(f"Saved {output_file}")


def detailed_chart(rows, output_file="detailed_performance.png"):
    """Per-category bar charts, log-scaled when the spread is large."""
    by_category = {}
    for r in rows:
        category = CATEGORIES.get(r["lang"].split(" (")[0], "Other")
        by_category.setdefault(category, []).append(r)

    order = [c for c in ["Compiled", "VM / JIT", "Interpreted", "Other"] if c in by_category]
    fig, axes = plt.subplots(len(order), 1, figsize=(12, 3.2 * len(order)), squeeze=False)

    for ax, category in zip((a for row in axes for a in row), order):
        cat_rows = by_category[category]
        langs = [r["lang"] for r in cat_rows]
        means = [r["mean"] for r in cat_rows]
        ax.barh(langs, means, color="steelblue", alpha=0.8)
        for i, r in enumerate(cat_rows):
            ax.text(r["mean"] * 1.02, i, f'{r["mean"]:.3f}s', va="center", fontsize=8)
        ax.invert_yaxis()
        ax.set_title(f"{category} ({len(cat_rows)})")
        if means and max(means) / max(min(means), 1e-9) > 100:
            ax.set_xscale("log")
            ax.set_xlabel("Execution time (seconds, log scale)")
        else:
            ax.set_xlabel("Execution time (seconds)")

    fig.suptitle("Performance by Language Category", fontsize=14)
    fig.tight_layout(rect=[0, 0, 1, 0.97])
    fig.savefig(output_file, dpi=150)
    plt.close(fig)
    print(f"Saved {output_file}")


def scaling_chart(input_values, output_file="scaling_analysis.png"):
    """Run the benchmarks at several input values and plot time vs input."""
    # Unless the caller filters languages themselves, stick to the fast ones:
    # a full scaling sweep through the slow interpreters takes hours.
    extra_env = {}
    if not os.environ.get("ONLY") and not os.environ.get("SKIP"):
        extra_env["ONLY"] = "C,C++,Rust,Go,Zig,Swift,JavaScript"
        print(f'No ONLY/SKIP set; defaulting to ONLY={extra_env["ONLY"]}')

    series = {}
    for val in input_values:
        print(f"\n=== Benchmarking with input {val} ===")
        for r in run_benchmarks(val, extra_env):
            series.setdefault(r["lang"], []).append((val, r["mean"]))

    complete = {k: v for k, v in series.items() if len(v) == len(input_values)}
    if not complete:
        sys.exit("No language produced results for every input value.")

    plt.figure(figsize=(12, 7))
    for lang in sorted(complete, key=lambda k: sum(t for _, t in complete[k])):
        xs, ys = zip(*complete[lang])
        plt.plot(xs, ys, "o-", label=lang)
    plt.xlabel("Input value (u)")
    plt.ylabel("Execution time (seconds, mean)")
    plt.title("Performance Scaling by Input Value")
    plt.grid(True, linestyle="--", alpha=0.6)
    plt.legend(fontsize="small", ncol=2 if len(complete) > 10 else 1)
    plt.tight_layout()
    plt.savefig(output_file, dpi=150)
    plt.close()
    print(f"\nSaved {output_file}")


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("input", nargs="?", type=int, default=7, help="benchmark input value (default 7)")
    parser.add_argument("--csv", metavar="FILE", help="chart an existing results CSV without running benchmarks")
    parser.add_argument("--scaling", nargs="+", type=int, metavar="N", help="run at several input values and plot scaling")
    args = parser.parse_args()

    if args.scaling:
        scaling_chart(args.scaling)
        return

    if args.csv:
        rows = read_results(args.csv)
    else:
        rows = run_benchmarks(args.input)

    print("\nResults (fastest first):")
    for r in rows:
        print(f'  {r["lang"]:<14} {r["mean"]:.3f}s')

    bar_chart(rows)
    detailed_chart(rows)


if __name__ == "__main__":
    main()
