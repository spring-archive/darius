-- This is very much wip. There are lots of parts broken, so be warned. 
--by Chris Mackey

-- pieces
local base = piece "base"
local head = piece "head"
local axle = piece "axle"
local podpist = piece "podpist"

-- missile rack
local pod = piece "pod"
local l_poddoor = piece "l_poddoor"
local r_poddoor = piece "r_poddoor"
local m_1 = piece "m_1"
local m_2 = piece "m_2"
local m_3 = piece "m_3"
local ex_1 = piece "ex_1"
local ex_2 = piece "ex_2"
local ex_3 = piece "ex_3"
local d_1 = piece "d_1"
local d_2 = piece "d_2"
local d_3 = piece "d_3"

--left leg
local l_thigh = piece "l_thigh"
local l_leg = piece "l_leg"
local l_pist = piece "l_pist"
local l_ankle = piece "l_ankle"
local l_foot = piece "l_foot"
local l_footie = piece "l_footie"
local l_toe = piece "l_toe"
local lf_toe = piece "lf_toe"
local lb_toe = piece "lb_toe"

--right leg
local r_thigh = piece "r_thigh"
local r_leg = piece "r_leg"
local r_pist = piece "r_pist"
local r_ankle = piece "r_ankle"
local r_foot = piece "r_foot"
local r_footie = piece "r_footie"
local r_toe = piece "r_toe"
local rf_toe = piece "rf_toe"
local rb_toe = piece "rb_toe"

--constants
local missile = 1
local missilespeed = 850 --fixme
local mfront = 10 --fixme
local pause = 600

--effects
local smokeblast = 1024

--signals
local walk = 2
local aim  = 4

function script.Create()
	Turn( ex_1, x_axis, math.rad(170) )
	Turn( ex_2, x_axis, math.rad(170) )
	Turn( ex_3, x_axis, math.rad(170) )
	Turn( axle, x_axis, math.rad(-30) )
end

local function Walk()
	SetSignalMask( walk )
	while ( true ) do -- needs major fixing. 
		Turn( l_thigh, x_axis, -1, 2 )
		Turn( l_leg, x_axis, 1, 2 )
		
		Turn( r_thigh, x_axis, 1, 2 )
		Turn( r_leg, x_axis, -1, 2 )
		
		Sleep( pause )
		WaitForTurn( l_thigh, x_axis )
		
		Turn( l_thigh, x_axis, 1, 2 )
		Turn( l_leg, x_axis, -1, 2 )
		
		Turn( r_thigh, x_axis, -1, 2 )
		Turn( r_leg, x_axis, 1, 2 )
		
		Sleep( pause )
		WaitForTurn( l_thigh, x_axis )
		--Sleep( 200 )
	end
end

local function StopWalk()
	Turn( l_thigh, x_axis, 0, 2 )
	Turn( l_leg, x_axis, 0, 2 )
	
	Turn( r_thigh, x_axis, 0, 2 )
	Turn( r_leg, x_axis, 0, 2 )
end

function script.StartMoving()
	SetSignalMask( walk )
	StartThread( Walk )
end

function script.StopMoving()
	Signal( walk )
	SetSignalMask( walk )
	StartThread( StopWalk )
end

----[[
function script.QueryWeapon1() return pod end

function script.AimFromWeapon1() return pod end

function script.AimWeapon1( heading, pitch )
	Signal( aim )
	SetSignalMask( aim )
	Turn( head, y_axis, heading, 3 )
	Turn( pod, x_axis, -pitch, 3 )
	--WaitForTurn( head, y_axis )
	--WaitForTurn( pod, x_axis )
	return true
end

function script.FireWeapon1()
	--effects
	EmitSfx( ex_1, smokeblast )
end
--]]

--[[ why are there two weapons???
function script.QueryWeapon2() return pod end

function script.AimFromWeapon2() return pod end

function script.AimWeapon2( heading, pitch )
	Signal( aim )
	SetSignalMask( aim )
	Turn( head, y_axis, heading, 5 )
	Turn( pod, x_axis, -pitch, 5 )
	--WaitForTurn( head, y_axis )
	--WaitForTurn( pod, x_axis )
	return true
end

function script.FireWeapon2()
	--effects
end
--]]

function script.Killed(recentDamage, maxHealth)
	Explode( head, SFX.EXPLODE )
	--etc... for other pieces
	local severity = recentDamage / maxHealth

	if (severity <= .25) then
		return 1 -- corpsetype

	elseif (severity <= .5) then
		return 2 -- corpsetype

	else		
		return 3 -- corpsetype
	end
end
