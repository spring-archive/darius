function widget:GetInfo()
	return {
		name      = "Card System Frontend",
		desc      = "Interfaces with the Darius Card system",
		author    = "Darius Team",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default?
		api       = true, --I think this forces it to be loaded before other widgets
	}
end

---------------
-- Game Vars -- Should be loaded from elsewhere (gadget?)
---------------
local requiredBallsToDraw = 5

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

----------------
-- Local Vars --
----------------
local Darius = widget
WG.Darius = Darius

local tower
local effect
local selectedWeapon
local selectedMaterial
local selectedSpecial
local greenballs = 0
local hand = 0
local testhand = { --For testing the hand
	{id = 1, name = "Metal", type = "Material", img = 'LuaUI/images/ibeam.png'},
	{id = 2, name = "Fire" , type = "Weapon"  , img = 'LuaUI/images/energy.png'},
	{id = 3, name = "Heal" , type = "Special" , img = 'bitmaps/gpl/nano.tga'},
	{id = 4, name = "Nuke" , type = "Special" , img = 'icons/nuke.dds'},
	{id = 5, name = "Alien", type = "Special" , img = 'LuaUI/images/friendly.png'},
}

----------------------
-- Member Functions --
----------------------
function Darius:GetTower()
	return tower
end

function Darius:GetEffect()
	return effect
end

function Darius:GetHand()
	return testhand --TODO: revert to just hand
end

function Darius:GetSelectedMaterial()
	return selectedMaterial
end

function Darius:GetSelectedWeapon()
	return selectedWeapon
end

function Darius:GetSelectedSpecial()
	return selectedSpecial
end

function Darius:GetGreenBalls()
	return greenballs
end

function Darius:CanDraw()
	return true
	--spEcho(greenballs .. " / " .. requiredBallsToDraw)
	--spEcho(greenballs >= requiredBallsToDraw)
	--return (greenballs >= requiredBallsToDraw)
end

function Darius:ActivateCard(card)
	--Pass actual card to gadget (by ID)
	Spring.SendLuaRulesMsg("Activate Card:" .. card.id)
	spEcho("Activate Card:" .. card.id)
end

function Darius:Draw(deck)
	--Tell gadget to draw from specified deck
	Spring.SendLuaRulesMsg("Draw Card:" .. deck)
	spEcho("Draw Card:" .. deck)
end

-----------------------------
-- Unsynced Vars Receivers --
-----------------------------
local function SetHand(arg)
	hand = arg
end

local function SetTower(arg)
	tower = arg
end

local function SetEffect(arg)
	effect = arg
end

local function SetSelectedMaterial(arg)
	selectedMaterial = arg
end

local function SetSelectedWeapon(arg)
	selectedWeapon = arg
end

local function SetSelectedSpecial(arg)
	selectedSpecial = arg
end

local function SetGreenBalls(arg)
	greenballs = arg
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	widgetHandler:RegisterGlobal("SetCardHand" , SetHand)
	widgetHandler:RegisterGlobal("SetTower", SetTower)
	widgetHandler:RegisterGlobal("SetCardEffect", SetEffect)
	widgetHandler:RegisterGlobal("SetSelectedMaterialCard", SetSelectedMaterial)
	widgetHandler:RegisterGlobal("SetSelectedWeaponCard", SetSelectedWeapon)
	widgetHandler:RegisterGlobal("SetSelectedSpecialCard", SetSelectedSpecial)
	widgetHandler:RegisterGlobal("SetGreenBalls", SetGreenBalls)

	Spring.SendLuaRulesMsg("Update Card System Widget")
end
