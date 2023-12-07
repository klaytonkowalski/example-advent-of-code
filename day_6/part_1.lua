-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read all file text.
local file_text = file:read("a")

-- Get the race times in milliseconds.
local times = {}
for number in string.gmatch(file_text, "%d+") do
    times[#times + 1] = tonumber(number)
    if #times == 4 then break end
end

-- Get the race distances in millmeters.
local distances = {}
for number in string.gmatch(file_text, "%d+", 38) do
    distances[#distances + 1] = tonumber(number)
    if #distances == 4 then break end
end

-- Calculate the distance results for holding down the button for [1, time] milliseconds.
-- Talley the amount of millisecond options that result in a 1st place win for the race.
local winner_count = { 0, 0, 0, 0 }
for i = 1, 4 do
    for j = 1, times[i] do
        local distance_result = (times[i] - j) * j
        if distance_result > distances[i] then
            winner_count[i] = winner_count[i] + 1
        end
    end
end

-- Multiply the winning millisecond options.
local product = 1
for i = 1, 4 do
    product = product * winner_count[i]
end

-- Print the product.
print(product)