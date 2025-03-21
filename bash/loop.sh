#!/bin/bash

# Input validation
if [ $# -ne 1 ]; then
    echo "Please provide a number as command line argument" >&2
    exit 1
fi

# Check if input is a valid number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Please provide a valid integer" >&2
    exit 1
fi

# Check for zero input
if [ "$1" -eq 0 ]; then
    echo "Please provide a non-zero integer" >&2
    exit 1
fi

input=$1

# Better random number generation with improved seeding
RANDOM=$(date +%N | sed 's/^0*//')
r=$((RANDOM % 10000))

# Create array (10k elements)
declare -a a
for ((i=0; i<10000; i++)); do
    a[$i]=0
done

# Main computation loop - full 10k outer loops and 100k inner loops
echo "Computing, please wait..." >&2
for ((i=0; i<10000; i++)); do
    # Print progress every 1000 iterations
    if (( i % 1000 == 0 )); then
        echo "Progress: $i/10000" >&2
    fi

    sum=0
    # Pre-calculate some values to reduce computation in inner loop
    input_m=$input

    # Unroll the inner loop by factor of 100 to speed up calculation
    for ((j=0; j<100000; j+=100)); do
        # Process 100 iterations at once
        for ((k=0; k<100; k++)); do
            current_j=$((j + k))
            sum=$((sum + (current_j % input_m)))
        done
    done

    a[$i]=$((sum + r))
done

echo "${a[$r]}"
