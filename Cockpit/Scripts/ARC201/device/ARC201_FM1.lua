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
local paramFreq = get_param_handle("ARC201_FM1_FREQ")
local paramDisplayFreq = get_param_handle("ARC201_FM1_FREQ_DISPLAY")
local paramMode = get_param_handle("ARC201_FM1_MODE")
local paramHomingEnabled = get_param_handle("ARC201_FM1_HOMING_ENABLED")
local displayString = "30000"
local manualFreq = 30e6
local radioDevice = nil
local canEnterData = false
local pwrMode = 0
local presetMode = 0
local presets = nil
local rcvMode = 0

function post_initialize()
    dev:performClickableAction(device_commands.fm1Volume, 1, false)
    dev:performClickableAction(device_commands.fm1ModeSelector, 0.02, false)
	local dev = GetSelf()
    radioDevice = GetDevice(devices.FM1_RADIO)
    presets = get_aircraft_mission_data("Radio")[1].channels
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.fm1FunctionSelector, .02, false)
    elseif birth=="GROUND_COLD" then
    end
end

dev:listen_command(device_commands.fm1PresetSelector)
dev:listen_command(device_commands.fm1FunctionSelector)
dev:listen_command(device_commands.fm1PwrSelector)
dev:listen_command(device_commands.fm1ModeSelector)
dev:listen_command(device_commands.fm1Volume)

dev:listen_command(device_commands.fm1Btn1)
dev:listen_command(device_commands.fm1Btn2)
dev:listen_command(device_commands.fm1Btn3)
dev:listen_command(device_commands.fm1Btn4)
dev:listen_command(device_commands.fm1Btn5)
dev:listen_command(device_commands.fm1Btn6)
dev:listen_command(device_commands.fm1Btn7)
dev:listen_command(device_commands.fm1Btn8)
dev:listen_command(device_commands.fm1Btn9)
dev:listen_command(device_commands.fm1Btn0)
dev:listen_command(device_commands.fm1BtnClr)
dev:listen_command(device_commands.fm1BtnEnt)
dev:listen_command(device_commands.fm1BtnFreq)
dev:listen_command(device_commands.fm1BtnErfOfst)
dev:listen_command(device_commands.fm1BtnTime)

dev:listen_command(Keys.fm1FunctionSelectorInc)
dev:listen_command(Keys.fm1FunctionSelectorDec)
dev:listen_command(Keys.fm1FunctionSelectorCycle)
dev:listen_command(Keys.fm1PresetSelectorInc)
dev:listen_command(Keys.fm1PresetSelectorDec)
dev:listen_command(Keys.fm1PresetSelectorCycle)

local FM1paramFreq = get_param_handle("ARC201FM1param")

--[[
dev:listen_command(Keys.fm1PwrSelectorInc)
dev:listen_command(Keys.fm1PwrSelectorDec)
dev:listen_command(Keys.fm1PwrSelectorCycle)
dev:listen_command(Keys.fm1fm2ModeSelectorInc)
dev:listen_command(Keys.fm1fm2ModeSelectorDec)
dev:listen_command(Keys.fm1fm2ModeSelectorCycle)
]]


function SetCommand(command,value)

    if command == device_commands.fm1FunctionSelector then
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
    elseif command == Keys.fm1FunctionSelectorInc and pwrMode < 8 then
        --print_message_to_user(pwrMode) -- results in whole digits 0 to 8
        dev:performClickableAction(device_commands.fm1FunctionSelector, pwrMode / 100 + 0.01, false)
    elseif command == Keys.fm1FunctionSelectorDec and pwrMode > 0 then
        dev:performClickableAction(device_commands.fm1FunctionSelector, pwrMode / 100 - 0.01, false)
    elseif command == Keys.fm1FunctionSelectorCycle then
        pwrMode = pwrMode + 1
        if pwrMode > 8 then
            pwrMode = 0
        end
        dev:performClickableAction(device_commands.fm1FunctionSelector, pwrMode / 100, false)
    elseif command == device_commands.fm1PresetSelector then
        presetMode = round(value * 100)
        updatePresetMode()
    elseif command == device_commands.fm1ModeSelector then
        rcvMode = round(value * 100)
    elseif command == Keys.fm1PresetSelectorInc and presetMode < 7 then
        dev:performClickableAction(device_commands.fm1PresetSelector, presetMode / 100 + 0.01, false)
    elseif command == Keys.fm1PresetSelectorDec and presetMode > 0 then
        dev:performClickableAction(device_commands.fm1PresetSelector, presetMode / 100 - 0.01, false)
    elseif command == Keys.fm1PresetSelectorCycle then
        presetMode = presetMode + 1
        if presetMode > 7 then
            presetMode = 0
        end
        dev:performClickableAction(device_commands.fm1PresetSelector, presetMode / 100, false)
    else
        if value > 0 then
            if command == device_commands.fm1Btn1 then
                handleValueEntry("1")
            elseif command == device_commands.fm1Btn2 then
                handleValueEntry("2")
            elseif command == device_commands.fm1Btn3 then
                handleValueEntry("3")
            elseif command == device_commands.fm1Btn4 then
                handleValueEntry("4")
            elseif command == device_commands.fm1Btn5 then
                handleValueEntry("5")
            elseif command == device_commands.fm1Btn6 then
                handleValueEntry("6")
            elseif command == device_commands.fm1Btn7 then
                handleValueEntry("7")
            elseif command == device_commands.fm1Btn8 then
                handleValueEntry("8")
            elseif command == device_commands.fm1Btn9 then
                handleValueEntry("9")
            elseif command == device_commands.fm1Btn0 then
                handleValueEntry("0")
            elseif command == device_commands.fm1BtnFreq then
                handleFnBtn("FREQ")
            elseif command == device_commands.fm1BtnClr then
                handleFnBtn("CLR")
            elseif command == device_commands.fm1BtnEnt then
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
	FM1paramFreq:set(manualFreq)
        canEnterData = false
    end
end

function updateReceiverMode()
    if rcvMode == 0 then
        paramHomingEnabled:set(1)
    else
        paramHomingEnabled:set(0)
    end
end

function updatePresetMode()
    if presetMode > 0 and presetMode < 7 then
        if hasPower and pwrMode > 1 then
            paramMode:set(1)
        end
        canEnterData = false
        displayString = tostring(presets[presetMode] * 1e3)
        --printsec(presets[presetMode] * 1e6)
        radioDevice:set_frequency(presets[presetMode] * 1e6)
	FM1paramFreq:set(presets[presetMode] * 1e6)
    elseif presetMode == 7 then
        paramMode:set(0)
    else
        if hasPower and pwrMode > 1 then
            paramMode:set(1)
        end
        displayString = tostring(manualFreq / 1e3)
        radioDevice:set_frequency(manualFreq)
	FM1paramFreq:set(manualFreq)
        --printsec(manualFreq)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    updateReceiverMode()
    hasPower = paramCB_VHFFM1:get() > 0
    if displayString ~= "" then
        paramFreq:set(tonumber(displayString) * 1e3)
    end
    paramDisplayFreq:set(formatPrecedingUnderscores(displayString, 5).."@")
end

need_to_be_closed = false
