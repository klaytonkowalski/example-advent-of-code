-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read all file text and strip it of spaces.
local file_text = string.gsub(file:read("a"), " ", "")

-- Get the race time and winning distance.
local time = tonumber(string.match(file_text, "%d+"))
local distance = tonumber(string.match(file_text, "%d+", string.find(file_text, "Distance:")))

-- Calculate the distance results for holding down the button for [1, time] milliseconds.
-- Tally the amount of millisecond options that result in a win for the race.
local winner_count = 0
for i = 1, time do
    local option = (time - i) * i
    if option > distance then
        winner_count = winner_count + 1
    end
end

-- Print the tally.
print(winner_count)