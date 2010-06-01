local menu_terraform = include("Configs/marking_menu_menu_terraform.lua")

local menu_corcsa = {
  items = {
  {
    angle = 0,
    unit = "cormex",
    label = "ECO",
    items = {
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
    unit = "corfast",
  },
  {
    angle = -90,
    unit = "corak",
    label = "UNITS",
    items = {
      {
        angle = 45,
        unit = "corpyro"
      },
      {
        angle = -45,
        unit = "corroach"
      },
      {
        angle = 0,
        unit = "cormort",
      },
      {
        angle = -180,
        unit = "blastwing"
      },
      {
        angle = 135,
        unit = "corthud"
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
        angle = 135,
        unit = "corartic"
      },
      {
        angle = -45,
        unit = "corhlt"
      },
      {
        angle = -135,
        unit = "corpb"
      },
    }
  },
  {
    angle = 90,
    unit = "corrad",
    label = "AUX",
    items = {
      {
        angle = -135,
        unit = "corjamt"
      },
      {
        angle = 0,
        unit = "cornanotc"
      },
      {
        angle = 45,
        unit = "corsonar"
      }
    }
  },
  {
    angle = -135,
    unit = "corcomdgun",
    label = "STRIDERS",
    items = {
      {
        angle = 0,
        unit = "corkarg"
      },
      {
        angle = 90,
        unit = "armraven"
      },
      {
        angle = -90,
        unit = "gorg"
      },
      {
        angle = 180,
        unit = "corkrog"
      }
    }
  },
  }
}

return menu_corcsa

