-- $Id: unit_dgun_cost.lua 3171 2008-11-06 09:06:29Z det $
if (Spring.GetModOptions().commtype ~= 'tourney') then
  return false
end

function gadget:GetInfo()
  return {
    name      = "DgunCost",
    desc      = "Increases dgun energy cost when far from base",
    author    = "Licho",
    date      = "2.2.2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false -- loaded by default?
  }
end

local MINDIST_DGUN_COST = 0 -- minimum dgun cost (at 0 distance from start pos)
local MAXDIST_DGUN_COST = 1500 -- dgun cost at max distance from start pos

local BASE_DGUN_RANGE = 0.25 -- "base" range is 25% of map size
local BASE_DGUN_COST = 4000  -- extra cost in the middle of enemy base


if (gadgetHandler:IsSyncedCode()) then 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--- Disable gadget in Chicken mode
---


local chicken
local teams = Spring.GetTeamList()
for _, teamID in ipairs(teams) do
  local teamLuaAI = Spring.GetTeamLuaAI(teamID)
  if (teamLuaAI and teamLuaAI ~= "") then
    chicken = true
  end
end


if (chicken) then
  Spring.SendMessage"D-gun cost disabled"
  return false
else
  Spring.SendMessage"D-gun cost NOT disabled"
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local GetUnitPosition = Spring.GetUnitPosition
local GetTeamResources = Spring.GetTeamResources
local UseTeamResource = Spring.UseTeamResource
local AreTeamsAllied = Spring.AreTeamsAllied
local GetTeamInfo = Spring.GetTeamInfo

local CMD_DGUN = CMD.DGUN

local startPos = {}

local mapSize
local baseRange

function GetDgunCost(unitID, teamID) 
  local x,y,z = GetUnitPosition(unitID)
  local pos = startPos[teamID]
  local xd = x - pos[1]
  local yd = z - pos[3]
  local eCost = (math.sqrt(xd*xd + yd*yd)/mapSize) * (MAXDIST_DGUN_COST - MINDIST_DGUN_COST) + MINDIST_DGUN_COST

  local minDist = math.huge
  for id, pos in pairs(startPos) do
    if (not AreTeamsAllied(id, teamID)) then
      local xd = x - pos[1]
      local zd = z - pos[3]
      local nDist = xd*xd + zd*zd
      if (nDist < minDist) then
        minDist = nDist
      end
    end
  end

  minDist = math.sqrt(minDist)
  if (minDist < baseRange) then
    eCost = eCost + (baseRange - minDist) / baseRange * BASE_DGUN_COST
  end
  return eCost
end


function gadget:GameFrame(n)
  if (n > 2) then
    local teams = Spring.GetTeamList()
    local gaiaID = Spring.GetGaiaTeamID()
    for _, teamID in ipairs(teams) do
      if (teamID ~= gaiaID) then
        startPos[teamID] = {Spring.GetTeamStartPosition(teamID)}
      end
    end
        
    local x = Game.mapSizeX
    local y = Game.mapSizeZ
    mapSize = math.sqrt(x*x + y*y)
    baseRange = mapSize * BASE_DGUN_RANGE

    gadgetHandler:RemoveCallIn("GameFrame")
  end
end



function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
  if cmdID ~= CMD_DGUN then
    return true
  end
  local lev = GetTeamResources(teamID,"energy")
  local eCost = GetDgunCost(unitID, teamID)
  if (eCost > lev) then
    SendToUnsynced("noDgun", teamID, eCost)
    return false
  else
    UseTeamResource(teamID, "e", eCost)
    return true
  end
end


else  -- UNSYNCED PART

local Echo = Spring.Echo
local GetLocalTeamID = Spring.GetLocalTeamID

function ShowNoDgunMessage(_,teamID,cost)
  if (GetLocalTeamID() == teamID) then Echo(string.format("You need %d energy to fire Dgun here", cost)) end
end

function gadget:Initialize()
  gadgetHandler:AddSyncAction('noDgun',ShowNoDgunMessage)
end

end
