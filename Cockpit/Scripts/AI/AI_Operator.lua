dofile(LockOn_Options.script_path.."AI/AI_utility.lua")

OPERATOR_WAITING	= 0
OPERATOR_ACTIVE	    = 1
OPERATOR_DEATH_ANIM	= 2
OPERATOR_DEAD		= 3

function fill_operator_states(dead_arg_)
return {
	[OPERATOR_WAITING] = {},

	[OPERATOR_ACTIVE] = {
		name = "Cannon",
		max_sight_deviation = {math.rad(3.0), math.rad(3.0)}, -- {azimuth,elevation}
		average_burst = 2.0 -- in sec
	},
	
	[OPERATOR_DEATH_ANIM] = {
		name = "AnimateModel",
		args = {
			model_animation(dead_arg_,0.0,1.0,0.7),
		}
	},
	
	[OPERATOR_DEAD] = {
		name = "GunnerDead",
	},
}
end

function fill_operator_state_matrix(dead_arg_)
return {	

	--[[WAIT]] {[OPERATOR_ACTIVE] = s_cnds({EngCmd}),
				[OPERATOR_DEATH_ANIM] = s_cnds({{name="IsDead"}})},
				
	--[[ACTIVE]]  {[OPERATOR_WAITING] = s_cnds({DEngCmd}),
					[OPERATOR_DEATH_ANIM] = s_cnds({{name="IsDead"}})},
	
	--[[DEATH ANIM]] { [OPERATOR_DEAD] = s_cnds({arg_cnd("EG",dead_arg_,0.5)})},
	
	--[[DEAD]] {}

}
end