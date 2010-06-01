-- $Id: unit_start_boost.lua 4481 2009-04-25 18:38:05Z carrepairer $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "StartBoostPlop",
    desc      = "Implements initial boost and plop for construction",
    author    = "Licho, CarRepairer and Google Frog",
    date      = "2008,2009,2010",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end


local BOOST_RATE = 2.0
local START_STORAGE=500
local EXCLUDED_UNITS = {
  [ UnitDefNames['terraunit'].id ] = true,
}

local startMode = Spring.GetModOption("startingresourcetype",false,"facplopboost")

if (startMode == "limitboost") then
	for udid, ud in pairs(UnitDefs) do
		if ud.canAttack and not ud.isFactory then
			EXCLUDED_UNITS[udid] = true
		end
	end
end

local plop = false
if startMode == "facplop" or startMode == "facplopboost" then
  plop = true
end

local ploppables = {

  "armlab",
  "armalab",
  "armvp",
  "armavp",
  "armap",
  "armaap",
  "armfhp",
  "armsy",

  "corlab",
  "coralab",
  "corvp",
  "coravp",
  "corap",
  "coraap",
  "corfhp",
  "corsy",

}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (gadgetHandler:IsSyncedCode()) then
  
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local boost = {}
local boostMax = {}
local teamMetal = {}

local facplops = {}
local ploppableDefs = {}
local facplopsrunning = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function AddBoost(unitID, newBoost, newBoostMax)
	local tm = math.min(2000,teamMetal[Spring.GetUnitTeam(unitID)])
	boost[unitID]  = newBoost or tm or 1000
	boostMax[unitID] = newBoostMax or tm or 1000
	SendToUnsynced("UpdateBoost", unitID, boost[unitID], boostMax[unitID])   
end


function gadget:UnitCreated(unitID, unitDefID, teamID)
        if plop and ploppableDefs[unitDefID] and facplops[teamID] then
                facplops[teamID] = nil
		-- 3 seconds to build with commander
		Spring.SetUnitCosts(unitID, {
			buildTime = 36,
			metalCost = 1,
			energyCost = 1
		})
		-- remember to plop, can't do it here else other gadgets etc. see UnitFinished before UnitCreated
		facplopsrunning[unitID] = true
        end
end


function gadget:UnitDestroyed(unitID) 

	if plop and facplopsrunning[unitID] then
		facplopsrunning[unitID] = nil
	end

	if (boost[unitID] == nil) then return end
	disableBoost(unitID)
end


function gadget:UnitFinished(unitID, unitDefID)
	if plop and facplopsrunning[unitID] then
		facplopsrunning[unitID] = nil
		-- reset to original costs
		Spring.SetUnitCosts(unitID, {
			buildTime = UnitDefs[unitDefID].buildTime,
			metalCost = UnitDefs[unitDefID].metalCost,
			energyCost = UnitDefs[unitDefID].energyCost
		})
	end
end


function disableBoost(unitID) 
	boost[unitID] = nil
	local cnt = 0
	for _,_ in pairs(boost) do
		cnt = cnt+1
	end
	for _,_ in pairs(facplops) do
		cnt = cnt+1
	end
	if (cnt == 0) and Spring.GetGameSeconds() > 5 then
		gadgetHandler.RemoveGadget(self)
	end
end


function gadget:AllowUnitBuildStep(builderID, teamID, unitID, unitDefID, step) 
	if plop and facplopsrunning[unitID] then
		return true -- dont waste boost on facplops
	elseif (boost[builderID]) and (not EXCLUDED_UNITS[unitDefID]) and (step>0) then
		local cost = UnitDefs[unitDefID].metalCost
		local oldHealth, maxHealth, _, _, oldProgress = Spring.GetUnitHealth(unitID)
		if (boost[builderID] > BOOST_RATE) then 
			local progress  = oldProgress + BOOST_RATE / cost
			if (progress > 1) then progress = 1 end
			local newHealth = oldHealth + (BOOST_RATE / cost)*maxHealth
			if (newHealth > maxHealth) then newHealth = maxHealth end
			boost[builderID] = boost[builderID] - BOOST_RATE
			Spring.SetUnitHealth(unitID, { health = newHealth,  build  = progress })
			SendToUnsynced("UpdateBoost", builderID, boost[builderID], boostMax[builderID])   
			return false
		else 
			disableBoost(builderID)
		end
	end
	return true
