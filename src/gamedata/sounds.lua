
local Sounds = {
   SoundItems = {
      MapPoint = {
         file = "sounds/voices/gamestart.wav",
         priority = 15,
         preload = true,
         rolloff = 0.1,
      },
	  IncomingChat = {
         file = "sounds/ui/chip.wav",
         priority = 15,
         preload = true,
      },
      MultiSelect = {
         file = "sounds/ui/bleep.wav",
         priority = 15,
         preload = true,
         rolloff = 0.1,
      },
	  FailedCommand = {
         file = "sounds/ui/error.wav",
         gain = 0.75,
         priority = 15,
         preload = true,
         in3d = false,
      }
   }
}

return Sounds