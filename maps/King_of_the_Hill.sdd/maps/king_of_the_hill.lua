return {
	name = "King of the Hill",

	easy = {
		{ -- wave 1
			duration = 30,
			{ monster = "chicken", interval = 2, amount = 10, location = 1 },
			{ monster = "chicken", interval = 2, amount = 10, location = 2 },
			{ monster = "chicken", interval = 2, amount = 10, location = 3 },
		},
		{ -- wave 2
			duration = 30,
			{ monster = "corthud", interval = 3, amount = 3, location = 1 },
			{ monster = "corthud", interval = 3, amount = 3, location = 2 },
			{ monster = "corthud", interval = 3, amount = 3, location = 3 },
		},
		{ -- wave 3
			duration = 30,
			{ monster = "armpw", interval = 3, amount = 5, location = 1 },
			{ monster = "armpw", interval = 3, amount = 5, location = 2 },
			{ monster = "armpw", interval = 3, amount = 5, location = 3 },
		},
		{ -- wave 4
			duration = 30,
			{ monster = "arm_venom", interval = 3, amount = 3, location = 1 },
			{ monster = "arm_venom", interval = 3, amount = 3, location = 2 },
			{ monster = "arm_venom", interval = 3, amount = 3, location = 3 },
		},
		{ -- wave 5
			duration = 30,
			{ monster = "corstorm", interval = 4, amount = 3, location = 1 },
			{ monster = "corstorm", interval = 4, amount = 3, location = 2 },
			{ monster = "corstorm", interval = 4, amount = 3, location = 3 },
		},
		{ -- wave 6
			duration = 30,
			{ monster = "corpyro", interval = 5, amount = 3, location = 1 },
			{ monster = "corpyro", interval = 5, amount = 3, location = 2 },
			{ monster = "corpyro", interval = 5, amount = 3, location = 3 },
		},
		{ -- wave 7
			duration = 30,
			{ monster = "armsptk", interval = 3, amount = 3, location = 1 },
			{ monster = "armsptk", interval = 3, amount = 3, location = 2 },
			{ monster = "armsptk", interval = 3, amount = 3, location = 3 },
		},
		{ -- wave 8
			duration = 30,
			{ monster = "chickena", interval = 3, amount = 3, location = 1 },
			{ monster = "chickena", interval = 3, amount = 3, location = 2 },
			{ monster = "chickena", interval = 3, amount = 3, location = 3 },
		},
		{ -- wave 9
			duration = 30,
			{ monster = "chicken_dodo", interval = 5, amount = 4, location = 1 },
			{ monster = "chicken_dodo", interval = 5, amount = 4, location = 2 },
			{ monster = "chicken_dodo", interval = 5, amount = 4, location = 3 },
		},
		{ -- wave 10
			duration = 30,
			{ monster = "chicken_sporeshooter", interval = 5, amount = 4, location = 1 },
			{ monster = "chicken_sporeshooter", interval = 5, amount = 4, location = 2 },
			{ monster = "chicken_sporeshooter", interval = 5, amount = 4, location = 3 },
		},
		{ -- wave 11
			duration = 30,
			{ monster = "cormortgold", interval = 5, amount = 2, location = 1 },
			{ monster = "cormortgold", interval = 5, amount = 2, location = 2 },
			{ monster = "cormortgold", interval = 5, amount = 2, location = 3 },
		},
		{ -- wave 12
			duration = 30,
			{ monster = "armwar", interval = 3, amount = 3, location = 1 },
			{ monster = "armwar", interval = 3, amount = 3, location = 2 },
			{ monster = "armwar", interval = 3, amount = 3, location = 3 },
		},
		{ -- wave 13
			duration = 30,
			{ monster = "chickenc", interval = 5, amount = 2, location = 1 },
			{ monster = "chickenc", interval = 5, amount = 2, location = 2 },
			{ monster = "chickenc", interval = 5, amount = 2, location = 3 },
		},
		{ -- wave 14
			duration = 30,
			{ monster = "armorco", interval = 5, amount = 1, location = math.random(1,3) },
		},
		{ -- wave 15
			duration = 30,
			{ monster = "chickenq", interval = 5, amount = 1, location = math.random(1,3) },
		}
	},
	
	--[[
	normal = {
	},
	
	hard = {
	},
	]]--
	
	castleposition = {1200, 700},
	spawningpoints = {
		{1900, 400},
		{90, 1900},
		{90, 400},
  	},
}
