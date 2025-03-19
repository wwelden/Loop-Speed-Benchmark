#!/usr/bin/env php
<?php

/**
 * Merge sort implementation in PHP
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 *
 * @param array $arr The array to sort
 * @return array The sorted array
 */
function mergeSort(array $arr): array {
    if (count($arr) <= 1) return $arr;

    // Split array into two halves
    $mid = floor(count($arr) / 2);
    $left = array_slice($arr, 0, $mid);
    $right = array_slice($arr, $mid);

    // Recursively sort both halves
    $left = mergeSort($left);
    $right = mergeSort($right);

    // Merge the sorted halves
    return merge($left, $right);
}

/**
 * Helper function to merge two sorted arrays
 *
 * @param array $left First sorted array
 * @param array $right Second sorted array
 * @return array Merged sorted array
 */
function merge(array $left, array $right): array {
    $result = [];
    $i = 0;
    $j = 0;

    // Compare elements from both arrays and merge them
    while ($i < count($left) && $j < count($right)) {
        if ($left[$i] <= $right[$j]) {
            $result[] = $left[$i++];
        } else {
            $result[] = $right[$j++];
        }
    }

    // Copy remaining elements from left array
    while ($i < count($left)) {
        $result[] = $left[$i++];
    }

    // Copy remaining elements from right array
    while ($j < count($right)) {
        $result[] = $right[$j++];
    }

    return $result;
}

// Check if file path is provided
if ($argc < 2) {
    fwrite(STDERR, "Please provide a file path as an argument\n");
    exit(1);
}

try {
    // Read numbers from file
    $numbers = array_filter(
        array_map('trim', file($argv[1])),
        function($line) { return !empty($line); }
    );

    // Sort the array
    $sortedNumbers = mergeSort($numbers);

    // Write sorted numbers back to file
    file_put_contents('sorted_data.txt', implode("\n", $sortedNumbers) . "\n");

} catch (Exception $e) {
    fwrite(STDERR, "Error: " . $e->getMessage() . "\n");
    exit(1);
}
