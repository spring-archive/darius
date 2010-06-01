-- $Id: unit_enemy_commands.lua 3171 2008-11-06 09:06:29Z det $
function gadget:GetInfo()
  return {
    name      = "Enemy Command Blocker",
    desc      = "Blocks certain commands given on enemy units, like repair.",
    author    = "lurker",
    date      = "March 31, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 1,
    enabled   = false  --  loaded by default?
  }
end

if (gadgetHandler:IsSyncedCode()) then

local AreTeamsAllied = Spring.AreTeamsAllied
local GetUnitTeam = Spring.GetUnitTeam
local CMD_REPAIR = CMD.REPAIR
local CMD_RECLAIM = CMD.RECLAIM

function gadget:AllowCommand(unitID, unitDefID, teamID,
                             cmdID, cmdParams, cmdOptions)
  if (cmdID == CMD_REPAIR) then
    if (cmdParams[2] == nil) then  --make sure it's a unit, not a coordinate
	  if not AreTeamsAllied(teamID, GetUnitTeam(cmdParams[1])) then return false end
	end
--[[  elseif (cmdID == CMD_RECLAIM) then
    Spring.Echo(cmdParams[1])
    if ((cmdParams[2] == nil) and (cmdParams[1] < 10000)) then
	--make sure it's a unit, not a feature or coordinate; couldn't find a way to get MAX_UNITS
	  if (teamID ~= GetUnitTeam(cmdParams[1])) then return false end
	end]]
  end
  return true
end

end

