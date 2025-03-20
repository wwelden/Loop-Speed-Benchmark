"use strict";
/**
 * Binary Search implementation in TypeScript
 *
 * Usage: node binary_search.js <input_file_path> <targets_file_path>
 */
Object.defineProperty(exports, "__esModule", { value: true });
var fs = require("fs");
/**
 * Binary search algorithm implementation
 * @param arr Sorted array to search in
 * @param target Value to search for
 * @returns Index of the target if found, -1 otherwise
 */
function binarySearch(arr, target) {
    var left = 0;
    var right = arr.length - 1;
    while (left <= right) {
        var mid = Math.floor((left + right) / 2);
        if (arr[mid] === target) {
            return mid; // Found the target
        }
        else if (arr[mid] < target) {
            left = mid + 1; // Search in the right half
        }
        else {
            right = mid - 1; // Search in the left half
        }
    }
    return -1; // Target not found
}
/**
 * Main function to handle file I/O and searching
 */
function main() {
    // Check command line arguments
    if (process.argv.length < 4) {
        console.error('Usage: node binary_search.js <input_file_path> <targets_file_path>');
        process.exit(1);
    }
    var inputFile = process.argv[2];
    var targetsFile = process.argv[3];
    try {
        // Read and parse the sorted input array
        var inputData = fs.readFileSync(inputFile, 'utf8');
        var sortedArray = inputData.trim().split('\n').map(function (line) {
            var num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error("Invalid number in input file: ".concat(line));
            }
            return num;
        });
        // Read and parse the targets to search for
        var targetsData = fs.readFileSync(targetsFile, 'utf8');
        var targets = targetsData.trim().split('\n').map(function (line) {
            var num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error("Invalid number in targets file: ".concat(line));
            }
            return num;
        });
        // Search for each target and count found/not found
        var found = 0;
        var notFound = 0;
        var results = [];
        for (var _i = 0, targets_1 = targets; _i < targets_1.length; _i++) {
            var target = targets_1[_i];
            var index = binarySearch(sortedArray, target);
            var isFound = index !== -1;
            results.push({
                target: target,
                index: index,
                found: isFound
            });
            if (isFound) {
                found++;
            }
            else {
                notFound++;
            }
        }
        // Write results summary
        console.log("Search results: found ".concat(found, ", not found ").concat(notFound));
        // Optionally write detailed results to a file
        var resultsOutput = results.map(function (r) {
            return "".concat(r.target, ": ").concat(r.found ? 'Found at index ' + r.index : 'Not found');
        }).join('\n');
        fs.writeFileSync('binary_search_results.txt', resultsOutput);
    }
    catch (error) {
        console.error('Error:', error.message);
        process.exit(1);
    }
}
// Run the main function
main();
