
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")
dofile(LockOn_Options.script_path..'ASN128/indicator/pageDefines.lua')
dofile(LockOn_Options.script_path..'ASN128/device/validators.lua')
dofile(LockOn_Options.script_path..'ASN128/device/utils.lua')
dofile(LockOn_Options.script_path..'ASN128/device/table.lua')
dofile(LockOn_Options.script_path..'ASN128/device/netConfig.lua')
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
update_time_step = 0.1
make_default_activity(update_time_step)

local ltrLeftEnabled = false
local ltrMidEnabled = false
local ltrRightEnabled = false

local bearingToNextWP = 0

local moreTextHandle = get_param_handle("ASN128_MORE")
local endTextHandle = get_param_handle("ASN128_END")
local okTextHandle = get_param_handle("ASN128_OK")

moreTextHandle:set("more")
endTextHandle:set("end")
okTextHandle:set("ok")

kybdModeEnabled = false
local kybdModeIndex = 1
local selectedVisibilityParam = "FOO"
local handle = get_param_handle(selectedVisibilityParam)

local paramASN128Pwr = get_param_handle("ASN128_POWER")

local topLineHandle = get_param_handle("ASN128_GENERIC_TOP_LINE")

local powerUpMode = true

local trackAngle = 0
local trackError = 0
local trackErrorDist = 0

local paramGroundSpeedX = get_param_handle("GROUNDSPEED_X")
local paramGroundSpeedY = get_param_handle("GROUNDSPEED_Y")
local paramGroundSpeedZ = get_param_handle("GROUNDSPEED_Z")

-- POWERUP
local dateHandle2 = get_param_handle("ASN128_DATE2")
local wmmHandle = get_param_handle("ASN128_WMMDATE")
local dafifStartDateHandle = get_param_handle("ASN128_DAFIF_STARTDATE")
local dafifEndDateHandle = get_param_handle("ASN128_DAFIF_ENDDATE")

-- WINDUTC
local windSpeedHandle = get_param_handle("ASN128_WIND_SPEED")
local windDirHandle = get_param_handle("ASN128_WIND_DIR")
local dateHandle = get_param_handle("ASN128_DATE")
local timeHandle = get_param_handle("ASN128_TIME")

-- XTK/TKE/KEY
local courseDisplayHandle = get_param_handle("ASN128_COURSEDISPLAY")
local crossTrackHandle = get_param_handle("ASN128_XTK")
local trackErrorHandle = get_param_handle("ASN128_TKE")

-- GS/TK/NAV
local groundSpeedHandle = get_param_handle("ASN128_GS")
local paramGroundSpeed = get_param_handle("GROUND_SPEED")
local trackAngleHandle = get_param_handle("ASN128_TK")
local directTrackAngleHandle = get_param_handle("ASN128_DTK")
local paramTrackAngle = get_param_handle("TRACK_ANGLE")

-- PP
local pPos1Handle = get_param_handle("ASN128_PPOS1")
local pPos2Handle = get_param_handle("ASN128_PPOS2")
local magVarHandle = get_param_handle("ASN128_MAGVAR")
local gpsAltHandle = get_param_handle("ASN128_GPSALT")
local magVarModeHandle = get_param_handle("ASN128_MAGVARMODE")

-- DISTBRGTIME
local navModeHandle = get_param_handle("ASN128_NAVMODE")
local legDistHandle = get_param_handle("ASN128_LEGDIST")
local legTimeHandle = get_param_handle("ASN128_LEGTIME")
local legNumHandle = get_param_handle("ASN128_LEGNUM")
local phaseOfFlightHandle = get_param_handle("ASN128_PHASE")
local phaseOfFlightShortHandle = get_param_handle("ASN128_PHASESHORT")

-- FLIGHT PLAN
local fpNameHandle = get_param_handle("ASN128_FLIGHTPLAN_NAME")
local fpNextWPHandle = get_param_handle("ASN128_FLIGHTPLAN_NEXT_WP")
local fpNumWPsHandle = get_param_handle("ASN128_FLIGHTPLAN_NUM_WPS")
local fpCurrFPHandle = get_param_handle("ASN128_FLIGHTPLAN_CURR_FP")

-- AVS7
local avs7wpBrgHandle = get_param_handle("AVS7_WP_BRG")
local avs7wpDistHandle = get_param_handle("AVS7_WP_DIST")
local avs7wpIndHandle = get_param_handle("AVS7_WPIND")
local avs7GSHandle = get_param_handle("AVS7_GS")
local avs7wpToHandle = get_param_handle("AVS7_WPTO")
local avs7wpFromHandle = get_param_handle("AVS7_WPFROM")

