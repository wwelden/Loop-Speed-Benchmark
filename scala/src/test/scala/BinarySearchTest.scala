package binarysearch

import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class BinarySearchTest extends AnyFlatSpec with Matchers {
  "BinarySearch" should "find target in middle" in {
    val arr = Array(1, 2, 3, 4, 5)
    BinarySearch.search(arr, 3) should be(2)
  }

  it should "find target at start" in {
    val arr = Array(1, 2, 3, 4, 5)
    BinarySearch.search(arr, 1) should be(0)
  }

  it should "find target at end" in {
    val arr = Array(1, 2, 3, 4, 5)
    BinarySearch.search(arr, 5) should be(4)
  }

  it should "return -1 when target not found" in {
    val arr = Array(1, 2, 3, 4, 5)
    BinarySearch.search(arr, 6) should be(-1)
  }

  it should "handle empty array" in {
    val arr = Array.empty[Int]
    BinarySearch.search(arr, 1) should be(-1)
  }

  it should "handle single element" in {
    val arr = Array(1)
    BinarySearch.search(arr, 1) should be(0)
  }

  it should "handle negative numbers" in {
    val arr = Array(-5, -3, -1, 0, 2)
    BinarySearch.search(arr, -3) should be(1)
  }

  it should "handle duplicate elements" in {
    val arr = Array(1, 2, 2, 2, 3)
    BinarySearch.search(arr, 2) should be(1)
  }

  it should "handle string arrays" in {
    val arr = Array("apple", "banana", "cherry", "date", "elderberry")
    BinarySearch.search(arr, "cherry") should be(2)
    BinarySearch.search(arr, "apple") should be(0)
    BinarySearch.search(arr, "elderberry") should be(4)
    BinarySearch.search(arr, "fig") should be(-1)
  }

  it should "handle null array" in {
    val arr: Array[Int] = null
    BinarySearch.search(arr, 1) should be(-1)
  }
}
