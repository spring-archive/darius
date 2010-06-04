function gadget:GetInfo()
	return {
		name      = "Card System Backend",
		desc      = "Controls the Darius Card system",
		author    = "Darius Team",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

local spEcho = Spring.Echo

local Darius = {}
GG.Darius = Darius

local tower = "corllt"
local effect
local selectedWeapon
local selectedMaterial
local selectedSpecial
local greenballs
local hand

local deck1
local deck2

if (gadgetHandler:IsSyncedCode()) then -- synced

function gadget:GameFrame(f)
	SendToUnsynced("TowerName", tower)
end

else --unsynced

local function SendTowerName(_, tower)
	--Make sure the widget still exists (might have been stopped)
	if (Script.LuaUI('SetTower')) then
		-- Call the widget function.  Widget must declare 'Update' this via 'widgetHandler:RegisterGlobal'
		Script.LuaUI.SetTower(tower)
	end
end

function gadget:Initialize()
	gadgetHandler:AddSyncAction("TowerName", SendTowerName)
end

function Darius:GetTower()
	spEcho("Gadget:Tower")
	return tower
end

function Darius:GetHand()
	spEcho("Gadget:Hand")
	return {} --PASSES ACTUAL OBJECTS
end

function Darius:CanDraw()
	spEcho("Gadget:CanDraw")
	return false
end

--NEED ACTUAL CARD OBJECT
function Darius:ActivateCard(card)
end

end