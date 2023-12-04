-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Maps words to digits.
local word_to_digit =
{
    one = "1",
    two = "2",
    three = "3",
    four = "4",
    five = "5",
    six = "6",
    seven = "7",
    eight = "8",
    nine = "9"
}

-- Read the file line by line.
local values = {}
for line in file:lines() do
    
end

-- Calculate the sum of all values.
local sum = 0
for i = 1, #values do
    sum = sum + tonumber(values[i])
end

-- Print the sum.
print(sum)