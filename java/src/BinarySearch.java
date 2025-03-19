/**
 * Binary Search implementation in Java.
 * This class provides a static method to perform binary search on a sorted array.
 */
public class BinarySearch {
    /**
     * Performs binary search to find the index of target in a sorted array.
     *
     * @param arr    A sorted array of integers
     * @param target The value to search for
     * @return The index of target if found, -1 otherwise
     *
     * @throws IllegalArgumentException if arr is null
     *
     * @example
     * int[] arr = {1, 2, 3, 4, 5};
     * binarySearch(arr, 3); // returns 2
     * binarySearch(arr, 6); // returns -1
     *
     * @complexity
     * Time: O(log n)
     * Space: O(1)
     */
    public static int binarySearch(int[] arr, int target) {
        if (arr == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }

        if (arr.length == 0) {
            return -1;
        }

        int left = 0;
        int right = arr.length - 1;

        while (left <= right) {
            int mid = (left + right) / 2;

            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return -1;
    }

    public static void main(String[] args) {
        // Test cases
        int[][] testArrays = {
            {1, 2, 3, 4, 5},    // Target in middle
            {1, 2, 3, 4, 5},    // Target at start
            {1, 2, 3, 4, 5},    // Target at end
            {1, 2, 3, 4, 5},    // Target not present
            {},                  // Empty array
            {1}                  // Single element
        };

        int[] testTargets = {3, 1, 5, 6, 1, 1};

        for (int i = 0; i < testArrays.length; i++) {
            int result = binarySearch(testArrays[i], testTargets[i]);
            System.out.printf("Array: %s, Target: %d, Result: %d%n",
                java.util.Arrays.toString(testArrays[i]), testTargets[i], result);
        }
    }
}
