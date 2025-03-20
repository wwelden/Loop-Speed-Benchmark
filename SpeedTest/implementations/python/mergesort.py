#!/usr/bin/env python3
import random
import time

def merge_sort(arr):
    if len(arr) <= 1:
        return arr

    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])

    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0

    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])
    return result

def generate_random_array(size):
    return [random.randint(1, 1000) for _ in range(size)]

def main():
    # Run 100 times with different random arrays
    for _ in range(100):
        arr = generate_random_array(1000)
        merge_sort(arr)

if __name__ == "__main__":
    main()
