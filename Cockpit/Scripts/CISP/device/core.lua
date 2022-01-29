
dofile(LockOn_Options.script_path.."CISP/device/beaconData.lua")

-- 'Master Modes'
paramHdgMode = get_param_handle("CIS_MODE_HDG")
paramNavMode = get_param_handle("CIS_MODE_NAV")
paramAltMode = get_param_handle("CIS_MODE_ALT")

navModeOn = false
hdgModeOn = false
altModeOn = false

altModeBtnState = 0

paramPilotHSIHeading = get_param_handle("PILOT_HSI_HDGBUG")
paramPilotHSICourse = get_param_handle("PILOT_HSI_CRSBUG")

paramCopilotHSIHeading = get_param_handle("COPILOT_HSI_HDGBUG")
paramCopilotHSICourse = get_param_handle("COPILOT_HSI_CRSBUG")

local paramAHRUAligned = get_param_handle("AHRU_ALIGNED")

local aircraftHeading

-- For the VSI CISP logic
pilotHeading = 0
pilotCourse = 0

copilotHeading = 0
copilotCourse = 0

vorILSTrackError = 0 -- track error for whichever course input is set on CIS
pilotAltHoldAltitude = 0
pilotAirspeedHold = 0

paramARN149Freq = get_param_handle("ARN149_FREQ")
adfBearing = 0
paramARN147Freq = get_param_handle("ARN147_FREQ")
validVOR = false
validILS = false
vorILSBearing = 0
vorPos = {}
vorILSDistance = -1
ilsDirection = -1
gsBeaconAlt = 0

-- 'Sub Modes'
dplrGpsModeOn = false
vorModeOn = false
ilsModeOn = false
hdgSubModeOn = false -- NAV subMode for VOR, ILS and DPLR GPS
stationPassageSubModeOn = false
approachSubModeOn = false
backCrsModeOn = false
fmHomeModeOn = false
turnRateIsAlt = false
crsHdgIsCplt = false
vertGyroIsAlt = false
brg2IsVOR = false

gsFlagPos = 0
gsIndPos = 0

stationPassageSubModeStartTime = -1
stationPassageSubModeTimeElapsed = -1

paramGPSAvail = get_param_handle("CISP_GPS_AVAILABLE")
paramGPSDist = get_param_handle("CISP_GPS_DISTANCE")
paramGPSBearing = get_param_handle("CISP_GPS_BEARING")
paramGPSCourse = get_param_handle("CISP_GPS_COURSE")
paramGPSTrackError = get_param_handle("CISP_GPS_TRACKERROR")

paramPltRdrAltLo = get_param_handle("PILOT_APN209_LOBUG")
paramCpltRdrAltLo = get_param_handle("COPILOT_APN209_LOBUG")

paramTrackAngle = get_param_handle("TRACK_ANGLE")

-- Lights
paramCISPHDGLt = get_param_handle("LIGHTING_CIS_HDG_ON")
paramCISPNAVLt = get_param_handle("LIGHTING_CIS_NAV_ON")
paramCISPALTLt = get_param_handle("LIGHTING_CIS_ALT_ON")

flagMoveSpeed = 5

function getBeaconData(freq, type)
    type = nil or type
    local selfx, selfy, selfz = sensor_data.getSelfCoordinates()
    
    for k,v in pairs(beacons) do
        beaconPos = v.position
        beaconDistance = math.sqrt((beaconPos[1] - selfx)^2 + (beaconPos[3] - selfz)^2)

        -- VOR beacons typically have range of roughly 300km. ILS 40km. NDBs have much greater range (infinite for DCS purposes)
        if v.frequency == freq then
            local correctType = false
            if type then
                if v.type == type then
                    correctType = true
                end
            else
                correctType = true
            end

            if correctType then
                if v.type == BEACON_TYPE_VOR or v.type == BEACON_TYPE_VOR_DME or v.type == BEACON_TYPE_VORTAC then
                    if beaconDistance < 300000 then
                        return v
                    end
                elseif v.type == BEACON_TYPE_ILS_LOCALIZER or v.type == BEACON_TYPE_ILS_GLIDESLOPE then
                    if beaconDistance < 40000 then
                        return v
                    end
                else
                    return v
                end
            end
        end
    end

    return nil
