-- $Id: unit_replace_comm.lua 4643 2009-05-22 05:52:27Z carrepairer $
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "replacecomm",
    desc      = "Replace Commander at start of game with a different unit",
    author    = "CarRepairer",
    date      = "February 2, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true --  loaded by default?
  }
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
local GetPlayerInfo = Spring.GetPlayerInfo

local SYNCSTR = 'backup'

--------------------------------------------------------------------------------
--  COMMON
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
--------------------------------------------------------------------------------
--  SYNCED
--------------------------------------------------------------------------------

local created_backup_unit = {}
local replace_units = {}
local createdunits = 0
local modOptions = Spring.GetModOptions()
local gameFrame = -1
local blindUnits = {}
local blindData = {}

local function replaceUnit(unitID, unitDefID, unitTeam, udDstName, cloak, noblock, keep)
	replace_units[#replace_units+1] = {id=unitID, defid=unitDefID, team=unitTeam, dstname=udDstName, cloak=(cloak or false), noblock=(noblock or false), keep=(keep or false)}
end

local function shuffle_sequence(num)
	local seq, shufseq = {}, {}
	for i = 1, num do
		seq[i] = {i, math.random()}
	end
	table.sort(seq, function(a,b) return a[2] < b[2] end)
	for i = 1, num do
		shufseq[i] = seq[i][1]
	end
	return shufseq
end

local function shuffle_comms(comms)
	local shufseq = shuffle_sequence(#comms)
	local commpoints = {}
	for i,commID  in ipairs(comms) do
		local x,y,z = Spring.GetUnitPosition(commID)
		commpoints[i] = {x,y,z}
	end

	for i,commID  in ipairs(comms) do
		local x,y,z = unpack(commpoints[shufseq[i]])
		Spring.SetUnitPosition(comms[i], x,y,z )
		Spring.GiveOrderToUnit(comms[i],CMD.STOP,{},{})
	end

end

local function distribute_comms_over_boxes(comms)

  -- determine start positions from boxes
  --[[ Spring will replace a missing box by adding one covering the whole map.
       So if two or more boxes are missing, serveral commanders will be placed
       in the middle of the map]]
  local teamBoxes = {}
  for _, allyTeamID in ipairs(Spring.GetAllyTeamList()) do 
    local teams = Spring.GetTeamList(allyTeamID)
    local x1, z1, x2, z2 = Spring.GetAllyTeamStartBox(allyTeamID)
    if (x1 ~= nil) then
      -- middle of each box
      table.insert(teamBoxes, {(x1 + x2)/2, (z1 + z2)/2})
    end 
  end

  local shufflePos = shuffle_sequence(#teamBoxes)

  -- set positions
  for i=1,#comms do
    local x, z = unpack(teamBoxes[shufflePos[i]])
    Spring.SetUnitPosition(comms[i], x, z)
    Spring.GiveOrderToUnit(comms[i], CMD.STOP, {}, {});
  end

end

function gadget:GameFrame(n)

	gameFrame = n

	--// create units
	for i=1,#replace_units do
		createdunits = createdunits+1
		local replace = replace_units[i]
		local h, px, py, pz = 0, 0,100*createdunits,0
		local keep = false

		if (replace.id>=0) then
			px, py, pz = Spring.GetUnitBasePosition(replace.id)
			h = Spring.GetUnitHeading(replace.id)
			px = px + 30*(replace.keep or 0)
			keep = replace.keep
		end

		local newUnitID = Spring.CreateUnit(replace.dstname, px, py, pz, 0, replace.team)

		if (not keep and replace.id ~= -1) then
			Spring.DestroyUnit(replace.id, false, true) -- selfd = false, reclaim = true
		end

		if (replace.cloak) then
			Spring.SetUnitCloak(newUnitID, 4)
		end

		if (replace.noblock) then
			Spring.SetUnitBlocking(newUnitID, true)
		end

		if (h) then
			Spring.SetUnitRotation(newUnitID, 0, -h * math.pi / 32768, 0)
		end
	end
	replace_units = {}

	if n == 2 then
		if modOptions and modOptions.shuffle == 'box' then
			
			for _, alliance in ipairs(Spring.GetAllyTeamList()) do
				local comms = {}
				local teamList = Spring.GetTeamList(alliance)
				for _, team in ipairs(teamList) do
					local commID = Spring.GetTeamUnits(team)[1]
					comms[#comms + 1] = commID
				end
				shuffle_comms(comms)
			end
			
		elseif modOptions and modOptions.shuffle == 'all' then
			local comms = {}
			local teamList = Spring.GetTeamList()
			for _, team in ipairs(teamList) do
				local commID = Spring.GetTeamUnits(team)[1]
				comms[#comms + 1] = commID
			end
			shuffle_comms(comms)
                elseif modOptions and modOptions.shuffle == 'allboxes' then
                        local comms = {}
                        local units = Spring.GetAllUnits()
                        for i=1,#units do
                          comms[#comms+1] = units[i]
                        end
                        distribute_comms_over_boxes(comms)
		end
	end

	if n == 7 then
		for _,unit in ipairs(blindUnits) do
			if Spring.ValidUnitID(unit) then
			local l,a
			l = blindData[unit].los
			a = blindData[unit].airLos
			Spring.SetUnitSensorRadius(unit,"los",l)
	                Spring.SetUnitSensorRadius(unit,"airLos",a)
			end
		end
	end


	-- remove gadget after 10 seconds
	if n >= 310 then
		gadgetHandler:RemoveGadget()
		return
	end

end

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
	local unitName = UnitDefs[unitDefID].name

	local destName = nil
	--local _,_,_,_,faction = Spring.GetTeamInfo(unitTeam)

	-- Hide fake units in unsynced code --
	if (unitName == "backupunit") then
		SendToUnsynced(SYNCSTR, unitID, unitTeam)
	end

	if (unitName ~= "corcom") and (unitName ~= "armcom") 
		and (unitName ~= "chickenbroodqueen") and (unitName ~= 'random_comm') then
		return
	end

	if gameFrame < 5 then
		local l,a
		l = Spring.GetUnitSensorRadius(unitID, "los")
		a = Spring.GetUnitSensorRadius(unitID, "airLos")
		Spring.SetUnitSensorRadius(unitID,"los",0)
		Spring.SetUnitSensorRadius(unitID,"airLos",0)
		blindUnits[#blindUnits+1] = unitID
		blindData[unitID] = { los = l, airLos = a}
	end
	
	
	if modOptions and not tobool(modOptions.chickens) and unitName == 'chickenbroodqueen' then
		unitName = 'random_comm'
	end
	
	if unitName == 'random_comm' then
		local rand = math.random()
		destName = 'armcom'
		if modOptions and tobool(modOptions.chickens) then
			if (rand < 0.667) then
				destName = 'corcom'
			end
			if (rand < 0.333) then
				destName = 'chickenbroodqueen'
			end
		else
			if (rand < 0.5) then
				destName = 'corcom'
			end
		end
	end

	-- Replace unit now --
	if (destName) then
		replaceUnit(unitID, unitDefID, unitTeam, destName)
	end

	-- Give everyone a fake unit for stayonteam mode --
	if modOptions and tobool(modOptions.stayonteam) and (not created_backup_unit[unitTeam]) then
		created_backup_unit[unitTeam] = true
		replaceUnit(-1, -1, unitTeam, 'backupunit', true, true)
	end
end


--------------------------------------------------------------------------------
--  SYNCED
--------------------------------------------------------------------------------
else
--------------------------------------------------------------------------------
--  UNSYNCED
--------------------------------------------------------------------------------

local spSetUnitNoMinimap    = Spring.SetUnitNoMinimap
local spSetUnitNoSelect     = Spring.SetUnitNoSelect
local spSetUnitNoDraw       = Spring.SetUnitNoDraw

local myTeam = Spring.GetLocalTeamID()


local function HideFakeUnit(cmd, unitID, unitTeam)	
	if (type(unitID) ~= 'number') then
		return
	end

	spSetUnitNoDraw(unitID, true)
	spSetUnitNoMinimap(unitID, true)

	if (unitTeam ~= myTeam) then
		spSetUnitNoSelect(unitID, true)
	end
end

function gadget:Initialize()
  gadgetHandler:AddSyncAction(SYNCSTR, HideFakeUnit)
end

function gadget:Shutdown(unitID)
  gadgetHandler:RemoveSyncAction(SYNCSTR)
end


--------------------------------------------------------------------------------
--  UNSYNCED
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
--  COMMON
--------------------------------------------------------------------------------

