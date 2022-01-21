local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
-- down = single instance,  pressed = continuous input

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

join(res.keyCommands,
{
	-- Electrical Systems
    {combos = {{key = 'B'}}, down = Keys.BattSwitch, name = _('Battery Switch'), category = _('Electrical Systems')},
	{combos = {{key = 'B', reformers = {'LCtrl'}}}, down = Keys.ExtPwrSwitch, name = _('External Power Switch'), category = _('Electrical Systems')},

	-- Cyclic
	{combos = {{key = ';', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimUp, name = _('Cyclic Trim Nose Up'), category = _('Cyclic')},
	{combos = {{key = '.', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimDown, name = _('Cyclic Trim Nose Down'), category = _('Cyclic')},
	{combos = {{key = ',', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimLeft, name = _('Cyclic Trim Roll Left'), category = _('Cyclic')},
	{combos = {{key = '/', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimRight, name = _('Cyclic Trim Roll Right'), category = _('Cyclic')},
	{pressed = EFM_commands.trimRelease, up = EFM_commands.trimSet, name = _('Trim Release'), category = _('Cyclic')},
    {up = EFM_commands.trimReset, name = _('Trim Reset'), category = _('Cyclic')},

    -- AFCS    
    {down = Keys.slewStabUp, up = Keys.slewStabUp, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Up'), category = _('AFCS')},
    {down = Keys.slewStabDown, up = Keys.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Down'), category = _('AFCS')},

	-- Radios
	{down = Keys.ptt, up = Keys.ptt, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, value_up = 0.0, name = _('PTT - Push To Talk'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorInc, cockpit_device_id = devices.PLT_ICP, name = _('ICS XMIT Select Next Radio'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorDec, cockpit_device_id = devices.PLT_ICP, name = _('ICS XMIT Select Previous Radio'), category = _('Radios')},

    -- Countermeasures
	{down = Keys.dispenseChaffDown, up = Keys.dispenseChaffUp, name = _('Chaff Dispense'), category = _('Countermeasures')},

	-- AN/AVS-7
	{down = Keys.avs7Toggle, 	name = _('AN/AVS-7 ON/OFF'),	category = _('AN/AVS-7 HUD')},
    {pressed = Keys.avs7Brighten, 	name = _('AN/AVS-7 Brighten'),	category = _('AN/AVS-7 HUD')},
    {pressed = Keys.avs7Dim, 	name = _('AN/AVS-7 Dim'),	category = _('AN/AVS-7 HUD')},

    -- Lighting
    {down = Keys.landingLightToggle, 	name = _('Landing Light ON/OFF'),	category = _('Lighting')},
    {pressed = Keys.landingLightExtend, 	name = _('Landing Light Extend'),	category = _('Lighting')},
    {pressed = Keys.landingLightRetract, 	name = _('Landing Light Retract'),	category = _('Lighting')},

	{down = Keys.searchLightToggle, 	name = _('Search Light ON/OFF'),	category = _('Lighting')},
    {pressed = Keys.searchLightExtend, 	name = _('Search Light Extend'),	category = _('Lighting')},
    {pressed = Keys.searchLightRetract,	name = _('Search Light Retract'),	category = _('Lighting')},
    {pressed = Keys.searchLightLeft, 	name = _('Search Light Left'),	category = _('Lighting')},
    {pressed = Keys.searchLightRight, 	name = _('Search Light Right'),	category = _('Lighting')},
    {pressed = Keys.searchLightBrighten,name = _('Search Light Brighten'),	category = _('Lighting')},
    {pressed = Keys.searchLightDim, 	name = _('Search Light Dim'),	category = _('Lighting')},

	{combos = {{key = 'L', reformers = {'LAlt'}}},	down = 3256, cockpit_device_id  = 0,	value_down = 1.0,	name = _('Flashlight'),	category = _('Lighting')},

    -- Others
	{combos = {{key = 'E', reformers = {'LCtrl'}}}, down 	= iCommandPlaneEject, 	name = _('Eject (3 times)'), category = _('General')},
    {combos = {{key = 'C', reformers = {'LCtrl'}}}, down = Keys.toggleDoors,		name = _('Canopy Open/Close'), category = _('General')},
    {down = Keys.toggleCopilotDoor,		name = _('Copilot Door Open/Close'), category = _('General')},
    {down = Keys.toggleLeftCargoDoor,	name = _('Left Cargo Door Open/Close'), category = _('General')},
    {down = Keys.toggleRightCargoDoor,	 name = _('Right Cargo Door Open/Close'), category = _('General')},
    {down = Keys.toggleLeftGunnerDoor,	 name = _('Left Gunner Hatch Open/Close'), category = _('General')},
    {down = Keys.toggleRightGunnerDoor,	 name = _('Right Gunner Hatch Open/Close'), category = _('General')},

    {down = Keys.toggleProbe,	 name = _('AAR Probe Extend/Retract'), category = _('General')},

	{down = EFM_commands.wheelbrake, value_down = 1.0, up = EFM_commands.wheelbrake, value_up = 0,  name = _('Wheel Brakes')},

	-- Input
	{pressed 	= EFM_commands.collectiveIncrease, 	name = _('Collective Increase'), category = _('Collective')},
	{pressed 	= EFM_commands.collectiveDecrease, 	name = _('Collective Decrease'), category = _('Collective')},
	
    -- Night Vision Goggles
	{combos = {{key = 'N'}}	, down = iCommandViewNightVisionGogglesOn,	 name = _('Toggle Night Vision Goggles'), 	category = _('NVG')},
	{combos = {{key = 'N', reformers = {'RCtrl'}}}, pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Gain NVG up')  , category = _('NVG')},
	{combos = {{key = 'N', reformers = {'RAlt'}}} , pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Gain NVG down'), category = _('NVG')},
	
    -- Multicrew
	{combos = {{key = '1'}},	down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Pilot Seat'),	category = _('Crew Control')},
	{combos = {{key = '2'}},	down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Copilot Seat'),	category = _('Crew Control')},
	{combos = {{key = '3'}},	down = iCommandViewCockpitChangeSeat, value_down = 3, name = _('Occupy Left Gunner Seat'),	category = _('Crew Control')},
	{combos = {{key = '4'}},	down = iCommandViewCockpitChangeSeat, value_down = 4, name = _('Occupy Right Gunner Seat'),	category = _('Crew Control')},
	{combos = {{key = 'C'}},	down = iCommandNetCrewRequestControl,				name = _('Request Aircraft Control'),category = _('Crew Control')},
	
	--{combos = {{key = 'P', reformers = {'RShift'}}}, down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
	
    {combos = {{key = 'Enter', reformers = {'RCtrl'}}},			 down = Keys.showControlInd,				name = _('Show controls indicator') ,			 category = _('General')},
	
	{up = EFM_commands.wheelbrakeToggle,      name = _('Wheel Brakes Toggle On/Off')},

	{down = iCommandExtCargoHook, name = _('External Cargo Hook'), 	category = _("External Cargo")},
	{down = iCommandExternalCargoAutounhook, name = _('External Cargo Autounhook'),	category = _("External Cargo")},
	{down = iCommandExternalCargoIndicator, name = _("External Cargo Indicator"),  category = _("External Cargo"), },
	{down = iCommandEmergencyCargoUnhook, name = _('External Cargo Emergency Unhook'), 	category = _("External Cargo")},
	
	--Gunners AI Panel
	--{combos = {{key = 'H', reformers = {'LWin'}}}, down = device_commands.Button_37, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AI Panel Show/Hide'), category = _('Gunners AI Panel')},
	
	--{combos = {{key = '3', reformers = {'LCtrl'}}}, down = device_commands.Button_38, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Left ROE Iterate'), category = _('Gunners AI Panel')},
	--{combos = {{key = '3', reformers = {'LShift'}}}, down = device_commands.Button_38, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Left Burst Switch'), category = _('Gunners AI Panel')},
	
	--{combos = {{key = '2', reformers = {'LCtrl'}}}, down = device_commands.Button_39, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Operator ROE Iterate'), category = _('Gunners AI Panel')},
	--{combos = {{key = '2', reformers = {'LShift'}}}, down = device_commands.Button_39, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Operator Burst Switch'), category = _('Gunners AI Panel')},
	
	--{combos = {{key = '4', reformers = {'LCtrl'}}}, down = device_commands.Button_40, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Right ROE Iterate'), category = _('Gunners AI Panel')},
	--{combos = {{key = '4', reformers = {'LShift'}}}, down = device_commands.Button_40, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Right Burst Switch'), category = _('Gunners AI Panel')},
})
return res
