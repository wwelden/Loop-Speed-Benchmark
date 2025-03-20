fun merge(arr: IntArray, left: IntArray, right: IntArray) {
    var i = 0
    var j = 0
    var k = 0

    while (i < left.size && j < right.size) {
        if (left[i] <= right[j]) {
            arr[k] = left[i]
            i++
        } else {
            arr[k] = right[j]
            j++
        }
        k++
    }

    while (i < left.size) {
        arr[k] = left[i]
        i++
        k++
    }

    while (j < right.size) {
        arr[k] = right[j]
        j++
        k++
    }
}

fun mergeSort(arr: IntArray) {
    if (arr.size <= 1) {
        return
    }

    val mid = arr.size / 2
    val left = arr.copyOfRange(0, mid)
    val right = arr.copyOfRange(mid, arr.size)

    mergeSort(left)
    mergeSort(right)

    merge(arr, left, right)
}

fun generateRandomArray(size: Int): IntArray {
    return IntArray(size) { (0..9999).random() }
}

fun main() {
    val ARRAY_SIZE = 1000
    val ITERATIONS = 100

    repeat(ITERATIONS) {
        val arr = generateRandomArray(ARRAY_SIZE)
        mergeSort(arr)
    }
}
