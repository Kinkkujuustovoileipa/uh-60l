dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.01  
make_default_activity(update_time_step)

local paramARN147Freq = get_param_handle("ARN147_FREQ")
paramARN147Freq:set(0)

local paramARN147MHz100s = get_param_handle("ARN147_MHZ100S")
local paramARN147MHz10s = get_param_handle("ARN147_MHZ10S")
local paramARN147MHz1s = get_param_handle("ARN147_MHZ1S")
local paramARN147KHz100s = get_param_handle("ARN147_KHZ100S")
local paramARN147KHz10s = get_param_handle("ARN147_KHZ10S")
local paramARN147KHz1s = get_param_handle("ARN147_KHZ1S")

local hasPower = false
local power = false
local volume = 0
local frequency = 0
local lastFrequency = -1
local mhz = 108
local mhzKnobPosition = 0
local khz = 0
local khzKnobPosition = 0

local radioDevice

dev:listen_command(device_commands.arn147Power)
dev:listen_command(device_commands.arn147MHz)
dev:listen_command(device_commands.arn147KHz)
dev:listen_command(Keys.arn147MHzInc)
dev:listen_command(Keys.arn147MHzDec)
dev:listen_command(Keys.arn147KHzInc)
dev:listen_command(Keys.arn147KHzDec)
dev:listen_command(Keys.arn147PowerCycle)

function post_initialize()
	local dev = GetSelf()
    radioDevice = GetDevice(devices.VORILS_RADIO)
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.arn147Power, 0, false)
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.arn147Power, -1, false)
    end
end

function SetCommand(command,value)
    if command == device_commands.arn147Power then
        if value == 0 then
            power = true
        else
            power = false
        end
    elseif command == Keys.arn147PowerCycle then
        if power then
            dev:performClickableAction(device_commands.arn147Power, -1, false)
        else
            dev:performClickableAction(device_commands.arn147Power, 0, false)
        end
    elseif command == device_commands.arn147MHz then
        if value > 0 then
            mhz = mhz + 1
        else
            mhz = mhz - 1
        end

        if mhz > 126 then
            mhz = 108
        elseif mhz < 108 then
            mhz = 126
        end
    elseif command == Keys.arn147MHzInc then
        dev:performClickableAction(device_commands.arn147MHz, mhzKnobPosition + 0.1, false)
    elseif command == Keys.arn147MHzDec then
        dev:performClickableAction(device_commands.arn147MHz, mhzKnobPosition - 0.1, false)
    elseif command == device_commands.arn147KHz then
        if value > 0 then
            khz = khz + 25
        else
            khz = khz - 25
        end

        if khz > 975 then
            khz = 0
        elseif khz < 0 then
            khz = 975
        end
    elseif command == Keys.arn147KHzInc then
        dev:performClickableAction(device_commands.arn147KHz, khzKnobPosition + 0.1, false)
    elseif command == Keys.arn147KHzDec then
        dev:performClickableAction(device_commands.arn147KHz, khzKnobPosition - 0.1, false)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    hasPower = paramCB_VORILS:get() > 0
    paramARN147MHz100s:set(getDigit(mhz, 3) / 10)
    paramARN147MHz10s:set(getDigit(mhz, 2) / 10)
    paramARN147MHz1s:set(getDigit(mhz, 1) / 10)
    paramARN147KHz100s:set(getDigit(khz, 3) / 10)
    paramARN147KHz10s:set(getDigit(khz, 2) / 10)
    paramARN147KHz1s:set(getDigit(khz, 1) / 10)


    if hasPower and power then
        frequency = mhz * 1000000 + khz * 1000
    else
        frequency = 0
    end

    if frequency ~= lastFrequency then
        paramARN147Freq:set(frequency)
        radioDevice:set_frequency(frequency)
        lastFrequency = frequency
    end
end

need_to_be_closed = false
