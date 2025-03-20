--- Binary Search Implementation in Lua
--- @param arr table A sorted array of numbers
--- @param target number The value to search for
--- @return number|nil The index of target if found, nil otherwise
--- @complexity Time: O(log n), Space: O(1)
local function binarySearch(arr, target)
    if not arr or #arr == 0 then
        return nil
    end

    local left = 1
    local right = #arr

    while left <= right do
        local mid = math.floor((left + right) / 2)

        if arr[mid] == target then
            return mid
        elseif arr[mid] < target then
            left = mid + 1
        else
            if mid == 1 then
                break
            end
            right = mid - 1
        end
    end

    return nil
end

-- Read test data from file
local function readNumbers(filename)
    local numbers = {}
    local file = io.open(filename, "r")
    if not file then
        error("Could not open file: " .. filename)
    end

    for line in file:lines() do
        table.insert(numbers, tonumber(line))
    end

    file:close()
    return numbers
end

-- Main function
local function main()
    local filename = arg[1] or "test_data.txt"
    local data = readNumbers(filename)

    -- Test with a few values
    local testValues = {
        data[math.floor(#data / 2)],  -- Middle value
        data[1],                      -- First value
        data[#data],                  -- Last value
        -999999                      -- Value not in array
    }

    for _, target in ipairs(testValues) do
        local result = binarySearch(data, target)
        print(string.format("Target: %d, Result: %s", target, result and tostring(result) or "nil"))
    end
end

main()
