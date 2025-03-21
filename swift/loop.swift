import Foundation

guard CommandLine.arguments.count > 1,
      let input = Int(CommandLine.arguments[1]) else {  // Get an input number from the command line
    print("Please provide a valid integer")
    exit(1)
}

let r = Int.random(in: 0..<10000)                      // Get a random number 0 <= r < 10k
var a = Array(repeating: 0, count: 10000)              // Array of 10k elements initialized to 0

for i in 0..<10000 {                                   // 10k outer loop iterations
    for j in 0..<100000 {                             // 100k inner loop iterations, per outer loop iteration
        a[i] = a[i] + j % input                       // Simple sum
    }
    a[i] += r                                         // Add a random value to each element in array
}

print(a[r])                                           // Print out a single element from the array
