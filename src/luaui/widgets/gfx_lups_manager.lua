-- $Id: gfx_lups_manager.lua 4440 2009-04-19 15:36:53Z licho $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  author:  jK
--
--  Copyright (C) 2007,2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "LupsManager",
    desc      = "",
    author    = "jK",
    date      = "Feb, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 10,
    enabled   = true,
    handler   = true,
  }
end


include("Configs/lupsFXs.lua")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function MergeTable(table1,table2)
  local result = {}
  for i,v in pairs(table2) do
    if (type(v)=='table') then
      result[i] = MergeTable(v,{})
    else
      result[i] = v
    end
  end
  for i,v in pairs(table1) do
    if (result[i]==nil) then
      if (type(v)=='table') then
        if (type(result[i])~='table') then result[i] = {} end
        result[i] = MergeTable(v,result[i])
      else
        result[i] = v
      end
    end
  end
  return result
end


local function blendColor(c1,c2,mix)
  if (mix>1) then mix=1 end
  local mixInv = 1-mix
  return {
    c1[1]*mixInv + c2[1]*mix,
    c1[2]*mixInv + c2[2]*mix,
    c1[3]*mixInv + c2[3]*mix,
    (c1[4] or 1)*mixInv + (c2[4] or 1)*mix
  }
end


local function blend(a,b,mix)
  if (mix>1) then mix=1 end
  return a*(1-mix) + b*mix
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local UnitEffects = {}

local function AddFX(unitname,fx)
  local ud = UnitDefNames[unitname]
  if ud then
    UnitEffects[ud.id] = fx
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--// FUSIONS //--------------------------
AddFX("cafus", {
    {class='Bursts',options=cafusBursts},
    {class='StaticParticles',options=cafusCorona},
    --{class='ShieldSphere',options=cafusShieldSphere},
    --{class='ShieldJitter',options={layer=-16, life=math.huge, pos={0,58.9,-4.5}, size=24.5, precision=22, repeatEffect=true}},
    {class='GroundFlash',options=groundFlashOrange},
  })
AddFX("corfus", {
    {class='StaticParticles',options=corfusNova},
    {class='StaticParticles',options=corfusNova2},
    {class='StaticParticles',options=corfusNova3},
    {class='StaticParticles',options=corfusNova4},

    {class='Bursts',options=corfusBursts},
    {class='ShieldJitter',options={delay=0,life=math.huge, pos={0,40.5,0}, size=10, precision=22, repeatEffect=true}},
  })
AddFX("aafus", {
    {class='SimpleParticles2',options=MergeTable({piece="rod2", delay=30, lifeSpread=math.random()*20},sparks)},
    {class='SimpleParticles2',options=MergeTable({piece="rod4", delay=60, lifeSpread=math.random()*20},sparks)},
    {class='SimpleParticles2',options=MergeTable({piece="rod5", delay=90, lifeSpread=math.random()*20},sparks)},
    {class='SimpleParticles2',options=MergeTable({piece="rod7", delay=120, lifeSpread=math.random()*20},sparks)},

    {class='Sound',options={repeatEffect=true, file="Sparks", blockfor=4.8*30, length=5.1*30}},
  })

--// SHIELDS //---------------------------
AddFX("corjamt", {
    {class='Bursts',options=corjamtBursts},
    {class='ShieldSphere',options={life=math.huge, piece="sphere", size=11, colormap1 = {{0.8, 0.1, 0.8, 0.5}}, repeatEffect=true}},
    {class='GroundFlash',options=groundFlashViolett},
  })
AddFX("core_spectre", {
    {class='Bursts',options=MergeTable({piece="sphere"},corjamtBursts)},
    {class='ShieldSphere',options={piece="sphere", life=math.huge, size=8, colormap1 = {{0.95, 0.1, 0.95, 0.9}}, repeatEffect=true}},
  })
--AddFX("corsjam", {
--  {class='Bursts',options=coreterBursts},
--  {class='ShieldSphere',options={piece="sphere", life=math.huge, size=8, colormap1 = {{0.95, 0.1, 0.95, 0.9}}, repeatEffect=true}},
--})

--// ENERGY STORAGE //--------------------
AddFX("corestor", {
    {class='GroundFlash',options=groundFlashCorestor},
  })
AddFX("armestor", {
    {class='GroundFlash',options=groundFlashArmestor},
  })

--// PYLONS // ----------------------------------
AddFX("mexpylon", {
    {class='GroundFlash',options=groundFlashCorestor},
})


