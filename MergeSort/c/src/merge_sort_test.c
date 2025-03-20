#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

// Forward declarations
void mergeSort(int* arr, size_t size);

// Helper function to create and initialize test arrays
int* createArray(const int* values, size_t size) {
    int* arr = (int*)malloc(size * sizeof(int));
    if (!arr) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    memcpy(arr, values, size * sizeof(int));
    return arr;
}

// Helper function to check if array is sorted
int isSorted(const int* arr, size_t size) {
    for (size_t i = 1; i < size; i++) {
        if (arr[i-1] > arr[i]) return 0;
    }
    return 1;
}

void testEmptyArray() {
    int arr[] = {};
    mergeSort(arr, 0);
    assert(isSorted(arr, 0));
    printf("Empty array test passed\n");
}

void testSingleElement() {
    int arr[] = {1};
    mergeSort(arr, 1);
    assert(isSorted(arr, 1));
    printf("Single element test passed\n");
}

void testTwoElements() {
    int arr[] = {2, 1};
    mergeSort(arr, 2);
    assert(isSorted(arr, 2));
    assert(arr[0] == 1 && arr[1] == 2);
    printf("Two elements test passed\n");
}

void testMultipleElements() {
    int arr[] = {5, 3, 8, 4, 2};
    mergeSort(arr, 5);
    assert(isSorted(arr, 5));
    assert(arr[0] == 2 && arr[1] == 3 && arr[2] == 4 && arr[3] == 5 && arr[4] == 8);
    printf("Multiple elements test passed\n");
}

void testDuplicateElements() {
    int arr[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    mergeSort(arr, 11);
    assert(isSorted(arr, 11));
    printf("Duplicate elements test passed\n");
}

void testNegativeNumbers() {
    int arr[] = {-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5};
    mergeSort(arr, 11);
    assert(isSorted(arr, 11));
    printf("Negative numbers test passed\n");
}

void testLargeArray() {
    const size_t size = 1000;
    int* arr = (int*)malloc(size * sizeof(int));
    if (!arr) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize with random numbers
    for (size_t i = 0; i < size; i++) {
        arr[i] = rand() % 1000;
    }

    mergeSort(arr, size);
    assert(isSorted(arr, size));
    printf("Large array test passed\n");

    free(arr);
}

int main() {
    // Run all tests
    testEmptyArray();
    testSingleElement();
    testTwoElements();
    testMultipleElements();
    testDuplicateElements();
    testNegativeNumbers();
    testLargeArray();

    printf("All tests passed!\n");
    return 0;
}
