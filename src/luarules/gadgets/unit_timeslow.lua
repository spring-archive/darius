-- $Id: unit_timeslow.lua 3171 2009-01-08 09:06:29Z midknight $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
   return {
      name      = "Time slow",
      desc      = "Time slow Weapon",
      author    = "MidKnight, with help from lurker",
      date      = "2009-01-08",
      license   = "GNU GPL, v2 or later",
      layer     = 0,
      enabled   = false  --  controlled by mod option
   }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--SYNCED
if (not gadgetHandler:IsSyncedCode()) then
   return false
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GetUnitDefID        = Spring.GetUnitDefID
local SetUnitWeaponState  = Spring.SetUnitWeaponState
local GetUnitWeaponState  = Spring.GetUnitWeaponState
local GetUnitSeparation   = Spring.GetUnitSeparation
local GetUnitCOBValue = Spring.GetUnitCOBValue
local SetUnitCOBValue = Spring.SetUnitCOBValue
--Spring.Echo("ploop!")
local MAX_SPEED = 75
--Spring.Echo(MAX_SPEED)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local attritionWeaponDefs = {}
local slowedUnits = {}


function gadget:Initialize()

   for i=1,#WeaponDefs do
   --[[   if (WeaponDefs[i].name =="corgrav_core_attrition") then
         attritionWeaponDefs[i]=true
      end
      if (WeaponDefs[i].name =="corgrav_core_attrition2") then
         attritionWeaponDefs[i]=true
      end
         if (WeaponDefs[i].name =="armllt_laser") then
         attritionWeaponDefs[i]=true 
      end]]
       if (WeaponDefs[i].name =="armkamslow_laser") then
         attritionWeaponDefs[i]=true
      end
   end
end


function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID,
                            attackerID, attackerDefID, attackerTeam)
          
   if not attritionWeaponDefs[weaponID] then return end
 if not slowedUnits[unitID] then 
	local origSpeed = GetUnitCOBValue(unitID, MAX_SPEED)
    slowedUnits[unitID] = origSpeed
   end
  --[[for i,w in ipairs(UnitDefs[unitDefID].weapons) do
                  --  Spring.Echo("i", i)
         
                 local reload = GetUnitWeaponState(unitID, i-1, 'reloadTime')
                 --  Spring.Echo("orig",reload)
                 SetUnitWeaponState(unitID, i-1, {reloadTime = reload + reload * .05})

                
                 if reload ~= 0 then
                     Spring.Echo("reloadtime",reload)
                 end
                
            end]]
	
                -- end



   local dist = GetUnitSeparation(unitID, attackerID)
 
   local Cspeed = GetUnitCOBValue(unitID, MAX_SPEED) * 0.985
   SetUnitCOBValue(unitID, MAX_SPEED, Cspeed)


--Spring.Echo("speed",Cspeed)
end


function gadget:GameFrame(f)
    if (f + 3) % 10 < .1 then
        for unitID, origSpeed in pairs(slowedUnits) do
        

      
            local udid =  GetUnitDefID(unitID)
            --[[  for i,w in ipairs(UnitDefs[udid].weapons) do
               local reload = GetUnitWeaponState(unitID, i-1, 'reloadTime')
                SetUnitWeaponState(unitID, i-1, {reloadTime = reload * .99})        
                if reload < WeaponDefs[w.weaponDef].reload then
                    reload = WeaponDefs[w.weaponDef].reload
                    slowedUnits[unitID] = nil  
                end
             end]]
             local speed = GetUnitCOBValue(unitID, MAX_SPEED) + origSpeed * .02
            --Spring.Echo("upspeed",speed)
             if speed > origSpeed then
                 speed = origSpeed
                slowedUnits[unitID] = nil
             end
             -- if not slowedUnits[unitID] then 
             SetUnitCOBValue(unitID, MAX_SPEED, speed)
        end
    end
end


function gadget:UnitDestroyed(unitID)
   slowedUnits[unitID] = nil
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
