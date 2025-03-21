#include <iostream>
#include <random>
#include <vector>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Please provide a number as command line argument\n";
        return 1;
    }

    try {
        int input = std::stoi(argv[1]);           // Get an input number from the command line
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> dis(0, 9999);
        int r = dis(gen);                         // Get a random number 0 <= r < 10k
        std::vector<int> a(10000, 0);             // Array of 10k elements initialized to 0

        for (int i = 0; i < 10000; i++) {         // 10k outer loop iterations
            for (int j = 0; j < 100000; j++) {    // 100k inner loop iterations, per outer loop iteration
                a[i] = a[i] + j % input;          // Simple sum
            }
            a[i] += r;                            // Add a random value to each element in array
        }

        std::cout << a[r] << std::endl;           // Print out a single element from the array
    } catch (const std::invalid_argument& e) {
        std::cerr << "Please provide a valid integer\n";
        return 1;
    }

    return 0;
}
