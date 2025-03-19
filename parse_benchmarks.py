import sys
import re

def parse_and_sort(filename):
    results = []

    # Read benchmark results
    with open(filename, "r") as file:
        language = None
        real_time = None

        for line in file:
            line = line.strip()

            # Match language names
            if line.startswith("Running"):
                language = line.replace("Running ", "").replace("...", "")

            # Match real time
            real_match = re.match(r"real (\d+\.\d+)", line)
            if real_match:
                real_time = float(real_match.group(1))
                if language is not None:
                    results.append((real_time, language))
                    language, real_time = None, None  # Reset for next entry

    # Sort results by real time (ascending order)
    results.sort()

    # Print formatted output
    print(f"{'Rank':<5} {'Language':<15} {'Time (s)':<10}")
    print("=" * 35)
    for rank, (time, language) in enumerate(results, start=1):
        print(f"{rank:<5} {language:<15} {time:<10.3f}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 parse_benchmarks.py benchmark_results.txt")
        sys.exit(1)

    parse_and_sort(sys.argv[1])
