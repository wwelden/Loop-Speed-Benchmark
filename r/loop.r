#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
    cat("Please provide a number as command line argument\n", file = stderr())
    quit(status = 1)
}

input <- suppressWarnings(as.integer(args[1]))  # Get an input number from the command line
if (is.na(input)) {
    cat("Please provide a valid integer\n", file = stderr())
    quit(status = 1)
}

set.seed(as.integer(Sys.time()))
r <- sample(0:9999, 1)                         # Get a random number 0 <= r < 10k
a <- integer(10000)                            # Array of 10k elements initialized to 0

for (i in 1:10000) {                          # 10k outer loop iterations
    for (j in 0:99999) {                      # 100k inner loop iterations, per outer loop iteration
        a[i] <- a[i] + j %% input             # Simple sum
    }
    a[i] <- a[i] + r                          # Add a random value to each element in array
}

cat(a[r + 1], "\n")                           # Print out a single element from the array (R is 1-indexed)
