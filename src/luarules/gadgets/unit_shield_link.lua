function gadget:GetInfo()
  return {
    name      = "Shield Link",
    desc      = "Nearby shields on the same ally team share charge to and from each other. Working Version",
    author    = "lurker",
    date      = "2009",
    license   = "Public domain",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

-- CHANGELOG
--  2009-5-24: CarRepairer: Added graphic lines to show links of shields (also shows links of enemies' visible shields, can remove if desired).
--  2009-5-30: CarRepairer: Lups graphic lines, fix for 0.79.1 compatibility.
--  2009-9-15: Licho: added simple fast graph lines

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetUnitPosition		= Spring.GetUnitPosition
local spGetUnitDefID		= Spring.GetUnitDefID
local spGetUnitTeam		= Spring.GetUnitTeam
local spGetUnitIsStunned	= Spring.GetUnitIsStunned
local spGetUnitIsActive		= Spring.GetUnitIsActive
						
if gadgetHandler:IsSyncedCode() then

local shieldTeams = {}
shieldConnections = {}

function gadget:Initialize()
   for _,unitID in ipairs(Spring.GetAllUnits()) do
      local teamID = spGetUnitTeam(unitID)
      local unitDefID = spGetUnitDefID(unitID)
      gadget:UnitCreated(unitID, unitDefID, teamID)
   end
end

function gadget:UnitCreated(unitID, unitDefID)

   -- only count finished buildings
   local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID)
   if stunned_or_inbuild ~= nil and inbuild then
     return
   end

   local ud = UnitDefs[unitDefID]
   if ud.shieldWeaponDef then
      local shieldWep = WeaponDefs[ud.shieldWeaponDef]
      local x,y,z = spGetUnitPosition(unitID)
      local allyTeam = Spring.GetUnitAllyTeam(unitID)
      shieldTeams[allyTeam] = shieldTeams[allyTeam] or {}
      shieldUnit = {
         shieldPower = shieldWep.shieldPower,
         shieldRadius = shieldWep.shieldRadius,
         shieldOn = true,
         link = {},
      }
      shieldTeams[allyTeam][unitID] = shieldUnit
   end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
  gadget:UnitCreated(unitID, unitDefID)
end

function gadget:UnitDestroyed(unitID, unitDefID)
   local ud = UnitDefs[unitDefID]
   local allyTeam = Spring.GetUnitAllyTeam(unitID)
   if ud.shieldWeaponDef and shieldTeams[allyTeam] then
      local shieldUnit = shieldTeams[allyTeam][unitID]
      shieldTeams[allyTeam][unitID] = nil
      if shieldUnit then
        shieldUnit.link[unitID] = nil
      end
   end
end

function gadget:UnitGiven(unitID, unitDefID, unitTeam, oldTeam)
   local ud = UnitDefs[unitDefID]
   local _,_,_,_,_,oldAllyTeam = Spring.GetTeamInfo(oldTeam)
   if ud.shieldWeaponDef then
      if shieldTeams[oldAllyTeam] and shieldTeams[oldAllyTeam][unitID] then
        local shieldUnit = shieldTeams[oldAllyTeam][unitID]
        shieldTeams[oldAllyTeam][unitID] = nil
        shieldUnit.link[unitID] = nil
        shieldUnit.link = {}
      end
      
      local allyTeam = Spring.GetUnitAllyTeam(unitID)
      shieldTeams[allyTeam] = shieldTeams[allyTeam] or {}
      shieldTeams[allyTeam][unitID] = shieldUnit
   end
end

-- check if working unit so it can be used for shield link
local function linkable(unitID)
  local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID)
  if stunned_or_inbuild then
    return false
  end
  local active = spGetUnitIsActive(unitID)
  if active ~= nil then
    return active
  else
    return true
  end
end

