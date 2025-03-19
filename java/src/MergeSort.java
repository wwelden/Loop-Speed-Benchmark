import java.io.*;
import java.util.Arrays;

/**
 * Merge sort implementation in Java
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 */
public class MergeSort {
    /**
     * Sorts an array using merge sort algorithm
     *
     * @param arr The array to sort
     * @return The sorted array
     */
    public static int[] mergeSort(int[] arr) {
        if (arr.length <= 1) return arr;

        // Split array into two halves
        int mid = arr.length / 2;
        int[] left = Arrays.copyOfRange(arr, 0, mid);
        int[] right = Arrays.copyOfRange(arr, mid, arr.length);

        // Recursively sort both halves
        left = mergeSort(left);
        right = mergeSort(right);

        // Merge the sorted halves
        return merge(left, right);
    }

    /**
     * Helper function to merge two sorted arrays
     *
     * @param left First sorted array
     * @param right Second sorted array
     * @return Merged sorted array
     */
    private static int[] merge(int[] left, int[] right) {
        int[] result = new int[left.length + right.length];
        int i = 0, j = 0, k = 0;

        // Compare elements from both arrays and merge them
        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                result[k++] = left[i++];
            } else {
                result[k++] = right[j++];
            }
        }

        // Copy remaining elements from left array
        while (i < left.length) {
            result[k++] = left[i++];
        }

        // Copy remaining elements from right array
        while (j < right.length) {
            result[k++] = right[j++];
        }

        return result;
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Please provide a file path as an argument");
            System.exit(1);
        }

        try {
            // Read numbers from file
            BufferedReader reader = new BufferedReader(new FileReader(args[0]));
            String line;
            StringBuilder numbers = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    numbers.append(line).append("\n");
                }
            }
            reader.close();

            // Parse numbers and sort
            int[] arr = Arrays.stream(numbers.toString().split("\n"))
                             .mapToInt(Integer::parseInt)
                             .toArray();
            int[] sortedArr = mergeSort(arr);

            // Write sorted numbers back to file
            try (PrintWriter writer = new PrintWriter(new FileWriter("sorted_data.txt"))) {
                for (int num : sortedArr) {
                    writer.println(num);
                }
            }

        } catch (IOException e) {
            System.err.println("Error reading/writing file: " + e.getMessage());
            System.exit(1);
        }
    }
}
