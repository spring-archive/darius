-- $Id$


function gadget:GetInfo()
  return {
    name      = "Factory Anti Slacker",
    desc      = "Teleports units out from factory build area.",
    author    = "Licho",
    date      = "10.4.2009",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true --  loaded by default?
  }
end

local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitVectors = Spring.GetUnitVectors
local spGetUnitRadius = Spring.GetUnitRadius
local spSetUnitPosition = Spring.SetUnitPosition

local corapID = UnitDefNames["corap"].id
local armapID = UnitDefNames["armap"].id

if (gadgetHandler:IsSyncedCode()) then

function gadget:UnitFromFactory(unitID, unitDefID, teamID, builderID, builderDefID, _)
	if not (builderDefID == corapID or builderDefID == armapID) then
		local ux,uy,uz = spGetUnitPosition(unitID)
		local f = spGetUnitVectors(builderID)
		local s = spGetUnitRadius(unitID) + 16
		spSetUnitPosition(unitID, ux + f[1]*s, uy + f[2]*s, uz + f[3]*s)
	end
end


end
