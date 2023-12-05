-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Maps spelled-out digits to numerical digits.
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

-- Lua only provides string.find() which searches a string forward.
local function string_find_reverse(line, pattern)
    local line_reverse = string.reverse(line)
    local start_index, end_index = string.find(line_reverse, pattern)
    if not start_index then return end
    return #line - end_index + 1, #line - start_index + 1
end

-- Some variables.
local values = {}

-- Read the file line by line.
for line in file:lines() do

    -- Get the start and end indices of the first and last numerical digits.
    local first_start_index, first_end_index = string.find(line, "%d")
    local last_start_index, last_end_index = string_find_reverse(line, "%d")

    -- Get the start and end indices of the first and last spelled-out digits.
    for key, value in pairs(word_to_digit) do
        local first_start_index_word, first_end_index_word = string.find(line, "(" .. key .. ")")
        local last_start_index_word, last_end_index_word = string_find_reverse(line, "(" .. string.reverse(key) .. ")")

        -- Check if the first spelled-out digit comes before the first numerical digit.
        if first_start_index_word and first_start_index_word < first_start_index then
            first_start_index = first_start_index_word
            first_end_index = first_end_index_word
        end

        -- Check if the last spelled-out digit comes after the last numerical digit.
        if last_start_index_word and last_start_index_word > last_start_index then
            last_start_index = last_start_index_word
            last_end_index = last_end_index_word
        end
    end

    -- Get the first and last strings, regardless of numerical or spelled-out.
    local first_string = string.sub(line, first_start_index, first_end_index)
    local last_string = string.sub(line, last_start_index, last_end_index)

    -- Combine the first and last digits into a single value.
    local value = #first_string > 1 and word_to_digit[first_string] or first_string
    value = value .. (#last_string > 1 and word_to_digit[last_string] or last_string)
    values[#values + 1] = value
end

-- Calculate the sum of all values.
local sum = 0
for i = 1, #values do
    sum = sum + tonumber(values[i])
end

-- Print the sum.
print(sum)