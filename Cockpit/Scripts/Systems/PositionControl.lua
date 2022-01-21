dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.1  
make_default_activity(update_time_step)
local PositionControl     = GetSelf()

local posIndex = 0
local paramHandlePosIndex = get_param_handle("POS_INDEX")

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then
    end
end

PositionControl:listen_command(Keys.iCommandViewCockpitChangeSeat)

function SetCommand(command,value)
    if command == device_commands.iCommandViewCockpitChangeSeat then
        --print_message_to_user("change")
		posIndex = value
		paramHandlePosIndex:set(value)
	end
end

function update()
	--print_message_to_user(posIndex)
end

need_to_be_closed = false -- lua_state  will be closed in post_initialize()