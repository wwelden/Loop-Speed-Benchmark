/**
 * Implementation of merge sort algorithm in Kotlin
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 */

class MergeSort {
    /**
     * Sorts an array using merge sort algorithm.
     * @param arr The array to sort
     * @return The sorted array
     */
    fun <T : Comparable<T>> mergeSort(arr: Array<T>): Array<T> {
        if (arr.size <= 1) return arr

        val mid = arr.size / 2
        val left = arr.copyOfRange(0, mid)
        val right = arr.copyOfRange(mid, arr.size)

        return merge(mergeSort(left), mergeSort(right))
    }

    /**
     * Merges two sorted arrays into a single sorted array.
     * @param left The left sorted array
     * @param right The right sorted array
     * @return The merged sorted array
     */
    private fun <T : Comparable<T>> merge(left: Array<T>, right: Array<T>): Array<T> {
        val result = Array(left.size + right.size) { left[0] }
        var i = 0
        var j = 0
        var k = 0

        while (i < left.size && j < right.size) {
            if (left[i] <= right[j]) {
                result[k++] = left[i++]
            } else {
                result[k++] = right[j++]
            }
        }

        while (i < left.size) {
            result[k++] = left[i++]
        }

        while (j < right.size) {
            result[k++] = right[j++]
        }

        return result
    }

    /**
     * Checks if an array is sorted in ascending order.
     * @param arr The array to check
     * @return true if the array is sorted, false otherwise
     */
    fun <T : Comparable<T>> isSorted(arr: Array<T>): Boolean {
        for (i in 1 until arr.size) {
            if (arr[i - 1] > arr[i]) return false
        }
        return true
    }
}

/**
 * Main function for command-line interface
 */
fun main(args: Array<String>) {
    if (args.isEmpty()) {
        println("Please provide an input file path")
        return
    }

    val file = args[0]
    val numbers = java.io.File(file).readLines().map { it.toInt() }.toTypedArray()
    val sorter = MergeSort()
    val sorted = sorter.mergeSort(numbers)
    java.io.File("sorted_data.txt").writeText(sorted.joinToString("\n"))
}

/**
 * Test suite
 */
object Tests {
    private val sorter = MergeSort()

    fun runTests(): Boolean {
        val testCases = listOf(
            "Empty array" to { sorter.mergeSort(emptyArray<Int>()).isEmpty() },
            "Single element" to { sorter.mergeSort(arrayOf(1)).contentEquals(arrayOf(1)) },
            "Two elements" to { sorter.mergeSort(arrayOf(2, 1)).contentEquals(arrayOf(1, 2)) },
            "Multiple elements" to {
                sorter.mergeSort(arrayOf(5, 3, 8, 4, 2))
                    .contentEquals(arrayOf(2, 3, 4, 5, 8))
            },
            "Duplicate elements" to {
                sorter.mergeSort(arrayOf(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5))
                    .contentEquals(arrayOf(1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9))
            },
            "Negative numbers" to {
                sorter.mergeSort(arrayOf(-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5))
                    .contentEquals(arrayOf(-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9))
            },
            "Large array" to {
                val largeArray = Array(1000) { it }
                sorter.isSorted(sorter.mergeSort(largeArray))
            },
            "Strings" to {
                sorter.mergeSort(arrayOf("banana", "apple", "cherry"))
                    .contentEquals(arrayOf("apple", "banana", "cherry"))
            }
        )

        println("Running tests...")
        var allPassed = true

        testCases.forEach { (name, test) ->
            val passed = test()
            println("$name: ${if (passed) "PASSED" else "FAILED"}")
            if (!passed) allPassed = false
        }

        return allPassed
    }
}

// Run tests if DEBUG is set
@JvmStatic
fun main(args: Array<String>) {
    if (System.getenv("DEBUG") == "1") {
        if (Tests.runTests()) {
            println("All tests passed!")
        } else {
            println("Some tests failed!")
        }
    } else {
        main(args)
    }
}
