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
local Darius = gadget
GG.Darius = Darius

local tower
local effect
local selectedMaterial
local selectedWeapon
local selectedSpecial
local greenballs

local hand = {}

local deck = {}
deck[1] = {}
deck[2] = {}

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

local cards = {}
cards[1] = {id = 1, name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0}
cards[2] = {id = 2, name = "Metal"    , type = "Material", img = 'LuaUI/images/ibeam.png' , health =   100, rate = -0.01, range =  10, damage =  0}
cards[3] = {id = 3, name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1   , range =  50, damage =  5}
cards[4] = {id = 4, name = "Fire"     , type = "Weapon"  , img = 'LuaUI/images/energy.png', health =  - 10, rate =  1   , range =  50, damage =  5}
cards[5] = {id = 5, name = "Lightning", type = "Weapon"  , img = 'LuaUI/images/energy.png', health =     0, rate =  0.5 , range = 100, damage = 10}

-----------------------------
-- SendToUnsynced Wrappers --
-----------------------------

local function UnsyncTower()
	SendToUnsynced("TowerName", tower)
end

local function UnsyncEffect()
	SendToUnsynced("CardEffect", effect)
end

local function UnsyncSelectedMaterial()
	--spEcho("Unsyncing selected material card")
	if (selectedMaterial) then
		SendToUnsynced("SelectedMaterialCard", selectedMaterial.id)
	else
		SendToUnsynced("SelectedMaterialCard", nil)
	end
end

local function UnsyncSelectedWeapon()
	--spEcho("Unsyncing selected weapon card")
	if (selectedWeapon) then
		SendToUnsynced("SelectedWeaponCard", selectedWeapon.id)
	else
		SendToUnsynced("SelectedWeaponCard", nil)
	end
end

local function UnsyncSelectedSpecial()
	--spEcho("Unsyncing selected special card")
	if (selectedSpecial) then
		SendToUnsynced("SelectedSpecialCard", selectedSpecial.id)
	else
		SendToUnsynced("SelectedSpecialCard", nil)
	end
end

local function UnsyncGreenballs()
	SendToUnsynced("GreenBalls", greenballs)
end

-- Requires actual card
local function UnsyncCard(card)
	--spEcho("Unsyncing card [" .. card.id .. "]")
	if not (card) then return end
	SendToUnsynced("CardTable", 
		card.id,
		card.img,
		card.name,
		card.type,
		card.health,
		card.firerate,
		card.range,
		card.damage
	)
end

local function UnsyncHand()
	msg = ""
	for _, card in pairs(hand) do
		msg = msg .. card.id .. " "
	end
	SendToUnsynced("CardHand", msg) --Can't send tables?
end

----------------------
-- Member Functions --
----------------------
function Darius:SetTower(arg)
	tower = arg
	effect = nil
	UnsyncTower()
	UnsyncEffect()
end

function Darius:SetEffect(arg)
	effect = arg
	tower = nil
	UnsyncTower()
	UnsyncEffect()
end

