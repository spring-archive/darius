
-- by Chris Mackey
include "smokeunit.lua"

--pieces 
local base = piece "base"
local missile = piece "missile"
local l_wing = piece "l_wing"
local l_fan = piece "l_fan"
local r_wing = piece "r_wing"
local r_fan = piece "r_fan"

local smokePieces = { base, l_wing, r_wing }

function script.Create()
	StartThread(SmokeUnit, smokePieces)
end

function script.QueryWeapon1() return missile end

function script.AimFromWeapon1() return missile end

function script.AimWeapon1( heading, pitch ) 
	Turn( base, y_axis, heading, 10 )
	Turn( base, x_axis, -pitch, 10 )
	WaitForTurn( base, y_axis )
	WaitForTurn( base, x_axis )
	return true 
end

function script.FireWeapon1()
	--effects
	Spring.DestroyUnit( unitID, 0 )
end

function script.Killed()
	Explode( base, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_wing, SFX.EXPLODE )
	Explode( r_wing, SFX.EXPLODE )
	
	Explode( missile, SFX.SHATTER )
	
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( l_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
	Explode( r_fan, SFX.EXPLODE, SFX.FIRE, SFX.SMOKE )
end
