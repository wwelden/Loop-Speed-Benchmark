import Foundation

/// Merge sort implementation in Swift
/// Time complexity: O(n log n)
/// Space complexity: O(n)
func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {
        return arr
    }

    let mid = arr.count / 2
    let left = Array(arr[..<mid])
    let right = Array(arr[mid...])

    return merge(mergeSort(left), mergeSort(right))
}

/// Helper function to merge two sorted arrays
func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result: [Int] = []
    var leftIndex = 0
    var rightIndex = 0

    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] <= right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        } else {
            result.append(right[rightIndex])
            rightIndex += 1
        }
    }

    // Add remaining elements
    result.append(contentsOf: left[leftIndex...])
    result.append(contentsOf: right[rightIndex...])

    return result
}

// Main program
do {
    // Check if file path is provided
    guard CommandLine.arguments.count > 1 else {
        fputs("Please provide a file path as an argument\n", stderr)
        exit(1)
    }

    // Read numbers from file
    let filePath = CommandLine.arguments[1]
    let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
    let numbers = fileContent
        .components(separatedBy: CharacterSet.newlines)
        .filter { !$0.isEmpty }
        .compactMap { Int($0.trimmingCharacters(in: CharacterSet.whitespaces)) }

    // Sort the array
    let sortedNumbers = mergeSort(numbers)

    // Write sorted numbers back to file
    try sortedNumbers
        .map { String($0) }
        .joined(separator: "\n")
        .data(using: .utf8)?
        .write(to: URL(fileURLWithPath: "sorted_data.txt"))
} catch {
    fputs("Error: \(error)\n", stderr)
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
