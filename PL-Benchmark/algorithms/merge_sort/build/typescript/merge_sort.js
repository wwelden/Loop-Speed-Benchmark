"use strict";
/**
 * Merge Sort implementation in TypeScript
 *
 * Usage: node merge_sort.js <input_file_path> <output_file_path>
 */
Object.defineProperty(exports, "__esModule", { value: true });
var fs = require("fs");
/**
 * Merge sort algorithm implementation
 * @param arr Array to sort
 * @returns Sorted array
 */
function mergeSort(arr) {
    // Base case: array with 0 or 1 element is already sorted
    if (arr.length <= 1) {
        return arr;
    }
    // Split array in half
    var middle = Math.floor(arr.length / 2);
    var left = arr.slice(0, middle);
    var right = arr.slice(middle);
    // Recursively sort both halves
    return merge(mergeSort(left), mergeSort(right));
}
/**
 * Merge two sorted arrays
 * @param left First sorted array
 * @param right Second sorted array
 * @returns Merged sorted array
 */
function merge(left, right) {
    var result = [];
    var leftIndex = 0;
    var rightIndex = 0;
    // Compare elements from both arrays and add smaller element to result
    while (leftIndex < left.length && rightIndex < right.length) {
        if (left[leftIndex] < right[rightIndex]) {
            result.push(left[leftIndex]);
            leftIndex++;
        }
        else {
            result.push(right[rightIndex]);
            rightIndex++;
        }
    }
    // Add remaining elements from left array
    while (leftIndex < left.length) {
        result.push(left[leftIndex]);
        leftIndex++;
    }
    // Add remaining elements from right array
    while (rightIndex < right.length) {
        result.push(right[rightIndex]);
        rightIndex++;
    }
    return result;
}
/**
 * Main function to handle file I/O and sorting
 */
function main() {
    // Check command line arguments
    if (process.argv.length < 4) {
        console.error('Usage: node merge_sort.js <input_file_path> <output_file_path>');
        process.exit(1);
    }
    var inputFile = process.argv[2];
    var outputFile = process.argv[3];
    // Read input file
    try {
        var data = fs.readFileSync(inputFile, 'utf8');
        // Parse numbers from input file
        var numbers = data.trim().split('\n').map(function (line) {
            var num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error("Invalid number in input file: ".concat(line));
            }
            return num;
        });
        // Sort the numbers
        var sortedNumbers = mergeSort(numbers);
        // Write sorted numbers to output file
        fs.writeFileSync(outputFile, sortedNumbers.join('\n'));
        console.log("Sorted ".concat(numbers.length, " numbers and saved to ").concat(outputFile));
    }
    catch (error) {
        console.error('Error:', error.message);
        process.exit(1);
    }
}
// Run the main function
main();
