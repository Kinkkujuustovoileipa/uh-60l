modeIndex = 0
pageIndex = 0
displayIndex = 0
displayKnobIndex = 0
waypointData = get_mission_route()

waypoints = {}
currWP = 1
currTGTWP = 1
currHardcodedWP = 91
inputArray = {}

INPUT_ALLOWANCE_TIME = 1 -- time user has after pressing input button to press another
inputTime = INPUT_ALLOWANCE_TIME
runInputTimeOut = false

displayHandle = get_param_handle("ASN128_PAGE")

function initVisibilityArgs()
    local pageIndex = displayHandle:get()
    if data.pages[pageIndex] then
        local numEditableValues = data.pages[pageIndex].numEditableValues

        for i=1,numEditableValues do
            local paramHandle = get_param_handle(data.pages[pageIndex][i].paramHandleString.."_VIS")
            paramHandle:set(1)
        end
    end
end

function parseInputData()
    local str = ""
    for k,v in pairs(inputArray) do
        str = str..v
    end

    return str
end

function startInputClearTimer()
    runInputTimeOut = true
end

function updateInputTimeOut()
    if kybdModeEnabled == false then
        if runInputTimeOut then
            inputTime = inputTime - update_time_step
        end

        if inputTime <= 0 then
            onInputTimerComplete()
            inputTime = INPUT_ALLOWANCE_TIME
            runInputTimeOut = false
            inputArray = {}
        end
    else
        runInputTimeOut = false
        inputTime = INPUT_ALLOWANCE_TIME
    end
end

function splitString(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function formatMGRSString(s)
    local t = splitString(s, " ")
    local sqidgrid = string.upper(tostring(t[1])..tostring(t[2]).." "..tostring(t[3]))
    local easting = string.upper(string.sub(tostring(t[4]), 1, 4))
    local northing = string.upper(string.sub(tostring(t[5]), 1, 4))

    return sqidgrid, easting.." "..northing
end

function formatLatString(lat,long)
    local latDeg = math.floor(lat)
    local latHemi = "S"
    if latDeg > 0 then
        latHemi = "N"
    end
    local longDeg = math.floor(long)
    local longHemi = "W"
    if longDeg > 0 then
        longHemi = "E"
    end

    local latMin = formatPrecedingZeros(string.format("%.2f",(lat - latDeg) * 60), 5)
    local longMin = formatPrecedingZeros(string.format("%.2f",(long - longDeg) * 60), 5)

    return latHemi..formatPrecedingSpaces(tostring(math.abs(latDeg)), 3).."°"..latMin.."'", longHemi..formatPrecedingZeros(tostring(math.abs(longDeg)), 3).."°"..longMin.."'"
end

function unFormatLatString(lat,long)
    local latD = tonumber(lat:sub(2,4))
    local latM = tonumber(lat:sub(7,11)) / 60
    local latDec = latD + latM

    if lat:sub(1,1) == "S" then
        latDec = -latDec
    end

    local longD = tonumber(long:sub(2,4))
    local longM = tonumber(long:sub(7,11)) / 60
    local longDec = longD + longM

    --print_message_to_user(long:sub(1,1))
    if long:sub(1,1) == "W" then
        longDec = -longDec
    end

    --print_message_to_user(lat.."; "..latDec.."; "..long.."; "..longDec)
    return latDec, longDec
end

-- starts at given index and returns next available wp slot that isn't already used
function getNextEmptyWaypoint(waypointData, startIndex)
    for i = startIndex, 100 do
        if (waypointData[i] == nil or waypointData[i] == '') then
            --move on
        else
            return i
        end
    end

    return startIndex
end

function addWaypoint(num, wpName, xPos, yPos, alt)
    table.insert(waypoints, {number = num, name = wpName, x = xPos, y = yPos, alt = alt})
end

need_to_be_closed = false
