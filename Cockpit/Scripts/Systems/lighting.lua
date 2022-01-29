dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local update_time_step = 0.01 --update will be called 10 times per second
make_default_activity(update_time_step)
local sensor_data = get_base_data()

elec_dc_ok  = get_param_handle("DC_BUS_ON")
paramLightsCpltInst = get_param_handle("LIGHTING_CPLT_INST")
paramLightsPltInst = get_param_handle("LIGHTING_PLT_INST")
paramLightsNonFLtInst = get_param_handle("LIGHTING_NON_FLT_INST")
paramLightsUpperConsole = get_param_handle("LIGHTING_UPPER_CONSOLE")
paramLightsLowerConsole = get_param_handle("LIGHTING_LOWER_CONSOLE")
paramLightsSwitches = get_param_handle("LIGHTING_SWITCHES")
paramLightsGlareshield = get_param_handle("LIGHTING_GLARESHIELD")
paramLightsPltRdrAlt = get_param_handle("LIGHTING_PLT_RDR_ALT")
paramLightsCpltRdrAlt = get_param_handle("LIGHTING_CPLT_RDR_ALT")
paramLightsMagCompass = get_param_handle("LIGHTING_MAGCOMPASS")
paramightsDomeBlue = get_param_handle("LIGHTING_DOME_BLUE")
paramightsDomeWhite = get_param_handle("LIGHTING_DOME_WHITE")

paramProbeState = get_param_handle("PROBE_STATE");

-- Default light values
local cpltInstBrightness = 0
local pltInstBrightness = 0
local nonFLtInstBrightness = 0
local upperConsoleBrightness = 0
local lowerConsoleBrightness = 0
local switchesBrightness = 0
local glareShieldLightBrightness = 0
local pltRdrAltBrightness = 0
local cpltRdrAltBrightness = 0
local magCompassBrightness = 0

local antiLightGrp = 0
local antiLightMode = 0
local posLightMode = 0
local posLightIntensity = 0
local cabinLightMode = 0
local cockpitLightMode = 0

local landingLtOn = false
local searchLtOn = false
local navBrightness = 0
local formationBrightness = 0

local argNumLandingLightPitch = 607
local argNumLandingLightToggle = 608

local landingLightPos = get_aircraft_draw_argument_value(argNumLandingLightPitch)
local paramLandingLightAdvisory = get_param_handle("CAP_LANDINGLIGHTON")

local argNumSearchLightPitch = 611
local argNumSearchLightYaw = 612
local argNumSearchLightToggle = 613

local searchLightPitch = 0
local searchLightYaw = 0
local searchLightBrightness = 1

local paramSearchLightAdvisory = get_param_handle("CAP_SEARCHLIGHTON")

local fuelProbeState = 0
local fuelProbeSwitchState = 0
local fuelProbeSpeed = 0.3

dev:listen_command(device_commands.cpltInstrLights)
dev:listen_command(device_commands.lightedSwitches)
dev:listen_command(device_commands.formationLights)
dev:listen_command(device_commands.upperConsoleLights)
dev:listen_command(device_commands.lowerConsoleLights)
dev:listen_command(device_commands.pltInstrLights)
dev:listen_command(device_commands.nonFltInstrLights)
dev:listen_command(device_commands.glareshieldLights)
dev:listen_command(device_commands.magCompassLights)
dev:listen_command(device_commands.cabinLightMode)
dev:listen_command(device_commands.cockpitLightMode)

dev:listen_command(device_commands.pltRdrAltLights)
dev:listen_command(device_commands.cpltRdrAltLights)

dev:listen_command(device_commands.posLightIntensity)
dev:listen_command(device_commands.posLightMode)
dev:listen_command(device_commands.antiLightGrp)
dev:listen_command(device_commands.antiLightMode)
dev:listen_command(device_commands.navLightMode)

dev:listen_command(Keys.landingLightToggle)
dev:listen_command(Keys.landingLightExtend)
dev:listen_command(Keys.landingLightRetract)

dev:listen_command(Keys.searchLightToggle)
dev:listen_command(Keys.searchLightLeft)
dev:listen_command(Keys.searchLightRight)
dev:listen_command(Keys.searchLightExtend)
dev:listen_command(Keys.searchLightRetract)
dev:listen_command(Keys.searchLightBrighten)
dev:listen_command(Keys.searchLightDim)

-- Fuel Probe
dev:listen_command(device_commands.fuelProbe)
dev:listen_command(Keys.toggleProbe)