local moreStepEnabled = false
local endStepEnabled = false

local wpSequence = {}
local flightPlanType = 0
local currLeg = 1
local currToo = 90

-- CISP
local paramGPSBearing = get_param_handle("CISP_GPS_BEARING")
local paramGPSDist = get_param_handle("CISP_GPS_DISTANCE")
local paramGPSAvail = get_param_handle("CISP_GPS_AVAILABLE")
local paramGPSCourse = get_param_handle("CISP_GPS_COURSE")
local paramGPSTrackError = get_param_handle("CISP_GPS_TRACKERROR")

local pilotN1Bug = get_param_handle("PILOT_HSI_DOPPLERGPS_POINTER")

function post_initialize()
    initWaypoints()
    initVisibilityArgs()
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        powerUpMode = false
		dev:performClickableAction(device_commands.SelectMode,0.03,true)
		dev:performClickableAction(device_commands.SelectDisplay,0.03,true)
		dev:performClickableAction(device_commands.SelectBtnInc,1,true) -- put on dest waypoint
		dev:performClickableAction(device_commands.SelectBtnInc,0,true) -- put on dest waypoint
    elseif birth=="GROUND_COLD" then
    end
    pilotN1Bug:set(0)
    for k,v in pairs(Terrain) do
        --print_message_to_user(Dump(k))
    end
end

dev:listen_command(device_commands.SelectMode)
dev:listen_command(device_commands.SelectDisplay)
dev:listen_command(Keys.SelectModeInc)
dev:listen_command(Keys.SelectModeDec)
dev:listen_command(Keys.SelectDisplayInc)
dev:listen_command(Keys.SelectDisplayDec)
dev:listen_command(device_commands.SelectBtnKybd)
dev:listen_command(device_commands.SelectBtnLtrLeft)
dev:listen_command(device_commands.SelectBtnLtrMid) 
dev:listen_command(device_commands.SelectBtnLtrRight)
dev:listen_command(device_commands.SelectBtnF1)
dev:listen_command(device_commands.SelectBtn1) 
dev:listen_command(device_commands.SelectBtn2)
dev:listen_command(device_commands.SelectBtn3) 
dev:listen_command(device_commands.SelectBtnTgtStr)
dev:listen_command(device_commands.SelectBtn4)
dev:listen_command(device_commands.SelectBtn5)
dev:listen_command(device_commands.SelectBtn6)
dev:listen_command(device_commands.SelectBtnInc)
dev:listen_command(device_commands.SelectBtn7)
dev:listen_command(device_commands.SelectBtn8)
dev:listen_command(device_commands.SelectBtn9)
dev:listen_command(device_commands.SelectBtnDec)
dev:listen_command(device_commands.SelectBtnClr)
dev:listen_command(device_commands.SelectBtn0)
dev:listen_command(device_commands.SelectBtnEnt)

function SetCommand(command,value)
    -- TODO: power requirement
    if command == device_commands.SelectMode then
        selectMode(value)
    elseif command == Keys.SelectModeInc and modeIndex < 5 then
        dev:performClickableAction(device_commands.SelectMode, modeIndex/100 + 0.01, false)
    elseif command == Keys.SelectModeDec and modeIndex > 0 then
        dev:performClickableAction(device_commands.SelectMode, modeIndex/100 - 0.01, false)
    elseif command == device_commands.SelectDisplay then
        selectDisplay(value)
    elseif command == Keys.SelectDisplayInc and displayIndex < 60 then
        dev:performClickableAction(device_commands.SelectDisplay, displayIndex/1000 + 0.01, false)
    elseif command == Keys.SelectDisplayDec and displayIndex > 1 then
        dev:performClickableAction(device_commands.SelectDisplay, displayIndex/1000 - 0.01, false)
    else
        buttonHandler(command, value)
    end
end

function selectMode(value)
    kybdModeEnabled = false
    moreTextHandle:set("more")
    endTextHandle:set("end")
    inputArray = {}
    modeIndex = math.ceil(value * 100)

    if modeIndex == 0 or modeIndex == 1 or modeIndex == 2 or modeIndex == 5 then
        changePage(-1)
        if modeIndex == 0 then
            powerUpMode = true
        end
    elseif modeIndex == 3 or modeIndex == 4 then
        if powerUpMode then
            changePage(POWERUP_1)
        else
            changePage(displayIndex)
        end
    end
end

