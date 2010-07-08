function gadget:GetInfo()
	return {
		name      = "Card Pool",
		desc      = "Stores the cards the player owns",
		author    = "xcompwiz",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default?
	}
end



--------------
-- Speed Up --
--------------

local spEcho = Spring.Echo



---------------------
-- Local Variables --
---------------------

local allPossibleCards = {
	material = {},
	weapon = {},
	special = {}
}



---------------------
-- Table Functions --
---------------------

function table.copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		if (type(v) == "table") then
			t2[k] = table.copy(v)
		else
			t2[k] = v
		end
	end
	return t2
end



----------------------
-- Synced Functions --
----------------------

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end


local function LoadCardsFromFiles()
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')
	
	for i=1, #materialFiles do
		allPossibleCards.material[i] = VFS.Include(materialFiles[i])
	end
	
	for i=1, #weaponFiles do
		allPossibleCards.weapon[i] = VFS.Include(weaponFiles[i])
	end
	
	for i=1, #specialFiles do
		allPossibleCards.special[i] = VFS.Include(specialFiles[i])
	end
end


local function GetCardByTypeAndName(cardType, cardName)
	for i=1, #allPossibleCards[cardType] do
		if allPossibleCards[cardType][i].name == cardName then
			return allPossibleCards[cardType][i]
		end
	end
	return nil
end


local function SendDecks()  -- Sends the decks to the instance game manager
	for i = 1, 2 do
		Darius:AddCard(GetCardByTypeAndName("material", "Stone"), 1)
	end
	
	for i = 1, 2 do
		Darius:AddCard(GetCardByTypeAndName("material", "Metal"), 1)
	end
	
	for i = 1, 2 do
		Darius:AddCard(GetCardByTypeAndName("weapon", "Fire"), 2)
	end
	
	for i = 1, 2 do
		Darius:AddCard(GetCardByTypeAndName("weapon", "Lightning"), 2)
	end

	Darius:AddCard(GetCardByTypeAndName("special", "Castle Revival"), 1)
    Darius:AddCard(GetCardByTypeAndName("special", "Earthquake"), 1)
    Darius:AddCard(GetCardByTypeAndName("special", "Quad Damage"), 1)
    Darius:AddCard(GetCardByTypeAndName("special", "Sandstorm"), 1)
    Darius:AddCard(GetCardByTypeAndName("special", "Solar Radiation"), 2)
    Darius:AddCard(GetCardByTypeAndName("special", "Temporary Degreelessness"), 2)
    Darius:AddCard(GetCardByTypeAndName("special", "Tower Invisibility"), 2)
    Darius:AddCard(GetCardByTypeAndName("special", "Tower Regeneration"), 2)
end


local function StartGame()
	if (not GG.Darius) then
		spEcho("Game failed to load properly")
		return
	end
	
	Darius = GG.Darius
	Darius:ClearGame()
	
	LoadCardsFromFiles()
	SendDecks()
	
	Darius:AddGreenballs(40)
end


function gadget:Initialize()
	StartGame()
end
