dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")


local dev 	    = GetSelf()
local update_time_step = 0.05 --update will be called 20/second
make_default_activity(update_time_step)

--dev:listen_command(Keys.radio_ptt)

efm_data_bus = get_efm_data_bus()

--Current Radio Values
local mode = 0
local mpgMode = 0
local preset = 1
local frequency = 0
local displayFreq = 0
local lastFreq = 0
local change = false
local volume = 0
local squelch = 0

local freq_Xooooo = 200e6
local freq_oXoooo = 20e6
local freq_ooXooo = 5e6
local freq_oooXoo = 0
local freq_ooooXX = 0

local paramFreq = get_param_handle("ARC164_FREQ")
local paramPreset = get_param_handle("ARC164_PRESET")
local paramMode = get_param_handle("ARC164_MODE")

local uhf_radio_device = nil

local arc164_radio_presets
if get_aircraft_mission_data ~= nil then
end

function post_initialize()
    arc164_radio_presets = get_aircraft_mission_data("Radio")[2].channels

    for i=1,20 do
        get_param_handle("ARC164_PRESET_"..i):set(arc164_radio_presets[i])
    end

    --print_message_to_user(Dump(get_aircraft_mission_data("Radio")))
    uhf_radio_device = GetDevice(devices.UHF_RADIO)
	dev:performClickableAction(device_commands.arc164_volume, 1, false)

	dev:performClickableAction(device_commands.arc164_freq_Xooooo, 0, false)
	dev:performClickableAction(device_commands.arc164_freq_oXoooo, 0.2, false)
	dev:performClickableAction(device_commands.arc164_freq_ooXooo, 0.5, false)
	dev:performClickableAction(device_commands.arc164_freq_oooXoo, 0, false)
	dev:performClickableAction(device_commands.arc164_freq_ooooXX, 0, false)
    
    local birth = LockOn_Options.init_conditions.birth_place
    
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        dev:performClickableAction(device_commands.arc164_mode, 0.01, false)
    elseif birth == "GROUND_COLD" then

    end
end

dev:listen_command(device_commands.arc164_mode)
dev:listen_command(device_commands.arc164_xmitmode)
dev:listen_command(device_commands.arc164_volume)
dev:listen_command(device_commands.arc164_squelch)
dev:listen_command(device_commands.arc164_freq_preset)
dev:listen_command(device_commands.arc164_freq_Xooooo)
dev:listen_command(device_commands.arc164_freq_oXoooo)
dev:listen_command(device_commands.arc164_freq_ooXooo)
dev:listen_command(device_commands.arc164_freq_oooXoo)
dev:listen_command(device_commands.arc164_freq_ooooXX)
dev:listen_command(device_commands.arc164_preset)
dev:listen_command(Keys.arc164_presetInc)
dev:listen_command(Keys.arc164_presetDec)
dev:listen_command(Keys.arc164_freq_XoooooInc)
dev:listen_command(Keys.arc164_freq_XoooooDec)
dev:listen_command(Keys.arc164_freq_oXooooInc)
dev:listen_command(Keys.arc164_freq_oXooooDec)
dev:listen_command(Keys.arc164_freq_ooXoooInc)
dev:listen_command(Keys.arc164_freq_ooXoooDec)
dev:listen_command(Keys.arc164_freq_oooXooInc)
dev:listen_command(Keys.arc164_freq_oooXooDec)
dev:listen_command(Keys.arc164_freq_ooooXXInc)
dev:listen_command(Keys.arc164_freq_ooooXXDec)
dev:listen_command(Keys.arc164_modeInc)
dev:listen_command(Keys.arc164_modeDec)
dev:listen_command(Keys.arc164_xmitmodeInc)
dev:listen_command(Keys.arc164_xmitmodeDec)
dev:listen_command(Keys.arc164_modeCycle)
dev:listen_command(Keys.arc164_xmitmodeCycle)


