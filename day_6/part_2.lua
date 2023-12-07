-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read all file text and strip it of spaces.
local file_text = string.gsub(file:read("a"), " ", "")