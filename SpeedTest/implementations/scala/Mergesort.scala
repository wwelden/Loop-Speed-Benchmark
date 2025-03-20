object Mergesort {
  def merge(arr: Array[Int], left: Array[Int], right: Array[Int]): Unit = {
    var i = 0
    var j = 0
    var k = 0

    while (i < left.length && j < right.length) {
      if (left(i) <= right(j)) {
        arr(k) = left(i)
        i += 1
      } else {
        arr(k) = right(j)
        j += 1
      }
      k += 1
    }

    while (i < left.length) {
      arr(k) = left(i)
      i += 1
      k += 1
    }

    while (j < right.length) {
      arr(k) = right(j)
      j += 1
      k += 1
    }
  }

  def mergeSort(arr: Array[Int]): Unit = {
    if (arr.length <= 1) {
      return
    }

    val mid = arr.length / 2
    val left = arr.slice(0, mid)
    val right = arr.slice(mid, arr.length)

    mergeSort(left)
    mergeSort(right)

    merge(arr, left, right)
  }

  def generateRandomArray(size: Int): Array[Int] = {
    Array.fill(size)(scala.util.Random.nextInt(10000))
  }

  def main(args: Array[String]): Unit = {
    val ARRAY_SIZE = 1000
    val ITERATIONS = 100

    for (_ <- 1 to ITERATIONS) {
      val arr = generateRandomArray(ARRAY_SIZE)
      mergeSort(arr)
    }
  }
}
