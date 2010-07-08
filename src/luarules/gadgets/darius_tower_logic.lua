function gadget:GetInfo()
	return {
		name      = "Tower Selector Logic",
		desc      = "The Logic controller which selects the appropriate tower based on the currently selected cards.",
		author    = "xcompwiz",
		date      = "June 7, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default
	}
end

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

---------------------
-- Local Functions --
---------------------
local unitIDs = {}

local function getUnitDef(name)
	if (unitIDs[name]) then return unitIDs[name] end
	for id, unit in pairs(UnitDefs) do
		if (unit.name == name) then
			unitIDs[name] = id
			return id
		end
	end
	return nil
end

local function getTowerID(material, weapon)
	if ((material.type ~= "Material") or (weapon.type ~= "Weapon")) then return nil end
	local id = getUnitDef(material.name .. weapon.name)
	if (id) then return id end
	return getUnitDef("corllt") -- Default tower
end

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

---------------------
-- Synced Call-ins --
---------------------
function gadget:Initialize()
	-- Setup Darius
	Darius = GG.Darius
end

function gadget:GameFrame(f)
	Darius = GG.Darius
	if not (Darius) then return end

	local material = Darius:GetSelectedMaterial()
	local weapon = Darius:GetSelectedWeapon()

	if (material and weapon) then
		Darius:SetTower(getTowerID(material, weapon))
	else
		Darius:SetTower(nil)
	end
end

------------------------------------------------
else --unsynced
------------------------------------------------

-----------------------
-- Unsynced Call-ins --
-----------------------

end -- End synced check
