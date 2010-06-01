-- $Id$
function gadget:GetInfo()
  return {
    name      = "Spawn on death",
    desc      = "Spawns a unit on death",
    author    = "Quantum",
    date      = "Feb. 2009",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false,  --  loaded by default?
  }
end

if (not gadgetHandler:IsSyncedCode()) then
  return false -- no unsynced code
end
local oldUnitName = "blastwingmine" -- no longer used? was morph supposed to replace this?
local testUnitName = "logheavymine"
local testUnitDefID = UnitDefNames[testUnitName].id

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  if UnitDefNames[oldUnitName].id == unitDefID then
    local x, y, z = Spring.GetUnitPosition(unitID)
    Spring.CreateUnit(testUnitName, x, y, z, 0, unitTeam)
  end
end
