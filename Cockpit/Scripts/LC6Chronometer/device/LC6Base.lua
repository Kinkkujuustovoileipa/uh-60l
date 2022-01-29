
modeIndex = 1
numModes = 5 --LT,UTC,FLIGHT,SW,DC

flightTime = 0
totalFlightTime = 0
liftOffTime = -1
firstWoW = true

swTime = 0
swRunning = false

birth = nil

function post_initialize()
	local dev = GetSelf()
    birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then
    end
end

dev:listen_command(device_commands.resetSetBtn)
dev:listen_command(device_commands.modeBtn)
dev:listen_command(device_commands.startStopAdvBtn)
function SetCommand(command,value) 
    if hasPower then  
        if command == device_commands.modeBtn then
            if value > 0 then
                modeIndex = modeIndex + 1
                if modeIndex > numModes then
                    modeIndex = 1
                end
            end
        end

        if command == device_commands.startStopAdvBtn then
            if value > 0 then
                if modeIndex == 3 then
                    resetFlightTimer()
                elseif modeIndex == 4 then
                    toggleStopwatch()
                end
            end
        end

        if command == device_commands.resetSetBtn then
            if value > 0 then
                if modeIndex == 4 then
                    resetStopwatch()
                end
            end
        end
    end
end

function updateUTC()
    local time = get_absolute_model_time()
    local mapName = Terrain.GetTerrainConfig("id")
    --print_message_to_user(mapName)

    -- apply utc offsets. In some cases (Caucasus, Syria) the map covers multiple timezones.
    -- In these cases I am just using whichever timezone covers most of the map area
    -- If there is some function to get the timezone directly from the terrain I'd love to know it!
    local utcOffset = 0
    if mapName == "Syria" then
        utcOffset = -2 * 3600
    elseif mapName == "Caucasus" then
        utcOffset = -3 * 3600
    elseif mapName == "PersianGulf" then
        utcOffset = -4 * 3600
    elseif mapName == "MarianaIslands" then
        utcOffset = -10 * 3600
    elseif mapName == "Nevada" then
        utcOffset = 8 * 3600
    end
    -- TODO Normandy + Channel Islands (0 should be fine anyway)

    local days, utcTime = math.modf((time + utcOffset) / 86400)
    local hours, mins = math.modf(utcTime * 24)
    local foo, secs = math.modf(mins * 60)
    mins = math.floor(mins * 60)
    secs = math.floor(secs * 60)
    
    handleUTCHrs:set(hours)
    handleUTCMins:set(formatPrecedingZeros(mins,2))
    handleUTCSecs:set(secs)
end

function updateLT()
    local localTime = get_absolute_model_time()
    local days, time = math.modf(localTime / 86400)
    local hours, mins = math.modf(time * 24)
    local foo, secs = math.modf(mins * 60)
    mins = math.floor(mins * 60)
    secs = math.floor(secs * 60)

    handleLTHrs:set(hours)
    handleLTMins:set(formatPrecedingZeros(mins,2))
    handleLTSecs:set(secs)
end

function resetFlightTimer()
    -- can only be reset on the ground
    if sensor_data.getWOW_LeftMainLandingGear() == 1 then
        liftOffTime = -1
        flightTime = 0
    end
end

function updateFlightTimer()
    -- I don't trust this script to update accurately enough to just count up, so we will use the DCS mission clock
    
    -- There is problem where WOW is 0 at spawn, so we need to workaround by detecting ground start
    if (birth == "GROUND_HOT" or birth == "GROUND_COLD") and firstWoW == true then
        if sensor_data.getWOW_LeftMainLandingGear() == 0 then
            firstWoW = true
        end
    else
        firstWoW = false
    end

    -- Once back on the ground, set false again
    if sensor_data.getWOW_LeftMainLandingGear() > 0 then
        firstWoW = false
    end
        
    -- Ignore the first start from ground
    if firstWoW == false and sensor_data.getWOW_LeftMainLandingGear() == 0 then
        if liftOffTime < 0 then
            liftOffTime = get_absolute_model_time()
        end

        flightTime = totalFlightTime + (get_absolute_model_time() - liftOffTime)
    elseif firstWoW == false and sensor_data.getWOW_LeftMainLandingGear() > 0 then
        liftOffTime = -1
        totalFlightTime = flightTime
    end
    
    --print_message_to_user("Abs: "..get_absolute_model_time().."; LOT: "..liftOffTime.."; firstWoW: "..tostring(firstWoW))
    local hours, mins = math.modf(flightTime/3600)
    local foo, secs = math.modf(mins * 60)
    mins = math.floor(mins * 60)
    secs = math.floor(secs * 60)
    
    handleFLTHrs:set(hours)
    handleFLTMins:set(formatPrecedingZeros(mins,2))
    handleFLTSecs:set(secs)
end

function resetStopwatch()
    swTime = 0
end

function toggleStopwatch()
    -- Fucking lua...
    if swRunning then
        swRunning = false
        --print_message_to_user("off")
    else
        swRunning = true
        --print_message_to_user("on")
    end
end

function updateStopwatch()
    -- Because pausing, we'll use counter in this, even if might be less accurate
    if swRunning then
        swTime = swTime + update_time_step
    end
    
    local hours, mins = math.modf(swTime/3600)
    local foo, secs = math.modf(mins * 60)
    mins = math.floor(mins * 60)
    secs = math.floor(secs * 60)
    
    handleSWHrs:set(hours)
    handleSWMins:set(formatPrecedingZeros(mins,2))
    handleSWSecs:set(secs)
end