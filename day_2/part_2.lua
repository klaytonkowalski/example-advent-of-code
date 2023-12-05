-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Some variables.
local game_powers = {}

-- Read the file line by line.
for line in file:lines() do

    -- Get the minimum amount of red colors to make this game possible.
    local min_red_count = 0
    for red_count in string.gmatch(line, "(%d+) red") do
        if tonumber(red_count) > min_red_count then
            min_red_count = tonumber(red_count)
        end
    end

    -- Get the minimum amount of green colors to make this game possible.
    local min_green_count = 0
    for green_count in string.gmatch(line, "(%d+) green") do
        if tonumber(green_count) > min_green_count then
            min_green_count = tonumber(green_count)
        end
    end

    -- Get the minimum amount of blue colors to make this game possible.
    local min_blue_count = 0
    for blue_count in string.gmatch(line, "(%d+) blue") do
        if tonumber(blue_count) > min_blue_count then
            min_blue_count = tonumber(blue_count)
        end
    end

    -- Calculate this game's power.
    game_powers[#game_powers + 1] = min_red_count * min_green_count * min_blue_count
end

-- Calculate the sum of all game powers.
local sum = 0
for i = 1, #game_powers do
    sum = sum + game_powers[i]
end

-- Print the sum.
print(sum)