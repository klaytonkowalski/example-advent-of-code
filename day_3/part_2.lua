-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- File dimensions in characters.
local file_width = 140

-- Read the file all at once and strip the \n and \r characters.
local file_text = string.gsub(file:read("a"), "[\n\r]", "")

-- Some variables.
local gear_data = {}

-- If the character is a gear, then this number is one of its ratio components.
local function handle_gear(character, character_index, number)
    if character == "*" then
        if not gear_data[character_index] then
            gear_data[character_index] = {}
        end
        local number_count = #gear_data[character_index]
        gear_data[character_index][number_count + 1] = number
    end
end

-- Get the next number.
local start_index, end_index = 0, 0
for number in string.gmatch(file_text, "%d+") do
    start_index, end_index = string.find(file_text, number, end_index + 1)

    -- Check if the left character is a gear.
    if start_index % file_width ~= 1 then
        local left_character = string.sub(file_text, start_index - 1, start_index - 1)
        handle_gear(left_character, start_index - 1, number)
    end

    -- Check if the right character is a gear.
    if end_index % file_width ~= 0 then
        local right_character = string.sub(file_text, end_index + 1, end_index + 1)
        handle_gear(right_character, end_index + 1, number)
    end

    -- Check if the top-left character is a gear.
    if start_index % file_width ~= 1 and start_index > file_width then
        local top_left_character = string.sub(file_text, start_index - 1 - file_width, start_index - 1 - file_width)
        handle_gear(top_left_character, start_index - 1 - file_width, number)
    end

    -- Check if any of the top-middle characters are gears.
    if start_index > file_width then
        for i = 0, #number - 1 do
            local top_middle_character = string.sub(file_text, start_index - file_width + i, start_index - file_width + i)
            handle_gear(top_middle_character, start_index - file_width + i, number)
        end
    end

    -- Check if the top-right character is a gear.
    if end_index % file_width ~= 0 and start_index > file_width then
        local top_right_character = string.sub(file_text, end_index + 1 - file_width, end_index + 1 - file_width)
        handle_gear(top_right_character, end_index + 1 - file_width, number)
    end

    -- Check if the bottom-left character is a gear.
    if start_index % file_width ~= 1 and start_index <= #file_text - file_width then
        local bottom_left_character = string.sub(file_text, start_index - 1 + file_width, start_index - 1 + file_width)
        handle_gear(bottom_left_character, start_index - 1 + file_width, number)
    end

    -- Check if any of the bottom-middle characters are gears.
    if start_index <= #file_text - file_width then
        for i = 0, #number - 1 do
            local bottom_middle_character = string.sub(file_text, start_index + file_width + i, start_index + file_width + i)
            handle_gear(bottom_middle_character, start_index + file_width + i, number)
        end
    end

    -- Check if the bottom-right character is a gear.
    if end_index % file_width ~= 0 and start_index <= #file_text - file_width then
        local bottom_right_character = string.sub(file_text, end_index + 1 + file_width, end_index + 1 + file_width)
        handle_gear(bottom_right_character, end_index + 1 + file_width, number)
    end
end

-- Calculate the sum of all gear ratios.
-- Only * symbols that are surrounded by exactly two numbers are gears.
local sum = 0
for gear_index, numbers in pairs(gear_data) do
    if #numbers == 2 then
        sum = sum + gear_data[gear_index][1] * gear_data[gear_index][2]
    end
end

-- Print the sum.
print(sum)