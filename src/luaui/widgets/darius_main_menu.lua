function widget:GetInfo()
	return {
		name = "Darius Main Menu",
		desc = "Displays a menu for the game",
		author = "kap89/xcompwiz",
		date = "July 27th, 2010",
		layer = 100,
		enabled = true,
		handler = true,
	}
end

VFS.Include("luaui/widgets/maplist.txt",nil)

--------------
-- Speed Up --
--------------
local spEcho    = Spring.Echo
local spRestart = Spring.Restart
local spSendCmds = Spring.SendCommands

---------------------
-- Table functions --
---------------------

function table.tostring(t)
	str = "{"
	i = 0
	for k,v in pairs(t) do
		if (type(v) == "table") then --Next level needed for effects
			str = str .. k.. " = '" .. table.tostring(v) .. "', "
		elseif (type(v) ~= "function") then
			str = str .. k.. " = '" .. v .. "', "
		end
	end
	str = str .. "}"
	return str
end

----------------
-- Local Vars --
----------------
local startscriptfilename = "loader_script.lua"
local maplist = ""
local selectedMap = {ClearName=""} 
local IsActive = false
local HideView = false
local vsx,vsy = 0,0
local FramesList = {}
local ActiveFrameIndex = nil
local MouseOveredFrameIndex = nil
local KeyboardFrameIndex = nil
local gameOver = false
--local ScrollUp=nil  --used for mousescrolling
--local ScrollDown=nil


---------------------
-- Local Functions --
---------------------

local function StartNewGame(mapfile)
	if ((spRestart) and VFS.FileExists(startscriptfilename)) then --If Spring.Restart exists
		scriptContent = VFS.Include(startscriptfilename)
		if (scriptContent) then
			spEcho(table.tostring(scriptContent))
			if (mapfile) then
				scriptContent.MapName = mapfile
			end
			enableWidgets() --while in menu the darius widgets are disabled
			spEcho(widget:GetInfo().name..": Starting game on "..scriptContent.MapName)
			scriptContent = scriptContent:toString()
			spEcho(widget:GetInfo().name..": Calling Spring.Restart(\"-s\",\"[GAME]{..}\") now!")
			widgetHandler:SaveConfigData()
			spRestart("-s", scriptContent)
			spEcho(widget:GetInfo().name..": Just called Spring.Restart(\"-s\",\"[GAME]{..}\")")
			spEcho(widget:GetInfo().name..": Wait... we shouldn't be here... we should have restarted or crashed or something by now.")
		else
			spEcho("Could not execute the necessary script file.")
		end
	else
		spEcho("Could not call Spring.Restart!  Please check your game version.")
	end
end


--All items in the main menu are frames. Some menu  frames can have a function tied to them that is called when the frame is clicked  and the Param1 - 3 are the possible parameters for the function
local function AddFrame(Text,Pos,FontSize,Color,FramePosition,TextPosition,Function,Param1,Param2,Param3)
	table.insert(FramesList,{Text=Text,Pos=Pos,FontSize=FontSize,Color=Color,FramePosition=FramePosition,TextPosition=TextPosition,Function=Function,Param1=Param1,Param2=Param2,Param3=Param3})
end


local function RemoveAllFrames()
	FramesList = {}
	ActiveFrameIndex = nil
	MouseOveredFrameIndex = nil
	KeyboardFrameIndex = nil
	--ScrollUp=nil
	--ScrollDown=nil
end

--is the mouse above a  menu frame
local function isAboveFrame(x,y,Frame)
	if type(x)~="number" or type(y)~="number" then
		x,y = Spring.GetMouseState()
	end
	if x>=Frame.Pos.xPosMin and x<=Frame.Pos.xPosMax and y>=Frame.Pos.yPosMin and y<=Frame.Pos.yPosMax then
		return true
	else
		return false
	end
end


local function Quit()
	spSendCmds("quit")
	spSendCmds("quitforce")
end


local function SelectMap(map, ReturnTo)
	selectedMap = map
	ReturnTo()
end	


