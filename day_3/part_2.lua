-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- File dimensions in characters.
local file_width = 140

-- Read the file all at once and strip the \n and \r characters.
local file_text = string.gsub(file:read("a"), "[\n\r]", "")

-- Some variables.
local gear_ratios = {}

-- Get the next number.
for number in string.gmatch(file_text, "%d+") do
    
end

-- Calculate the sum of all gear ratios.
local sum = 0
for i = 1, #gear_ratios do
    sum = sum + gear_ratios[i]
end

-- Print the sum.
print(sum)