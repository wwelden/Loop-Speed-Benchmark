const fs = require('fs');

/**
 * Performs binary search to find the index of target in a sorted array.
 * @param {number[]} arr - A sorted array of integers
 * @param {number} target - The value to search for
 * @returns {number} The index of target if found, -1 otherwise
 *
 * @example
 * const arr = [1, 2, 3, 4, 5];
 * binarySearch(arr, 3); // returns 2
 * binarySearch(arr, 6); // returns -1
 *
 * @complexity
 * Time: O(log n)
 * Space: O(1)
 */
function binarySearch(arr, target) {
    if (!arr || arr.length === 0) {
        return -1;
    }

    let left = 0;
    let right = arr.length - 1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);

        if (arr[mid] === target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            if (mid === 0) {
                break;
            }
            right = mid - 1;
        }
    }

    return -1;
}

// Read test data from file
function main() {
    const filename = process.argv[2] || 'test_data.txt';
    const data = fs.readFileSync(filename, 'utf8')
        .split('\n')
        .map(Number)
        .filter(n => !isNaN(n));

    // Test with a few values
    const testValues = [
        data[Math.floor(data.length / 2)],  // Middle value
        data[0],                            // First value
        data[data.length - 1],              // Last value
        -999999,                            // Value not in array
    ];

    for (const target of testValues) {
        const result = binarySearch(data, target);
        console.log(`Target: ${target}, Result: ${result}`);
    }
}

main();