end

function updateHSIPointer(pointerHandle, targetBearing)
    local currBrg = pointerHandle:get()
    local stepChange = 0
    local targetPos = 0
    local radialPath = getShortestRadialPath(targetBearing, currBrg)

    if (radialPath < 0) then
        stepChange = math.min(math.abs(radialPath), update_time_step * 100);
        if (currBrg - stepChange < 0) then
            targetPos = currBrg - stepChange + 360
        else
            targetPos = currBrg - stepChange
        end
    else
        stepChange = math.min(radialPath, update_time_step * 100);
        if (currBrg + stepChange >= 360) then
            targetPos = currBrg + stepChange - 360
        else
            targetPos = currBrg + stepChange
        end
    end

    pointerHandle:set(targetPos)
end

function updateADF()
    adfBearing = 0
    local adfFreq = paramARN149Freq:get()
    if adfFreq and adfFreq > 0 then
        local beaconData = getBeaconData(adfFreq)
        if beaconData then
            local selfx, selfy, selfz = sensor_data.getSelfCoordinates()
            adfBearing = getBearingToPosition(beaconData.position, {selfx, selfy, selfz})
            --print_message_to_user(Dump("ADF Freq: "..adfFreq.."; Bearing: "..adfBearing))
        end
    end
end

function updateVORILS()
    vorILSBearing = 0
    vorILSDistance = -1
    validVOR = false
    validILS = false

    local vorFreq = paramARN147Freq:get()

    if vorFreq and vorFreq > 0 then
        local beaconData = getBeaconData(vorFreq)
        if beaconData then
            if beaconData.type == BEACON_TYPE_ILS_LOCALIZER or beaconData.type == BEACON_TYPE_ILS_GLIDESLOPE or beaconData.type == BEACON_TYPE_VOR or beaconData.type == BEACON_TYPE_VOR_DME or beaconData.type == BEACON_TYPE_VORTAC then
                local selfx, selfy, selfz = sensor_data.getSelfCoordinates()
                vorILSBearing = getBearingToPosition(beaconData.position, {selfx, selfy, selfz})
                vorPos = beaconData.position
                local selfX,selfY,selfZ = sensor_data.getSelfCoordinates()
                vorILSDistance = math.sqrt((vorPos[1] - selfX)^2 + (vorPos[3] - selfZ)^2)

                -- Consider ILS as subtype of VOR, can still apply VOR to ILS
                if beaconData.type == BEACON_TYPE_ILS_LOCALIZER or beaconData.type == BEACON_TYPE_ILS_GLIDESLOPE then
                    validILS = true
                    -- The localiser and glideslope have different directions, use the glideslope
                    local gsBeacon = getBeaconData(vorFreq, BEACON_TYPE_ILS_GLIDESLOPE)
                    ilsDirection = formatCompassDir(gsBeacon.direction - 180)
                    vorPos = gsBeacon.position
                    gsBeaconAlt = gsBeacon.position[2]

                    -- Set track error
                    vorILSTrackError = getShortestRadialPath(vorILSBearing, course)
                else
                    validVOR = true
                    vorILSTrackError = getShortestRadialPath(vorILSBearing, course)
                end
            end
        end
    end
end

function updateNo1Pointer()
    local gpsBearing = paramGPSBearing:get()
    updateHSIPointer(paramHSINo1Bug, gpsBearing)

    if (paramGPSAvail:get() > 0 and dplrGpsModeOn and navModeOn) then
        moveGauge(paramHSIDistFlag, 0, flagMoveSpeed, update_time_step)
        
        local dist = paramGPSDist:get()
        moveGauge(paramHSIDistFlag, 0, flagMoveSpeed, update_time_step)

        moveGauge(paramHSIDistDrum1, jumpwheel(dist * 10, 4), 2, update_time_step)
        moveGauge(paramHSIDistDrum2, jumpwheel(dist * 10, 3), 2, update_time_step)
        moveGauge(paramHSIDistDrum3, jumpwheel(dist * 10, 2), 2, update_time_step)
        moveGauge(paramHSIDistDrum4, jumpwheel(dist * 10, 1), 2, update_time_step)
    else
        moveGauge(paramHSIDistFlag, 1, flagMoveSpeed, update_time_step)
    end
