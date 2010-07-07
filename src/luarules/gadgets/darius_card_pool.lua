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
-- Table Functions --
---------------------

function table.copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end



----------------------
-- Synced Functions --
----------------------

if (not gadgetHandler:IsSyncedCode()) then
	return false -- no unsynced code
end


local function LoadCardFromFile(cardName)
	cardName = string.lower(cardName) -- filename is in lowercase
	cardName = string.gsub(cardName, " ", "_") -- filename has underscores instead of spaces
	
	local cardData = {}
	cardData = VFS.Include("cards/lua/"..cardName..".lua")
	return cardData
end


local function SendDecks()  -- Sends the decks to the instance game manager
	
	for i = 1, 3 do
		Darius:AddCard(table.copy(LoadCardFromFile("Stone")), 1)
	end

	for i = 1, 2 do
		Darius:AddCard(table.copy(LoadCardFromFile("Metal")), 1)
	end
	
	for i = 1, 3 do
		Darius:AddCard(table.copy(LoadCardFromFile("Fire")), 2)
	end
	
	for i = 1, 2 do
		Darius:AddCard(table.copy(LoadCardFromFile("Lightning")), 2)
	end
	
	Darius:AddCard(table.copy(LoadCardFromFile("Pink Fluffy Bunnies")), 1)

end


local function StartGame()
	if (not GG.Darius) then
		spEcho("Game failed to load properly")
		return
	end
	
	Darius = GG.Darius
	Darius:ClearGame()
	SendDecks()
	Darius:AddGreenballs(40)
end


function gadget:Initialize()
	StartGame()
end
