-------------------
--The Darius skin--
-------------------


local skin = {
  info = {
    name    = "Darius",
    version = "0.01",
    author  = "Ziggurat",
  }
}

skin.general = {
--Removing the general section(even if empty) will crash almost every chili widget
}

skin.window = {
  TileImage = ":cl:glass_.png",


  --In the following order: left, top, right, bottom

  tiles = {25, 25, 25, 25},-- Affects on how the edges of the window will be drawn

  padding = {15, 13, 10, 10},-- The empty space between the window edge and the elements inside

  hitpadding = {4, 4, 4, 4},-- Sets the limits wich the user must exceed in order to "hit" the object

  captionColor = {1, 1, 1, 1},-- RGB values (0 = 0 and 1 = 255), opaqueness(0 = can't see it. 1 = can't see through it)



  boxes = {
    resize = {-25, -25, -14, -14},
    drag = {0, 0, "100%", 24},
  },



  NCHitTest = NCHitTestWithPadding,
  NCMouseDown = WindowNCMouseDown,
  NCMouseDownPostChildren = WindowNCMouseDownPostChildren,


  --Defines the functions that draw the window
  DrawControl = DrawWindow,
  DrawDragGrip = DrawDragGrip,
  DrawResizeGrip = DrawResizeGrip,
}

skin.control = skin.general

return skin
