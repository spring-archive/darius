function widget:GetInfo()
	return {
		name      = "Card System Frontend",
		desc      = "Interfaces with the Darius Card system",
		author    = "Darius Team",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default
		api       = true, --I think this forces it to be loaded before other widgets
	}
end

---------------
-- Game Vars -- Should be loaded from elsewhere (gadget?)
---------------
local requiredBallsToDraw = 1

--------------
-- Speed Up --
--------------
local spEcho = Spring.Echo
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg

-- Chili Stuff
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color

WhiteStr   = "\255\255\255\255"
GreyStr    = "\255\210\210\210"
GreenStr   = "\255\092\255\092"
YellowStr  = "\255\255\255\152"
OrangeStr  = "\255\255\190\128"
RedStr     = "\255\255\170\170"


----------------
-- Local Vars --
----------------
local Darius = widget
WG.Darius = Darius

local tower = nil
local effect = nil
local greenballs = 0
local hand = {}
local selectedWeapon = {}
local selectedMaterial = {}
local selectedSpecial = {}
local cards = {} -- The in-game card pool (not the player's full card collection)

local function getCardBackground(type)
	if (type == "Material") then
		return 'cards/images/background/material.png'
	elseif (type == "Weapon") then
		return 'cards/images/background/weapon.png'
	elseif (type == "Special") then
		return 'cards/images/background/special.png'
	end
end

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

function Darius:GetCardButton(card, width, height)
	-- setup Chili
	if not (Button) then Button = WG.Chili.Button end
	if not (Label) then Label = WG.Chili.Label end
	if not (Image) then Image = WG.Chili.Image end

	local lbl_name = Label:New{valign = "top"}
	local img_center = Image:New{keepAspect = false}
	local img_background= Image:New{keepAspect = false}
	local lbl_health = Label:New{x=5}
	local lbl_reloadTime = Label:New{x=5}
	local lbl_range = Label:New{x=5}
	local lbl_damage = Label:New{x=5}
	local lbl_greenballs = Label:New{valign = "top"}

	lbl_name:SetCaption("")
	lbl_greenballs:SetCaption("")

	local button = Button:New{
		name = "",
		caption = "",
		textColor = color.game_fg,
		card = card,
		children = {
			lbl_name,
			lbl_greenballs,
			img_center,
			lbl_health,
			lbl_reloadTime,
			lbl_range,
			lbl_damage,
			img_background,
		},

		UpdateCard = function(button, width, height)
			--Prepare card data (Formatting/Validation)
			local card = button.card
			card.name       = card.name       or "Unknown"
			card.type       = card.type       or "Unknown"
			card.health     = card.health     or 0
			card.reloadTime = string.format("%.3f", card.reloadTime or 0)
			card.range      = card.range      or 0
			card.damage     = card.damage     or 0
			card.greenballs = card.greenballs or 0
			card.desc       = card.desc       or ""

			button.width = width
			button.height = height

			width = width - 10
			height = height - 10

			--Create tooltip
			tooltip =   WhiteStr  .. "Name: "        .. card.name         .. "\n" ..
					GreyStr   .. "Type: "        .. card.type         .. "\n" ..
					GreenStr  .. "Health: "      .. card.health       .. "\n" ..
					YellowStr .. "Reload Time: " .. card.reloadTime   .. "s\n" ..
					OrangeStr .. "Range: "       .. card.range        .. "\n" ..
					RedStr    .. "Damage: "      .. card.damage       .. "\n" ..
					WhiteStr  .. "Desc:\n"       .. card.desc
			button.tooltip = tooltip
	
			--Determine highlighting
			local background = color.game_bg
			if (card == selectedSpecial) then
				background = color.blue
			elseif (card == selectedMaterial or card == selectedWeapon) then
				background = color.game_fg
			end
			button.backgroundColor = background
			
			-- Visual formatting
			lbl_name:SetCaption(card.name)
			lbl_name.x = 5
			lbl_name.y = 5
			lbl_name.font.size = 13
			while (lbl_name.font:GetTextWidth(lbl_name.caption) > width - 15) do
				lbl_name.font.size = lbl_name.font.size - 1
			end
			lbl_name:Invalidate()

			lbl_greenballs:SetCaption(card.greenballs)
			lbl_greenballs.x = width - 10
			lbl_greenballs.y = 5
			lbl_greenballs.font.color = color.black
			if (card.greenballs < 0) then
				lbl_greenballs.font.color = color.red
			elseif (card.greenballs > 0) then
				lbl_greenballs.font.color = color.green
			end
			lbl_greenballs:Invalidate()

			img_center.file = card.img
			img_center.x = width/6
			img_center.y = height/10
			img_center.width = width*2/3
			img_center.height = height*2/5
			img_center:Invalidate()

			--Card data display
			if (card.health ~= 0) then
				lbl_health:SetCaption(GreenStr .. "Health: " .. card.health)
				lbl_health.font.size = height/15
				while (lbl_health.font:GetTextWidth(lbl_health.caption) > width - 15) do
					lbl_health.font.size = lbl_health.font.size - 1
				end
			else
				lbl_health:SetCaption("")
				lbl_health.font.size = 0
			end
			lbl_health.y = height/10 + height*2/5 + 5
			lbl_health:Invalidate()

			if (card.reloadTime ~= 0) then
				lbl_reloadTime:SetCaption(YellowStr .. "Reload: " .. card.reloadTime)
				lbl_reloadTime.font.size = height/15
				while (lbl_reloadTime.font:GetTextWidth(lbl_reloadTime.caption) > width - 15) do
					lbl_reloadTime.font.size = lbl_reloadTime.font.size - 1
				end
			else
				lbl_reloadTime:SetCaption("")
				lbl_reloadTime.font.size = 0
			end
			lbl_reloadTime.y = lbl_health.y + lbl_health.font.size
			lbl_reloadTime:Invalidate()

			if (card.range ~= 0) then
				lbl_range:SetCaption(OrangeStr .. "Range: " .. card.range)
				lbl_range.font.size = height/15
				while (lbl_range.font:GetTextWidth(lbl_range.caption) > width - 15) do
					lbl_range.font.size = lbl_range.font.size - 1
				end
			else
				lbl_range:SetCaption("")
				lbl_range.font.size = 0
			end
			lbl_range.y = lbl_reloadTime.y + lbl_reloadTime.font.size
			lbl_range:Invalidate()

			if (card.damage ~= 0) then
				lbl_damage:SetCaption(RedStr .. "Damage: " .. card.damage)
				lbl_damage.font.size = height/15
				while (lbl_damage.font:GetTextWidth(lbl_damage.caption) > width - 15) do
					lbl_damage.font.size = lbl_damage.font.size - 1
				end
			else
				lbl_damage:SetCaption("")
				lbl_damage.font.size = 0
			end
			lbl_damage.y = lbl_range.y + lbl_range.font.size
			lbl_damage:Invalidate()

			img_background.file = getCardBackground(card.type)
			img_background.width = width
			img_background.height = height
			img_background:Invalidate()

			button:Invalidate()
		end,
	}
	
	Spring.PlaySoundFile("sounds/ui/card_pick.wav")

	button:UpdateCard(width, height)
	return button
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

local function UpdateCard(id, name, type, img, health, reloadTime, range, damage, greenballs, desc)
	id = 0 + id
	if not (cards[id]) then
		cards[id] = {}
		spEcho("SNH: Created new card on update.  Why?") --Should never return this error.
	end
	--spEcho("Updating card data")
	local card = cards[id]
	card.id = id
	card.name = name
	card.type = type
	card.img = img
	card.health = health
	card.reloadTime = reloadTime
	card.range = range
	card.damage = damage
	card.greenballs = greenballs
	card.desc = desc

	--for v,k in pairs(card) do spEcho(v .. ": " .. k) end
end

local function SetTower(arg)
	tower = arg
end

local function SetEffect(name, desc)
	if (not name) then effect = nil end
	effect = {}
	effect.name = name
	effect.desc = desc
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
