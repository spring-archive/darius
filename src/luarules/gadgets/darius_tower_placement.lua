function gadget:GetInfo()
	return {
		name      = "Simple Tower Placement Widget",
		desc      = "Waits for signal to create a tower in the game",
		author    = "Jammer",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

local spEcho = Spring.Echo

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end

local tower = nil
local team = nil
local x = nil
local y = nil
local z = nil

function gadget:GameFrame(f)
	if not GG.Darius then return end
	if tower ~= nil then -- If tower variable is set then create the tower
		local selectedMaterial = GG.Darius:GetSelectedMaterial()
		local selectedWeapon = GG.Darius:GetSelectedWeapon()
		if (tower ~= GG.Darius:GetTower()) then
			spEcho("Tower Invalid")
			spEcho(tower .. " != " .. GG.Darius:GetTower())
			tower = nil
			return
		end
		GG.Darius:DiscardCard(selectedMaterial, true)
		GG.Darius:DiscardCard(selectedWeapon, true)
		Spring.CreateUnit(tower,x,y,z,"south",team,false)
		team = nil
		x = nil
		y = nil
		z = nil
		tower = nil
	end
end

function gadget:RecvLuaMsg(msg, playerID)
	--spEcho("RecvLuaMsg: "..msg)
	local words = {}
	i = 0
	for word in string.gmatch(msg, "%S+") do -- Split the message to a table, %S = All non-space characters
		i = i + 1
		words[i] = word
	end
	if words[1] == "PlaceTower" then
		team = 1 --playerID --TODO: Get actual player ID
		tower = 0 + words[2]
		x = tonumber(words[3])
		y = tonumber(words[4])
		z = tonumber(words[5])
	end
end
