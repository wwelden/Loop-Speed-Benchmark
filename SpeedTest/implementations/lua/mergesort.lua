#!/usr/bin/env lua

function merge(arr, left, right)
    local i, j, k = 1, 1, 1

    while i <= #left and j <= #right do
        if left[i] <= right[j] then
            arr[k] = left[i]
            i = i + 1
        else
            arr[k] = right[j]
            j = j + 1
        end
        k = k + 1
    end

    while i <= #left do
        arr[k] = left[i]
        i = i + 1
        k = k + 1
    end

    while j <= #right do
        arr[k] = right[j]
        j = j + 1
        k = k + 1
    end
end

function mergeSort(arr)
    if #arr <= 1 then
        return
    end

    local mid = math.floor(#arr / 2)
    local left = {}
    local right = {}

    for i = 1, mid do
        left[i] = arr[i]
    end

    for i = mid + 1, #arr do
        right[i - mid] = arr[i]
    end

    mergeSort(left)
    mergeSort(right)

    merge(arr, left, right)
end

function generateRandomArray(size)
    local arr = {}
    for i = 1, size do
        arr[i] = math.random(0, 9999)
    end
    return arr
end

math.randomseed(os.time())
local ARRAY_SIZE = 1000
local ITERATIONS = 100

for _ = 1, ITERATIONS do
    local arr = generateRandomArray(ARRAY_SIZE)
    mergeSort(arr)
end
