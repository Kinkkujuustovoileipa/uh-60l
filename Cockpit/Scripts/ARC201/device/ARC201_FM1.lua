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
local paramFreq = get_param_handle("ARC201_FM1_FREQ") -- this is for FM Homing?
local paramDisplayFreq = get_param_handle("ARC201_FM1_FREQ_DISPLAY") -- this is for the radio display
local paramMode = get_param_handle("ARC201_FM1_MODE")
local paramHomingEnabled = get_param_handle("ARC201_FM1_HOMING_ENABLED")

-- for SRS
local FM1paramModulation = get_param_handle("ARC201_FM1_MODULATION")
local FM1paramFreq = get_param_handle("ARC201FM1param")

local scanRate = 0.3 -- seconds between changing frequencies while scanning, lower (faster) is more realistic but must be high enough for SRS to change and detect a transmissions

local displayString = "30000"
local manualFreq = 30e6
local radioDevice = nil
local canEnterData = false
local pwrMode = 0 -- position of the function knob
local presetMode = 0 -- position of the preset knob
local presets = nil
local rcvMode = 0 -- whether or not FM homing is enabled
local countdownTimer = 0 -- countdown until the radio display turns off
local returnTimer = 0 -- countdown until the radio display goes back to showing frequency
local blinkTimer = 0 -- countdown for blinking the display off then back on
local delayTimer = 0 -- countdown for delayed action
local scanTimer = 0 -- countdown to resume scanning
local scanPriority = 8 -- preset that gets scanned more often, 0=man, 7=cue, 8=no priority
local scanPriorityNext = false -- whether or not the next scan should be the priority preset
local scanCurrent = 0 -- preset that is currently tuned for scanning
local scanTable = {} -- boolean table to determine which presets are being scanned
local isScanMode = false -- whether or not radio is in scan mode
local checkBlink = false -- whether or not blink is occuring
local checkBlinkWithDelay = false --whether or not a delayed blink is occuring
local displayTimeoutEnable = false -- whether or not the display blanking timeout is active
local returnTimeoutEnable = false -- whether or not the return timeout is active
local soundDelayTimer = 0 -- countdown until audio plays
local checkSoundWithDelay = false -- whether or not a delayed sound will be played
local soundToPlay = nil -- sound that will be played, should be set equal to get_param_handle("sound_param-from-sound_system.lua")
local displayMode = "none" -- what the display is showing
local nextDisplayMode = "" -- what will be displayed next after delay
local FHWorkingMemory = 0 -- temporary working memory for loading/storing/sending hopsets

local ICPselector = 0 -- position of ICP selector knob, 0.2 is FM1, 0.8 is FM2

local startSelfTest = false -- indicator to initiate the self test


function post_initialize()
    presets = get_aircraft_mission_data("Radio")[1].channels
    if presets[0] == nil then
        presets[0] = 30
    end
    presets[11]=101
    presets[12]=244
    presets[13]=316
    presets[14]=420
    presets[15]=588
    presets[16]=690
    FM1paramModulation:set(1)
    dev:performClickableAction(device_commands.fm1Volume, 1, false)
    dev:performClickableAction(device_commands.fm1ModeSelector, 0.01, false)
    dev:performClickableAction(device_commands.fm1PresetSelector, 0, false)
    local dev = GetSelf()
    radioDevice = GetDevice(devices.FM1_RADIO)
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        dev:performClickableAction(device_commands.fm1FunctionSelector, .02, false)
        paramDisplayFreq:set(formatTrailingUnderscores(displayString, 5).."@") -- needed to prevent NULL shown on radio with hot start
    elseif birth=="GROUND_COLD" then
        paramDisplayFreq:set("".."@")
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

