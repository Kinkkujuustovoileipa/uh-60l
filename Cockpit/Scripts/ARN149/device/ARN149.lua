dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.01  
make_default_activity(update_time_step)

local hasPower = false
local paramARN149Freq = get_param_handle("ARN149_FREQ")
paramARN149Freq:set(0)
local volume = 0
local frequency = 0
local presetMode = 0
local power = false
local adfPower = false
local thousands = 0
local hundreds = 0
local tens = 0
local ones = 0
local tenths = 0

dev:listen_command(device_commands.arn149Preset)
dev:listen_command(device_commands.arn149ToneTest)
dev:listen_command(device_commands.arn149Volume)
dev:listen_command(device_commands.arn149Power)
dev:listen_command(device_commands.arn149thousands)
dev:listen_command(device_commands.arn149hundreds)
dev:listen_command(device_commands.arn149tens)
dev:listen_command(device_commands.arn149ones)
dev:listen_command(device_commands.arn149tenths)

function post_initialize()
    local cispDevice = GetDevice(devices.CISP)
    local birth = LockOn_Options.init_conditions.birth_place

    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        dev:performClickableAction(device_commands.arn149Power, 1, false)
        dev:performClickableAction(device_commands.arn149Volume, 1, false)		  
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.arn149Power, 0, false)
        dev:performClickableAction(device_commands.arn149Volume, 0, false)
    end
end

function SetCommand(command,value)
    if command == device_commands.arn149Preset then
        presetMode = round(value * 2)
    elseif command == device_commands.arn149ToneTest then
    elseif command == device_commands.arn149Volume then
        volume = value
    elseif command == device_commands.arn149Power then
        if round(value * 2) > 0 then
            power = true
        else
            power = false
        end

        if round(value * 2) > 1 then
            adfPower = true
        else
            adfPower = false
        end
    elseif command == device_commands.arn149thousands then
        thousands = round(value * 2)
    elseif command == device_commands.arn149hundreds then
        hundreds = round(value * 10)
    elseif command == device_commands.arn149tens then
        tens = round(value * 10)
    elseif command == device_commands.arn149ones then
        ones = round(value * 10)
    elseif command == device_commands.arn149tenths then
        tenths = round(value * 10)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    hasPower = paramCB_ADF:get() > 0 and paramCB_26VACINST:get() > 0
    if hasPower and power then
        if presetMode == 0 then
            frequency = thousands * 1000000 + hundreds * 100000 + tens * 10000 + ones * 1000 + tenths * 100
        elseif presetMode == 1 then
            frequency = 2182000
        elseif presetMode == 2 then
            frequency = 500000
        end
    else
        frequency = 0
        volume = 0
    end

    paramARN149Freq:set(frequency)
end

need_to_be_closed = false