--// OTHER
AddFX("roost", {
    {class='SimpleParticles',options=roostDirt},
    {class='SimpleParticles',options=MergeTable({delay=60},roostDirt)},
    {class='SimpleParticles',options=MergeTable({delay=120},roostDirt)},
  })
AddFX("corarad", {
    {class='StaticParticles',options=radarBlink},
    {class='StaticParticles',options=MergeTable(radarBlink,{pos={-1.6,25,0},delay=15})},
    {class='StaticParticles',options=MergeTable(radarBlink,{pos={0,21,-1.0},delay=30})},
  })
AddFX("corrad", {
    {class='StaticParticles',options=MergeTable(radarBlink,{piece="head"})},
    {class='StaticParticles',options=MergeTable(radarBlink,{piece="head", delay=15})},
  })

--// GROUND UNITS //----------------------
--AddFX("armcrabe", { --// needs to be done in synced lups someday (cus of inAirLos := true)
--  {class='StaticParticles',options=ArmCrabeWhiteLight},
--})
AddFX("armmex", {
    {class='AirJet',options={color={1,0.1,0.1}, width=1, length=30, piece="emit", onActive=false, emitVector={0,1,0}}},
  })


--// SEA PLANES //----------------------------
AddFX("armsaber", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.7, length=25, piece="nozzle", onActive=true}},
  })
AddFX("armseap", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.7, length=30, piece="nozzle", onActive=true}},
  })
AddFX("armsehak", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.7, length=30, piece="nozzle", onActive=true}},
  })
AddFX("armsfig", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.3, length=30, piece="nozzle", onActive=true}},
  })
AddFX("armsb", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.7, length=70, piece="emit1", onActive=true}},
  })
AddFX("corsfig", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=32, piece="nozzle", onActive=true}},
  })
AddFX("corhunt", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=6.25, length=40, piece="nozzle", onActive=true}},
  })
AddFX("corseap", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="nozzle1", onActive=true}},
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="nozzle2", onActive=true}},
  })
AddFX("corsb", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=36, piece="emit1", onActive=true}},
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=36, piece="emit2", onActive=true}},
  })
AddFX("corcut", {
    {class='AirJet',options={color={0.6,0.1,0}, width=6, length=25, piece="rthrust1", onActive=true}},
    {class='AirJet',options={color={0.6,0.1,0}, width=6, length=25, piece="rthrust2", onActive=true}},
  })

--// PLANES //----------------------------
AddFX("armfig", {
    {class='AirJet',options={color={0.2,0.1,0.5}, width=5, length=35, piece="ljet", onActive=true}},
	{class='AirJet',options={color={0.2,0.1,0.5}, width=5, length=35, piece="rjet", onActive=true}},
    {class='Ribbon',options={width=1, size=8, piece="lwingtip"}},
    {class='Ribbon',options={width=1, size=8, piece="rwingtip"}},
  })
AddFX("armhawk", {
    {class='AirJet',options={color={0.2,0.1,0.5}, width=5, length=35, piece="ljet", onActive=true}},
	{class='AirJet',options={color={0.2,0.1,0.5}, width=5, length=35, piece="rjet", onActive=true}},
	{class='AirJet',options={color={0.2,0.1,0.5}, width=5, length=35, piece="mjet", onActive=true}},
    {class='Ribbon',options={width=1, size=8, piece="lwingtip"}},
    {class='Ribbon',options={width=1, size=8, piece="rwingtip"}},
	{class='Ribbon',options={width=1, size=8, piece="mwingtip"}},
  })
AddFX("armcybr", {
    {class='AirJet',options={color={0.5,0.1,0}, width=3.5, length=25, piece="nozzle1", onActive=true}},
	{class='AirJet',options={color={0.5,0.1,0}, width=3.5, length=25, piece="nozzle2", onActive=true}},
   })
AddFX("armhawk2", {
    {class='AirJet',options={color={0.6,0.2,0}, width=2.8, length=12, piece="enginel", onActive=true}},
    {class='AirJet',options={color={0.6,0.2,0}, width=2.8, length=12, piece="enginer", onActive=true}},
    {class='Ribbon',options={width=1, size=12, piece="wingtip1"}},
    {class='Ribbon',options={width=1, size=12, piece="wingtip2"}},
  })
