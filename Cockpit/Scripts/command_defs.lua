local function counter()
	count = count + 1
	return count
end

count = 10000

Keys =
{
	iCommandEnginesStart = 309, -- Testing
	BattSwitch	 	 = counter(),
	ExtPwrSwitch	 = counter(),
	ThrottleCutoff 	 = counter(),
	ThrottleIncrease = counter(),
	ThrottleDecrease = counter(),
	ThrottleStop 	 = counter(),
	LandingLight	 = counter(),
	
	TriggerFireOn	= counter(),
	TriggerFireOff 	= counter(),
	PickleOn		= counter(),
	PickleOff		= counter(),
	MasterArm		= counter(),

	-- Engine Quadrant
	e1PCL	= counter(),
	e2PCL	= counter(),
	bothPCLs= counter(),
	
	-- AFCS
	slewStabUp = counter(),
	slewStabDown = counter(),

	showControlInd 		= counter(),
	toggleDoors 		= counter(),

	toggleDoorsClose	= counter(),
	toggleDoorsOpen		= counter(),

	landingLightToggle = counter(),
	landingLightExtend = counter(),
	landingLightRetract = counter(),

	searchLightToggle = counter(),
	searchLightExtend = counter(),
	searchLightRetract = counter(),
	searchLightLeft = counter(),
	searchLightRight = counter(),
	searchLightBrighten = counter(),
	searchLightDim = counter(),

	debugMoveElementUp = counter(),
	debugMoveElementDn = counter(),
	debugMoveElementLeft = counter(),
	debugMoveElementRight = counter(),
	debugMoveElementForward = counter(),
	debugMoveElementBack = counter(),

	ptt = counter(),
	pilotICPXmitSelectorInc = counter(),
	pilotICPXmitSelectorDec = counter(),

	-- AN/AVS-7
	avs7Toggle 		= counter(),
	avs7Brighten 	= counter(),
    avs7Dim 		= counter(),

	-- Countermeasures
	dispenseChaffDown 	= counter(),
	dispenseChaffUp 	= counter(),
	dispenseFlareDown 	= counter(),
	dispenseFlareUp 	= counter(),

	-- Doors
	toggleCopilotDoor 		= counter(),
	toggleLeftCargoDoor 	= counter(),
	toggleRightCargoDoor 	= counter(),
	toggleLeftGunnerDoor 	= counter(),
	toggleRightGunnerDoor 	= counter(),

	-- AAR Probe
	toggleProbe = counter(),
	
	radioPTT = counter(),
	
	-- Toggles
	cycleposLightIntensity 	= counter(), -- Position Lights
	cyclecabinLightMode 	= counter(),
	cyclecockpitLightMode 	= counter(),
	navLightModeCycle 		= counter(),
	posLightModeCycle		= counter(), -- Position Lights FLASH/STEADY
	antiLightGrpCycle		= counter(), -- Anticollision Lights LOWER/BOTH/UPPER
	antiLightModeCycle		= counter(), -- Anticollision Lights NIGHT/OFF/DAY
	magCompassLightsCycle 	= counter (),
	
	-- AN/ARC-164 UHF Radio
	arc164_presetInc				= counter(),
	arc164_presetDec 				= counter(),
	arc164_freq_XoooooInc			= counter(),
	arc164_freq_XoooooDec			= counter(),
	arc164_freq_oXooooInc			= counter(),
	arc164_freq_oXooooDec			= counter(),
	arc164_freq_ooXoooInc			= counter(),
	arc164_freq_ooXoooDec			= counter(),
	arc164_freq_oooXooInc			= counter(),
	arc164_freq_oooXooDec			= counter(),
	arc164_freq_ooooXXInc			= counter(),
	arc164_freq_ooooXXDec			= counter(),
	arc164_modeInc					= counter(),
	arc164_modeDec					= counter(),
	arc164_xmitmodeInc				= counter(),
	arc164_xmitmodeDec				= counter(),
	arc164_modeCycle				= counter(),
	arc164_xmitmodeCycle			= counter(),

	-- APN-209 Radar Altimeter
	apn209PilotLoSetInc 			= counter(),
	apn209PilotLoSetDec				= counter(),
	apn209PilotHiSetInc				= counter(),
	apn209PilotHiSetDec				= counter(),
	apn209CopilotLoSetInc			= counter(),
	apn209CopilotLoSetDec			= counter(),
	apn209CopilotHiSetInc			= counter(),
	apn209CopilotHiSetDec			= counter(),

	-- AN/ASN-128B
	SelectDisplayInc				= counter(),
	SelectDisplayDec				= counter(),
	SelectModeInc					= counter(),
	SelectModeDec					= counter(),

	-- AN/ARN-147
	arn147MHzInc = counter(),
	arn147MHzDec = counter(),
	arn147KHzInc = counter(),
	arn147KHzDec = counter(),
	arn147PowerCycle = counter(),

	-- FM Radios 201 FM1
	fm1PresetSelectorInc		= counter(),
	fm1PresetSelectorDec		= counter(),
	fm1PresetSelectorCycle		= counter(),
	fm1FunctionSelectorInc		= counter(),
	fm1FunctionSelectorDec		= counter(),
	fm1FunctionSelectorCycle	= counter(),
	fm1SRSrx			= 20101, -- must be fixed known value for SRS scanning integration

	-- FM Radios 201 FM2
	fm2PresetSelectorInc		= counter(),
	fm2PresetSelectorDec		= counter(),
	fm2PresetSelectorCycle		= counter(),
	fm2FunctionSelectorInc		= counter(),
	fm2FunctionSelectorDec		= counter(),
	fm2FunctionSelectorCycle	= counter(),
	fm2SRSrx			= 20102, -- must be fixed known value for SRS scanning integration

	--[[
	fm1PwrSelectorInc			= counter(),
	fm1PwrSelectorDec			= counter(),
	fm1PwrSelectorCycle			= counter(),
	fm1ModeSelectorInc			= counter(),
	fm1ModeSelectorDec			= counter(),
	fm1ModeSelectorCycle		= counter(),

	fm2PwrSelectorInc			= counter(),
	fm2PwrSelectorDec			= counter(),
	fm2PwrSelectorCycle			= counter(),
	fm2ModeSelectorInc			= counter(),
	fm2ModeSelectorDec			= counter(),
	fm2ModeSelectorCycle		= counter(),
	]]

	-- BARO ALTIMETERs
	pilotBarometricScaleSetInc		= counter(),
	pilotBarometricScaleSetDec		= counter(),
	copilotBarometricScaleSetInc	= counter(),
	copilotBarometricScaleSetDec	= counter(),
	
	-- ARC-186
	arc186Selector10MHzInc		= counter(),
	arc186Selector1MHzInc		= counter(),
	arc186Selector100KHzInc		= counter(),
	arc186Selector25KHzInc		= counter(),
	arc186FreqSelectorInc		= counter(),
	arc186PresetSelectorInc		= counter(),
	arc186ModeSelectorInc		= counter(),
	arc186Selector10MHzDec		= counter(),
	arc186Selector1MHzDec		= counter(),
	arc186Selector100KHzDec		= counter(),
	arc186Selector25KHzDec		= counter(),
	arc186FreqSelectorDec		= counter(),
	arc186PresetSelectorDec		= counter(),
	arc186ModeSelectorDec		= counter(),

	-- Electrical
	BattSwitchOn				= counter(),
	BattSwitchOff				= counter(),
	gen1SwitchOn				= counter(),
	gen1SwitchOff				= counter(),
	gen1SwitchTest				= counter(),
	gen2SwitchOn				= counter(),
	gen2SwitchOff				= counter(),
	gen2SwitchTest				= counter(),
	extPwrSwitchOn				= counter(),
	extPwrSwitchOff				= counter(),
	extPwrSwitchReset			= counter(),
	apuGenSwitchOn				= counter(),
	apuGenSwitchOff				= counter(),
	apuGenSwitchTest			= counter(),
	switchFuelPumpPrime			= counter(),
	switchFuelPumpOff			= counter(),
	switchFuelPumpApuBoost		= counter(),
	switchAirSourceApu			= counter(),
	switchAirSourceOff			= counter(),
	switchAirSourceEngine		= counter(),
	switchAPUOn					= counter(),
	switchAPUOff				= counter(),

	-- Overhead Panel Light Knobs
	glareshieldLightsInc		= counter(),
	glareshieldLightsDec		= counter(),
	cpltInstrLightsInc			= counter(),
	cpltInstrLightsDec			= counter(),
	lightedSwitchesInc			= counter(),
	lightedSwitchesDec			= counter(),
	upperConsoleLightsInc		= counter(),
	upperConsoleLightsDec		= counter(),
	lowerConsoleLightsInc		= counter(),
	lowerConsoleLightsDec		= counter(),
	pltInstrLightsInc			= counter(),
	pltInstrLightsDec			= counter(),
	nonFltInstrLightsInc		= counter(),
	nonFltInstrLightsDec		= counter(),
	formationLights_AXIS		= counter(),
	formationLightsInc			= counter(),
	formationLightsDec			= counter(),

	-- Wiper
	wiperSelectorInc 			= counter(),
	wiperSelectorDec 			= counter(),
	wiperSelectorCycle 			= counter(),

	-- Axis
	pltRdrAltLights_AXIS			= counter(),
	cpltRdrAltLights_AXIS			= counter(),
	apn209PilotLoSet_AXIS			= counter(),
	apn209PilotHiSet_AXIS			= counter(),
	apn209CopilotLoSet_AXIS			= counter(),
	apn209CopilotHiSet_AXIS			= counter(),
	pilotBarometricScaleSet_AXIS	= counter(),
	copilotBarometricScaleSet_AXIS	= counter(),
	lowerConsoleLights_AXIS			= counter(),
	glareshieldLights_AXIS 			= counter(),
	cpltInstrLights_AXIS			= counter(),
	lightedSwitches_AXIS			= counter(),
	upperConsoleLights_AXIS			= counter(),
	pltInstrLights_AXIS				= counter(),
	nonFltInstrLights_AXIS			= counter(),

	-- ECQ
	engFSSBoth			= counter(),
	setEngControlBoth	= counter(),
	eng1FSS_AXIS		= counter(),
	eng2FSS_AXIS		= counter(),
	engFSSBoth_AXIS		= counter(),

	-- CISP Pilot
	PilotCISHdgCycle		= counter(),
	PilotCISNavCycle		= counter(),
	PilotCISAltCycle		= counter(),
	PilotNavGPSCycle		= counter(),
	PilotNavVORILSCycle		= counter(),
	PilotNavBACKCRSCycle	= counter(),
	PilotNavFMHOMECycle		= counter(),
	PilotTURNRATECycle		= counter(),
	PilotCRSHDGCycle		= counter(),
	PilotVERTGYROCycle		= counter(),
	PilotBRG2Cycle			= counter(),

	-- CISP Copilot
	CopilotNavGPSCycle		= counter(),
	CopilotNavVORILSCycle	= counter(),
	CopilotNavBACKCRSCycle	= counter(),
	CopilotNavFMHOMECycle	= counter(),
	CopilotTURNRATECycle	= counter(),
	CopilotCRSHDGCycle		= counter(),
	CopilotVERTGYROCycle	= counter(),
	CopilotBRG2Cycle		= counter(),
	
	-- AN/ARN-149
	arn149PresetCycle 		= counter(),
	arn149ToneTestCycle 	= counter(),
	arn149VolumeCycle 		= counter(),
	arn149PowerCycle 		= counter(),
	arn149thousandsCycle	= counter(),
	arn149hundredsCycle 	= counter(),
	arn149tensCycle 		= counter(),
	arn149onesCycle 		= counter(),
	arn149tenthsCycle 		= counter(),

	-- AFCS
	afcsStabAutoToggle 		= counter(),
	afcsFPSToggle 			= counter(),
	afcsBoostToggle 		= counter(),
	afcsSAS1Toggle  		= counter(),
	afcsSAS2Toggle  		= counter(),
	afcsTrimToggle  		= counter(),
	miscTailWheelLockToggle = counter(),

	-- RWR
	apr39PowerCycle 		= counter(),
	apr39BrightnessIncDec	= counter(),
	apr39VolumeIncDec		= counter(),
	apr39Volume_AXIS		= counter(),
	apr39Brightness_AXIS	= counter(),

	-- Aux Fuel 
	afmcpXferModeCycle 		= counter(),
	afmcpManXferCycle 		= counter(),
	afmcpXferFromCycle 		= counter(),
	afmcpPressCycle 		= counter(),
	afmcpPress_AXIS			= counter(),
	afmcpPressInc 			= counter(),
	afmcpPressDec 			= counter(),

	-- Countermeasures
	cmProgramDial_AXIS 		= counter(),
	cmProgramDialInc 		= counter(),
	cmProgramDialDec 		= counter(),
	cmProgramDialCycle		= counter(),
}

