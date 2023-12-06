-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Useful constants.
local winners_start_index = 11
local elf_start_index = 43
local max_winner_count = 10

-- Some variables.
local scores = {}

-- Read the file line by line.
for line in file:lines() do

    -- Initialize this card's score to 0.
    scores[#scores + 1] = 0

    -- Get all of the winning numbers.
    local winners = {}
    local winner_count = 0
    for winner in string.gmatch(line, "%d+", winners_start_index) do
        winners[winner] = true
        winner_count = winner_count + 1
        if winner_count == max_winner_count then break end
    end

    -- Compare the elf's numbers to the winning numbers.
    for elf in string.gmatch(line, "%d+", elf_start_index) do
        if winners[elf] then
            -- The first match earns 1 point, while subsequent matches double the score.
            scores[#scores] = scores[#scores] > 0 and scores[#scores] * 2 or 1
        end
    end
end

-- Calculate the sum of all scores.
local sum = 0
for i = 1, #scores do
    sum = sum + scores[i]
end

-- Print the sum.
print(sum)