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

---------------
-- Game Vars -- Should be loaded from elsewhere?
---------------
local requiredBallsToDraw = 5

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo

----------------
-- Local Vars --
----------------
local Darius = {}
GG.Darius = Darius

local tower
local effect
local selectedMaterial
local selectedWeapon
local selectedSpecial
local greenballs
local hand

local deck = {}
deck[1] = {}
deck[2] = {}

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

----------------------
-- Member Functions --
----------------------
function Darius:SetTower(arg)
	tower = arg
	effect = nil
	SendToUnsynced("TowerName", tower)
	SendToUnsynced("CardEffect", effect)
end

function Darius:SetEffect(arg)
	effect = arg
	tower = nil
	SendToUnsynced("TowerName", tower)
	SendToUnsynced("CardEffect", effect)
end

function Darius:DrawCard(arg)
	--If not a valid deck ID return
	if not (arg == 1 or arg == 2) then return end
	-- If we have cards to draw, draw one
	if (#deck[arg] > 1) then
		hand.insert(tremove(deck[arg],1))
		greenballs = greenballs - requiredBallsToDraw -- decrease balls
		SendToUnsynced("CardHand", hand) -- Update hand in unsynced
		SendToUnsynced("GreenBalls", greenballs) -- Update greenballs in unsynced
	end
end

local function SetSelectedMaterial(card)
	if (selectedMaterial == card) then
		selectedMaterial = nil
	else
		selectedMaterial = card
	end
	SendToUnsynced("SelectedMaterialCard", selectedMaterial)
end

local function SetSelectedWeapon(card)
	if (selectedWeapon == card) then
		selectedWeapon = nil
	else
		selectedWeapon = card
	end
	SendToUnsynced("SelectedWeaponCard", selectedWeapon)
end

local function SetSelectedSpecial(card)
	if (selectedSpecial == card) then
		selectedSpecial = nil
	else
		selectedSpecial = card
	end
	if (selectedSpecial) then
		selectedMaterial = nil
		selectedWeapon = nil
		SendToUnsynced("SelectedMaterialCard", selectedMaterial)
		SendToUnsynced("SelectedWeaponCard", selectedWeapon)
	end
	SendToUnsynced("SelectedSpecialCard", selectedSpecial)
end

function Darius:UseSelected()
	if (selectedWeapon) then
		selectedWeapon.used = true
		SetSelectedWeapon(nil)
	end
	if (selectedMaterial) then
		selectedMaterial.used = true
		SetSelectedMaterial(nil)
	end
	if (selectedSpecial) then
		selectedSpecial.used = true
		SetSelectedSpecial(nil)
	end
	--Remove used from hand
	for i, card in pairs(hand) do
		if (card.used == true) then
			table.remove(hand, i) --TODO: Does this work?  Might not handle the table changinging when iterating
		end
	end
	SendToUnsynced("CardHand", hand)
end

-- Requires actual card
function Darius:ActivateCard(card)
	if not (card) then return end --assure there is card data
	if (card.type) then --make sure the card is properly formed
		if (card.type == "Material") then
			SetSelectedMaterial(card)
		elseif (card.type == "Weapon") then
			SetSelectedWeapon(card)
		else
			SetSelectedSpecial(card)
		end
	end
end

--------------------
-- Synced Getters --
--------------------
function Darius:GetTower()
	spEcho("Gadget:Tower")
	return tower
end

function Darius:GetEffect()
	spEcho("Gadget:Effect")
	return effect
end

function Darius:GetHand()
	spEcho("Gadget:Hand")
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

function Darius:GetGreenBalls()
	return greenballs
end

function Darius:CanDraw()
	return (greenballs >= requiredBallsToDraw)
end

---------------------
-- Synced Call-ins --
---------------------
function gadget:Initialize()
	Darius:SetTower("corllt") --NOTE: The SyncActions aren't in place yet, so this isn't sent properly.
					  -- However, the widget requests the data when it loads, so this should be taken care of.
	hand = {
		{id = 1, name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0},
		{id = 2, name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0},
		{id = 3, name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1  , range =  50, damage =  5},
		{id = 4, name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1  , range =  50, damage =  5},
		{id = 5, name = "Lightning", type = "Weapon"  , img = 'LuaUI/images/energy.png', health =     0, rate =  0.5, range = 100, damage = 10},
	}
end

function gadget:GameFrame(f)
end

function gadget:RecvLuaMsg(msg, playerID)
	--spEcho("[Card Gadget] RecvLuaMsg: "..msg)
	if string.find(msg, "Activate Card:") then -- Select this card
		cardID = msg:gsub("Activate Card:","")
		for _, card in pairs(hand) do
			if card.id == cardID then
				ActivateCard(card)
				return
			end
		end
	elseif string.find(msg, "Draw Card:") then -- Select this card
		deck = msg:gsub("Draw Card:","")
		DrawCard(deck)
	elseif string.find(msg, "Update Card System Widget") then
		SendToUnsynced("CardHand", nil) --hand) --TODO: Can't send tables?
		SendToUnsynced("TowerName", tower)
		SendToUnsynced("CardEffect", effect)
		SendToUnsynced("SelectedMaterialCard", selectedMaterial)
		SendToUnsynced("SelectedWeaponCard", selectedWeapon)
		SendToUnsynced("SelectedSpecialCard", selectedSpecial)
		SendToUnsynced("GreenBalls", greenballs)
	end
end

------------------------------------------------
else --unsynced
------------------------------------------------

----------------------------------
-- Send Unsynced vars to widget --
----------------------------------
local function SendTowerName(_, tower)
	--Make sure the widget still exists (might have been stopped)
	if (Script.LuaUI('SetTower')) then
		-- Call the widget function.  Widget must declare function via 'widgetHandler:RegisterGlobal'
		Script.LuaUI.SetTower(tower)
	end
end

local function SendHand(_, hand)
	if (Script.LuaUI('SetCardHand')) then
		Script.LuaUI.SetCardHand(hand)
	end
end

local function SendEffect(_, effect)
	if (Script.LuaUI('SetCardEffect')) then
		Script.LuaUI.SetCardEffect(effect)
	end
end

local function SendMaterial(_, material)
	if (Script.LuaUI('SetSelectedMaterialCard')) then
		Script.LuaUI.SetSelectedMaterialCard(material)
	end
end

local function SendWeapon(_, weapon)
	if (Script.LuaUI('SetSelectedWeaponCard')) then
		Script.LuaUI.SetSelectedWeaponCard(weapon)
	end
end

local function SendSpecial(_, card)
	if (Script.LuaUI('SetSelectedSpecialCard')) then
		Script.LuaUI.SetSelectedSpecialCard(card)
	end
end

local function SendBalls(_, balls)
	if (Script.LuaUI('SetGreenBalls')) then
		Script.LuaUI.SetGreenBalls(balls)
	end
end

-----------------------
-- Unsynced Call-ins --
-----------------------
function gadget:Initialize()
	--Init the sender functions
	gadgetHandler:AddSyncAction("CardHand", SendHand)
	gadgetHandler:AddSyncAction("TowerName", SendTowerName)
	gadgetHandler:AddSyncAction("CardEffect", SendEffect)
	gadgetHandler:AddSyncAction("SelectedMaterialCard", SendMaterial)
	gadgetHandler:AddSyncAction("SelectedWeaponCard", SendWeapon)
	gadgetHandler:AddSyncAction("SelectedSpecialCard", SendSpecial)
	gadgetHandler:AddSyncAction("GreenBalls", SendBalls)
end

end -- End synced check