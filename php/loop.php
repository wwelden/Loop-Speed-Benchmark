#!/usr/bin/env php
<?php

if ($argc < 2) {
    fwrite(STDERR, "Please provide a number as command line argument\n");
    exit(1);
}

if (!is_numeric($argv[1])) {
    fwrite(STDERR, "Please provide a valid integer\n");
    exit(1);
}

$input = intval($argv[1]);                    // Get an input number from the command line
$r = random_int(0, 9999);                     // Get a random number 0 <= r < 10k
$a = array_fill(0, 10000, 0);                // Array of 10k elements initialized to 0

for ($i = 0; $i < 10000; $i++) {             // 10k outer loop iterations
    for ($j = 0; $j < 100000; $j++) {        // 100k inner loop iterations, per outer loop iteration
        $a[$i] = $a[$i] + $j % $input;       // Simple sum
    }
    $a[$i] += $r;                            // Add a random value to each element in array
}

echo $a[$r] . "\n";                          // Print out a single element from the array
