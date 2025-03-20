#!/usr/bin/env python3

"""
Script to visualize benchmark results.
Generates bar charts and tables comparing language performance.
"""

import sys
import os
import csv
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from datetime import datetime

def read_results(csv_file):
    """Read benchmark results from CSV file."""
    try:
        df = pd.read_csv(csv_file)
        return df
    except Exception as e:
        print(f"Error reading CSV file: {e}")
        sys.exit(1)

def create_bar_chart(df, algorithm, output_dir):
    """Create a bar chart comparing language performance for a given algorithm."""
    # Filter data for the specific algorithm
    algo_df = df[df['algorithm'] == algorithm].sort_values('avg_time')

    # Create the figure
    plt.figure(figsize=(12, 8))
    bars = plt.barh(algo_df['language'], algo_df['avg_time'], color='skyblue')

    # Add labels and title
    plt.xlabel('Average Time (seconds)')
    plt.ylabel('Programming Language')
    plt.title(f'{algorithm.replace("_", " ").title()} - Performance Comparison')

    # Add values on bars
    for bar in bars:
        width = bar.get_width()
        plt.text(width + 0.0002, bar.get_y() + bar.get_height()/2,
                f'{width:.6f}s', ha='left', va='center')

    # Adjust layout and save
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, f'{algorithm}_comparison.png'))
    plt.close()

def create_comparison_table(df, output_dir):
    """Create a comparison table for all algorithms."""
    # Pivot the dataframe to get languages as rows and algorithms as columns
    pivot_df = df.pivot(index='language', columns='algorithm', values='avg_time')

    # Fill NaN values with '-'
    pivot_df = pivot_df.fillna('-')

    # Sort by the first algorithm column (alphabetically)
    first_algo = sorted(pivot_df.columns)[0]
    pivot_df = pivot_df.sort_values(by=[first_algo])

    # Save as CSV
    pivot_df.to_csv(os.path.join(output_dir, 'comparison_table.csv'))

    # Also create an HTML table for easy viewing
    html = """
    <html>
    <head>
        <style>
            table { border-collapse: collapse; width: 100%; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: right; }
            th { background-color: #f2f2f2; }
            tr:nth-child(even) { background-color: #f9f9f9; }
            tr:hover { background-color: #f2f2f2; }
            .language { text-align: left; font-weight: bold; }
        </style>
    </head>
    <body>
        <h1>Programming Language Benchmark Comparison</h1>
        <p>Generated on: {}</p>
        <table>
    """.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

    # Add headers
    html += "<tr><th class='language'>Language</th>"
    for col in pivot_df.columns:
        html += f"<th>{col.replace('_', ' ').title()}</th>"
    html += "</tr>"

    # Add data rows
    for idx, row in pivot_df.iterrows():
        html += f"<tr><td class='language'>{idx}</td>"
        for col in pivot_df.columns:
            if row[col] == '-':
                html += f"<td>-</td>"
            else:
                html += f"<td>{row[col]:.6f}s</td>"
        html += "</tr>"

    html += """
        </table>
    </body>
    </html>
    """

    with open(os.path.join(output_dir, 'comparison_table.html'), 'w') as f:
        f.write(html)

def main():
    if len(sys.argv) < 2:
        print("Usage: python visualize_results.py <results_csv_file>")
        sys.exit(1)

    csv_file = sys.argv[1]
    output_dir = os.path.dirname(csv_file)

    print(f"Reading results from {csv_file}...")
    df = read_results(csv_file)

    # Get unique algorithms
    algorithms = df['algorithm'].unique()

    # Create a bar chart for each algorithm
    for algorithm in algorithms:
        print(f"Creating bar chart for {algorithm}...")
        create_bar_chart(df, algorithm, output_dir)

    # Create a comparison table
    print("Creating comparison table...")
    create_comparison_table(df, output_dir)

    print(f"Visualizations saved to {output_dir}")

if __name__ == "__main__":
    main()
