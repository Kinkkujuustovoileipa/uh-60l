dofile(LockOn_Options.script_path.."AI/AI_Operator.lua")
dofile(LockOn_Options.script_path.."AI/AI_Side_Gunner.lua")
dofile("Scripts/Database/wsTypes.lua")

OPERATOR_SEAT = 1
LEFT_GUNNER_SEAT = 2
RIGHT_GUNNER_SEAT = 3

AI_gunners = {}
AI_manager = {
	--> decrease priority
	targets_priority = { 
	{wsType_Air},
	{wsType_Ground,wsType_SAM, wsType_Miss},
	{wsType_Ground,wsType_SAM},
	{wsType_Ground,wsType_Tank}, 
	},
	
	EffectiveRange = 5000
}

left_gunner_position =  {
	
	coord = {0.1,0.3,-0.4},
	--Field of view related to aircraft
	FOV = { 
		azimuth = {math.rad(-126), math.rad(-36.0)},
		elevation = {math.rad(-40), math.rad(10.0)}
	}
}

left_controller = fill_side_controller(2,0,{math.rad(-36), math.rad(54.0)},{math.rad(-40), math.rad(10.0)})
left_state_matrix = fill_side_state_matrix(43,{426,2},{452,2})
left_g_states = fill_side_states("Door2", 43, {426,2}, {423,2}, {424,2}, {452,2},{52,2},52)

AI_gunners[LEFT_GUNNER_SEAT] = add_gunner(left_gunner_position,left_controller,0.04,S_WAIT,left_g_states,left_state_matrix)

right_gunner_position =  {
	
	coord = {0.1,0.3,0.4},
	--Field of view related to aircraft
	FOV = { 
		azimuth = {math.rad(36), math.rad(126.0)},
		elevation = {math.rad(-40), math.rad(10.0)}
	}
}

right_controller = fill_side_controller(3,0,{math.rad(-54), math.rad(36.0)},{math.rad(-40), math.rad(10.0)})
right_state_matrix = fill_side_state_matrix(44,{426,3},{452,3})
right_g_states = fill_side_states("Door3", 44,{426,3}, {423,3}, {424,3}, {452,3}, {52,3},51)

AI_gunners[RIGHT_GUNNER_SEAT] = add_gunner(right_gunner_position,right_controller,0.04,S_WAIT,right_g_states,right_state_matrix)

operator_pos = 	{
	coord = {2.665,0.361,-0.586},
	--Field of view related to aircraft
	FOV = { 
		azimuth = {math.rad(-70), math.rad(70.0)},
		elevation = {math.rad(-70), math.rad(20.0)}
	}
}

operator_states = fill_operator_states({449})
operator_state_matrix = fill_operator_state_matrix({449})

AI_gunners[OPERATOR_SEAT] = add_gunner(operator_pos,{Aiming_T = 0.1},0.05,OPERATOR_WAITING,operator_states,operator_state_matrix)