dev:listen_command(Keys.fm1SRSrx) -- this "key" is pressed by SRS when receiving on this radio
dev:listen_command(Keys.ptt) -- the SRS PTT keybind, used by the scan feature to pause scanning

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
        if pwrMode == 0 or pwrMode == 7 or pwrMode == 8 then -- Function selector = off or zeroize or stow
            setFrequency(0)
            canEnterData = false
            paramDisplayFreq:set("".."@")
            paramMode:set(0) -- turns off display
            --print_message_to_user("set freq to 0")
        else
            paramMode:set(1) -- turns on display

            if pwrMode == 1 then
                startSelfTest = true
            elseif pwrMode == 2 or pwrMode == 3 or pwrMode == 5 then -- Function selector = SQ or SQ OFF or LD
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
        isScanMode = false
        setDisplayMode("preKnob")
    elseif command == device_commands.fm1ModeSelector then
        rcvMode = round(value * 100)
        --print_message_to_user("Mode displayMode")
        isScanMode = false
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
    elseif command == Keys.fm1SRSrx then -- this should only ever be done by SRS
        if value == 1 and isScanMode then
            if scanTimer >= 0 then -- set the scan timer unless ENT was pushed (set to -1)
                scanTimer = 2.5
            end
            
            if scanTimer <= 2.2 or displayMode ~= "scanFreq" then -- don't change the display if it's showing the frequency unless there was a short break in RX
                displayMode = "scanRX"
            end
            
            updateDisplay()
        end
    elseif command == Keys.ptt and math.floor(GetDevice("PLT_ICP"):get_argument_value(400) * 5) == 1 then -- the SRS PTT keybind and ICP selector set to radio 1
        if isScanMode then
            scanPTT(value)
        end
    else
        if value > 0 then
            if command == device_commands.fm1Btn1 then
                keypadInput("1")
            elseif command == device_commands.fm1Btn2 then
                keypadInput("2")
            elseif command == device_commands.fm1Btn3 then
                keypadInput("3")
            elseif command == device_commands.fm1Btn4 then
                keypadInput("4")
            elseif command == device_commands.fm1Btn5 then
                keypadInput("5")
            elseif command == device_commands.fm1Btn6 then
                keypadInput("6")
            elseif command == device_commands.fm1Btn7 then
                keypadInput("7")
            elseif command == device_commands.fm1Btn8 then
                keypadInput("8")
            elseif command == device_commands.fm1Btn9 then
                keypadInput("9")
            elseif command == device_commands.fm1Btn0 then
                keypadInput("0")
            elseif command == device_commands.fm1BtnFreq then
                keypadInput("FREQ")
            elseif command == device_commands.fm1BtnClr then
                keypadInput("CLR")
            elseif command == device_commands.fm1BtnEnt then
                keypadInput("ENT")
            elseif command == device_commands.fm1BtnTime then
                keypadInput("TIME")
            elseif command == device_commands.fm1BtnErfOfst then
                keypadInput("ERFOFST")
            end
        end
    end
end


function keypadInput(key) -- handle keypad presses
    if hasPower then
        -- go set display mode based on function key presses
        if (pwrMode == 2 or pwrMode == 3 or pwrMode == 5) and (key == "TIME" or key == "ERFOFST" or key == "FREQ" or key == "CLR" or key == "0" or key == "ENT") and (not isScanMode) then
            setDisplayMode(key)
        elseif (pwrMode == 2 or pwrMode == 3 or pwrMode == 5) and (key == "TIME" or key == "ERFOFST") and isScanMode then
            scanTimer = 2.5
            setDisplayMode(key)
        end

        -- send key presses to the relevant functions based on current displayMode
        if displayMode == "loadSC" then
            loadSC(key)
        elseif displayMode == "loadFH" then
            loadFH(key)
        elseif displayMode == "loadOffset" then
            loadOffset(key)
        elseif displayMode == "loadTime" then
            --loadTime(key)
        elseif displayMode == "clearFH" then
            clearFH(key)
        elseif displayMode == "recallFHWorkingMemory" then
            recallFHWorkingMemory(key)
        elseif displayMode == "storeFHWorkingMemory" then
            storeFHWorkingMemory(key)
        elseif displayMode == "startScan" then
            setScanPriority(key)
        elseif displayMode == "scanMode" or displayMode == "scanFreq" or displayMode == "scanRX" or displayMode =="scanCLR" then
            scanModeAction(key)
        end
        --print_message_to_user(displayMode)
    end
end