end

function updateNo2Pointer()
    if brg2IsVOR then
        updateHSIPointer(paramHSINo2Bug, vorILSBearing)
    else
        updateHSIPointer(paramHSINo2Bug, adfBearing)
    end
end

function updateCRSDeviationBar()
    local crsDeviationPos = 0
    if navModeOn and vorModeOn and validVOR then
        crsDeviationPos = clamp(vorILSTrackError / 10, -1, 1)
    elseif navModeOn and ilsModeOn and validILS then
        crsDeviationPos = clamp(vorILSTrackError / 2.5, -1, 1)
    elseif navModeOn and dplrGpsModeOn then
        crsDeviationPos = clamp(paramGPSTrackError:get() / 10, -1, 1)
    end

    moveGauge(paramHSICrsDev, crsDeviationPos, 3, update_time_step)
end

function calculateRollCmdPosUsingHdg(offset)
    local currentRoll = sensor_data:getRoll() * radian_to_degree
    return ((clamp(offset, -20, 20) - currentRoll) / 20) / 2
end

function calculateRollCmdPosUsingAngle(angle)
    local currentRoll = sensor_data:getRoll() * radian_to_degree
    return ((clamp(angle, -20, 20) - currentRoll) / 20) / 2
end

function interceptFollowRadial(courseDir, bearing, distanceToTarget)
    local commandRoll = -1
    -- vor mode - intercept the radial at 45deg, then follow the radial
    local crsDeviationDeg = getShortestRadialPath(courseDir, bearing)
    local interceptHeading = 0
    if crsDeviationDeg > 0 then
        interceptHeading = formatCompassDir(courseDir - 45)
    else
        interceptHeading = formatCompassDir(courseDir + 45)
    end

    -- Now we want the distance to the radial intercept point. We know dist to beacon, intercept heading and heading to beacon, so calculate the remaining angle and sides
    -- using law of sines
    local distanceToRadial = -1
    --print_message_to_user(vorILSDistance)
    if distanceToTarget >= 0 then
        distanceToRadial = math.abs(vorILSDistance * math.sin(math.rad(crsDeviationDeg))) / math.sin(math.rad(135))
    else
        return
    end

    --print_message_to_user("VOR Dist: "..vorILSDistance.."; crsDeviationDeg: "..crsDeviationDeg.."; distToIntercept: "..distanceToRadial)
    local standardRateBankAngle = ((sensor_data:getIndicatedAirSpeed() * msToKts) / 10) + 7
    -- r = s^2/11.26*a
    -- a = (s^2/r)/11.26
    local requiredBankAngle = ((((sensor_data:getIndicatedAirSpeed() * msToKts)^2) / (distanceToRadial * meters_to_feet)) / 11.26) * radian_to_degree
    
    -- command to intercept at 45 until we reach the point we can make a half standard rate turn onto the radial

    --print_message_to_user(crsDeviationDeg)
    if crsDeviationDeg >= 2.5 then
        local hdgOffset = getShortestRadialPath(interceptHeading, paramTrackAngle:get())
        commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
        --print_message_to_user("45 intercept. bank angle: "..requiredBankAngle.."; crsDeviationDeg"..crsDeviationDeg)
    else
        -- turn onto and follow the radials
        local hdg = courseDir - clamp(crsDeviationDeg * 5, -45, 45)
        local hdgOffset = getShortestRadialPath(hdg, paramTrackAngle:get())
        commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
        --print_message_to_user("course/ILS dir: "..courseDir.."; tgtHeading: "..hdg.."; distToRadial: "..distanceToRadial.."; crsDeviationDeg"..crsDeviationDeg)
    end

    return commandRoll
end

function enableStationPassageSubMode()
    stationPassageSubModeOn = true
    stationPassageSubModeStartTime = get_absolute_model_time()
    stationPassageSubModeTimeElapsed = 0
end

