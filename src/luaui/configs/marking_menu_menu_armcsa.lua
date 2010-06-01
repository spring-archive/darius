local menu_terraform = include("Configs/marking_menu_menu_terraform.lua")

local menu_armcsa = {
  items = {
  {
    angle = 0,
    unit = "armmex",
    label = "ECO",
    items = {
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
    unit = "arm_spider",
  },
  {
    angle = -90,
    unit = "armpw",
    label = "UNITS",
    items = {
      {
        angle = 45,
        unit = "armfast"
      },
      {
        angle = 0,
        unit = "armsptk"
      },
      {
        angle = -45,
        unit = "armzeus"
      },
      {
        angle = -135,
        unit = "armsnipe"
      },
      {
        angle = -180,
        unit = "armtick"
      },
      {
        angle = 135,
        unit = "armspy"
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
    }
  },
  {
    angle = 90,
    unit = "armrad",
    label = "AUX",
    items = {
      {
        angle = -135,
        unit = "armjamt"
      },
      {
        angle = 0,
        unit = "armnanotc"
      },
      {
        angle = 45,
        unit = "armsonar"
      }
    }
  },
  {
    angle = -135,
    unit = "armcomdgun",
    label = "STRIDERS",
    items = {
      {
        angle = 0,
        unit = "armraz"
      },
      {
        angle = 90,
        unit = "armshock"
      },
      {
        angle = -90,
        unit = "armbanth"
      },
      {
        angle = 180,
        unit = "armorco"
      }
    }
  },
  }
}

return menu_armcsa

