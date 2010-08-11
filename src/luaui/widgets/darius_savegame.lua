function widget:GetInfo()
	return {
		name      = "Card Pool Save Widget",
		desc      = "Used by the card pool to save data",
		author    = "xcompwiz",
		date      = "July, 17th 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,
		api       = true,
	}
end

-----------------
-- Definitions --
-----------------
local GAMEDATA_FILENAME = LUAUI_DIRNAME .. '/Config/Darius_data.lua'
VFS.Include(LUAUI_DIRNAME .. 'savetable.lua')

local function SaveData(pool, decks, selection)
	if (debug_message) then debug_message("Saving Player Data") end
	data = {}
	data.pool = pool
	data.decks = decks
	data.selection = selection
	if (debug_message) then debug_message("Saving to "..GAMEDATA_FILENAME) end
	--Save Table as script file
	table.save(data, GAMEDATA_FILENAME, '-- Darius Game Data')
end

function widget:Initialize()
	widgetHandler:RegisterGlobal("SaveGameData" , SaveData)
end