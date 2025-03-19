#!/usr/bin/env Rscript

# Binary search implementation in R
# Time complexity: O(log n)
# Space complexity: O(1)
#
# @param arr The sorted array to search in
# @param target The value to find
# @return The index of the target if found, -1 otherwise
binary_search <- function(arr, target) {
    left <- 1
    right <- length(arr)

    while (left <= right) {
        mid <- left + floor((right - left) / 2)
        if (arr[mid] == target) {
            return(mid)
        } else if (arr[mid] < target) {
            left <- mid + 1
        } else {
            right <- mid - 1
        }
    }
    return(-1)
}

# Check if file path is provided
args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop("Please provide a file path as an argument")
}

# Read numbers from file
numbers <- as.numeric(readLines(args[1]))
target <- 42  # Example target value

# Perform binary search
result <- binary_search(numbers, target)
if (result != -1) {
    cat(sprintf("Found %d at index %d\n", target, result))
} else {
    cat(sprintf("%d not found in the array\n", target))
}