function updateStationPassageSubMode()
    if stationPassageSubModeOn then
        stationPassageSubModeTimeElapsed = get_absolute_model_time() - stationPassageSubModeStartTime
        if stationPassageSubModeTimeElapsed > 30 then
            stationPassageSubModeOn = false
            stationPassageSubModeStartTime = -1
            stationPassageSubModeTimeElapsed = -1
        end
    end
end

function updateVSI()
    if ahruPower then
        moveGauge(paramVSIPitch, sensor_data:getPitch() + paramAHRUPitchError:get(), 20 / radian_to_degree, update_time_step)
        moveGauge(paramVSIRoll, sensor_data:getRoll() + paramAHRURollError:get(), 20 / radian_to_degree, update_time_step)
        --print_message_to_user(sensor_data:getPitch().."; "..paramAHRUPitchError:get().."; "..paramVSIPitch:get())
    end

    -- Roll command bar
	local commandRoll = -1
	if hdgModeOn then
        -- Standard Heading Mode, follow the heading bug. Also reused as a nav submode
		-- Command a roll equating to 1 degree of roll for every 1 degree off heading
        local hdgOffset = getShortestRadialPath(heading, aircraftHeading)
		commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
    elseif navModeOn then
        -- Check for mode
        if vorModeOn then
            if vorILSDistance < 10 and not stationPassageSubModeOn then
                enableStationPassageSubMode()
            elseif math.abs(vorILSTrackError) > 15 then -- Check for heading submode
                hdgSubModeOn = true
            else
                hdgSubModeOn = false
            end

            -- Submode logic
            if stationPassageSubModeOn then
                -- Station Passage submode. Follow course bug. Automatically disengaged after 30s after passing over beacon/waypoint
                local crsOffset = getShortestRadialPath(course, paramTrackAngle:get())
		        commandRoll = calculateRollCmdPosUsingHdg(crsOffset)
            elseif hdgSubModeOn then
                -- Heading submode. Follow heading bug. Automatically disengaged within 15deg of radial.
                local hdgOffset = getShortestRadialPath(heading, aircraftHeading)
		        commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
            else
                -- Default VOR mode - intercept the radial at 45deg then follow
                commandRoll = interceptFollowRadial(course, vorILSBearing, vorILSDistance)
            end
        elseif ilsModeOn then
            if vorILSDistance < 10 and not stationPassageSubModeOn then
                enableStationPassageSubMode()
            elseif gsFlagPos > 0 then
                approachSubModeOn = true
                hdgSubModeOn = false
            elseif math.abs(vorILSTrackError) > 2.5 then
                hdgSubModeOn = true
            else
                hdgSubModeOn = false
            end

            -- Submode logic
            if stationPassageSubModeOn then
                -- Station Passage submode. Follow course bug. Automatically disengaged after 30s after passing over beacon/waypoint
                local crsOffset = getShortestRadialPath(course, paramTrackAngle:get())
		        commandRoll = calculateRollCmdPosUsingHdg(crsOffset)
            elseif hdgSubModeOn then
                -- Heading submode. Follow heading bug. Automatically disengaged within 2.5deg of radial.
                local hdgOffset = getShortestRadialPath(heading, aircraftHeading)
		        commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
            else
                -- Default ILS mode - intercept the radial at 45deg then follow
                commandRoll = interceptFollowRadial(course, vorILSBearing, vorILSDistance)
            end
        elseif dplrGpsModeOn then
            -- Check for submodes
            local trackErrorDist = math.abs(paramGPSDist:get() * math.sin(math.rad(paramGPSTrackError:get()))) / math.sin(math.rad(90))
            -- Intercept distance is 200m at less than 2km to waypoint, then increases to 1000m at 12km
            local interceptDist = clamp((paramGPSDist:get() - 2000) / 10000 * 800, 200, 1000)

            if paramGPSDist:get() < 10 and not stationPassageSubModeOn then
                enableStationPassageSubMode()
            elseif math.abs(trackErrorDist) > interceptDist then
                hdgSubModeOn = true
            else
                hdgSubModeOn = false
            end

            -- Submode logic
            if stationPassageSubModeOn then
                -- Station Passage submode. Follow course bug. Automatically disengaged after 30s after passing over beacon/waypoint
                local crsOffset = getShortestRadialPath(course, paramTrackAngle:get())
		        commandRoll = calculateRollCmdPosUsingHdg(crsOffset)
            elseif hdgSubModeOn then
                -- Heading submode. Follow heading bug. Automatically disengaged within 1000 to 200m of radial.
                local hdgOffset = getShortestRadialPath(heading, aircraftHeading)
		        commandRoll = calculateRollCmdPosUsingHdg(hdgOffset)
            else
                -- Default DPLR GPS mode - intercept the waypoint course at 45deg then follow
                commandRoll = interceptFollowRadial(paramGPSCourse:get(), paramGPSBearing:get(), paramGPSDist:get())
            end
        end
	end

	moveGauge(paramVSIRollCmdBar, commandRoll, 1, update_time_step)
    
	-- Pitch command bar
    local commandPitch = -1
    if ilsModeOn and navModeOn then
        local airspeedDiff = sensor_data:getIndicatedAirSpeed() - pilotAirspeedHold
        local acceleration = sensor_data:getHorizontalAcceleration()
        -- Need to be gentle, so limit max pitch to e.g. 10m/s (~20kts) speed diff and an acceleration of 3m/s2
        local clampedSpeed = clamp(airspeedDiff / 10, -1, 1)
        local clampedAccel = clamp(acceleration / 3, -1, 1)
        -- Animation is limited to +10/-10 deg of current attitude. -1 and 1 anim states reserved for 'off screen' position, like other indicators
        commandPitch = clamp(clampedSpeed + clampedAccel, -0.5, 0.5)
        --print_message_to_user("Airspeed: "..sensor_data:getIndicatedAirSpeed().."; Hold: "..pilotAirspeedHold.."; Acc: "..acceleration.."; clampedSpeed: "..clampedSpeed.."; clampedAccel: "..clampedAccel.."; commandPitch: "..commandPitch)
    end
    
    moveGauge(paramVSIPitchCmdBar, commandPitch, 1, update_time_step)
    
	-- Collective command bar
    local commandCollective = -1
    if altModeOn or approachSubModeOn then
        local heliAlt = sensor_data.getBarometricAltitude() * meters_to_feet
        local targetAlt
        
        if altModeOn then
            targetAlt = pilotAltHoldAltitude * meters_to_feet
        elseif approachSubModeOn then
            local heliRdrAlt = sensor_data.getRadarAltitude() * meters_to_feet

            -- Decision Height - ILS mode commands level off when DH reached
            local dH = math.max(paramPltRdrAltLo:get(), paramCpltRdrAltLo:get())

            if heliRdrAlt <= dH then
                targetAlt = heliAlt
            else
                -- Assume GS signal at 20km and GS is 3deg, and within 2.5deg of radial. Indicator range +/- .5deg
                local ilsDeviationDeg = getShortestRadialPath(ilsDirection, vorILSBearing)
                if ilsDeviationDeg <= 2.5 and vorILSDistance <= 20000 then
                    -- Calculate height of glide path at present position
                    targetAlt = ((vorILSDistance * math.sin(math.rad(3)) / math.sin(math.rad(87))) + gsBeaconAlt) * meters_to_feet
                end
            end
        end
        
        local vs = clamp((sensor_data.getVerticalVelocity() * msToFpm) / 1000, -1, 1)
        local relAlt = clamp((heliAlt / 100) - (targetAlt / 100), -1, 1)

        commandCollective = clamp(relAlt + vs, -1, 1) / 2
        --printsec("vs: "..vs.."; ra: "..relAlt.."cc: "..commandCollective)
    end
    
    moveGauge(paramVSICollectiveCmdBar, commandCollective, 1, update_time_step)
    
	-- Glideslope
    if navModeOn and (ilsModeOn and validILS) then
        -- Assume GS signal at 20km and GS is 3deg, and within 2.5deg of radial. Indicator range +/- .5deg
        local ilsDeviationDeg = getShortestRadialPath(ilsDirection, vorILSBearing)
        if ilsDeviationDeg <= 2.5 and vorILSDistance <= 20000 then
            -- Calculate angle from beacon to helo
            local glideAngle = math.deg(math.atan((sensor_data:getBarometricAltitude() - gsBeaconAlt) / vorILSDistance))
            gsIndPos = clamp((glideAngle - 3) * -2, -1, 1)
            --print_message_to_user("On GS. Glide Angle: "..glideAngle)
            gsFlagPos = 1
        else
            gsFlagPos = 0
            gsIndPos = 0
        end
        --print_message_to_user(ilsDeviationDeg..", "..vorILSDistance)
    end
    
    moveGauge(paramVSIGlideSlopeInd, gsIndPos, 1, update_time_step)
    moveGauge(paramVSIGSFlag, gsFlagPos, 5, update_time_step)
    
	-- Track Error
    local trackErrorIndPos = 0
    if navModeOn and (ilsModeOn and validILS) then
        local ilsDeviationDeg = getShortestRadialPath(ilsDirection, vorILSBearing)
        trackErrorIndPos = -clamp(ilsDeviationDeg / 2.5, -1, 1)
    elseif navModeOn and vorModeOn and validVOR then
        local vorDeviationDeg = getShortestRadialPath(course, vorILSBearing)
        trackErrorIndPos = -clamp(vorDeviationDeg / 10, -1, 1)
    elseif navModeOn and dplrGpsModeOn then
        trackErrorIndPos = -clamp(paramGPSTrackError:get() / 10, -1, 1)
    end
    
    moveGauge(paramVSITrackErrorInd, trackErrorIndPos, 1, update_time_step)
    
	-- Turn Rate
	local turnRate = radian_to_degree * sensor_data:getRateOfYaw()
	--print_message_to_user(-turnRate)
	-- max at two minute turn = 3deg per sec
    moveGauge(paramVSITurnRateInd, -turnRate / 3, 1, update_time_step)
