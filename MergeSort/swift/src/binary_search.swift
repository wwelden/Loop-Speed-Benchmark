/// Performs binary search to find the index of target in a sorted array.
///
/// - Parameters:
///   - arr: A sorted array of integers
///   - target: The value to search for
/// - Returns: The index of target if found, nil otherwise
///
/// - Complexity:
///   - Time: O(log n)
///   - Space: O(1)
func binarySearch<T: Comparable>(_ arr: [T], target: T) -> Int? {
    guard !arr.isEmpty else {
        return nil
    }

    var left = 0
    var right = arr.count - 1

    while left <= right {
        let mid = (left + right) / 2

        if arr[mid] == target {
            return mid
        } else if arr[mid] < target {
            left = mid + 1
        } else {
            if mid == 0 {
                break
            }
            right = mid - 1
        }
    }

    return nil
}

// Example usage
func main() {
    // Test cases
    let testCases: [(arr: [Int], target: Int)] = [
        ([1, 2, 3, 4, 5], 3),    // Target in middle
        ([1, 2, 3, 4, 5], 1),    // Target at start
        ([1, 2, 3, 4, 5], 5),    // Target at end
        ([1, 2, 3, 4, 5], 6),    // Target not present
        ([], 1),                  // Empty array
        ([1], 1)                  // Single element
    ]

    for (arr, target) in testCases {
        let result = binarySearch(arr, target: target)
        print("Array: \(arr), Target: \(target), Result: \(String(describing: result))")
    }

    // Test with strings
    let stringTestCases: [(arr: [String], target: String)] = [
        (["apple", "banana", "cherry", "date", "elderberry"], "cherry"),
        (["apple", "banana", "cherry", "date", "elderberry"], "apple"),
        (["apple", "banana", "cherry", "date", "elderberry"], "elderberry")
    ]

    print("\nTesting with strings:")
    for (arr, target) in stringTestCases {
        let result = binarySearch(arr, target: target)
        print("Array: \(arr), Target: \(target), Result: \(String(describing: result))")
    }
}

main()
