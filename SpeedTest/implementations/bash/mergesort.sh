#!/bin/bash

# Function to merge two sorted arrays
merge() {
    local left=($1)
    local right=($2)
    local result=()
    local i=0
    local j=0

    while [ $i -lt ${#left[@]} ] && [ $j -lt ${#right[@]} ]; do
        if [ ${left[$i]} -le ${right[$j]} ]; then
            result+=("${left[$i]}")
            ((i++))
        else
            result+=("${right[$j]}")
            ((j++))
        fi
    done

    while [ $i -lt ${#left[@]} ]; do
        result+=("${left[$i]}")
        ((i++))
    done

    while [ $j -lt ${#right[@]} ]; do
        result+=("${right[$j]}")
        ((j++))
    done

    echo "${result[@]}"
}

# Function to perform merge sort
mergeSort() {
    local arr=($1)
    local len=${#arr[@]}

    if [ $len -le 1 ]; then
        echo "${arr[@]}"
        return
    fi

    local mid=$((len / 2))
    local left=()
    local right=()

    for ((i=0; i<mid; i++)); do
        left+=("${arr[$i]}")
    done

    for ((i=mid; i<len; i++)); do
        right+=("${arr[$i]}")
    done

    left=($(mergeSort "${left[*]}"))
    right=($(mergeSort "${right[*]}"))

    echo $(merge "${left[*]}" "${right[*]}")
}

# Function to generate random array
generateRandomArray() {
    local size=$1
    local arr=()
    for ((i=0; i<size; i++)); do
        arr[$i]=$((RANDOM % 10000))
    done
    echo "${arr[@]}"
}

# Main program
ARRAY_SIZE=1000
ITERATIONS=100

for ((iter=0; iter<ITERATIONS; iter++)); do
    # Generate random array
    arr=()
    for ((i=0; i<ARRAY_SIZE; i++)); do
        arr+=($((RANDOM % 1000)))
    done

    # Sort array
    sorted=($(mergeSort "${arr[*]}"))
done