end

function updateVORDirFlag()
    if validVOR then
        if vorILSTrackError > 90 or vorILSTrackError < -90 then
            paramHSIVorToFrom:set(-1)
        else
            paramHSIVorToFrom:set(1)
        end
    else
        paramHSIVorToFrom:set(0)
    end
end

function updateFlags()
    if validVOR or validILS then
        moveGauge(paramVSINAVFlag, 1, flagMoveSpeed, update_time_step)
        moveGauge(paramHSINavFlag, 0, flagMoveSpeed, update_time_step)
    else
        moveGauge(paramVSINAVFlag, 0, flagMoveSpeed, update_time_step)
        moveGauge(paramHSINavFlag, 1, flagMoveSpeed, update_time_step)
    end

    if hdgModeOn or navModeOn or altModeOn then
        moveGauge(paramVSICMDFlag, 1, flagMoveSpeed, update_time_step)
    else
        moveGauge(paramVSICMDFlag, 0, flagMoveSpeed, update_time_step)
    end
    
    if ahruPower then
        moveGauge(paramVSIATTFlag, 1 * paramAHRUAligned:get(), flagMoveSpeed, update_time_step)
        moveGauge(paramHSIHdgFlag, 0, flagMoveSpeed, update_time_step)
    else
        moveGauge(paramVSIATTFlag, 0, flagMoveSpeed, update_time_step)
        moveGauge(paramHSIHdgFlag, 1, flagMoveSpeed, update_time_step)
    end
