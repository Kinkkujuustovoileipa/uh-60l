
local getStoredWPTGT1

flightplans =
{
    [1] =
    {
        name = "",
        waypoints = {}
    },
    [2] =
    {
        name = "",
        waypoints = {}
    },
    [3] =
    {
        name = "",
        waypoints = {}
    }
}

data =
{
    pages =
    {
        [50] =
        {
            numEditableValues = 3,
            [1] =
            {
                paramHandleString = "ASN128_CURRENT_WP",
                inputData = "",
                updateInputData = function(input)
                    data.pages[50][1].inputData = formatPrecedingZeros(waypoints[currWP].number, 2)..":"..input
                end,
            },
            [2] =
            {
                paramHandleString = "ASN128_WP_POS_1",
                inputData = "",
                updateInputData = function(input)
                    --print_message_to_user(input)
                    if modeIndex == 3 then
                        data.pages[50][2].inputData = input:sub(1,3).." "..input:sub(4,5)..";"
                    else
                        data.pages[50][2].inputData = input:sub(1,1).." "..input:sub(2,3).."°"..input:sub(4,5).."."..input:sub(6,7)
                    end
                end,
            },
            [3] =
            {
                paramHandleString = "ASN128_WP_POS_2",
                inputData = "",
                updateInputData = function(input)
                    --print_message_to_user(input)
                    if modeIndex == 3 then
                        data.pages[50][3].inputData = input:sub(1,4).." "..input:sub(5,8)..";"
                    else
                        data.pages[50][3].inputData = input:sub(1,1)..input:sub(2,4).."°"..input:sub(5,6).."."..input:sub(7,8)
                    end
                end,
            },
            getStoredData = function()
                local text =  formatPrecedingZeros(waypoints[currTGTWP].number, 2)..":"..waypoints[currTGTWP].name
                data.pages[50][1].inputData = text
                
                local wpPos1DisplayData
                local wpPos2DisplayData

                if (waypoints[currTGTWP].x ~= "" and waypoints[currTGTWP].y ~= "") then
                    -- WP POS
                    local mgrs = Terrain.GetMGRScoordinates(waypoints[currTGTWP].x,waypoints[currTGTWP].y) 
                    local current_lat,current_long = Terrain.convertMetersToLatLon(waypoints[currTGTWP].x,waypoints[currTGTWP].y)
                    latStr,longStr = formatLatString(current_lat,current_long)
                        
                    if modeIndex == 3 then
                        wpPos1DisplayData, wpPos2DisplayData = formatMGRSString(mgrs)
                    else
                        wpPos1DisplayData = latStr
                        wpPos2DisplayData = longStr
                    end
                else
                    wpPos1DisplayData = "---"
                    wpPos2DisplayData = "---"                  
                end
            
                data.pages[50][2].inputData = (tostring(wpPos1DisplayData))
                data.pages[50][3].inputData = (tostring(wpPos2DisplayData))
            end,
            setStoredData = function()
                local wpName = data.pages[50][1].inputData
                local wpPos1 = data.pages[50][2].inputData
                local wpPos2 = data.pages[50][3].inputData
                local posX, posY

                if string.find(wpPos1, ";") then
                    wpPos1 = wpPos1:gsub('%;', '')
                end

                if string.find(wpPos2, ";") then
                    wpPos2 = wpPos2:gsub('%;', '')
                end

                if modeIndex == 3 then -- MGRS SQID + GRID ENTRY
                    local mgrsString = wpPos1.." "..wpPos2
                    posX, posY = Terrain.convertMGRStoMeters(mgrsString)
                    --print_message_to_user("Store MGRS input: "..mgrsString.." "..posX.." "..posY)

                else -- LAT ENTRY
                    local lat,long = unFormatLatString(wpPos1,wpPos2)
                    posX, posY = Terrain.convertLatLonToMeters(lat,long)
                end

                waypoints[currTGTWP].x = posX
                waypoints[currTGTWP].y = posY

                waypoints[currTGTWP].name = wpName:sub(4,#wpName)
            end,
            validator = function()
                local result = false
                local wpPos1 = data.pages[50][2].inputData
                local wpPos2 = data.pages[50][3].inputData
                --print_message_to_user("1: "..wpPos1.." 2: "..wpPos2)
                if string.find(wpPos1, ";") then
                    wpPos1 = wpPos1:gsub('%;', '')
                end

                if string.find(wpPos2, ";") then
                    wpPos2 = wpPos2:gsub('%;', '')
                end
                --print_message_to_user("1: "..wpPos1.." 2: "..wpPos2)
                
                if modeIndex == 3 then
                    if (wpPos2 == "---" or wpPos2 == nil) then
                        data.pages[50][3].inputData, wpPos2 = "00"
                    end
                    local mgrsString = wpPos1.." "..wpPos2
                    local posX, posY = Terrain.convertMGRStoMeters(mgrsString)
                    --print_message_to_user("Validate MGRS input: "..mgrsString.." "..posX.." "..posY)
                    if posX ~= 0 and posZ ~= 0 then
                        result =  true
                    end
                else
                    local lat,long = unFormatLatString(wpPos1,wpPos2)
                    local posX, posY = Terrain.convertLatLonToMeters(lat,long)
                    --print_message_to_user("Validate LL input: "..posX.." "..posY)
                    if posX ~= 0 and posZ ~= 0 then
                        result =  true
                    end
                end

                return result
            end,
        },
        [51] =
        {
            numEditableValues = 2,
            [1] =
            {
                paramHandleString = "ASN128_CURRENT_WP",
                inputData = "",
                updateInputData = function(input)
                    data.pages[51][1].inputData = formatPrecedingZeros(waypoints[currWP].number, 2)..":"..input
                end,
            },
            [2] = {
                paramHandleString = "ASN128_WP_GPSALT",
                inputData = "",
                updateInputData = function(input)
                    --print(input)
                    if input.sub(#input-1, #input) == "/" then
                        input = input.sub(1, #input-1)
                    end
                    input = formatPrecedingZeros(input, 6)
                    if modeIndex == 3 then
                        data.pages[51][2].inputData = "GPS:ALT+"..input:sub(1,5).."."..input:sub(6,7).."m"
                    else
                        data.pages[51][2].inputData = "GPS:ALT+"..input:sub(1,5).."."..input:sub(6,7).."f"
                    end
                end,
            },
            getStoredData = function()
                local text =  formatPrecedingZeros(waypoints[currTGTWP].number, 2)..":"..waypoints[currTGTWP].name
                data.pages[51][1].inputData = text
                
                local alt
                
                if (waypoints[currTGTWP].alt ~= "") then
                    --print_message_to_user(waypoints[currTGTWP].alt)
                    if modeIndex == 3 then
                        alt = tostring(math.floor(waypoints[currTGTWP].alt * 10))
                    else
                        alt = tostring(math.floor(waypoints[currTGTWP].alt * meters_to_feet * 10))
                    end
                else
                    alt = "-------"               
                end
            
                data.pages[51][2].updateInputData(alt)
            end,
            setStoredData = function()
                local wpName = data.pages[51][1].inputData
                local wpAlt = data.pages[51][2].inputData

                local alt
                if modeIndex == 3 then -- MGRS SQID + GRID ENTRY
                    alt = tonumber(wpAlt)
                else -- LAT ENTRY
                    alt = tonumber(wpAlt) / meters_to_feet
                end

                waypoints[currTGTWP].alt = alt

                waypoints[currTGTWP].name = wpName:sub(4,#wpName)
            end,
            validator = function()
                local result = false
                local input = data.pages[51][2].inputData
                input = input:sub(9, #input - 1)
                if tonumber(input) then
                    result = true
                end

                return result
            end,
        },
        [67] =
        {
            numEditableValues = 2,
            [1] =
            {
                paramHandleString = "ASN128_RTCONSEC_START",
                inputData = "",
                updateInputData = function(input)
                    data.pages[67][1].inputData = "STARTS: "..input:sub(1,2)
                end,
            },
            [2] = {
                paramHandleString = "ASN128_RTCONSEC_END",
                inputData = "",
                updateInputData = function(input)
                    data.pages[67][2].inputData = "END: "..input:sub(1,2)
                end,
            },
            getStoredData = function()

            end,
            setStoredData = function()

            end,
            validator = function()
                local result = false
                return result
            end,
        }
    }
}
