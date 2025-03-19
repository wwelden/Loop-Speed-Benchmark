#!/usr/bin/env swift

func merge(_ arr: inout [Int], _ left: [Int], _ right: [Int]) {
    var i = 0
    var j = 0
    var k = 0

    while i < left.count && j < right.count {
        if left[i] <= right[j] {
            arr[k] = left[i]
            i += 1
        } else {
            arr[k] = right[j]
            j += 1
        }
        k += 1
    }

    while i < left.count {
        arr[k] = left[i]
        i += 1
        k += 1
    }

    while j < right.count {
        arr[k] = right[j]
        j += 1
        k += 1
    }
}

func mergeSort(_ arr: inout [Int]) {
    if arr.count <= 1 {
        return
    }

    let mid = arr.count / 2
    var left = Array(arr[..<mid])
    var right = Array(arr[mid...])

    mergeSort(&left)
    mergeSort(&right)

    merge(&arr, left, right)
}

func generateRandomArray(size: Int) -> [Int] {
    return (0..<size).map { _ in Int.random(in: 0..<10000) }
}

let ARRAY_SIZE = 1000
let ITERATIONS = 100

for _ in 0..<ITERATIONS {
    var arr = generateRandomArray(size: ARRAY_SIZE)
    mergeSort(&arr)
}
