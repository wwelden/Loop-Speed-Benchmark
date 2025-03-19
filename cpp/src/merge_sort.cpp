#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

/**
 * Merge sort implementation in C++
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 */

/**
 * Helper function to merge two sorted vectors
 *
 * @param arr The original vector
 * @param left The left subvector
 * @param right The right subvector
 */
template<typename T>
void merge(std::vector<T>& arr, const std::vector<T>& left, const std::vector<T>& right) {
    size_t i = 0, j = 0, k = 0;

    // Compare elements from both vectors and merge them
    while (i < left.size() && j < right.size()) {
        if (left[i] <= right[j]) {
            arr[k++] = left[i++];
        } else {
            arr[k++] = right[j++];
        }
    }

    // Copy remaining elements from left vector
    while (i < left.size()) {
        arr[k++] = left[i++];
    }

    // Copy remaining elements from right vector
    while (j < right.size()) {
        arr[k++] = right[j++];
    }
}

/**
 * Sorts a vector using merge sort algorithm
 *
 * @param arr The vector to sort
 */
template<typename T>
void mergeSort(std::vector<T>& arr) {
    if (arr.size() <= 1) return;

    // Split vector into two halves
    size_t mid = arr.size() / 2;
    std::vector<T> left(arr.begin(), arr.begin() + mid);
    std::vector<T> right(arr.begin() + mid, arr.end());

    // Recursively sort both halves
    mergeSort(left);
    mergeSort(right);

    // Merge the sorted halves
    merge(arr, left, right);
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Please provide a file path as an argument" << std::endl;
        return 1;
    }

    std::ifstream input(argv[1]);
    if (!input) {
        std::cerr << "Error opening input file" << std::endl;
        return 1;
    }

    // Read numbers from file
    std::vector<int> numbers;
    std::string line;

    while (std::getline(input, line)) {
        if (!line.empty()) {
            numbers.push_back(std::stoi(line));
        }
    }

    input.close();

    // Sort the vector
    mergeSort(numbers);

    // Write sorted numbers back to file
    std::ofstream output("sorted_data.txt");
    if (!output) {
        std::cerr << "Error opening output file" << std::endl;
        return 1;
    }

    for (int num : numbers) {
        output << num << std::endl;
    }

    output.close();
    return 0;
}
