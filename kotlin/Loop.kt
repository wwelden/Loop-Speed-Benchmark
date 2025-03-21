fun main(args: Array<String>) {
    if (args.isEmpty()) {
        System.err.println("Please provide a number as command line argument")
        System.exit(1)
    }

    try {
        val input = args[0].toInt()                    // Get an input number from the command line
        val r = (0 until 10000).random()              // Get a random number 0 <= r < 10k
        val a = IntArray(10000)                       // Array of 10k elements initialized to 0

        for (i in 0 until 10000) {                    // 10k outer loop iterations
            for (j in 0 until 100000) {               // 100k inner loop iterations, per outer loop iteration
                a[i] = a[i] + j % input               // Simple sum
            }
            a[i] += r                                 // Add a random value to each element in array
        }

        println(a[r])                                 // Print out a single element from the array
    } catch (e: NumberFormatException) {
        System.err.println("Please provide a valid integer")
        System.exit(1)
    }
}
