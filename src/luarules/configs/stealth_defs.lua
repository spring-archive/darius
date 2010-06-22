-- $Id: stealth_defs.lua 3496 2008-12-21 20:33:13Z licho $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local stealthDefs = {

  armcom = {
    draw   = true,
    init   = false,
    energy = 20,
    delay  = 30,
  },

  corcom = {
    draw   = true,
    init   = false,
    energy = 20,
    delay  = 30,
  },
 
--[[ 
  armcomdgun = {
    draw   = true,
    init   = false,
    energy = 20,
    delay  = 30,
  },
--]]

  corcomdgun = {
    draw   = true,
    init   = false,
    energy = 20,
    delay  = 30,
  },  
}


if (Spring.IsDevLuaEnabled()) then
  for k,v in pairs(UnitDefNames) do
    stealthDefs[k] = {
      init   = false,
      energy = v.metalCost * 0.05,
      draw   = true
    }
  end
end


return stealthDefs


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
