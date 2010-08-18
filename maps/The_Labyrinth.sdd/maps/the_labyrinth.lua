return {
	name = "The Labyrinth",
	waves = {
		easy = {
			--CreateWave({monster1 = {"id", interval, count}, monster2 = {"id", interval, count}, ...})
			CreateWave({{"chicken", 2, 20},}), --Chickens
			CreateWave({{"corthud", 2, 3},}), --Thug
			CreateWave({{"armpw", 2, 5},}),
			CreateWave({{"arm_venom", 2, 3},}),  --Venom
			CreateWave({{"corstorm", 2, 3},}),
			CreateWave({{"corpyro", 2, 3},}),
			CreateWave({{"armsptk", 2, 3},}),
			CreateWave({{"chickena", 2, 3},}),
			CreateWave({{"chicken_dodo", 2, 4},}),
			CreateWave({{"chicken_sporeshooter", 2, 4},}),
			CreateWave({{"cormortgold", 2, 2},}),
			CreateWave({{"armwar", 2, 3},}),
			CreateWave({{"chickenc", 2, 2},}),
			CreateWave({{"armorco", 2, 2},}),
			CreateWave({{"chickenq", 2, 1},}),
		},
		normal = {
			CreateWave({{"chicken", 2, 40},}), --Chickens
			CreateWave({{"corthud", 2, 10},}), --Thug
			CreateWave({{"armpw", 2, 5},}),
			CreateWave({{"arm_venom", 2, 3},}),  --Venom
			CreateWave({{"corstorm", 2, 3},}),
			CreateWave({{"corpyro", 2, 3},}),
			CreateWave({{"armsptk", 2, 3},}),
			CreateWave({{"chickena", 2, 3},}),
			CreateWave({{"chicken_dodo", 2, 4},}),
			CreateWave({{"chicken_sporeshooter", 2, 4},}),
			CreateWave({{"cormortgold", 2, 2},}),
			CreateWave({{"armwar", 2, 3},}),
			CreateWave({{"chickenc", 2, 2},}),
			CreateWave({{"armorco", 2, 2},}),
			CreateWave({{"chickenq", 2, 1},}),
		},
		hard = {
			CreateWave({{"chicken", 2, 80},}), --Chickens
			CreateWave({{"corthud", 2, 10},}), --Thug
			CreateWave({{"armpw", 2, 9},}),
			CreateWave({{"arm_venom", 2, 12},}), --Venom
			CreateWave({{"corstorm", 2, 8},}),
			CreateWave({{"corpyro", 2, 8},}),
			CreateWave({{"armsptk", 2, 5},}),
			CreateWave({{"chickena", 2, 5},}),
			CreateWave({{"chicken_dodo", 2, 5},}),
			CreateWave({{"chicken_sporeshooter", 2, 5},}),
			CreateWave({{"cormortgold", 2, 5},}),
			CreateWave({{"armwar", 2, 5},}),
			CreateWave({{"chickenc", 2, 5},}),
			CreateWave({{"armorco", 2, 5},}),
			CreateWave({{"chickenq", 2, 3},}),
		},
	},
	castleposition = {90, 100},
	spawningpoints = {
		{950,100},
  	},
}
