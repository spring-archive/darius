local menu_terraform = include("Configs/marking_menu_menu_terraform.lua")

local menu_corcom = {
  items = {
  {
    angle = 0,
    unit = "cormex",
    label = "ECO",
    items = {
      {
        angle = 45,
        unit = "cafus"
      },
      {
        angle= 90,
        unit = "corfus",
      },
      {
        angle= 135,
        unit = "corgeo",
      },
      {
        angle = -45,
        unit = "cortide",
      },
      {
        angle= -90,
        unit = "corsolar",
      },
      {
        angle= -135,
        unit = "corwin",
      },
    }
  },
  --menu_terraform,
  {
    angle = -45,
    unit = "corap",
    label = "LABS",
    items = {
      {
        angle = 90,
        unit = "coraap"
      },
      {
        angle = 0,
        unit = "corasp"
      },
      {
        angle = -90,
        unit = "corcsa"
      },
      {
        angle = 180,
        unit = "corsy"
      },
    }
  },
  {
    angle = -90,
    unit = "corlab",
    label = "LAND LABS",
    items = {
      {
        angle = 135,
        unit = "corvp"
      },
      {
        angle = 180,
        unit = "coravp"
      },
      {
        angle = 0,
        unit = "coralab"
      },
      {
        angle = 45,
        unit = "corfhp"
      }
    }
  },
  {
    angle = 180,
    unit = "corllt",
    label = "LIGHT DEF",
    items = {
      {
        angle = 45,
        unit = "corrl"
      },
      {
        angle = 90,
        unit = "corpre"
      },
      {
        angle = 135,
        unit = "corgrav"
      },
      {
        angle = -45,
        unit = "corhlt"
      },
      {
        angle = -135,
        unit = "corvipe"
      },
      {
        angle = -90,
        unit = "corrazor"
      }
    }
  },
  {
    angle = 135,
    unit = "corflak",
    label = "BIG DEF",
    items = {
      {
        angle = 0,
        unit = "screamer"
      },
      {
        angle = -90,
        unit = "cordoom"
      },
      {
        angle = 45,
        unit = "cortl"
      },
      {
        angle = -135,
        unit = "coratl"
      },
      {
        angle = 90,
        unit = "cordl"
      },
      {
        angle = 180,
        unit = "cormine1"
      }
    }
  },
  {
    angle = 90,
    unit = "corrad",
    label = "AUX",
    items = {
      {
        angle = -45,
        unit = "corarad"
      },
      {
        angle = -135,
        unit = "corjamt"
      },
      {
        angle = 0,
        unit = "cornanotc"
      },
      {
        angle = 180,
        unit = "corestor"
      },
      {
        angle = 135,
        unit = "cormstor"
      },
      {
        angle = 45,
        unit = "corsonar"
      }
    }
  },
  {
    angle = -135,
    unit = "corfmd",
    label = "SUPER",
    items = {
      {
        angle = 0,
        unit = "corsilo"
      },
      {
        angle = 90,
        unit = "cortron"
      },
      {
        angle = 180,
        unit = "corbeac"
      },
      {
        angle = -45,
        unit = "corbhmth"
      },
      {
        angle = -90,
        unit = "corint"
      }
    }
  },
  }
}

return menu_corcom

