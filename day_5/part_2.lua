-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read the file line by line.
local lines = {}
for line in file:lines() do
    lines[#lines + 1] = line
end

-- Get all seeds and their respective ranges.
local seeds = {}
for number in string.gmatch(lines[1], "%d+") do
    if #seeds == 0 or seeds[#seeds].range then
        seeds[#seeds + 1] = { start = tonumber(number) }
    else
        seeds[#seeds].range = tonumber(number)
    end
end