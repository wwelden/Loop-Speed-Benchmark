import Foundation

// Helper function to merge two sorted arrays
func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var result: [T] = []
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
    while i < left.count {
        result.append(left[i])
        i += 1
    }

    // Copy remaining elements from right array
    while j < right.count {
        result.append(right[j])
        j += 1
    }

    return result
}

// Main merge sort function
func mergeSort<T: Comparable>(_ arr: [T]) -> [T] {
    let len = arr.count
    if len <= 1 {
        return arr
    }

    // Split array into two halves
    let mid = len / 2
    let left = Array(arr[..<mid])
    let right = Array(arr[mid...])

    // Recursively sort both halves
    let leftSorted = mergeSort(left)
    let rightSorted = mergeSort(right)

    // Merge the sorted halves
    return merge(leftSorted, rightSorted)
}

// Function to check if an array is sorted
func isSorted<T: Comparable>(_ arr: [T]) -> Bool {
    for i in 1..<arr.count {
        if arr[i-1] > arr[i] {
            return false
        }
    }
    return true
}

// Function to read numbers from file
func readNumbersFromFile(_ filename: String) -> [Int] {
    guard let contents = try? String(contentsOfFile: filename, encoding: .utf8) else {
        print("Error: Could not read file \(filename)")
        return []
    }
    return contents.components(separatedBy: .newlines)
        .compactMap { Int($0) }
}

// Function to write numbers to file
func writeNumbersToFile(_ filename: String, numbers: [Int]) {
    let contents = numbers.map { String($0) }.joined(separator: "\n")
    try? contents.write(toFile: filename, atomically: true, encoding: .utf8)
}

// Main function
func main() {
    guard CommandLine.arguments.count > 1 else {
        print("Please provide an input file path")
        return
    }

    let filename = CommandLine.arguments[1]
    let numbers = readNumbersFromFile(filename)

    if !numbers.isEmpty {
        let sorted = mergeSort(numbers)
        writeNumbersToFile("sorted_data.txt", numbers: sorted)
    }
}

// Run main function
main()
