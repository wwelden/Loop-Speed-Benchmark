#!/usr/bin/env python3

import argparse
import os
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('Agg')  # Use non-interactive backend

def parse_args():
    parser = argparse.ArgumentParser(description='Visualize benchmark results')
    parser.add_argument('--results', type=str, required=True, help='Path to results CSV file')
    parser.add_argument('--output', type=str, default='visualization.html', help='Output HTML file')
    return parser.parse_args()

def main():
    args = parse_args()

    # Read results
    try:
        df = pd.read_csv(args.results)
    except Exception as e:
        print(f"Error reading results file: {e}")
        return

    # Check if we have combined or individual results
    has_algorithm = 'algorithm' in df.columns

    # Set up the figure
    plt.figure(figsize=(12, 8))

    if has_algorithm:
        # Combined results
        pivot_df = df.pivot(index='language', columns='algorithm', values='average_time').reset_index()

        # Bar chart
        ax = plt.subplot(111)
        bar_width = 0.35
        x = range(len(pivot_df))

        if 'merge_sort' in pivot_df.columns:
            bars1 = ax.bar([i - bar_width/2 for i in x], pivot_df['merge_sort'],
                          bar_width, label='Merge Sort')

        if 'binary_search' in pivot_df.columns:
            bars2 = ax.bar([i + bar_width/2 for i in x], pivot_df['binary_search'],
                          bar_width, label='Binary Search')

        ax.set_xlabel('Language')
        ax.set_ylabel('Average Time (seconds)')
        ax.set_title('Benchmark Results by Language and Algorithm')
        ax.set_xticks(x)
        ax.set_xticklabels(pivot_df['language'], rotation=45, ha='right')
        ax.legend()
    else:
        # Single algorithm results
        df = df.sort_values('average_time' if 'average_time' in df.columns else 'time_seconds')

        ax = plt.subplot(111)
        bars = ax.bar(df['language'], df['average_time'] if 'average_time' in df.columns else df['time_seconds'])

        ax.set_xlabel('Language')
        ax.set_ylabel('Average Time (seconds)')
        ax.set_title('Benchmark Results by Language')
        plt.xticks(rotation=45, ha='right')

    plt.tight_layout()

    # Save the figure
    plt.savefig(args.output.replace('.html', '.png'))

    # Generate HTML
    html = f"""<!DOCTYPE html>
<html>
<head>
    <title>PL-Benchmark Results</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        h1 {{ color: #333; }}
        img {{ max-width: 100%; }}
        table {{ border-collapse: collapse; width: 100%; margin-top: 20px; }}
        th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
        th {{ background-color: #f2f2f2; }}
        tr:nth-child(even) {{ background-color: #f9f9f9; }}
    </style>
</head>
<body>
    <h1>PL-Benchmark Results</h1>

    <h2>Visualization</h2>
    <img src="{os.path.basename(args.output).replace('.html', '.png')}" alt="Benchmark Results">

    <h2>Data</h2>
    <table>
        <tr>
"""

    # Add table headers
    for col in df.columns:
        html += f"<th>{col}</th>"

    html += "</tr>"

    # Add table rows
    for _, row in df.iterrows():
        html += "<tr>"
        for col in df.columns:
            value = row[col]
            if isinstance(value, float):
                html += f"<td>{value:.6f}</td>"
            else:
                html += f"<td>{value}</td>"
        html += "</tr>"

    html += """
    </table>
</body>
</html>
"""

    # Write HTML file
    with open(args.output, 'w') as f:
        f.write(html)

    print(f"Visualization saved to {args.output}")
    print(f"Chart image saved to {args.output.replace('.html', '.png')}")

if __name__ == "__main__":
    main()
