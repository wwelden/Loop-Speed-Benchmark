import { binarySearch } from '../src/binary_search';

describe('binarySearch', () => {
    test('should find target in middle of array', () => {
        expect(binarySearch([1, 2, 3, 4, 5], 3)).toBe(2);
    });

    test('should find target at start of array', () => {
        expect(binarySearch([1, 2, 3, 4, 5], 1)).toBe(0);
    });

    test('should find target at end of array', () => {
        expect(binarySearch([1, 2, 3, 4, 5], 5)).toBe(4);
    });

    test('should return -1 when target not present', () => {
        expect(binarySearch([1, 2, 3, 4, 5], 6)).toBe(-1);
    });

    test('should handle empty array', () => {
        expect(binarySearch([], 1)).toBe(-1);
    });

    test('should handle single element array', () => {
        expect(binarySearch([1], 1)).toBe(0);
    });

    test('should handle negative numbers', () => {
        expect(binarySearch([-5, -3, -1, 0, 2], -3)).toBe(1);
    });

    test('should handle duplicate elements (returns first occurrence)', () => {
        expect(binarySearch([1, 2, 2, 2, 3], 2)).toBe(1);
    });

    test('should handle null or undefined array', () => {
        expect(binarySearch(null as unknown as number[], 1)).toBe(-1);
        expect(binarySearch(undefined as unknown as number[], 1)).toBe(-1);
    });
});
