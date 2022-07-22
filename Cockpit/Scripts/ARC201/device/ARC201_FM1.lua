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
local countdownTimer = 0
local blinkTimer = 0
local checkBlink = false
local displayTimeoutEnable = false
local displayMode = "none"

local startSelfTest = false

function post_initialize()
    presets = get_aircraft_mission_data("Radio")[1].channels
    if presets[0] == nil then
        presets[0] = 30
    end
    dev:performClickableAction(device_commands.fm1Volume, 1, false)
    dev:performClickableAction(device_commands.fm1ModeSelector, 0.01, false)
    dev:performClickableAction(device_commands.fm1PresetSelector, 0, false)
    local dev = GetSelf()
    radioDevice = GetDevice(devices.FM1_RADIO)
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        dev:performClickableAction(device_commands.fm1FunctionSelector, .02, false)
        paramDisplayFreq:set(formatTrailingUnderscores(displayString, 5).."@")
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
        if pwrMode == 0 or pwrMode == 7 or pwrMode == 8 then
            canEnterData = false
            paramMode:set(0)
            radioDevice:set_frequency(0)
        else
            paramMode:set(1)

            if pwrMode == 1 then
                startSelfTest = true
            elseif pwrMode == 2 or pwrMode == 3 or pwrMode == 5 then
                setDisplayMode("funcKnob")
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
        --updatePresetMode()
        setDisplayMode("preKnob")
    elseif command == device_commands.fm1ModeSelector then
        rcvMode = round(value * 100)
        --print_message_to_user("Mode displayMode")
        setDisplayMode("modeKnob")
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
                --handleValueEntry("1")
                keypadInput("1")
            elseif command == device_commands.fm1Btn2 then
                --handleValueEntry("2")
                keypadInput("2")
            elseif command == device_commands.fm1Btn3 then
                --handleValueEntry("3")
                keypadInput("3")
            elseif command == device_commands.fm1Btn4 then
                --handleValueEntry("4")
                keypadInput("4")
            elseif command == device_commands.fm1Btn5 then
                --handleValueEntry("5")
                keypadInput("5")
            elseif command == device_commands.fm1Btn6 then
                --handleValueEntry("6")
                keypadInput("6")
            elseif command == device_commands.fm1Btn7 then
                --handleValueEntry("7")
                keypadInput("7")
            elseif command == device_commands.fm1Btn8 then
                --handleValueEntry("8")
                keypadInput("8")
            elseif command == device_commands.fm1Btn9 then
                --handleValueEntry("9")
                keypadInput("9")
            elseif command == device_commands.fm1Btn0 then
                --handleValueEntry("0")
                keypadInput("0")
            elseif command == device_commands.fm1BtnFreq then
                --handleFnBtn("FREQ")
                keypadInput("FREQ")
            elseif command == device_commands.fm1BtnClr then
                --handleFnBtn("CLR")
                keypadInput("CLR")
            elseif command == device_commands.fm1BtnEnt then
                --handleFnBtn("ENT")
                keypadInput("ENT")
            elseif command == device_commands.fm1BtnTime then
                --handleFnBtn("TIME")
                keypadInput("TIME")
            elseif command == device_commands.fm1BtnErfOfst then
                --handleFnBtn("ERFOFST")
                keypadInput("ERFOFST")
            end
        end
    end
end

function keypadInput(key)
    if hasPower then
        if (pwrMode == 2 or pwrMode == 3 or pwrMode == 5) and (key == "TIME" or key == "ERFOFST" or key == "FREQ") then
            setDisplayMode(key)
        end
        
        if displayMode == "loadSC" then
            loadSC(key)
        elseif displayMode == "FH" then
            --loadFH(key)
        elseif displayMode == "loadOffset" then
            --loadOffset(key)
        elseif displayMode == "loadTime" then
            --loadTime(key)
        end
    end
end

function setDisplayMode(key)
    if pwrMode == 5 and key == "TIME" then
        displayMode = "loadTime"
    elseif (pwrMode == 2 or pwrMode == 3) and key == "TIME" then
        displayMode = "displayTime"
    elseif pwrMode == 5 and (rcvMode == 0 or rcvMode == 1) and key == "ERFOFST" then
        displayMode = "loadOffset"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 0 or rcvMode == 1) and key == "ERFOFST" then
        displayMode = "displayOffset"
    elseif (pwrMode == 5 or ((pwrMode == 2 or pwrMode == 3) and presetMode == 0)) and (rcvMode == 0 or rcvMode == 1) and key == "FREQ" then
        displayMode = "loadSC"
    elseif pwrMode == 5 and rcvMode == 2 and key == "FREQ" then
        displayMode = "loadFH"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 0 or rcvMode == 1) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "displaySC"
        displayTimeoutEnable = false
        updatePresetMode()
    elseif pwrMode == 5 and (rcvMode == 0 or rcvMode == 1) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "loadSC"
        
        if key == "preKnob" then
            countdownTimer = 7
        elseif key == "funcKnob" then
            countdownTimer = 1
        end
        
        displayTimeoutEnable = true
        updatePresetMode()
    end
end