function selectDisplay(value)
    displayKnobIndex = value
    kybdModeEnabled = false
    moreTextHandle:set("more")
    endTextHandle:set("end")
    inputArray = {}
    if powerUpMode then return end

    displayIndex = math.ceil(value * 100)
    
    if (modeIndex == 3 or modeIndex == 4) then
        if displayIndex == 0 then
            changePage(WINDUTC_DATA_1)
        elseif displayIndex == 1 then
            changePage(XTKTKEKEY_1)
        elseif displayIndex == 2 then
            changePage(GSTKNAVM_1)
        elseif displayIndex == 3 then
            changePage(PP_1)
        elseif displayIndex == 4 then
            changePage(DISTBRGTIME_1)
        elseif displayIndex == 5 then
            changePage(WPTGT_1)
        elseif displayIndex == 6 then
            changePage(DATUMROUTE_1)
        end
    end
end

function buttonFunctions(command)
    if (command == device_commands.SelectBtnInc) then
        if (kybdModeEnabled == false) then
            if displayIndex == 50 or displayIndex == 51 then
                if (currTGTWP < 100) then
                    currTGTWP = currTGTWP + 1
                else
                    currTGTWP = 1
                end

                if data.pages[displayIndex] then
                    data.pages[displayIndex].getStoredData()
                    initVisibilityArgs()
                end
            else
                if (currWP < 100) then
                    currWP = currWP + 1
                else
                    currWP = 1
                end
            end
        end
    elseif (command == device_commands.SelectBtnDec) then
        if (kybdModeEnabled == false) then
            if displayIndex == 50 or displayIndex == 51 then
                if (currTGTWP > 1) then
                    currTGTWP = currTGTWP - 1
                else
                    currTGTWP = 100
                end

                if data.pages[displayIndex] then
                    data.pages[displayIndex].getStoredData()
                    initVisibilityArgs()
                end
            else
                if (currWP > 1) then
                    currWP = currWP - 1
                else
                    currWP = 100
                end
            end
        end
    elseif (command == device_commands.SelectBtnTgtStr) then
        if (kybdModeEnabled == false) then
            addTOOWaypoint()
        end
    elseif (command == device_commands.SelectBtnEnt) then
        if displayIndex == POWERUP_2 then
            powerUpMode = false
            selectDisplay(displayKnobIndex)
            return
        end

        if kybdModeEnabled then
            -- we pass this on to numHandler() since that already has page & item logic
            numKeyHandler(command)
        else
            if moreStepEnabled then
                changePage(displayIndex + 1)
            elseif endStepEnabled then
                local targetPage
                -- handle some edge cases...
                if (displayIndex == WINDUTC_DOWNLOAD or displayIndex == WINDUTC_DAFIF or displayIndex == WINDUTC_CONFIG or displayIndex == WINDUTC_NETWORKENTRY) then
                    targetPage = WINDUTC_DATA_3
                else -- otherwise just take us back to the lead page
                    targetPage = math.floor(displayIndex/10) * 10
                    if targetPage == 0 then targetPage = 1 end
                end

                changePage(targetPage)
            end
        end
    elseif command == device_commands.SelectBtnKybd then
        -- only allow editing 0-69
        if (currTGTWP <= 70 or currTGTWP > 90) then
            inputArray = {}
            setKybdMode()
        end
    end
end

function buttonHandler(command, value)
    --Discard 0 value (key release) for now, later might need to hand press for duration
    if (value > 0) then
        --Divide into function and data keys
        if (command == device_commands.SelectBtnKybd or command == device_commands.SelectBtnF1 or command == device_commands.SelectBtnInc or command == device_commands.SelectBtnDec or command == device_commands.SelectBtnEnt or command == device_commands.SelectBtnTgtStr) then
            --print_message_to_user("func")
            buttonFunctions(command)
        elseif (command == device_commands.SelectBtn1 or command == device_commands.SelectBtn2 or command == device_commands.SelectBtn3 or command == device_commands.SelectBtn4 or command == device_commands.SelectBtn5 or command == device_commands.SelectBtn6 or command == device_commands.SelectBtn7 or command == device_commands.SelectBtn8 or command == device_commands.SelectBtn9 or command == device_commands.SelectBtn0 or command == device_commands.SelectBtnClr) then
            --print_message_to_user("num")
            numKeyHandler(command)
        else
            --print_message_to_user("special")
            if (command == device_commands.SelectBtnLtrLeft) then
                if kybdModeEnabled then
                    ltrLeftEnabled = true
                end
            elseif (command == device_commands.SelectBtnLtrMid) then
                if kybdModeEnabled then
                    ltrMidEnabled = true
                end
            elseif (command == device_commands.SelectBtnLtrRight) then
                if kybdModeEnabled then
                    ltrRightEnabled = true
                end
            end
        end
    end