function Darius:DrawCard(deckID)
	if not (deckID) then return end
	--If not a valid deck ID return
	if not (deckID == 1 or deckID == 2) then return end
	-- Makes sure we are allowed to draw
	if not (Darius:CanDraw()) then return end
	-- If we have cards to draw, draw one
	if (#deck[deckID] > 1) then
		hand.insert(tremove(deck[deckID],1))
		greenballs = greenballs - requiredBallsToDraw -- decrease balls
		UnsyncHand() -- Update hand in unsynced
		UnsyncGreenballs() -- Update greenballs in unsynced
	end
end

local function SetSelectedMaterial(card)
	--spEcho("Activating card as " .. card.type)
	if (selectedMaterial == card) then
		selectedMaterial = nil
	else
		selectedMaterial = card
	end
	UnsyncSelectedMaterial()
end

local function SetSelectedWeapon(card)
	--spEcho("Activating card as " .. card.type)
	if (selectedWeapon == card) then
		selectedWeapon = nil
	else
		selectedWeapon = card
	end
	UnsyncSelectedWeapon()
end

local function SetSelectedSpecial(card)
	--spEcho("Activating card as " .. card.type)
	if (selectedSpecial == card) then
		selectedSpecial = nil
	else
		selectedSpecial = card
	end
	if (selectedSpecial) then
		selectedMaterial = nil
		selectedWeapon = nil
		UnsyncSelectedMaterial()
		UnsyncSelectedWeapon()
	end
	UnsyncSelectedSpecial()
end

function Darius:DiscardSelected()
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
--	for i, card in pairs(hand) do
--		if (card.used == true) then
--			table.remove(hand, i) --TODO: Does this work?  Might not handle the table changinging when iterating
--		end
--	end
	UnsyncHand()
end

-- Requires actual card
function Darius:ActivateCard(card)
	--spEcho("Card Activation Called")
	if not (card) then return end --assure there is card data
	if (card.type) then --make sure the card is properly formed
		--spEcho("Activating card [" .. card.id .. "]")
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
	--Darius:SetTower("corllt") --NOTE: The SyncActions aren't in place yet, so this isn't sent properly.
					  -- However, the widget requests the data when it loads, so this should be taken care of for the start up.
					  -- Unfortunately, if the rules reload then the ui needs to be reloaded (this is a minor issue)
	hand = {cards[1], cards[2], cards[4], cards[3]}
end

function gadget:GameFrame(f)
end

function gadget:RecvLuaMsg(msg, playerID)
	if string.find(msg, "Activate Card:") then -- Select this card
		cardID = 0 + msg:gsub("Activate Card:","")
		if not (cards[cardID]) then return end
		Darius:ActivateCard(cards[cardID])
	elseif string.find(msg, "Draw Card:") then -- Draw from specified
		deckID = msg:gsub("Draw Card:","")
		Darius:DrawCard(deckID)
	elseif string.find(msg, "Send Card Data:") then -- The card data was requested
		cardID = 0 + msg:gsub("Send Card Data:","")
		--spEcho("Card data for [" .. cardID .. "] requested")
		if not (cards[cardID]) then return end
		--spEcho("Card is valid")
		UnsyncCard(cards[cardID])
	elseif string.find(msg, "Update Card System Widget") then -- the widget requested the game data
		UnsyncHand()
		UnsyncTower()
		UnsyncEffect()
		UnsyncSelectedMaterial()
		UnsyncSelectedWeapon()
		UnsyncSelectedSpecial()
		UnsyncGreenballs()
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

local function SendHand(_, handStr)
	--spEcho("Sending hand as: " .. handStr)
	if (Script.LuaUI('SetCardHand')) then
		Script.LuaUI.SetCardHand(handStr)
	end
end

local function SendCard(_, ...)
	if (Script.LuaUI('UpdateCard')) then
		Script.LuaUI.UpdateCard(...)
	end
end

local function SendEffect(_, effect)
	if (Script.LuaUI('SetCardEffect')) then
		Script.LuaUI.SetCardEffect(effect)
	end
end

local function SendMaterial(_, id)
	if (Script.LuaUI('SetSelectedMaterialCard')) then
		Script.LuaUI.SetSelectedMaterialCard(id)
	end
end

local function SendWeapon(_, id)
	if (Script.LuaUI('SetSelectedWeaponCard')) then
		Script.LuaUI.SetSelectedWeaponCard(id)
	end
end

local function SendSpecial(_, id)
	if (Script.LuaUI('SetSelectedSpecialCard')) then
		Script.LuaUI.SetSelectedSpecialCard(id)
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
	gadgetHandler:AddSyncAction("CardTable", SendCard)
	gadgetHandler:AddSyncAction("TowerName", SendTowerName)
	gadgetHandler:AddSyncAction("CardEffect", SendEffect)
	gadgetHandler:AddSyncAction("SelectedMaterialCard", SendMaterial)
	gadgetHandler:AddSyncAction("SelectedWeaponCard", SendWeapon)
	gadgetHandler:AddSyncAction("SelectedSpecialCard", SendSpecial)
	gadgetHandler:AddSyncAction("GreenBalls", SendBalls)
end

end -- End synced check