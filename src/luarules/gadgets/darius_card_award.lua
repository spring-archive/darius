function gadget:GetInfo()
	return {
		name      = "Card Award System",
		desc      = "Awards the player with cards at the end of a session",
		author    = "xcompwiz",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,  --  loaded by default
	}
end

--------------
-- Speed Up --
--------------

local spEcho              = Spring.Echo
local spGetGameRulesParam = Spring.GetGameRulesParam

--local debug_message = spEcho

----------------
-- Local Vars --
----------------

local awardsfile = "gamedata/awards.lua"
local randomcard = {}

---------------------
-- Local Functions --
---------------------

local function RandFromList(list)
	i = math.random(1, #list)
	return list[i]
end

local function LoadCardData()
	local materialFiles = VFS.DirList('cards/lua/material', '*.lua')
	local weaponFiles = VFS.DirList('cards/lua/weapon', '*.lua')
	local specialFiles = VFS.DirList('cards/lua/special', '*.lua')

	randomcard = {}
	for i=1, #materialFiles do
		local card = VFS.Include(materialFiles[i])
		table.insert(randomcard, card.name)
	end
	for i=1, #weaponFiles do
		local card = VFS.Include(weaponFiles[i])
		table.insert(randomcard, card.name)
	end

	for i=1, #specialFiles do
		local card = VFS.Include(specialFiles[i])
		table.insert(randomcard, card.name)
	end
end

local function AwardCards(award)
	if (type(award) == "string") then award = {award} end
	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Awarding Player") end
	str = ""
	for _, name in pairs(award) do
		--Give award
		GG.CardPool:AddCardToPlayer(name, 1)
		str = str .. " " .. name
	end

	--Notify UI
	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Awarded player with " .. str) end
	SendToUnsynced("awardstr", str)
end

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then -- synced
------------------------------------------------

function gadget:Initialize()
	if (GG.Darius) then
		GG.Darius.AwardCards = AwardCards
	end

	--Get map info
	local mapname = string.gsub(Game.mapName,"\.smf$","") -- remove the .smf from the mapName string
	local mapfile = "maps/" .. mapname .. ".lua"

	--Setup the card lists
	LoadCardData()

	local loaded = nil
	if (VFS.FileExists(awardsfile)) then
		loaded = VFS.Include(awardsfile)
	end
	if not loaded then loaded = {} end
	easy = loaded.easy or randomcard
	normal = loaded.normal or randomcard
	hard = loaded.hard or randomcard
	loaded = nil

	if (VFS.FileExists(mapfile)) then
		loaded = VFS.Include(mapfile)
	end
	if (loaded) then
		if not (loaded.awards) then loaded.awards = {} end
		if (loaded.awards.easy) then easy = loaded.awards.easy end
		if (loaded.awards.normal) then normal = loaded.awards.normal end
		if (loaded.awards.hard) then hard = loaded.awards.hard end
	end
end

function gadget:GameOver()
	if (spGetGameRulesParam("gameWon") ~= 1) then return end

	local difficulty = spGetGameRulesParam("difficulty")
	if not difficulty then difficulty = "easy" end

	--Decide on award
	if (debug_message) then debug_message(gadget:GetInfo().name .. ": Selecting Award") end
	award = {}
	table.insert(award, RandFromList(easy))
	if (difficulty == "normal" or difficulty == "hard") then
		table.insert(award, RandFromList(normal))
	end
	if (difficulty == "hard") then
		table.insert(award, RandFromList(hard))
	end

	AwardCards(award)
end

------------------------------------------------
else --unsynced
------------------------------------------------

local function RecvAwardStr(_, str)
	if Script.LuaUI('AddAwardDisplay') then
		if (debug_message) then debug_message(gadget:GetInfo().name .. ": Notifying UI of " .. str .. " award") end
		Script.LuaUI.AddAwardDisplay(str)
	end
end

function gadget:Initialize()
	gadgetHandler:AddSyncAction("awardstr", RecvAwardStr)--This is the one that gets called on the SendToUnsynced
end

end -- End synced check
