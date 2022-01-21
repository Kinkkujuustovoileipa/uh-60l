dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.01  
make_default_activity(update_time_step)

paramNeedle = get_param_handle("PILOT_APN209_NEEDLE")
paramDigit1 = get_param_handle("PILOT_APN209_DIGIT1")
paramDigit2 = get_param_handle("PILOT_APN209_DIGIT2")
paramDigit3 = get_param_handle("PILOT_APN209_DIGIT3")
paramDigit4 = get_param_handle("PILOT_APN209_DIGIT4")
paramLoBug = get_param_handle("PILOT_APN209_LOBUG")
paramHiBug = get_param_handle("PILOT_APN209_HIBUG")
paramLoLight = get_param_handle("PILOT_APN209_LOLIGHT")
paramHiLight = get_param_handle("PILOT_APN209_HILIGHT")
paramFlag = get_param_handle("PILOT_APN209_FLAG")

dev:listen_command(device_commands.apn209PilotLoSet)
dev:listen_command(device_commands.apn209PilotHiSet)

radarAltitude = 0
lowAlt = -30
hiAlt = 0
isOn = false

function SetCommand(command,value)
    if command == device_commands.apn209PilotLoSet then
        if lowAlt > 200 then value = value * 5 end
        lowAlt = clamp(lowAlt + value, -30, 1500)
    elseif command == device_commands.apn209PilotHiSet then
        if hiAlt > 200 then value = value * 5 end
        hiAlt = clamp(hiAlt + value, 0, 1500)
    end
end

dofile(LockOn_Options.script_path.."APN209/device/APN209.lua")

function update()
    updateNetworkArgs(GetSelf())
    updateAPN209()
end

need_to_be_closed = false