AddFX("armbrawl", {
    {class='AirJet',options={color={0.0,0.5,1.0}, width=5, length=15, piece="lfjet", onActive=true}},
    {class='AirJet',options={color={0.0,0.5,1.0}, width=5, length=15, piece="rfjet", onActive=true}},
    {class='AirJet',options={color={0.0,0.5,1.0}, width=2.5, length=10, piece="lrjet", onActive=true}},
    {class='AirJet',options={color={0.0,0.5,1.0}, width=2.5, length=10, piece="rrjet", onActive=true}},
  })
AddFX("armawac", {
    {class='Ribbon',options={color={.3,.3,01,1}, width=5.5, piece="rjet"}},
    {class='Ribbon',options={color={.3,.3,01,1}, width=5.5, piece="ljet"}},
  })
AddFX("corgripn", {
    {class='AirJet',options={color={0.5,0.1,0}, width=3.5, length=35, piece="nozzle", onActive=true}},
  })

AddFX("armstiletto_laser", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=17, piece="jet1", onActive=true}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=17, piece="jet2", onActive=true}},
    {class='Ribbon',options={width=1, size=6, piece="wingtip1"}},
    {class='Ribbon',options={width=1, size=6, piece="wingtip2"}},
  })
AddFX("armcsa", {
    {class='AirJet',options={color={0.45,0.45,0.9}, width=2.8, length=12, piece="enginel", onActive=true}},
    {class='AirJet',options={color={0.45,0.45,0.9}, width=2.8, length=12, piece="enginer", onActive=true}},
    {class='Ribbon',options={width=1, size=12, piece="wingtipl"}},
    {class='Ribbon',options={width=1, size=12, piece="wingtipr"}},
  })


  AddFX("bladew", {
    {class='Ribbon',options={width=1, size=5, piece="ljet"}},
    {class='Ribbon',options={width=1, size=5, piece="rjet"}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=3, length=14, piece="ljet", onActive=true, emitVector = {0, 1, 0}}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=3, length=14, piece="rjet", onActive=true, emitVector = {0, 1, 0}}},
  })

AddFX("armkam", {
    {class='Ribbon',options={width=1, size=10, piece="lfx"}},
    {class='Ribbon',options={width=1, size=10, piece="rfx"}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=4, length=25, piece="lfx", onActive=true, emitVector = {0, 0, 1}}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=4, length=25, piece="rfx", onActive=true, emitVector = {0, 0, 1}}},
  })
AddFX("armpnix", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="exhaustl", onActive=true}},
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="exhaustr", onActive=true}},
    {class='Ribbon',options={width=1, size=10, piece="wingtipl"}},
    {class='Ribbon',options={width=1, size=10, piece="wingtipr"}},
  })
AddFX("armthund", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=15, piece="nozzle1", onActive=true}},
	{class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=15, piece="nozzle2", onActive=true}},
  })

--[UnitDefNames["armcybr", {
 --  {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=22, piece="thrust1", texture2="bitmaps/gpl/lups/jet2.bmp", onActive=true}},
--  {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=22, piece="thrust2", texture2="bitmaps/gpl/lups/jet2.bmp", onActive=true}},
--},
AddFX("armdfly", {
    {class='AirJet',options={color={0.1,0.5,0.3}, width=3.2, length=22, piece="jet1", onActive=true}},
    {class='AirJet',options={color={0.1,0.5,0.3}, width=3.2, length=22, piece="jet2", onActive=true}},
  })

