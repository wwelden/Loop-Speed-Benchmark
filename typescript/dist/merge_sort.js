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
    const mid = Math.floor(arr.length / 2);
    const left = arr.slice(0, mid);
    const right = arr.slice(mid);
    return merge(mergeSort(left), mergeSort(right));
}
/**
 * Merges two sorted arrays into a single sorted array
 *
 * @param {number[]} left First sorted array
 * @param {number[]} right Second sorted array
 * @returns {number[]} Merged sorted array
 */
function merge(left, right) {
    const result = [];
    let i = 0;
    let j = 0;
    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            result.push(left[i++]);
        }
        else {
            result.push(right[j++]);
        }
    }
    while (i < left.length) {
        result.push(left[i++]);
    }
    while (j < right.length) {
        result.push(right[j++]);
    }
    return result;
}
/**
 * Main function to read input file, sort numbers, and write to output file
 */
async function main() {
    const args = process.argv.slice(2);
    if (args.length !== 1) {
        console.error("Usage: merge_sort <input_file>");
        process.exit(1);
    }
    const inputFile = args[0];
    try {
        const fs = require('fs');
        const numbers = fs.readFileSync(inputFile, 'utf-8')
            .split('\n')
            .filter(line => line.trim())
            .map(Number);
        const sorted = mergeSort(numbers);
        fs.writeFileSync('sorted_data.txt', sorted.join('\n'));
    }
    catch (error) {
        console.error("Error:", error.message);
        process.exit(1);
    }
}
// Run if this is the main module
if (require.main === module) {
    main();
}
