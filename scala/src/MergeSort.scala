/**
 * Implementation of merge sort algorithm in Scala
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 */
object MergeSort {
  /**
   * Sorts an array using merge sort algorithm.
   * @param arr The array to sort
   * @return The sorted array
   */
  def mergeSort[T: Ordering](arr: Array[T]): Array[T] = {
    if (arr.length <= 1) arr
    else {
      val mid = arr.length / 2
      val left = arr.slice(0, mid)
      val right = arr.slice(mid, arr.length)
      merge(mergeSort(left), mergeSort(right))
    }
  }

  /**
   * Merges two sorted arrays into a single sorted array.
   * @param left The left sorted array
   * @param right The right sorted array
   * @return The merged sorted array
   */
  private def merge[T: Ordering](left: Array[T], right: Array[T]): Array[T] = {
    val result = new Array[T](left.length + right.length)
    var i = 0
    var j = 0
    var k = 0
    val ord = implicitly[Ordering[T]]

    while (i < left.length && j < right.length) {
      if (ord.lteq(left(i), right(j))) {
        result(k) = left(i)
        i += 1
      } else {
        result(k) = right(j)
        j += 1
      }
      k += 1
    }

    while (i < left.length) {
      result(k) = left(i)
      i += 1
      k += 1
    }

    while (j < right.length) {
      result(k) = right(j)
      j += 1
      k += 1
    }

    result
  }

  /**
   * Checks if an array is sorted in ascending order.
   * @param arr The array to check
   * @return true if the array is sorted, false otherwise
   */
  def isSorted[T: Ordering](arr: Array[T]): Boolean = {
    val ord = implicitly[Ordering[T]]
    arr.sliding(2).forall { case Array(a, b) => ord.lteq(a, b) }
  }
}

/**
 * Main object for command-line interface and testing
 */
object Main {
  def main(args: Array[String]): Unit = {
    if (args.isEmpty) {
      println("Please provide an input file path")
      return
    }

    val file = args(0)
    val numbers = scala.io.Source.fromFile(file).getLines().map(_.toInt).toArray
    val sorted = MergeSort.mergeSort(numbers)
    java.nio.file.Files.write(
      java.nio.file.Paths.get("sorted_data.txt"),
      sorted.mkString("\n").getBytes
    )
  }
}

/**
 * Test suite
 */
object Tests {
  def runTests(): Boolean = {
    val testCases = List(
      "Empty array" -> (MergeSort.mergeSort(Array.empty[Int]).isEmpty),
      "Single element" -> (MergeSort.mergeSort(Array(1)).sameElements(Array(1))),
      "Two elements" -> (MergeSort.mergeSort(Array(2, 1)).sameElements(Array(1, 2))),
      "Multiple elements" -> (
        MergeSort.mergeSort(Array(5, 3, 8, 4, 2))
          .sameElements(Array(2, 3, 4, 5, 8))
      ),
      "Duplicate elements" -> (
        MergeSort.mergeSort(Array(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5))
          .sameElements(Array(1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9))
      ),
      "Negative numbers" -> (
        MergeSort.mergeSort(Array(-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5))
          .sameElements(Array(-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9))
      ),
      "Large array" -> {
        val largeArray = (1 to 1000).toArray
        MergeSort.isSorted(MergeSort.mergeSort(largeArray))
      },
      "Strings" -> (
        MergeSort.mergeSort(Array("banana", "apple", "cherry"))
          .sameElements(Array("apple", "banana", "cherry"))
      )
    )

    println("Running tests...")
    var allPassed = true

    testCases.foreach { case (name, test) =>
      val passed = test
      println(s"$name: ${if (passed) "PASSED" else "FAILED"}")
      if (!passed) allPassed = false
    }

    allPassed
  }
}

// Run tests if DEBUG is set
object TestRunner {
  def main(args: Array[String]): Unit = {
    if (sys.env.getOrElse("DEBUG", "0") == "1") {
      if (Tests.runTests()) {
        println("All tests passed!")
      } else {
        println("Some tests failed!")
      }
    } else {
      Main.main(args)
    }
  }
}