--list all the possible maps as selectable frames. The function gets the map list from widgets\maplist.txt
local function ListMap(ReturnTo) --ReturnTo returns to the last frame 
	RemoveAllFrames()
	AddFrame("Choose a map:",{x=vsx*0.5,y=vsy*0.95},vsy/24,{0,0,1,0.5},"cc","c",nil)
	for m,_ in ipairs(MapsList) do
		--this should look if the map exists, but the VFS command is probably looking at the wrong place now
		--[[
		local missing=true
		if VFS.FileExists(MapsList[m].ExternalFileName) then
			missing = false
		end
		--]]					
		AddFrame(MapsList[m].ClearName, {x=vsx*0.5,y=vsy*(0.92-0.06*m)}, vsy/36,{0,1,0,0.5},"cc","c", SelectMap, MapsList[m], ReturnTo)
	end
	AddFrame("Back",{x=vsx*0.5,y=vsy*0.1},vsy/24,{0,0,1,0.5},"cc","c",ReturnTo)
end

local function DeckEditor(ReturnTo)
	RemoveAllFrames()
	widgetHandler:EnableWidget("The deck editor")
	AddFrame("Back",{x=vsx*0.5,y=vsy*0.1},vsy/24,{0,0,1,0.5},"cc","c",ReturnTo)
end

local function ResetUI()
	WG.Darius:SendUIMessage("reset")
	SwitchOff()
end

local function MainMenu()
	RemoveAllFrames()
	disableWidgets() --disabled so that the player can't accidently draw cards or move the windows while in menu 	
	AddFrame("Back",{x=vsx*0.1,y=vsy*0.9},vsy/24,{0,1,0,0.5},"cc","c", SwitchOff)
	AddFrame("Darius Tower Defence",{x=vsx*0.5,y=vsy*0.98},vsy/14,{0,1,1,0.5},"ct","c")
	AddFrame("ResetUI",{x=vsx*0.9,y=vsy*0.9},vsy/24,{0,1,0,0.5},"cc","c", ResetUI)
	AddFrame("Deck editor",{x=vsx*0.5,y=vsy*0.7},vsy/18,{0,1,0,0.5},"cc","c", DeckEditor, MainMenu)
	AddFrame("Map:"..selectedMap.ClearName,{x=vsx*0.5,y=vsy*0.5},vsy/15,{0.1,1,0,0.5},"cc","c",ListMap, MainMenu) --opens maplist and returns back to main menu
	AddFrame("Run!",{x=vsx*0.5,y=vsy*0.1},vsy/18,{0,0,1,0.5},"cc","c", StartNewGame, selectedMap.InternalFileName) --starts a new game with the selected map
	AddFrame("Quit",{x=vsx*0.95 ,y=vsy*0.05},vsy/24,{0,0,1,0.5},"cc","c", Quit)
	
end


