local menu_terraform = include("Configs/marking_menu_menu_terraform.lua")

local menu_armcom = {
  items = {
  {
    angle = 0,
    unit = "armmex",
    label = "ECO",
    items = {
      {
        angle = 45,
        unit = "aafus"
      },
      {
        angle= 90,
        unit = "armfus",
      },
      {
        angle= 135,
        unit = "armgeo",
      },
      {
        angle = -45,
        unit = "armtide",
      },
      {
        angle= -90,
        unit = "armsolar",
      },
      {
        angle= -135,
        unit = "armwin",
      },
    }
  },
  --menu_terraform,
  {
    angle = -45,
    unit = "armap",
    label = "LABS",
    items = {
      {
        angle = 90,
        unit = "armaap"
      },
      {
        angle = 0,
        unit = "armasp"
      },
      {
        angle = -90,
        unit = "armcsa"
      },
      {
        angle = 180,
        unit = "armsy"
      },
    }
  },
  {
    angle = -90,
    unit = "armlab",
    label = "LAND LABS",
    items = {
      {
        angle = 135,
        unit = "armvp"
      },
      {
        angle = 180,
        unit = "armavp"
      },
      {
        angle = 0,
        unit = "armalab"
      },
      {
        angle = 45,
        unit = "armfhp"
      }
    }
  },
  {
    angle = 180,
    unit = "armllt",
    label = "LIGHT DEF",
    items = {
      {
        angle = 45,
        unit = "armrl"
      },
      {
        angle = 90,
        unit = "armdeva"
      },
      {
        angle = 135,
        unit = "armartic"
      },
      {
        angle = -45,
        unit = "armhlt"
      },
      {
        angle = -135,
        unit = "armpb"
      },
      {
        angle = -90,
        unit = "armarch"
      }
    }
  },
  {
    angle = 135,
    unit = "armcir",
    label = "BIG DEF",
    items = {
      {
        angle = 0,
        unit = "mercury"
      },
      {
        angle = -90,
        unit = "armanni"
      },
      {
        angle = 45,
        unit = "armtl"
      },
      {
        angle = -135,
        unit = "armatl"
      },
      {
        angle = 90,
        unit = "armdl"
      },
      {
        angle = 180,
        unit = "armmine1"
      }
    }
  },
  {
    angle = 90,
    unit = "armrad",
    label = "AUX",
    items = {
      {
        angle = -45,
        unit = "armarad"
      },
      {
        angle = -135,
        unit = "armjamt"
      },
      {
        angle = 0,
        unit = "armnanotc"
      },
      {
        angle = 180,
        unit = "armestor"
      },
      {
        angle = 135,
        unit = "armmstor"
      },
      {
        angle = 45,
        unit = "armsonar"
      }
    }
  },
  {
    angle = -135,
    unit = "armamd",
    label = "SUPER",
    items = {
      {
        angle = 0,
        unit = "armsilo"
      },
      {
        angle = 90,
        unit = "armemp"
      },
      {
        angle = 180,
        unit = "mahlazer"
      },
      {
        angle = -90,
        unit = "armbrtha"
      }
    }
  },
  }
}

return menu_armcom

