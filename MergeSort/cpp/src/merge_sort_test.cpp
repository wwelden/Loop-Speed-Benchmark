#include <iostream>
#include <vector>
#include <cassert>
#include <random>
#include <algorithm>

// Forward declarations
template<typename T>
void mergeSort(std::vector<T>& arr);

// Helper function to check if vector is sorted
template<typename T>
bool isSorted(const std::vector<T>& arr) {
    for (size_t i = 1; i < arr.size(); i++) {
        if (arr[i-1] > arr[i]) return false;
    }
    return true;
}

void testEmptyVector() {
    std::vector<int> arr;
    mergeSort(arr);
    assert(isSorted(arr));
    std::cout << "Empty vector test passed" << std::endl;
}

void testSingleElement() {
    std::vector<int> arr = {1};
    mergeSort(arr);
    assert(isSorted(arr));
    std::cout << "Single element test passed" << std::endl;
}

void testTwoElements() {
    std::vector<int> arr = {2, 1};
    mergeSort(arr);
    assert(isSorted(arr));
    assert(arr[0] == 1 && arr[1] == 2);
    std::cout << "Two elements test passed" << std::endl;
}

void testMultipleElements() {
    std::vector<int> arr = {5, 3, 8, 4, 2};
    mergeSort(arr);
    assert(isSorted(arr));
    assert(arr[0] == 2 && arr[1] == 3 && arr[2] == 4 && arr[3] == 5 && arr[4] == 8);
    std::cout << "Multiple elements test passed" << std::endl;
}

void testDuplicateElements() {
    std::vector<int> arr = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    mergeSort(arr);
    assert(isSorted(arr));
    std::cout << "Duplicate elements test passed" << std::endl;
}

void testNegativeNumbers() {
    std::vector<int> arr = {-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5};
    mergeSort(arr);
    assert(isSorted(arr));
    std::cout << "Negative numbers test passed" << std::endl;
}

void testLargeVector() {
    const size_t size = 1000;
    std::vector<int> arr(size);

    // Initialize with random numbers
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 999);

    for (size_t i = 0; i < size; i++) {
        arr[i] = dis(gen);
    }

    mergeSort(arr);
    assert(isSorted(arr));
    std::cout << "Large vector test passed" << std::endl;
}

void testDifferentTypes() {
    // Test with double
    std::vector<double> doubleArr = {3.14, 1.41, 2.71, 0.58, 1.73};
    mergeSort(doubleArr);
    assert(isSorted(doubleArr));

    // Test with string
    std::vector<std::string> strArr = {"banana", "apple", "cherry", "date", "elderberry"};
    mergeSort(strArr);
    assert(isSorted(strArr));

    std::cout << "Different types test passed" << std::endl;
}

int main() {
    // Run all tests
    testEmptyVector();
    testSingleElement();
    testTwoElements();
    testMultipleElements();
    testDuplicateElements();
    testNegativeNumbers();
    testLargeVector();
    testDifferentTypes();

    std::cout << "All tests passed!" << std::endl;
    return 0;
}
