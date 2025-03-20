#!/usr/bin/env python3

import argparse
import os
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('Agg')  # Use non-interactive backend

def parse_args():
    parser = argparse.ArgumentParser(description='Visualize benchmark results')
    parser.add_argument('--results', type=str, required=True, help='Path to the benchmark results CSV file')
    parser.add_argument('--output', type=str, default='benchmark_visualization.html', help='Output HTML file path')
    return parser.parse_args()

def generate_visualization(results_file, output_file):
    # Read the benchmark results
    df = pd.read_csv(results_file)

    # Calculate average time per language
    avg_times = df.groupby('language')['time_seconds'].mean().reset_index()
    avg_times = avg_times.sort_values('time_seconds')

    # Create the visualization
    plt.figure(figsize=(12, 8))

    # Bar chart
    ax1 = plt.subplot(2, 1, 1)
    bars = ax1.bar(avg_times['language'], avg_times['time_seconds'], color='skyblue')
    ax1.set_title('Average Execution Time by Language', fontsize=16)
    ax1.set_xlabel('Language', fontsize=12)
    ax1.set_ylabel('Time (seconds)', fontsize=12)
    ax1.set_xticklabels(avg_times['language'], rotation=45, ha='right')

    # Add values on top of bars
    for bar in bars:
        height = bar.get_height()
        ax1.text(bar.get_x() + bar.get_width()/2., height + 0.001,
                f'{height:.6f}', ha='center', va='bottom', fontsize=8)

    # Box plot
    ax2 = plt.subplot(2, 1, 2)
    languages = sorted(df['language'].unique())
    data = [df[df['language'] == lang]['time_seconds'] for lang in languages]

    box = ax2.boxplot(data, patch_artist=True, labels=languages)

    # Set colors for boxplots
    colors = plt.cm.viridis(range(0, 256, 256 // len(languages)))
    for patch, color in zip(box['boxes'], colors):
        patch.set_facecolor(color)

    ax2.set_title('Distribution of Execution Times', fontsize=16)
    ax2.set_xlabel('Language', fontsize=12)
    ax2.set_ylabel('Time (seconds)', fontsize=12)
    ax2.set_xticklabels(languages, rotation=45, ha='right')

    plt.tight_layout()
    plt.savefig(os.path.splitext(output_file)[0] + '.png', dpi=300)

    # Generate HTML report
    html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>PL-Benchmark Results</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 0; padding: 20px; line-height: 1.6; }}
            h1, h2 {{ color: #333; }}
            table {{ border-collapse: collapse; width: 100%; margin-bottom: 20px; }}
            th, td {{ text-align: left; padding: 12px; }}
            th {{ background-color: #f2f2f2; }}
            tr:nth-child(even) {{ background-color: #f9f9f9; }}
            tr:hover {{ background-color: #e9e9e9; }}
            .chart-container {{ margin: 20px 0; }}
            .summary {{ margin: 20px 0; padding: 15px; background-color: #f5f5f5; border-left: 5px solid #4CAF50; }}
        </style>
    </head>
    <body>
        <h1>PL-Benchmark Results</h1>

        <div class="summary">
            <h2>Summary</h2>
            <p>Total languages benchmarked: {len(avg_times)}</p>
            <p>Fastest language: {avg_times.iloc[0]['language']} ({avg_times.iloc[0]['time_seconds']:.6f} seconds)</p>
            <p>Slowest language: {avg_times.iloc[-1]['language']} ({avg_times.iloc[-1]['time_seconds']:.6f} seconds)</p>
            <p>Speed difference: {avg_times.iloc[-1]['time_seconds']/avg_times.iloc[0]['time_seconds']:.2f}x</p>
        </div>

        <h2>Visualization</h2>
        <div class="chart-container">
            <img src="{os.path.splitext(os.path.basename(output_file))[0] + '.png'}" alt="Benchmark Results" style="width: 100%;" />
        </div>

        <h2>Detailed Results</h2>
        <table>
            <tr>
                <th>Rank</th>
                <th>Language</th>
                <th>Average Time (seconds)</th>
                <th>Relative Performance</th>
            </tr>
    """

    # Add rows for each language
    for i, (index, row) in enumerate(avg_times.iterrows()):
        relative_perf = row['time_seconds'] / avg_times.iloc[0]['time_seconds']
        html_content += f"""
            <tr>
                <td>{i+1}</td>
                <td>{row['language']}</td>
                <td>{row['time_seconds']:.6f}</td>
                <td>{relative_perf:.2f}x</td>
            </tr>
        """

    html_content += """
        </table>

        <h2>All Runs</h2>
        <table>
            <tr>
                <th>Language</th>
                <th>Run</th>
                <th>Time (seconds)</th>
            </tr>
    """

    # Add rows for each run
    for index, row in df.iterrows():
        html_content += f"""
            <tr>
                <td>{row['language']}</td>
                <td>{row['run']}</td>
                <td>{row['time_seconds']:.6f}</td>
            </tr>
        """

    html_content += """
        </table>

        <footer>
            <p>Generated by PL-Benchmark visualization tool</p>
        </footer>
    </body>
    </html>
    """

    # Write HTML to file
    with open(output_file, 'w') as f:
        f.write(html_content)

    print(f"Visualization saved to: {output_file}")
    print(f"Image saved to: {os.path.splitext(output_file)[0] + '.png'}")

def main():
    args = parse_args()
    generate_visualization(args.results, args.output)

if __name__ == "__main__":
    main()
