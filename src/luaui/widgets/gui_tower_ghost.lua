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

local spGetUnitDefID     = Spring.GetUnitDefID

local glColor            = gl.Color
local glDrawGroundCircle = gl.DrawGroundCircle
local glPopMatrix        = gl.PopMatrix
local glPushMatrix       = gl.PushMatrix
local glTranslate        = gl.Translate
local glUnitShape        = gl.UnitShape
local glVertex           = gl.Vertex

----------------
-- Local Vars --
----------------
local tower

local teamColors = {}

---------------------
-- Local Functions --
---------------------

local function GetTeamColorSet(teamID)
  local colors = teamColors[teamID]
  if (colors) then
    return colors
  end
  local r,g,b = spGetTeamColor(teamID)
  
  colors = {{ r, g, b, 0.4 },
            { r, g, b, 0.7 }}
  teamColors[teamID] = colors
  return colors
end

-------------
-- Callins --
-------------
function widget:Initialize()
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
		local unitID, pos
		local hoverType, hoverData = spTraceScreenRay(mx, my)
		if (hoverType == "ground") then
			pos = hoverData
		end
		if (hoverType == "unit") then
			--spEcho(spGetUnitDefID(hoverData))
		end
		radius = 50.0
		local colorSet  = GetTeamColorSet(1)
		glColor(colorSet[1])
		if (pos) then
			glDrawGroundCircle(pos[1], pos[2], pos[3], radius, 32)
			glPushMatrix()
			glTranslate(pos[1], pos[2], pos[3])

			glUnitShape(260, 1) --TODO: How to get the unitDefID? (260 = corllt)

			glPopMatrix()
		end
	--	spEcho("Draw Tower "..tostring(pos[1]).." "..tostring(pos[2]).." "..tostring(pos[3]))
	end
end