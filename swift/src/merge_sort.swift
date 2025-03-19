#!/usr/bin/swift

/// Implementation of merge sort algorithm in Swift
/// Time complexity: O(n log n)
/// Space complexity: O(n)
func mergeSort<T: Comparable>(_ arr: [T]) -> [T] {
    if arr.count <= 1 {
        return arr
    }

    // Split array into two halves
    let mid = arr.count / 2
    let left = Array(arr[..<mid])
    let right = Array(arr[mid...])

    // Recursively sort both halves
    return merge(mergeSort(left), mergeSort(right))
}

/// Helper function to merge two sorted arrays into a single sorted array
func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var result = [T]()
    result.reserveCapacity(left.count + right.count)
    var i = 0
    var j = 0

    // Compare elements from both arrays and merge them
    while i < left.count && j < right.count {
        if left[i] <= right[j] {
            result.append(left[i])
            i += 1
        } else {
            result.append(right[j])
            j += 1
        }
    }

    // Copy remaining elements from left array
    result.append(contentsOf: left[i...])

    // Copy remaining elements from right array
    result.append(contentsOf: right[j...])

    return result
}

// Check if file path is provided
guard CommandLine.arguments.count > 1 else {
    print("Please provide a file path as an argument", to: &stderr)
    exit(1)
}

do {
    // Read numbers from file
    let filePath = CommandLine.arguments[1]
    let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
    let numbers = fileContent
        .components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

    // Sort the array
    let sortedNumbers = mergeSort(numbers)

    // Write sorted numbers back to file
    try sortedNumbers
        .map { String($0) }
        .joined(separator: "\n")
        .write(toFile: "sorted_data.txt", atomically: true, encoding: .utf8)
} catch {
    print("Error: \(error.localizedDescription)", to: &stderr)
    exit(1)
}

// MARK: - Tests
#if DEBUG
func isSorted<T: Comparable>(_ arr: [T]) -> Bool {
    for i in 1..<arr.count {
        if arr[i-1] > arr[i] {
            return false
        }
    }
    return true
}

// Test cases
func runTests() {
    // Test empty array
    let emptyArray: [Int] = []
    let emptyResult = mergeSort(emptyArray)
    assert(emptyResult.isEmpty)
    assert(isSorted(emptyResult))

    // Test single element
    let singleElement = [1]
    let singleResult = mergeSort(singleElement)
    assert(singleResult == [1])
    assert(isSorted(singleResult))

    // Test two elements
    let twoElements = [2, 1]
    let twoResult = mergeSort(twoElements)
    assert(twoResult == [1, 2])
    assert(isSorted(twoResult))

    // Test multiple elements
    let multipleElements = [5, 3, 8, 4, 2]
    let multipleResult = mergeSort(multipleElements)
    assert(multipleResult == [2, 3, 4, 5, 8])
    assert(isSorted(multipleResult))

    // Test duplicate elements
    let duplicateElements = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    let duplicateResult = mergeSort(duplicateElements)
    assert(isSorted(duplicateResult))

    // Test negative numbers
    let negativeNumbers = [-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5]
    let negativeResult = mergeSort(negativeNumbers)
    assert(isSorted(negativeResult))

    // Test large array
    let largeArray = (0..<1000).map { $0 % 1000 }
    let largeResult = mergeSort(largeArray)
    assert(isSorted(largeResult))

    // Test strings
    let strings = ["banana", "apple", "cherry", "date", "elderberry"]
    let stringResult = mergeSort(strings)
    assert(isSorted(stringResult))

    print("All tests passed!")
}

// Run tests if in debug mode
runTests()
#endif
