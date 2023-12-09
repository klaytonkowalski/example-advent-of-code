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

-- Check if all current triplets end in "Z".
local function all_end_in_z()
    for i = 1, #current_triplets do
        if not ends_in_z(current_triplets[i]) then
            return false
        end
    end
    return true
end

-- While the current triplets do not all end in "Z", continue traversing the map.
-- Tally how many traversals are made.
local traversal_count = 0
local instruction_index = 1
while not all_end_in_z() do
    -- All triplets make the same traversal simultaneously.
    for i = 1, #current_triplets do
        if i == 1 then
            print(current_triplets[i], instruction_index, instructions[instruction_index])
        end
        current_triplets[i] = instructions[instruction_index] == "L" and mappings[current_triplets[i]].left or mappings[current_triplets[i]].right
    end
    instruction_index = instruction_index + 1
    -- If we reached the end of the left-right instructions, then start over.
    if instruction_index > #instructions then
        instruction_index = 1
    end
    traversal_count = traversal_count + 1
end

-- Print the traversal count.
print(traversal_count)