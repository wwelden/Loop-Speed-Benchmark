--[[
Implementation of merge sort algorithm in Lua
Time complexity: O(n log n)
Space complexity: O(n)
]]

-- Helper function to merge two sorted arrays
local function merge(left, right)
    local result = {}
    local i, j, k = 1, 1, 1
    local left_len, right_len = #left, #right

    -- Compare elements from both arrays and merge them
    while i <= left_len and j <= right_len do
        if left[i] <= right[j] then
            result[k] = left[i]
            i = i + 1
        else
            result[k] = right[j]
            j = j + 1
        end
        k = k + 1
    end

    -- Copy remaining elements from left array
    while i <= left_len do
        result[k] = left[i]
        i = i + 1
        k = k + 1
    end

    -- Copy remaining elements from right array
    while j <= right_len do
        result[k] = right[j]
        j = j + 1
        k = k + 1
    end

    return result
end

-- Main merge sort function
local function mergeSort(arr)
    local len = #arr
    if len <= 1 then
        return arr
    end

    -- Split array into two halves
    local mid = math.floor(len / 2)
    local left = {}
    local right = {}

    -- Copy elements to left and right arrays
    for i = 1, mid do
        left[i] = arr[i]
    end
    for i = mid + 1, len do
        right[i - mid] = arr[i]
    end

    -- Recursively sort both halves
    left = mergeSort(left)
    right = mergeSort(right)

    -- Merge the sorted halves
    return merge(left, right)
end

-- Function to check if an array is sorted
local function isSorted(arr)
    for i = 2, #arr do
        if arr[i-1] > arr[i] then
            return false
        end
    end
    return true
end

-- Function to read numbers from file
local function readNumbersFromFile(filename)
    local numbers = {}
    local file = io.open(filename, "r")
    if file then
        for line in file:lines() do
            table.insert(numbers, tonumber(line))
        end
        file:close()
    end
    return numbers
end

-- Function to write numbers to file
local function writeNumbersToFile(filename, numbers)
    local file = io.open(filename, "w")
    if file then
        for _, num in ipairs(numbers) do
            file:write(num, "\n")
        end
        file:close()
    end
end

-- Main function for command-line interface
local function main()
    if #arg < 1 then
        print("Please provide an input file path")
        return
    end

    local filename = arg[1]
    local numbers = readNumbersFromFile(filename)
    if #numbers > 0 then
        local sorted = mergeSort(numbers)
        writeNumbersToFile("sorted_data.txt", sorted)
    end
end

-- Test suite
local function runTests()
    local testCases = {
        {
            name = "Empty array",
            input = {},
            expected = {},
            test = function(input, expected)
                local result = mergeSort(input)
                return #result == 0
            end
        },
        {
            name = "Single element",
            input = {1},
            expected = {1},
            test = function(input, expected)
                local result = mergeSort(input)
                return #result == 1 and result[1] == 1
            end
        },
        {
            name = "Two elements",
            input = {2, 1},
            expected = {1, 2},
            test = function(input, expected)
                local result = mergeSort(input)
                return result[1] == 1 and result[2] == 2
            end
        },
        {
            name = "Multiple elements",
            input = {5, 3, 8, 4, 2},
            expected = {2, 3, 4, 5, 8},
            test = function(input, expected)
                local result = mergeSort(input)
                for i = 1, #expected do
                    if result[i] ~= expected[i] then
                        return false
                    end
                end
                return true
            end
        },
        {
            name = "Duplicate elements",
            input = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5},
            expected = {1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9},
            test = function(input, expected)
                local result = mergeSort(input)
                for i = 1, #expected do
                    if result[i] ~= expected[i] then
                        return false
                    end
                end
                return true
            end
        },
        {
            name = "Negative numbers",
            input = {-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5},
            expected = {-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9},
            test = function(input, expected)
                local result = mergeSort(input)
                for i = 1, #expected do
                    if result[i] ~= expected[i] then
                        return false
                    end
                end
                return true
            end
        },
        {
            name = "Large array",
            input = {},
            expected = {},
            test = function()
                local largeArray = {}
                for i = 1000, 1, -1 do
                    table.insert(largeArray, i)
                end
                local result = mergeSort(largeArray)
                return isSorted(result)
            end
        },
        {
            name = "Strings",
            input = {"banana", "apple", "cherry"},
            expected = {"apple", "banana", "cherry"},
            test = function(input, expected)
                local result = mergeSort(input)
                for i = 1, #expected do
                    if result[i] ~= expected[i] then
                        return false
                    end
                end
                return true
            end
        }
    }

    print("Running tests...")
    local allPassed = true

    for _, testCase in ipairs(testCases) do
        local passed = testCase.test(testCase.input, testCase.expected)
        print(string.format("%s: %s", testCase.name, passed and "PASSED" or "FAILED"))
        if not passed then
            allPassed = false
        end
    end

    return allPassed
end

-- Run tests if DEBUG is set
if os.getenv("DEBUG") == "1" then
    if runTests() then
        print("All tests passed!")
    else
        print("Some tests failed!")
    end
else
    main()
end
