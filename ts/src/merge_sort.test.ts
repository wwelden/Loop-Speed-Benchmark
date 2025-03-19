import { mergeSort } from './merge_sort';

describe('mergeSort', () => {
    test('should sort an empty array', () => {
        expect(mergeSort([])).toEqual([]);
    });

    test('should sort an array with one element', () => {
        expect(mergeSort([1])).toEqual([1]);
    });

    test('should sort an array with two elements', () => {
        expect(mergeSort([2, 1])).toEqual([1, 2]);
    });

    test('should sort an array with multiple elements', () => {
        expect(mergeSort([5, 3, 8, 4, 2])).toEqual([2, 3, 4, 5, 8]);
    });

    test('should sort an array with duplicate elements', () => {
        expect(mergeSort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])).toEqual([1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]);
    });

    test('should sort an array with negative numbers', () => {
        expect(mergeSort([-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5])).toEqual([-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9]);
    });

    test('should sort a large array', () => {
        const largeArray = Array.from({ length: 1000 }, () => Math.floor(Math.random() * 1000));
        const sortedArray = [...largeArray].sort((a, b) => a - b);
        expect(mergeSort(largeArray)).toEqual(sortedArray);
    });
});
