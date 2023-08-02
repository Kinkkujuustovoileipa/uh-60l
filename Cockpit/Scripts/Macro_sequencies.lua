dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15 -- default message timeout

local t_start 	= 0.0
local t_stop 	= 0.0
local dt		= 0.3 -- default delay before the command
local dt_mto	= 1.5 -- message timeout

local hour = get_absolute_model_time() / 3600

local delta_t_com = 2.0

start_sequence_full 	  = {}
stop_sequence_full		  = {}
cockpit_illumination_full = {}

function push_command(sequence, run_t, command)
	sequence[#sequence + 1] =  command
	sequence[#sequence]["time"] = run_t
end

function push_start_command(delta_t, command)
	t_start = t_start + delta_t
	push_command(start_sequence_full,t_start, command)
end

function push_stop_command(delta_t, command)
	t_stop = t_stop + delta_t
	push_command(stop_sequence_full,t_stop, command)
end

local count = 0
local function counter()
	count = count + 1
	return count
end

-- conditions
count = -1

-- Auto Start sequence
push_start_command(dt,	{message = _("AUTOSTART SEQUENCE IS RUNNING"), message_timeout = 120.0})

-----------------------
-----------------------

push_start_command(dt, {message = _("--- COCKPIT EQUIPMENT CHECKS CHECKLIST ---"), message_timeout = 20.0})
push_start_command(dt, {action = Keys.gen1SwitchOn, message = _("GEN 1 Switch - ON"),	message_timeout = dt_mto})
push_start_command(dt, {action = Keys.gen2SwitchOn, message = _("GEN 2 Switch - ON"),	message_timeout = dt_mto})
push_start_command(dt, {action = Keys.switchAirSourceApu, message = _("Air Source Switch - APU"), message_timeout = dt_mto})
push_start_command(dt, {action = Keys.BattSwitchOn, message = _("Battery Switch - ON"), message_timeout = dt_mto})
push_start_command(dt, {action = Keys.apuGenSwitchOn, message = _("APU GEN Switch- ON"),	message_timeout = dt_mto})

push_start_command(2, {action = Keys.switchAPUOn, message = _("APU CONTROL - ON"), message_timeout = dt_mto})
push_start_command(2, {message = _("APU ADVISORIES - CHECK"),	message_timeout = dt_mto})

if hour > 18 or hour < 7 then
	push_start_command(5, {message = _("Cockpit Lighting - SET"),	message_timeout = 5})
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.cpltInstrLights	, value = i})
	end
	for i = 0, 0.30, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.lightedSwitches	, value = i})
	end
	for i = 0, 1, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.formationLights	, value = i})
	end
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.upperConsoleLights	, value = i})
	end
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.lowerConsoleLights	, value = i})
	end
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.pltInstrLights		, value = i})
	end
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.nonFltInstrLights	, value = i})
	end
	for i = 0, 0.50, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.glareshieldLights	, value = i})
	end

		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.magCompassLights	, value = 0.5})
		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.cockpitLightMode	, value = 0.5})
		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.posLightIntensity	, value = 0.5})
		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.posLightMode		, value = 0})
		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.antiLightGrp		, value = 0})
		push_start_command(dt, {device = devices.EXTLIGHTS, action = device_commands.antiLightMode		, value = 1.0})
	
	for i = 0, 0.30, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.pltRdrAltLights	, value = i})
	end
	for i = 0, 0.30, 0.01 do
		push_start_command(0.02, {device = devices.EXTLIGHTS, action = device_commands.cpltRdrAltLights	, value = i})
	end
else
	--push_start_command(dt, {message = _("Lower Console Ligting - ON"),	message_timeout = dt_mto})
	for i = 0, 60, 1 do
		push_start_command(0.02, {action = Keys.lowerConsoleLightsInc })
	end
end

push_start_command(3, {message = _("AHRS ALIGNING - CHECK"),	message_timeout = dt_mto})
push_start_command(5, {message = _("TAILWHEEL LOCK - AS REQUIRED"), message_timeout = dt_mto})

push_start_command(dt, {device = devices.ASN128B, action = device_commands.SelectMode, value = 0.04, message = _("AN/ASN-128B Select Mode - LAT/LONG"),	message_timeout = dt_mto})

push_start_command(dt, {message = _("AN/ASN-128B Select Button ENT x2"),	message_timeout = dt_mto*4})
push_start_command(dt, {device = devices.ASN128B, action = device_commands.SelectBtnEnt, value = 1.0})
push_start_command(dt, {device = devices.ASN128B, action = device_commands.SelectBtnEnt, value = 0.0})
push_start_command(dt, {device = devices.ASN128B, action = device_commands.SelectBtnEnt, value = 1.0})
push_start_command(dt, {device = devices.ASN128B, action = device_commands.SelectBtnEnt, value = 0.0})

