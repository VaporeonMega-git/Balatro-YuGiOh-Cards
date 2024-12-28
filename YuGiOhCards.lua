--- STEAMODDED HEADER
--- MOD_NAME: Yu-Gi-Oh Cards
--- MOD_ID: YuGiOh
--- MOD_AUTHOR: [VaporeonMega]
--- MOD_DESCRIPTION: Adds various Yu-Gi-Oh cards.
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: c7638f
--- PREFIX: ygo

local atlas, error_loading = SMODS.load_file("Atlas.lua")
if error_loading then
  print("Error loading: " .. error_loading)
else
  atlas()
end

local consumableTypes, error_loading = SMODS.load_file("ConsumableTypes.lua")
if error_loading then
  print("Error loading: " .. error_loading)
else
  consumableTypes()
end

local boosters, error_loading = SMODS.load_file("Boosters.lua")
if error_loading then
  print("Error loading: " .. error_loading)
else
  boosters()
end

local consumables, error_loading = SMODS.load_file("Consumables.lua")
if error_loading then
  print("Error loading: " .. error_loading)
else
  consumables()
end

local jokers, error_loading = SMODS.load_file("Jokers.lua")
if error_loading then
  print("Error loading: " .. error_loading)
else
  jokers()
end
