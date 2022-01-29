local function counter()
	count = count + 1
	return count
end

count = 10000

Keys =
{
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

	showControlInd = counter(),
	toggleDoors = counter(),

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
	avs7Toggle = counter(),
	avs7Brighten = counter(),
    avs7Dim = counter(),

	-- Countermeasures
	dispenseChaffDown = counter(),
	dispenseChaffUp = counter(),

	-- Doors
	toggleCopilotDoor = counter(),
	toggleLeftCargoDoor = counter(),
	toggleRightCargoDoor = counter(),
	toggleLeftGunnerDoor = counter(),
	toggleRightGunnerDoor = counter(),

	-- AAR Probe
	toggleProbe = counter(),

	radioPTT = counter(),
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
	ahruMode = counter(),
	ahruFunc = counter(),
	ahruUp = counter(),
	ahruRight = counter(),
	ahruEnter = counter(),

	RWRpower		= counter(),
	RWRBrightness	= counter(),

	CAPLampTest = counter(),
	CAPLampBrightness = counter(),
	CAPMasterCautionReset = counter(),

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
	arc164_mode                      = counter(),
    arc164_xmitmode                  = counter(),
    arc164_volume                    = counter(),
    arc164_squelch                   = counter(),
    arc164_freq_preset               = counter(),
	arc164_freq_Xooooo				= counter(),
	arc164_freq_oXoooo				= counter(),
	arc164_freq_ooXooo				= counter(),
	arc164_freq_oooXoo				= counter(),
	arc164_freq_ooooXX				= counter(),
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

	wiperSelector = counter(),

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

	slewStabUp = 3050,
	slewStabDown = 3051,

	lockTailWheel = 3052,

	afmcpXferMode = 3053,
	afmcpManXfer = 3054,
	afmcpXferFrom = 3055,
	
	trimUp				= 4017,
	trimDown			= 4018,
	trimLeft			= 4019,
	trimRight			= 4020,
	trimRelease	        = 4025,
	trimSet 	        = 4026,
	trimReset           = 4027,
	
	radioPTT			= 4029,
	
	nonFltLighting		= 4040,
	
	setPilotHSIHeading	= 5000,
	
	wheelbrake			= 3100,
	wheelbrakeToggle	= 3101,
	setParkingBrake 	= 3104,
	
	collectiveIncrease = 3102,
	collectiveDecrease = 3103,

	dampenValue = 5001,

	startServer = 5016,
	connectServer = 5017,

	useUnsprungCyclic = 5018,
}
