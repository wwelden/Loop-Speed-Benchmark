#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Please provide a number as command line argument\n");
        return 1;
    }

    char* endptr;
    long input = strtol(argv[1], &endptr, 10);    // Get an input number from the command line
    if (*endptr != '\0') {
        fprintf(stderr, "Please provide a valid integer\n");
        return 1;
    }

    srand(time(NULL));
    int r = rand() % 10000;                       // Get a random number 0 <= r < 10k
    int a[10000] = {0};                          // Array of 10k elements initialized to 0

    for (int i = 0; i < 10000; i++) {            // 10k outer loop iterations
        for (int j = 0; j < 100000; j++) {       // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + j % input;             // Simple sum
        }
        a[i] += r;                               // Add a random value to each element in array
    }

    printf("%d\n", a[r]);                        // Print out a single element from the array
    return 0;
}
