#!/usr/bin/env node

function mergeSort(arr) {
    if (arr.length <= 1) {
        return arr;
    }

    const mid = Math.floor(arr.length / 2);
    const left = mergeSort(arr.slice(0, mid));
    const right = mergeSort(arr.slice(mid));

    return merge(left, right);
}

function merge(left, right) {
    const result = [];
    let i = 0;
    let j = 0;

    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            result.push(left[i]);
            i++;
        } else {
            result.push(right[j]);
            j++;
        }
    }

    return result.concat(left.slice(i)).concat(right.slice(j));
}

function generateRandomArray(size) {
    return Array.from({ length: size }, () => Math.floor(Math.random() * 1000) + 1);
}

function main() {
    // Run 100 times with different random arrays
    for (let i = 0; i < 100; i++) {
        const arr = generateRandomArray(1000);
        mergeSort(arr);
    }
}

main();
