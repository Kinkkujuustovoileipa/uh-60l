dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
local dev 	    = GetSelf()

local update_time_step = 1 --update will be called once per second
local efm_data_bus = get_efm_data_bus()

if make_default_activity then
    make_default_activity(update_time_step)
end

function update()
end

function post_initialize()
    str_ptr = string.sub(tostring(dev.link),10)
    efm_data_bus.fm_setIntercomPTR(str_ptr)
    --print_message_to_user(str_ptr)
end

function SetCommand(command,value)
    print_message_to_user("SetCommand in intercom: "..tostring(command).."="..tostring(value))
end
  

need_to_be_closed = false -- close lua state after initialization

