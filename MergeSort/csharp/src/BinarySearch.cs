using System;

namespace BinarySearch
{
    /// <summary>
    /// Provides binary search implementation for sorted arrays.
    /// </summary>
    public static class BinarySearch
    {
        /// <summary>
        /// Performs binary search to find the index of target in a sorted array.
        /// </summary>
        /// <param name="arr">A sorted array of integers</param>
        /// <param name="target">The value to search for</param>
        /// <returns>The index of target if found, -1 otherwise</returns>
        /// <exception cref="ArgumentNullException">Thrown when arr is null</exception>
        /// <remarks>
        /// Time Complexity: O(log n)
        /// Space Complexity: O(1)
        /// </remarks>
        public static int Search(int[] arr, int target)
        {
            if (arr == null)
            {
                throw new ArgumentNullException(nameof(arr));
            }

            if (arr.Length == 0)
            {
                return -1;
            }

            int left = 0;
            int right = arr.Length - 1;

            while (left <= right)
            {
                int mid = (left + right) / 2;

                if (arr[mid] == target)
                {
                    return mid;
                }
                else if (arr[mid] < target)
                {
                    left = mid + 1;
                }
                else
                {
                    if (mid == 0)
                    {
                        break;
                    }
                    right = mid - 1;
                }
            }

            return -1;
        }

        public static void Main()
        {
            // Test cases
            var testCases = new[]
            {
                (new[] { 1, 2, 3, 4, 5 }, 3),    // Target in middle
                (new[] { 1, 2, 3, 4, 5 }, 1),    // Target at start
                (new[] { 1, 2, 3, 4, 5 }, 5),    // Target at end
                (new[] { 1, 2, 3, 4, 5 }, 6),    // Target not present
                (Array.Empty<int>(), 1),          // Empty array
                (new[] { 1 }, 1)                  // Single element
            };

            foreach (var (arr, target) in testCases)
            {
                int result = Search(arr, target);
                Console.WriteLine($"Array: [{string.Join(", ", arr)}], Target: {target}, Result: {result}");
            }
        }
    }
}
