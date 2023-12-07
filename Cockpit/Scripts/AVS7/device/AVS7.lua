dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local Terrain = require('terrain')
local update_time_step = 0.1  
make_default_activity(update_time_step)

local paramBaroAlt = get_param_handle("AVS7_BARO_ALT")
local paramHeading = get_param_handle("AVS7_HEADING")
local paramBankAngle = get_param_handle("AVS7_BANKANGLE")
local paramBankAngleVis = get_param_handle("AVS7_BANKANGLE_VIS")
local paramPitchAngle = get_param_handle("AVS7_PITCHANGLE")
local paramIAS = get_param_handle("AVS7_IAS")
local paramIASVis = get_param_handle("AVS7_IAS_VIS")
local paramGS = get_param_handle("AVS7_GS")
local paramHorizonVis = get_param_handle("AVS7_HORIZON_VIS")

local handleRdrAlt = get_param_handle("AVS7_RDR_ALT")
local handleRdrAltLine = get_param_handle("AVS7_RDR_ALT_LINE")
local handleRdrAltVis = get_param_handle("AVS7_RDR_ALT_VIS")
local handleRdrAltDigitVis = get_param_handle("AVS7_RDR_ALT_DIGITVIS")
local handleVS = get_param_handle("AVS7_VS")
local paramRdrAltBox = get_param_handle("AVS7_RDR_ALT_BOX")
local rdrAltLo = get_param_handle("PILOT_APN209_LOLIGHT")

local paramGroundSpeedX = get_param_handle("GROUNDSPEED_X")
local paramGroundSpeedY = get_param_handle("GROUNDSPEED_Y")
local paramGroundSpeedZ = get_param_handle("GROUNDSPEED_Z")

local handleVVMag = get_param_handle("AVS7_VV_MAG")
local handleVVRot = get_param_handle("AVS7_VV_ROT")
local handleVVVis = get_param_handle("AVS7_VV_VIS")

local paramE1TRQ = get_param_handle("E1_TRQ")
local paramE2TRQ = get_param_handle("E2_TRQ")
local paramE1TrqBox = get_param_handle("E1_TRQ_BOX")
local paramE2TrqBox = get_param_handle("E2_TRQ_BOX")

local handlePower = get_param_handle("AVS7_PWR")

local handleVROption = get_param_handle("AVS7_VR")

local handleBrightness = get_param_handle("AVS7_BRIGHTNESS")
local avs7Brightness = 1
local avs7BrightnessChange = 0

local avs7wpToHandle = get_param_handle("AVS7_WPTO")
local avs7wpFromHandle = get_param_handle("AVS7_WPFROM")

local avs7wpToDisplayHandle = get_param_handle("AVS7_WPTO_DISPLAY")
local avs7wpFromDisplayHandle = get_param_handle("AVS7_WPFROM_DISPLAY")

local curPosX = 0
local curPosY = 0
local lastPosX = 0
local lastPosY = 0

local rdrAltDigitVis = 0
local rdrAltBarVis = 0

local powerSwitchOn = false
local powerSwitchState = 0

function post_initialize()
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then
    end

    dev:performClickableAction(device_commands.setAVS7Power,-1,true)
    
    if (get_plugin_option_value("UH-60L","VR_AVS7") == true) then
        handleVROption:set(1)
    else
        handleVROption:set(0)
    end
end

dev:listen_command(device_commands.setAVS7Power)
dev:listen_command(device_commands.incAVS7Brightness)
dev:listen_command(device_commands.decAVS7Brightness)
dev:listen_command(Keys.avs7Toggle)
dev:listen_command(Keys.avs7Brighten)
dev:listen_command(Keys.avs7Dim)

function SetCommand(command,value)   
    --print_message_to_user(value)
    if command == device_commands.setAVS7Power then
        if (value >= 0) then
            powerSwitchOn = true
        else
            powerSwitchOn = false
        end
        powerSwitchState = value

    elseif command == device_commands.incAVS7Brightness or command == device_commands.decAVS7Brightness then
        avs7BrightnessChange = value
    elseif command == Keys.avs7Toggle then
        if powerSwitchState == 0 then
            dev:performClickableAction(device_commands.setAVS7Power,-1,true)
        else
            dev:performClickableAction(device_commands.setAVS7Power,0,true)
        end
    end
end