AddFX("corshad", {
    {class='AirJet',options={color={0.8,0.1,0}, width=4, length=25, piece="thrustr", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet',options={color={0.8,0.1,0}, width=4, length=25, piece="thrustl", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  })
AddFX("fighter", {
    {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=55, piece="nozzle1", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=55, piece="nozzle2", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='Ribbon',options={width=1, piece="wingtip1"}},
    {class='Ribbon',options={width=1, piece="wingtip2"}},
  })
AddFX("corape", {
    {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=22, piece="rthrust1", onActive=true}},
    {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=22, piece="rthrust2", onActive=true}},
  })
AddFX("corhurc", {
    {class='AirJet',options={color={0.5,0.1,0}, width=3.5, length=25, piece="nozzle1", onActive=true}},
    {class='AirJet',options={color={0.5,0.1,0}, width=3.5, length=25, piece="nozzle2", onActive=true}},
   })
AddFX("corhurc2", {
    {class='AirJet',options={color={0.7,0.3,0.1}, width=3, length=25, piece="exhaustl1", onActive=true}},
    {class='AirJet',options={color={0.7,0.3,0.1}, width=3, length=25, piece="exhaustr1", onActive=true}},
    {class='AirJet',options={color={0.7,0.3,0.1}, width=3, length=25, piece="exhaustl2", onActive=true}},
    {class='AirJet',options={color={0.7,0.3,0.1}, width=3, length=25, piece="exhaustr2", onActive=true}},
    {class='Ribbon',options={width=1, piece="wingtipl"}},
    {class='Ribbon',options={width=1, piece="wingtipr"}},
  })
AddFX("corvamp", {
    {class='AirJet',options={color={0.6,0.1,0}, width=3.5, length=55, piece="thrustb", onActive=true}},
    {class='Ribbon',options={width=1, size=8, piece="wingtipa"}},
    {class='Ribbon',options={width=1, size=8, piece="wingtipb"}},
  })
AddFX("corawac", {
    {class='AirJet',options={color={0.1,0.4,0.6}, width=3.5, length=25, piece="thrust", onActive=true}},
  })
AddFX("blackdawn", {
    {class='AirJet',options={color={0.8,0.1,0}, width=7, length=30, jitterWidthScale=2, distortion=0.01, piece="Lengine", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
    {class='AirJet',options={color={0.8,0.1,0}, width=7, length=30, jitterWidthScale=2, distortion=0.01, piece="Rengine", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},
  })

AddFX("corcrw", {
    {class='AirJet',options={color={0.6,0.15,0}, width=4.5, length=20, distortion=0.01, piece="engine", texture2=":c:bitmaps/gpl/lups/jet2.bmp", onActive=true}},

    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=19, distortion=0.01, piece="leftengine1", onActive=true}},
    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=16, distortion=0.01, piece="leftengine2", onActive=true}},
    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=13, distortion=0.01, piece="leftengine3", onActive=true}},

    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=19, distortion=0.01, piece="rightengine1", onActive=true}},
    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=16, distortion=0.01, piece="rightengine2", onActive=true}},
    {class='AirJet',options={color={0.5,0.05,0}, width=3.5, length=13, distortion=0.01, piece="rightengine3", onActive=true}},
  })


--// ^-^
local t = os.date('*t')
if (t.month==12) then
  AddFX("armcom", {
    {class='SantaHat',options={color={0,0.7,0,1}, pos={0,4,0.35}, emitVector={0.3,1,0.2}, width=2.7, height=6, ballSize=0.7, piece="head"}},
  })
  AddFX("corcom", {
    {class='SantaHat',options={pos={0,6,2}, emitVector={0.4,1,0.2}, width=2.7, height=6, ballSize=0.7, piece="head"}},
  })
end



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--// armmex overdrive FX
---[[ THIS BLOCK WAS ORIGINALLY DISABLED
local armmexDefID = UnitDefNames["armmex"].id
local armmexes    = {}
local armmexesFxIDs = {}
local armmexFX    = armmexJet
--]]

--// cormex overdrive FX
---[[ THIS BLOCK WAS ORIGINALLY DISABLED
local cormexDefID = UnitDefNames["cormex"].id
local cormexes    = {}
local cormexFX    = cormexGlow
--]]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local abs = math.abs
local min = math.min
local max = math.max
local spGetSpectatingState = Spring.GetSpectatingState
local spGetUnitDefID       = Spring.GetUnitDefID
local spGetUnitRulesParam  = Spring.GetUnitRulesParam

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Lups  -- Lua Particle System
local LupsAddFX
local particleIDs = {}
local initialized = false --// if LUPS isn't started yet, we try it once a gameframe later
local tryloading  = 1     --// try to activate lups if it isn't found

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function ClearFxs(unitID)
  if (particleIDs[unitID]) then
    for _,fxID in ipairs(particleIDs[unitID]) do
      Lups.RemoveParticles(fxID)
    end
    particleIDs[unitID] = nil
  end
end

