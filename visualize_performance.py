#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import subprocess
import re
import os
import sys
from collections import defaultdict
import time

def parse_time(time_str):
    """Convert time string (e.g. '0m1.234s') to seconds (float)"""
    # Pattern matches minutes and seconds format like '0m1.234s'
    match = re.match(r'(\d+)m([\d.]+)s', time_str)
    if match:
        minutes, seconds = match.groups()
        return int(minutes) * 60 + float(seconds)
    # Try to parse as direct seconds
    try:
        return float(time_str.rstrip('s'))
    except ValueError:
        return None

def run_benchmarks(input_val=7, exclude_langs=None):
    """Run the benchmark script and parse results"""
    if exclude_langs is None:
        exclude_langs = []  # Include all languages by default

    results = {}

    try:
        output = subprocess.check_output(
            [f"bash run_loops.sh {input_val}"],
            shell=True,
            stderr=subprocess.STDOUT,
            universal_newlines=True
        )

        # Parse the output looking for language: time pairs
        for line in output.splitlines():
            match = re.match(r'(.+?):\s+([\d.]+m[\d.]+s|[\d.]+s)', line.strip())
            if match:
                lang, time_str = match.groups()
                lang = lang.strip()
                # Skip excluded languages
                if any(excluded in lang for excluded in exclude_langs):
                    continue
                seconds = parse_time(time_str)
                if seconds is not None:
                    results[lang] = seconds
    except subprocess.CalledProcessError as e:
        print(f"Error running benchmarks: {e}")
        print(e.output)

    return results

def visualize_results(results, output_file='performance_comparison.png'):
    """Create a bar chart of performance results"""
    if not results:
        print("No results to visualize")
        return

    # Sort by execution time (ascending)
    sorted_results = dict(sorted(results.items(), key=lambda x: x[1]))

    languages = list(sorted_results.keys())
    times = list(sorted_results.values())

    # Create figure with specified size
    plt.figure(figsize=(12, 8))

    # Create horizontal bar chart
    bars = plt.barh(languages, times, color='skyblue')

    # Add values to the end of each bar
    for i, (lang, time) in enumerate(sorted_results.items()):
        plt.text(time + 0.01, i, f'{time:.3f}s', va='center')

    # Add labels and title
    plt.xlabel('Execution Time (seconds)')
    plt.ylabel('Programming Language')
    plt.title('Loop Performance Comparison Across Languages')

    # Adjust layout and set tight layout
    plt.tight_layout()

    # Save the figure
    plt.savefig(output_file)
    print(f"Visualization saved to {output_file}")

    # Show the plot if running interactively
    plt.show()

def create_detailed_visualization(results, output_file='detailed_performance.png'):
    """Create a more detailed visualization with logarithmic scale and categories"""
    if not results:
        print("No results to visualize")
        return

    # Categorize languages (very rough categorization)
    categories = defaultdict(list)

    compiled_langs = ['C', 'C++', 'Rust', 'Go', 'Zig', 'Assembly']
    jvm_langs = ['Java', 'Kotlin', 'Scala']
    scripting_langs = ['Python', 'JavaScript', 'Ruby', 'PHP', 'Perl', 'Bash', 'R']  # Added Bash back

    for lang, time in results.items():
        if any(compiled in lang for compiled in compiled_langs):
            categories['Compiled'].append((lang, time))
        elif any(jvm in lang for jvm in jvm_langs):
            categories['JVM-based'].append((lang, time))
        elif 'Script' in lang or any(script in lang for script in scripting_langs):
            categories['Scripting'].append((lang, time))
        else:
            categories['Other'].append((lang, time))

    # Create subplots for each category
    fig, axs = plt.subplots(len(categories), 1, figsize=(14, 10), sharex=True)

    # Use logarithmic scale to better show differences
    for i, (category, langs) in enumerate(categories.items()):
        if langs:
            # Sort by execution time
            langs.sort(key=lambda x: x[1])

            # Plot bars for this category
            ax = axs[i] if len(categories) > 1 else axs
            names = [lang[0] for lang in langs]
            times = [lang[1] for lang in langs]

            bars = ax.barh(names, times, color=plt.cm.tab10(i/len(categories)), alpha=0.7)

            # Add values to bars
            for j, time in enumerate(times):
                ax.text(time + 0.01, j, f'{time:.3f}s', va='center')

            ax.set_title(f'{category} Languages')
            ax.set_ylabel('Language')

            # Use logarithmic scale if there are large differences
            if max(times) / (min(times) or 1) > 100:
                ax.set_xscale('log')
                ax.set_xlabel('Execution Time (seconds, log scale)')
            else:
                ax.set_xlabel('Execution Time (seconds)')

    plt.suptitle('Detailed Performance Comparison by Language Category', fontsize=16)
    plt.tight_layout(rect=[0, 0, 1, 0.96])  # Adjust for the super title

    # Save the figure
    plt.savefig(output_file)
    print(f"Detailed visualization saved to {output_file}")

    # Show the plot if running interactively
    plt.show()