function update()
    --updateNetworkArgs(GetSelf())
    local hasPower = paramCB_HUDREF:get() > 0 and paramCB_HUDSYS:get() > 0

    if hasPower and powerSwitchOn then
        -- TODO POWER UP AND BIT
        handlePower:set(1)

        paramBaroAlt:set(clamp(sensor_data.getBarometricAltitude() * meters_to_feet, -1000, 20000))
        paramHeading:set(getAircraftHeading())

        -- TODO TRQ box
    
        -- Bank angle indicator should flash >30deg
        local bankAngle = sensor_data.getRoll() * radian_to_degree
        paramBankAngle:set(clamp(-bankAngle, -180, 180) / radian_to_degree)
        if bankAngle > 30 or bankAngle < -30 then
            paramBankAngleVis:set(math.sin(get_absolute_model_time() * 16))
        else
            paramBankAngleVis:set(1)
        end
    
        local pitchAngle = sensor_data.getPitch() * radian_to_degree
    
        if pitchAngle > 30 then
            pitchAngle = 30
        elseif pitchAngle < -30 then
            pitchAngle = -30
        end
    
        paramPitchAngle:set(-pitchAngle)
    
        -- IAS disappears below 32kts
        local ias = sensor_data.getIndicatedAirSpeed() * msToKts
        paramIAS:set(clamp(sensor_data.getIndicatedAirSpeed() * msToKts, 0, 180))
        if ias < 32 then
            paramIASVis:set(0)
        else
            paramIASVis:set(avs7Brightness)
        end
    
        -- Radar Altitude
        -- Analog bar disappears at 250ft
        -- Digits disappear at 999ft
        -- TODO LO ALT box
        local rdrAlt = (sensor_data.getRadarAltitude() * meters_to_feet) - 8
        local rdrAltDigits = rdrAlt

        if rdrAlt > 200 then
            rdrAltDigits = round(rdrAlt / 10) * 10
        end

        handleRdrAlt:set(clamp(rdrAltDigits, 0, 1500))
        handleRdrAltLine:set(rdrAlt / 250)

        if rdrAlt > 250 and rdrAltBarVis == 1 then
            handleRdrAltVis:set(0)
            rdrAltBarVis = 0
        elseif rdrAlt <= 230 then
            handleRdrAltVis:set(avs7Brightness)
            rdrAltBarVis = 1
        end
    
        if rdrAlt >= 999 and rdrAltDigitVis == 1 then
            handleRdrAltDigitVis:set(0)
            rdrAltDigitVis = 0
        elseif rdrAlt <= 950 then
            handleRdrAltDigitVis:set(avs7Brightness)
            rdrAltDigitVis = 1
        end
    
        -- Vertical speed, shares same scale as radar alt
        local vs = sensor_data.getVerticalVelocity() * meters_to_feet * 60
        if vs > 2000 then
            vs = 2000
        elseif vs < -2000 then
            vs = -2000
        end
    
        handleVS:set(vs)
    
        -- Groundspeed and velocity vector
        -- Velocity vector only visible at 30kts and below
        -- Velocity vector max length at 15kts
        local groundSpeedX = round(paramGroundSpeedX:get(), 0)
        local groundSpeedZ = round(-paramGroundSpeedZ:get(), 0)
        local angle = math.atan2(groundSpeedZ, groundSpeedX)
        local gs = (math.sqrt(math.pow(paramGroundSpeedX:get(), 2) + (math.pow(paramGroundSpeedZ:get(), 2)))) * msToKts
        local pointPos = round(clamp(gs / 15, 0, 1), 2)
        
        handleVVRot:set(angle)
        handleVVMag:set(pointPos)
        
        if gs > 30 then
            handleVVVis:set(0)
        else
            handleVVVis:set(1)
        end
        
        paramGS:set(gs)
    
        -- Overall brightness setting
        avs7Brightness = avs7Brightness + avs7BrightnessChange / 30
        --print_message_to_user(avs7Brightness)
        if avs7Brightness < 0 then
            avs7Brightness = 0
        elseif avs7Brightness > 1 then
            avs7Brightness = 1
        end

        handleBrightness:set(avs7Brightness)

        avs7wpToDisplayHandle:set(avs7wpToHandle:get() * avs7Brightness)
        avs7wpFromDisplayHandle:set(avs7wpFromHandle:get() * avs7Brightness)
    
        -- Attitude ref and horizon line visibility
        local absPitchAngle = math.abs(pitchAngle)
        local absBankAngle = math.abs(bankAngle)
        --if (gs > 40 and absPitchAngle < 5 and absBankAngle < 5) or (gs < 5 and absPitchAngle < 7 and absBankAngle < 5) then
            --paramHorizonVis:set(0)
        --else
            paramHorizonVis:set(1) -- I don't trust the source on this, it seems weird. Disabling for now...
        --end
        --print_message_to_user("ias: "..gs.."; pitch: "..absPitchAngle.."; bank: "..absBankAngle)

        -- Torque Boxes
        local box1 = 0
        local box2 = 0

        if paramE1TRQ:get() > 150 then
            box1 = math.sin(get_absolute_model_time() * 15)
        elseif paramE1TRQ:get() > 100 then
            box1 = 1
        else
            box1 = 0
        end

        if paramE2TRQ:get() > 150 then
            box2 = math.sin(get_absolute_model_time() * 15)
        elseif paramE2TRQ:get() > 100 then
            box2 = 1
        else
            box2 = 0
        end

        paramE1TrqBox:set(box1)
        paramE2TrqBox:set(box2)

        -- Rdr Alt Box
        if rdrAltLo:get() > 0 then
            paramRdrAltBox:set(math.sin(get_absolute_model_time() * 15))
        else
            paramRdrAltBox:set(0)
        end
    else
        handlePower:set(0)
    end
end

need_to_be_closed = false
