function widget:GetInfo()
	return {
		name      = "Default UI remover",
		desc      = "Disables the default UI elements provided by the engine",
		author    = "Jammer",
		date      = "June 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

local spSendCommands = Spring.SendCommands

function widget:Initialize()
	spSendCommands({
		"resbar 0", -- resource bars
		"clock 0", -- clock showing how long you have played
		"info 0", -- list of players
		"endgraph 0", -- the window displayed at the end of the game
	})
end