def analyze_scaling(input_values=None, languages_to_test=None, exclude_langs=None, output_file='scaling_analysis.png'):
    """Run benchmarks with different input values to analyze scaling behavior"""
    if input_values is None:
        input_values = [3, 5, 7, 9, 11]  # Default input values

    if exclude_langs is None:
        exclude_langs = []  # Include all languages by default

    all_results = {}

    print(f"Running scaling analysis with input values: {input_values}")

    for input_val in input_values:
        print(f"\nTesting with input value: {input_val}")
        results = run_benchmarks(input_val, exclude_langs)

        # Filter for specified languages if provided
        if languages_to_test:
            results = {lang: time for lang, time in results.items() if any(l in lang for l in languages_to_test)}

        for lang, time_val in results.items():
            if lang not in all_results:
                all_results[lang] = []
            all_results[lang].append((input_val, time_val))

        # Short delay to avoid overwhelming the system
        time.sleep(1)

    # Filter out languages that don't have data for all input values
    complete_results = {lang: times for lang, times in all_results.items()
                       if len(times) == len(input_values)}

    # Create visualization
    plt.figure(figsize=(14, 8))

    # Use a different color for each language
    colors = plt.cm.tab10.colors + plt.cm.tab20.colors

    # Sort languages by average execution time (ascending)
    sorted_langs = sorted(complete_results.keys(),
                          key=lambda lang: sum(t for _, t in complete_results[lang]) / len(complete_results[lang]))

    # Plot each language's scaling behavior
    for i, lang in enumerate(sorted_langs):
        x_vals = [x for x, _ in complete_results[lang]]
        y_vals = [y for _, y in complete_results[lang]]
        plt.plot(x_vals, y_vals, 'o-', label=lang, color=colors[i % len(colors)])

    # Add labels and legend
    plt.xlabel('Input Value')
    plt.ylabel('Execution Time (seconds)')
    plt.title('Performance Scaling Analysis by Input Value')
    plt.grid(True, linestyle='--', alpha=0.7)

    # Add legend with smaller font size and multiple columns if many languages
    if len(complete_results) > 10:
        plt.legend(fontsize='small', ncol=2)
    else:
        plt.legend()

    # Save the figure
    plt.tight_layout()
    plt.savefig(output_file)
    print(f"Scaling analysis saved to {output_file}")

    # Show the plot if running interactively
    plt.show()

    return complete_results

def main():
    # No excluded languages by default
    exclude_langs = []

    # Check for command line arguments
    if len(sys.argv) > 1:
        if sys.argv[1] == '--scaling':
            # Scaling analysis mode
            input_values = [int(x) for x in sys.argv[2:]] if len(sys.argv) > 2 else None
            # Use only the fastest languages to save time, but include Bash for comparison
            fast_languages = ['C', 'Rust', 'Go', 'Zig', 'Python', 'JavaScript', 'Bash']
            analyze_scaling(input_values, fast_languages, exclude_langs)
            return
        else:
            # Single benchmark mode with specified input
            input_val = int(sys.argv[1])
    else:
        # Default input value
        input_val = 7

    print(f"Running benchmarks with input value: {input_val}")
    results = run_benchmarks(input_val, exclude_langs)

    if results:
        print("\nResults:")
        for lang, time in sorted(results.items(), key=lambda x: x[1]):
            print(f"{lang}: {time:.3f}s")

        # Create visualizations
        visualize_results(results)
        create_detailed_visualization(results)
    else:
        print("No results to display")

if __name__ == "__main__":
    main()