local function AdjustLinks()
  shieldConnections = {}
  _G.shieldConnections = shieldConnections

   for allyTeam,shieldUnits in pairs(shieldTeams) do
      for unitID,su in pairs(shieldUnits) do
         local x,y,z = spGetUnitPosition(unitID)
         su.link = {[unitID] = su}
         su.x = x
         su.y = y
         su.z = z
      end
      
      local sc = {}
      local cnt = 1
      shieldConnections[allyTeam] = sc 

      -- cache
      local unitStat = {}

      for ud1,su in pairs(shieldUnits) do

         repeat
         if unitStat[ud1] == nil then
           unitStat[ud1] = linkable(ud1)
         end
         if not unitStat[ud1] then break end -- continue

         for ud2,su2 in pairs(shieldUnits) do

            if unitStat[ud2] == nil then
              unitStat[ud2] = linkable(ud2)
            end

            if su.link ~= su2.link and unitStat[ud2] then
               if ((su.x - su2.x)^2 + (su.y - su2.y)^2 + (su.z - su2.z)^2) ^ 0.5
                     < (su.shieldRadius + su2.shieldRadius) then
                  
                  sc[cnt] = {ud1,ud2}
                  cnt = cnt + 1
      
                  for unitID,linksu in pairs(su2.link) do
                     su.link[unitID] = linksu
                     linksu.link = su.link
                  end
               end
            end
         end -- for ud2
         until true
      end  -- for ud1
   end
end

function gadget:GameFrame(n)
   if n%30 == 18 then AdjustLinks() end 

   -- cache
   local unitStat = {}

   for allyTeam,shieldUnits in pairs(shieldTeams) do
      local processedLinks = {} --DO NOT USE PAIRS ON THIS
      for unitID,su in pairs(shieldUnits) do
         repeat
         if not processedLinks[su.link] then
            processedLinks[su.link] = true

            -- only update working shields
            if unitStat[unitID] == nil then
              unitStat[unitID] = linkable(unitID)
            end
            if not unitStat[unitID] then break end -- continue

            local currentPower = 0
            local maxPower = 0
            local linkUnits = 0
            for unitID2,su2 in pairs(su.link) do
               local shieldOn,shieldCharge = Spring.GetUnitShieldState(unitID2, -1)
               su.shieldOn = shieldOn
               currentPower = currentPower + shieldCharge
               maxPower = maxPower + su2.shieldPower
               linkUnits = linkUnits + 1
            end
            for unitID3,su2 in pairs(su.link) do
              Spring.SetUnitShieldState(unitID3, -1, currentPower * su2.shieldPower / maxPower)
            end
         end
         until true
      end
   end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--UNSYNCED
else
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local glVertex = gl.Vertex
local isUnitInView = Spring.IsUnitInView
local areTeamsAllied = Spring.AreTeamsAllied
local getUnitTeam = Spring.GetUnitTeam
local getUnitLosState = Spring.GetUnitLosState
local spValidUnitID = Spring.ValidUnitID

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


function gadget:Initialize()
end


local function DrawFunc()
  myAllyID = Spring.GetMyAllyTeamID()
  local spec, fullview = Spring.GetSpectatingState()
  spec = spec or fullview
  
  for allyID, connections in spairs(SYNCED.shieldConnections) do 
  
  for _,con in sipairs(connections) do 
    local u1 = con[1]
    local u2 = con[2]
    
    local l1
    local l2 
    
    if (spec or allyID == myAllyID) then 
      l1 = isUnitInView(u1)
      l2 = isUnitInView(u2)
    end 
    
    if ((l1 or l2) and (spValidUnitID(u1) and spValidUnitID(u2))) then 
      glVertex(spGetUnitPosition(u1))
      glVertex(spGetUnitPosition(u2))
    end 
  end
  end 
end 

	
function gadget:DrawWorld()
  if SYNCED.shieldConnections and snext(SYNCED.shieldConnections) then 
    gl.PushAttrib(GL.LINE_BITS)
	
    gl.DepthTest(true)
    gl.Color(1,0,1,math.random()*0.3+0.2)
    gl.LineWidth(1)
    gl.BeginEnd(GL.LINES, DrawFunc)
	
    gl.DepthTest(false)
    gl.Color(1,1,1,1)
	
    gl.PopAttrib()
  end 
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

