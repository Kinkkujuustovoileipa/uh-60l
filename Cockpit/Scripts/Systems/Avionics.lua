dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.05  
make_default_activity(update_time_step)

local current_hdg = get_param_handle("CURRENT_HDG")
local TOT1 = get_param_handle("TOT1")
local TOT2 = get_param_handle("TOT2")
local N1RPM1 = get_param_handle("N1_RPM1")
local N1RPM2 = get_param_handle("N1_RPM2")

local pilotADIHdg = 0
local rollCommandHdg = false
local pilotAltHoldOn = false
local pilotAltHoldAltitude = 0

-- Magnetic Compass
local paramMagCompBank = get_param_handle("MAGCOMPASS_BANK")
local paramMagCompPitch = get_param_handle("MAGCOMPASS_PITCH")

-- Stabliator Indicators
local paramStabInd = get_param_handle("STABIND")
local paramStabIndFlag = get_param_handle("STABINDFLAG")

current_hdg:set(0)
TOT1:set(0)
TOT2:set(0)
N1RPM1:set(0)
N1RPM2:set(0)

paramMagCompBank:set(0)
paramMagCompPitch:set(0)

function post_initialize()
	current_hdg:set(360-(sensor_data.getMagneticHeading()*radian_to_degree))

	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
		
    elseif birth=="GROUND_COLD" then
		paramStabInd:set(1)
    end
end

function SetCommand(command,value)   

end

function updateMagCompass()
	local bankAngle = sensor_data.getRoll() * radian_to_degree
	local pitchAngle = sensor_data.getPitch() * radian_to_degree
	paramMagCompBank:set(bankAngle / 180)
	paramMagCompPitch:set(pitchAngle / 180)
end

function updateStabInd()
	if paramCB_STABIND:get() > 0 then
		paramStabIndFlag:set(1)
		paramStabInd:set(get_aircraft_draw_argument_value(14))
	else
		paramStabIndFlag:set(0)
	end
end

function update()
	updateNetworkArgs(GetSelf())
	current_hdg:set(360-(sensor_data.getHeading()*radian_to_degree))
	TOT1:set(sensor_data.getEngineRightTemperatureBeforeTurbine())
	TOT2:set(sensor_data.getEngineLeftTemperatureBeforeTurbine())
	N1RPM1:set(sensor_data.getEngineRightRPM())
	N1RPM2:set(sensor_data.getEngineLeftRPM())
	
	updateMagCompass()
	updateStabInd()
end

need_to_be_closed = false 