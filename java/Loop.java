import java.util.Random;

public class Loop {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Please provide a number as command line argument");
            System.exit(1);
        }

        try {
            int input = Integer.parseInt(args[0]); // Get an input number from the command line
            Random rand = new Random();
            int r = rand.nextInt(10000);          // Get a random number 0 <= r < 10k
            int[] a = new int[10000];             // Array of 10k elements initialized to 0

            for (int i = 0; i < 10000; i++) {     // 10k outer loop iterations
                for (int j = 0; j < 100000; j++) { // 100k inner loop iterations, per outer loop iteration
                    a[i] = a[i] + j % input;      // Simple sum
                }
                a[i] += r;                        // Add a random value to each element in array
            }

            System.out.println(a[r]);             // Print out a single element from the array
        } catch (NumberFormatException e) {
            System.err.println("Please provide a valid integer");
            System.exit(1);
        }
    }
}
