local binarySearch = require("../src/binary_search")

-- Test helper function
local function assertEqual(expected, actual, message)
    if expected ~= actual then
        error(string.format("%s: expected %s, got %s", message, tostring(expected), tostring(actual)))
    end
end

-- Test cases
local function runTests()
    -- Test with target in middle
    assertEqual(3, binarySearch({1, 2, 3, 4, 5}, 3), "Should find target in middle")

    -- Test with target at start
    assertEqual(1, binarySearch({1, 2, 3, 4, 5}, 1), "Should find target at start")

    -- Test with target at end
    assertEqual(5, binarySearch({1, 2, 3, 4, 5}, 5), "Should find target at end")

    -- Test with target not present
    assertEqual(nil, binarySearch({1, 2, 3, 4, 5}, 6), "Should return nil when target not found")

    -- Test with empty array
    assertEqual(nil, binarySearch({}, 1), "Should handle empty array")

    -- Test with single element
    assertEqual(1, binarySearch({1}, 1), "Should handle single element")

    -- Test with negative numbers
    assertEqual(2, binarySearch({-5, -3, -1, 0, 2}, -3), "Should handle negative numbers")

    -- Test with duplicate elements (should return first occurrence)
    assertEqual(2, binarySearch({1, 2, 2, 2, 3}, 2), "Should find first occurrence")

    print("All tests passed!")
end

-- Run tests
local success, err = pcall(runTests)
if not success then
    print("Test failed: " .. tostring(err))
    os.exit(1)
end