push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsStabAuto, value = 1.0, message = _("Stabilator Auto - ON"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsFPS, value = 1.0,message = _("AFCS FPS - ON"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsSAS1, value = 0.0,message = _("AFCS SAS1 - OFF"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsSAS2, value = 1.0,message = _("AFCS SAS2 - ON"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsBoost, value = 1.0,message = _("AFCS Boost - ON"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.AFCS, action = device_commands.afcsTrim, value = 1.0,message = _("AFCS Trim - ON"),	message_timeout = dt_mto})

push_start_command(dt,	{message = _("--- COCKPIT EQUIPMENT CHECKS CHECKLIST COMPLETE ---"), message_timeout = 4.0})

-----------------------
-----------------------

push_start_command(5,	{message = _("--- STARTING ENGINES CHECKLIST ---"), message_timeout = 55.0})

push_start_command(dt, {message = _("Engine 1 + 2 FSS - DIR"), message_timeout = dt_mto*2})
for i = 0, 0.5, 0.001 do
	push_start_command(0.01, {device = devices.ECQ, action = device_commands.eng1FSS, value = i})
	push_start_command(0.01, {device = devices.ECQ, action = device_commands.eng2FSS, value = i})
end

push_start_command(dt, {message = _("Engine 1 + 2 Starters - Press"), message_timeout = dt_mto*4})
push_start_command(dt, {device = devices.ECQ, action = device_commands.eng1Starter, value = 1})
push_start_command(dt, {device = devices.ECQ, action = device_commands.eng1Starter, value = 0})
push_start_command(dt, {device = devices.ECQ, action = device_commands.eng2Starter, value = 1})
push_start_command(dt, {device = devices.ECQ, action = device_commands.eng2Starter, value = 0})

push_start_command(10, {message = _("Engine 1 + 2 Control Levers - IDLE"), message_timeout = dt_mto*2})
push_start_command(dt, {device = devices.ECQ, action = device_commands.eng1ControlDetent, value = 1})
push_start_command(2, {device = devices.ECQ, action = device_commands.eng2ControlDetent, value = 1})

push_start_command(10, {message = _("Engine 1 + 2 Control Levers - FLY"), message_timeout = dt_mto*2})
for i = 0, 1.0, 0.001 do
	push_start_command(0.004, {device = devices.ECQ, action = device_commands.setEng1Control, value = i})
	push_start_command(0.004, {device = devices.ECQ, action = device_commands.setEng2Control, value = i})
end

push_start_command(10, {message = _("RPMs 100% - CHECK"),	message_timeout = dt_mto})

push_start_command(2, {message = _("TRQ STABLE - CHECK"),	message_timeout = dt_mto})

push_start_command(2, {message = _("MCP AND CAUTIONS - CHECK"),	message_timeout = dt_mto})

push_start_command(2,	{message = _("--- STARTING ENGINES CHECKLIST COMPLETE ---"), message_timeout = 4.0})

-----------------------
-----------------------

push_start_command(5,	{message = _("--- BEFORE TAXI CHECKLIST ---"), message_timeout = 28.0})

push_start_command(dt, {message = _("RWR - AS REQUIRED"),	message_timeout = dt_mto})
push_start_command(dt, {device = devices.APR39, action = device_commands.apr39Volume, value = 1})
push_start_command(1, {device = devices.APR39, action = device_commands.apr39Power, value = 1})
push_start_command(1, {device = devices.APR39, action = device_commands.apr39Brightness, value = 1})

push_start_command(2, {message = _("AHRS - SLAVE"),	message_timeout = dt_mto})

push_start_command(2, {message = _("RADIOS - SET"),	message_timeout = dt_mto*6})
push_start_command(1, {device = devices.ARC201_FM1, action = device_commands.fm1FunctionSelector, value = 0.02})
push_start_command(1.5, {device = devices.ARC201_FM2, action = device_commands.fm2FunctionSelector, value = 0.02})
push_start_command(1, {device = devices.ARC164, action = device_commands.arc164_mode, value = 0.01})
push_start_command(1, {device = devices.ARC186, action = device_commands.arc186ModeSelector, value = 0.5})
push_start_command(1.5, {device = devices.ARC186, action = device_commands.arc186FreqSelector, value = 2/3})
push_start_command(1.5, {device = devices.BASERADIO, action = device_commands.pilotICPXmitSelector, value = 0.4})

push_start_command(1, {device = devices.ARN149, action = device_commands.arn149Power, value = 1,message = _("ADF CONTROL - ADF"),	message_timeout = dt_mto})

push_start_command(1, {device = devices.ARN147, action = device_commands.arn147Power, value = 0.5, message = _("VOR/ILS - ON"),	message_timeout = dt_mto})

push_start_command(1.5, {device = devices.AFCS, action = device_commands.afcsSAS1, value = 1, message = _("SAS1 - ON"),	message_timeout = dt_mto})

push_start_command(dt, {message = _("HELMET MOUNTED SIGHT - AS REQUIRED"),	message_timeout = dt_mto})
--push_start_command(1, {device = devices.AVS7, action = device_commands.setAVS7Power, value = 0})

push_start_command(dt, {message = _("APU AND APU GEN - OFF"),	message_timeout = dt_mto*2})
push_start_command(1, {action = Keys.switchAPUOff})
push_start_command(1, {action = Keys.apuGenSwitchOn})

push_start_command(2, {message = _("DOORS - SECURE"),	message_timeout = dt_mto})
-- Can leave as user set to prevent rearming issues
--push_start_command(dt, {action = Keys.toggleDoorsClose})
--push_start_command(dt, {device = devices.MISC, action = device_commands.doorCplt, value = 0})
--push_start_command(dt, {device = devices.MISC, action = device_commands.doorLGnr, value = 0})
--push_start_command(dt, {device = devices.MISC, action = device_commands.doorRGnr, value = 0})
--push_start_command(dt, {device = devices.MISC, action = device_commands.doorLCargo, value = 0})
--push_start_command(dt, {device = devices.MISC, action = device_commands.doorRCargo, value = 0})

push_start_command(2, {message = _("PARKING BRAKE - RELEASE"),	message_timeout = dt_mto})
-- Can leave it off
push_start_command(2, {message = _("TAIL WHEEL LOCK - AS REQUIRED"),	message_timeout = dt_mto})
-- Can leave as user set
push_start_command(2, {message = _("WHEEL BRAKES - CHECK"),	message_timeout = dt_mto})
-- Player can check brakes

push_start_command(dt,	{message = _("--- BEFORE TAXI CHECKLIST COMPLETE ---"), message_timeout = 4.0})
push_start_command(5,	{message = _("--- AUTO START COMPLETE ---"), message_timeout = 10.0})