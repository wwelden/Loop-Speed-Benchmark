<?php

require_once 'merge_sort.php';

/**
 * Helper function to check if array is sorted
 *
 * @param array $arr The array to check
 * @return bool Whether the array is sorted
 */
function isSorted(array $arr): bool {
    for ($i = 1; $i < count($arr); $i++) {
        if ($arr[$i-1] > $arr[$i]) return false;
    }
    return true;
}

function testEmptyArray() {
    $arr = [];
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Empty array test passed\n";
}

function testSingleElement() {
    $arr = [1];
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Single element test passed\n";
}

function testTwoElements() {
    $arr = [2, 1];
    $result = mergeSort($arr);
    assert(isSorted($result));
    assert($result[0] === 1 && $result[1] === 2);
    echo "Two elements test passed\n";
}

function testMultipleElements() {
    $arr = [5, 3, 8, 4, 2];
    $result = mergeSort($arr);
    assert(isSorted($result));
    assert($result[0] === 2 && $result[1] === 3 && $result[2] === 4 && $result[3] === 5 && $result[4] === 8);
    echo "Multiple elements test passed\n";
}

function testDuplicateElements() {
    $arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Duplicate elements test passed\n";
}

function testNegativeNumbers() {
    $arr = [-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5];
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Negative numbers test passed\n";
}

function testLargeArray() {
    $size = 1000;
    $arr = array_map(function() { return rand(0, 999); }, range(0, $size - 1));
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Large array test passed\n";
}

function testStrings() {
    $arr = ["banana", "apple", "cherry", "date", "elderberry"];
    $result = mergeSort($arr);
    assert(isSorted($result));
    echo "Strings test passed\n";
}

// Run all tests
testEmptyArray();
testSingleElement();
testTwoElements();
testMultipleElements();
testDuplicateElements();
testNegativeNumbers();
testLargeArray();
testStrings();

echo "All tests passed!\n";