local function ClearFx(unitID, fxIDtoDel)
  if (particleIDs[unitID]) then
	local newTable = {}
	for _,fxID in ipairs(particleIDs[unitID]) do
		if fxID == fxIDtoDel then
			Lups.RemoveParticles(fxID)
		else
			newTable[#newTable+1] = fxID
		end
    end
	if #newTable == 0 then
		particleIDs[unitID] = nil
	else
		particleIDs[unitID] = newTable
	end
  end
end



local function AddFxs(unitID,fxID)
  if (not particleIDs[unitID]) then
    particleIDs[unitID] = {}
  end

  local unitFXs = particleIDs[unitID]
  unitFXs[#unitFXs+1] = fxID
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local function UnitFinished(_,unitID,unitDefID)
  if (unitDefID == armmexDefID) then
    armmexes[unitID] = 0
    armmexFX.unit    = unitID
    particleIDs[unitID] = {}

	local fxID = LupsAddFX("airjet",armmexFX)
	armmexesFxIDs[unitID] = fxID
	AddFxs( unitID, fxID )
  end

  if (unitDefID == cormexDefID) then
    cormexes[unitID] = 0
    cormexFX.unit    = unitID
    particleIDs[unitID] = {}
    AddFxs( unitID, LupsAddFX("StaticParticles",cormexFX) )
  end

  local effects = UnitEffects[unitDefID]
  if (effects) then
    for _,fx in ipairs(effects) do
      if (not fx.options) then
        Spring.Echo("LUPS DEBUG GRRR", UnitDefs[unitDefID].name, fx and fx.class)
        return
      end

      if (fx.class=="GroundFlash") then
        fx.options.pos = { Spring.GetUnitBasePosition(unitID) }
      end
      fx.options.unit = unitID
      AddFxs( unitID,LupsAddFX(fx.class,fx.options) )
      fx.options.unit = nil
    end
  end
end

local function UnitDestroyed(_,unitID,unitDefID)
  if (unitDefID == armmexDefID)or(unitDefID == cormexDefID)  then
    armmexes[unitID] = nil
    cormexes[unitID] = nil
  end

  ClearFxs(unitID)
end


local function UnitEnteredLos(_,unitID)
  local spec, fullSpec = spGetSpectatingState()
  if (spec and fullSpec) then return end

  if (unitDefID == armmexDefID) then
    armmexes[unitID] = 1
    armmexFX.unit    = unitID
    particleIDs[unitID] = {}
	local fxID = LupsAddFX("airjet",armmexFX)
	armmexesFxIDs[unitID] = fxID
    AddFxs( unitID, fxID )
  end

  if (unitDefID == cormexDefID) then
    cormexes[unitID] = 1
    cormexFX.unit    = unitID
    particleIDs[unitID] = {}
    AddFxs( unitID, LupsAddFX("StaticParticles",cormexFX) )
  end

  local unitDefID = spGetUnitDefID(unitID)
  local effects   = UnitEffects[unitDefID]
  if (effects) then
    for _,fx in ipairs(effects) do
      if (fx.class=="GroundFlash") then
        fx.options.pos = { Spring.GetUnitBasePosition(unitID) }
      end
      fx.options.unit = unitID
      AddFxs( unitID,LupsAddFX(fx.class,fx.options) )
      fx.options.unit = nil
    end
  end
end


local function UnitLeftLos(_,unitID)
  local spec, fullSpec = spGetSpectatingState()
  if (spec and fullSpec) then return end

  if (unitDefID == armmexDefID)or(unitDefID == cormexDefID)  then
    armmexes[unitID] = nil
    cormexes[unitID] = nil
  end

  ClearFxs(unitID)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local color1 = {0,0,0}
local color2 = {1,0.5,0}

local function GameFrame(_,n)
  if (((n+48)%60)<1 and (next(armmexes) or next(cormexes))) then
    --//Update Overdrive Fx
    for unitID,strength in pairs(armmexes) do
      local cur_strength = spGetUnitRulesParam(unitID,"overdrive") or 1
      local diff         = abs(cur_strength - strength)
      if (diff>0.3) then
        -- limit the maximum change per update (else the fx would jump like hell)
        cur_strength = strength + ((cur_strength>strength and 1) or -1)*0.3

        ClearFx(unitID, armmexesFxIDs[unitID])

        armmexFX.unit   = unitID
        armmexFX.color  = blendColor(color1,color2, (cur_strength-1)*0.5)
        armmexFX.length = blend(140,80, (cur_strength-1)*0.75)

		local fxID = LupsAddFX("airjet",armmexFX)
		armmexesFxIDs[unitID] = fxID
		AddFxs( unitID, fxID )
        armmexes[unitID] = cur_strength
      end
    end
    armmexFX.color  = color1
    armmexFX.length = 140

    for unitID,strength in pairs(cormexes) do
      local cur_strength = spGetUnitRulesParam(unitID,"overdrive") or 1
      local diff         = abs(cur_strength - strength)
      if (diff>0.1) then
        -- limit the maximum change per update (else the fx would jump like hell)
        cur_strength = (strength) + ((cur_strength>strength and 1) or -1)*0.3

	local a = min(1,max(0,(cur_strength-1)*0.35));
        ClearFxs(unitID)
        cormexFX.unit     = unitID
        cormexFX.colormap = {blendColor(cormexFX.color1,cormexFX.color2, a)}

        cormexFX.size     = blend(cormexFX.size1,cormexFX.size2, a)
        AddFxs( unitID, LupsAddFX("StaticParticles",cormexFX) )
        cormexes[unitID]  = cur_strength
      end
    end
    cormexFX.colormap = {cormexFX.color1}
    cormexFX.size   = cormexFX.size1
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Player status changed (switched team/ally or become a spectator)

local function PlayerChanged(_,playerID)
  if (playerID == Spring.GetMyPlayerID()) then
    --// clear all FXs
    for _,unitFxIDs in pairs(particleIDs) do
      for _,fxID in ipairs(unitFxIDs) do
        Lups.RemoveParticles(fxID)
      end
    end
    particleIDs = {}

    widgetHandler:UpdateWidgetCallIn("Update",widget)
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GameFrame()
  if (Spring.GetGameFrame() > 0) then
    Spring.SendLuaRulesMsg("lups running","allies")
    widgetHandler:RemoveWidgetCallIn("GameFrame",widget)
  end
end

local function CheckForExistingUnits()
  --// initialize effects for existing units
  local allUnits = Spring.GetAllUnits();
  for i=1,#allUnits do
    local unitID    = allUnits[i]
    local unitDefID = Spring.GetUnitDefID(unitID)
    UnitFinished(nil,unitID,unitDefID)
  end

  widgetHandler:RemoveWidgetCallIn("Update",widget)
end


function widget:Update()
  Lups = WG['Lups']
  local LupsWidget = widgetHandler.knownWidgets['Lups'] or {}

  --// Lups running?
  if (not initialized) then
    if (Lups and LupsWidget.active) then
      if (tryloading==-1) then
        Spring.Echo("LuaParticleSystem (Lups) activated.")
      end
      initialized=true
      return
    else
      if (tryloading==1) then
        Spring.Echo("Lups not found! Trying to activate it.")
        widgetHandler:EnableWidget("Lups")
        tryloading=-1
        return
      else
        Spring.Echo("LuaParticleSystem (Lups) couldn't be loaded!")
        widgetHandler:RemoveWidgetCallIn("Update",self)
        return
      end
    end
  end

  if (Spring.GetGameFrame()<1) then
    --// send errorlog if me (jK) is in the game
    local allPlayers = Spring.GetPlayerList()
    for i=1,#allPlayers do
      local playerName = Spring.GetPlayerInfo(allPlayers[i])
      if (playerName == "[LCC]jK") then
        local errorLog = Lups.GetErrorLog(1)
        if (errorLog~="") then
          local cmds = {
            "say ------------------------------------------------------",
            "say LUPS: jK is here! Sending error log (so he can fix your problems):",
          }
         --// the str length is limited with "say ...", so we split it
          for line in errorLog:gmatch("[^\r\n]+") do
            cmds[#cmds+1] = "say " .. line
          end
          cmds[#cmds+1] = "say ------------------------------------------------------"
          Spring.SendCommands(cmds)
        end
        break
      end
    end
  end

  LupsAddFX = Lups.AddParticles

  widget.UnitFinished   = UnitFinished
  widget.UnitDestroyed  = UnitDestroyed
  widget.UnitEnteredLos = UnitEnteredLos
  widget.UnitLeftLos    = UnitLeftLos
  widget.GameFrame      = GameFrame
  widget.PlayerChanged  = PlayerChanged
  widgetHandler:UpdateWidgetCallIn("UnitFinished",widget)
  widgetHandler:UpdateWidgetCallIn("UnitDestroyed",widget)
  widgetHandler:UpdateWidgetCallIn("UnitEnteredLos",widget)
  widgetHandler:UpdateWidgetCallIn("UnitLeftLos",widget)
  widgetHandler:UpdateWidgetCallIn("GameFrame",widget)
  widgetHandler:UpdateWidgetCallIn("PlayerChanged",widget)

  widget.Update = CheckForExistingUnits
  widgetHandler:UpdateWidgetCallIn("Update",widget)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Shutdown()
  if (initialized) then
    for _,unitFxIDs in pairs(particleIDs) do
      for _,fxID in ipairs(unitFxIDs) do
        Lups.RemoveParticles(fxID)
      end
    end
    particleIDs = {}
  end

  Spring.SendLuaRulesMsg("lups shutdown","allies")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
