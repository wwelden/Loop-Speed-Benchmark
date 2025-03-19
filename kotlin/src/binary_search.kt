/**
 * Binary search implementation in Kotlin.
 * Time complexity: O(log n)
 * Space complexity: O(1)
 *
 * @param arr The sorted array to search in
 * @param target The value to find
 * @return The index of the target if found, -1 otherwise
 */
fun binarySearch(arr: List<Int>, target: Int): Int {
    var left = 0
    var right = arr.size - 1

    while (left <= right) {
        val mid = left + (right - left) / 2
        when {
            arr[mid] == target -> return mid
            arr[mid] < target -> left = mid + 1
            else -> right = mid - 1
        }
    }
    return -1
}

fun main(args: Array<String>) {
    if (args.isEmpty()) {
        println("Please provide a file path as an argument")
        return
    }

    val numbers = java.io.File(args[0]).readLines().map { it.toInt() }
    val target = 42 // Example target value

    val result = binarySearch(numbers, target)
    if (result != -1) {
        println("Found $target at index $result")
    } else {
        println("$target not found in the array")
    }
}
