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
local checkBlink = false -- whether or not blink is occuring
local displayTimeoutEnable = false -- whether or not the display blanking timeout is active
local returnTimeoutEnable = false -- whether or not the return timeout is active
local displayMode = "none" -- what the display is showing

local startSelfTest = false -- indicator to initiate the self test

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
            canEnterData = false
            paramDisplayFreq:set("".."@")
            paramMode:set(0) -- turns off display
            radioDevice:set_frequency(0)
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
        if (pwrMode == 2 or pwrMode == 3 or pwrMode == 5) and (key == "TIME" or key == "ERFOFST" or key == "FREQ") then
            setDisplayMode(key)
        end
        
        -- send key presses to the relevant functions based on current displayMode
        if displayMode == "loadSC" then
            loadSC(key)
        elseif displayMode == "FH" then
            --loadFH(key)
        elseif displayMode == "loadOffset" then
            loadOffset(key)
        elseif displayMode == "loadTime" then
            --loadTime(key)
        end
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
    elseif (pwrMode == 5 or ((pwrMode == 2 or pwrMode == 3) and presetMode == 0)) and (rcvMode == 0 or rcvMode == 1) and key == "FREQ" then
        if displayMode ~= "loadSC" then
            canEnterData = false
        end
        displayMode = "loadSC"
    elseif ((pwrMode == 2 or pwrMode == 3) and presetMode ~= 0) and (rcvMode == 0 or rcvMode == 1) and key == "FREQ" then
        displayMode = "displaySC"
        canEnterData = false
        updatePresetMode()
    elseif pwrMode == 5 and rcvMode == 2 and key == "FREQ" then
        displayMode = "loadFH"
    elseif (pwrMode == 2 or pwrMode == 3) and (rcvMode == 0 or rcvMode == 1) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "displaySC"
        displayTimeoutEnable = false
        updatePresetMode() -- update currently tuned frequency
    elseif pwrMode == 5 and (rcvMode == 0 or rcvMode == 1) and (key == "funcKnob" or key == "preKnob" or key == "modeKnob") then
        canEnterData = false
        displayMode = "loadSC"
        
        if key == "preKnob" then
            countdownTimer = 7 -- if preset knob is turned, set the countdown to 7sec
        elseif key == "funcKnob" then
            countdownTimer = 1 -- if the function knob is turned, set countdown to 1sec
        end
        
        displayTimeoutEnable = true -- activate the timeout
        updatePresetMode() -- update currently tuned frequency
    end
end

function loadSC(key) -- load single channel frequencies into a preset
    if key == "FREQ" then
        if (pwrMode == 2 or pwrMode == 3) then --if in SQ ON of OFF, return to normal display instead of blank display
            displayTimeoutEnable = false
            returnTimeoutEnable = true
            returnTimer = 7
        else --otherwise blank the display
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

function updatePresetMode() -- tune the radio based on the preset selected, and then update the display
    if presets[presetMode] == 0 then -- if the preset freq is 0, put FILL on the display
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
    --paramFreq:set(presets[presetMode] * 1e6)
    --print_message_to_user(presets[presetMode] * 1e6)
    --print_message_to_user(radioDevice:get_frequency())
    updateDisplay()
end

function updateDisplay() -- refresh the values on the display according to the current displayMode of the radio
    local adjustedText = ""
    
    if displayMode == "selfTest" then
        adjustedText = displayString
    elseif displayMode == "loadSC" or displayMode == "displaySC" then
        adjustedText = formatTrailingUnderscores(displayString, 5)
    elseif displayMode == "FH" then
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
        setDisplayMode("funcKnob")
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
    
    if checkBlink then -- if blink is occuring, check it
        blink()
    end
    
    if displayTimeoutEnable then -- if display timeout is enabled, run the check function
        checkDisplayTimeout()
    end
    
    if returnTimeoutEnable then -- if return timeout is enabled, run the check function
        checkReturnTimeout()
    end

    --paramDisplayFreq:set(formatPrecedingUnderscores(displayString, 5).."@")
    --paramDisplayFreq:set(formatTrailingUnderscores(displayString, 5).."@")
end

need_to_be_closed = false
