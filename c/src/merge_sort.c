#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Merge sort implementation in C
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 */

/**
 * Helper function to merge two sorted arrays
 *
 * @param arr The original array
 * @param left The left subarray
 * @param right The right subarray
 * @param left_size Size of left subarray
 * @param right_size Size of right subarray
 */
void merge(int* arr, int* left, int* right, size_t left_size, size_t right_size) {
    size_t i = 0, j = 0, k = 0;

    // Compare elements from both arrays and merge them
    while (i < left_size && j < right_size) {
        if (left[i] <= right[j]) {
            arr[k++] = left[i++];
        } else {
            arr[k++] = right[j++];
        }
    }

    // Copy remaining elements from left array
    while (i < left_size) {
        arr[k++] = left[i++];
    }

    // Copy remaining elements from right array
    while (j < right_size) {
        arr[k++] = right[j++];
    }
}

/**
 * Sorts an array using merge sort algorithm
 *
 * @param arr The array to sort
 * @param size The size of the array
 */
void mergeSort(int* arr, size_t size) {
    if (size <= 1) return;

    // Split array into two halves
    size_t mid = size / 2;
    int* left = (int*)malloc(mid * sizeof(int));
    int* right = (int*)malloc((size - mid) * sizeof(int));

    if (!left || !right) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Copy elements to left and right subarrays
    memcpy(left, arr, mid * sizeof(int));
    memcpy(right, arr + mid, (size - mid) * sizeof(int));

    // Recursively sort both halves
    mergeSort(left, mid);
    mergeSort(right, size - mid);

    // Merge the sorted halves
    merge(arr, left, right, mid, size - mid);

    // Free temporary arrays
    free(left);
    free(right);
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Please provide a file path as an argument\n");
        return 1;
    }

    FILE* input = fopen(argv[1], "r");
    if (!input) {
        fprintf(stderr, "Error opening input file\n");
        return 1;
    }

    // Read numbers from file
    int* numbers = NULL;
    size_t capacity = 1000;
    size_t size = 0;
    char line[256];

    numbers = (int*)malloc(capacity * sizeof(int));
    if (!numbers) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(input);
        return 1;
    }

    while (fgets(line, sizeof(line), input)) {
        if (line[0] != '\n') {  // Skip empty lines
            if (size >= capacity) {
                capacity *= 2;
                int* temp = (int*)realloc(numbers, capacity * sizeof(int));
                if (!temp) {
                    fprintf(stderr, "Memory reallocation failed\n");
                    free(numbers);
                    fclose(input);
                    return 1;
                }
                numbers = temp;
            }
            numbers[size++] = atoi(line);
        }
    }

    fclose(input);

    // Sort the array
    mergeSort(numbers, size);

    // Write sorted numbers back to file
    FILE* output = fopen("sorted_data.txt", "w");
    if (!output) {
        fprintf(stderr, "Error opening output file\n");
        free(numbers);
        return 1;
    }

    for (size_t i = 0; i < size; i++) {
        fprintf(output, "%d\n", numbers[i]);
    }

    fclose(output);
    free(numbers);
    return 0;
}
