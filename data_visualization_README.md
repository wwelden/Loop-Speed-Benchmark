# Loop Speed Data Visualization

This tool visualizes the performance results of various programming languages from the LoopSpeed benchmark suite.

## Requirements

- Python 3.6+
- matplotlib
- numpy

## Installation

Install the required Python packages:

```bash
pip install matplotlib numpy
```

## Usage

### Basic Usage

Run the visualization script with a single input value:

```bash
python visualize_performance.py [input_value]
```

Where `[input_value]` is an optional parameter to set the input value for the loop benchmarks (default is 7).

### Scaling Analysis

To analyze how different languages scale with different input values:

```bash
python visualize_performance.py --scaling [input_values...]
```

For example:
```bash
python visualize_performance.py --scaling 3 5 7 9 11
```

If no input values are provided, the default values `[3, 5, 7, 9, 11]` will be used.

## Visualization Types

The script creates several types of visualizations:

1. **Simple Bar Chart** (`performance_comparison.png`):
   - Shows execution times for all languages sorted from fastest to slowest

2. **Detailed Categorized Chart** (`detailed_performance.png`):
   - Groups languages by category (compiled, JVM-based, scripting, etc.)
   - Uses separate subplots for each category
   - May use logarithmic scale for categories with large performance differences

3. **Scaling Analysis** (`scaling_analysis.png`):
   - Shows how execution time changes as input values increase
   - Helps identify which languages scale better with larger inputs
   - By default, only tests a subset of languages to save time

## Interpreting the Results

- In the bar charts, shorter bars indicate better performance (faster execution)
- In the scaling analysis, flatter lines indicate better scaling (less affected by input size)
- Logarithmic scales may be used when there are large differences between languages

## Customization

You can modify the `visualize_performance.py` script to:
- Change output file names or formats
- Adjust the categorization of languages
- Customize colors, labels, or plot styles
- Change which languages are included in the scaling analysis

## Example Commands

```bash
# Run with default input value (7)
python visualize_performance.py

# Run with custom input value
python visualize_performance.py 10

# Run scaling analysis with default input values
python visualize_performance.py --scaling

# Run scaling analysis with custom input values
python visualize_performance.py --scaling 2 4 6 8 10
```

## Notes

- The script automatically handles time format parsing (e.g., "0m1.234s" or "1.234s")
- If a language benchmark fails to run, it will not appear in the visualization
- The scaling analysis introduces short delays between runs to avoid overwhelming the system