end

function updateLights()
    if hdgModeOn or (hdgSubModeOn and navModeOn and (vorModeOn or ilsModeOn)) then
        paramCISPHDGLt:set(1)
    else
        paramCISPHDGLt:set(0)
    end

    if navModeOn then
        paramCISPNAVLt:set(1)
    else
        paramCISPNAVLt:set(0)
    end
    
    if altModeOn then
        paramCISPALTLt:set(1)
    else
        paramCISPALTLt:set(0)
    end

    if dplrGpsModeOn then
        paramCISPDPLRGPSLt:set(1)
    else
        paramCISPDPLRGPSLt:set(0)
    end

    if vorModeOn then
        paramCISPVORLt:set(1)
    else
        paramCISPVORLt:set(0)
    end

    if ilsModeOn then
        paramCISPILSLt:set(1)
    else
        paramCISPILSLt:set(0)
    end

    if backCrsModeOn then
        paramCISPBACKCRSLt:set(1)
    else
        paramCISPBACKCRSLt:set(0)
    end

    if fmHomeModeOn then
        paramCISPFMHOMELt:set(1)
    else
        paramCISPFMHOMELt:set(0)
    end

    if turnRateIsAlt then
        paramCISPTURNRATENORMLt:set(0)
        paramCISPTURNRATEALTLt:set(1)
    else
        paramCISPTURNRATENORMLt:set(1)
        paramCISPTURNRATEALTLt:set(0)
    end
    if crsHdgIsCplt then
        paramCISPCRSHDGPLTLt:set(0)
        paramCISPCRSHDGCPLTLt:set(1)
    else
        paramCISPCRSHDGPLTLt:set(1)
        paramCISPCRSHDGCPLTLt:set(0)
    end
    if vertGyroIsAlt then
        paramCISPVERTGYRONORMLt:set(0)
        paramCISPVERTGYROALTLt:set(1)
    else
        paramCISPVERTGYRONORMLt:set(1)
        paramCISPVERTGYROALTLt:set(0)
    end
    if brg2IsVOR then
        paramCISPBRG2ADFLt:set(0)
        paramCISPBRG2VORLt:set(1)
    else
        paramCISPBRG2ADFLt:set(1)
        paramCISPBRG2VORLt:set(0)
    end
