function widget:GetInfo()
  return {
    name     = "Mod Options Reminder",
    desc     = "Reminder for important mod options.",
    author   = "SirMaverick",
    date     = "2009",
    license  = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

local vsx, vsy

function widget:ViewResize(viewSizeX, viewSizeY)
  vsx = viewSizeX
  vsy = viewSizeY
end

local Chili
local Window
local screen0
local Image
local Button

local modoptions = Spring.GetModOptions()

local mainWindow

local actionShowReminder = "showmodoptionsreminder"

local optionData = {
  communism = {
    enabled = function()
      return true -- always enabled
    end,
    poster = "LuaUI/Images/reminder/communism.jpg",
    tooltip = "Communism Mode",
    sound = "LuaUI/Sounds/communism/sovnat1.wav" -- only for communism
  },
  shuffle = {
    enabled = function()
      if modoptions and modoptions.shuffle ~= "off" then
        return true
      end
      return false
    end,
    poster = "LuaUI/Images/reminder/shuffle.png",
    tooltip = "Commander Shuffle",
  },
  planetwars = {
    enabled = function()
      if modoptions and modoptions.planetwars ~= "" then
        return true
      end
      return false
    end,
    poster = "LuaUI/Images/reminder/planetwars.jpg",
    tooltip = "PlanetWars",
  }
}

-- set poster size (3/4 ratio)
local function posterSize(num)
  if num < 2 then
    return 450, 600, 60
  else
    return 300, 400, 60
  end
end

function widget:Initialize()

  if (not WG.Chili) then
    widgetHandler:RemoveWidget()
    return
  end

  -- chili setup
  Chili = WG.Chili
  Window = Chili.Window
  screen0 = Chili.Screen0
  Image = Chili.Image
  Button = Chili.Button

  vsx, vsy = widgetHandler:GetViewSizes()

  BindCallins()

  widgetHandler:AddAction(actionShowReminder, CreateWindow, nil, "t")

  -- create the window
  CreateWindow()

end

function CreateWindow()

  -- count otpions
  local actived = 0
  for name,option in pairs(optionData) do
    if option:enabled() then
      actived = actived + 1
    end
  end

  local posterx, postery, buttonspace = posterSize(actived)

  -- create window if necessarey
  if actived > 0 then

    mainWindow = Window:New{
      resizable = false,
      draggable = false,
      clientWidth  = posterx*actived,
      clientHeight = postery + buttonspace,
      x = (vsx - posterx*actived)/2,
      y = (vsy - postery - buttonspace)/2,
      parent = screen0,
      caption = "Mod Options Reminder",
    }

    -- add posters
    local i = 0
    for name,option in pairs(optionData) do
      if option:enabled() then
        local image = Image:New{
          parent = mainWindow,
          file = option.poster,
          tooltip = option.tooltip,
          width = posterx,
          height = postery,
          x = i*posterx,
          padding = {1,1,1,1}
        }
        i = i + 1
      end
    end

    local closeButton = Button:New{
      parent = mainWindow,
      caption = "close",
      width = 400,
      height = 30,
      x = (posterx*actived - 400)/2,
      y = postery + (buttonspace-30)/2,
      OnMouseUp = {Close}
    }

  end
end

function Close()
  mainWindow:Dispose()
end

function widget:Shutdown()

  if mainWindow then
    mainWindow:Dispose()
  end

  widgetHandler:RemoveAction(actionShowReminder)

end

function widget:GameStart()
  if mainWindow then
    mainWindow:Dispose()
  end
end

function UpdateCallins()
  widgetHandler:UpdateCallIn('DrawScreen')
  widgetHandler:UpdateCallIn('DrawScreen')
end

function BindCallins()
  widget.DrawScreen = _DrawScreen
  UpdateCallins()
end

function UnbindCallins()
  widget.DrawScreen = nil
  UpdateCallins()
end

-- use to play communism sound only at game start
function _DrawScreen()
  -- special for communism
  if optionData.communism:enabled() and Spring.GetGameSeconds() < 0.1 then
    Spring.PlaySoundFile("LuaUI/Sounds/communism/sovnat1.wav", 1)
  end
  UnbindCallins()
end

