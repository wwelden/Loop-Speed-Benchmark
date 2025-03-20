#include <iostream>
#include <fstream>
#include <vector>
#include <string>

/**
 * Binary Search Implementation in C++
 * @tparam T The type of elements in the array
 * @param arr A sorted array of elements
 * @param target The value to search for
 * @return The index of target if found, -1 otherwise
 * @complexity Time: O(log n), Space: O(1)
 */
template<typename T>
int binary_search(const std::vector<T>& arr, const T& target) {
    if (arr.empty()) {
        return -1;
    }

    int left = 0;
    int right = arr.size() - 1;

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

int main(int argc, char* argv[]) {
    const std::string filename = (argc > 1) ? argv[1] : "test_data.txt";
    std::ifstream file(filename);
    if (!file) {
        std::cerr << "Error opening file: " << filename << std::endl;
        return 1;
    }

    // Read numbers into vector
    std::vector<int> arr;
    int num;
    while (file >> num) {
        arr.push_back(num);
    }

    // Test with a few values
    std::vector<int> test_values;
    test_values.push_back(arr[arr.size() / 2]);  // Middle value
    test_values.push_back(arr[0]);               // First value
    test_values.push_back(arr[arr.size() - 1]);  // Last value
    test_values.push_back(-999999);              // Value not in array

    for (const int& target : test_values) {
        int result = binary_search(arr, target);
        std::cout << "Target: " << target << ", Result: " << result << std::endl;
    }

    return 0;
}