end

function updateCore()
    -- HSI Compass Dir
    if ahruPower then
        aircraftHeading = 360 - (sensor_data:getHeading() * radian_to_degree)
        --moveCompass(paramHSICompass, formatCompassDir(aircraftHeading + paramAHRUHeadingError:get()), 30, update_time_step)
        paramHSICompass:set(aircraftHeading + paramAHRUHeadingError:get())
    end

    if paramHdgMode:get() > 0 then
        hdgModeOn = true
        navModeOn = false
        stationPassageSubModeOn = false
        approachSubModeOn = false
        hdgSubModeOn = false
    else
        hdgModeOn = false
    end

    if paramNavMode:get() > 0 then
        navModeOn = true
        hdgModeOn = false

        -- If switching on ILS, switch on ALT hold as well
        if ilsModeOn then
            if approachSubModeOn then
                altModeOn = false
            else
                altModeOn = true
            end
            pilotAltHoldAltitude = sensor_data:getBarometricAltitude()
            pilotAirspeedHold = sensor_data:getIndicatedAirSpeed()
        end
    else
        navModeOn = false
        stationPassageSubModeOn = false
        approachSubModeOn = false
        hdgSubModeOn = false
    end

    -- if we lose a valid vor or ils signal, switch off those modes
    if not validVOR then
        vorModeOn = false
    end

    if not validILS then
        ilsModeOn = false
    end

    -- DPLRGPS mode overrides others
    if dplrGpsModeOn then
        vorModeOn = false
        ilsModeOn = false
    end

    if paramAltMode:get() ~= altModeBtnState then
        if altModeOn == false then
            -- Alt hold only engages if vertical speed less than 200fpm
			if (math.abs(sensor_data:getVerticalVelocity()) * msToFpm <= 200) then
                altModeOn = true
				pilotAltHoldAltitude = sensor_data:getBarometricAltitude()
			end
        else
            altModeOn = false
        end

        altModeBtnState = paramAltMode:get()
    end

    pilotCourse = paramPilotHSICourse:get()
    pilotHeading = paramPilotHSIHeading:get()
    copilotCourse = paramCopilotHSICourse:get()
    copilotHeading = paramCopilotHSIHeading:get()

    if crsHdgIsCplt then
        heading = copilotHeading
        course = copilotCourse
    else
        heading = pilotHeading
        course = pilotCourse
    end

    updateStationPassageSubMode()

    updateADF()
    updateVORILS()
    updateVORDirFlag()

    updateCRSDeviationBar()
    updateNo1Pointer()
    updateNo2Pointer()

    updateVSI()

    updateLights()
    updateFlags()
end
