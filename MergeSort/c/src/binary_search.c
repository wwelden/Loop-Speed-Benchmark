#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Binary Search Implementation in C
 * @param arr A sorted array of integers
 * @param n The length of the array
 * @param target The value to search for
 * @return The index of target if found, -1 otherwise
 * @complexity Time: O(log n), Space: O(1)
 */
int binary_search(int arr[], int n, int target) {
    if (!arr || n == 0) {
        return -1;
    }

    int left = 0;
    int right = n - 1;

    while (left <= right) {
        int mid = (left + right) / 2;

        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            if (mid == 0) {
                break;
            }
            right = mid - 1;
        }
    }

    return -1;
}

int main(int argc, char *argv[]) {
    const char *filename = argc > 1 ? argv[1] : "test_data.txt";
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error opening file: %s\n", filename);
        return 1;
    }

    // Count lines to determine array size
    int count = 0;
    char ch;
    while (!feof(file)) {
        ch = fgetc(file);
        if (ch == '\n') {
            count++;
        }
    }
    rewind(file);

    // Allocate and read array
    int *arr = malloc(count * sizeof(int));
    if (!arr) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(file);
        return 1;
    }

    int i = 0;
    char line[32];
    while (fgets(line, sizeof(line), file)) {
        arr[i++] = atoi(line);
    }

    // Test with a few values
    int test_values[] = {
        arr[count / 2],  // Middle value
        arr[0],          // First value
        arr[count - 1],  // Last value
        -999999         // Value not in array
    };
    int num_tests = sizeof(test_values) / sizeof(test_values[0]);

    for (int j = 0; j < num_tests; j++) {
        int result = binary_search(arr, count, test_values[j]);
        printf("Target: %d, Result: %d\n", test_values[j], result);
    }

    free(arr);
    fclose(file);
    return 0;
}