function post_initialize()
	
	dev:performClickableAction(device_commands.lightedSwitches, 	1, true)
	dev:performClickableAction(device_commands.pltRdrAltLights, 	1, true)
	dev:performClickableAction(device_commands.cpltRdrAltLights, 	1, true)
	dev:performClickableAction(device_commands.wiperSelector, 0.01, true)
	dev:performClickableAction(device_commands.RWRBrightness,1,true)

    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_COLD" then
        canopyTargetState = 1
    else
        canopyTargetState = 0
		local hour = get_absolute_model_time() / 3600

		if hour > 18 or hour < 7 then
			dev:performClickableAction(device_commands.cpltInstrLights, 	0.5, true)
			dev:performClickableAction(device_commands.lightedSwitches, 	0.3, true)
			dev:performClickableAction(device_commands.formationLights, 	1, true)
			dev:performClickableAction(device_commands.upperConsoleLights, 	0.5, true)
			dev:performClickableAction(device_commands.lowerConsoleLights, 	0.5, true)
			dev:performClickableAction(device_commands.pltInstrLights, 		0.5, true)
			dev:performClickableAction(device_commands.nonFltInstrLights, 	0.5, true)
			dev:performClickableAction(device_commands.glareshieldLights, 	0.2, true)
			dev:performClickableAction(device_commands.magCompassLights, 	1, true)
			dev:performClickableAction(device_commands.cockpitLightMode, 	1, true)
			
			dev:performClickableAction(device_commands.posLightIntensity, 	1, true)
			dev:performClickableAction(device_commands.posLightMode, 		0, true)
			dev:performClickableAction(device_commands.antiLightGrp, 		0, true)
			dev:performClickableAction(device_commands.antiLightMode, 		1, true)

			dev:performClickableAction(device_commands.pltRdrAltLights, 	0.3, true)
			dev:performClickableAction(device_commands.cpltRdrAltLights, 	0.3, true)
			--dev:performClickableAction(device_commands.navLightMode, 		1, true)
		else
			dev:performClickableAction(device_commands.pltRdrAltLights, 	1, true)
			dev:performClickableAction(device_commands.cpltRdrAltLights, 	1, true)
		end
    end
end

function SetCommand(command,value)
	if command == device_commands.cpltInstrLights then
		cpltInstBrightness = value / 4
	elseif command == device_commands.lightedSwitches then
		switchesBrightness = value
	elseif command == device_commands.formationLights then
		formationBrightness = value
	elseif command == device_commands.upperConsoleLights then
		upperConsoleBrightness = value / 4
	elseif command == device_commands.lowerConsoleLights then
		lowerConsoleBrightness = value / 4
	elseif command == device_commands.pltInstrLights then
		pltInstBrightness = value / 4
	elseif command == device_commands.nonFltInstrLights then
		nonFLtInstBrightness = value / 4
	elseif command == device_commands.glareshieldLights then
		glareShieldLightBrightness = value
	elseif command == device_commands.magCompassLights then
		magCompassBrightness = value
	elseif command == device_commands.pltRdrAltLights then
		pltRdrAltBrightness = value
	elseif command == device_commands.cpltRdrAltLights then
		cpltRdrAltBrightness = value
	elseif command == device_commands.antiLightGrp then
		antiLightGrp = value
	elseif command == device_commands.antiLightMode then
		antiLightMode = value
	elseif command == device_commands.posLightMode then
		posLightMode = value
	elseif command == device_commands.posLightIntensity then
		posLightIntensity = value
	elseif command == device_commands.cabinLightMode then
		cabinLightMode = value
	elseif command == device_commands.cockpitLightMode then
		cockpitLightMode = value
	elseif command == Keys.landingLightExtend then
		if landingLightPos < 1 then
			landingLightPos = landingLightPos + (12/105 * update_time_step)
			set_aircraft_draw_argument_value(argNumLandingLightPitch, landingLightPos)
			--print_message_to_user(landingLightPos)
		end
	elseif command == Keys.landingLightRetract then
		if landingLightPos > 0 then
			landingLightPos = landingLightPos - (30/105 * update_time_step)
			set_aircraft_draw_argument_value(argNumLandingLightPitch, landingLightPos)
			--print_message_to_user(landingLightPos)
		end
	elseif command == Keys.landingLightToggle then
		if landingLtOn then landingLtOn = false else landingLtOn = true end -- fucking lua
	elseif command == Keys.searchLightToggle then
		if searchLtOn then searchLtOn = false else searchLtOn = true end -- fucking lua
	elseif command == Keys.searchLightExtend then
		if searchLightPitch < 1 then
			searchLightPitch = searchLightPitch + (12/105 * update_time_step)
		end
	elseif command == Keys.searchLightRetract then
		if searchLightPitch > 0 then
			searchLightPitch = searchLightPitch - (30/105 * update_time_step)
		end
	elseif command == Keys.searchLightLeft then
		searchLightYaw = searchLightYaw + (30/105 * update_time_step)
		if searchLightYaw > 1 then searchLightYaw = searchLightYaw - 1 end
		if searchLightYaw < 0 then searchLightYaw = searchLightYaw + 1 end
	elseif command == Keys.searchLightRight then
		searchLightYaw = searchLightYaw - (30/105 * update_time_step)
		if searchLightYaw > 1 then searchLightYaw = searchLightYaw - 1 end
		if searchLightYaw < 0 then searchLightYaw = searchLightYaw + 1 end
	elseif command == Keys.searchLightBrighten then
		if searchLightBrightness < 1 then
			searchLightBrightness = searchLightBrightness + math.min(0.003, 1 - searchLightBrightness)
		end
	elseif command == Keys.searchLightDim then
		if searchLightBrightness > 0 then
			searchLightBrightness = searchLightBrightness - math.min(0.003, searchLightBrightness)
		end
	elseif command == device_commands.fuelProbe then
		if get_aircraft_draw_argument_value(22) > 0 then
			fuelProbeState = 1 - fuelProbeState
		end
	elseif command == Keys.toggleProbe then
		dev:performClickableAction(device_commands.fuelProbe, 1 - fuelProbeSwitchState, true)
		fuelProbeSwitchState = 1 - fuelProbeSwitchState
	end
