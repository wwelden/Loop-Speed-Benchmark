#include <iostream>
#include <vector>
#include <string>
#include <cassert>
#include "../src/binary_search.cpp"

// Test framework
#define TEST_ASSERT(condition, message) \
    do { \
        if (!(condition)) { \
            std::cerr << "Test failed: " << message << std::endl; \
            return false; \
        } \
    } while (0)

bool test_binary_search() {
    // Test with integers
    std::vector<int> arr1 = {1, 2, 3, 4, 5};
    TEST_ASSERT(binary_search(arr1, 3) == 2, "Target in middle");
    TEST_ASSERT(binary_search(arr1, 1) == 0, "Target at start");
    TEST_ASSERT(binary_search(arr1, 5) == 4, "Target at end");
    TEST_ASSERT(binary_search(arr1, 6) == -1, "Target not present");

    // Test with empty array
    std::vector<int> empty_arr;
    TEST_ASSERT(binary_search(empty_arr, 1) == -1, "Empty array");

    // Test with single element
    std::vector<int> single_arr = {1};
    TEST_ASSERT(binary_search(single_arr, 1) == 0, "Single element");

    // Test with negative numbers
    std::vector<int> neg_arr = {-5, -3, -1, 0, 2};
    TEST_ASSERT(binary_search(neg_arr, -3) == 1, "Negative numbers");

    // Test with duplicate elements
    std::vector<int> dup_arr = {1, 2, 2, 2, 3};
    TEST_ASSERT(binary_search(dup_arr, 2) == 1, "Duplicate elements");

    // Test with strings
    std::vector<std::string> str_arr = {"apple", "banana", "cherry", "date", "elderberry"};
    TEST_ASSERT(binary_search(str_arr, std::string("cherry")) == 2, "String target in middle");
    TEST_ASSERT(binary_search(str_arr, std::string("apple")) == 0, "String target at start");
    TEST_ASSERT(binary_search(str_arr, std::string("elderberry")) == 4, "String target at end");
    TEST_ASSERT(binary_search(str_arr, std::string("fig")) == -1, "String target not present");

    std::cout << "All tests passed!" << std::endl;
    return true;
}

int main() {
    return test_binary_search() ? 0 : 1;
}
