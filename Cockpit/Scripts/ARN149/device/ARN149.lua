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
local toneTest = 0
local powerInt = 0

local lastFrequency = -1
local radioDevice

dev:listen_command(device_commands.arn149Preset)
dev:listen_command(device_commands.arn149ToneTest)
dev:listen_command(device_commands.arn149Volume)
dev:listen_command(device_commands.arn149Power)
dev:listen_command(device_commands.arn149thousands)
dev:listen_command(device_commands.arn149hundreds)
dev:listen_command(device_commands.arn149tens)
dev:listen_command(device_commands.arn149ones)
dev:listen_command(device_commands.arn149tenths)

dev:listen_command(Keys.arn149PresetCycle)
--dev:listen_command(Keys.arn149ToneTestCycle)
dev:listen_command(Keys.arn149PowerCycle)
dev:listen_command(Keys.arn149thousandsCycle)
dev:listen_command(Keys.arn149hundredsCycle)
dev:listen_command(Keys.arn149tensCycle)
dev:listen_command(Keys.arn149onesCycle)
dev:listen_command(Keys.arn149tenthsCycle)


function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    radioDevice = GetDevice(devices.ADF_RADIO)

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
        toneTest = value
    elseif command == device_commands.arn149Volume then
        volume = value
    elseif command == device_commands.arn149Power then
        --print_message_to_user(value)
        powerInt = value
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
    elseif command == Keys.arn149PresetCycle then
        if value > 0 then -- increase
            local tempNumber = clamp(presetMode - 1, 0, 2)
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149Preset, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(presetMode + 1, 0, 2)
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149Preset, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = presetMode - 1
            if tempNumber < 0 then tempNumber = 2 end
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149Preset, tempNumber, false)
        end
        --[[
    elseif command == Keys.arn149ToneTestCycle then
        --print_message_to_user("arn149ToneTestCycle")
        if value > 0 then -- increase
            local tempNumber = clamp(toneTest + 1, -1, 1)
            dev:performClickableAction(device_commands.arn149ToneTest, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(toneTest - 1, -1, 1)
            dev:performClickableAction(device_commands.arn149ToneTest, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = toneTest + 1
            if tempNumber > 1 then tempNumber = -1 end
            dev:performClickableAction(device_commands.arn149ToneTest, tempNumber, false)
        end
        ]]
    elseif command == Keys.arn149PowerCycle then
        --print_message_to_user("arn149PowerCycle")
        if value > 0 then -- increase
            local tempNumber = clamp(powerInt + 0.5, 0, 1)
            dev:performClickableAction(device_commands.arn149Power, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(powerInt - 0.5, 0, 1)
            dev:performClickableAction(device_commands.arn149Power, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = powerInt + 0.5
            if tempNumber > 1 then tempNumber = 0 end
            dev:performClickableAction(device_commands.arn149Power, tempNumber, false)
        end
    elseif command == Keys.arn149thousandsCycle then
        if value > 0 then -- increase
            local tempNumber = clamp(thousands + 1, 0, 2)
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149thousands, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(thousands - 1, 0, 2)
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149thousands, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = thousands + 1
            if tempNumber > 2 then tempNumber = 0 end
            tempNumber = tempNumber / 2
            dev:performClickableAction(device_commands.arn149thousands, tempNumber, false)
        end
    elseif command == Keys.arn149hundredsCycle then -- working
        if value > 0 then -- increase
            local tempNumber = clamp(hundreds + 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149hundreds, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(hundreds - 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149hundreds, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = hundreds + 1
            if tempNumber > 9 then tempNumber = 0 end
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149hundreds, tempNumber, false)
        end
    elseif command == Keys.arn149tensCycle then 
        if value > 0 then -- increase
            local tempNumber = clamp(tens + 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tens, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(tens - 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tens, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = tens + 1
            if tempNumber > 9 then tempNumber = 0 end
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tens, tempNumber, false)
        end
    elseif command == Keys.arn149onesCycle then
        if value > 0 then -- increase
            local tempNumber = clamp(ones + 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149ones, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(ones - 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149ones, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = ones + 1
            if tempNumber > 9 then tempNumber = 0 end
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149ones, tempNumber, false)
        end
    elseif command == Keys.arn149tenthsCycle then
        if value > 0 then -- increase
            local tempNumber = clamp(tenths + 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tenths, tempNumber, false)
        elseif value < 0 then -- decrease
            local tempNumber = clamp(tenths - 1, 0, 9)
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tenths, tempNumber, false)
        else -- value is 0, then cycle
            local tempNumber = tenths + 1
            if tempNumber > 9 then tempNumber = 0 end
            tempNumber = tempNumber / 10
            dev:performClickableAction(device_commands.arn149tenths, tempNumber, false)
        end
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

    if frequency ~= lastFrequency then
        paramARN149Freq:set(frequency)
        radioDevice:set_frequency(frequency)
        lastFrequency = frequency
        --print_message_to_user(frequency)
    end
end

need_to_be_closed = false
