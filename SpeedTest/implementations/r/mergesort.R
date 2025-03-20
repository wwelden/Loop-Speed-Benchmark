#!/usr/bin/env Rscript

merge <- function(arr, left, right) {
    i <- j <- k <- 1

    while (i <= length(left) && j <= length(right)) {
        if (left[i] <= right[j]) {
            arr[k] <- left[i]
            i <- i + 1
        } else {
            arr[k] <- right[j]
            j <- j + 1
        }
        k <- k + 1
    }

    while (i <= length(left)) {
        arr[k] <- left[i]
        i <- i + 1
        k <- k + 1
    }

    while (j <= length(right)) {
        arr[k] <- right[j]
        j <- j + 1
        k <- k + 1
    }

    return(arr)
}

mergeSort <- function(arr) {
    if (length(arr) <= 1) {
        return(arr)
    }

    mid <- floor(length(arr) / 2)
    left <- arr[1:mid]
    right <- arr[(mid + 1):length(arr)]

    left <- mergeSort(left)
    right <- mergeSort(right)

    return(merge(arr, left, right))
}

generateRandomArray <- function(size) {
    return(sample(0:9999, size, replace = TRUE))
}

ARRAY_SIZE <- 1000
ITERATIONS <- 100

for (i in 1:ITERATIONS) {
    arr <- generateRandomArray(ARRAY_SIZE)
    arr <- mergeSort(arr)
}
