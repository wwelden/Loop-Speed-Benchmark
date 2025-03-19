using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace MergeSort
{
    /// <summary>
    /// Implementation of merge sort algorithm in C#
    /// Time complexity: O(n log n)
    /// Space complexity: O(n)
    /// </summary>
    public class MergeSort<T> where T : IComparable<T>
    {
        /// <summary>
        /// Sorts an array using merge sort algorithm
        /// </summary>
        /// <param name="arr">The array to sort</param>
        /// <returns>The sorted array</returns>
        public static T[] Sort(T[] arr)
        {
            if (arr == null || arr.Length <= 1)
                return arr;

            // Split array into two halves
            int mid = arr.Length / 2;
            T[] left = arr.Take(mid).ToArray();
            T[] right = arr.Skip(mid).ToArray();

            // Recursively sort both halves
            return Merge(Sort(left), Sort(right));
        }

        /// <summary>
        /// Merges two sorted arrays into a single sorted array
        /// </summary>
        /// <param name="left">First sorted array</param>
        /// <param name="right">Second sorted array</param>
        /// <returns>Merged sorted array</returns>
        private static T[] Merge(T[] left, T[] right)
        {
            var result = new List<T>(left.Length + right.Length);
            int i = 0, j = 0;

            // Compare elements from both arrays and merge them
            while (i < left.Length && j < right.Length)
            {
                if (left[i].CompareTo(right[j]) <= 0)
                {
                    result.Add(left[i++]);
                }
                else
                {
                    result.Add(right[j++]);
                }
            }

            // Copy remaining elements from left array
            while (i < left.Length)
            {
                result.Add(left[i++]);
            }

            // Copy remaining elements from right array
            while (j < right.Length)
            {
                result.Add(right[j++]);
            }

            return result.ToArray();
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.Error.WriteLine("Please provide a file path as an argument");
                Environment.Exit(1);
            }

            try
            {
                // Read numbers from file
                var numbers = File.ReadAllLines(args[0])
                    .Where(line => !string.IsNullOrWhiteSpace(line))
                    .Select(line => int.Parse(line.Trim()))
                    .ToArray();

                // Sort the array
                var sortedNumbers = MergeSort<int>.Sort(numbers);

                // Write sorted numbers back to file
                File.WriteAllLines("sorted_data.txt",
                    sortedNumbers.Select(n => n.ToString()));
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Error: {ex.Message}");
                Environment.Exit(1);
            }
        }
    }
}
