return {
	PlayerName = "Darius",
	MapName = "dunes.smf",

	GameMode = 1,
	 -- 0 for "Kill everything"
	 -- 1 for "Kill all factories"
	 -- 2 for "Kill the Commander"
	 -- 4 for "Never ends"
	toString = function(self)
		return [[
			[GAME]
			{
				GameType = Darius Tower Defense 0.1; //Complete Annihilation stable-7761
				Mapname = ]]..self.MapName..[[;

				[MODOPTIONS]
				{
					GameMode = ]]..self.GameMode..[[;
					ghostedbuildings = 1;
					fixedallies = 1;
					MaxUnits = 512;
					MinSpeed = 0.1;
					MaxSpeed=10;

					// Irrelevant for Darius:
					StartMetal = 0;
					StartEnergy = 1000;
					LauncherName = Darius Game Launcher;
					LauncherVersion = 0.1;
				}

				HostIP=localhost;
				HostPort=0;
				IsHost=1;

				StartPosType = 0;// 0 for fixed, 1 for random, 2 for chosen
				MyPlayerNum = 0;
				MyPlayerName = ]]..self.PlayerName..[[;
				NumPlayers = 1;
				NumUsers = 2;
				NumTeams = 2;
				NumAllyTeams = 2;

				// List of human controlled players:
				[PLAYER0]
				{
					name = ]]..self.PlayerName..[[;
					Team = 1;
					Spectator = 0;
				}

				// List of AI controlled players:
				[AI0]
				{
					name = Invaders;
					ShortName = NullAI;
					Team = 0;
					Host = 0;// Number of the PLAYER hosting the AI
				}

				// List of "teams" (or "players" depending on terminology):
				[TEAM0]
				{
					TeamLeader = 0;
					AllyTeam = 0;
					Handicap = 0;
					Side=random;
					RGBColor = 1 0 0;
					AIDLL=NullAI 0.1;
					RemoveUnits = 1; //Not sure what this does
					RemoveFeatures = 1; //Not sure what this does
					//u1= castle Position 50 50;
				}
				[TEAM1]
				{
					TeamLeader=0;
					AllyTeam=1;
					Handicap=0;
					Side=random;
					RGBColor=0 1 0;
					RemoveUnits=1;
					RemoveFeatures=1;
					//u1= castle Position 1000 1000;
				}

				// List of ally teams: This is for assymetrical alliances
				[ALLYTEAM0]
				{
					NumAllies=0;
				}
				[ALLYTEAM1]
				{
					NumAllies=0;
				}

				// List of restrictions
				NumRestrictions=0;
				[RESTRICT]
				{
				}
			}
		]]
	end,
}