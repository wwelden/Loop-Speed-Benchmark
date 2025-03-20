#!/usr/bin/env Rscript

# Merge sort implementation in R
# Time complexity: O(n log n)
# Space complexity: O(n)
#
# @param arr The array to sort
# @return The sorted array
merge_sort <- function(arr) {
    if (length(arr) <= 1) {
        return(arr)
    }

    # Split array into two halves
    mid <- floor(length(arr) / 2)
    left <- arr[1:mid]
    right <- arr[(mid + 1):length(arr)]

    # Recursively sort both halves
    left <- merge_sort(left)
    right <- merge_sort(right)

    # Merge the sorted halves
    return(merge_arrays(left, right))
}

# Helper function to merge two sorted arrays
# @param left First sorted array
# @param right Second sorted array
# @return Merged sorted array
merge_arrays <- function(left, right) {
    result <- numeric(length(left) + length(right))
    i <- 1
    j <- 1
    k <- 1

    while (i <= length(left) && j <= length(right)) {
        if (left[i] <= right[j]) {
            result[k] <- left[i]
            i <- i + 1
        } else {
            result[k] <- right[j]
            j <- j + 1
        }
        k <- k + 1
    }

    # Copy remaining elements from left array
    while (i <= length(left)) {
        result[k] <- left[i]
        i <- i + 1
        k <- k + 1
    }

    # Copy remaining elements from right array
    while (j <= length(right)) {
        result[k] <- right[j]
        j <- j + 1
        k <- k + 1
    }

    return(result)
}

# Check if file path is provided
args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop("Please provide a file path as an argument")
}

# Read numbers from file
numbers <- as.numeric(readLines(args[1]))

# Sort the array
sorted_numbers <- merge_sort(numbers)

# Write sorted numbers back to file
writeLines(as.character(sorted_numbers), "sorted_data.txt")
