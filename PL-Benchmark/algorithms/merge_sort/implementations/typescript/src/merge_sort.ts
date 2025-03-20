/**
 * Merge Sort implementation in TypeScript
 *
 * Usage: node merge_sort.js <input_file_path> <output_file_path>
 */

import * as fs from 'fs';

/**
 * Merge sort algorithm implementation
 * @param arr Array to sort
 * @returns Sorted array
 */
function mergeSort(arr: number[]): number[] {
    // Base case: array with 0 or 1 element is already sorted
    if (arr.length <= 1) {
        return arr;
    }

    // Split array in half
    const middle = Math.floor(arr.length / 2);
    const left = arr.slice(0, middle);
    const right = arr.slice(middle);

    // Recursively sort both halves
    return merge(mergeSort(left), mergeSort(right));
}

/**
 * Merge two sorted arrays
 * @param left First sorted array
 * @param right Second sorted array
 * @returns Merged sorted array
 */
function merge(left: number[], right: number[]): number[] {
    const result: number[] = [];
    let leftIndex = 0;
    let rightIndex = 0;

    // Compare elements from both arrays and add smaller element to result
    while (leftIndex < left.length && rightIndex < right.length) {
        if (left[leftIndex] < right[rightIndex]) {
            result.push(left[leftIndex]);
            leftIndex++;
        } else {
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
function main(): void {
    // Check command line arguments
    if (process.argv.length < 4) {
        console.error('Usage: node merge_sort.js <input_file_path> <output_file_path>');
        process.exit(1);
    }

    const inputFile = process.argv[2];
    const outputFile = process.argv[3];

    // Read input file
    try {
        const data = fs.readFileSync(inputFile, 'utf8');

        // Parse numbers from input file
        const numbers = data.trim().split('\n').map(line => {
            const num = parseInt(line.trim(), 10);
            if (isNaN(num)) {
                throw new Error(`Invalid number in input file: ${line}`);
            }
            return num;
        });

        // Sort the numbers
        const sortedNumbers = mergeSort(numbers);

        // Write sorted numbers to output file
        fs.writeFileSync(outputFile, sortedNumbers.join('\n'));

        console.log(`Sorted ${numbers.length} numbers and saved to ${outputFile}`);
    } catch (error) {
        console.error('Error:', error.message);
        process.exit(1);
    }
}

// Run the main function
main();
