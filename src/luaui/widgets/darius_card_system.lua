function widget:GetInfo()
	return {
		name      = "Card System Frontend",
		desc      = "Interfaces with the Darius Card system",
		author    = "Darius Team",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

local spEcho = Spring.Echo

local Darius = {}

WG.Darius = Darius

local tower
local effect
local selectedWeapon
local selectedMaterial
local selectedSpecial
local greenballs
local hand

local function SetTower(arg)
	tower = arg
end

function widget:Initialize()
	widgetHandler:RegisterGlobal("SetTower", SetTower)
end

function Darius:GetTower()
	return tower
end

function Darius:GetHand()
	return {} --PASSES ACTUAL OBJECTS
end

function Darius:CanDraw()
	return false
end

function Darius:ActivateCard(card)
	--Pass actual card to gadget?
end

function Darius:Draw(deck)
	--Tell gadget to draw
end