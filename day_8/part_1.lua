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

-- Get each of the "XXX = (YYY, ZZZ)" mappings.
local mappings = {}
for i = 3, 800 do
    local key = string.match(lines[i], "%u+")
    local left = string.match(lines[i], "%u+", 8)
    local right = string.match(lines[i], "%u+", 13)
    mappings[key] = { left = left, right = right }
end

-- Useful variables.
local current_triplet = "AAA"
local traversal_count = 0
local instruction_index = 1

-- While the current triplet is not the goal of "ZZZ", continue traversing the map.
-- Tally how many traversals are made.
while current_triplet ~= "ZZZ" do
    current_triplet = instructions[instruction_index] == "L" and mappings[current_triplet].left or mappings[current_triplet].right
    instruction_index = instruction_index + 1
    -- If we reached the end of the left-right instructions, then start over.
    if instruction_index > #instructions then
        instruction_index = 1
    end
    traversal_count = traversal_count + 1
end

-- Print the traversal count.
print(traversal_count)