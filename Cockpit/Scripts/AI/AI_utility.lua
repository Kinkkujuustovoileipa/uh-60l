EngCmd = {name = "OperatorStrE", commands = {"engage"}}
DoorCmd = {name = "OperatorStrE", commands = {"door"}}
DEngCmd = {name = "OperatorStrE", commands = {"disengage"}}
NullCmd = {name = "OperatorStrE", commands = {"","door"}}
OpenDoorCmd = {name = "OperatorStrE", commands = {"open_door"}}
CloseDoorCmd = {name = "OperatorStrE", commands = {"close_door"}}

function arg_cnd(operator_, arg_, value_)
	local arg_l = parse_argument(arg_)
	return {name = "Operator"..operator_, arg = arg_l[1], pylon = arg_l[2], value = value_}
end

function parse_argument(arg_)
	
	local arg_n_  = -1
	local pylon_ = -1

	if type(arg_)=="table" then
		arg_n_ = arg_[1]
		pylon_ = arg_[2] or -1
	else
		arg_n_ = arg_
	end 
	
	return {arg_n_, pylon_}
end

function model_animation(arg_, init_, target_, speed_, conditions_)
	if type(arg_) == 'string' then
		return {arg = -1, mecha = arg_, target = target_, conditions = conditions_}
	else
		local arg_l = parse_argument(arg_)
		return {arg = arg_l[1], pylon = arg_l[2], init = init_, target = target_, speed = speed_, conditions = conditions_}
	end
end

function model_init(arg_, value_)

	local arg_l = parse_argument(arg_)
	return {arg = arg_l[1], pylon = arg_l[2], value = value_}
end

function s_cnds(conditions_)
	return {conditions = conditions_}
end

function add_gunner(position_,controller_,max_armor_, wait_state_, states_, states_matrix_)
return
	{
	position = position_,

	controller = controller_,
	
	max_armor_width = max_armor_,

	wait_state	= wait_state_,
	
	states = states_,
	
	state_matrix = states_matrix_
}
end