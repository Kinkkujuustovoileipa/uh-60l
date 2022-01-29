dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local Terrain = require('terrain')
local update_time_step = 0.1  
make_default_activity(update_time_step)

local volume = 0
local freq10MHz = 3
local freq1MHz = 0
local freq100KHz = 0
local freq25KHz = 0

local freqSelectIndex = 0
local modeIndex = 0
local presetIndex = 1

local frequency = 30e6
local oldFreq = 30e6

local radioDevice = nil

function post_initialize()
    dev:performClickableAction(device_commands.arc186Volume, 1, false)
	local dev = GetSelf()
    radioDevice = GetDevice(devices.VHF_RADIO)
    presets = get_aircraft_mission_data("Radio")[3].channels
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.arc186FreqSelector, 2/3, false)
        dev:performClickableAction(device_commands.arc186ModeSelector, .5, false)
    elseif birth=="GROUND_COLD" then
    end
end

dev:listen_command(device_commands.arc186Volume)
dev:listen_command(device_commands.arc186Tone)
dev:listen_command(device_commands.arc186Selector10MHz)
dev:listen_command(device_commands.arc186Selector1MHz)
dev:listen_command(device_commands.arc186Selector100KHz)
dev:listen_command(device_commands.arc186Selector25KHz)
dev:listen_command(device_commands.arc186FreqSelector)
dev:listen_command(device_commands.arc186Load)
dev:listen_command(device_commands.arc186PresetSelector)
dev:listen_command(device_commands.arc186ModeSelector)

function SetCommand(command,value)
    if command == device_commands.arc186Volume then
        volume = value
    elseif command == device_commands.arc186Tone then
    elseif command == device_commands.arc186Selector10MHz then
        freq10MHz = round(value * 12) + 3
        --print_message_to_user(value..":"..freq10MHz)
    elseif command == device_commands.arc186Selector1MHz then
        freq1MHz = round(value * 10)
        --print_message_to_user(value..":"..freq1MHz)
    elseif command == device_commands.arc186Selector100KHz then
        freq100KHz = round(value * 10)
        --print_message_to_user(value..":"..freq100KHz)
    elseif command == device_commands.arc186Selector25KHz then
        freq25KHz = round(value * 4)
        --print_message_to_user(value..":"..freq25KHz)
    elseif command == device_commands.arc186FreqSelector then
        freqSelectIndex = round(value * 4)
        --print_message_to_user(value..":"..freqSelectIndex)
    elseif command == device_commands.arc186Load then
        if value > 0 then
            presets[presetIndex] = (freq10MHz * 10e6 + freq1MHz * 1e6 + freq100KHz * 100e3 + freq25KHz * 25e3) / 1e6
        end
    elseif command == device_commands.arc186PresetSelector then
        presetIndex = round(value * 20) + 1
        --print_message_to_user(value..":"..presetIndex)
    elseif command == device_commands.arc186ModeSelector then
        modeIndex = round(value * 2)
        --print_message_to_user(value..":"..modeIndex)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    local hasPower = paramCB_VHFAM:get() > 0
    if hasPower and modeIndex == 1 then
        if freqSelectIndex == 0 then
            frequency = 121.5e6
            -- TODO FM Modulation
        elseif freqSelectIndex == 1 then
            frequency = 121.5e6
            -- TODO AM Modulation
        elseif freqSelectIndex == 3 then
            frequency = freq10MHz * 10e6 + freq1MHz * 1e6 + freq100KHz * 100e3 + freq25KHz * 25e3
        elseif freqSelectIndex == 4 then
            if presets[presetIndex] then
                frequency = presets[presetIndex] * 1e6
            else
                frequency = 0
            end
        end
    else
        frequency = 0
    end
    
    if frequency ~= oldFreq then
        radioDevice:set_frequency(frequency)
        --print_message_to_user(frequency)
        oldFreq = frequency
    end
end

need_to_be_closed = false
