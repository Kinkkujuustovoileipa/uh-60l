
local ALT_PRESSURE_MAX = 30.99 -- in Hg
local ALT_PRESSURE_MIN = 28.10 -- in Hg
local ALT_PRESSURE_STD = 29.92 -- in Hg
local baroScaleSetting = ALT_PRESSURE_STD
local baroScaleSettingRate = 0.002

paramAlt10000:set(0.0)
paramAlt1000:set(0.0)
paramAlt100:set(0.0)

local alt = 0

function post_initialize()
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then
    end
end

dev:listen_command(baroScaleSetCmd)

function SetCommand(command,value)   
    if command == baroScaleSetCmd then
		baroScaleSetting = baroScaleSetting + value / 10
		if baroScaleSetting > ALT_PRESSURE_MAX then
			baroScaleSetting = ALT_PRESSURE_MAX
		elseif baroScaleSetting < ALT_PRESSURE_MIN then
			baroScaleSetting = ALT_PRESSURE_MIN
		end
    elseif command == baroScaleSetCmd_Axis then
        value = value + 1
        baroScaleSetting = (value * 1.45 + 28.10)
        if baroScaleSetting > ALT_PRESSURE_MAX then
			baroScaleSetting = ALT_PRESSURE_MAX
		elseif baroScaleSetting < ALT_PRESSURE_MIN then
			baroScaleSetting = ALT_PRESSURE_MIN
		end
    elseif command == baroScaleSetCmdInc then
        --print_message_to_user(baroScaleSetting)
        baroScaleSetting = baroScaleSetting + baroScaleSettingRate
		if baroScaleSetting > ALT_PRESSURE_MAX then
			baroScaleSetting = ALT_PRESSURE_MAX
		elseif baroScaleSetting < ALT_PRESSURE_MIN then
			baroScaleSetting = ALT_PRESSURE_MIN
		end
    elseif command == baroScaleSetCmdDec then
    baroScaleSetting = baroScaleSetting - baroScaleSettingRate
        if baroScaleSetting > ALT_PRESSURE_MAX then
        baroScaleSetting = ALT_PRESSURE_MAX
        elseif baroScaleSetting < ALT_PRESSURE_MIN then
            baroScaleSetting = ALT_PRESSURE_MIN
        end
    end
end

function update_altimeter(powerState)
    if powerState > 0 then
        alt = sensor_data.getBarometricAltitude() * meters_to_feet
        paramEncoderFlag:set(1)
    else
        paramEncoderFlag:set(0)
    end

    local altNxxx = jumpwheel(baroScaleSetting * 100, 4)
    local altxNxx = jumpwheel(baroScaleSetting * 100, 3)
    local altxxNx = jumpwheel(baroScaleSetting * 100, 2)
    local altxxxN = jumpwheel(baroScaleSetting * 100, 1)

    paramBaroSetNxxx:set(altNxxx)
    paramBaroSetxNxx:set(altxNxx)
    paramBaroSetxxNx:set(altxxNx)
    paramBaroSetxxxN:set(altxxxN)

    local   temp,pressure =  weather.getTemperatureAndPressureAtPoint({position = sensor_data:getSelfCoordinates()})
	local pressureInches = pressure * 0.000295300586467
	--print_message_to_user(Dump(pressure * 0.000295300586467))
    
    local alt_adj = (baroScaleSetting - pressureInches) * 1000   -- 1000 feet per inHg / 10 feet per .01 inHg -- if we set higher pressure than actual => altimeter reads higher
    local baroAlt = round(alt + alt_adj)
    --print_message_to_user("base alt: "..alt.."; baroScaleSetting: "..baroScaleSetting.."; alt_adj: "..alt_adj.."; baroAlt: "..baroAlt)
    paramAlt10000:set(jumpwheel(baroAlt / 100, 1))
    paramAlt1000:set(jumpwheel(baroAlt / 100, 2))
    paramAlt100:set(jumpwheel(baroAlt / 100, 3))
end
