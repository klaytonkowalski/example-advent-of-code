-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read the file line by line.
local hands = {}
local bids = {}
for line in file:lines() do

    -- Get each hand and tally each of its ranks.
    local hand = string.sub(line, 1, 5)
    local components = {}
    for rank in string.gmatch(hand, "%w") do
        for i = 1, #components do
            if components[i].rank == rank then
                components[i].count = components[i].count + 1
                goto next_rank
            end
        end
        components[#components + 1] = { rank = rank, count = 1 }
        ::next_rank::
    end
    hands[#hands + 1] = components

    -- Get the corresponding bid.
    bids[#bids + 1] = tonumber(string.match(line, "%d+", 7))
end

-- All possible card ranks, ordered by strength.
local ranks = { "A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2" }

-- Determine what kind of hands these are, then assign each hand a weight based on:
-- (1) category: 1000 points (Five of a kind = 6000, high card = 0)
-- (2) 
local weights = {}
for i = 1, #hands do
    -- Five of a kind...
    if #hands[i] == 1 then

    -- Four of a kind...
    elseif #hands[i] == 2 and (hands[i][1].count == 4 or hands[i][2].count == 4) then

    -- Full house...
    elseif #hands[i] == 2 then

    -- Three of a kind...
    elseif #hands[i] == 3 and (hands[i][1].count == 3 or hands[i][2].count == 3 or hands[i][3].count == 3) then

    -- Two pair...
    elseif #hands[i] == 3 then

    -- One pair...
    elseif #hands[i] == 4 then

    -- High card...
    else

    end
end