function setDisplayMode(key) -- logic to set displayMode based on key presses or knob rotation
    if pwrMode == 5 and key == "TIME" then
        displayMode = "loadTime"
    elseif (pwrMode == 2 or pwrMode == 3) and key == "TIME" then
        displayMode = "displayTime"
    elseif pwrMode == 5 and (rcvMode == 0 or rcvMode == 1) and key == "ERFOFST" then
        if displayMode ~= "loadOffset" then
            canEnterData = false
        end
        displayMode = "loadOffset"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 0 or rcvMode == 1) and key == "ERFOFST" then
        displayMode = "displayOffset"
        returnTimeoutEnable = true
        returnTimer = 7
        updateDisplay()
    elseif (pwrMode == 5 or ((pwrMode == 2 or pwrMode == 3) and presetMode == 0)) and (rcvMode == 0 or rcvMode == 1 or ((rcvMode == 2 or rcvMode == 3) and presetMode == 7)) and key == "FREQ" then
        if displayMode ~= "loadSC" then
            canEnterData = false
        end
        displayMode = "loadSC"
    elseif ((pwrMode == 2 or pwrMode == 3) and presetMode ~= 0) and (rcvMode == 0 or rcvMode == 1) and key == "FREQ" then
        displayMode = "displaySC"
        canEnterData = false
        updatePresetMode()
    elseif pwrMode == 5 and (rcvMode == 2 or rcvMode == 3) and key == "CLR" and not (canEnterData) then
        displayMode = "clearFH"
    elseif pwrMode == 5 and rcvMode == 3 and key == "0" and not (canEnterData) then
        displayMode = "recallFHWorkingMemory"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 0 or rcvMode == 1 or ((rcvMode == 2 or rcvMode == 3) and (presetMode == 0 or presetMode == 7))) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "displaySC"
        displayTimeoutEnable = false
        updatePresetMode() -- update currently tuned frequency
        --print_message_to_user("displaySC")
    elseif pwrMode == 5 and (rcvMode == 0 or rcvMode == 1 or ((rcvMode == 2 or rcvMode == 3) and presetMode == 7)) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "loadSC"
        
        if key == "preKnob" then
            countdownTimer = 7 -- if preset knob is turned, set the countdown to 7sec
        elseif key == "funcKnob" then
            countdownTimer = 1 -- if the function knob is turned, set countdown to 1sec
        end
        
        displayTimeoutEnable = true -- activate the timeout
        updatePresetMode() -- update currently tuned frequency
    elseif pwrMode == 5 and (rcvMode == 2 or rcvMode == 3) and (key == "FREQ" or key == "funcKnob" or key == "preKnob" or key == "modeKnob") and presetMode == 0 then
        canEnterData = false
        displayMode = "displaySC"
        if key == "funcKnob" then
            countdownTimer = 1
        else
            countdownTimer = 7
        end
        
        displayTimeoutEnable = true -- activate the timeout
        updatePresetMode() -- update currently tuned frequency
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 2 or rcvMode == 3) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") and not (presetMode == 0 or presetMode == 7) then
        canEnterData = false
        displayMode = "displayFH"
        displayTimeoutEnable = false
        updatePresetMode() -- update currently tuned frequency
        --print_message_to_user("displayFH")
        --print_message_to_user(rcvMode)
    elseif pwrMode == 5 and rcvMode == 2 and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") and not (presetMode == 0 or presetMode == 7) then
        canEnterData = false
        displayMode = "displayFH"
        
        if key == "preKnob" or key == "modeKnob" then
            countdownTimer = 7 -- if preset knob is turned, set the countdown to 7sec
        elseif key == "funcKnob" then
            countdownTimer = 1 -- if the function knob is turned, set countdown to 1sec
        end
        
        displayTimeoutEnable = true -- activate the timeout
        updatePresetMode() -- update currently tuned frequency
        --print_message_to_user("displayFH")
        --print_message_to_user(rcvMode)
    elseif pwrMode == 5 and rcvMode == 3 and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") and not (presetMode == 0 or presetMode == 7) then
        canEnterData = false
        displayMode = "loadFH"
        
        if key == "preKnob" or key == "modeKnob" then
            countdownTimer = 7 -- if preset knob is turned, set the countdown to 7sec
        elseif key == "funcKnob" then
            countdownTimer = 1 -- if the function knob is turned, set countdown to 1sec
        end
        
        displayTimeoutEnable = true -- activate the timeout
        updatePresetMode() -- update currently tuned frequency
        --print_message_to_user("loadFH")
    elseif pwrMode == 5 and rcvMode == 3 and presetMode ~= 0 and key == "FREQ" then
        displayMode = "loadFH"
        countdownTimer = 7
        updatePresetMode()
    elseif pwrMode == 5 and rcvMode == 3 and key == "ENT" and not (canEnterData) then
        displayMode = "storeFHWorkingMemory"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 2 or rcvMode == 3) and key == "ENT" and presetMode == 7 then
        displayMode = "startScan"
    end
--print_message_to_user(displayMode)
end


