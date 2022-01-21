dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.1  
make_default_activity(update_time_step)

local paramHdgMode = get_param_handle("CIS_MODE_HDG")
local paramNavMode = get_param_handle("CIS_MODE_NAV")
local paramAltMode = get_param_handle("CIS_MODE_ALT")

dev:listen_command(device_commands.PilotCISHdgToggle)
dev:listen_command(device_commands.PilotCISNavToggle)
dev:listen_command(device_commands.PilotCISAltToggle)

function SetCommand(command,value)
    -- Main CIS modes shouldn't function without power
    local hasPower = paramCB_PLTMODESEL:get() > 0
        if hasPower then
        if command == device_commands.PilotCISHdgToggle then
            paramHdgMode:set(value)
        elseif command == device_commands.PilotCISNavToggle then
            paramNavMode:set(value)
        elseif command == device_commands.PilotCISAltToggle then
            paramAltMode:set(value)
        end
    end
end

function update()

end

need_to_be_closed = false
