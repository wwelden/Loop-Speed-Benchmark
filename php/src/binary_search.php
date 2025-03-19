<?php

/**
 * Binary Search Implementation in PHP
 *
 * @param array $arr A sorted array of integers
 * @param int $target The value to search for
 * @return int The index of target if found, -1 otherwise
 *
 * Time Complexity: O(log n)
 * Space Complexity: O(1)
 */
function binarySearch(array $arr, int $target): int {
    if (empty($arr)) {
        return -1;
    }

    $left = 0;
    $right = count($arr) - 1;

    while ($left <= $right) {
        $mid = (int)(($left + $right) / 2);

        if ($arr[$mid] === $target) {
            return $mid;
        } elseif ($arr[$mid] < $target) {
            $left = $mid + 1;
        } else {
            if ($mid === 0) {
                break;
            }
            $right = $mid - 1;
        }
    }

    return -1;
}

// Read test data from file
function main(): void {
    $filename = $argc > 1 ? $argv[1] : 'test_data.txt';
    $data = array_map('intval', file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES));

    // Test with a few values
    $testValues = [
        $data[count($data) / 2],  // Middle value
        $data[0],                 // First value
        $data[count($data) - 1],  // Last value
        -999999                  // Value not in array
    ];

    foreach ($testValues as $target) {
        $result = binarySearch($data, $target);
        echo sprintf("Target: %d, Result: %d\n", $target, $result);
    }
}

main();
