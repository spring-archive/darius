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

----------------
-- Local Vars --
----------------
local startscriptfilename = ""

---------------------
-- Local Functions --
---------------------

local function StartNewGame(mapFile)
	if (spRestart) then --If Spring.Restart exists
		scriptContent = VFS.LoadFile(startscriptfilename)
		scriptContent.MapName = mapFile
		scriptContent = scriptContent.toString()
		spEcho(widget:GetInfo().name..": Ok, calling Spring.Restart(\"-s\",\"[GAME]{..}\") now!")
		spRestart("-s", scriptContent)
		spEcho(widget:GetInfo().name..": Just called Spring.Restart(\"-s\",\"[GAME]{..}\")")
		spEcho(widget:GetInfo().name..": Wait... we shouldn't be here... we should have restarted or crashed or something by now.")
	else
		spEcho("Could not call Spring.Restart!  Please check your game version.")
	end
end
