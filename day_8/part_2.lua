-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read the file line by line.
local lines = {}
for line in file:lines() do
    lines[#lines + 1] = line
end

-- Get each individual left-right instruction.
local instructions = {}
for instruction in string.gmatch(lines[1], "%u") do
    instructions[#instructions + 1] = instruction
end

-- Check if a triplet ends in an "A".
local function ends_in_a(triplet)
    return string.sub(triplet, 3, 3) == "A"
end

-- Check if a triplet ends in an "Z".
local function ends_in_z(triplet)
    return string.sub(triplet, 3, 3) == "Z"
end

-- Get each of the "XXX = (YYY, ZZZ)" mappings.
-- Track the triplets that end in "A".
local mappings = {}
local current_triplets = {}
for i = 3, 800 do
    local key = string.match(lines[i], "%u+")
    local left = string.match(lines[i], "%u+", 8)
    local right = string.match(lines[i], "%u+", 13)
    mappings[key] = { left = left, right = right }
    if ends_in_a(key) then
        current_triplets[#current_triplets + 1] = key
    end
end

-- Tally the amount of traversals it takes for each triplet to end in a "Z".
local traversals = {}
for i = 1, #current_triplets do
    local instruction_index = 1
    traversals[#traversals + 1] = 0
    while not ends_in_z(current_triplets[i]) do
        current_triplets[i] = instructions[instruction_index] == "L" and mappings[current_triplets[i]].left or mappings[current_triplets[i]].right
        instruction_index = instruction_index + 1
        -- If we reached the end of the left-right instructions, then start over.
        if instruction_index > #instructions then
            instruction_index = 1
        end
        traversals[#traversals] = traversals[#traversals] + 1
    end
end

-- Calculate the least common multiple of the traversals.
local lcm = 1
for i = 1, #traversals do
    lcm = lcm * traversals[i]
end

-- Print the lcm.
print(lcm)