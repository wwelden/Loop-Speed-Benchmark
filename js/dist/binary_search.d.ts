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
export declare function binarySearch(arr: number[], target: number): number;
