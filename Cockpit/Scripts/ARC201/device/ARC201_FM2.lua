dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local Terrain = require('terrain')
local update_time_step = 0.1  
make_default_activity(update_time_step)

local hasPower = false
local paramFreq = get_param_handle("ARC201_FM2_FREQ")
local paramMode = get_param_handle("ARC201_FM2_MODE")
local displayString = "30000"
local manualFreq = 30e6
local radioDevice = nil
local canEnterData = false
local pwrMode = 0
local presetMode = 0
local presets = nil

function post_initialize()
    dev:performClickableAction(device_commands.fm2Volume, 1, false)
	local dev = GetSelf()
    radioDevice = GetDevice(devices.FM2_RADIO)
    presets = get_aircraft_mission_data("Radio")[4].channels
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.fm2FunctionSelector, .02, false)
    elseif birth=="GROUND_COLD" then
    end
end

dev:listen_command(device_commands.fm2PresetSelector)
dev:listen_command(device_commands.fm2FunctionSelector)
dev:listen_command(device_commands.fm2PwrSelector)
dev:listen_command(device_commands.fm2ModeSelector)
dev:listen_command(device_commands.fm2Volume)

dev:listen_command(device_commands.fm2Btn1)
dev:listen_command(device_commands.fm2Btn2)
dev:listen_command(device_commands.fm2Btn3)
dev:listen_command(device_commands.fm2Btn4)
dev:listen_command(device_commands.fm2Btn5)
dev:listen_command(device_commands.fm2Btn6)
dev:listen_command(device_commands.fm2Btn7)
dev:listen_command(device_commands.fm2Btn8)
dev:listen_command(device_commands.fm2Btn9)
dev:listen_command(device_commands.fm2Btn0)
dev:listen_command(device_commands.fm2BtnClr)
dev:listen_command(device_commands.fm2BtnEnt)
dev:listen_command(device_commands.fm2BtnFreq)
dev:listen_command(device_commands.fm2BtnErfOfst)
dev:listen_command(device_commands.fm2BtnTime)

dev:listen_command(Keys.fm2FunctionSelectorInc)
dev:listen_command(Keys.fm2FunctionSelectorDec)
dev:listen_command(Keys.fm2FunctionSelectorCycle)
dev:listen_command(Keys.fm2PresetSelectorInc)
dev:listen_command(Keys.fm2PresetSelectorDec)
dev:listen_command(Keys.fm2PresetSelectorCycle)

local FM2paramFreq = get_param_handle("ARC201FM2param")

--[[
dev:listen_command(Keys.fm2PwrSelectorInc)
dev:listen_command(Keys.fm2PwrSelectorDec)
dev:listen_command(Keys.fm2PwrSelectorCycle)
dev:listen_command(Keys.fm2ModeSelectorInc)
dev:listen_command(Keys.fm2ModeSelectorDec)
dev:listen_command(Keys.fm2ModeSelectorCycle)
]]

