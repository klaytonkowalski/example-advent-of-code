-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read the file line by line.
local values = {}
for line in file:lines() do

    -- Get the first digit.
    local first = string.match(line, "%d")
    -- Get the last digit.
    local last = string.match(string.reverse(line), "%d")

    -- Combine the first and last digits into a single value.
    values[#values + 1] = first .. last
end

-- Calculate the sum of all values.
local sum = 0
for i = 1, #values do
    sum = sum + tonumber(values[i])
end

-- Print the sum.
print(sum)