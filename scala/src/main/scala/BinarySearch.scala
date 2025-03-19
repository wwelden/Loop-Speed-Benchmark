package binarysearch

/**
 * Binary Search Implementation in Scala
 *
 * @param arr A sorted array of integers
 * @param target The value to search for
 * @return The index of target if found, -1 otherwise
 *
 * Time Complexity: O(log n)
 * Space Complexity: O(1)
 */
object BinarySearch {
  def search[T: Ordering](arr: Array[T], target: T): Int = {
    if (arr == null || arr.isEmpty) {
      return -1
    }

    val ord = implicitly[Ordering[T]]
    var left = 0
    var right = arr.length - 1

    while (left <= right) {
      val mid = (left + right) / 2

      ord.compare(arr(mid), target) match {
        case 0 => return mid
        case x if x < 0 => left = mid + 1
        case _ =>
          if (mid == 0) return -1
          right = mid - 1
      }
    }

    -1
  }

  def main(args: Array[String]): Unit = {
    // Test cases
    val testCases = Seq(
      (Array(1, 2, 3, 4, 5), 3),    // Target in middle
      (Array(1, 2, 3, 4, 5), 1),    // Target at start
      (Array(1, 2, 3, 4, 5), 5),    // Target at end
      (Array(1, 2, 3, 4, 5), 6),    // Target not present
      (Array.empty[Int], 1),         // Empty array
      (Array(1), 1)                  // Single element
    )

    for ((arr, target) <- testCases) {
      val result = search(arr, target)
      println(s"Array: [${arr.mkString(", ")}], Target: $target, Result: $result")
    }

    // Test with strings
    val stringTestCases = Seq(
      (Array("apple", "banana", "cherry", "date", "elderberry"), "cherry"),
      (Array("apple", "banana", "cherry", "date", "elderberry"), "apple"),
      (Array("apple", "banana", "cherry", "date", "elderberry"), "elderberry")
    )

    println("\nTesting with strings:")
    for ((arr, target) <- stringTestCases) {
      val result = search(arr, target)
      println(s"Array: [${arr.mkString(", ")}], Target: $target, Result: $result")
    }
  }
}
