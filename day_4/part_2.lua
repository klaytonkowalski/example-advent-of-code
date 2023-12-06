-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Useful constants.
local winners_start_index = 11
local elves_start_index = 43
local max_winner_count = 10
local max_elf_count = 25
local max_game_count = 223

-- Some variables.
local winners = {}
local elves = {}
local cards = {}

-- We start with a single copy of each card.
for i = 1, max_game_count do
    cards[#cards + 1] = 1
end

-- Read the file line by line.
local game_count = 0
for line in file:lines() do
    game_count = game_count + 1

    -- Get the winning numbers for this game.
    winners[game_count] = {}
    local winner_count = 0
    for winner in string.gmatch(line, "%d+", winners_start_index) do
        winners[game_count][winner] = true
        winner_count = winner_count + 1
        if winner_count == max_winner_count then break end
    end

    -- Get the elf numbers for this game.
    elves[game_count] = {}
    for elf in string.gmatch(line, "%d+", elves_start_index) do
        local next_index = #elves[game_count] + 1
        elves[game_count][next_index] = elf
        if next_index == max_elf_count then break end
    end

    -- Get the amount of matches between the winning numbers and the elf's numbers.
    local matches = 0
    for i = 1, max_elf_count do
        if winners[game_count][elves[game_count][i]] then
            matches = matches + 1
        end
    end

    -- Collect another copy of the next [matches] cards.
    -- We must do this multiple times if we have more than one of the current card.
    for i = 1, cards[game_count] do
        for j = 1, matches do
            if game_count + j <= max_game_count then
                cards[game_count + j] = cards[game_count + j] + 1
            end
        end
    end
end

-- Calculate the sum of all cards.
local sum = 0
for i = 1, #cards do
    sum = sum + cards[i]
end

-- Print the sum.
print(sum)