end


function gadget:GameFrame(n)
  -- frame 33 because engine gives resources after 1 second?
  if (n == 33) then
	local teamIDs = Spring.GetTeamList()
	for i=1,#teamIDs do
		local teamID = teamIDs[i]
		local gaiaID = Spring.GetGaiaTeamID()
		local teamLuaAI = Spring.GetTeamLuaAI(teamID)

		Spring.SetTeamResource(teamID, 'ms', START_STORAGE)
		Spring.SetTeamResource(teamID, 'es', START_STORAGE + 10000)

		if	teamID ~= gaiaID 
			and (not teamLuaAI or teamLuaAI == "")
			and (
				startMode == "boost" 
				or startMode == "limitboost" 
				or startMode == "facplopboost"
			)
		then
			local metal = Spring.GetTeamResources(teamID, 'metal')
			teamMetal[teamID] = metal

			Spring.SetTeamResource(teamID, 'energy', 0)
			Spring.SetTeamResource(teamID, 'metal', 0)

			for _, unitID in ipairs(Spring.GetTeamUnits(teamID)) do
				local udef = UnitDefs[Spring.GetUnitDefID(unitID)]
				if (udef.isCommander and udef.name ~= "chickenbroodqueen") then
					if (startMode == "facplopboost") then
						AddBoost(unitID, 500, 500)
					elseif (startMode == "boost") then
						AddBoost(unitID, START_STORAGE, START_STORAGE)
					else
						AddBoost(unitID)
					end
					break
				end
			end
		end
	end
  end
end


function gadget:Initialize() 

  -- self linking
  GG['boostHandler'] = {}
  GG['boostHandler'].AddBoost = AddBoost

  if plop then
	for i, v in pairs(ploppables) do
                local name = UnitDefNames[v]
                if name then
                        local ud = name.id
                        if ud then
                                ploppableDefs[ud] = true
                        end
                end
        end

        local teams = Spring.GetTeamList()
        for _,teamID in ipairs(teams) do
                facplops[teamID] = 1
        end
  end
end



--------------------------------------------------------------------
-- unsynced code
--------------------------------------------------------------------
else

local teamID = Spring.GetLocalTeamID()
local boost = {}
local boostMax = {}

function gadget:Initialize()
  gadgetHandler:AddSyncAction("UpdateBoost",UpdateBoost)
end
  
  
function UpdateBoost(_, uid, value, valueMax) 
	boost[uid] = value
	boostMax[uid] = valueMax
end
  
  
local function circleLines(percentage, radius)
	gl.BeginEnd(GL.LINE_STRIP, function()
		local radstep = (2.0 * math.pi) / 50
		for i = 0, 50 * percentage do
			local a = (i * radstep)
			gl.Vertex(math.sin(a)*radius, 0, math.cos(a)*radius)
		end
	end)
end  

function gadget:DrawWorldPreUnit()
	teamID = Spring.GetLocalTeamID()
	local spec, fullview = Spring.GetSpectatingState()
	spec = spec or fullview
	for unitID, value in pairs(boost) do
		local ut = Spring.GetUnitTeam(unitID)
		if (ut ~= nil and (spec or Spring.AreTeamsAllied(teamID, ut))) then
			if (value > 0 and boostMax[unitID] ~= nil) then 
				gl.LineWidth(6.5)
				gl.Color({255,0,0})
				local radius = 30
				while value > 1000 do 
					gl.DrawFuncAtUnit(unitID, false, circleLines, 1, radius)
					radius = radius + 8
					value = value - 1000
				end
				gl.DrawFuncAtUnit(unitID, false, circleLines, value / 1000, radius)
			end
		end
	end
end

end
