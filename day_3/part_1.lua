-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- File dimensions in characters.
local file_width = 140

-- Read the file all at once and strip the \n and \r characters.
local file_text = string.gsub(file:read("a"), "[\n\r]", "")

-- Some variables.
local part_numbers = {}

-- Check if a number is adjacent to a symbol.
-- If so, then store it as a part number and remove it from the file.
local function handle_number(character, number, start_index, end_index)
    if string.match(character, "[^%w.]") then
        part_numbers[#part_numbers + 1] = number
        file_text = string.sub(file_text, 1, start_index - 1) .. string.rep(".", #number) .. string.sub(file_text, end_index + 1, #file_text)
        return true
    end
end

-- Get the next number.
local start_index, end_index = nil, 0
for number in string.gmatch(file_text, "%d+") do
    start_index, end_index = string.find(file_text, number, end_index + 1)

    -- We need to check all characters surrounding each number in the file.
    -- If we find a symbol, then this is a part number and we do not have to check the rest of the surrounding characters.
    -- Instead, we can immediately move on to the next number.

    -- We also need to check if the number is flush against the top, bottom, left, or right sides of the file.
    -- This allows us to avoid wrapping onto a new line.

    -- Check if the left character is a symbol.
    if start_index % file_width ~= 1 then
        local left_character = string.sub(file_text, start_index - 1, start_index - 1)
        if handle_number(left_character, number, start_index, end_index) then goto next_number end
    end

    -- Check if the right character is a symbol.
    if end_index % file_width ~= 0 then
        local right_character = string.sub(file_text, end_index + 1, end_index + 1)
        if handle_number(right_character, number, start_index, end_index) then goto next_number end
    end

    -- Check if the top-left character is a symbol.
    if start_index % file_width ~= 1 and start_index > file_width then
        local top_left_character = string.sub(file_text, start_index - 1 - file_width, start_index - 1 - file_width)
        if handle_number(top_left_character, number, start_index, end_index) then goto next_number end
    end

    -- Check if any of the top-middle characters are symbols.
    if start_index > file_width then
        for i = 0, #number - 1 do
            local top_middle_character = string.sub(file_text, start_index - file_width + i, start_index - file_width + i)
            if handle_number(top_middle_character, number, start_index, end_index) then goto next_number end
        end
    end

    -- Check if the top-right character is a symbol.
    if end_index % file_width ~= 0 and start_index > file_width then
        local top_right_character = string.sub(file_text, end_index + 1 - file_width, end_index + 1 - file_width)
        if handle_number(top_right_character, number, start_index, end_index) then goto next_number end
    end

    -- Check if the bottom-left character is a symbol.
    if start_index % file_width ~= 1 and start_index <= #file_text - file_width then
        local bottom_left_character = string.sub(file_text, start_index - 1 + file_width, start_index - 1 + file_width)
        if handle_number(bottom_left_character, number, start_index, end_index) then goto next_number end
    end

    -- Check if any of the bottom-middle characters are symbols.
    if start_index <= #file_text - file_width then
        for i = 0, #number - 1 do
            local bottom_middle_character = string.sub(file_text, start_index + file_width + i, start_index + file_width + i)
            if handle_number(bottom_middle_character, number, start_index, end_index) then goto next_number end
        end
    end

    -- Check if the bottom-right character is a symbol.
    if end_index % file_width ~= 0 and start_index <= #file_text - file_width then
        local bottom_right_character = string.sub(file_text, end_index + 1 + file_width, end_index + 1 + file_width)
        if handle_number(bottom_right_character, number, start_index, end_index) then goto next_number end
    end

    ::next_number::
end

-- Calculate the sum of all part numbers.
local sum = 0
for i = 1, #part_numbers do
    sum = sum + part_numbers[i]
end

-- Print the sum.
print(sum)