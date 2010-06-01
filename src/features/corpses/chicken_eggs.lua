-- $Id$

local eggDefs = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local defaultEgg = {
  description = [[Egg]],
  blocking    = false,
  damage      = 10000,
  reclaimable = true,
  energy      = 0,
  footprintx  = 1,
  footprintz  = 1,

  customParams = {
    mod = true,
  },
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local type  = type
local pairs = pairs
local function CopyTable(outtable,intable)
  for i,v in pairs(intable) do 
    if (type(v)=='table') then
      if (type(outtable[i])~='table') then outtable[i] = {} end
      CopyTable(outtable[i],v)
    else
      outtable[i] = v
    end
  end
end
local function MergeTable(table1,table2)
  local ret = {}
  CopyTable(ret,table2)
  CopyTable(ret,table1)
  return ret
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

eggDefs.chicken_dodo_egg = MergeTable(defaultEgg, {
  metal       = 90,
  reclaimTime = 90,
  object      = [[chickeneggcrimson.s3o]],
})

eggDefs.chicken_egg = MergeTable(defaultEgg, {
  metal       = 15,
  reclaimTime = 15,
  object      = [[chickenegg.s3o]],
})

eggDefs.chicken_pigeon_egg = MergeTable(defaultEgg, {
  metal       = 15,
  reclaimTime = 15,
  object      = [[chickeneggblue.s3o]],
})

eggDefs.chicken_sporeshooter_egg = MergeTable(defaultEgg, {
  metal       = 100,
  reclaimTime = 100,
  object      = [[chickeneggyellow.s3o]],
})

eggDefs.chickena_egg = MergeTable(defaultEgg, {
  metal       = 45,
  reclaimTime = 45,
  object      = [[chickeneggred.s3o]],
})

eggDefs.chickenc_egg = MergeTable(defaultEgg, {
  metal       = 200,
  reclaimTime = 200,
  object      = [[chickeneggaqua.s3o]],
})

eggDefs.chickend_egg = MergeTable(defaultEgg, {
  metal       = 125,
  reclaimTime = 125,
  object      = [[chickeneggaqua.s3o]],
})

eggDefs.chickenf_egg = MergeTable(defaultEgg, {
  metal       = 200,
  reclaimTime = 200,
  object      = [[chickeneggyellow.s3o]],
})

eggDefs.chickenr_egg = MergeTable(defaultEgg, {
  metal       = 200,
  reclaimTime = 200,
  object      = [[chickeneggblue.s3o]],
})

eggDefs.chickens_egg = MergeTable(defaultEgg, {
  metal       = 30,
  reclaimTime = 30,
  object      = [[chickenegggreen.s3o]],
})

eggDefs.chicken_leaper_egg = MergeTable(defaultEgg, {
  metal       = 20,
  reclaimTime = 20,
  object      = [[chickeneggbrown.s3o]],
})

eggDefs.chickenspire_egg = MergeTable(defaultEgg, {
  metal       = 300,
  reclaimTime = 300,
  object      = [[chickenegggreen.s3o]],
})

eggDefs.chicken_blimpy_egg = MergeTable(defaultEgg, {
  metal       = 250,
  reclaimTime = 250,
  object      = [[chickeneggblue.s3o]],
})

eggDefs.chickenblobber_egg = MergeTable(defaultEgg, {
  metal       = 250,
  reclaimTime = 250,
  object      = [[chickeneggblue.s3o]],
})

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys( eggDefs )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------