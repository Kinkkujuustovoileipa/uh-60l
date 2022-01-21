dofile(LockOn_Options.script_path.."AI/AI_utility.lua")

S_INIT					= 0
S_WAIT					= 1
S_ENGAGE				= 2
S_OPEN_DOOR				= 3
S_ACTIVE				= 4
S_CLOSE_DOOR			= 5
S_DEATH_ANIM			= 6
S_DEAD					= 7
S_LOAD					= 8
S_UNLOAD				= 9
S_CLOSE_DOOR_ARMED		= 10
S_CLOSE_DOOR_UNARMED	= 11


function fill_side_controller(pylon_, gun_num_, azimuth_limit_, elevation_limit_)
return {
	handler = {
		name = "GunHandler",
		location = {pylon_,gun_num_}, 
	},
	guidance = {
		name = "PilonCannonSight",
		location = {pylon_,gun_num_}, 
		FOF =  { 
			azimuth = azimuth_limit_,
			elevation = elevation_limit_
		},
	},
	Aiming_T = 0.3,
}
end

function fill_side_states(d_mecha_, d_arg_, g_arg_, az_arg_, elev_arg_, dead_arg_, hide_gunner_arg_, collision_box_arg_)
return {
	[S_ENGAGE] = {
		--Enagage -- empty because no actions
	},

	[S_OPEN_DOOR] = {
		name = "AnimateModel",
		args = {
		-- {arg_num}, {init}, {target}, {speed}
			model_animation(d_mecha_,nil,"Open"),	
			model_animation(g_arg_,-0.7,0.0,0.3, {arg_cnd('EG',d_arg_,0.8)})
			}
	},

	[S_ACTIVE] = {
		name = "Cannon",
		max_sight_deviation = {math.rad(1.0), math.rad(1.0)}, -- {azimuth,elevation}
		average_burst = 2.0, -- in sec
		gunner_model_arg = hide_gunner_arg_
	},

	[S_CLOSE_DOOR] = {}, --no actions, just transfer state to close door either armed or unarmed
	
	[S_DEATH_ANIM] = {
		name = "AnimateModel",
		args = {
			model_animation(dead_arg_,0.0,1.0,0.02),
		}
	},
	
	[S_DEAD] = {
		name = "GunnerDead",
	},
	
	[S_LOAD] = {
		name = "InitModel",
		args = {
			model_init(az_arg_,0.0),
			model_init(elev_arg_,0.0),	
			--model_init(g_arg_,-0.7),
			--model_init(d_arg_,0.0),
			model_init(collision_box_arg_,0.0)
		}
	},
	
	[S_UNLOAD] = {
		name = "GunnerUnload",
		args = {
			model_init(collision_box_arg_,1.0),
		}
	},
	
	[S_CLOSE_DOOR_ARMED] = {
		name = "AnimateModel",
		args = {
			-- {arg_num}, {init}, {target}, {speed}
			model_animation(az_arg_,nil,0.0,0.2),
			model_animation(elev_arg_,nil,0.0,0.2),
			model_animation(g_arg_,0.0,-0.7,-0.3),
			model_animation(d_mecha_,nil,"Close",nil,{arg_cnd('EL',g_arg_,-0.4)})
		}
	},
	
	[S_CLOSE_DOOR_UNARMED] = {
		name = "AnimateModel",
		args = {
			model_animation(d_mecha_,nil,"Close")
		}
	},
}
end

function fill_side_state_matrix(d_arg_, g_arg_, dead_arg_)
return {
	--[[INIT]]	{[S_LOAD] = s_cnds({{name="IsPresent", value = true}}),
				 [S_UNLOAD] = s_cnds({{name="IsPresent", value = false}})
				},
				 
	--[[WAIT]]	{[S_ENGAGE] = s_cnds({EngCmd}),
				 [S_DEATH_ANIM] = s_cnds({{name="IsDead"}}),
				 [S_OPEN_DOOR] = s_cnds({OpenDoorCmd}),
				 [S_CLOSE_DOOR] = s_cnds({CloseDoorCmd}),
				 },
	
	--[[ENGAGE]]{[S_OPEN_DOOR] = s_cnds({arg_cnd("E",d_arg_,0.0)}),
				 [S_ACTIVE]= s_cnds({arg_cnd("E",d_arg_,1.0),EngCmd})},
	
	--[[OPEN DOOR]]{[S_UNLOAD] = s_cnds({arg_cnd("E",d_arg_,1.0),{name="IsPresent", value = false}}),
					[S_ACTIVE] = s_cnds({arg_cnd("E",g_arg_,0.0),{name="IsPresent", value = true}}),
					[S_DEATH_ANIM] = s_cnds({{name="IsDead"}})
					},
					
	--[[FIRE]] {[S_WAIT] = s_cnds({DEngCmd}),
				[S_DEATH_ANIM] = s_cnds({{name="IsDead"}}),
				[S_OPEN_DOOR] = s_cnds({OpenDoorCmd}),
				[S_CLOSE_DOOR] = s_cnds({CloseDoorCmd}),
				},

--[[CLOSE DOOR]] 	{
					[S_CLOSE_DOOR_ARMED] = s_cnds({{name="IsPresent", value = true}}),
					[S_CLOSE_DOOR_UNARMED] = s_cnds({{name="IsPresent", value = false}}),
					},



	--[[DEATH ANIM]] {[S_DEAD] = s_cnds({arg_cnd("EG",dead_arg_,0.12)})},
	
	--[[DEAD]]			{},
	
					
	--[[LOAD]]		{[S_WAIT] = s_cnds({{name = "OperatorJMP"}})},
	
	--[[UNLOAD]]	{
					[S_OPEN_DOOR] = s_cnds({OpenDoorCmd}),
					[S_CLOSE_DOOR] = s_cnds({CloseDoorCmd}),
					},
					
--[[CLOSE DOOR ARMED]]{
					[S_WAIT] = s_cnds({arg_cnd("E",d_arg_,0.0),{name="IsPresent", value = true}}),
					[S_DEATH_ANIM] = s_cnds({{name="IsDead"}}),
					},
					
--[[CLOSE DOOR UNARMED]]{
					[S_WAIT] = s_cnds({arg_cnd("E",d_arg_,0.0)}),
					},

}
end
