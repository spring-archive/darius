-- $Id: unit_active_radar.lua 3950 2009-02-11 13:15:49Z google frog $
--[[
if (not Spring.GetModOption("activeradars",true)) then
  return false
end
--]]
function gadget:GetInfo()
  return {
    name      = "Active Radars.",
    desc      = "Makes some radars always visible.",
    author    = "quantum",
    date      = "Nov 05, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false  --  loaded by default?
  }
end


if (not gadgetHandler:IsSyncedCode()) then
  return false  --  silent removal
end


local radarNameList = {
  "armrad",
  "corrad",
  "armarad",
  "corarad",
  "arm_marky",
  "armawac",
  "armseer",
  "armsehak",
  "corawac",
  "core_informer",
  "corvoyr",
  "corhunt",
}


local radarIDSet = {}
for _, unitName in ipairs(radarNameList) do
  if (UnitDefNames[unitName]) then
    unitDefID = UnitDefNames[unitName].id
    radarIDSet[unitDefID] = true
  end
end


function gadget:UnitCreated(unitID, unitDefID)
  if (radarIDSet[unitDefID]) then
    Spring.SetUnitAlwaysVisible(unitID, true)
  end
end
