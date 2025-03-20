function merge(arr: number[], left: number[], right: number[]): void {
    let i = 0, j = 0, k = 0;

    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            arr[k] = left[i];
            i++;
        } else {
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

function mergeSort(arr: number[]): void {
    if (arr.length <= 1) {
        return;
    }

    const mid = Math.floor(arr.length / 2);
    const left = arr.slice(0, mid);
    const right = arr.slice(mid);

    mergeSort(left);
    mergeSort(right);

    merge(arr, left, right);
}

function generateRandomArray(size: number): number[] {
    return Array.from({ length: size }, () => Math.floor(Math.random() * 10000));
}

const ARRAY_SIZE = 1000;
const ITERATIONS = 100;

for (let i = 0; i < ITERATIONS; i++) {
    const arr = generateRandomArray(ARRAY_SIZE);
    mergeSort(arr);
}