function SetCommand(command,value)

    if command == device_commands.fm2FunctionSelector then
        pwrMode = round(value * 100)
        if pwrMode == 0 then
            canEnterData = false
            paramMode:set(0)
        else
            paramMode:set(1)

            if pwrMode == 1 then
                displayString = "00000"
            else
                updatePresetMode()
            end
        end
    elseif command == Keys.fm2FunctionSelectorInc and pwrMode < 8 then
        --print_message_to_user(pwrMode) -- results in whole digits 0 to 8
        dev:performClickableAction(device_commands.fm2FunctionSelector, pwrMode / 100 + 0.01, false)
    elseif command == Keys.fm2FunctionSelectorDec and pwrMode > 0 then
        dev:performClickableAction(device_commands.fm2FunctionSelector, pwrMode / 100 - 0.01, false)
    elseif command == Keys.fm2FunctionSelectorCycle then
        pwrMode = pwrMode + 1
        if pwrMode > 8 then
            pwrMode = 0
        end
        dev:performClickableAction(device_commands.fm2FunctionSelector, pwrMode / 100, false)
    elseif command == device_commands.fm2PresetSelector then
        presetMode = round(value * 100)
        updatePresetMode()
    elseif command == Keys.fm2PresetSelectorInc and presetMode < 7 then
        dev:performClickableAction(device_commands.fm2PresetSelector, presetMode / 100 + 0.01, false)
    elseif command == Keys.fm2PresetSelectorDec and presetMode > 0 then
        dev:performClickableAction(device_commands.fm2PresetSelector, presetMode / 100 - 0.01, false)
    elseif command == Keys.fm2PresetSelectorCycle then
        presetMode = presetMode + 1
        if presetMode > 7 then
            presetMode = 0
        end
        dev:performClickableAction(device_commands.fm2PresetSelector, presetMode / 100, false)
    else
        if value > 0 then
            if command == device_commands.fm2Btn1 then
                handleValueEntry("1")
            elseif command == device_commands.fm2Btn2 then
                handleValueEntry("2")
            elseif command == device_commands.fm2Btn3 then
                handleValueEntry("3")
            elseif command == device_commands.fm2Btn4 then
                handleValueEntry("4")
            elseif command == device_commands.fm2Btn5 then
                handleValueEntry("5")
            elseif command == device_commands.fm2Btn6 then
                handleValueEntry("6")
            elseif command == device_commands.fm2Btn7 then
                handleValueEntry("7")
            elseif command == device_commands.fm2Btn8 then
                handleValueEntry("8")
            elseif command == device_commands.fm2Btn9 then
                handleValueEntry("9")
            elseif command == device_commands.fm2Btn0 then
                handleValueEntry("0")
            elseif command == device_commands.fm2BtnFreq then
                handleFnBtn("FREQ")
            elseif command == device_commands.fm2BtnClr then
                handleFnBtn("CLR")
            elseif command == device_commands.fm2BtnEnt then
                handleFnBtn("ENT")
            end
        end
    end
end

function handleValueEntry(value)
    if hasPower and pwrMode > 1 and canEnterData and presetMode == 0 then
        if string.len(displayString) < 5 then
            displayString = displayString..value
        end
    end
end

function handleFnBtn(value)
     if hasPower then
        if pwrMode > 1 then
            if value == "FREQ" then
                if canEnterData == false then
                    canEnterData = true
                    displayString = ""
                end
            elseif value == "ENT" then
                if canEnterData then
                    enterNewFreq()
                end
            elseif value == "CLR" then
                if canEnterData then
                    displayString = displayString:sub(1, #displayString-1)
                end
            end
        end
    end
end

function enterNewFreq()
    local newFreq = tonumber(displayString) * 1e3
    if newFreq >= 30e6 and newFreq <= 87.975e6 then
        manualFreq = newFreq
        radioDevice:set_frequency(manualFreq)
	FM2paramFreq:set(manualFreq)
        canEnterData = false
    end
end

function updatePresetMode()
    if presetMode > 0 and presetMode < 7 then
        if hasPower and pwrMode > 1 then
            paramMode:set(1)
        end
        canEnterData = false
        displayString = tostring(presets[presetMode] * 1e3)
        radioDevice:set_frequency(presets[presetMode] * 1e6)
	FM2paramFreq:set(presets[presetMode] * 1e6)
    elseif presetMode == 7 then
        paramMode:set(0)
    else
        if hasPower and pwrMode > 1 then
            paramMode:set(1)
        end
        displayString = tostring(manualFreq / 1e3)
        radioDevice:set_frequency(manualFreq)
	FM2paramFreq:set(manualFreq)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    hasPower = paramCB_VHFFM1:get() > 0
    paramFreq:set(formatPrecedingUnderscores(displayString, 5).."@")
end

need_to_be_closed = false
