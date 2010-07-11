function gadget:GetInfo()
	return {
		name      = "Commander modifier",
		desc      = "Modifies the commanders to suit mr. Darius",
		author    = "Ziggurat",
		date      = "July 3, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true
	}
end


----------------------
-- Synced Functions --
----------------------
if (gadgetHandler:IsSyncedCode()) then

--Speed ups
spEcho = Spring.Echo
spGetTeamUnits = Spring.GetTeamUnits
spGetUnitDefID = Spring.GetUnitDefID

playerTeam = 1
monsterTeam = 0
commanderHealth = 2000

local function GetCommanders(teamID) --Finds the commander IDs for the given team

	local units = spGetTeamUnits(teamID)
	local commanders = {}

	for _,unitID in ipairs(units) do
		if (UnitDefs[spGetUnitDefID(unitID)].isCommander) then
			--checks if the isCommander attribute is true in current unit's unitDef -file
			commanders[#commanders + 1] = unitID
		end
	end

	return commanders

end


local function DisableUnit(unitID)
	Spring.MoveCtrl.Enable(unitID)
	Spring.MoveCtrl.SetNoBlocking(unitID, true)
	Spring.MoveCtrl.SetPosition(unitID, Game.mapSizeX+4000, 0, Game.mapSizeZ+4000)
	Spring.SetUnitCloak(unitID, true)
	Spring.SetUnitHealth(unitID, {paralyze=99999999})
	Spring.SetUnitNoDraw(unitID, true)
	Spring.SetUnitStealth(unitID, true)
	Spring.SetUnitNoSelect(unitID, true)
	Spring.SetUnitNoMinimap(unitID, true)
end



function gadget:GameFrame(f)


	if f < 100 then
		DisableUnit(GetCommanders(monsterTeam)[1])-- We assume that there is only one commander
	end

	if f == 7 then
		--Sets the health amount for the players commander
		Spring.SetUnitMaxHealth(GetCommanders(playerTeam)[1], commanderHealth)
		Spring.SetUnitHealth(GetCommanders(playerTeam)[1], {health = commanderHealth})
	end

	if(f > 100) then
		gadgetHandler:RemoveGadget()-- Disable this gadget after it has done it's job
		return
	end

end



end