count = 3200
device_commands =
{ -- commands for lua

	AuxPowerSw  	= counter(),

	FuelShutoffSw	= counter(),
	FuelPumpSw 		= counter(),

	eng1ControlDetent	= counter(),
	eng2ControlDetent	= counter(),

	setEng1Control = counter(),
	setEng2Control = counter(),

	eng1FSS = counter(),
	eng2FSS = counter(),

	eng1Starter = counter(),
	eng2Starter = counter(),

	-- AHRU
	ahruMode 	= counter(),
	ahruFunc 	= counter(),
	ahruUp 		= counter(),
	ahruRight 	= counter(),
	ahruEnter 	= counter(),

	RWRpower		= counter(),
	RWRBrightness	= counter(),

	CAPLampTest 			= counter(),
	CAPLampBrightness 		= counter(),
	CAPMasterCautionReset 	= counter(),

	-- AFCS
	afcsStabAuto	= counter(),
	afcsSAS1		= counter(),
	afcsSAS2		= counter(),
	afcsTrim		= counter(),
	afcsFPS			= counter(),
	afcsBoost		= counter(),
	slewStabUp		= counter(),
	slewStabDown	= counter(),

	-- VIDS
	cduLampTest = counter(),
	pilotPDUTest = counter(),
	copilotPDUTest = counter(),

	--AAU32A
	pilotBarometricScaleSet = counter(),
	copilotBarometricScaleSet = counter(),

	--ASN128B
	SelectMode			= counter(),
	SelectDisplay 		= counter(),
	SelectBtnKybd		= counter(),
	SelectBtnLtrLeft	= counter(),
	SelectBtnLtrMid		= counter(),
	SelectBtnLtrRight	= counter(),
	SelectBtnF1			= counter(),
	SelectBtn1			= counter(),
	SelectBtn2			= counter(),
	SelectBtn3			= counter(),
	SelectBtnTgtStr		= counter(),
	SelectBtn4			= counter(),
	SelectBtn5			= counter(),
	SelectBtn6			= counter(),
	SelectBtnInc		= counter(),
	SelectBtn7			= counter(),
	SelectBtn8			= counter(),
	SelectBtn9			= counter(),
	SelectBtnDec		= counter(),
	SelectBtnClr		= counter(),
	SelectBtn0			= counter(),
	SelectBtnEnt		= counter(),

	--AVS7
	setAVS7Power		= counter(),
	incAVS7Brightness	= counter(),
	decAVS7Brightness	= counter(),

	-- Generic
	foo = counter(),

	--Radio
	arc164_mode        	= counter(),
    arc164_xmitmode    	= counter(),
    arc164_volume      	= counter(),
    arc164_squelch     	= counter(),
    arc164_freq_preset 	= counter(),
	arc164_freq_Xooooo	= counter(),
	arc164_freq_oXoooo	= counter(),
	arc164_freq_ooXooo	= counter(),
	arc164_freq_oooXoo	= counter(),
	arc164_freq_ooooXX	= counter(),
	arc164_preset = counter(),

	--Lighting Panel
	glareshieldLights = counter(),
	cpltInstrLights = counter(),
	lightedSwitches = counter(),
	formationLights = counter(),
	upperConsoleLights = counter(),
	lowerConsoleLights = counter(),
	pltInstrLights = counter(),
	nonFltInstrLights = counter(),
	magCompassLights = counter(),
	
	posLightIntensity = counter(),
	posLightMode = counter(),
	antiLightGrp = counter(),
	antiLightMode = counter(),
	navLightMode = counter(),
	cabinLightMode = counter(),
	cockpitLightMode = counter(),

	wiperSelector 		= counter(),

	pltRdrAltLights = counter(),
	cpltRdrAltLights = counter(),

	-- APR-39
	apr39Power = counter(),
	apr39SelfTest = counter(),
	apr39Altitude = counter(),
	apr39Volume = counter(),
	apr39Brightness = counter(),

	-- LC6
	resetSetBtn = counter(),
	modeBtn = counter(),
	startStopAdvBtn = counter(),

	-- Pilot ICP
	pilotICPXmitSelector = counter(),
	pilotICPSetVolume = counter(),
	pilotICPToggleFM1 = counter(),
	pilotICPToggleUHF = counter(),
	pilotICPToggleVHF = counter(),
	pilotICPToggleFM2 = counter(),
	pilotICPToggleHF = counter(),
	pilotICPToggleVOR = counter(),
	pilotICPToggleADF = counter(),

	-- CM System
	cmFlareDispenseModeCover = counter(),
	cmFlareCounterDial = counter(),
	cmChaffCounterDial = counter(),
	cmArmSwitch = counter(),
	cmProgramDial = counter(),
	cmChaffDispense = counter(),
	cmFlareDispense = counter(),

	-- ARC201 FM1
	fm1PresetSelector = counter(),
	fm1FunctionSelector = counter(),
	fm1PwrSelector = counter(),
	fm1ModeSelector = counter(),
	fm1Volume = counter(),
	fm1Btn1 = counter(),
	fm1Btn2 = counter(),
	fm1Btn3 = counter(),
	fm1Btn4 = counter(),
	fm1Btn5 = counter(),
	fm1Btn6 = counter(),
	fm1Btn7 = counter(),
	fm1Btn8 = counter(),
	fm1Btn9 = counter(),
	fm1Btn0 = counter(),
	fm1BtnClr = counter(),
	fm1BtnEnt = counter(),
	fm1BtnFreq = counter(),
	fm1BtnErfOfst = counter(),
	fm1BtnTime = counter(),

	-- ARC201 FM2
	fm2PresetSelector = counter(),
	fm2FunctionSelector = counter(),
	fm2PwrSelector = counter(),
	fm2ModeSelector = counter(),
	fm2Volume = counter(),
	fm2Btn1 = counter(),
	fm2Btn2 = counter(),
	fm2Btn3 = counter(),
	fm2Btn4 = counter(),
	fm2Btn5 = counter(),
	fm2Btn6 = counter(),
	fm2Btn7 = counter(),
	fm2Btn8 = counter(),
	fm2Btn9 = counter(),
	fm2Btn0 = counter(),
	fm2BtnClr = counter(),
	fm2BtnEnt = counter(),
	fm2BtnFreq = counter(),
	fm2BtnErfOfst = counter(),
	fm2BtnTime = counter(),

	-- ARC186
	arc186Volume = counter(),
	arc186Tone = counter(),
	arc186Selector10MHz = counter(),
	arc186Selector1MHz = counter(),
	arc186Selector100KHz = counter(),
	arc186Selector25KHz = counter(),
	arc186FreqSelector = counter(),
	arc186Load = counter(),
	arc186PresetSelector = counter(),
	arc186ModeSelector = counter(),

	-- CISP
	pilotHSIHdgSet		= counter(),
	pilotHSICrsSet		= counter(),
	copilotHSIHdgSet	= counter(),
	copilotHSICrsSet	= counter(),

	PilotCISHdgToggle = counter(),
	PilotCISNavToggle = counter(),
	PilotCISAltToggle = counter(),
	
	PilotNavGPSToggle = counter(),
	PilotNavVORILSToggle = counter(),
	PilotNavBACKCRSToggle = counter(),
	PilotNavFMHOMEToggle = counter(),
	PilotTURNRATEToggle = counter(),
	PilotCRSHDGToggle = counter(),
	PilotVERTGYROToggle = counter(),
	PilotBRG2Toggle = counter(),

	CopilotNavGPSToggle = counter(),
	CopilotNavVORILSToggle = counter(),
	CopilotNavBACKCRSToggle = counter(),
	CopilotNavFMHOMEToggle = counter(),
	CopilotTURNRATEToggle = counter(), 
	CopilotCRSHDGToggle = counter(),
	CopilotVERTGYROToggle = counter(),
	CopilotBRG2Toggle = counter(),

	-- DEBUG
	visualisationToggle = counter(),

	-- AN/ARN-149
	arn149Preset = counter(),
	arn149ToneTest = counter(),
	arn149Volume = counter(),
	arn149Power = counter(),
	arn149thousands = counter(),
	arn149hundreds = counter(),
	arn149tens = counter(),
	arn149ones = counter(),
	arn149tenths = counter(),

	-- AN/ARN-147
	arn147MHz = counter(), 
	arn147KHz = counter(), 
	arn147Power = counter(),

	-- MISC
	fuelProbe = counter(),
	parkingBrake = counter(),
	miscTailWheelLock = counter(),
	doorCplt = counter(),
	doorPlt = counter(),
	doorLGnr = counter(),
	doorRGnr = counter(),
	doorLCargo = counter(),
	doorRCargo = counter(),

	-- MISC PANEL
	miscFuelIndTest = counter(),
	miscTailWheelLock = counter(),
	miscGyroEffect = counter(),
	miscTailServo = counter(),

	-- APN209
	apn209PilotLoSet = counter(),
	apn209PilotHiSet = counter(),
	apn209CopilotLoSet = counter(),
	apn209CopilotHiSet = counter(),

	-- AFMS
	afmcpXferMode = counter(),
	afmcpManXfer = counter(),
	afmcpXferFrom = counter(),
	afmcpPress = counter(),
}

