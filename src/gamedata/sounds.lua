
local Sounds = {
   SoundItems = {
      MapPoint = {
         file = "sounds/other/gamestart.wav",
         priority = 15,
         preload = true,
         rolloff = 0.1,
      },
	  IncomingChat = {
         file = "sounds/other/chip.wav",
         priority = 15,
         preload = true,
      },
      MultiSelect = {
         file = "sounds/other/bleep.wav",
         priority = 15,
         preload = true,
         rolloff = 0.1,
      },
	  FailedCommand = {
         file = "sounds/other/error.wav",
         gain = 0.75,
         priority = 15,
         preload = true,
         in3d = false,
      }
   }
}

return Sounds