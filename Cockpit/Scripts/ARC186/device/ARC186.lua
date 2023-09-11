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
dev:listen_command(Keys.arc186Selector10MHzInc)
dev:listen_command(Keys.arc186Selector1MHzInc)
dev:listen_command(Keys.arc186Selector100KHzInc)
dev:listen_command(Keys.arc186Selector25KHzInc)
dev:listen_command(Keys.arc186FreqSelectorInc)
dev:listen_command(Keys.arc186PresetSelectorInc)
dev:listen_command(Keys.arc186ModeSelectorInc)
dev:listen_command(Keys.arc186Selector10MHzDec)
dev:listen_command(Keys.arc186Selector1MHzDec)
dev:listen_command(Keys.arc186Selector100KHzDec)
dev:listen_command(Keys.arc186Selector25KHzDec)
dev:listen_command(Keys.arc186FreqSelectorDec)
dev:listen_command(Keys.arc186PresetSelectorDec)
dev:listen_command(Keys.arc186ModeSelectorDec)

local ARC186paramFreq = get_param_handle("ARC186param")

function SetCommand(command,value)
    if command == device_commands.arc186Volume then
        volume = value
    elseif command == device_commands.arc186Tone then
    elseif command == device_commands.arc186Selector10MHz then
        freq10MHz = round(value * 12) + 3
        --print_message_to_user(value..":"..freq10MHz)
    elseif command == Keys.arc186Selector10MHzInc then
        freq10MHz = ((freq10MHz - 3) / 12) + (1/12)
        if freq10MHz > 1 then
            freq10MHz = 0
        end
        --print_message_to_user(freq10MHz)
        dev:performClickableAction(device_commands.arc186Selector10MHz, freq10MHz, false)
    elseif command == Keys.arc186Selector10MHzDec then
        freq10MHz = ((freq10MHz - 3) / 12) - (1/12)
        --print_message_to_user(freq10MHz)
        if freq10MHz < 0 then
            freq10MHz = 1
        end
        dev:performClickableAction(device_commands.arc186Selector10MHz, freq10MHz, false)
    elseif command == device_commands.arc186Selector1MHz then
        freq1MHz = round(value * 10)
        --print_message_to_user(value..":"..freq1MHz)
    elseif command == Keys.arc186Selector1MHzInc then
        --print_message_to_user(freq1MHz)
        if freq1MHz == 9 then
            freq1MHz = -1
        end
        dev:performClickableAction(device_commands.arc186Selector1MHz , freq1MHz / 10 + 0.1, false)
    elseif command == Keys.arc186Selector1MHzDec then
        if freq1MHz == 0 then
            freq1MHz = 10
        end
        dev:performClickableAction(device_commands.arc186Selector1MHz , freq1MHz / 10 - 0.1, false)
    elseif command == device_commands.arc186Selector100KHz then
        freq100KHz = round(value * 10)
        --print_message_to_user(value..":"..freq100KHz)

    elseif command == Keys.arc186Selector100KHzInc then
        --print_message_to_user(freq100KHz)
        if freq100KHz == 9 then
            freq100KHz = -1
        end
        dev:performClickableAction(device_commands.arc186Selector100KHz , freq100KHz / 10 + 0.1, false)
        --print_message_to_user(freq100KHz/100 + 0.1)
        --print_message_to_user(value..":"..freq100KHz)
    elseif command == Keys.arc186Selector100KHzDec then
        --print_message_to_user(freq100KHz)
        if freq100KHz == 0 then
            freq100KHz = 10
        end
        dev:performClickableAction(device_commands.arc186Selector100KHz, freq100KHz / 10 - 0.1, false)
        --print_message_to_user(value..":"..freq100KHz)
        --print_message_to_user(freq100KHz/100 - 0.1)
    elseif command == device_commands.arc186Selector25KHz then
        freq25KHz = round(value * 4)
        --print_message_to_user(value..":"..freq25KHz)
    elseif command == Keys.arc186Selector25KHzInc then
        --print_message_to_user(value..":"..freq25KHz)
        freq25KHz = freq25KHz / 4 + 0.25
        if freq25KHz > 0.76 then
            freq25KHz = 0
        end
        dev:performClickableAction(device_commands.arc186Selector25KHz, freq25KHz, false)
    elseif command == Keys.arc186Selector25KHzDec then
        --print_message_to_user(value..":"..freq25KHz)
        freq25KHz = freq25KHz / 4 - 0.25
        if freq25KHz < 0 then
            freq25KHz = 1
        end
        dev:performClickableAction(device_commands.arc186Selector25KHz, freq25KHz, false)
    elseif command == device_commands.arc186FreqSelector then
        freqSelectIndex = round(value * 3)
        --print_message_to_user(value..":"..freqSelectIndex)
    elseif command == Keys.arc186FreqSelectorInc and freqSelectIndex < 3 then
        freqSelectIndex = freqSelectIndex / 3 + 0.333
        if freqSelectIndex > 0.7 then
            freqSelectIndex = 1
        end
        dev:performClickableAction(device_commands.arc186FreqSelector, freqSelectIndex, false)
    elseif command == Keys.arc186FreqSelectorDec and freqSelectIndex > 0 then
        freqSelectIndex = freqSelectIndex / 3 - 0.333
        if freqSelectIndex < 0 then
            freqSelectIndex = 0
        end
        dev:performClickableAction(device_commands.arc186FreqSelector, freqSelectIndex, false)
    elseif command == device_commands.arc186Load then
        if value > 0 then
            presets[presetIndex] = (freq10MHz * 10e6 + freq1MHz * 1e6 + freq100KHz * 100e3 + freq25KHz * 25e3) / 1e6
        end
    elseif command == device_commands.arc186PresetSelector then
        presetIndex = round(value * 20) + 1
        --print_message_to_user(value..":"..presetIndex)
    elseif command == Keys.arc186PresetSelectorInc then
        --print_message_to_user(presetIndex)
        presetIndex = (presetIndex / 20)
        if presetIndex > 0.95 then
            presetIndex = 0
        end
        dev:performClickableAction(device_commands.arc186PresetSelector, presetIndex, false)
    elseif command == Keys.arc186PresetSelectorDec then
        presetIndex = (presetIndex / 20) - 0.05 - 0.05
        if presetIndex < 0 then
            presetIndex = 0.95
        end
        dev:performClickableAction(device_commands.arc186PresetSelector, presetIndex, false)
        --print_message_to_user(presetIndex)
    elseif command == device_commands.arc186ModeSelector then
        modeIndex = round(value * 2)
        --print_message_to_user(value..":"..modeIndex)
    elseif command == Keys.arc186ModeSelectorInc then
        modeIndex = modeIndex + 1
        if modeIndex > 2 then
            modeIndex = 2
        end
        dev:performClickableAction(device_commands.arc186ModeSelector, modeIndex / 2, false)
    elseif command == Keys.arc186ModeSelectorDec then
        modeIndex = modeIndex - 1
        if modeIndex < 0 then
            modeIndex = 0
        end
        dev:performClickableAction(device_commands.arc186ModeSelector, modeIndex / 2, false)
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
        elseif freqSelectIndex == 2 then
            frequency = freq10MHz * 10e6 + freq1MHz * 1e6 + freq100KHz * 100e3 + freq25KHz * 25e3
        elseif freqSelectIndex == 3 then
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
	ARC186paramFreq:set(frequency)
        --print_message_to_user(frequency)
        oldFreq = frequency
    end
end

need_to_be_closed = false
