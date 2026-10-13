--==========================================================================================================================
-- Remsely's Alexander II: Great Reforms, Farm adjacency (docs/remselys-alexander-ii.md, 3.1)
-- Farms get +1 Production per 3 adjacent Farms (max +2 at 6). Only Farms count as neighbours.
--
-- XML cannot count adjacent improvements, so this script keeps two plot properties up to date and the XML modifiers
-- (Data/GameDefines.sql) read them: one for "3+ adjacent Farms", one for "6 adjacent Farms". The properties are set for
-- every Farm regardless of owner; the modifiers only exist for Alexander II players, so only they get the Production.
--==========================================================================================================================
local DEBUG = false -- set true to write every recalculation to Lua.log
local PROPERTY_3 = "REMSELY_FARM_ADJ_3"
local PROPERTY_6 = "REMSELY_FARM_ADJ_6"

local FARM = GameInfo.Improvements["IMPROVEMENT_FARM"]
if FARM == nil then return end
local FARM_INDEX = FARM.Index

local function IsFarm(plot)
	return plot ~= nil and plot:GetImprovementType() == FARM_INDEX
end

-- skipX/skipY: a plot that is being cleared and must not count as a Farm (its improvement may still be readable)
local function CountAdjacentFarms(x, y, skipX, skipY)
	local count = 0
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local adjacent = Map.GetAdjacentPlot(x, y, direction)
		if IsFarm(adjacent) and not (adjacent:GetX() == skipX and adjacent:GetY() == skipY) then
			count = count + 1
		end
	end
	return count
end

local function RefreshPlot(plot, skipX, skipY)
	if plot == nil then return end
	local near3, near6 = 0, 0
	if IsFarm(plot) and not (plot:GetX() == skipX and plot:GetY() == skipY) then
		local count = CountAdjacentFarms(plot:GetX(), plot:GetY(), skipX, skipY)
		if count >= 3 then near3 = 1 end
		if count >= 6 then near6 = 1 end
	end
	if (plot:GetProperty(PROPERTY_3) or 0) ~= near3 then plot:SetProperty(PROPERTY_3, near3) end
	if (plot:GetProperty(PROPERTY_6) or 0) ~= near6 then plot:SetProperty(PROPERTY_6, near6) end
	if DEBUG then
		print(string.format("REMSELY_FARMS: plot (%d,%d) farm=%s adjacentFarms=%d -> adj3=%d adj6=%d",
			plot:GetX(), plot:GetY(), tostring(IsFarm(plot)), CountAdjacentFarms(plot:GetX(), plot:GetY(), skipX, skipY), near3, near6))
	end
end

-- Refresh the plot itself and its neighbours (a changed Farm alters the count of every plot around it)
local function RefreshAround(x, y, skipX, skipY)
	RefreshPlot(Map.GetPlot(x, y), skipX, skipY)
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		RefreshPlot(Map.GetAdjacentPlot(x, y, direction), skipX, skipY)
	end
end

local function OnImprovementAddedToMap(plotX, plotY, improvementID)
	if DEBUG then print(string.format("REMSELY_FARMS: ImprovementAddedToMap (%d,%d) improvementID=%s farmIndex=%s", plotX, plotY, tostring(improvementID), tostring(FARM_INDEX))) end
	RefreshAround(plotX, plotY)
end

local function OnImprovementRemovedFromMap(plotX, plotY)
	if DEBUG then print(string.format("REMSELY_FARMS: ImprovementRemovedFromMap (%d,%d)", plotX, plotY)) end
	RefreshAround(plotX, plotY, plotX, plotY)
end

if DEBUG then print("REMSELY_FARMS: script loaded, farm index " .. tostring(FARM_INDEX)) end

Events.ImprovementAddedToMap.Add(OnImprovementAddedToMap)
Events.ImprovementRemovedFromMap.Add(OnImprovementRemovedFromMap)

-- One full pass at load, so a mod added to an existing game (or a different Farm layout in a save) is picked up
for index = 0, Map.GetPlotCount() - 1, 1 do
	local plot = Map.GetPlotByIndex(index)
	if IsFarm(plot) or (plot ~= nil and (plot:GetProperty(PROPERTY_3) or 0) ~= 0) then
		RefreshPlot(plot)
	end
end