--the menu graphics, this will probably go through some changes 
local function DrawFrame(Frame)

	local Text = Frame.Text
	local Texture = nil
	local x = Frame.Pos.x
	local y = Frame.Pos.y
	local FontSize = Frame.FontSize
	local bg_red = Frame.Color[1] or (Frame.Function and 0.7 or 0.2)
	local bg_green = Frame.Color[2] or (Frame.Function and 0.7 or 0.2)
	local bg_blue = Frame.Color[3] or (Frame.Function and 0.7 or 0.2)
	local bg_alpha = Frame.Color[4] or 0.5
	local FramePosition = Frame.FramePosition
	local TextPosition = Frame.TextPosition

	if type(Text)=="function" then
		Text=Text()
	end
	if type(Text)=="table" then
		Texture,Text=Text.texture,Text.text
	end
	if type(Text)~="string" then
		Text=tostring(Text)
	end
	if type(x)~="number" then
		x=vsx/2
	end
	if type(y)~="number" then
		y=vsy/2
	end
	if type(FontSize)~="number" then
		FontSize=20
	end
	if type(bg_red)~="number" or type(bg_green)~="number" or type(bg_blue)~="number" then
		bg_red = 1
		bg_green = 1
		bg_blue = 1
	end
	if type(bg_alpha)~="number" then
		bg_alpha = 0.2
	end

	local txtLinesList = {}
	local maxTxtWidth = 0
	for line in string.gmatch(Text,"[^\r\n]+") do
		table.insert(txtLinesList,line)
		if gl.GetTextWidth(line)>maxTxtWidth then
			maxTxtWidth=gl.GetTextWidth(line)
		end
	end

	local TextWidthFixHack = 1
	if tonumber(string.sub(Game.version,1,4))<=0.785 and string.sub(Game.version,1,5)~="0.78+" then
		TextWidthFixHack = (vsx/vsy)*(4/3)
	end
	local xFramedTextSize=FontSize*(1+maxTxtWidth*TextWidthFixHack)
	local yFramedTextSize=FontSize*(1+#txtLinesList)
	if Texture then
		gl.Texture(Texture)
		local TextureInfo=gl.TextureInfo(Texture)
		xFramedTextSize,yFramedTextSize=TextureInfo.xsize,TextureInfo.ysize
		xFramedTextSize,yFramedTextSize=0.3*vsx,0.3*vsx*yFramedTextSize/xFramedTextSize
	end
	local xPosMin = x-xFramedTextSize/2
	local xPosMax = x+xFramedTextSize/2
	local yPosMin = y-yFramedTextSize/2
	local yPosMax = y+yFramedTextSize/2

	if type(FramePosition)=="string" and string.len(FramePosition)==2 then
		if string.sub(FramePosition,1,1)=='c' then
			xPosMin = x - xFramedTextSize/2
			xPosMax = x + xFramedTextSize/2
		elseif string.sub(FramePosition,1,1)=='r' then
			xPosMin = x - xFramedTextSize
			xPosMax = x
		elseif string.sub(FramePosition,1,1)=='l' then
			xPosMin = x
			xPosMax = x + xFramedTextSize
		else
			spEcho("Wrong FramePosition[1] in "..widget:GetInfo().name.."'s DrawFramedText",string.sub(FramePosition,1,1))
		end
		if string.sub(FramePosition,2,2)=='c' then
			yPosMin = y - yFramedTextSize/2
			yPosMax = y + yFramedTextSize/2
		elseif string.sub(FramePosition,2,2)=='t' or string.sub(FramePosition,2,2)=='u' then
			yPosMin = y - yFramedTextSize
			yPosMax = y
		elseif string.sub(FramePosition,2,2)=='b' or string.sub(FramePosition,2,2)=='d' then
			yPosMin = y
			yPosMax = y + yFramedTextSize
		else
			spEcho("Wrong FramePosition[2] in "..widget:GetInfo().name.."'s DrawFramedText")
		end
	else
		spEcho("Wrong FramePosition in "..widget:GetInfo().name.."'s DrawFramedText",string.sub(FramePosition,2,2))
	end

	Frame.Pos={x=Frame.Pos.x, y=Frame.Pos.y, xPosMin=xPosMin, xPosMax=xPosMax, yPosMin=yPosMin, yPosMax=yPosMax, xFramedTextSize=xFramedTextSize, yFramedTextSize=yFramedTextSize}

	if Frame.Function and isAboveFrame(nil,nil,Frame) then
		MouseOveredFrameIndex  = Frame.Index
		ActiveFrameIndex = Frame.Index
	end

	if ActiveFrameIndex ~= MouseOveredFrameIndex and not KeyboardFrameIndex then
		ActiveFrameIndex = nil
	end

	if Frame.Index==ActiveFrameIndex then
		bg_red = 1 - (1 - bg_red)/2
		bg_green = 1 - (1 - bg_green)/2
		bg_blue = 1 - (1 - bg_blue)/2
		bg_alpha = 1 - (1 - bg_alpha)/2
	end

	if Texture then
		gl.Color(1,1,1,bg_alpha)
		gl.TexRect(xPosMin,yPosMin,xPosMax,yPosMax)
		gl.Texture(false)
	else
		gl.Color(bg_red,bg_green,bg_blue,bg_alpha/2)
		gl.Rect(xPosMin,yPosMin,xPosMax,yPosMax)
	end
	gl.Color(1,1,1,bg_alpha)
	for n,_ in ipairs(txtLinesList) do
		if TextPosition=="c" then
			gl.Text(txtLinesList[n], (xPosMin+xPosMax)/2, yPosMax+(-0.5-n)*FontSize, FontSize, "cod")
		elseif TextPosition=="r" then
			gl.Text(txtLinesList[n], xPosMax-FontSize/2, yPosMax+(-0.5-n)*FontSize, FontSize, "rod")
		else
			gl.Text(txtLinesList[n], xPosMin+FontSize/2, yPosMax+(-0.5-n)*FontSize, FontSize, "od")
		end
	end
	if not Texture then
		gl.Color(bg_red,bg_green,bg_blue,bg_alpha/2)
		gl.Rect(xPosMin,yPosMin,xPosMax,yPosMax)
		gl.Color(bg_red,bg_green,bg_blue,bg_alpha)
		gl.LineWidth(FontSize/4)
		gl.Shape(GL.LINES,{
			{v={xPosMin+FontSize/4,yPosMax-FontSize/8}},
			{v={xPosMax-FontSize/4,yPosMax-FontSize/8}},
			{v={xPosMax-FontSize/8,yPosMax}},
			{v={xPosMax-FontSize/8,yPosMin}},
			{v={xPosMax-FontSize/4,yPosMin+FontSize/8}},
			{v={xPosMin+FontSize/4,yPosMin+FontSize/8}},
			{v={xPosMin+FontSize/8,yPosMin}},
			{v={xPosMin+FontSize/8,yPosMax}},})
	end
	gl.Color(1,1,1,1)
end


local function EitherDrawScreen(self)

	-- Nothing until screen size is known
	if vsx==nil or vsy==nil or vsx==0 or vsy==0 or not IsActive then
		return
	end
	
	-- If no menu shown, then show the first menu
	if #FramesList==0 then
		MainMenu()
	end


	-- Draw the elements
	gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
	gl.Color(1,1,1,1)
	gl.Text("Spring\n"..Game.version,4,4,12,"ob")
	gl.Text(Game.modShortName.."\n"..Game.modVersion,vsx-4,4,12,"rob")
	MouseOveredFrameIndex=nil
	for Index,Frame in ipairs(FramesList) do
		Frame.Index=Index
		DrawFrame(Frame)
	end
end

--switches the menu on
local function SwitchOn()
	if not IsActive then
		IsActive = true
		FramesList={}	
		--spSendCmds("endgraph 0")
		--spSendCmds("hideinterface 1")
		--spSendCmds("pause") --pauses the game when the menu is turned on
	end
end


function SwitchOff()
	if IsActive then
		IsActive = false
		RemoveAllFrames()
		widgetHandler:DisableWidget("The deck editor") --just to make sure the deck editor is off while in game
		if not gameOver then 
			enableWidgets()
		end	
		--spSendCmds("endgraph 1")
		--spSendCmds("hideinterface 0")
		--spSendCmds("pause") --unpauses the game when the menu is turned off
	end
end


function enableWidgets()
	WG.Darius:SendUIMessage("show")
end

--have to disable widgets so that the player can't accidently draw cards or move the windows while in menu 	
function disableWidgets()
	WG.Darius:SendUIMessage("hide")
	widgetHandler:DisableWidget("The deck editor")
end

--------------
-- Call-ins --
--------------

function widget:IsAbove(x,y)
	if IsActive then
		return true
	else
		return false
	end
end


function widget:GetTooltip(x,y)
	return ""
end


function widget:DrawScreenEffects(dse_vsx, dse_vsy)
	vsx, vsy = dse_vsx, dse_vsy
	if Spring.IsGUIHidden() then
		EitherDrawScreen(self)
	end
end


function widget:DrawScreen()
	if not Spring.IsGUIHidden() then
		EitherDrawScreen(self)
	end
end


function widget:MousePress(x,y,button)
	if IsActive then
		for _,Frame in ipairs(FramesList) do
			if isAboveFrame(x,y,Frame) then
				if Frame.Function then
					Frame.Function(Frame.Param1,Frame.Param2,Frame.Param3)
					return true
				end
			end
		end
	end
end

--not used at this point
--[[ 
function widget:MouseWheel(up,value)
	if up then
		if ScrollUp then
			ScrollUp[1](ScrollUp[2],ScrollUp[3],ScrollUp[4],ScrollUp[5])
			return true
		end
	else
		if ScrollDown then
			ScrollDown[1](ScrollDown[2],ScrollDown[3],ScrollDown[4],ScrollDown[5])
			return true
		end
	end
	return false
end
--]]

function widget:KeyPress(key)
	local up_arrow,down_arrow,right_arrow,left_arrow,enter,space,esc,del,tab = 273,274,275,276,13,32,27,127,9
	if key==esc then
		local _,cmd=Spring.GetActiveCommand()
		local alt,ctrl,meta,shift=Spring.GetModKeyState()
		if not alt and not ctrl and not meta and not shift and not cmd then
			if IsActive and not HideView then
				SwitchOff()
				return true
			elseif IsActive and HideView then
				HideView=false
				spSendCmds("endgraph 0")
				spSendCmds("hideinterface 1")
				spSendCmds({'NoSound 0'}) -- Re-enable sounds when pressing esc after direct running Spring.exe
				return true
			else
				SwitchOn()
				return true
			end
		end
	end
	if IsActive then
		if key==up_arrow or key==left_arrow then
			if not ActiveFrameIndex then
				for Index,Frame in ipairs(FramesList) do
					if Frame.Function then
						ActiveFrameIndex = Index
					end
				end
			else
				local NewFrameIndex = ActiveFrameIndex
				for Index,Frame in ipairs(FramesList) do
					if Frame.Function and Index<ActiveFrameIndex then
						NewFrameIndex = Index
					end
				end
				ActiveFrameIndex = NewFrameIndex
			end
		KeyboardFrameIndex = ActiveFrameIndex
		elseif key==down_arrow or key==right_arrow or key==tab then
			if key==tab and ActiveFrameIndex==#FramesList then
				ActiveFrameIndex=nil
			end
			if not ActiveFrameIndex then
				for Index,Frame in ipairs(FramesList) do
					if Frame.Function then
						ActiveFrameIndex = Index
						break
					end
				end
			else
				for Index,Frame in ipairs(FramesList) do
					if Frame.Function and Index>ActiveFrameIndex then
						ActiveFrameIndex = Index
						break
					end
				end
			end
		KeyboardFrameIndex = ActiveFrameIndex
		elseif key==enter or key==space then
			if ActiveFrameIndex and FramesList[ActiveFrameIndex] and FramesList[ActiveFrameIndex].Function then
				FramesList[ActiveFrameIndex].Function(FramesList[ActiveFrameIndex].Param1,FramesList[ActiveFrameIndex].Param2,FramesList[ActiveFrameIndex].Param3)
				return true
			end
		elseif key==del then
			local FrameIndex=ActiveFrameIndex or MouseOveredFrameIndex or KeyboardFrameIndex
			if FrameIndex and FramesList[FrameIndex] and FramesList[FrameIndex].Param2 then
				local ActiveSave=FramesList[FrameIndex].Param2
				if ActiveSave.FileName then
					spEcho("Deleting "..ActiveSave.FileName)
					os.remove(ActiveSave.FileName)
					return true
				end
			end
		end
		if key==up_arrow or key==left_arrow or key==down_arrow or key==right_arrow or key==enter or key==space or key==tab then
			return true
		end
	end
end

function widget:GameOver()
	gameOver = true
	SwitchOn()
end

function widget:Initialize()

	FramesList={}
	spSendCmds({'NoSound 1'}) -- Disable sound when menu pops up straight after running Spring.exe
	HideView = false
	SwitchOff()
end


function widget:Shutdown()
	SwitchOff()
end