EFM_commands = 	-- commands for use in EFM (make sure to copy to inputs.h)
{
	batterySwitch		= 3013,
	extPwrSwitch		= 3014,
	apuGenSwitch		= 3015,
	gen1Switch			= 3016,
	gen2Switch			= 3017,
	apuGenSwitch2		= 3018,
	gen1Switch2			= 3019,
	gen2Switch2			= 3020,
	extPwrSwitch2		= 3021,

	switchFuelPump		= 3022,
	switchAirSource		= 3023,
	switchAPU			= 3024,

	setEng1Control		= 3028,
	setEng2Control		= 3029,
	eng1FSS				= 3030,
	eng2FSS				= 3031,

	eng1Starter			= 3034,
	eng2Starter			= 3035,

	stabManualSlew		= 3036,

	stabPwrReset		= 3043,

	fuelPumpL 			= 3044,
	fuelPumpR 			= 3045,

	setRefuelProbeState = 3046,

	slewStabUp			= 3050,
	slewStabDown		= 3051,

	lockTailWheel		= 3052,

	afmcpXferMode		= 3053,
	afmcpManXfer		= 3054,
	afmcpXferFrom		= 3055,
		
	trimUp				= 4017,
	trimDown			= 4018,
	trimLeft			= 4019,
	trimRight			= 4020,
	trimRelease	        = 4025,
	trimSet 	        = 4026,
	trimReset           = 4027,
	
	intercomPTT			= 4029,
	
	nonFltLighting		= 4040,
	
	setPilotHSIHeading	= 5000,
	
	wheelbrake			= 3100,
	wheelbrakeToggle	= 3101,
	wheelbrakeLeft		= 3102,
	wheelbrakeRight		= 3103,
	setParkingBrake		= 3104,

	collectiveIncrease = 3105,
	collectiveDecrease = 3106,

	dampenValue = 5001,

	startServer = 5016,
	connectServer = 5017,
}
