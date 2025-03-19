/**
 * Performs binary search to find the index of target in a sorted array.
 * @param arr - A sorted array of integers
 * @param target - The value to search for
 * @returns The index of target if found, -1 otherwise
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
export function binarySearch(arr: number[], target: number): number {
    if (!arr || arr.length === 0) {
        return -1;
    }

    let left: number = 0;
    let right: number = arr.length - 1;

    while (left <= right) {
        const mid: number = Math.floor((left + right) / 2);

        if (arr[mid] === target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
}

// Example usage
const testCases: Array<{ arr: number[]; target: number }> = [
    { arr: [1, 2, 3, 4, 5], target: 3 },      // Target in middle
    { arr: [1, 2, 3, 4, 5], target: 1 },      // Target at start
    { arr: [1, 2, 3, 4, 5], target: 5 },      // Target at end
    { arr: [1, 2, 3, 4, 5], target: 6 },      // Target not present
    { arr: [], target: 1 },                    // Empty array
    { arr: [1], target: 1 },                   // Single element
];

testCases.forEach(({ arr, target }) => {
    const result = binarySearch(arr, target);
    console.log(`Array: [${arr}], Target: ${target}, Result: ${result}`);
});
