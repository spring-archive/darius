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
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg

----------------
-- Local Vars --
----------------
local Darius = widget
WG.Darius = Darius

local tower
local effect
local greenballs = 0
local hand = {}
local selectedWeapon = {}
local selectedMaterial = {}
local selectedSpecial = {}
local testhand = { --For testing the hand, obviously
	{id = 1, name = "Metal", type = "Material", img = 'LuaUI/images/ibeam.png'},
	{id = 2, name = "Fire" , type = "Weapon"  , img = 'LuaUI/images/energy.png'},
	{id = 3, name = "Heal" , type = "Special" , img = 'bitmaps/gpl/nano.tga'},
	{id = 4, name = "Nuke" , type = "Special" , img = 'icons/nuke.dds'},
	{id = 5, name = "Alien", type = "Special" , img = 'LuaUI/images/friendly.png'},
}

local cards = {} -- The in-game card pool (not necessarily the player's full card collection)

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
	return hand
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

function Darius:GetGreenballs()
	return greenballs
end

function Darius:CanDraw()
	if not (greenballs) then
		greenballs = 0
	end
	--spEcho(greenballs)
	--spEcho(requiredBallsToDraw)
	--spEcho(greenballs .. " / " .. requiredBallsToDraw)
	--spEcho(greenballs >= requiredBallsToDraw)
	return (greenballs >= requiredBallsToDraw)
end

function Darius:ActivateCard(card)
	--Pass actual card to gadget (by ID)
	spSendLuaRulesMsg("Activate Card:" .. card.id)
end

function Darius:Draw(deck)
	--Tell gadget to draw from specified deck
	spSendLuaRulesMsg("Draw Card:" .. deck)
	--spEcho("Draw Card:" .. deck)
end

-----------------------------
-- Unsynced Vars Receivers --
-----------------------------
local function SetHand(handStr)
	--spEcho("Receiving hand: " .. handStr)
	local new_hand = {}
	for id in string.gmatch(handStr, "%d+") do
		id = 0 + id
		if not (cards[id]) then
			cards[id] = {id = id}
			spSendLuaRulesMsg("Send Card Data:" .. id)
		end
		table.insert(new_hand, cards[id])
	end
	--for _, card in pairs(new_hand) do
	--	spEcho("Card:")
	--	for v,k in pairs(card) do spEcho(v .. ": " .. k) end
	--end
	hand = new_hand
end

local function UpdateCard(id, img, name, type, health, reloadTime, range, sightDistance, damage, weaponVelocity, desc)
	id = 0 + id
	if not (cards[id]) then
		cards[id] = {}
		spEcho("Created new card on update.  Why?") --Should never return this error.
	end
	--spEcho("Updating card data")
	local card = cards[id]
	card.id = id
	card.img = img
	card.name = name
	card.type = type
	card.health = health
	card.reloadTime = reloadTime
	card.range = range
	card.sightDistance = sightDistance
	card.damage = damage
	card.weaponVelocity = weaponVelocity
	card.desc = desc

	--for v,k in pairs(card) do spEcho(v .. ": " .. k) end
end

local function SetTower(arg)
	tower = arg
end

local function SetEffect(arg)
	effect = arg
end

local function SetSelectedMaterial(id)
	if not (id) then
		selectedMaterial = nil
		return
	end
	if not (cards[id]) then
		cards[id] = {id = id}
		spSendLuaRulesMsg("Send Card Data:" .. id)
	end
	selectedMaterial = cards[id]
end

local function SetSelectedWeapon(id)
	if not (id) then
		selectedWeapon = nil
		return
	end
	if not (cards[id]) then
		cards[id] = {id = id}
		spSendLuaRulesMsg("Send Card Data:" .. id)
	end
	selectedWeapon = cards[id]
end

local function SetSelectedSpecial(id)
	if not (id) then
		selectedSpecial = nil
		return
	end
	if not (cards[id]) then
		cards[id] = {id = id}
		spSendLuaRulesMsg("Send Card Data:" .. id)
	end
	selectedSpecial = cards[id]
end

local function SetGreenballs(arg)
	--spEcho("Receiving Greenballs: " .. arg)
	greenballs = arg
end

--------------
-- Call-ins --
--------------
function widget:Initialize()
	widgetHandler:RegisterGlobal("SetCardHand" , SetHand)
	widgetHandler:RegisterGlobal("UpdateCard" , UpdateCard)
	widgetHandler:RegisterGlobal("SetTower", SetTower)
	widgetHandler:RegisterGlobal("SetCardEffect", SetEffect)
	widgetHandler:RegisterGlobal("SetSelectedMaterialCard", SetSelectedMaterial)
	widgetHandler:RegisterGlobal("SetSelectedWeaponCard", SetSelectedWeapon)
	widgetHandler:RegisterGlobal("SetSelectedSpecialCard", SetSelectedSpecial)
	widgetHandler:RegisterGlobal("SetGreenballs", SetGreenballs)

	spSendLuaRulesMsg("Resend All")
end
