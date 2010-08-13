function widget:GetInfo()
	return {
	name = "Green balls display",
	desc = "Shows how many green balls you have",
	author = "Jammer",
	date = "July 2010",
	license = "GNU GPL, v2 or later",
	layer = 0,
	enabled = true
	}
end

-- Chili Stuff
local VFSMODE      = VFS.RAW_FIRST
local file = LUAUI_DIRNAME .. "Configs/gui_conf.lua"
local confdata = VFS.Include(file, nil, VFSMODE)
local color = confdata.color

function widget:Initialize()
	if (not WG.Chili) or (not WG.Darius) then
		widgetHandler:RemoveWidget(widget)
		return
	end
	
	-- Setup Darius
	Darius = WG.Darius

	-- setup Chili
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Window = Chili.Window
	ScrollPanel = Chili.ScrollPanel
	StackPanel = Chili.StackPanel
	Grid = Chili.Grid
	TextBox = Chili.TextBox
	Image = Chili.Image
	screen0 = Chili.Screen0
	
	lblBallAmount = Label:New { y=5, x=40, width=60, autosize="false", align="right", textColor = color.game_fg, caption = '0', autosize=true, fontSize=30, valign='center' }
	imgBall = Image:New { width=30, height=30, file = 'bitmaps/greenball.png' }
	imgBall:Invalidate()
	
	greenballs = Window:New {  
		x = 1,
		y = 1,
		dockable = true,
		name = "greenballs",
		width = 150,
		height = 60,
		draggable = true,
		resizable = false,
		OnMouseUp = {},
		backgroundColor = color.main_bg,
		tooltip = "Greenballs\n\nThe game's currency. You can get more by killing monsters. Spend these by playing and drawing cards.",		
		children = {
			imgBall,
			lblBallAmount,
		}
	}
	
	screen0:AddChild(greenballs)
end

function widget:Update()
	local balls = Darius:GetGreenballs()
	lblBallAmount:SetCaption(balls)
end