
-------------
-- Utility --
-------------

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end


local function disableunits(unitlist)
  for name, ud in pairs(UnitDefs) do
    if (ud.buildoptions) then
      for _, toremovename in ipairs(unitlist) do
        for index, unitname in pairs(ud.buildoptions) do
          if (unitname == toremovename) then
            table.remove(ud.buildoptions, index)
          end
        end
      end
    end
  end
end


function CopyTable(tableToCopy, deep)
  local copy = {}
  for key, value in pairs(tableToCopy) do
    if (deep and type(value) == "table") then
      copy[key] = CopyTable(value, true)
    else
      copy[key] = value
    end
  end
  return copy
end



---------------
-- Functions --
---------------

-- Convert all CustomParams to strings
for name, ud in pairs(UnitDefs) do
  if (ud.customparams) then
    for tag,v in pairs(ud.customparams) do
      if (type(v) ~= "string") then
        ud.customparams[tag] = tostring(v)
      end
    end
  end
end 


-- Set unit faction and build options
local function TagTree(unit, faction, newbuildoptions)
  
  local function Tag(unit)
    if (not UnitDefs[unit] or UnitDefs[unit].faction) then
      return
    end
	local ud = UnitDefs[unit]
    ud.faction = faction
    if (UnitDefs[unit].buildoptions) then
	  for _, buildoption in ipairs(ud.buildoptions) do
        Tag(buildoption)
      end
	  if (tonumber(ud.maxvelocity) > 0) and unit ~= "armcsa" and unit ~= "corcsa" then
	    ud.buildoptions = newbuildoptions
	  end
    end
  end
  
  Tag(unit)
end

TagTree("armcom", "arm", UnitDefs["armcom"].buildoptions)
TagTree("corcom", "core", UnitDefs["corcom"].buildoptions)


-- Calculate mincloakdistance based on unit footprint size
local sqrt = math.sqrt

for name, ud in pairs(UnitDefs) do
  if (not ud.mincloakdistance) then
    local fx = ud.footprintx and tonumber(ud.footprintx) or 1
    local fz = ud.footprintz and tonumber(ud.footprintz) or 1
    local radius = 8 * sqrt((fx * fx) + (fz * fz))
    ud.mincloakdistance = (radius + 48)
  end
end


-- Set reverse velocities (tanks)
for name, ud in pairs(UnitDefs) do
  if ((not ud.tedclass) or ud.tedclass:find("TANK", 1, true)) then
    if (ud.maxvelocity) then ud.maxreversevelocity = tonumber(ud.maxvelocity) * 0.33 end
  end
end 


-- Disable smoothmesh
for name, ud in pairs(UnitDefs) do
    if (ud.canfly) then ud.usesmoothmesh = false end
end 


-- Lasercannons going through units fix
for name, ud in pairs(UnitDefs) do
  ud.collisionVolumeTest = 1
end


-- Burrowed
for name, ud in pairs(UnitDefs) do
  if (ud.weapondefs) then
    for wName,wDef in pairs(ud.weapondefs) do      
      wDef.damage.burrowed = 0.001
    end
  end
end


-- This adds onlytagetcategory = VTOL HOVER FLOAT SINK to any unit without onlytargetcategory.
for name, ud in pairs(UnitDefs) do
  if (ud.nochasecategory) then
    ud.nochasecategory = ud.nochasecategory .. ' SATELLITE'    
  end

  if (ud.weapons) then
    for _, weapon in ipairs(ud.weapons) do
      if (not weapon.onlytargetcategory) then
    weapon.onlytargetcategory = 'VTOL HOVER FLOAT SINK'    
      end
      if (weapon.badtargetcatory) then
        weapon.badtargetcatory = weapon.badtargetcatory .. ' SATELLITE'
      else
    weapon.badtargetcatory = 'SATELLITE'
      end
    end
  end
end