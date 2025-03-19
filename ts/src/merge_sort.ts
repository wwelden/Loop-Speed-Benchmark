#!/usr/bin/env ts-node

/**
 * Merge sort implementation in TypeScript
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 *
 * @param arr The array to sort
 * @returns The sorted array
 */
export function mergeSort(arr: number[]): number[] {
    if (arr.length <= 1) return arr;

    // Split array into two halves
    const mid = Math.floor(arr.length / 2);
    const left = arr.slice(0, mid);
    const right = arr.slice(mid);

    // Recursively sort both halves
    const sortedLeft = mergeSort(left);
    const sortedRight = mergeSort(right);

    // Merge the sorted halves
    return merge(sortedLeft, sortedRight);
}

/**
 * Helper function to merge two sorted arrays
 *
 * @param left First sorted array
 * @param right Second sorted array
 * @returns Merged sorted array
 */
function merge(left: number[], right: number[]): number[] {
    const result: number[] = [];
    let i = 0;
    let j = 0;

    // Compare elements from both arrays and merge them
    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            result.push(left[i]);
            i++;
        } else {
            result.push(right[j]);
            j++;
        }
    }

    // Copy remaining elements from left array
    result.push(...left.slice(i));

    // Copy remaining elements from right array
    result.push(...right.slice(j));

    return result;
}

// Check if file path is provided
if (process.argv.length < 3) {
    console.error("Please provide a file path as an argument");
    process.exit(1);
}

// Read numbers from file
import * as fs from 'fs';
const numbers = fs.readFileSync(process.argv[2], 'utf8')
    .split('\n')
    .filter(line => line.trim())
    .map(Number);

// Sort the array
const sortedNumbers = mergeSort(numbers);

// Write sorted numbers back to file
fs.writeFileSync('sorted_data.txt', sortedNumbers.join('\n'));
