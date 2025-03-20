#!/usr/bin/env node
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.mergeSort = mergeSort;
/**
 * Merge sort implementation in TypeScript
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 *
 * @param {number[]} arr The array to sort
 * @returns {number[]} The sorted array
 */
function mergeSort(arr) {
    if (arr.length <= 1)
        return arr;
    // Split array into two halves
    var mid = Math.floor(arr.length / 2);
    var left = arr.slice(0, mid);
    var right = arr.slice(mid);
    // Recursively sort both halves
    var sortedLeft = mergeSort(left);
    var sortedRight = mergeSort(right);
    // Merge the sorted halves
    return merge(sortedLeft, sortedRight);
}
/**
 * Helper function to merge two sorted arrays
 *
 * @param {number[]} left First sorted array
 * @param {number[]} right Second sorted array
 * @returns {number[]} Merged sorted array
 */
function merge(left, right) {
    var result = [];
    var i = 0;
    var j = 0;
    // Compare elements from both arrays and merge them
    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            result.push(left[i]);
            i++;
        }
        else {
            result.push(right[j]);
            j++;
        }
    }
    // Copy remaining elements from left array
    result.push.apply(result, left.slice(i));
    // Copy remaining elements from right array
    result.push.apply(result, right.slice(j));
    return result;
}
// Check if file path is provided
if (process.argv.length < 3) {
    console.error("Please provide a file path as an argument");
    process.exit(1);
}
// Read numbers from file
var fs = require("fs");
var numbers = fs.readFileSync(process.argv[2], 'utf8')
    .split('\n')
    .filter(function (line) { return line.trim(); })
    .map(Number);
// Sort the array
var sortedNumbers = mergeSort(numbers);
// Write sorted numbers back to file
fs.writeFileSync('sorted_data.txt', sortedNumbers.join('\n'));
