function widget:GetInfo()
	return {
		name = "Show Tower",
		desc = "Shows where the tower will be built",
		author = "xcompwiz",
		date = "June 8, 2010",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

--------------
-- Speed Up --
--------------
local spEcho             = Spring.Echo
local spGetMouseState    = Spring.GetMouseState
local spGetTeamColor     = Spring.GetTeamColor
local spSendLuaRulesMsg  = Spring.SendLuaRulesMsg
local spTraceScreenRay   = Spring.TraceScreenRay

--local spGetUnitDefID     = Spring.GetUnitDefID

local glColor            = gl.Color
local glPopMatrix        = gl.PopMatrix
local glPushMatrix       = gl.PushMatrix
local glTranslate        = gl.Translate
local glUnitShape        = gl.UnitShape

----------------
-- Local Vars --
----------------
local tower
local team = 1

local teamColors = {}

---------------------
-- Local Functions --
---------------------

local function GetTeamColor(teamID)
  local colors = teamColors[teamID]
  if (colors) then
    return colors
  end
  local r,g,b = spGetTeamColor(teamID)
  
  color = { r, g, b, 0.4 }
  teamColors[teamID] = color
  return color
end

-------------
-- Callins --
-------------
function widget:Initialize()
	spEcho("Tower Ghost ON")
	team = Spring.GetMyTeamID()
end

function widget:Update()
	if WG.Darius then
		tower = WG.Darius:GetTower()
	end
end

function widget:DrawWorld()
	if (tower) then
		local mx, my = spGetMouseState()
		-- If we are over a chili element then return
		if (WG.Chili) then if (WG.Chili:IsAbove(mx,my)) then return end end
		local _, pos = spTraceScreenRay(mx, my, true, false)
		glColor(GetTeamColor(team))
		if (pos) then
			glPushMatrix()
			glTranslate(pos[1], pos[2], pos[3])

			glUnitShape(tower, team)

			glPopMatrix()
		end
		--local hoverType, hoverData = spTraceScreenRay(mx, my)
		--if (hoverType == "unit") then
		--	spEcho(spGetUnitDefID(hoverData))
		--end
	--	spEcho("Draw Tower "..tostring(pos[1]).." "..tostring(pos[2]).." "..tostring(pos[3]))
	end
end

function widget:Shutdown()
	spEcho("Tower Ghost OFF")
end