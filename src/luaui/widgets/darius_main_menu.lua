function widget:GetInfo()
	return {
		name = "Darius Main Menu",
		desc = "Displays a menu for the game",
		author = "kap89/xcompwiz",
		date = "July 27th, 2010",
		layer = 100,
		enabled = true,
	}
end

--------------
-- Speed Up --
--------------
local spEcho    = Spring.Echo
local spRestart = Spring.Restart

---------------------
-- Table functions --
---------------------

function table.tostring(t)
	str = "{"
	i = 0
	for k,v in pairs(t) do
		if (type(v) == "table") then --Next level needed for effects
			str = str .. k.. " = '" .. table.tostring(v) .. "', "
		elseif (type(v) ~= "function") then
			str = str .. k.. " = '" .. v .. "', "
		end
	end
	str = str .. "}"
	return str
end

----------------
-- Local Vars --
----------------
local startscriptfilename = "loader_script.lua"

---------------------
-- Local Functions --
---------------------

local function StartNewGame(mapfile)
	if ((spRestart) and VFS.FileExists(startscriptfilename)) then --If Spring.Restart exists
		scriptContent = VFS.Include(startscriptfilename)
		if (scriptContent) then
			spEcho(table.tostring(scriptContent))
			if (mapfile) then
				scriptContent.MapName = mapfile
			end
			spEcho(widget:GetInfo().name..": Starting game on "..scriptContent.MapName)
			scriptContent = scriptContent:toString()
			spEcho(widget:GetInfo().name..": Calling Spring.Restart(\"-s\",\"[GAME]{..}\") now!")
			spRestart("-s", scriptContent)
			spEcho(widget:GetInfo().name..": Just called Spring.Restart(\"-s\",\"[GAME]{..}\")")
			spEcho(widget:GetInfo().name..": Wait... we shouldn't be here... we should have restarted or crashed or something by now.")
		else
			spEcho("Could not execute the necessary script file.")
		end
	else
		spEcho("Could not call Spring.Restart!  Please check your game version.")
	end
end

function widget:GameOver()
	StartNewGame("the_labyrinth.smf")
end