end

function update()
	updateNetworkArgs(GetSelf())

	-- INTERIOR LIGHTS
	-- Glareshield
	local glareShieldPwr = paramCB_LTSGLARESHIELD:get()
	paramLightsGlareshield:set(glareShieldLightBrightness * glareShieldPwr)
	set_aircraft_draw_argument_value(250, glareShieldLightBrightness * glareShieldPwr)

	-- Pilot Flight Instrument Lights
	local pltFltLtsPwr = paramCB_LTSPLTFLT:get()
	paramLightsPltInst:set(pltInstBrightness * pltFltLtsPwr)

	-- Non Instrument Lights
	local nonFltLtsPwr = paramCB_LTSNONFLT:get()
	paramLightsNonFLtInst:set(nonFLtInstBrightness * nonFltLtsPwr)

	-- Copilot Flight Instrument Lights
	local cpltFltLtsPwr = paramCB_LTSCPLTFLT:get()
	paramLightsCpltInst:set(cpltInstBrightness * cpltFltLtsPwr)
	
	-- Upper Console Lights
	local upperCslLtsPwr = paramCB_LTSUPPERCSL:get()
	paramLightsUpperConsole:set(upperConsoleBrightness * upperCslLtsPwr)
	
	-- Lower Console Lights
	local lwrCslLtsPwr = paramCB_LTSLWRCSL:get()
	paramLightsLowerConsole:set(lowerConsoleBrightness * lwrCslLtsPwr)

	-- Lighted Switches
	-- Doesn't have its own CB, will use lowerconsole as placeholder
	paramLightsSwitches:set(switchesBrightness * lwrCslLtsPwr)

	-- Cabin Dome Lights
	local cabinDomeLtsPwr = paramCB_LTSCABINDOME:get()
	if (cabinLightMode == 1) then
		set_aircraft_draw_argument_value(605, cabinDomeLtsPwr)
	elseif (cabinLightMode == -1) then
		set_aircraft_draw_argument_value(606, cabinDomeLtsPwr)
	else
		set_aircraft_draw_argument_value(605, 0)
		set_aircraft_draw_argument_value(606, 0)
	end

	-- Cockpit Dome Lights
	local cockpitDomeLtsPwr = paramCB_LIGHTSSECPNL:get()
	if (cockpitLightMode == 1) then
		set_aircraft_draw_argument_value(251, cockpitDomeLtsPwr)
		paramightsDomeBlue:set(cockpitDomeLtsPwr)
	elseif (cockpitLightMode == -1) then
		set_aircraft_draw_argument_value(252, cockpitDomeLtsPwr)
		paramightsDomeWhite:set(cockpitDomeLtsPwr)
	else
		set_aircraft_draw_argument_value(251, 0)
		set_aircraft_draw_argument_value(252, 0)
		paramightsDomeBlue:set(0)
		paramightsDomeWhite:set(0)
	end

	-- Radar Altimeter Lights
	local rdrAltPwr = paramCB_RdrAltm:get()
	paramLightsPltRdrAlt:set(pltRdrAltBrightness * rdrAltPwr)
	paramLightsCpltRdrAlt:set(cpltRdrAltBrightness * rdrAltPwr)

	-- Mag Compass Light
	paramLightsMagCompass:set(magCompassBrightness * nonFltLtsPwr)

	-- EXTERIOR LIGHTS

	-- Position Lights
	local posLtsPwr = paramCB_EXTLTSPOS:get()
	if (posLightIntensity ~= 0) then
		local brightness = posLtsPwr
		if (posLightIntensity == -1) then
			brightness = .5 * posLtsPwr
		end
		
		if (posLightMode == 0) then
			if get_aircraft_draw_argument_value(123) > 0.9 then
				set_aircraft_draw_argument_value(609, brightness) -- ESS red/green
				set_aircraft_draw_argument_value(604, 0) -- fuselage red/green
			else
				set_aircraft_draw_argument_value(604, brightness) -- fuselage red/green
				set_aircraft_draw_argument_value(609, 0) -- fuselage red/green
			end
			set_aircraft_draw_argument_value(610, brightness) -- fuselage white
		else
			if (math.sin(4 * (get_absolute_model_time())) > 0.9995) then
				if get_aircraft_draw_argument_value(123) > 0.9 then
					set_aircraft_draw_argument_value(609, brightness) -- ESS red/green
					set_aircraft_draw_argument_value(604, 0) -- fuselage red/green
				else
					set_aircraft_draw_argument_value(604, brightness) -- fuselage red/green
					set_aircraft_draw_argument_value(609, 0) -- fuselage red/green
				end
				set_aircraft_draw_argument_value(610, brightness) -- fuselage white
			else
				set_aircraft_draw_argument_value(604, 0)
				set_aircraft_draw_argument_value(609, 0)
				set_aircraft_draw_argument_value(610, 0)
			end
		end
	else
		set_aircraft_draw_argument_value(604, 0)
		set_aircraft_draw_argument_value(609, 0)
		set_aircraft_draw_argument_value(610, 0)
	end

	-- Anticollision Lights
	local antiCollLtsPwr = paramCB_EXTLTSANTICOLL:get()
	-- white lower
	if (antiLightMode == -1 and antiLightGrp >= 0 and math.sin(2.5 * get_absolute_model_time()) > 0.95) then
		set_aircraft_draw_argument_value(600, antiCollLtsPwr) 
	else
		set_aircraft_draw_argument_value(600, 0) 
	end
	
	-- white upper
	if (antiLightMode == -1 and antiLightGrp <= 0 and math.sin(2.5 * (get_absolute_model_time() - 1)) > 0.95) then
		set_aircraft_draw_argument_value(601, antiCollLtsPwr) 
	else
		set_aircraft_draw_argument_value(601, 0) 
	end
	
	-- red lower
	if (antiLightMode == 1 and antiLightGrp >= 0 and math.sin(2.5 * get_absolute_model_time()) > 0.95) then
		set_aircraft_draw_argument_value(602, antiCollLtsPwr) 
	else
		set_aircraft_draw_argument_value(602, 0) 
	end
	
	-- red upper
	if (antiLightMode == 1 and antiLightGrp <= 0 and math.sin(2.5 * (get_absolute_model_time() - 1)) > 0.95) then
		set_aircraft_draw_argument_value(603, antiCollLtsPwr) 
	else
		set_aircraft_draw_argument_value(603, 0) 
	end

	-- Landing Light
	local ldgLtPwr = paramCB_EXTLTSRETRLDGPWR:get()
	if landingLtOn then
		set_aircraft_draw_argument_value(argNumLandingLightToggle, ldgLtPwr)
		paramLandingLightAdvisory:set(ldgLtPwr)
	else
		set_aircraft_draw_argument_value(argNumLandingLightToggle, 0)
		paramLandingLightAdvisory:set(0)
	end
	
	-- Formation Lights
	set_aircraft_draw_argument_value(614, formationBrightness * posLtsPwr)
	
	-- Search Light
	if searchLtOn then
		set_aircraft_draw_argument_value(argNumSearchLightToggle, searchLightBrightness * ldgLtPwr)
		paramSearchLightAdvisory:set(ldgLtPwr)
	else
		set_aircraft_draw_argument_value(argNumSearchLightToggle, 0)
		paramSearchLightAdvisory:set(0)
	end
	set_aircraft_draw_argument_value(argNumSearchLightPitch, searchLightPitch)
	set_aircraft_draw_argument_value(argNumSearchLightYaw, searchLightYaw)

	-- MISC
	if fuelProbeState == 1 and get_aircraft_draw_argument_value(22) > 0 and get_aircraft_draw_argument_value(122) < 1 then
		set_aircraft_draw_argument_value(122, get_aircraft_draw_argument_value(122) + (update_time_step * fuelProbeSpeed))
	end

	if fuelProbeState == 0 and get_aircraft_draw_argument_value(22) > 0 and get_aircraft_draw_argument_value(122) > 0 then
		set_aircraft_draw_argument_value(122, get_aircraft_draw_argument_value(122) - (update_time_step * fuelProbeSpeed))
	end

	--print_message_to_user(get_aircraft_draw_argument_value(122))
	paramProbeState:set(get_aircraft_draw_argument_value(122))
end

need_to_be_closed = false
