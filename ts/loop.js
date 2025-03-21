#!/usr/bin/env node
/// <reference types="node" />
function main() {
    var input = parseInt(process.argv[2]); // Get an input number from the command line
    if (isNaN(input)) {
        console.error("Please provide a valid integer");
        process.exit(1);
    }
    var u = input;
    var r = Math.floor(Math.random() * 10000); // Get a random number 0 <= r < 10k
    var a = new Int32Array(10000); // Array of 10k elements initialized to 0
    for (var i = 0; i < 10000; i++) { // 10k outer loop iterations
        for (var j = 0; j < 100000; j++) { // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + j % u; // Simple sum
        }
        a[i] += r; // Add a random value to each element in array
    }
    console.log(a[r]); // Print out a single element from the array
}
main();