function SetCommand(command,value)   
    if command == device_commands.arc164_mode then
        mode = round(value * 100)
    elseif command == Keys.arc164_modeInc and mode < 3 then
        dev:performClickableAction(device_commands.arc164_mode, clamp(mode * 0.01 + 0.01, 0, 0.03), false)
		--print_message_to_user(mode)
    elseif command == Keys.arc164_modeDec and mode > 0 then
        dev:performClickableAction(device_commands.arc164_mode, clamp(mode * 0.01 - 0.01, 0, 0.03), false)
		--print_message_to_user(mode)
    elseif command == Keys.arc164_modeCycle then
        mode = mode + 1
        if mode > 3 then
            mode = 0
        end
        dev:performClickableAction(device_commands.arc164_mode, mode * 0.01, false)
    elseif command == device_commands.arc164_xmitmode then
        mpgMode = round(value * 100)
    elseif command == Keys.arc164_xmitmodeInc and mpgMode < 2 then
        dev:performClickableAction(device_commands.arc164_xmitmode, clamp(mpgMode * 0.01 + 0.01, 0, 0.02), false)
		--print_message_to_user(mpgMode)
    elseif command == Keys.arc164_xmitmodeDec and mpgMode > 0 then
        dev:performClickableAction(device_commands.arc164_xmitmode, clamp(mpgMode * 0.01 - 0.01, 0, 0.02), false)
		--print_message_to_user(mpgMode)
    elseif command == Keys.arc164_xmitmodeCycle then
        mpgMode = mpgMode + 1
        if mpgMode > 2 then
            mpgMode = 0
        end
        dev:performClickableAction(device_commands.arc164_xmitmode, mpgMode * 0.01, false)
    elseif command == device_commands.arc164_volume then
        volume = round(value * 100)
    elseif command == device_commands.arc164_squelch then
    elseif command == device_commands.arc164_freq_preset then
        preset = round(value * 100)
    elseif command == device_commands.arc164_freq_Xooooo then
        freq_Xooooo = round(value * 10) * 100e6 + 200e6
        --print_message_to_user(value.." "..freq_Xooooo)
    elseif command == Keys.arc164_freq_XoooooInc then
        --print_message_to_user("pre freq_Xooooo " .. freq_Xooooo)
        dev:performClickableAction(device_commands.arc164_freq_Xooooo, clamp(freq_Xooooo * 0.0000000001 + 0.1, 0, 0.1), false)
    elseif command == Keys.arc164_freq_XoooooDec then
        --print_message_to_user("pre freq_Xooooo " .. freq_Xooooo)
        dev:performClickableAction(device_commands.arc164_freq_Xooooo, clamp(freq_Xooooo * 0.0000000001 - 0.1, 0, 0.1), false)
    elseif command == device_commands.arc164_freq_oXoooo then
        freq_oXoooo = round(value * 10) * 10e6
        --print_message_to_user(value.." "..freq_oXoooo)
    elseif command == Keys.arc164_freq_oXooooInc then
        dev:performClickableAction(device_commands.arc164_freq_oXoooo, clamp(freq_oXoooo * 0.00000001 + 0.1,0,0.9),false)
    elseif command == Keys.arc164_freq_oXooooDec then
        dev:performClickableAction(device_commands.arc164_freq_oXoooo, clamp(freq_oXoooo * 0.00000001 - 0.1,0,0.9),false)
    elseif command == device_commands.arc164_freq_ooXooo then
        freq_ooXooo = round(value * 10) * 1e6
        --print_message_to_user(value.." "..freq_ooXooo)
    elseif command == Keys.arc164_freq_ooXoooInc then
        dev:performClickableAction(device_commands.arc164_freq_ooXooo, clamp(freq_ooXooo * 0.0000001 + 0.1,0,0.9),false)
    elseif command == Keys.arc164_freq_ooXoooDec then
        dev:performClickableAction(device_commands.arc164_freq_ooXooo, clamp(freq_ooXooo * 0.0000001 - 0.1,0,0.9),false)
    elseif command == device_commands.arc164_freq_oooXoo then
        freq_oooXoo = round(value * 10) * 100e3
        --print_message_to_user(value.." "..freq_oooXoo)
    elseif command == Keys.arc164_freq_oooXooInc then
        dev:performClickableAction(device_commands.arc164_freq_oooXoo, clamp(freq_oooXoo * 0.000001 + 0.1,0,0.9),false)
    elseif command == Keys.arc164_freq_oooXooDec then
        dev:performClickableAction(device_commands.arc164_freq_oooXoo, clamp(freq_oooXoo * 0.000001 - 0.1,0,0.9),false)
    elseif command == device_commands.arc164_freq_ooooXX then
        freq_ooooXX = round(value * 10) * 25 * 1e3
        --print_message_to_user(value.." "..freq_ooooXX)
    elseif command == Keys.arc164_freq_ooooXXInc then
        dev:performClickableAction(device_commands.arc164_freq_ooooXX, clamp((freq_ooooXX * 0.0001 / 25) + 0.1,0,0.3),false)
    elseif command == Keys.arc164_freq_ooooXXDec then
        dev:performClickableAction(device_commands.arc164_freq_ooooXX, clamp((freq_ooooXX * 0.0001 / 25) - 0.1,0,0.3),false)
    elseif command == device_commands.arc164_preset then
        preset = round(value * 20) + 1
        --print_message_to_user(value.." "..preset)
	elseif command == Keys.arc164_presetInc and preset < 20 then
        dev:performClickableAction(device_commands.arc164_preset, clamp(preset * 0.05, 0, 0.95), false)
		--print_message_to_user(preset)
    elseif command == Keys.arc164_presetDec and preset > 1 then
        dev:performClickableAction(device_commands.arc164_preset, clamp(preset * 0.05 - 0.1, 0, 0.95), false)
		--print_message_to_user(preset)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    local hasPower = paramCB_UHFAM:get() > 0
    if mode > 0 and hasPower then
        if mpgMode == 0 then
            frequency = freq_Xooooo + freq_oXoooo + freq_ooXooo+ freq_oooXoo + freq_ooooXX
            displayFreq = frequency
        elseif mpgMode == 1 then
            frequency = 225000000 -- using this if no preset set
            if arc164_radio_presets then
                if arc164_radio_presets[preset] then
                    frequency = arc164_radio_presets[preset] * 1000000
                    --print_message_to_user(frequency)
                end
            end
        else
            frequency = 243e6
            displayFreq = frequency
        end
    else
        frequency = 0
    end

    if frequency ~= lastFreq then
        uhf_radio_device:set_frequency(frequency)
        lastFreq = frequency
        --print_message_to_user("ARC-164: "..uhf_radio_device:get_frequency())
    end
    if mode > 0 then
        efm_data_bus.fm_setRadioPower(1.0) 
    else
        efm_data_bus.fm_setRadioPower(0.0)
    end

    paramMode:set(mode)
    -- Freq isn't updated when in preset mode
    paramFreq:set(displayFreq / 1e3)
    paramPreset:set(preset)
end

need_to_be_closed = false -- close lua state after initialization