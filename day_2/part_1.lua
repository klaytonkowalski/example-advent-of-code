-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Maximum color counts.
local max_red_count = 12
local max_green_count = 13
local max_blue_count = 14

-- Some variables.
local game_number = 1
local valid_game_ids = {}

-- Read the file line by line.
for line in file:lines() do

    -- It does not matter how many reveals there are.
    -- If any of the red, green, or blue color counts are greater than their corresponding maximums,
    -- then the game is invalid and we can move on to the next game.

    -- Check if the red count in any of the reveals is greater than its maximum.
    for red_count in string.gmatch(line, "(%d+) red") do
        if tonumber(red_count) > max_red_count then
            goto invalid_game
        end
    end

    -- Check if the green count in any of the reveals is greater than its maximum.
    for green_count in string.gmatch(line, "(%d+) green") do
        if tonumber(green_count) > max_green_count then
            goto invalid_game
        end
    end

    -- Check if the blue count in any of the reveals is greater than its maximum.
    for blue_count in string.gmatch(line, "(%d+) blue") do
        if tonumber(blue_count) > max_blue_count then
            goto invalid_game
        end
    end

    -- This game is valid.
    valid_game_ids[#valid_game_ids + 1] = game_number

    ::invalid_game::

    -- Increment the game number.
    game_number = game_number + 1
end

-- Calculate the sum of all valid game ids.
local sum = 0
for i = 1, #valid_game_ids do
    sum = sum + valid_game_ids[i]
end

-- Print the sum.
print(sum)