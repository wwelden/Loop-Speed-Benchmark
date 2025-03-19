#!/usr/bin/env php
<?php

function merge(&$arr, $left, $right) {
    $i = $j = $k = 0;

    while ($i < count($left) && $j < count($right)) {
        if ($left[$i] <= $right[$j]) {
            $arr[$k] = $left[$i];
            $i++;
        } else {
            $arr[$k] = $right[$j];
            $j++;
        }
        $k++;
    }

    while ($i < count($left)) {
        $arr[$k] = $left[$i];
        $i++;
        $k++;
    }

    while ($j < count($right)) {
        $arr[$k] = $right[$j];
        $j++;
        $k++;
    }
}

function mergeSort(&$arr) {
    if (count($arr) <= 1) {
        return;
    }

    $mid = floor(count($arr) / 2);
    $left = array_slice($arr, 0, $mid);
    $right = array_slice($arr, $mid);

    mergeSort($left);
    mergeSort($right);

    merge($arr, $left, $right);
}

function generateRandomArray($size) {
    return array_map(function() {
        return rand(0, 9999);
    }, array_fill(0, $size, null));
}

$ARRAY_SIZE = 1000;
$ITERATIONS = 100;

for ($i = 0; $i < $ITERATIONS; $i++) {
    $arr = generateRandomArray($ARRAY_SIZE);
    mergeSort($arr);
}
