function gadget:GetInfo()
	return {
		name      = "Card System Backend",
		desc      = "Controls the Darius Card system",
		author    = "Darius Team",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default?
	}
end

---------------
-- Game Vars -- Should be loaded from elsewhere?
---------------
local requiredBallsToDraw = 1

--------------
-- Speed Up --
--------------
local spEcho            = Spring.Echo
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg

--local debug_message = spEcho

----------------
-- Local Vars --
----------------
local Darius = gadget
GG.Darius = Darius

local tower = nil
local effect = nil
local selectedMaterial = {}
local selectedWeapon = {}
local selectedSpecial = {}

local greenballs = 0

-- Card Handling --
local cards = {}
local hand = {}
local deck = {}
deck[1] = {}
deck[2] = {}

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

-----------------------------
-- SendToUnsynced Wrappers --
-----------------------------

local function UnsyncTower()
	SendToUnsynced("TowerID", tower)
end

local function UnsyncEffect()
	if (effect) then
		SendToUnsynced("CardEffect", effect.name, effect.desc)
	else
		SendToUnsynced("CardEffect", nil, nil)
	end
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
	--spEcho("Unsyncing Greenballs: " .. greenballs)
	SendToUnsynced("Greenballs", greenballs)
end

-- Requires actual card
local function UnsyncCard(card)
	--spEcho("Unsyncing card [" .. card.id .. "]")
	if not (card) then return end
	SendToUnsynced("CardTable",
		card.id,
		card.name,
		card.type,
		card.img,
		card.health,
		card.reloadTime,
		card.range,
		card.damage,
		card.greenballs,
		card.desc
	)
end

local function UnsyncHand()
	msg = ""
	for _, card in pairs(hand) do
		msg = msg .. card.id .. " "
	end
	SendToUnsynced("CardHand", msg) --Can't send tables?
	--spEcho("Unsyncing hand: " .. msg)
end

----------------------
-- Member Functions --
----------------------
function Darius:AddCard(card, deckID)
	if ((not deckID) or (not card)) then return end
	if not (deckID == 1 or deckID == 2) then return end
	card.id = #cards + 1 --LUA Tables are 1 indexed
	cards[card.id] = card
	table.insert(deck[deckID], math.random(#deck[deckID] + 1), card)
end

function Darius:SetTower(arg)
	tower = arg
	UnsyncTower()
end

function Darius:SetEffect(arg)
	effect = arg
	UnsyncEffect()
end

function Darius:AddGreenballs(num)
	--spEcho("Greenballs = " .. greenballs .. " + " .. num)
	greenballs = greenballs + num
	--spEcho("Greenballs = " .. greenballs)
	UnsyncGreenballs()
end

function Darius:DrawCard(deckID)
	--If not a valid deck ID return
	if not (deckID) then return end
	if not (deckID == 1 or deckID == 2) then return end
	--spEcho("Drawing from deck " .. deckID)

	-- Makes sure we are allowed to draw
	if not (Darius:CanDraw()) then return end
	--spEcho("Drawing is allowed, looking for cards")

	-- If we have cards to draw, draw one
	if (#deck[deckID] > 0) then
		table.insert(hand, table.remove(deck[deckID], 1))
		--spEcho("Beginning Greenballs: " .. greenballs)
		greenballs = greenballs - requiredBallsToDraw -- decrease balls
		--spEcho("Ending Greenballs: " .. greenballs)
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
	selectedSpecial = nil
	UnsyncSelectedMaterial()
	UnsyncSelectedSpecial()
end

local function SetSelectedWeapon(card)
	--if card then spEcho("Activating card as " .. card.type) end
	if (selectedWeapon == card) then
		selectedWeapon = nil
	else
		selectedWeapon = card
	end
	selectedSpecial = nil
	UnsyncSelectedWeapon()
	UnsyncSelectedSpecial()
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
	new_hand = {}
	for i, card in pairs(hand) do
		if not (card.used) then
			table.insert(new_hand, card)
		end
	end
	hand = new_hand
	UnsyncHand()
end

function Darius:ClearGame() -- Clears the game session data
	Darius:SetTower(nil)
	Darius:SetEffect(nil)
	SetSelectedMaterial(nil)
	SetSelectedWeapon(nil)
	SetSelectedSpecial(nil)

	greenballs = 0
	UnsyncGreenballs()

	cards = {}
	hand = {}
	UnsyncHand() -- Update hand in unsynced
	deck = {}
	deck[1] = {}
	deck[2] = {}
end

--------------------
-- Synced Getters --
--------------------
function Darius:GetTower()
	return tower
end

function Darius:GetEffect()
	if (debug_message) then debug_message("Darius:GetEffect Called") end	
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
	--spEcho (greenballs .. " / " .. requiredBallsToDraw)
	return (greenballs >= requiredBallsToDraw)
end

function Darius:GetDeckSize(deckID)
	if not (deckID) then return 0 end
	if not (deckID == 1 or deckID == 2) then return 0 end
	return #deck[deckID]
end

---------------------
-- Synced Call-ins --
---------------------
function gadget:Initialize()
end

function gadget:RecvLuaMsg(msg, playerID)
	if string.find(msg, "Activate Card:") then -- Select this card
		cardID = 0 + msg:gsub("Activate Card:","")
		if not (cards[cardID]) then return end
		Darius:ActivateCard(cards[cardID])
	elseif string.find(msg, "Draw Card:") then -- Draw from specified
		--spEcho("Backend: Drawing card")
		deckID = 0 + msg:gsub("Draw Card:","")
		Darius:DrawCard(deckID)
	elseif string.find(msg, "Send Card Data:") then -- The card data was requested
		cardID = 0 + msg:gsub("Send Card Data:","")
		--spEcho("Card data for [" .. cardID .. "] requested")
		if not (cards[cardID]) then return end
		--spEcho("Card is valid")
		UnsyncCard(cards[cardID])
	elseif string.find(msg, "Resend All") then -- the widget requested the game data
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
local function SendTowerID(_, tower)
	--Make sure the widget function exists
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

local function SendEffect(_, ...)
	if (Script.LuaUI('SetCardEffect')) then
		Script.LuaUI.SetCardEffect(...)
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
	--spEcho("Sending Greenballs: " .. balls)
	if (Script.LuaUI('SetGreenballs')) then
		Script.LuaUI.SetGreenballs(balls)
	end
end

-----------------------
-- Unsynced Call-ins --
-----------------------
function gadget:Initialize()
	--Init the sender functions
	gadgetHandler:AddSyncAction("CardHand", SendHand)
	gadgetHandler:AddSyncAction("CardTable", SendCard)
	gadgetHandler:AddSyncAction("TowerID", SendTowerID)
	gadgetHandler:AddSyncAction("CardEffect", SendEffect)
	gadgetHandler:AddSyncAction("SelectedMaterialCard", SendMaterial)
	gadgetHandler:AddSyncAction("SelectedWeaponCard", SendWeapon)
	gadgetHandler:AddSyncAction("SelectedSpecialCard", SendSpecial)
	gadgetHandler:AddSyncAction("Greenballs", SendBalls)
	spSendLuaRulesMsg("Resend All")
end

end -- End synced check