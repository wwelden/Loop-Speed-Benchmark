/**
 * Binary Search implementation in TypeScript
 *
 * Usage: node binary_search.js <input_file_path> <targets_file_path>
 */

import * as fs from 'fs';

/**
 * Binary search algorithm implementation
 * @param arr Sorted array to search in
 * @param target Value to search for
 * @returns Index of the target if found, -1 otherwise
 */
function binarySearch(arr: number[], target: number): number {
    let left = 0;
    let right = arr.length - 1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);

        if (arr[mid] === target) {
            return mid; // Found the target
        } else if (arr[mid] < target) {
            left = mid + 1; // Search in the right half
        } else {
            right = mid - 1; // Search in the left half
        }
    }

    return -1; // Target not found
}

/**
 * Main function to handle file I/O and searching
 */
function main(): void {
    // Check command line arguments
    if (process.argv.length < 4) {
        console.error('Usage: node binary_search.js <input_file_path> <targets_file_path>');
        process.exit(1);
    }

    const inputFile = process.argv[2];
    const targetsFile = process.argv[3];

    try {
        // Read and parse the sorted input array
        const inputData = fs.readFileSync(inputFile, 'utf8');
        const sortedArray = inputData.trim().split('\n').map(line => {
            const num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error(`Invalid number in input file: ${line}`);
            }
            return num;
        });

        // Read and parse the targets to search for
        const targetsData = fs.readFileSync(targetsFile, 'utf8');
        const targets = targetsData.trim().split('\n').map(line => {
            const num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error(`Invalid number in targets file: ${line}`);
            }
            return num;
        });

        // Search for each target and count found/not found
        let found = 0;
        let notFound = 0;

        const results: Array<{target: number, index: number, found: boolean}> = [];

        for (const target of targets) {
            const index = binarySearch(sortedArray, target);
            const isFound = index !== -1;

            results.push({
                target,
                index,
                found: isFound
            });

            if (isFound) {
                found++;
            } else {
                notFound++;
            }
        }

        // Write results summary
        console.log(`Search results: found ${found}, not found ${notFound}`);

        // Optionally write detailed results to a file
        const resultsOutput = results.map(r =>
            `${r.target}: ${r.found ? 'Found at index ' + r.index : 'Not found'}`
        ).join('\n');

        fs.writeFileSync('binary_search_results.txt', resultsOutput);

    } catch (error) {
        console.error('Error:', error.message);
        process.exit(1);
    }
}

// Run the main function
main();
