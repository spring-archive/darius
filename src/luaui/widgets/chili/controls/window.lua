Window = Control:Inherit{
  classname = 'window',
  resizable = true,
  draggable = true,

  minWidth  = 50,
  minHeight = 50,
  defaultWidth  = 400,
  defaultHeight = 300,
}

local this = Window
local inherited = this.inherited

--//=============================================================================
--[[
function Window:UpdateClientArea()
  this.inherited.UpdateClientArea(self)

  if (not WG['blur_api']) then return end

  if (self.blurId) then
    WG['blur_api'].RemoveBlurRect(self.blurId)
  end

  local screeny = select(2,gl.GetViewSizes()) - self.y

  self.blurId = WG['blur_api'].InsertBlurRect(self.x,screeny,self.x+self.width,screeny-self.height)
end
--]]
--//=============================================================================

function Window:New(obj)
  obj = inherited.New(self,obj)
  obj:BringToFront()
  return obj
end

function Window:DrawControl()
  --// gets overriden by the skin/theme
end

function Window:MouseDown(...)
  self:BringToFront()
  return inherited.MouseDown(self,...)
end
