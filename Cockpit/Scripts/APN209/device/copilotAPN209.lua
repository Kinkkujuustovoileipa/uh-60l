dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.01  
make_default_activity(update_time_step)

paramNeedle = get_param_handle("COPILOT_APN209_NEEDLE")
paramDigit1 = get_param_handle("COPILOT_APN209_DIGIT1")
paramDigit2 = get_param_handle("COPILOT_APN209_DIGIT2")
paramDigit3 = get_param_handle("COPILOT_APN209_DIGIT3")
paramDigit4 = get_param_handle("COPILOT_APN209_DIGIT4")
paramLoBug = get_param_handle("COPILOT_APN209_LOBUG")
paramHiBug = get_param_handle("COPILOT_APN209_HIBUG")
paramLoLight = get_param_handle("COPILOT_APN209_LOLIGHT")
paramHiLight = get_param_handle("COPILOT_APN209_HILIGHT")
paramFlag = get_param_handle("COPILOT_APN209_FLAG")

dev:listen_command(device_commands.apn209CopilotLoSet)
dev:listen_command(device_commands.apn209CopilotHiSet)
dev:listen_command(Keys.apn209CopilotLoSetInc)
dev:listen_command(Keys.apn209CopilotLoSetDec)
dev:listen_command(Keys.apn209CopilotHiSetInc)
dev:listen_command(Keys.apn209CopilotHiSetDec)

dev:listen_command(Keys.apn209CopilotLoSet_AXIS)
dev:listen_command(Keys.apn209CopilotHiSet_AXIS)

radarAltitude = 0
lowAlt = -30
hiAlt = 0
isOn = false

function SetCommand(command,value)
    if command == device_commands.apn209CopilotLoSet then
        if lowAlt > 200 then value = value * 5 end
        lowAlt = clamp(lowAlt + value, -30, 1500)
    elseif command == device_commands.apn209CopilotHiSet then
        if hiAlt > 200 then value = value * 5 end
        hiAlt = clamp(hiAlt + value, 0, 1500)
    elseif command == Keys.apn209CopilotLoSetInc and lowAlt < 1500 then
        dev:performClickableAction(device_commands.apn209CopilotLoSet, 2.0, false)
    elseif command == Keys.apn209CopilotLoSetDec and lowAlt > -30 then
        dev:performClickableAction(device_commands.apn209CopilotLoSet, -2.0, false)
    elseif command == Keys.apn209CopilotHiSetInc and  hiAlt < 1500 then
        dev:performClickableAction(device_commands.apn209CopilotHiSet, 2.0, false)
    elseif command == Keys.apn209CopilotHiSetDec and hiAlt > -30 then
        dev:performClickableAction(device_commands.apn209CopilotHiSet, -2.0, false)
    elseif command == Keys.apn209CopilotLoSet_AXIS then
        value = value + 1 -- makes all numbers positive, max of 2, min of 1
        if value < 1.5 then 
            -- linear from 0 to 200 using axis range 0 - 1.5
            value = 153 * value - 30
        else
            -- linear from 200 to 1500 using axis range 1.5 - 2.0
            value = 2600 * value - 3700
        end
        lowAlt = clamp(value, -30, 1500)
    elseif command == Keys.apn209CopilotHiSet_AXIS then
        value = value + 1 -- makes all numbers positive, max of 2, min of 1
        if value < 1.5 then 
            -- linear from 0 to 200 using axis range 0 - 1.5
            value = 153 * value - 30
        else
            -- linear from 200 to 1500 using axis range 1.5 - 2.0
            value = 2600 * value - 3700
        end
        hiAlt = clamp(value, -30, 1500)
    end
end

dofile(LockOn_Options.script_path.."APN209/device/APN209.lua")

function update()
    updateNetworkArgs(GetSelf())
    updateAPN209()
end

need_to_be_closed = false
