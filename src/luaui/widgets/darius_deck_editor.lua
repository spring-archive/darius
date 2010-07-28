function widget:GetInfo()
	return {
		name      = "The deck editor",
		desc      = "Used to edit and create the player's decks",
		author    = "Ziggurat",
		date      = "July 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = false,  --  loaded by default
	}
end

spSendLuaRulesMsg = Spring.SendLuaRulesMsg



local cardPool = {}
local decks = {}--Cards are stored only by card name
local latestCard = {}--Cache for the latest card fetched from the pool




function string.totable(s)
	local t = {}        -- table to collect fields
	if (not s) then return t end
	--Strip outer brackets
	if (s:sub(1,1) == '{') then s = s:sub(2) end
	while (s:sub(-1,-1) == ',') do s = s:sub(1, -2) end
	if (s:sub(-1,-1) == "}") then s = s:sub(1, -2) end
	while (s:sub(-1,-1) == ',') do s = s:sub(1, -2) end
	s = s .. ','        -- add ending comma
	--if (debug_message) then debug_message("String to Table: " .. s) end
	local fieldstart = 1
	while (fieldstart < string.len(s)) do
		-- next field is table? (starts with '{'?)
		if (s:sub(fieldstart, fieldstart) == '{') then
			local i
			-- find closing bracket
			i = s:find("}", fieldstart+1) --NOTE: second table inside causes problems
			if not i then error('unmatched bracket') end

			local f = s:sub(fieldstart+1, i-1)
			table.insert(t, string.totable(f))
			fieldstart = s:find(",", i) + 1
		else -- find next comma
			local nexti = s:find(',', fieldstart)
			local f = s:sub(fieldstart, nexti-1)
			local k, v = f:match("(%w+) = (%w+)")
			if not v then
				--if (debug_message) then debug_message("field: " .. f) end
				if (f ~= "") then table.insert(t, f) end --TODO: Trim string
			else
				--if (debug_message) then debug_message("field: " .. f .. "=>" .. tostring(k) .. " = " .. tostring(v)) end
				t[k] = v -- => t['str'] = val.  TODO: Remove ''s
			end
			fieldstart = nexti + 1
		end
	end
	return t
end




-----------------------
-- Interface helpers --
-----------------------
local function GenerateDecksString()
	local decksString = "{"

	for i = 1, #decks do

		decksString = decksString .. "{"

		for j = 1, #decks[i] do
			decksString = decksString .. decks[i][j] .. ","
		end

		decksString = decksString .. "},"
	end

	decksString = decksString .. "}"

	return decksString
end


local function SetCardPool(poolString)
		cardPool = string.totable(poolString)
end

local function SetDecks(decksString)
	decks = string.totable(decksString)
end

------------------------------------
-- Interfacing with the card pool --
------------------------------------
local function SendDecks()
	spSendLuaRulesMsg("SetDecks:", GenerateDecksString())
end

local function SendActivatedDecks(id1, id2)
	spSendLuaRulesMsg("SetActiveDecks:" .. id1 .. "," .. id2)
end


local function GetCard(cardName)
	local cache = latestCard

	spSendLuaRulesMsg("UnsyncCard:" .. cardName)

	while cache == latestCard do
		--Wait until the card has been received
	end

	return latestCard
end

local function GetDecks()
	local cache = decks

	spSendLuaRulesMsg("UnsyncDecks")

	while cache == decks do
		--Wait until the decks have been received
	end
end

local function GetPool()
	local cache = cardPool

	spSendLuaRulesMsg("UnsyncCardPool")

	while cache == cardPool do
		--Wait until the card pool has been received
	end
end

function RecvFromSynced(_, name, ...)

	if name == "cardpool" then
		SetCardPool(arg[1])
	end

	if name == "decksCollection" then
		SetDecks(arg[1])
	end

	if name == "CardTable" then
		--Parse the received card:
		local newCard = {}

		newCard.id = arg[1]
		newCard.name = arg[2]
		newCard.type = arg[3]
		newCard.img = arg[4]
		newCard.health = arg[5]
		newCard.realoadTime = arg[6]
		newCard.range = arg[7]
		newCard.damage = arg[8]
		newCard.greenballs = arg[9]
		newCard.desc = arg[10]

		latestCard = newCard
	end
end






---------------------
-- Widget call-ins --
---------------------


function widget:Initialize()
	GetDecks()
	GetPool()
end


