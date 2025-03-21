#!/usr/bin/env lua

if #arg < 1 then
    io.stderr:write("Please provide a number as command line argument\n")
    os.exit(1)
end

local input = tonumber(arg[1])                -- Get an input number from the command line
if not input then
    io.stderr:write("Please provide a valid integer\n")
    os.exit(1)
end

math.randomseed(os.time())
local r = math.random(0, 9999)                -- Get a random number 0 <= r < 10k
local a = {}                                  -- Array of 10k elements initialized to 0
for i = 0, 9999 do
    a[i] = 0
end

for i = 0, 9999 do                           -- 10k outer loop iterations
    for j = 0, 99999 do                      -- 100k inner loop iterations, per outer loop iteration
        a[i] = a[i] + j % input              -- Simple sum
    end
    a[i] = a[i] + r                          -- Add a random value to each element in array
end

print(a[r])                                  -- Print out a single element from the array
