dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 0.1 
make_default_activity(update_time_step)

local paramIndSlave	= get_param_handle("AHRU_IND_SLAVE")
local paramIndDG	= get_param_handle("AHRU_IND_DG")
local paramIndCcal	= get_param_handle("AHRU_IND_CCAL")
local paramIndFail	= get_param_handle("AHRU_IND_FAIL")
local paramIndAln	= get_param_handle("AHRU_IND_ALIGN")

local paramAHRUHeadingError = get_param_handle("AHRU_ERROR_HEADING")
local paramAHRURollError    = get_param_handle("AHRU_ERROR_ROLL")
local paramAHRUPitchError   = get_param_handle("AHRU_ERROR_PITCH")

local paramAHRUDisplayText = get_param_handle("AHRU_DISPLAY_TEXT")

local paramAHRUAligned = get_param_handle("AHRU_ALIGNED")

local isPowerOn = false
local isTested = false
local isTesting = false
local isAligning = false
local isAligned = false

local startPowerTestTime = -1
local startAlignTime = -1
local alignTime = -1

local headingError
local rollError
local pitchError

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        paramCB_AHRUPLT:set(1)
        isTested = true
        isAligned = true
        isTesting = false
        isAligning = false
        headingError = 0
        rollError    = 0
        pitchError   = 0

        paramAHRUHeadingError:set(headingError)
        paramAHRURollError:set(rollError)
        paramAHRUPitchError:set(pitchError)
    elseif birth=="GROUND_COLD" then
        isTested = false
        isAligned = false
        isTesting = false
        isAligning = false
        headingError = math.random(-180, 180)
        rollError    = math.rad(math.random(-10, 10))
        pitchError   = math.rad(math.random(-20, 20))

        paramAHRUHeadingError:set(headingError)
        paramAHRURollError:set(rollError)
        paramAHRUPitchError:set(pitchError)
    end
end

function SetCommand(command,value)   
end

function updateStatus()
    isPowerOn = paramCB_AHRUPLT:get() > 0
    --print_message_to_user(tostring(isPowerOn))
    if isPowerOn then
        --print_message_to_user("isAligned: "..tostring(isAligned).."; isTested: "..tostring(isTested).."; startAlignTime: "..tostring(startAlignTime).."; get_absolute_model_time: "..tostring(get_absolute_model_time()))
        if isAligned then
            -- Normal Operation
            isAligning = false
            isAligned = true
            isTesting = false
            isTested = true
        else
            if isTested then
                -- Run Alignment - 45s
                if startAlignTime == -1 then
                    startAlignTime = get_absolute_model_time()
                else
                    alignTime = get_absolute_model_time() - startAlignTime

                    if alignTime > 45 then
                        isAligning = false
                        isAligned = true
                        alignTime = -1
                        startAlignTime = -1
                    else
                        isAligning = true
                    end
                end
            else
                -- Run Power On Test - 2.5s
                if startPowerTestTime == -1 then
                    startPowerTestTime = get_absolute_model_time()
                else
                    local testTime = get_absolute_model_time() - startPowerTestTime

                    if testTime > 2.5 then
                        isTesting = false
                        isTested = true
                        startPowerTestTime = -1
                    else
                        isTesting = true
                    end
                end
            end
        end
    else
        startPowerTestTime = -1
        isPowerOnTest = false
        isTesting = false
        isTested = false
        isAligning = false
        isAligned = false
    end
end

function update()
    updateNetworkArgs(GetSelf())
    updateStatus()

    paramAHRUDisplayText:set("                ")

    if isPowerOn then
        if isTesting then
            --print_message_to_user("isTesting")
            paramIndSlave:set(1)
            paramIndDG:set(1)
            paramIndCcal:set(1)
            paramIndFail:set(1)
            paramIndAln:set(1)
        elseif isAligning then
            --print_message_to_user("isAligning")
            paramIndSlave:set(1)
            paramIndDG:set(0)
            paramIndCcal:set(0)
            paramIndFail:set(0)
            paramIndAln:set(1)

            if alignTime > 20 then
                headingError = 0
                rollError = 0
                pitchError = 0
            end

            paramAHRUHeadingError:set(headingError)
            paramAHRURollError:set(rollError)
            paramAHRUPitchError:set(pitchError)
        else
            --print_message_to_user("isOn")
            paramIndSlave:set(1)
            paramIndDG:set(0)
            paramIndCcal:set(0)
            paramIndFail:set(0)
            paramIndAln:set(0)
            if (isAligned) then
                paramAHRUAligned:set(1)
                paramAHRUDisplayText:set("-,,,,,,|,,,,,,,+")
            else
                paramAHRUAligned:set(0)
            end
        end
    else
        paramIndSlave:set(0)
        paramIndDG:set(0)
        paramIndCcal:set(0)
        paramIndFail:set(0)
        paramIndAln:set(0)
        paramAHRUAligned:set(0)
    end
end

need_to_be_closed = false
