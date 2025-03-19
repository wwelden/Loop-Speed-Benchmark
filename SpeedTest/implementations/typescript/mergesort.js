function merge(arr, left, right) {
    var i = 0, j = 0, k = 0;
    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            arr[k] = left[i];
            i++;
        }
        else {
            arr[k] = right[j];
            j++;
        }
        k++;
    }
    while (i < left.length) {
        arr[k] = left[i];
        i++;
        k++;
    }
    while (j < right.length) {
        arr[k] = right[j];
        j++;
        k++;
    }
}
function mergeSort(arr) {
    if (arr.length <= 1) {
        return;
    }
    var mid = Math.floor(arr.length / 2);
    var left = arr.slice(0, mid);
    var right = arr.slice(mid);
    mergeSort(left);
    mergeSort(right);
    merge(arr, left, right);
}
function generateRandomArray(size) {
    return Array.from({ length: size }, function () { return Math.floor(Math.random() * 10000); });
}
var ARRAY_SIZE = 1000;
var ITERATIONS = 100;
for (var i = 0; i < ITERATIONS; i++) {
    var arr = generateRandomArray(ARRAY_SIZE);
    mergeSort(arr);
}
