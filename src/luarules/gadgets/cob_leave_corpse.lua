-- $Id: cob_leave_corpse.lua 4431 2009-04-19 02:52:03Z google frog $
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "LuaCobCorpse",
    desc      = "leaves a corpse",
    author    = "jK",
    date      = "Feb, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

if (gadgetHandler:IsSyncedCode()) then
  function LeaveCorpse(unitID,unitDefID,teamID, corpsetype)
    local unitDef   = UnitDefs[unitDefID]
    local wreckName = unitDef.wreckName
    for i=2,corpsetype do
      wreckName = FeatureDefNames[wreckName].deathFeature
    end
	if wreckName ~= "" then
      local x,y,z = Spring.GetUnitBasePosition(unitID)
      local heading = Spring.GetUnitHeading(unitID)
      local featureID = Spring.CreateFeature(wreckName,x,y,z,heading)
      Spring.SetFeatureResurrect(featureID,unitDef.name)

      Spring.SetUnitNoDraw(unitID,true)
	end
  end

  -------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------

  function gadget:Initialize()
    gadgetHandler:RegisterGlobal("corpse",LeaveCorpse)
  end

  function gadget:Shutdown()
    gadgetHandler:DeregisterGlobal("corpse")
  end

else
  return false
end