end

-- long painful function because lua doesn't support fucking switch cases!
function getKeyValue(command)
    local latHemiOnly = (modeIndex == 4 and pageIndex == 50 and kybdModeEnabled and kybdModeIndex == 2 and #inputArray == 0)
    local longHemiOnly = (modeIndex == 4 and pageIndex == 50 and kybdModeEnabled and kybdModeIndex == 3 and #inputArray == 0)
    local long100Only = (modeIndex == 4 and pageIndex == 50 and kybdModeEnabled and kybdModeIndex == 3 and #inputArray == 1)

    if latHemiOnly then
        if command == device_commands.SelectBtn5 then
            return "N"
        elseif command == device_commands.SelectBtn7 then
            return "S"
        else
            return ""
        end
    end

    if longHemiOnly then
        if command == device_commands.SelectBtn2 then
            return "E"
        elseif command == device_commands.SelectBtn8 then
            return "W"
        else
            return ""
        end
    end

    if long100Only then
        if command == device_commands.SelectBtn1 then
            return "1"
        elseif command == device_commands.SelectBtn0 then
            return "0"
        else
            return ""
        end
    end

    if (command == device_commands.SelectBtn1) then
        if ltrLeftEnabled then
            return "A"
        elseif ltrMidEnabled then
            return "B"
        elseif ltrRightEnabled then
            return "C"
        else
            return "1"
        end
    elseif (command == device_commands.SelectBtn2) then
        if ltrLeftEnabled then
            return "D"
        elseif ltrMidEnabled then
            return "E"
        elseif ltrRightEnabled then
            return "F"
        else
            return "2"
        end
    elseif (command == device_commands.SelectBtn3) then
        if ltrLeftEnabled then
            return "G"
        elseif ltrMidEnabled then
            return "H"
        elseif ltrRightEnabled then
            return "I"
        else
            return "3"
        end
    elseif (command == device_commands.SelectBtn4) then
        if ltrLeftEnabled then
            return "J"
        elseif ltrMidEnabled then
            return "K"
        elseif ltrRightEnabled then
            return "L"
        else
            return "4"
        end
    elseif (command == device_commands.SelectBtn5) then
        if ltrLeftEnabled then
            return "M"
        elseif ltrMidEnabled then
            return "N"
        elseif ltrRightEnabled then
            return "O"
        else
            return "5"
        end
    elseif (command == device_commands.SelectBtn6) then
        if ltrLeftEnabled then
            return "P"
        elseif ltrMidEnabled then
            return "Q"
        elseif ltrRightEnabled then
            return "R"
        else
            return "6"
        end
    elseif (command == device_commands.SelectBtn7) then
        if ltrLeftEnabled then
            return "S"
        elseif ltrMidEnabled then
            return "T"
        elseif ltrRightEnabled then
            return "U"
        else
            return "7"
        end
    elseif (command == device_commands.SelectBtn8) then
        if ltrLeftEnabled then
            return "V"
        elseif ltrMidEnabled then
            return "W"
        elseif ltrRightEnabled then
            return "X"
        else
            return "8"
        end
    elseif (command == device_commands.SelectBtn9) then
        if ltrLeftEnabled then
            return "Y"
        elseif ltrMidEnabled then
            return "Z"
        elseif ltrRightEnabled then
            return "*"
        else
            return "9"
        end
    elseif (command == device_commands.SelectBtn0) then
        if ltrLeftEnabled then
            return "#"
        elseif ltrMidEnabled then
            return "#"
        elseif ltrRightEnabled then
            return "#"
        else
            return "0"
        end
    end
end

-- handles num/letterpad input cases
function numKeyHandler(command)
    local enterData = false
    local keyValue
    if command == device_commands.SelectBtnClr then
        table.remove(inputArray, #inputArray)
    elseif command == device_commands.SelectBtnEnt then
        enterData = true
    else
        keyValue = getKeyValue(command)
        if keyValue ~= "" then
            table.insert(inputArray, keyValue)
        end
    end

    ltrLeftEnabled = false
    ltrMidEnabled = false
    ltrRightEnabled = false

    if kybdModeEnabled then
        if enterData then
            if data.pages[pageIndex].validator() then
                data.pages[pageIndex].setStoredData()
                inputArray = {}
                kybdModeEnabled = false
                moreTextHandle:set("more")
                endTextHandle:set("end")
            end
        else
            --print_message_to_user(Dump(inputArray))
            data.pages[pageIndex][kybdModeIndex].updateInputData(parseInputData(inputArray))
        end
    else
        if pageIndex == WINDUTC_DATA_3 then -- selects WINDUTC page options
            if tonumber(keyValue) == 1 then
                changePage(WINDUTC_NETWORKENTRY)
            elseif tonumber(keyValue) == 2 then
                changePage(WINDUTC_DOWNLOAD)
            elseif tonumber(keyValue) == 3 then
                changePage(WINDUTC_DAFIF)
            elseif tonumber(keyValue) == 4 then
                changePage(WINDUTC_CONFIG)
            end
        elseif pageIndex == WINDUTC_NETWORKENTRY then -- selects WINDUTC page options
            if tonumber(keyValue) == 1 then
                changePage(WINDUTC_NETWORKSTART)
                dispatch_action(nil, EFM_commands.startServer, 1)
            elseif tonumber(keyValue) == 2 then
                changePage(WINDUTC_NETWORKCONNECT)
            end
        elseif pageIndex == WINDUTC_NETWORKCONNECT then -- selects WINDUTC page options
            if tonumber(keyValue) == 1 then
                dispatch_action(nil, EFM_commands.connectServer, .25)
                changePage(WINDUTC_NETWORKCONNECTSTATUS)
            elseif tonumber(keyValue) == 2 then
                dispatch_action(nil, EFM_commands.connectServer, 0.5)
                changePage(WINDUTC_NETWORKCONNECTSTATUS)
            elseif tonumber(keyValue) == 3 then
                dispatch_action(nil, EFM_commands.connectServer, 0.75)
                changePage(WINDUTC_NETWORKCONNECTSTATUS)
            elseif tonumber(keyValue) == 4 then
                dispatch_action(nil, EFM_commands.connectServer, 1)
                changePage(WINDUTC_NETWORKCONNECTSTATUS)
            end
        elseif pageIndex == DATUMROUTE_1 then -- selects DATUMROUTE page options
            if tonumber(keyValue) == 1 then
                changePage(DATUMROUTE_FP_1)
            elseif tonumber(keyValue) == 2 then
                changePage(DATUMROUTE_WP)
            elseif tonumber(keyValue) == 3 then
                changePage(DATUMROUTE_IAP)
            elseif tonumber(keyValue) == 4 then
                changePage(DATUMROUTE_RTCONSEC)
            end
        elseif pageIndex == WPTGT_1 or pageIndex == DISTBRGTIME_1 then -- selection of waypoint via numpad
            local wpNum = tonumber(parseInputData())
            if (wpNum < 100) then
                currWP = wpNum + 1
            end
            startInputClearTimer()
        end
    end
end

function onInputTimerComplete()
    inputArray = {}
end

function setKybdMode()
    local pageIndex = displayHandle:get()
    local numEditableValues = data.pages[pageIndex].numEditableValues
    if kybdModeEnabled == false then
        kybdModeEnabled = true
        kybdModeIndex = 1
        moreTextHandle:set("kybd")
        endTextHandle:set("kybd")
    else
        kybdModeIndex = kybdModeIndex + 1
        if kybdModeIndex > numEditableValues then
            kybdModeIndex = 1
        end
    end

    initVisibilityArgs()
    selectedVisibilityParam = data.pages[pageIndex][kybdModeIndex].paramHandleString.."_VIS"
end

function flashSelectedItem()
    handle:set(1) -- if the handle has changed, set the old one to 1
    handle = get_param_handle(selectedVisibilityParam)
    if kybdModeEnabled then
        handle:set(math.sin(get_absolute_model_time() * 16))
    else
        handle:set(1)
    end
end

-- handles page changing - including more/end stepping
function changePage(nextPageID)
    displayHandle:set(nextPageID)
    if nextPageID >= 0 then
        displayIndex = nextPageID
    end
    moreStepEnabled = false
    endStepEnabled = false
    okStepEnabled = false

    -- update page table data
    if data.pages[nextPageID] then
        data.pages[nextPageID].getStoredData()
        initVisibilityArgs()
    end

    for k,v in pairs(pagesMore) do
        if (nextPageID == v) then
            moreStepEnabled = true
            return
        end
    end

    for k,v in pairs(pagesEnd) do
        if (nextPageID == v) then
            endStepEnabled = true
            return
        end
    end

    for k,v in pairs(pagesOK) do
        if (nextPageID == v) then
            moreStepEnabled = true
            return
        end
    end
end

function initWaypoints()
    for i=1,100 do
        local num = formatPrecedingZeros(tostring(i-1), 2)
        local xPos = ""
        local yPos = ""
        local alt = ""
        local wpName = ""

        if (waypointData[i]) then
            xPos = waypointData[i].x
            yPos = waypointData[i].y
            alt = waypointData[i].alt

            if (waypointData[i].name) then
                wpName = string.sub(string.upper(waypointData[i].name),1,13)
            else
                wpName = "MIZ "..i-1
            end
        end

        addWaypoint(num, wpName, xPos, yPos, alt)
        --print_message_to_user("wpt added: "..num..", "..wpName)
        --default sequence using mission wp seq
        --table.insert(wpSequence, i)
    end
end

function addTOOWaypoint()
    local selfX,selfY,selfZ = sensor_data.getSelfCoordinates()
    local wpIndex = getNextEmptyWaypoint(waypoints, 91)
    local alt = formatYCoord(selfY, modeIndex)
    local wpName = ""

    if (wpIndex == -1) then
        wpName = "TGT"..formatPrecedingZeros(tostring(currToo-89), 2)
        wpIndex = currToo

        -- ran out of space, loop and overwrite
        if (currToo >= 99) then
            currToo = 90
        else
            currToo = currToo + 1
        end
    else
        -- free space
        wpName = "TGT"..formatPrecedingZeros(tostring(wpIndex-89), 2)
        if (wpIndex == 99) then
            currToo = 90
        else
            currToo = wpIndex+1
        end
    end

    waypoints[wpIndex+1].name = wpName
    waypoints[wpIndex+1].x = selfX
    waypoints[wpIndex+1].y = selfZ
    waypoints[wpIndex+1].alt = alt

    updateSelectedWpLine()
    refreshScreen()
end

function refreshScreen()
    data.pages[displayIndex].getStoredData()
    initVisibilityArgs()
end

function updateSelectedWpLine()
    local wpName = waypoints[currWP].name
    local shortName = string.sub(wpName,1,5)
    local text =  waypoints[currWP].number..":"..shortName
    local epeSysText = " 030MG"..currToo
    local len = 16 - string.len(text)
    text = text..formatPrecedingSpaces(epeSysText, len)

    topLineHandle:set(text)
end

--------------------------------------------------------------------------------------------

function updateWind()
    local lx, ly, lz = sensor_data.getSelfCoordinates()
    local windData = weather.getGroundWindAtPoint({position = {x=lx, y=ly, z=lz}})
    local windDir = windData.a * radian_to_degree
    local windSpeed = windData.v

    if (modeIndex == 4) then --LL
        windSpeedHandle:set("SP: "..formatPrecedingZeros(math.floor(windSpeed * msToKts), 3).."kt")
    else --MGRS
        windSpeedHandle:set("SP: "..formatPrecedingZeros(math.floor(windSpeed * msToKph), 3).."kph")
    end

    windDirHandle:set("DIR: "..formatPrecedingZeros(formatCompassDir(math.floor(windDir) - 180), 3).."°")
end

function updateDateTime()
    local time = get_absolute_model_time()
    local hours, mins = math.modf(time/3600)
    local foo, secs = math.modf(mins * 60)
    mins = math.floor(mins * 60)
    secs = math.floor(secs * 60)

    timeHandle:set("TIME: "..formatPrecedingZeros(math.floor(hours), 2)..":"..formatPrecedingZeros(math.floor(mins), 2)..":"..formatPrecedingZeros(math.floor(secs), 2))

    -- Bloody American date format, of course :(
    dateHandle:set("M:"..formatPrecedingZeros(LockOn_Options.date.month, 2).." D:"..formatPrecedingZeros(LockOn_Options.date.day, 2).." Y:"..LockOn_Options.date.year)
    dateHandle2:set("DATE: "..formatPrecedingZeros(LockOn_Options.date.month, 2).."/"..formatPrecedingZeros(LockOn_Options.date.day, 2).."/"..LockOn_Options.date.year)
    wmmHandle:set("WMM: "..formatPrecedingZeros(LockOn_Options.date.month, 2).."/"..formatPrecedingZeros(LockOn_Options.date.day, 2).."/"..LockOn_Options.date.year)
    dafifStartDateHandle:set("START: "..formatPrecedingZeros(LockOn_Options.date.month, 2).."/"..formatPrecedingZeros(LockOn_Options.date.day, 2).."/"..LockOn_Options.date.year - 2)
    dafifEndDateHandle:set("END: "..formatPrecedingZeros(LockOn_Options.date.month, 2).."/"..formatPrecedingZeros(LockOn_Options.date.day, 2).."/"..LockOn_Options.date.year - 1)
end

function updatePresentPosition()
    local curx,cury,curz = sensor_data.getSelfCoordinates()
	local current_lat,current_long = Terrain.convertMetersToLatLon(curx,curz)
    latStr,longStr = formatLatString(current_lat,current_long)
    local mgrs = Terrain.GetMGRScoordinates(curx,curz)
    local grid, coords = formatMGRSString(mgrs)
    local altitudeMeters = formatPrecedingZeros(math.floor(sensor_data.getBarometricAltitude() * 10) / 10, 5)
    local altitudeFeet = formatPrecedingZeros(math.floor(sensor_data.getBarometricAltitude() * meters_to_feet * 10) / 10, 5)
    
    if (modeIndex == 4) then
        pPos1Handle:set(latStr)
        pPos2Handle:set(longStr)
        gpsAltHandle:set("GPS:ALT+"..altitudeFeet.."ft")
    elseif (modeIndex == 3) then
        pPos1Handle:set(grid)
        pPos2Handle:set(coords)
        gpsAltHandle:set("GPS:ALT+"..altitudeMeters.."m")
    end

    local gsX = round(paramGroundSpeedX:get(), 1)
    local gsZ = round(paramGroundSpeedZ:get(), 1)

    local gs = math.sqrt(math.pow(gsX, 2) + (math.pow(gsZ, 2)))
    if (modeIndex == 4) then
        groundSpeedHandle:set("GS:"..formatPrecedingZeros(round(gs * msToKts), 3).."kt")
    elseif (modeIndex == 3) then
        groundSpeedHandle:set("GS:"..formatPrecedingZeros(round(gs * msToKph), 3).."kph")
    end

    paramGroundSpeed:set(gs)

    -- TODO: check this?
    trackAngle = formatCompassDir(360 - math.deg(sensor_data:getMagneticHeading()) + math.deg(math.atan(gsZ, gsX)))
    paramTrackAngle:set(trackAngle)
    trackAngleHandle:set("TK:"..formatPrecedingZeros(round(trackAngle), 3).."°")
end

function updateMagVar()
    local magVar = getDeclination()
    magVarHandle:set("V: "..magVar)
end

function updateWPInfo()
    local Xcoord = tonumber(waypoints[currWP].x)
    local Ycoord = tonumber(waypoints[currWP].y)

    local rangeKm  = "---"
    local rangeNm  = "---"
    local timeHour = "--"
    local timeMin  = "--"

    if (Xcoord and Ycoord) then
        local selfX,selfY,selfZ = sensor_data.getSelfCoordinates()
        local magVar = getDeclination()

        local relAngle = math.atan2((Ycoord-selfZ),(Xcoord-selfX))
        local northRelBearing = math.deg(relAngle)+magVar
        bearingToNextWP = formatCompassDir(northRelBearing)
        rangeKm = math.sqrt((Xcoord - selfX)^2 + (Ycoord - selfZ)^2) / 1000
        rangeNm = rangeKm * kmToNm

        local speedMS = math.max(paramGroundSpeed:get(), 60 / msToKts)
        local timeSecs = (rangeKm * 1000) / speedMS
        timeHour = formatPrecedingZeros(math.floor(timeSecs/3600),2)
        timeMin = formatPrecedingZeros(round((timeSecs/3600 - timeHour) * 60, 1), 4)

        -- Update the AN/AVS-7 with dist and brg info
        avs7wpBrgHandle:set(bearingToNextWP)
        avs7wpDistHandle:set(clamp(rangeKm, 0, 999.9))
        local relBearing = getShortestCompassPath(bearingToNextWP, getAircraftHeading())
        local wpIndPos = clamp((relBearing) / 60, -1, 1)
        avs7wpIndHandle:set(wpIndPos)

        -- Update CISP with dist and brg info
        paramGPSBearing:set(bearingToNextWP)
        paramGPSDist:set(rangeKm)
        paramGPSAvail:set(1)

        -- Get course and track error
        local lastWPXcoord
        local lastWPYcoord
        if currWP > 1 then
            lastWPXcoord = tonumber(waypoints[currWP-1].x)
            lastWPYcoord = tonumber(waypoints[currWP-1].y)
        end

        local course = 0
        trackError = 0

        if (lastWPXcoord and lastWPYcoord) then
            course = math.deg(math.atan2((Ycoord-lastWPYcoord),(Xcoord-lastWPXcoord)))
            trackError = getShortestCompassPath(bearingToNextWP, course)
        end

        local directTrackAngle = round(formatCompassDir(getShortestCompassPath(bearingToNextWP, trackAngle)))
        trackErrorDist = math.abs(rangeKm * math.sin(math.rad(trackError))) / math.sin(math.rad(90))

        paramGPSCourse:set(round(course))
        paramGPSTrackError:set(trackError)

        directTrackAngleHandle:set("DTK:"..formatPrecedingZeros(directTrackAngle, 3).."°")

        rangeNm = clamp(round(rangeNm, 1), 0, 999.9)
        rangeKm = clamp(round(rangeKm, 1), 0, 999.9)
    else
        -- Update CISP that there is no WP info
        paramGPSAvail:set(0)
        paramGPSBearing:set(0)
        paramGPSDist:set(0)
        paramGPSCourse:set(0)
        paramGPSTrackError:set(0)
    end
    
    if (modeIndex == 4) then
        legDistHandle:set(formatPrecedingZeros(rangeNm, 3).." nm "..formatPrecedingZeros(bearingToNextWP, 3).."°")
    elseif (modeIndex == 3) then
        legDistHandle:set(formatPrecedingZeros(rangeKm, 3).." km "..formatPrecedingZeros(bearingToNextWP, 3).."°")
    end

    legTimeHandle:set( timeHour.."h "..timeMin.."min")
end

function updateCourseDisplay()
    local isTo = false
    local relBearing = getRelativeBearing(bearingToNextWP)
    local toFrStr = "\\/"

    if -90 < relBearing and relBearing < 90 then
        toFrStr = "/\\"
        avs7wpToHandle:set(1)
        avs7wpFromHandle:set(0)
    else
        avs7wpToHandle:set(0)
        avs7wpFromHandle:set(1)
    end

    local indPos = 8
    local xtkStr
    if trackError < 0 then
        indPos = round(clamp(trackError, -20, 0) / 20 * 8) + 9
        xtkStr = "L"
    else
        indPos = round(clamp(trackError, 0, 20) / 20 * 8) + 8
        xtkStr = "R"
    end
    
    local str = "----------------"
    str = str:sub(1, indPos - 1).."|"..str:sub(indPos + 1)
    str = str:sub(1, 7)..toFrStr..str:sub(10)

    courseDisplayHandle:set(str)
    
    local localisedXTK = trackErrorDist
    local localisedUnit = "km"
    if (modeIndex == 4) then
        localisedXTK = trackErrorDist * kmToNm
        localisedUnit = "nm"
    end

    local tkeStr = "R"
    if relBearing < 0 then
        tkeStr = "L"
    end

    crossTrackHandle:set("XTK: "..xtkStr..formatPrecedingZeros(round(localisedXTK, 2), 2)..localisedUnit)
    trackErrorHandle:set("TKE: "..tkeStr..formatPrecedingZeros(math.abs(round(relBearing)), 3).."°")
end

function updateFlightPlan()
    -- 0 = FLIGHT PLAN
    -- 1 = VTF (Vector To Final)
    -- 2 = DIRECT-TO
    -- 3 = OBS (Omni Bearing Seach)

    if flightPlanType == 0 then
        navModeHandle:set("FLIGHT PLAN")
    elseif flightPlanType == 1 then
        navModeHandle:set("VTF")
    elseif flightPlanType == 2 then
        navModeHandle:set("DIRECT-TO")
    elseif flightPlanType == 3 then
        navModeHandle:set("OBS")
    end
    legNumHandle:set("L:"..formatPrecedingZeros(currLeg, 2))
end

function updateEditableUI()
    local pageIndex = displayHandle:get()
    if data.pages[pageIndex] then
        local numEditableValues = data.pages[pageIndex].numEditableValues

        for i=1,numEditableValues do
            local paramHandle = get_param_handle(data.pages[pageIndex][i].paramHandleString)
            paramHandle:set(data.pages[pageIndex][i].inputData)
        end
    end
end

function update()
    pageIndex = displayHandle:get()
    updateNetworkArgs(GetSelf())
    local hasPower = paramCB_DPLR:get() > 0 and paramCB_26VACDPLR:get() > 0
    paramASN128Pwr:set(paramCB_DPLR:get() * paramCB_26VACDPLR:get())
    
    if hasPower then
        updateWind()
        updateDateTime()
        updatePresentPosition()
        updateMagVar()
        updateSelectedWpLine()
        updateWPInfo()
        updateFlightPlan()
        updateCourseDisplay()

        flashSelectedItem()
        updateEditableUI()
    else
        paramGPSAvail:set(0)
    end

    updateInputTimeOut()
end

need_to_be_closed = false
