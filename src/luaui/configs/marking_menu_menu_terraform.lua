-- TODO needs update

local CMD_RAMP = 39734
local CMD_LEVEL = 39736
local CMD_RAISE = 39737
local CMD_SMOOTH = 39738
local CMD_RESTORE = 39739

local menu_terraform = {
    angle = 45,
    unit = "mexpylon",
--    cmd = CMD_LEVEL,
    label = "PYLONS",
    items = {
      {
        --angle = 90,
		--unit = "pylon",
--        unit = "terraunit",
--        cmd = CMD_RESTORE
      },
    },
}

return menu_terraform