function loadSC(key) -- load single channel frequencies into a preset
    if key == "FREQ" then
        if (pwrMode == 2 or pwrMode == 3) then --if in SQ ON of OFF, return to normal display instead of blank display
            displayTimeoutEnable = false
            returnTimeoutEnable = true
            returnTimer = 7
        else --otherwise enable blanking the display
            returnTimeoutEnable = false
            displayTimeoutEnable = true
            countdownTimer = 7            
        end
        canEnterData = true
        
        if presets[presetMode] == 0 then -- check if current preset is set to 0MHz
            displayString = "00000"
        else
            displayString = tostring(presets[presetMode] * 1e3)
        end

    elseif canEnterData then
        if key == "CLR" and (displayString == "00000" or displayString == tostring(presets[presetMode] * 1e3)) then
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            displayString = "" -- clear the entire display
            --print_message_to_user("all clr")
        elseif key == "CLR" and displayString ~= "00000" then
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            displayString = displayString:sub(1, #displayString-1) -- backspace one digit
        elseif key ~= "CLR" and canEnterData and string.len(displayString) == 0 then
            --print_message_to_user("len 0")
            --print_message_to_user(key)
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            if tonumber(key) >= 3 and tonumber(key) <= 8 then -- first digit must be between 3 and 8
                displayString = key
                --print_message_to_user("first digit")
            elseif tonumber(key) == 0 then -- if first digit is 0, make display all zeros
                displayString = "00000"
            end
        elseif canEnterData and string.len(displayString) == 1 then
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            if tonumber(displayString) == 8 then -- if first digit is 8 then second digit must be <= 7
                if tonumber(key) <= 7 then
                    displayString = displayString..key
                end
            else
                displayString = displayString..key
            end
        elseif canEnterData and string.len(displayString) == 2 then
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            displayString = displayString..key
        elseif canEnterData and string.len(displayString) == 3 then
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            if tonumber(key) == 0 or tonumber(key) == 2 or tonumber(key) == 5 or tonumber(key) == 7 then
                displayString = displayString..key -- only 0, 2, 5, and 7 are allowed in this position
            end
        elseif canEnterData and string.len(displayString) == 4 then -- logic to only allow last digit of 00, 25, 50, or 75
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
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
            --reset timer upon any keypress
            if (pwrMode == 2 or pwrMode == 3) then
                returnTimer = 7
            else
                countdownTimer = 7
            end
            canEnterData = false -- data is entered, so prevent typing anything more
            presets[presetMode] = tonumber(displayString * 1e-3) -- set preset to what's on the display
            updatePresetMode() -- update the frequency tuned by the radio
            --radioDevice:set_frequency(presets[presetMode] * 1e6)
            blink(0.25) -- blink the diplay for 0.25sec
        end    
    end
    
    updateDisplay()
    
end


function loadOffset(key) -- function to load an offset for the current preset
    returnTimeoutEnable = false -- disable the return timeout because the blanking countdown will be active instead
    local trueDisplayStringLen = 0 -- the string length not including the "-" symbol
    local hasNegOffset = false -- boolean for offset being positive or negative
    
    if displayString:sub(1,1) == "-" then -- figure out if offset it positive or negative, and set variables
        trueDisplayStringLen = string.len(displayString) - 1
        hasNegOffset = true
    else
        trueDisplayStringLen = string.len(displayString)
    end
    
    if key == "ERFOFST" and not canEnterData then
        displayTimeoutEnable = true -- make the display timeout active
        countdownTimer = 7 -- reset countdown
        displayString = calcCurrentOffset(presets[presetMode] * 1e3) -- set displayString to current offset value
    elseif key == "ERFOFST" and canEnterData then -- if canEnterData then ERFOFST toggles between + and - offset
        countdownTimer = 7 -- reset countdown
        if displayString:sub(1,1) == "-" then -- if negative
            displayString = displayString:sub(2) -- remove negative sign
        else
            displayString = "-"..displayString -- otherwise prepend negative
        end
    elseif key == "CLR" and not canEnterData then -- this is when pressing clear to enable entering data
        countdownTimer = 7 -- reset countdown
        displayString = "" -- clear the display
        canEnterData = true
    elseif key == "CLR" and canEnterData and trueDisplayStringLen > 0 then -- this is when pressing clear after data is being entered
        countdownTimer = 7 -- reset countdown
        displayString = displayString:sub(1, #displayString-1) -- backspace one character
    elseif trueDisplayStringLen == 0 and canEnterData then
        countdownTimer = 7 -- reset countdown upon any keypress
        if key == "0" or key == "1" then -- only 0 or 1 are valid for the first digit
            displayString = displayString..key -- append the digit, in case there's a "-" symbol
        end
    elseif trueDisplayStringLen == 1 and canEnterData then -- logic for only allowing valid second digits based on the first digit
        countdownTimer = 7 -- reset countdown upon any keypress
        if (displayString == "0" or displayString == "-0") and key == "0" or key == "5" then
            displayString = displayString..key
        elseif (displayString == "1" or displayString == "-1") and key == "0" then
            displayString = displayString..key
        end
    end
    
    updateDisplay()
    
    if trueDisplayStringLen == 2 and canEnterData then
        countdownTimer = 7 -- reset countdown upon any keypress
        if key == "ENT" then
            local offset = tonumber(displayString)
            --print_message_to_user(offset)
            --print_message_to_user(calcBaseFreq(presets[presetMode] * 1e3))
            --print_message_to_user((calcBaseFreq(presets[presetMode] * 1e3) + offset) * 1e-3)
            presets[presetMode] = (calcBaseFreq(presets[presetMode] * 1e3) + offset) * 1e-3  -- shift stored preset by entered offset value
            setDisplayMode("preKnob") -- run setDisplayMode as if the preset knob had been changed
            --updatePresetMode()
            --canEnterData = false
            blink(0.25) -- blink display for 0.25sec
        end
    end
end


function loadFH(key)
    if key == "FREQ" then
        returnTimeoutEnable = false
        displayTimeoutEnable = true
        countdownTimer = 7
        
        if presets[presetMode + 10] == 0 then -- check if current preset is set to 0MHz
            canEnterData = false -- IRL not possible to completely manually fill FH data
        else
            displayString = tostring(presets[presetMode + 10])
            canEnterData = true
        end

    elseif canEnterData then
        if key == "CLR" and displayString == tostring(presets[presetMode + 10]) then
            --reset timer upon any keypress
            countdownTimer = 7
            displayString = displayString:sub(1,1)-- keep only the first FH net ID digit
            --print_message_to_user("all clr")
        elseif key == "CLR" and displayString ~= tostring(presets[presetMode + 10]) then
            --reset timer upon any keypress
            countdownTimer = 7
            if string.len(displayString) > 1 then
                displayString = displayString:sub(1, #displayString-1) -- backspace one digit
            end
        elseif (key == "0" or key == "1" or key == "2" or key == "3" or key == "4" or key == "5" or key == "6" or key == "7" or key == "8" or key == "9") and string.len(displayString) < 3 then
            --print_message_to_user("len 0")
            --print_message_to_user(key)
            --reset timer upon any keypress
            countdownTimer = 7
            displayString = displayString..key
        elseif key == "ENT" and string.len(displayString) == 3 then
            --reset timer upon any keypress
            countdownTimer = 7
            canEnterData = false -- data is entered, so prevent typing anything more
            presets[presetMode + 10] = tonumber(displayString) -- set preset to what's on the display
            updatePresetMode() -- update the frequency tuned by the radio
            blink(0.25) -- blink the diplay for 0.25sec
        end
    end
    updateDisplay()
end


function clearFH(key)
    if key == "CLR" then
        displayString = "CLR "
        canEnterData = true
        displayTimeoutEnable = true
        countdownTimer = 7
    elseif (tonumber(key) >= 1 and tonumber(key) <= 6) and tonumber(key) ~= presetMode and canEnterData then
        countdownTimer = 7
        displayString = "CLR "..key
        --print_message_to_user(displayString)
        presets[tonumber(key) + 10] = 0
        blinkWithDelay(0.5,0.25)
        soundWithDelay(0.25,"SND_INST_ARC201FM1_250MS600HZBEEP")
        canEnterData = false
    end
    updateDisplay()
end


function recallFHWorkingMemory(key)
    if key == "0" then
        displayString = "Hid "
        canEnterData = true
        displayTimeoutEnable = true
        countdownTimer = 7
    elseif (tonumber(key) >= 1 and tonumber(key) <= 6) and canEnterData then
        displayString = "Hid "..key
        blinkWithDelay(0.5,0.25,"FHWorkingMemory_HF")
        soundWithDelay(0.25,"SND_INST_ARC201FM1_250MS600HZBEEP")
        FHWorkingMemory = presets[tonumber(key) + 10]
        canEnterData = false
        displayTimeoutEnable = false
        countdownTimer = 0
        --displayMode = "FHWorkingMemory_HF"
    end
    updateDisplay()
end


function storeFHWorkingMemory(key)
    if key == "ENT" then
        displayString = "Sto "
        canEnterData = true
    elseif (tonumber(key) >= 1 and tonumber(key) <= 6) and canEnterData then
        displayString = "Sto "..key
        blinkWithDelay(0.5,0.25)
        soundWithDelay(0.25,"SND_INST_ARC201FM1_250MS600HZBEEP")
        presets[tonumber(key) + 10] = FHWorkingMemory
        canEnterData = false
        displayTimeoutEnable = true
        countdownTimer = 7
    end
    updateDisplay()
end


function setScanPriority(key)
    if key == "ENT" then
        displayString = "SCAN"
        returnTimeoutEnable = true
        returnTimer = 7
        canEnterData = true
    elseif tonumber(key) <= 8 and canEnterData then
        canEnterData = false
        returnTimeoutEnable = false
        
        if presets[tonumber(key)] == 0 then -- can't set an empty preset as priority
            displayMode = "displaySC"
        else
            scanPriority = tonumber(key) -- set the preset that will be scanned more frequently, 0=man, 7=cue, 8=no priority
            if scanPriority == 8 then
                scanCurrent = 0
                scanPriorityNext = true
            else
                scanCurrent = scanPriority
                scanPriorityNext = false
            end
            isScanMode = true
            displayMode = "scanMode"
            scanTimer = scanRate

            -- enable scanning on all non-zero presets
            if presets[0] ~= 0 then
                scanTable[0] = true
            else
                scanTable[0] = false
            end
            
            if presets[1] ~= 0 then
                scanTable[1] = true
            else
                scanTable[1] = false
            end
            
            if presets[2] ~= 0 then
                scanTable[2] = true
            else
                scanTable[2] = false
            end
            
            if presets[3] ~= 0 then
                scanTable[3] = true
            else
                scanTable[3] = false
            end
            
            if presets[4] ~= 0 then
                scanTable[4] = true
            else
                scanTable[4] = false
            end
            
            if presets[5] ~= 0 then
                scanTable[5] = true
            else
                scanTable[5] = false
            end
            
            if presets[6] ~= 0 then
                scanTable[6] = true
            else
                scanTable[6] = false
            end
            
            if presets[7] ~= 0 then
                scanTable[7] = true
            else
                scanTable[7] = false
            end
        end
    end
    updateDisplay()
end


function scanModeAction(key)
    if key == "ENT" then
        scanTimer = -1 -- immediately go to next preset
    elseif tonumber(key) ~= nil then -- need to check for nil first due to text strings breaking number comparison
        if tonumber(key) <= 7 then
            scanTimer = 2.5
            scanCurrent = tonumber(key) -- set scan to this preset
            scanTable[scanCurrent] = true -- re-enable scanning of this preset
            setFrequency(presets[scanCurrent] * 1e6) -- set freq to the preset
            scanPriorityNext = true
            displayMode = "scanRX"
            updateDisplay()
        end
    elseif key == "FREQ" then
        scanTimer = 2.5
        displayMode = "scanFreq"
        if scanPriorityNext == true then
            displayString = tostring(presets[scanCurrent] * 1e3)
        else
            displayString = tostring(presets[scanPriority] * 1e3)
        end
        updateDisplay()
    elseif key == "CLR" then
        scanTimer = 2.5
        if scanPriorityNext == true and scanCurrent ~= scanPriority then -- check this because it's not possible to clear the priority preset
            scanTable[scanCurrent] = false
            displayMode = "scanCLR"
            setFrequency(0) -- Tune the radio to 0 to stop SRS from receiving, which would otherwise keep it locked in to the preset
        end
        updateDisplay()
    end
end


function scanUpdate()
    if scanTimer <= 0 then -- time to change preset
        displayMode = "scanMode" -- put SCAN# back on the display
        updateDisplay()

        -- scanCurrent = scanCurrent + 1 -- advance to next
        -- if scanCurrent > 7 then -- if next is beyond the Cue preset, return to start
            -- scanCurrent = 0
        -- end
        -- while (scanTable[scanCurrent] == false) do -- advance to next again if we're not scanning this preset
            -- scanCurrent = scanCurrent + 1
            -- if scanCurrent > 7 then
                -- scanCurrent = 0
            -- end
        -- end
        
        if scanPriority == 8 then -- there's no priority preset
            scanPriorityNext = true -- due to poor coding, needed here for some other logic
            scanNextPreset() -- pick the next preset we're scanning
            setFrequency(presets[scanCurrent] * 1e6) -- set freq to the next preset
        else -- there is a priority, so alternate between priority and next scanned preset
            if scanPriorityNext == false then -- the priority was being scanned, so scan the next non priority preset
                scanNextPreset() -- pick the next preset we're scanning
                setFrequency(presets[scanCurrent] * 1e6) -- set freq to the next preset
                scanPriorityNext = true -- next time scan the priority channel
            else -- a non priority was being scanned, so scan the priority
                setFrequency(presets[scanPriority] * 1e6) -- set freq back to the priority
                scanPriorityNext = false -- next time don't scan the priority channel
            end
        end
        
        scanTimer = scanRate -- hold on the new freq for a short while to detect transmissions
    else
        scanTimer = scanTimer - update_time_step
    end
end


function scanNextPreset() -- sets the next preset to be scanned equal to scanCurrent
    local loopCount = 0 -- ensure while loop runs one time, but make sure we don't get stuck in a loop somehow
    
    while ((loopCount == 0 or scanTable[scanCurrent] == false or scanCurrent == scanPriority) and loopCount < 10) do -- advance to next, ensure preset is being scanned and is not the priority preset
        scanCurrent = scanCurrent + 1
        if scanCurrent > 7 then -- once preset reaches CUE, go back to MAN
            scanCurrent = 0
        end
        loopCount = loopCount + 1 -- this is our infinite loop safety
    end
    
    if loopCount == 10 then -- something went wrong, so just use the priority preset
        scanCurrent = scanPriority
    end
end


function scanPTT(value)
    if value == 1.375 then -- if SRS PTT pressed
        if displayMode == "scanRX" or displayMode == "scanFreq" then -- if already receiving or lockec on a channel from pressing freq
            scanTimer = 300 -- hold the channel for 5 minutes. Nobody should EVER talk this long. IRL the radio probably has a PTT timeout anyway
            displayMode = "scanRX" -- transmit and receive have the same display, so reuse it
        elseif displayMode == "scanMode" then -- if we're just scanning normally
            if not scanPriorityNext then -- if we're currently on the priority preset
                scanTimer = 300
                displayMode = "scanRX"
            elseif scanPriorityNext and scanPriority ~= 8 then -- if we're not on the priority preset and a priority was chosen
                scanModeAction(scanPriority) -- set radio to priority preset, this must come first
                scanTimer = 300 -- this has to come after or else scanModeAction will override it to 2.5 second
                displayMode = "scanRX"
            else -- radio not locked to a channel and there was no priority preset chosen, so it's going to stop wherever it's at to transmit
                scanTimer = 300
                displayMode = "scanRX"
            end
        end
        updateDisplay()
    elseif value == 1.25 then -- if SRS PTT button released
        scanTimer = 2.5 -- scanning will resume in 2.5 sec
    end
end


function funcSelfTest()
    if startSelfTest then
        setFrequency(0)
        countdownTimer = 17 -- Initialize the timer to 17 seconds
        startSelfTest = false
        displayMode = "selfTest"
        displayTimeoutEnable = true
        playSound("SND_INST_ARC201FM1_750MS600HZBEEP",true) -- halt sound
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
        playSound("SND_INST_ARC201FM1_750MS600HZBEEP")
    --elseif countdownTimer <= 0 then
        -- You're still here? It's over. Go home. Go.
        --displayString = ""
    end
    
    updateDisplay()
end


function updatePresetMode() -- tune the radio based on the preset selected, and then update the display
    
    --printsec(presets[presetMode] * 1e6)
    if (rcvMode == 0 or rcvMode == 1) or ((rcvMode == 2 or rcvMode ==3) and (presetMode == 0 or presetMode == 7)) then -- if SC, or FH and CUE
        displayString = tostring(presets[presetMode] * 1e3)
        setFrequency(presets[presetMode] * 1e6)
        FM1paramModulation:set(1)
    elseif (rcvMode == 2 or rcvMode ==3) and (presetMode < 7 and presetMode > 0) then -- if FH and a channel
        --displayString = tostring(presets[presetMode + 10])
        displayString = getPresetOrFill(presetMode + 10)
        if string.find(displayString,"FILL") ~= nil then
            setFrequency(0)
        else
            setFrequency((35.002 + (presets[presetMode + 10] * 0.005)) * 1e6) -- pick freqs outside of 5khz spacing so that it can't be tuned in SC
        end
        FM1paramModulation:set(7)
    end
    
    if presets[presetMode] == 0 then -- if the preset freq is 0, put FILL on the display
        if presetMode == 7 then
            displayString = "FILLC"
        else
            displayString = "FILL"..tostring(presetMode)
        end
    else
        
        --print_message_to_user("updatePreset")
    end
    --radioDevice:set_frequency(presets[presetMode] * 1e6)
    --FM1paramFreq:set(presets[presetMode] * 1e6)
    --paramFreq:set(presets[presetMode] * 1e6)
    --print_message_to_user(presets[presetMode] * 1e6)
    --print_message_to_user(radioDevice:get_frequency())
    updateDisplay()
end


function getPresetOrFill(presetToCheck)
    local tmp_str = ""
    if presets[presetToCheck] == 0 then -- if the preset freq is 0, put FILL on the display
        if presetMode == 7 then
            tmp_str = "FILLC"
        else
            tmp_str = "FILL"..tostring(presetToCheck % 10)
        end
        return tmp_str
    else
        if presetToCheck < 10 then
            tmp_str = tostring(presets[presetToCheck] * 1e3)
        elseif presetToCheck >= 10 then
            tmp_str = tostring(presets[presetToCheck])
        end
        return tmp_str
        --print_message_to_user("updatePreset")
    end
end


function updateDisplay() -- refresh the values on the display according to the current displayMode of the radio
    local adjustedText = ""
    
    if displayMode == "selfTest" then
        adjustedText = displayString
    elseif displayMode == "loadSC" or displayMode == "displaySC" then
        if (rcvMode == 2 or rcvMode == 3) and presetMode == 0 and not (presets[presetMode] == 0) then
            adjustedText = " Cold"
        else
            adjustedText = formatTrailingUnderscores(displayString, 5)
            --print_message_to_user(presets[presetMode])
        end
    elseif displayMode == "loadFH" or displayMode == "displayFH" then
        if string.find(displayString,"FILL") ~= nil then
            adjustedText = displayString
        else
            adjustedText = " F"..displayString
            adjustedText = formatTrailingUnderscores(adjustedText,5)
        end
    elseif displayMode == "loadOffset" then
        if displayString:sub(1,1) == "-" then
            adjustedText = formatTrailingUnderscores(displayString,3)
        else
            adjustedText = formatTrailingUnderscores(displayString,2)
        end
        adjustedText = formatPrecedingSpaces(adjustedText, 5)
    elseif displayMode == "displayOffset" then
        --print_message_to_user(calcCurrentOffset(presets[presetMode] * 1e3))
        --print_message_to_user(tostring(calcCurrentOffset(presets[presetMode] * 1e3)))
        --print_message_to_user(formatPrecedingSpaces(tostring(calcCurrentOffset(presets[presetMode] * 1e3)), 5))
        adjustedText = formatPrecedingSpaces(calcCurrentOffset(presets[presetMode] * 1e3), 5)
    elseif displayMode == "none" then
        adjustedText = "     "
    elseif displayMode == "clearFH" or displayMode == "recallFHWorkingMemory" or displayMode == "storeFHWorkingMemory" then
        adjustedText = formatTrailingUnderscores(displayString,5)
    elseif displayMode == "FHWorkingMemory_HF" then
        adjustedText = "HF"..FHWorkingMemory
    elseif displayMode == "startScan" then
        adjustedText = formatTrailingUnderscores(displayString,5)
    elseif displayMode == "scanMode" then
        adjustedText = "SCAN"..tostring(scanPriority)
    elseif displayMode == "scanRX" then
        if scanPriorityNext == true then
            adjustedText = formatPrecedingSpaces("CH "..tostring(scanCurrent),5)
        else
            adjustedText = formatPrecedingSpaces("CH "..tostring(scanPriority),5)
        end
    elseif displayMode == "scanFreq" then
        adjustedText = displayString
    elseif displayMode == "scanCLR" then
        adjustedText = "CLR "..tostring(scanCurrent)
    end
    
    if hasPower then
        paramDisplayFreq:set(adjustedText.."@")
        --print_message_to_user("updated display with")
        --print_message_to_user(adjustedText)
        --print_message_to_user(paramFreq:get())
        
    end
end


function checkDisplayTimeout() -- function to check if the display timeout has reached 0, and if so turn off the display
    if countdownTimer <= 0 then
        displayTimeoutEnable = false
        canEnterData = false
        displayMode = "none"
        updateDisplay()
    end
    countdownTimer = countdownTimer - update_time_step
end


function checkReturnTimeout() -- function to check if the return timeout has reached 0, and if so act as if the function knob has been turned
    if returnTimer <= 0 then
        returnTimeoutEnable = false
        canEnterData = false
        if not isScanMode then
            setDisplayMode("funcKnob")
        elseif isScanMode then
            displayMode = "scanMode"
            updateDisplay()
        end
    end
    returnTimer = returnTimer - update_time_step
end


function updateReceiverMode() -- function to turn FM homing on or off
    if rcvMode == 0 then
        paramHomingEnabled:set(1)
    else
        paramHomingEnabled:set(0)
    end
end


function calcBaseFreq(inputFreq) -- calculates the base frequency of a preset, essentially reverses any applied offset
    local baseFreq = 25 * (math.floor((inputFreq / 25) + 0.5))
    return baseFreq
end


function calcCurrentOffset(inputFreq) -- given any preset frequency, calculates what the offset value is
    local currentOffset = 0
    local remainder = inputFreq % 25 -- why the hell does this return incorrect values?
    remainder = math.floor(remainder + 0.1) -- Using floor to make whole numbers
    --print_message_to_user(remainder)
    --print_message_to_user(formatPrecedingZeros(tostring((remainder - 25) * -1), 2))

    if remainder <= 10 then
        currentOffset = formatPrecedingZeros(tostring(remainder), 2)
    else
        currentOffset = "-"..formatPrecedingZeros(tostring((remainder - 25) * -1), 2)
    end
    return currentOffset
end


function blink(numSeconds) -- switches the display off for numSeconds
    blinkTimer = blinkTimer - update_time_step
    --print_message_to_user("blinking")
    if numSeconds ~= nil then
        paramMode:set(0)
        blinkTimer = numSeconds
        checkBlink = true
    end
    
    if blinkTimer <= 0 then
        paramMode:set(1)
        checkBlink = false
        --print_message_to_user("blink done")
    end
end


function blinkWithDelay(delaySeconds,offSeconds,nextUp)
    delayTimer = delayTimer - update_time_step
    if offSeconds ~= nil then
        blinkTimer = offSeconds + 0.1
    end
	
    if delaySeconds ~= nil then
        delayTimer = delaySeconds
        checkBlinkWithDelay = true
        checkBlink = false
        --print_message_to_user("delayTimer "..delayTimer)
    end
	
    if nextUp ~= nil then
        nextDisplayMode = nextUp
    --else nextDisplayMode = displayMode
    end
    
    if delayTimer <= 0 then
        blink(blinkTimer)
        checkBlinkWithDelay = false
        --print_message_to_user("We should now be checking blink with "..blinkTimer)
        if nextDisplayMode ~= "" then
            displayMode = nextDisplayMode
        end
        nextDisplayMode = ""
        updateDisplay()
    end
end


function soundWithDelay(delaySeconds,soundParam)
    soundDelayTimer = soundDelayTimer - update_time_step
    if delaySeconds ~= nil then
        soundDelayTimer = delaySeconds
        checkSoundWithDelay = true
        --checkPlaySound = false -- unneded so far
    end
    
    if soundParam ~= nil then
        soundToPlay = soundParam
        local prepareSoundParam = get_param_handle(soundParam)
        prepareSoundParam:set(0) -- make sure sound isn't currently playing
    end
    
    if soundDelayTimer <= 0 then
        playSound(soundToPlay)
        checkSoundWithDelay = false
        --soundParam:set(0) -- pointless, but the APR-39 has it, so...?
        --soundParam:set(1)
    end
end


function playSound(soundParam,stopPlaying) -- sound parameter, optional boolean to immediately halt sound playback
    local sound = get_param_handle(soundParam)
    if stopPlaying == nil or stopPlaying == false then
        sound:set(0) -- useless when located here, but the APR-39 code has it, so...?
        sound:set(1) -- TODO: tie this to volume knobs (replace "1" with ARC201volume * mainvolume)
    elseif stopPlaying == true then
        sound:set(0)
    end
end


function setFrequency(newFrequency)
	radioDevice:set_frequency(newFrequency) -- set freq in DCS
    FM1paramFreq:set(newFrequency) -- set freq for SRS
	paramFreq:set(newFrequency) -- set freq for FM Homing
    --print_message_to_user(FM1paramFreq:get())
end
	

function update()
    updateNetworkArgs(GetSelf())
    updateReceiverMode()
    hasPower = paramCB_VHFFM1:get() > 0
    if hasPower then
        if pwrMode == 1 then
            funcSelfTest()
        end
    end
	
    if isScanMode then
        scanUpdate()
    end
    
    if checkBlinkWithDelay then -- if delayed blink is occuring, check it
        blinkWithDelay()
    elseif checkBlink then -- if blink is occuring, check it
        blink()
    end
    
    if displayTimeoutEnable then -- if display timeout is enabled, run the check function
        checkDisplayTimeout()
    end
    
    if returnTimeoutEnable then -- if return timeout is enabled, run the check function
        checkReturnTimeout()
    end
    
    if checkSoundWithDelay then
        soundWithDelay()
    end

    --paramDisplayFreq:set(formatPrecedingUnderscores(displayString, 5).."@")
    --paramDisplayFreq:set(formatTrailingUnderscores(displayString, 5).."@")
end

need_to_be_closed = false
