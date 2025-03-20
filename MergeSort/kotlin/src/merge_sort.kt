fun mergeSort(arr: IntArray): IntArray {
    if (arr.size <= 1) return arr

    val mid = arr.size / 2
    val left = arr.copyOfRange(0, mid)
    val right = arr.copyOfRange(mid, arr.size)

    return merge(mergeSort(left), mergeSort(right))
}

fun merge(left: IntArray, right: IntArray): IntArray {
    val result = IntArray(left.size + right.size)
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

fun main(args: Array<String>) {
    if (args.isEmpty()) {
        println("Please provide an input file path")
        return
    }

    val file = args[0]
    val numbers = java.io.File(file).readLines().map { it.toInt() }.toIntArray()
    val sorted = mergeSort(numbers)
    java.io.File("sorted_data.txt").writeText(sorted.joinToString("\n"))
}