function loadSC(key)
    if key == "FREQ" then
        countdownTimer = 7
        displayTimeoutEnable = true
        canEnterData = true
        
        if presets[presetMode] == 0 then
            displayString = "00000"
        else
            displayString = tostring(presets[presetMode] * 1e3)
        end

    elseif countdownTimer > 0 and canEnterData then
        if key == "CLR" and (displayString == "00000" or displayString == tostring(presets[presetMode] * 1e3)) then
            countdownTimer = 7
            displayString = ""
            --print_message_to_user("all clr")
        elseif key == "CLR" and displayString ~= "00000" then
            countdownTimer = 7
            displayString = displayString:sub(1, #displayString-1)
        elseif key ~= "CLR" and canEnterData and string.len(displayString) == 0 then
            --print_message_to_user("len 0")
            --print_message_to_user(key)
            countdownTimer = 7            
            if tonumber(key) >= 3 and tonumber(key) <= 8 then
                displayString = key
                --print_message_to_user("first digit")
            elseif tonumber(key) == 0 then
                displayString = "00000"
            end
        elseif canEnterData and string.len(displayString) == 1 then
            countdownTimer = 7
            if tonumber(displayString) == 8 then
                if tonumber(key) <= 7 then
                    displayString = displayString..key
                end
            else
                displayString = displayString..key
            end
        elseif canEnterData and string.len(displayString) == 2 then
            countdownTimer = 7
            displayString = displayString..key
        elseif canEnterData and string.len(displayString) == 3 then
            countdownTimer = 7
            if tonumber(key) == 0 or tonumber(key) == 2 or tonumber(key) == 5 or tonumber(key) == 7 then
                displayString = displayString..key
            end
        elseif canEnterData and string.len(displayString) == 4 then
            countdownTimer = 7
            if tonumber(displayString:sub(4)) == 0 or tonumber(displayString:sub(4)) == 5 then
                if tonumber(key) == 0 then
                    displayString = displayString..key
                end
            elseif tonumber(displayString:sub(4)) == 2 or tonumber(displayString:sub(4)) == 7 then
                if tonumber(key) == 5 then
                    displayString = displayString..key
                end
            end
        elseif canEnterData and string.len(displayString) == 5 and key == "ENT" then
            countdownTimer = 7
            canEnterData = false
            presets[presetMode] = tonumber(displayString * 1e-3)
            radioDevice:set_frequency(presets[presetMode] * 1e6)
            blink(0.25)
        end    
    end
    
    updateDisplay()
    
end

function funcSelfTest()
    if startSelfTest then
        paramFreq:set(0)
        countdownTimer = 17 -- Initialize the timer to 17 seconds
        startSelfTest = false
        displayMode = "selfTest"
        displayTimeoutEnable = true
        --print_message_to_user(countdownTimer)
    elseif countdownTimer > 0 then
        --countdownTimer = countdownTimer - update_time_step -- decrement the timer
        --print_message_to_user(countdownTimer)
    end

    if countdownTimer >= 17 - 3 then
        displayString = "-----"
    elseif countdownTimer < 17 - 3 and countdownTimer >= 17 - 5.5 then
        -- L digit: display E or - to indicate ECCM installed or not
        -- R digit: display C or - to indicate crypto installed or not
        displayString = "E   -"
    elseif countdownTimer < 17 - 5.5 and countdownTimer >= 17 - 11 then
        -- display 8's to check display segments
        displayString = "88888"
    elseif countdownTimer < 17 - 11 and countdownTimer > 0 then --TODO: check damage
        -- display Good if self test passes
        -- FAIL1 fault with radio circuitry or programming
        -- FAIL3 fault with ECCM module
        -- FAIL7 fault with interface between remote head and radio, or between radio control panel and radio
        -- FAIL8 fault with control unit or control panel
        displayString = "Good "
    --elseif countdownTimer <= 0 then
        -- You're still here? It's over. Go home. Go.
        --displayString = ""
    end
    
    updateDisplay()
end

function updatePresetMode()
    if presets[presetMode] == 0 then
        if presetMode == 7 then
            displayString = "FILLC"
        else
            displayString = "FILL"..tostring(presetMode)
        end
    else
        displayString = tostring(presets[presetMode] * 1e3)
        --print_message_to_user("updatePreset")
    end
    --printsec(presets[presetMode] * 1e6)
    radioDevice:set_frequency(presets[presetMode] * 1e6)
    --print_message_to_user(presets[presetMode] * 1e6)
    updateDisplay()
end

function updateDisplay()
    local adjustedText = ""
    
    if displayMode == "selfTest" then
        adjustedText = displayString
    elseif displayMode == "loadSC" or displayMode == "displaySC" then
        adjustedText = formatTrailingUnderscores(displayString, 5)
    elseif displayMode == "FH" then
    elseif displayMode == "loadOffset" then
    elseif displayMode == "none" then
        adjustedText = "     "
    end
    
    if hasPower then
        paramDisplayFreq:set(adjustedText.."@")
        --print_message_to_user("updated display with")
        --print_message_to_user(adjustedText)
    end
end

function checkDisplayTimeout()
    if countdownTimer <= 0 then
        displayTimeoutEnable = false
        canEnterData = false
        displayMode = "none"
        updateDisplay()
    end
    countdownTimer = countdownTimer - update_time_step
end

function updateReceiverMode()
    if rcvMode == 0 then
        paramHomingEnabled:set(1)
    else
        paramHomingEnabled:set(0)
    end
end

function blink(numSeconds)
    blinkTimer = blinkTimer - update_time_step
    if numSeconds ~= nil then
        paramMode:set(0)
        blinkTimer = numSeconds
        checkBlink = true
    end
    
    if blinkTimer <= 0 then
        paramMode:set(1)
        checkBlink = false
    end
end

function update()
    updateNetworkArgs(GetSelf())
    updateReceiverMode()
    hasPower = paramCB_VHFFM1:get() > 0
    if hasPower and pwrMode == 1 then
        funcSelfTest()
    end
    
    if checkBlink then
        blink()
    end
    
    if displayTimeoutEnable then
        checkDisplayTimeout()
    end

    --paramDisplayFreq:set(formatPrecedingUnderscores(displayString, 5).."@")
    --paramDisplayFreq:set(formatTrailingUnderscores(displayString, 5).."@")
end

need_to_be_closed = false
