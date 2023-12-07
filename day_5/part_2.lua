-- Open the input file.
local file = io.open("input.txt", "r")
if not file then return end

-- Read the file line by line.
local lines = {}
for line in file:lines() do
    lines[#lines + 1] = line
end

-- Get all seeds.
local seeds = {}
for seed in string.gmatch(lines[1], "%d+") do
    seeds[#seeds + 1] = tonumber(seed)
end

-- Technically, we do not have to store mappings between every category.
-- We only need to store mappings between seed id and location id.
-- Regardless, I will store all mappings to better showcase the logic.

-- Get seed-to-soil mappings.
local seed_to_soil = {}
for i = 4, 40 do
    seed_to_soil[#seed_to_soil + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #seed_to_soil[#seed_to_soil] + 1
        seed_to_soil[#seed_to_soil][next_index] = tonumber(number)
    end
end

-- Get soil-to-fertilizer mappings.
local soil_to_fertilizer = {}
for i = 43, 52 do
    soil_to_fertilizer[#soil_to_fertilizer + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #soil_to_fertilizer[#soil_to_fertilizer] + 1
        soil_to_fertilizer[#soil_to_fertilizer][next_index] = tonumber(number)
    end
end

-- Get fertilizer-to-water mappings.
local fertilizer_to_water = {}
for i = 55, 90 do
    fertilizer_to_water[#fertilizer_to_water + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #fertilizer_to_water[#fertilizer_to_water] + 1
        fertilizer_to_water[#fertilizer_to_water][next_index] = tonumber(number)
    end
end

-- Get water-to-light mappings.
local water_to_light = {}
for i = 93, 138 do
    water_to_light[#water_to_light + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #water_to_light[#water_to_light] + 1
        water_to_light[#water_to_light][next_index] = tonumber(number)
    end
end

-- Get light-to-temperature mappings.
local light_to_temperature = {}
for i = 141, 168 do
    light_to_temperature[#light_to_temperature + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #light_to_temperature[#light_to_temperature] + 1
        light_to_temperature[#light_to_temperature][next_index] = tonumber(number)
    end
end

-- Get temperature-to-humidity mappings.
local temperature_to_humidity = {}
for i = 171, 210 do
    temperature_to_humidity[#temperature_to_humidity + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #temperature_to_humidity[#temperature_to_humidity] + 1
        temperature_to_humidity[#temperature_to_humidity][next_index] = tonumber(number)
    end
end

-- Get humidity-to-location mappings.
local humidity_to_location = {}
for i = 213, 254 do
    humidity_to_location[#humidity_to_location + 1] = {}
    for number in string.gmatch(lines[i], "%d+") do
        local next_index = #humidity_to_location[#humidity_to_location] + 1
        humidity_to_location[#humidity_to_location][next_index] = tonumber(number)
    end
end

-- Useful constants.
local destination_index = 1
local source_index = 2
local range_index = 3

-- Get the lowest location across all seed mappings.
local lowest_location
for i = 1, #seeds do

    -- Soil id = Seed id, if seed id is not found in the mappings.
    local soil_id = seeds[i]
    for j = 1, #seed_to_soil do
        if seed_to_soil[j][source_index] <= seeds[i] and seeds[i] <= seed_to_soil[j][source_index] + seed_to_soil[j][range_index] then
            soil_id = (seeds[i] - seed_to_soil[j][source_index]) + seed_to_soil[j][destination_index]
            break
        end
    end

    -- Fertilizer id = Soil id, if soil id is not found in the mappings.
    local fertilizer_id = soil_id
    for j = 1, #soil_to_fertilizer do
        if soil_to_fertilizer[j][source_index] <= soil_id and soil_id <= soil_to_fertilizer[j][source_index] + soil_to_fertilizer[j][range_index] then
            fertilizer_id = (soil_id - soil_to_fertilizer[j][source_index]) + soil_to_fertilizer[j][destination_index]
            break
        end
    end

    -- Water id = Fertilizer id, if fertilizer id is not found in the mappings.
    local water_id = fertilizer_id
    for j = 1, #fertilizer_to_water do
        if fertilizer_to_water[j][source_index] <= fertilizer_id and fertilizer_id <= fertilizer_to_water[j][source_index] + fertilizer_to_water[j][range_index] then
            water_id = (fertilizer_id - fertilizer_to_water[j][source_index]) + fertilizer_to_water[j][destination_index]
            break
        end
    end

    -- Light id = Water id, if water id is not found in the mappings.
    local light_id = water_id
    for j = 1, #water_to_light do
        if water_to_light[j][source_index] <= water_id and water_id <= water_to_light[j][source_index] + water_to_light[j][range_index] then
            light_id = (water_id - water_to_light[j][source_index]) + water_to_light[j][destination_index]
            break
        end
    end

    -- Temperature id = light id, if light id is not found in the mappings.
    local temperature_id = light_id
    for j = 1, #light_to_temperature do
        if light_to_temperature[j][source_index] <= light_id and light_id <= light_to_temperature[j][source_index] + light_to_temperature[j][range_index] then
            temperature_id = (light_id - light_to_temperature[j][source_index]) + light_to_temperature[j][destination_index]
            break
        end
    end

    -- Humidity id = temperature id, if temperature id is not found in the mappings.
    local humidity_id = temperature_id
    for j = 1, #temperature_to_humidity do
        if temperature_to_humidity[j][source_index] <= temperature_id and temperature_id <= temperature_to_humidity[j][source_index] + temperature_to_humidity[j][range_index] then
            humidity_id = (temperature_id - temperature_to_humidity[j][source_index]) + temperature_to_humidity[j][destination_index]
            break
        end
    end

    -- Location id = humidity id, if humidity id is not found in the mappings.
    local location_id = humidity_id
    for j = 1, #humidity_to_location do
        if humidity_to_location[j][source_index] <= humidity_id and humidity_id <= humidity_to_location[j][source_index] + humidity_to_location[j][range_index] then
            location_id = (humidity_id - humidity_to_location[j][source_index]) + humidity_to_location[j][destination_index]
            break
        end
    end

    -- Check if this is the lowest location so far.
    if not lowest_location or location_id < lowest_location then
        lowest_location = location_id
    end
end

-- Print the lowest location.
print(lowest_location)