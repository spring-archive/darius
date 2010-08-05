
function widget:GetInfo()
  return {
    name      = "Music",
    desc      = "Plays music",
    author    = "zwzsg",
    date      = "Aug 22 2009",
    license   = "Free",
    layer     = 0,
    enabled   = true
  }
end



local AllTracks      = VFS.DirList('sounds/music/','*.ogg')
local CurrentTrack   = nil
local info           = ""
local LastTimer      = nil
local LastPlayedTime = 0
local PlayNew        = true



local function JustTheName(text)
  local EndIndex=(string.find(text,".",string.len(text)-4,true) or 1+string.len(text))-1
  local BeginIndex=1
  repeat
    local NewBeginIndex=string.find(text,"/",BeginIndex,true) or string.find(text,"\\",BeginIndex,true)
    BeginIndex=NewBeginIndex and NewBeginIndex+1 or BeginIndex
  until not NewBeginIndex
  return string.sub(text,BeginIndex,EndIndex)
end


function widget:Shutdown()
  Spring.StopSoundStream()
end


function widget:Update()
  local PlayedTime, TotalTime = Spring.GetSoundStreamTime()
  info = "PlayedTime="..(PlayedTime or "nil").."\nTotalTime="..(TotalTime or "nil")
  info = (CurrentTrack and (JustTheName(CurrentTrack).."\n") or "")..info
  PlayedTime=PlayedTime or 0
  if not LastTimer then
   LastTimer=Spring.GetTimer()
   return
  end
  local Timer=Spring.GetTimer()
  if Spring.DiffTimers(Timer,LastTimer)>10 then
    LastTimer=Timer
    if LastPlayedTime==PlayedTime and PlayedTime>0 then
      PlayNew=true
    else
      LastPlayedTime=PlayedTime
    end
  end
  if PlayNew then
    if not AllTracks  or #AllTracks<1 then
      Spring.Echo("No music found!")
      widgetHandler:RemoveWidget()
    else
      local x,y=Spring.GetMouseState()
      local BetterRand=x+y+math.floor(99*(os.clock()%99999)+(99*(os.time())%99999))+Spring.GetDrawFrame()+math.random(0,999)
      CurrentTrack = AllTracks[1+(BetterRand%#AllTracks)]
      --Spring.SetConfigInt("snd_volmusic",25) -- Neither
      Spring.PlaySoundStream(CurrentTrack,0.3) -- Volume here does nothing
      Spring.Echo("Music: "..JustTheName(CurrentTrack))
      PlayNew=false
    end
  end
end


function widget:DrawScreen()
  if Spring.IsDevLuaEnabled() then
    gl.Text(info,0,150,16)
  end
end
