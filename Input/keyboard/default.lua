local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
-- down = single instance,  pressed = continuous input

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

join(res.keyCommands,
{
	-- Autostart
	{combos = {{key = 'Home',	reformers = {'LWin'}}},	down = Keys.iCommandEnginesStart, name = _('Auto Start UH60'),	category = _('Cheat')},
	
	-- AFCS FPS
	{down = device_commands.afcsFPS, up = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS FPS - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsFPS, up = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS FPS - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS FPS - ON'), category = _('AFCS')},
	{down = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS FPS - OFF'), category = _('AFCS')},
	{down = Keys.afcsFPSToggle, name = _('AFCS FPS - Toggle'), category = _('AFCS')},

	-- AFCS SAS1
	{down = device_commands.afcsSAS1, up = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS SAS1 - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, up = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS SAS1 - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS SAS1 - ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS SAS1 - OFF'), category = _('AFCS')},
	{down = Keys.afcsSAS1Toggle, name = _('AFCS SAS1 - Toggle'), category = _('AFCS')},

	-- AFCS SAS2
	{down = device_commands.afcsSAS2, up = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS SAS2 - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, up = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS SAS2 - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS SAS2 - ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS SAS2 - OFF'), category = _('AFCS')},
	{down = Keys.afcsSAS2Toggle, name = _('AFCS SAS2 - Toggle'), category = _('AFCS')},

	-- AFCS Boost
	{down = device_commands.afcsBoost, up = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS Boost - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsBoost, up = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS Boost - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS Boost - ON'), category = _('AFCS')},
	{down = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS Boost - OFF'), category = _('AFCS')},
	{down = Keys.afcsBoostToggle, name = _('AFCS Boost - Toggle'), category = _('AFCS')},

	-- AFCS Trim
	{down = device_commands.afcsTrim, up = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS Trim - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsTrim, up = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS Trim - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS Trim - ON'), category = _('AFCS')},
	{down = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS Trim - OFF'), category = _('AFCS')},
	{down = Keys.afcsTrimToggle, name = _('AFCS Trim - Toggle'), category = _('AFCS')},

	-- Slew Stab Fix
	{down = device_commands.slewStabDown, up = device_commands.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Stabilator Manual Slew Up (Momentary)'), category = _('AFCS')},
	{down = device_commands.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('Stabilator Manual Slew Up'), category = _('AFCS')},
	
	{down = device_commands.slewStabUp, up = device_commands.slewStabUp, cockpit_device_id = devices.AFCS, value_down = -1.0, value_up = 0.0, name = _('Stabilator Manual Slew Down (Momentary)'), category = _('AFCS')},
	{down = device_commands.slewStabUp, cockpit_device_id = devices.AFCS, value_down = -1.0, name = _('Stabilator Manual Slew Down'), category = _('AFCS')},
	
	{down = device_commands.afcsStabAuto, up = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Stabilator Auto - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, up = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('Stabilator Auto - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('Stabilator Auto - ON'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('Stabilator Auto - OFF'), category = _('AFCS')},	
	{down = Keys.afcsStabAutoToggle, name = _('Stabilator Auto - Toggle'), category = _('AFCS')},

	-- Engine Control Levers
	{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine 1 Control Lever - FLY'), category = _('Engine Control Quadrant')},
	{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine 1 Control Lever - IDLE'), category = _('Engine Control Quadrant')},
	{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine 2 Control Lever - FLY'), category = _('Engine Control Quadrant')},
	{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine 2 Control Lever - IDLE'), category = _('Engine Control Quadrant')},
	{down = Keys.setEngControlBoth, value_down = 0, name = _('Engine 1 + 2 Control Levers - IDLE'), category = _('Engine Control Quadrant')},
	{down = Keys.setEngControlBoth, value_down = 1, name = _('Engine 1 + 2 Control Levers - FLY'), category = _('Engine Control Quadrant')},
	
	-- Engine FSS
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine 1 FSS - OFF'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 0.5, name = _('Engine 1 FSS - DIR'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine 1 FSS - XFD'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine 2 FSS - OFF'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 0.5, name = _('Engine 2 FSS - DIR'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine 2 FSS - XFD'), category = _('Engine Control Quadrant')},
	{down = Keys.engFSSBoth, value_down = 0, name = _('Engine 1 + 2 FSS - OFF'), category = _('Engine Control Quadrant')},
	{down = Keys.engFSSBoth, value_down = 0.5, name = _('Engine 1 + 2 FSS - DIR'), category = _('Engine Control Quadrant')},
	{down = Keys.engFSSBoth, value_down = 1, name = _('Engine 1 + 2 FSS - XFD'), category = _('Engine Control Quadrant')},

	-- Engine Starter
	{down = device_commands.eng1Starter, up = device_commands.eng1Starter, cockpit_device_id = devices.ECQ, value_down = 1.0, value_up = 0.0, name = _('Engine 1 Starter'), category = _('Engine Control Quadrant')},
	{down = device_commands.eng2Starter, up = device_commands.eng2Starter, cockpit_device_id = devices.ECQ, value_down = 1.0, value_up = 0.0, name = _('Engine 2 Starter'), category = _('Engine Control Quadrant')},
	
	-- Tail Wheel
	{down = device_commands.miscTailWheelLock, up = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 1.0, value_up = 0.0, name = _('Tail Wheel Lock - LOCK else UNLOCK'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, up = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 0.0, value_up = 1.0, name = _('Tail Wheel Lock - UNLOCK else LOCK'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 1.0, name = _('Tail Wheel Lock - LOCK'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 0.0, name = _('Tail Wheel Lock - UNLOCK'), category = _('MISC')},
	{down = Keys.miscTailWheelLockToggle, name = _('Tail Wheel Lock - Toggle'), category = _('MISC')},
		
	-- VIDS
	{down = device_commands.cduLampTest, up = device_commands.cduLampTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('CDU Lamp Test'), category = _('VIDS')},
	{down = device_commands.pilotPDUTest, up = device_commands.pilotPDUTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('PDU Test Pilot'), category = _('VIDS')},
	{down = device_commands.copilotPDUTest, up = device_commands.copilotPDUTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('PDU Test Copilot'), category = _('VIDS')},
	
	-- Caution Display Panel
	{down = device_commands.CAPLampTest	, 			up = device_commands.CAPLampTest, 			cockpit_device_id = devices.CAUTION_ADVISORY_PANEL, value_down = 1.0, value_up = 0.0, name = _('CAP Lamp Test'), category = _('Caution Display Panel')},
	{down = device_commands.CAPMasterCautionReset, 	up = device_commands.CAPMasterCautionReset, cockpit_device_id = devices.CAUTION_ADVISORY_PANEL, value_down = 1.0, value_up = 0.0, name = _('Master Caution Reset Pilot'), category = _('Caution Display Panel')},

	--ASN128B GPS Computer
	{down = device_commands.SelectBtn1, up = device_commands.SelectBtn1, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 1'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn2, up = device_commands.SelectBtn2, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 2'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn3, up = device_commands.SelectBtn3, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 3'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn4, up = device_commands.SelectBtn4, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 4'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn5, up = device_commands.SelectBtn5, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 5'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn6, up = device_commands.SelectBtn6, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 6'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn7, up = device_commands.SelectBtn7, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 7'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn8, up = device_commands.SelectBtn8, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 8'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn9, up = device_commands.SelectBtn9, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 9'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtn0, up = device_commands.SelectBtn0, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button 0'), category = _('AN/ASN-128B GPS DPLR')},
	
	{down = device_commands.SelectBtnTgtStr, up = device_commands.SelectBtnTgtStr, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button TGT STR'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnEnt, up = device_commands.SelectBtnEnt, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button ENT'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnClr, up = device_commands.SelectBtnClr, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button CLR'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnDec, up = device_commands.SelectBtnDec, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button DEC'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnInc, up = device_commands.SelectBtnInc, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button INC'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnLtrRight, up = device_commands.SelectBtnLtrRight, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button LTR Right'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnLtrMid, up = device_commands.SelectBtnLtrMid, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button LTR MID'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnLtrLeft, up = device_commands.SelectBtnLtrLeft, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button LTR Left'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnKybd, up = device_commands.SelectBtnKybd, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button KYBD'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectBtnF1, up = device_commands.SelectBtnF1, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('AN/ASN-128B Select Button F1'), category = _('AN/ASN-128B GPS DPLR')},

	--AN/ASN-128B Selectors
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.00, name = _('AN/ASN-128B Select Display 1 WIND-UTC DATA'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.01, name = _('AN/ASN-128B Select Display 2 XTX/TXC KEY'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.02, name = _('AN/ASN-128B Select Display 3 GS/TK NAV M'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.03, name = _('AN/ASN-128B Select Display 4 PP'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.04, name = _('AN/ASN-128B Select Display 5 DST/BRG TIME'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.05, name = _('AN/ASN-128B Select Display 6 WP TGT'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.06, name = _('AN/ASN-128B Select Display 7 DATUM ROUTE'), category = _('AN/ASN-128B GPS DPLR')},
	{down = Keys.SelectDisplayInc, name = _('AN/ASN-128B Select Display - CW/Increase'), category = _('AN/ASN-128B GPS DPLR')},
	{down = Keys.SelectDisplayDec, name = _('AN/ASN-128B Select Display - CCW/Decrease'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.0, name = _('AN/ASN-128B Select Mode 1 OFF'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.01, name = _('AN/ASN-128B Select Mode 2 LAMP TEST'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.02, name = _('AN/ASN-128B Select Mode 3 TEST'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.03, name = _('AN/ASN-128B Select Mode 4 MGRS'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.04, name = _('AN/ASN-128B Select Mode 5 LAT/LONG'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.05, name = _('AN/ASN-128B Select Mode 6 GPS LDG'), category = _('AN/ASN-128B GPS DPLR')},
	{down = Keys.SelectModeInc, name = _('AN/ASN-128B Select Mode - CW/Increase'), category = _('AN/ASN-128B GPS DPLR')},
	{down = Keys.SelectModeDec, name = _('AN/ASN-128B Select Mode - CCW/Decrease'), category = _('AN/ASN-128B GPS DPLR')},

	-- VHF radio 
	{down = Keys.arc186Selector10MHzInc, name = _('AN/ARC-186 10MHz Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector1MHzInc, name = _('AN/ARC-186 1MHz Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector100KHzInc, name = _('AN/ARC-186 100KHz Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector25KHzInc, name = _('AN/ARC-186 25KHz Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186FreqSelectorInc, name = _('AN/ARC-186 Frequency Control Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186PresetSelectorInc, name = _('AN/ARC-186 Preset Channel Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186ModeSelectorInc, name = _('AN/ARC-186 Mode Selector - CW/Increase'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector10MHzDec, name = _('AN/ARC-186 10MHz Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector1MHzDec, name = _('AN/ARC-186 1MHz Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector100KHzDec, name = _('AN/ARC-186 100KHz Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186Selector25KHzDec, name = _('AN/ARC-186 25KHz Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186FreqSelectorDec, name = _('AN/ARC-186 Frequency Control Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186PresetSelectorDec, name = _('AN/ARC-186 Preset Channel Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	{down = Keys.arc186ModeSelectorDec, name = _('AN/ARC-186 Mode Selector - CCW/Decrease'), category = _('AN/ARC-186 VHF Radio')},
	

	-- Countermeasures
	{down = device_commands.cmArmSwitch, cockpit_device_id = devices.M130, value_down = 0.0, name = _('Countermeasures Arming Switch - SAFE'), category = _('Countermeasures')},
	{down = device_commands.cmArmSwitch, cockpit_device_id = devices.M130, value_down = 1.0, name = _('Countermeasures Arming Switch - ARM'), category = _('Countermeasures')},

	-- AN/ARN-149 ADF Radio
	{down = Keys.arn149PresetCycle,		 value_down = 1, name = _('AN/ARN-149 PRESET Selector - Increase'), 		category = _('AN/ARN-149 ADF Radio')},
	--{down = Keys.arn149ToneTestCycle,	 value_down = 1, name = _('AN/ARN-149 TONE/OFF/TEST - Increase'), 			category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149PowerCycle,		 value_down = 1, name = _('AN/ARN-149 POWER Selector - Increase'), 			category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149thousandsCycle,	 value_down = 1, name = _('AN/ARN-149 1000s Khz Selector - CW/Increase'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149hundredsCycle,	 value_down = 1, name = _('AN/ARN-149 100s Khz Selector - CW/Increase'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tensCycle,		 value_down = 1, name = _('AN/ARN-149 10s Khz Selector - CW/Increase'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149onesCycle,		 value_down = 1, name = _('AN/ARN-149 1s Khz Selector - CW/Increase'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tenthsCycle,		 value_down = 1, name = _('AN/ARN-149 .1s Khz Selector - CW/Increase'), 	category = _('AN/ARN-149 ADF Radio')},

	{down = Keys.arn149PresetCycle,		 value_down = 0, name = _('AN/ARN-149 PRESET Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},
	--{down = Keys.arn149ToneTestCycle,	 value_down = 0, name = _('AN/ARN-149 TONE/OFF/TEST - Cycle'), 			category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149PowerCycle,		 value_down = 0, name = _('AN/ARN-149 POWER Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149thousandsCycle,	 value_down = 0, name = _('AN/ARN-149 1000s Khz Selector - Cycle'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149hundredsCycle,	 value_down = 0, name = _('AN/ARN-149 100s Khz Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tensCycle,		 value_down = 0, name = _('AN/ARN-149 10s Khz Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149onesCycle,		 value_down = 0, name = _('AN/ARN-149 1s Khz Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tenthsCycle,		 value_down = 0, name = _('AN/ARN-149 .1s Khz Selector - Cycle'), 		category = _('AN/ARN-149 ADF Radio')},

	{down = Keys.arn149PresetCycle,		 value_down = -1, name = _('AN/ARN-149 PRESET Selector - Decrease'), 		category = _('AN/ARN-149 ADF Radio')},
	--{down = Keys.arn149ToneTestCycle,	 value_down = -1, name = _('AN/ARN-149 TONE/OFF/TEST - Decrease'), 			category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149PowerCycle,		 value_down = -1, name = _('AN/ARN-149 POWER Selector - Decrease'), 		category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149thousandsCycle,	 value_down = -1, name = _('AN/ARN-149 1000s Khz Selector - CCW/Decrease'), category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149hundredsCycle,	 value_down = -1, name = _('AN/ARN-149 100s Khz Selector - CCW/Decrease'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tensCycle,		 value_down = -1, name = _('AN/ARN-149 10s Khz Selector - CCW/Decrease'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149onesCycle,		 value_down = -1, name = _('AN/ARN-149 1s Khz Selector - CCW/Decrease'), 	category = _('AN/ARN-149 ADF Radio')},
	{down = Keys.arn149tenthsCycle,		 value_down = -1, name = _('AN/ARN-149 .1s Khz Selector - CCW/Decrease'), 	category = _('AN/ARN-149 ADF Radio')},

	-- AN/ARN-147
	{down = Keys.arn147MHzInc, name = _('AN/ARN-147 MHz Selector - Increase'),   category = _('AN/ARN-147 NAV/ILS Radio')},
	{down = Keys.arn147MHzDec, name = _('AN/ARN-147 MHz Selector - Decrease'),   category = _('AN/ARN-147 NAV/ILS Radio')},
	{down = Keys.arn147KHzInc, name = _('AN/ARN-147 KHz Selector - Increase'),   category = _('AN/ARN-147 NAV/ILS Radio')},
	{down = Keys.arn147KHzDec, name = _('AN/ARN-147 KHz Selector - Decrease'),   category = _('AN/ARN-147 NAV/ILS Radio')},
	{down = Keys.arn147PowerCycle, name = _('AN/ARN-147 Power Selector - OFF/ON'), category = _('AN/ARN-147 NAV/ILS Radio')},

	-- AN/ARC164 UHF Radio
	{down = Keys.arc164_presetInc, name = _('AN/ARC-164 Preset Channel - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_presetDec, name = _('AN/ARC-164 Preset Channel - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_XoooooInc, name = _('AN/ARC-164 100s - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_XoooooDec, name = _('AN/ARC-164 100s - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_oXooooInc, name = _('AN/ARC-164 10s - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_oXooooDec, name = _('AN/ARC-164 10s - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_ooXoooInc, name = _('AN/ARC-164 1s - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_ooXoooDec, name = _('AN/ARC-164 1s - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_oooXooInc, name = _('AN/ARC-164 .1s - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_oooXooDec, name = _('AN/ARC-164 .1s - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_ooooXXInc, name = _('AN/ARC-164 .01s - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_freq_ooooXXDec, name = _('AN/ARC-164 .01s - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_modeInc, name = _('AN/ARC-164 Mode - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_modeDec, name = _('AN/ARC-164 Mode - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_xmitmodeInc, name = _('AN/ARC-164 XmitMode - Increase'),   category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_xmitmodeDec, name = _('AN/ARC-164 XmitMode - Decrease'),   category = _('AN/ARC-164 UHF Radio')},
	
	{down = device_commands.arc164_mode, cockpit_device_id = devices.ARC164, value_down = 0.00, name = _('AN/ARC-164 Mode - OFF'), category = _('AN/ARC-164 UHF Radio')},
	{down = device_commands.arc164_mode, cockpit_device_id = devices.ARC164, value_down = 0.01, name = _('AN/ARC-164 Mode - MAIN'), category = _('AN/ARC-164 UHF Radio')},
	{down = device_commands.arc164_mode, cockpit_device_id = devices.ARC164, value_down = 0.02, name = _('AN/ARC-164 Mode - BOTH'), category = _('AN/ARC-164 UHF Radio')},
	{down = device_commands.arc164_mode, cockpit_device_id = devices.ARC164, value_down = 0.03, name = _('AN/ARC-164 Mode - ADF'), category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_modeCycle, name = _('AN/ARC-164 Mode - OFF/MAIN/BOTH/ADF'), category = _('AN/ARC-164 UHF Radio')},

	{down = device_commands.arc164_xmitmode, cockpit_device_id = devices.ARC164, value_down = 0.00, name = _('AN/ARC-164 Manual/Preset/Guard - MANUAL'), category = _('AN/ARC-164 UHF Radio')},
	{down = device_commands.arc164_xmitmode, cockpit_device_id = devices.ARC164, value_down = 0.01, name = _('AN/ARC-164 Manual/Preset/Guard - PRESET'), category = _('AN/ARC-164 UHF Radio')},
	{down = device_commands.arc164_xmitmode, cockpit_device_id = devices.ARC164, value_down = 0.02, name = _('AN/ARC-164 Manual/Preset/Guard - GUARD'), category = _('AN/ARC-164 UHF Radio')},
	{down = Keys.arc164_xmitmodeCycle, cockpit_device_id = devices.ARC164, value_down = 0.02, name = _('AN/ARC-164 Manual/Preset/Guard - Manual/Preset/Guard'), category = _('AN/ARC-164 UHF Radio')},

	--APN-209 Radar Altimeter
	{pressed = Keys.apn209PilotLoSetInc, 	name = _('Radar Altimeter Pilot Low Altitude Set - Increase'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209PilotLoSetDec, 	name = _('Radar Altimeter Pilot Low Altitude Set - Decrease'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209PilotHiSetInc, 	name = _('Radar Altimeter Pilot Hi Altitude Set - Increase'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209PilotHiSetDec, 	name = _('Radar Altimeter Pilot Hi Altitude Set - Decrease'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209CopilotLoSetInc, 	name = _('Radar Altimeter Copilot Low Altitude Set - Increase'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209CopilotLoSetDec, 	name = _('Radar Altimeter Copilot Low Altitude Set - Decrease'),   category = _('APN-209 Radar Altimeter')},	
	{pressed = Keys.apn209CopilotHiSetInc, 	name = _('Radar Altimeter Copilot Hi Altitude Set - Increase'),   category = _('APN-209 Radar Altimeter')},
	{pressed = Keys.apn209CopilotHiSetDec, 	name = _('Radar Altimeter Copilot Hi Altitude Set - Decrease'),   category = _('APN-209 Radar Altimeter')},

	-- BARO ALTIMETERs
	{pressed = Keys.pilotBarometricScaleSetInc, name = _('Barometric Altimeter Pilot - CW/Increase'),   	category = _('Barometric Altimeter')},
	{pressed = Keys.pilotBarometricScaleSetDec, name = _('Barometric Altimeter Pilot - CCW/Decrease'),   	category = _('Barometric Altimeter')},
	{pressed = Keys.copilotBarometricScaleSetInc, name = _('Barometric Altimeter Copilot - CW/Increase'),   category = _('Barometric Altimeter')},
	{pressed = Keys.copilotBarometricScaleSetDec, name = _('Barometric Altimeter Copilot - CCW/Decrease'),  category = _('Barometric Altimeter')},
	

	-- ARC201 FM1
	{down = device_commands.fm1Btn1, up = device_commands.fm1Btn1, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 1'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn2, up = device_commands.fm1Btn2, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 2'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn3, up = device_commands.fm1Btn3, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 3'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn4, up = device_commands.fm1Btn4, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 4'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn5, up = device_commands.fm1Btn5, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 5'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn6, up = device_commands.fm1Btn6, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 6'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn7, up = device_commands.fm1Btn7, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 7'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn8, up = device_commands.fm1Btn8, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 8'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn9, up = device_commands.fm1Btn9, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 9'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1Btn0, up = device_commands.fm1Btn0, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button 0'), category = _('AN/ARC-201 FM')},
	
	{down = device_commands.fm1BtnClr, up = device_commands.fm1BtnClr, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button CLR'), 				category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1BtnEnt, up = device_commands.fm1BtnEnt, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button ENT'), 				category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1BtnFreq, up = device_commands.fm1BtnFreq, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button FREQ'), 			category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1BtnErfOfst, up = device_commands.fm1BtnErfOfst, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button ERF/OFST'), 	category = _('AN/ARC-201 FM')},
	{down = device_commands.fm1BtnTime, up = device_commands.fm1BtnTime, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM1) Button TIME'), 			category = _('AN/ARC-201 FM')},
	
	{down = Keys.fm1PresetSelectorInc, name = _('AN/ARC-201 (FM1) PRESET Selector - CW/Increase'),   		category = _('AN/ARC-201 FM')},
	{down = Keys.fm1PresetSelectorDec, name = _('AN/ARC-201 (FM1) PRESET Selector - CCW/Decrease'),   		category = _('AN/ARC-201 FM')},
	{down = Keys.fm1PresetSelectorCycle, name = _('AN/ARC-201 (FM1) PRESET Selector - Cycle'),   			category = _('AN/ARC-201 FM')},
	{down = Keys.fm1FunctionSelectorInc, name = _('AN/ARC-201 (FM1) FUNCTION Selector - CW/Increase'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm1FunctionSelectorDec, name = _('AN/ARC-201 (FM1) FUNCTION Selector - CCW/Decrease'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm1FunctionSelectorCycle, name = _('AN/ARC-201 (FM1) FUNCTION Selector - Cycle'),   		category = _('AN/ARC-201 FM')},

	--[[
	{down = Keys.fm1PwrSelectorInc, name = _('AN/ARC-201 (FM1) PWR Selector - CW/Increase'),  	category = _('AN/ARC-201 FM')},
	{down = Keys.fm1PwrSelectorDec, name = _('AN/ARC-201 (FM1) PWR Selector - CCW/Decrease'),  category = _('AN/ARC-201 FM')},
	{down = Keys.fm1PwrSelectorCycle, name = _('AN/ARC-201 (FM1) PWR Selector - Cycle'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm1ModeSelectorInc, name = _('AN/ARC-201 (FM1) MODE Selector - CW/Increase'), category = _('AN/ARC-201 FM')},
	{down = Keys.fm1ModeSelectorDec, name = _('AN/ARC-201 (FM1) MODE Selector - CCW/Decrease'),category = _('AN/ARC-201 FM')},
	{down = Keys.fm1ModeSelectorCycle, name = _('AN/ARC-201 (FM1) MODE Selector - Cycle'),   	category = _('AN/ARC-201 FM')},
	]]

	-- ARC201 FM2
	{down = device_commands.fm2Btn1, up = device_commands.fm2Btn1, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 1'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn2, up = device_commands.fm2Btn2, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 2'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn3, up = device_commands.fm2Btn3, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 3'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn4, up = device_commands.fm2Btn4, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 4'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn5, up = device_commands.fm2Btn5, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 5'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn6, up = device_commands.fm2Btn6, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 6'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn7, up = device_commands.fm2Btn7, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 7'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn8, up = device_commands.fm2Btn8, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 8'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn9, up = device_commands.fm2Btn9, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 9'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2Btn0, up = device_commands.fm2Btn0, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button 0'), category = _('AN/ARC-201 FM')},
	
	{down = device_commands.fm2BtnClr, up = device_commands.fm2BtnClr, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button CLR'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2BtnEnt, up = device_commands.fm2BtnEnt, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button ENT'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2BtnFreq, up = device_commands.fm2BtnFreq, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button FREQ'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2BtnErfOfst, up = device_commands.fm2BtnErfOfst, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button ERF/OFST'), category = _('AN/ARC-201 FM')},
	{down = device_commands.fm2BtnTime, up = device_commands.fm2BtnTime, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('AN/ARC-201 (FM2) Button TIME'), category = _('AN/ARC-201 FM')},
	
	{down = Keys.fm2PresetSelectorInc, name = _('AN/ARC-201 (FM2) PRESET Selector - CW/Increase'),   category = _('AN/ARC-201 FM')},
	{down = Keys.fm2PresetSelectorDec, name = _('AN/ARC-201 (FM2) PRESET Selector - CCW/Decrease'),   category = _('AN/ARC-201 FM')},
	{down = Keys.fm2PresetSelectorCycle, name = _('AN/ARC-201 (FM2) PRESET Selector - Cycle'),   category = _('AN/ARC-201 FM')},
	{down = Keys.fm2FunctionSelectorInc, name = _('AN/ARC-201 (FM2) FUNCTION Selector - CW/Increase'),   category = _('AN/ARC-201 FM')},
	{down = Keys.fm2FunctionSelectorDec, name = _('AN/ARC-201 (FM2) FUNCTION Selector - CCW/Decrease'),   category = _('AN/ARC-201 FM')},
	{down = Keys.fm2FunctionSelectorCycle, name = _('AN/ARC-201 (FM2) FUNCTION Selector - Cycle'),   category = _('AN/ARC-201 FM')},

	--[[
	{down = Keys.fm2PwrSelectorInc, name = _('AN/ARC-201 (FM2) PWR Selector - CW/Increase'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm2PwrSelectorDec, name = _('AN/ARC-201 (FM2) PWR Selector - CCW/Decrease'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm2PwrSelectorCycle, name = _('AN/ARC-201 (FM2) PWR Selector - Cycle'),   		category = _('AN/ARC-201 FM')},
	{down = Keys.fm2ModeSelectorInc, name = _('AN/ARC-201 (FM2) MODE Selector - CW/Increase'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm2ModeSelectorDec, name = _('AN/ARC-201 (FM2) MODE Selector - CCW/Decrease'),   	category = _('AN/ARC-201 FM')},
	{down = Keys.fm2ModeSelectorCycle, name = _('AN/ARC-201 (FM2) MODE Selector - Cycle'),   		category = _('AN/ARC-201 FM')},
	]]

	-- CISP Pilot
	{down = device_commands.PilotCISHdgToggle, up = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot HDG - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, up = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot HDG - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP Pilot HDG - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP Pilot HDG - ON'), category = _('CISP')},

	{down = device_commands.PilotCISNavToggle, up = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot NAV - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, up = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot NAV - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP Pilot NAV - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP Pilot NAV - ON'), category = _('CISP')},

	{down = device_commands.PilotCISAltToggle, up = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot ALT - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, up = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot ALT - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP Pilot ALT - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP Pilot ALT - ON'), category = _('CISP')},

	{down = device_commands.PilotNavGPSToggle, up = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot DLPR GPS - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, up = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot DLPR GPS - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot NAV DLPR - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot NAV DLPR - ON'), category = _('CISP')},
	
	{down = device_commands.PilotNavVORILSToggle, up = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot VOR ILS - ILS else VOR'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, up = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot VOR ILS - VOR else ILS'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot VOR ILS - VOR'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot VOR ILS - ILS'), category = _('CISP')},
	
	{down = device_commands.PilotNavBACKCRSToggle, up = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot BACK CRS - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, up = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot BACK CRS - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot BACK CRS - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot BACK CRS - ON'), category = _('CISP')},
	
	{down = device_commands.PilotNavFMHOMEToggle, up = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot FM HOME - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, up = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot FM HOME - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot FM HOME - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot FM HOME - ON'), category = _('CISP')},
	
	{down = device_commands.PilotCRSHDGToggle, up = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot CRS HDG - CPLT else PLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, up = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot CRS HDG - PLT else CPLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot CRS HDG - PLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot CRS HDG - CPLT'), category = _('CISP')},
	
	{down = device_commands.PilotVERTGYROToggle, up = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot VERT GYRO - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, up = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot VERT GYRO - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot VERT GYRO - NORM'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot VERT GYRO - ALTR'), category = _('CISP')},
	
	{down = device_commands.PilotBRG2Toggle, up = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot BRG2 - VOR else ADF'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, up = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot BRG2 - ADF else VOR'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot BRG2 - ADF'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot BRG2 - VOR'), category = _('CISP')},

	{down = device_commands.PilotTURNRATEToggle, up = device_commands.PilotTURNRATEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Pilot Turn Rate - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.PilotTURNRATEToggle, up = device_commands.PilotTURNRATEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Pilot Turn Rate - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.PilotTURNRATEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP Pilot Turn Rate - NORM'), category = _('CISP')},
	{down = device_commands.PilotTURNRATEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP Pilot Turn Rate - ALTR'), category = _('CISP')},
	
	{pressed = device_commands.pilotHSIHdgSet, cockpit_device_id = devices.PLTCISP, value_pressed = 0.01, name = _('Pilot Heading Set - CW'), category = _('CISP')},
	{pressed = device_commands.pilotHSIHdgSet, cockpit_device_id = devices.PLTCISP, value_pressed = -0.01, name = _('Pilot Heading Set - CCW'), category = _('CISP')},
	{pressed = device_commands.pilotHSICrsSet, cockpit_device_id = devices.PLTCISP, value_pressed = 0.01, name = _('Pilot Course Set - CW'), category = _('CISP')},
	{pressed = device_commands.pilotHSICrsSet, cockpit_device_id = devices.PLTCISP, value_pressed = -0.01, name = _('Pilot Course Set - CCW'), category = _('CISP')},

	--Copilot CISP
	{down = device_commands.CopilotNavGPSToggle, up = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot DLPR GPS - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, up = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot DLPR GPS - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot DLPR GPS - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot DLPR GPS - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotNavVORILSToggle, up = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot VOR ILS - ILS else VOR'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, up = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot VOR ILS - VOR else ILS'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot VOR ILS - VOR'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot VOR ILS - ILS'), category = _('CISP')},

	{down = device_commands.CopilotNavBACKCRSToggle, up = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot BACK CRS - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, up = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot BACK CRS - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot BACK CRS - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot BACK CRS - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotNavFMHOMEToggle, up = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot FM HOME - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, up = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot FM HOME - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot FM HOME - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot FM HOME - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotCRSHDGToggle, up = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot CRS HDG - CPLT else PLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, up = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot CRS HDG - PLT else CPLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot CRS HDG - PLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot CRS HDG - CPLT'), category = _('CISP')},
	
	{down = device_commands.CopilotVERTGYROToggle, up = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot VERT GYRO - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, up = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot VERT GYRO - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot VERT GYRO - NORM'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot VERT GYRO - ALTR'), category = _('CISP')},
	
	{down = device_commands.CopilotBRG2Toggle, up = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot BRG2 - VOR else ADF'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, up = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot BRG2 - ADF else VOR'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot BRG2 - ADF'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot BRG2 - VOR'), category = _('CISP')},

	{down = device_commands.CopilotTURNRATEToggle, up = device_commands.CopilotTURNRATEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP Copilot Turn Rate - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.CopilotTURNRATEToggle, up = device_commands.CopilotTURNRATEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP Copilot Turn Rate - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.CopilotTURNRATEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CISP Copilot Turn Rate - NORM'), category = _('CISP')},
	{down = device_commands.CopilotTURNRATEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CISP Copilot Turn Rate - ALTR'), category = _('CISP')},
	
	{pressed = device_commands.copilotHSIHdgSet, cockpit_device_id = devices.CPLTCISP, value_pressed = 0.01, name = _('CISP Copilot CISP Copilot Heading Set - CW'), category = _('CISP')},
	{pressed = device_commands.copilotHSIHdgSet, cockpit_device_id = devices.CPLTCISP, value_pressed = -0.01, name = _('CISP Copilot CISP Copilot Heading Set - CCW'), category = _('CISP')},
	{pressed = device_commands.copilotHSICrsSet, cockpit_device_id = devices.CPLTCISP, value_pressed = 0.01, name = _('CISP Copilot CISP Copilot Course Set - CW'), category = _('CISP')},
	{pressed = device_commands.copilotHSICrsSet, cockpit_device_id = devices.CPLTCISP, value_pressed = -0.01, name = _('CISP Copilot CISP Copilot Course Set - CCW'), category = _('CISP')},

	-- Toggle CISP Pilot
	{down = Keys.PilotCISHdgCycle, 		name = _('CISP Pilot HDG - Cycle'), category = _('CISP')},
	{down = Keys.PilotCISNavCycle, 		name = _('CISP Pilot NAV - Cycle'), category = _('CISP')},
	{down = Keys.PilotCISAltCycle, 		name = _('CISP Pilot ALT - Cycle'), category = _('CISP')},
	{down = Keys.PilotNavGPSCycle,		name = _('CISP Pilot NAV GPS - Cycle'), category = _('CISP')},
	{down = Keys.PilotNavVORILSCycle,	name = _('CISP Pilot VOR ILS - Cycle'), category = _('CISP')},
	{down = Keys.PilotNavBACKCRSCycle,	name = _('CISP Pilot BACK CRS - Cycle'), category = _('CISP')},
	{down = Keys.PilotNavFMHOMECycle,	name = _('CISP Pilot FM HOME - Cycle'), category = _('CISP')},
	{down = Keys.PilotTURNRATECycle,	name = _('CISP Pilot TURN RATE - Cycle'), category = _('CISP')},
	{down = Keys.PilotCRSHDGCycle,		name = _('CISP Pilot CRS HDG - Cycle'), category = _('CISP')},
	{down = Keys.PilotVERTGYROCycle,	name = _('CISP Pilot VERT GYRO - Cycle'), category = _('CISP')},
	{down = Keys.PilotBRG2Cycle,		name = _('CISP Pilot BRG2 - Cycle'), category = _('CISP')},

	-- Toggle CISP Copilot
	{down = Keys.CopilotNavGPSCycle,		name = _('CISP Copilot NAV GPS - Cycle'), category = _('CISP')},
	{down = Keys.CopilotNavVORILSCycle,		name = _('CISP Copilot VOR ILS - Cycle'), category = _('CISP')},
	{down = Keys.CopilotNavBACKCRSCycle,	name = _('CISP Copilot BACK CRS - Cycle'), category = _('CISP')},
	{down = Keys.CopilotNavFMHOMECycle,		name = _('CISP Copilot FM HOME - Cycle'), category = _('CISP')},
	{down = Keys.CopilotTURNRATECycle,		name = _('CISP Copilot TURN RATE - Cycle'), category = _('CISP')},
	{down = Keys.CopilotCRSHDGCycle,		name = _('CISP Copilot CRS HDG - Cycle'), category = _('CISP')},
	{down = Keys.CopilotVERTGYROCycle,		name = _('CISP Copilot VERT GYRO - Cycle'), category = _('CISP')},
	{down = Keys.CopilotBRG2Cycle,			name = _('CISP Copilot BRG2 - Cycle'), category = _('CISP')},

	-- RWR
	{down = device_commands.apr39Power, up = device_commands.apr39Power, cockpit_device_id = devices.APR39, value_down = 1.0, value_up = 0.0, name = _('AN/APR-39 Power - ON else OFF'), category = _('AN/APR-39 RWR')},
	{down = device_commands.apr39Power, up = device_commands.apr39Power, cockpit_device_id = devices.APR39, value_down = 0.0, value_up = 1.0, name = _('AN/APR-39 Power - OFF else ON'), category = _('AN/APR-39 RWR')},
	{down = device_commands.apr39Power, cockpit_device_id = devices.APR39, value_down = 0.0, name = _('AN/APR-39 Power - OFF'), category = _('AN/APR-39 RWR')},
	{down = device_commands.apr39Power, cockpit_device_id = devices.APR39, value_down = 1.0, name = _('AN/APR-39 Power - ON'), category = _('AN/APR-39 RWR')},
	{down = Keys.apr39PowerCycle, name = _('AN/APR-39 Power - ON/OFF'), category = _('AN/APR-39 RWR')},

	{down = device_commands.apr39Volume, cockpit_device_id = devices.APR39, value_down = 1.0, name = _('AN/APR-39 Volume - MAX'), category = _('AN/APR-39 RWR')},
	{down = device_commands.apr39Volume, cockpit_device_id = devices.APR39, value_down = 0.0, name = _('AN/APR-39 Volume - MIN'), category = _('AN/APR-39 RWR')},
	{pressed = Keys.apr39VolumeIncDec, value_pressed = 0.005,  name = _('AN/APR-39 Volume - CW/Increase'), category = _('AN/APR-39 RWR')},
	{pressed = Keys.apr39VolumeIncDec, value_pressed = -0.005, name = _('AN/APR-39 Volume - CCW/Decrease'), category = _('AN/APR-39 RWR')},

	{down = device_commands.apr39Brightness, cockpit_device_id = devices.APR39, value_down = 1.0, name = _('AN/APR-39 Brightness - MAX'), category = _('AN/APR-39 RWR')},
	{down = device_commands.apr39Brightness, cockpit_device_id = devices.APR39, value_down = 0.0, name = _('AN/APR-39 Brightness - MIN'), category = _('AN/APR-39 RWR')},
	{pressed = Keys.apr39BrightnessIncDec, value_pressed = 0.005, name = _('AN/APR-39 Brightness - CW/Increase'), category = _('AN/APR-39 RWR')},
	{pressed = Keys.apr39BrightnessIncDec, value_pressed = -0.005, name = _('AN/APR-39 Brightness - CCW/Decrease'), category = _('AN/APR-39 RWR')},

	-- Electrical Systems
	-- TODO: Consider replacing the first two
    {combos = {{key = 'B'}}, down = Keys.BattSwitch, name = _('Battery Switch'), category = _('Electrical Systems')},
	{combos = {{key = 'B', reformers = {'LCtrl'}}}, down = Keys.ExtPwrSwitch, name = _('External Power Switch'), category = _('Electrical Systems')},

	{down = Keys.extPwrSwitchOn, name = _('External Power Switch - ON'), category = _('Electrical Systems')},
	{down = Keys.extPwrSwitchOff, name = _('External Power Switch - OFF'), category = _('Electrical Systems')},
	{down = Keys.extPwrSwitchOff, up = Keys.extPwrSwitchOn, name = _('External Power Switch - OFF else ON'), category = _('Electrical Systems')},
	{down = Keys.extPwrSwitchOn, up = Keys.extPwrSwitchOff, name = _('External Power Switch - ON else OFF'), category = _('Electrical Systems')},

	{down = Keys.apuGenSwitchOn, name = _('APU GEN Switch - ON'),   category = _('Electrical Systems')},
	{down = Keys.apuGenSwitchOff, name = _('APU GEN Switch - OFF'),   category = _('Electrical Systems')},
	{down = Keys.apuGenSwitchOff, up = Keys.apuGenSwitchOn, name = _('APU GEN Switch - OFF else ON'),   category = _('Electrical Systems')},
	{down = Keys.apuGenSwitchOn, up = Keys.apuGenSwitchOff, name = _('APU GEN Switch - ON else OFF'),   category = _('Electrical Systems')},

	{down = Keys.BattSwitchOn, name = _('Battery Switch - ON'), category = _('Electrical Systems')},
	{down = Keys.BattSwitchOff, name = _('Battery Switch - OFF'), category = _('Electrical Systems')},
	{down = Keys.BattSwitchOn, up = Keys.BattSwitchOff, name = _('Battery Switch - ON else OFF'), category = _('Electrical Systems')},
	{down = Keys.BattSwitchOff, up = Keys.BattSwitchOn, name = _('Battery Switch - OFF else ON'), category = _('Electrical Systems')},

	{down = Keys.gen1SwitchOn, name = _('GEN 1 Switch - ON'),   category = _('Electrical Systems')},
	{down = Keys.gen1SwitchOff, name = _('GEN 1 Switch - OFF'),   category = _('Electrical Systems')},
	{down = Keys.gen1SwitchOff, up = Keys.gen1SwitchOn, name = _('GEN 1 Switch - OFF else ON'),   category = _('Electrical Systems')},
	{down = Keys.gen1SwitchOn, up = Keys.gen1SwitchOff, name = _('GEN 1 Switch - ON else OFF'),   category = _('Electrical Systems')},

	{down = Keys.gen2SwitchOn, name = _('GEN 2 Switch - ON'),   category = _('Electrical Systems')},
	{down = Keys.gen2SwitchOff, name = _('GEN 2 Switch - OFF'),   category = _('Electrical Systems')},
	{down = Keys.gen2SwitchOff, up = Keys.gen2SwitchOn, name = _('GEN 2 Switch - OFF else ON'),   category = _('Electrical Systems')},
	{down = Keys.gen2SwitchOn, up = Keys.gen2SwitchOff, name = _('GEN 2 Switch - ON else OFF'),   category = _('Electrical Systems')},
	
	{down = Keys.switchAPUOff, name = _('APU CONTROL - OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchAPUOn, name = _('APU CONTROL - ON'),   category = _('Electrical Systems')},
	{down = Keys.switchAPUOn, up = Keys.switchAPUOff, name = _('APU CONTROL  - ON else OFF'),  category = _('Electrical Systems')},
	{down = Keys.switchAPUOff, up = Keys.switchAPUOn, name = _('APU CONTROL  - OFF else ON'),  category = _('Electrical Systems')},

	{down = Keys.switchFuelPumpPrime	, name = _('Fuel Pump Switch - PRIME'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpOff		, name = _('Fuel Pump Switch - OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpApuBoost	, name = _('Fuel Pump Switch - APU BOOST'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpPrime	, up = Keys.switchFuelPumpOff, name = _('Fuel Pump Switch - PRIME else OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpOff		, up = Keys.switchFuelPumpPrime, name = _('Fuel Pump Switch - OFF else PRIME'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpApuBoost	, up = Keys.switchFuelPumpOff, name = _('Fuel Pump Switch - APU BOOST else OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchFuelPumpOff		, up = Keys.switchFuelPumpApuBoost, name = _('Fuel Pump Switch - OFF else APU BOOST'),   category = _('Electrical Systems')},

	{down = Keys.switchAirSourceApu		, name = _('Air Source Switch - APU'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceOff		, name = _('Air Source Switch - OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceEngine	, name = _('Air Source Switch - ENGINE'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceApu		, up = Keys.switchAirSourceOff	, name = _('Air Source Switch - APU else OFF'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceOff		, up = Keys.switchAirSourceApu	, name = _('Air Source Switch - OFF else APU'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceOff		, up = Keys.switchAirSourceEngine	, name = _('Air Source Switch - OFF else ENGINE'),   category = _('Electrical Systems')},
	{down = Keys.switchAirSourceEngine	, up = Keys.switchAirSourceOff	, name = _('Air Source Switch - ENGINE else OFF'),   category = _('Electrical Systems')},

	-- Cyclic
	{combos = {{key = ';', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimUp, name = _('Cyclic Trim Nose Up'), category = _('Cyclic')},
	{combos = {{key = '.', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimDown, name = _('Cyclic Trim Nose Down'), category = _('Cyclic')},
	{combos = {{key = ',', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimLeft, name = _('Cyclic Trim Roll Left'), category = _('Cyclic')},
	{combos = {{key = '/', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimRight, name = _('Cyclic Trim Roll Right'), category = _('Cyclic')},
	{pressed = EFM_commands.trimRelease, up = EFM_commands.trimSet, name = _('Cyclic Trim Release'), category = _('Cyclic')},
    {up = EFM_commands.trimReset, name = _('Cyclic Trim Reset'), category = _('Cyclic')},

	-- Radios
	{down = Keys.ptt, up = Keys.ptt, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, value_up = 0.0, name = _('PTT - Push To Talk (SRS)'), category = _('Radios')},
	{down = Keys.radioPTT, cockpit_device_id = devices.BASE_RADIO, name = _('PTT - Push To Talk (Game Comms)'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorInc, cockpit_device_id = devices.PLT_ICP, name = _('Pilot ICP ICS XMIT Select Next Radio'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorDec, cockpit_device_id = devices.PLT_ICP, name = _('Pilot ICP ICS XMIT Select Previous Radio'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 0.0, name = _('Pilot ICP ICS XMIT Selector - ICS'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 0.2, name = _('Pilot ICP ICS XMIT Selector - 1 (FM1)'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 0.4, name = _('Pilot ICP ICS XMIT Selector - 2 (UHF)'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 0.6, name = _('Pilot ICP ICS XMIT Selector - 3 (VHF)'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 0.8, name = _('Pilot ICP ICS XMIT Selector - 4 (FM2)'), category = _('Radios')},
	{down = device_commands.pilotICPXmitSelector, cockpit_device_id = devices.BASERADIO, value_down = 1.0, name = _('Pilot ICP ICS XMIT Selector - 5 (HF)'), category = _('Radios')},
	
	{down = device_commands.pilotICPToggleFM1, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot FM1 - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleUHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot UHF - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleVHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot VHF - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleFM2, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot FM2 - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot HF - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleVOR, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot AUX - ON'), category = _('Radios')},
	{down = device_commands.pilotICPToggleADF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot NAV - ON'), category = _('Radios')},
	
	{down = device_commands.pilotICPToggleFM1, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot FM1 - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleUHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot UHF - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleVHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot VHF - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleFM2, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot FM2 - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot HF - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleVOR, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot AUX - OFF'), category = _('Radios')},
	{down = device_commands.pilotICPToggleADF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot NAV - OFF'), category = _('Radios')},

    -- Countermeasures
	{combos = {{key = 'Insert'}}, down = Keys.dispenseChaffDown, up = Keys.dispenseChaffUp, name = _('Chaff Dispense'), category = _('Countermeasures')},
	{combos = {{key = 'Delete'}}, down = Keys.dispenseFlareDown, up = Keys.dispenseFlareUp, name = _('Flare Dispense'), category = _('Countermeasures')},
	{down = device_commands.cmProgramDial, cockpit_device_id = devices.M130, value_down = 0.0, name = _('Chaff Dispenser Mode Selector - OFF'), category = _('Countermeasures')},
	{down = device_commands.cmProgramDial, cockpit_device_id = devices.M130, value_down = 0.5, name = _('Chaff Dispenser Mode Selector - MAN'), category = _('Countermeasures')},
	{down = device_commands.cmProgramDial, cockpit_device_id = devices.M130, value_down = 1.0, name = _('Chaff Dispenser Mode Selector - AUTO'), category = _('Countermeasures')},
	{down = Keys.cmProgramDialInc, name = _('Chaff Dispenser Mode Selector - CW/Increase'), category = _('Countermeasures')},
	{down = Keys.cmProgramDialDec, name = _('Chaff Dispenser Mode Selector - CCW/Decrease'), category = _('Countermeasures')},
	{down = Keys.cmProgramDialCycle, name = _('Chaff Dispenser Mode Selector - OFF/MAN/AUTO'), category = _('Countermeasures')},

	-- AN/AVS-7
	{down = Keys.avs7Toggle, name = _('AN/AVS-7 ON/OFF'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.decAVS7Brightness, up = device_commands.decAVS7Brightness, cockpit_device_id = devices.AVS7, value_down = 1.0, value_up = 0.0, name = _('AN/AVS-7 Brighten'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.incAVS7Brightness, up = device_commands.incAVS7Brightness, cockpit_device_id = devices.AVS7, value_down = -1.0, value_up = 0.0, name = _('AN/AVS-7 Dim'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 1.0, name = _('AN/AVS-7 ADJ'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 0.0, name = _('AN/AVS-7 ON'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = -1.0, name = _('AN/AVS-7 OFF'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, up = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 0.0, value_up = -1.0, name = _('AN/AVS-7 ON else OFF'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, up = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = -1.0, value_up = 0.0, name = _('AN/AVS-7 OFF else ON'),	category = _('AN/AVS-7 HUD')},

	-- Wipers
	{down = Keys.wiperSelectorInc, 	 name = _('Wipers - CW/Increase'),		category = _('General')},
	{down = Keys.wiperSelectorDec, 	 name = _('Wipers - CCW/Decrease'),		category = _('General')},
	{down = Keys.wiperSelectorCycle, name = _('Wipers - PARK/OFF/LOW/HI'),	category = _('General')},

    -- Lighting
    {down = Keys.landingLightToggle, 		name = _('Landing Light ON/OFF'),	category = _('Lighting')},
    {pressed = Keys.landingLightExtend, 	name = _('Landing Light Extend'),	category = _('Lighting')},
    {pressed = Keys.landingLightRetract, 	name = _('Landing Light Retract'),	category = _('Lighting')},

	{down = Keys.searchLightToggle, 	name = _('Search Light ON/OFF'),	category = _('Lighting')},
    {pressed = Keys.searchLightExtend, 	name = _('Search Light Extend'),	category = _('Lighting')},
    {pressed = Keys.searchLightRetract,	name = _('Search Light Retract'),	category = _('Lighting')},
    {pressed = Keys.searchLightLeft, 	name = _('Search Light Left'),		category = _('Lighting')},
    {pressed = Keys.searchLightRight, 	name = _('Search Light Right'),		category = _('Lighting')},
    {pressed = Keys.searchLightBrighten,name = _('Search Light Brighten'),	category = _('Lighting')},
    {pressed = Keys.searchLightDim, 	name = _('Search Light Dim'),		category = _('Lighting')},

	{combos = {{key = 'L', reformers = {'LAlt'}}},	down = 3256, cockpit_device_id  = 0,	value_down = 1.0,	name = _('Flashlight'),	category = _('Lighting')},

	-- Overhead Panel Lights
	{pressed = Keys.glareshieldLightsInc	, value_pressed = 0.001, name = _('Glareshield Lights - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.glareshieldLightsDec	, value_pressed = 0.001, name = _('Glareshield Lights - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.cpltInstrLightsInc		, value_pressed = 0.001, name = _('Copilot Flight Instrument Lights OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.cpltInstrLightsDec		, value_pressed = 0.001, name = _('Copilot Flight Instrument Lights OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.lightedSwitchesInc		, value_pressed = 0.001, name = _('Lighted Switches OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.lightedSwitchesDec		, value_pressed = 0.001, name = _('Lighted Switches OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.upperConsoleLightsInc	, value_pressed = 0.001, name = _('Upper Console Lights OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.upperConsoleLightsDec	, value_pressed = 0.001, name = _('Upper Console Lights OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.lowerConsoleLightsInc	, value_pressed = 0.001, name = _('Lower Console Lights OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.lowerConsoleLightsDec	, value_pressed = 0.001, name = _('Lower Console Lights OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.pltInstrLightsInc		, value_pressed = 0.001, name = _('Pilot Flight Instrument Lights OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.pltInstrLightsDec		, value_pressed = 0.001, name = _('Pilot Flight Instrument Lights OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{pressed = Keys.nonFltInstrLightsInc	, value_pressed = 0.001, name = _('Non Flight Instrument Lights OFF/BRT - CW/Increase'), category = _('Internal Lights')},
	{pressed = Keys.nonFltInstrLightsDec	, value_pressed = 0.001, name = _('Non Flight Instrument Lights OFF/BRT - CCW/Decrease'), category = _('Internal Lights')},
	{down = Keys.formationLightsInc			, name = _('Formation Lights - CW/Increase'), category = _('External Lights')},
	{down = Keys.formationLightsDec			, name = _('Formation Lights - CCW/Decrease'), category = _('External Lights')},

	-- Cabin Dome Lights BLUE/OFF/WHITE
	{down = device_commands.cabinLightMode, up = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Cabin Dome Lights - BLUE else OFF'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, up = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Cabin Dome Lights - OFF else BLUE'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, up = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, value_up = 0.0, name = _('Cabin Dome Lights - WHITE else OFF'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, up = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = -1.0, name = _('Cabin Dome Lights - OFF else WHITE'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Cabin Dome Lights - BLUE'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Cabin Dome Lights - OFF'), category = _('Internal Lighting')},
	{down = device_commands.cabinLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, name = _('Cabin Dome Lights - WHITE'), category = _('Internal Lighting')},
	{down = Keys.cyclecabinLightMode, name = _('Cabin Dome Lights - WHITE/OFF/BLUE'), category = _('Internal Lighting')},
	
	-- Cockpit Lights BLUE/OFF/WHITE
	{down = device_commands.cockpitLightMode, up = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Cockpit Lights - BLUE else OFF'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, up = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Cockpit Lights - OFF else BLUE'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, up = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, value_up = 0.0, name = _('Cockpit Lights - WHITE else OFF'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, up = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = -1.0, name = _('Cockpit Lights - OFF else WHITE'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Cockpit Lights - BLUE'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Cockpit Lights - OFF'), category = _('Internal Lighting')},
	{down = device_commands.cockpitLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, name = _('Cockpit Lights - WHITE'), category = _('Internal Lighting')},
	{down = Keys.cyclecockpitLightMode, name = _('Cockpit Lights - WHITE/OFF/BLUE'), category = _('Internal Lighting')},
		
	-- NAV lights NORM/IR
	{down = device_commands.navLightMode, up = device_commands.navLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Nav Light - IR else NORM'), category = _('External Lighting')},
	{down = device_commands.navLightMode, up = device_commands.navLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Nav Light - NORM else IR'), category = _('External Lighting')},
	{down = device_commands.navLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Nav Light - IR'), category = _('External Lighting')},
	{down = device_commands.navLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Nav Light - NORM'), category = _('External Lighting')},
	{down = Keys.navLightModeCycle, name = _('Nav Light - NORM/IR'), category = _('External Lighting')},
		
	-- Position Lights BRIGHT/OFF/DIM
	{down = device_commands.posLightIntensity, up = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Position Lights - BRIGHT else OFF'), category = _('External Lighting')},
	{down = device_commands.posLightIntensity, up = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Position Lights - OFF else BRIGHT'), category = _('External Lighting')},
	{down = device_commands.posLightIntensity, up = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, value_up = 0.0, name = _('Position Lights - DIM else OFF'), category = _('External Lighting')},
	{down = device_commands.posLightIntensity, up = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = -1.0, name = _('Position Lights - OFF else DIM'), category = _('External Lighting')},		
	{down = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Position Lights - BRIGHT'), category = _('External Lighting')},
	{down = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Position Lights - OFF'), category = _('External Lighting')},
	{down = device_commands.posLightIntensity, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, name = _('Position Lights - DIM'), category = _('External Lighting')},
	{down = Keys.cycleposLightIntensity, name = _('Position Lights - BRIGHT/OFF/DIM'), category = _('External Lighting')},

	-- Position Lights FLASH/STEADY
	{down = device_commands.posLightMode, up = device_commands.posLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Position Lights - FLASH else STEADY'), category = _('External Lighting')},
	{down = device_commands.posLightMode, up = device_commands.posLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Position Lights - STEADY else FLASH'), category = _('External Lighting')},
	{down = device_commands.posLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Position Lights - FLASH'), category = _('External Lighting')},
	{down = device_commands.posLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Position Lights - STEADY'), category = _('External Lighting')},
	{down = Keys.posLightModeCycle, name = _('Position Lights - FLASH/STEADY'), category = _('External Lighting')},	

	-- Anticollision Lights LOWER/BOTH/UPPER
	{down = device_commands.antiLightGrp, up = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Anticollision Lights - LOWER else BOTH'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, up = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Anticollision Lights - BOTH else LOWER'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, up = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, value_up = 0.0, name = _('Anticollision Lights - UPPER else BOTH'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, up = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = -1.0, name = _('Anticollision Lights - BOTH else UPPER'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Anticollision Lights - LOWER'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Anticollision Lights - BOTH'), category = _('External Lighting')},
	{down = device_commands.antiLightGrp, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, name = _('Anticollision Lights - UPPER'), category = _('External Lighting')},
	{down = Keys.antiLightGrpCycle, name = _('Anticollision Lights - UPPER/BOTH/LOWER'), category = _('External Lighting')},

	-- Anticollision Lights NIGHT/OFF/DAY
	{down = device_commands.antiLightMode, up = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Anticollision Lights - NIGHT else OFF'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, up = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Anticollision Lights - OFF else NIGHT'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, up = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, value_up = 0.0, name = _('Anticollision Lights - DAY else OFF'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, up = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = -1.0, name = _('Anticollision Lights - OFF else DAY'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Anticollision Lights - NIGHT'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Anticollision Lights - OFF'), category = _('External Lighting')},
	{down = device_commands.antiLightMode, cockpit_device_id = devices.EXTLIGHTS, value_down = -1.0, name = _('Anticollision Lights - DAY'), category = _('External Lighting')},
	{down = Keys.antiLightModeCycle, name = _('Anticollision Lights - DAY/OFF/NIGHT'), category = _('External Lighting')},

	-- Magnetic Compass Light
	{down = device_commands.magCompassLights, up = device_commands.magCompassLights, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('Magnetic Compass Light - ON else OFF'), category = _('External Lighting')},
	{down = device_commands.magCompassLights, up = device_commands.magCompassLights, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('Magnetic Compass Light - OFF else ON'), category = _('External Lighting')},
	{down = device_commands.magCompassLights, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('Magnetic Compass Light - ON'), category = _('External Lighting')},
	{down = device_commands.magCompassLights, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('Magnetic Compass Light - OFF'), category = _('External Lighting')},
	{down = Keys.magCompassLightsCycle, name = _('Magnetic Compass Light - ON/OFF'), category = _('External Lighting')},

    -- Others
	{combos = {{key = 'E', reformers = {'LCtrl'}}}, down 	= iCommandPlaneEject, 	name = _('Eject (3 times)'), category = _('General')},
    {down = Keys.toggleDoors,     name = _('Pilot Door Open/Close'), category = _('Doors')},
    {down = Keys.toggleCopilotDoor,		name = _('Copilot Door Open/Close'), category = _('Doors')},
    {down = Keys.toggleLeftCargoDoor,	name = _('Left Cargo Door Open/Close'), category = _('Doors')},
    {down = Keys.toggleRightCargoDoor,	 name = _('Right Cargo Door Open/Close'), category = _('Doors')},
    {down = Keys.toggleLeftGunnerDoor,	 name = _('Left Gunner Hatch Open/Close'), category = _('Doors')},
    {down = Keys.toggleRightGunnerDoor,	 name = _('Right Gunner Hatch Open/Close'), category = _('Doors')},

	--{down = device_commands.doorPlt,	up = device_commands.doorPlt,	 cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,		name = _('Pilot Door - Open else Close'), category = _('Doors')},
	{down = Keys.toggleDoorsOpen,	up = Keys.toggleDoorsClose,	 name = _('Pilot Door - Open else Close'), category = _('Doors')},
	{down = device_commands.doorCplt,	up = device_commands.doorCplt,		cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,	name = _('Copilot Door - Open else Close'), category = _('Doors')},
	{down = device_commands.doorLCargo,	up = device_commands.doorLCargo,	cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,	name = _('Left Cargo Door - Open else Close'), category = _('Doors')},
	{down = device_commands.doorRCargo,	up = device_commands.doorRCargo,	cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,	name = _('Right Cargo Door - Open else Close'), category = _('Doors')},
	{down = device_commands.doorLGnr,	up = device_commands.doorLGnr,  	cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,	name = _('Left Gunner Hatch - Open else Close'), category = _('Doors')},
	{down = device_commands.doorRGnr,	up = device_commands.doorRGnr,  	cockpit_device_id = devices.MISC,	value_down = 1, value_up = 0,	name = _('Right Gunner Hatch - Open else Close'), category = _('Doors')},

	--{down = device_commands.doorPlt,	up = device_commands.doorPlt,	 cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,		name = _('Pilot Door - Close else Open'), category = _('Doors')},
	{down = Keys.toggleDoorsClose,	up = Keys.toggleDoorsOpen,	 name = _('Pilot Door - Close else Open'), category = _('Doors')},
	{down = device_commands.doorCplt,	up = device_commands.doorCplt,		cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,	name = _('Copilot Door - Close else Open'), category = _('Doors')},
	{down = device_commands.doorLCargo,	up = device_commands.doorLCargo,	cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,	name = _('Left Cargo Door - Close else Open'), category = _('Doors')},
	{down = device_commands.doorRCargo,	up = device_commands.doorRCargo,	cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,	name = _('Right Cargo Door - Close else Open'), category = _('Doors')},
	{down = device_commands.doorLGnr,	up = device_commands.doorLGnr,  	cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,	name = _('Left Gunner Hatch - Close else Open'), category = _('Doors')},
	{down = device_commands.doorRGnr,	up = device_commands.doorRGnr,  	cockpit_device_id = devices.MISC,	value_down = 0, value_up = 1,	name = _('Right Gunner Hatch - Close else Open'), category = _('Doors')},

	--{down = device_commands.doorPlt,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Pilot Door - Close'), category = _('Doors')},
	{down = Keys.toggleDoorsClose,	 name = _('Pilot Door - Close'), category = _('Doors')},
	{down = device_commands.doorCplt,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Copilot Door - Close'), category = _('Doors')},
	{down = device_commands.doorLCargo,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Left Cargo Door - Close'), category = _('Doors')},
	{down = device_commands.doorRCargo,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Right Cargo Door - Close '), category = _('Doors')},
	{down = device_commands.doorLGnr,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Left Gunner Hatch - Close'), category = _('Doors')},
	{down = device_commands.doorRGnr,	cockpit_device_id = devices.MISC, value_down = 0, name = _('Right Gunner Hatch - Close'), category = _('Doors')},

	--{down = device_commands.doorPlt,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Pilot Door - Open'), category = _('Doors')},
	{down = Keys.toggleDoorsOpen,	 name = _('Pilot Door - Open'), category = _('Doors')},
	{down = device_commands.doorCplt,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Copilot Door - Open'), category = _('Doors')},
	{down = device_commands.doorLCargo,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Left Cargo Door - Open'), category = _('Doors')},
	{down = device_commands.doorRCargo,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Right Cargo Door - Open '), category = _('Doors')},
	{down = device_commands.doorLGnr,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Left Gunner Hatch - Open'), category = _('Doors')},
	{down = device_commands.doorRGnr,	cockpit_device_id = devices.MISC, value_down = 1, name = _('Right Gunner Hatch - Open'), category = _('Doors')},
	
	-- PILOT LC6 CHRONOMETER
	{down = device_commands.resetSetBtn,		up = device_commands.resetSetBtn,		cockpit_device_id = devices.PLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Pilot RESET/SET Button'), category = _('Chronometer')},
	{down = device_commands.modeBtn,			up = device_commands.modeBtn, 			cockpit_device_id = devices.PLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Pilot MODE Button'), category = _('Chronometer')},
	{down = device_commands.startStopAdvBtn,	up = device_commands.startStopAdvBtn, 	cockpit_device_id = devices.PLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Pilot START/STOP/ADVANCE Button'), category = _('Chronometer')},

	-- COPILOT LC6 CHRONOMETER
	{down = device_commands.resetSetBtn,		up = device_commands.resetSetBtn,		cockpit_device_id = devices.CPLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Copilot RESET/SET Button'), category = _('Chronometer')},
	{down = device_commands.modeBtn,			up = device_commands.modeBtn, 			cockpit_device_id = devices.CPLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Copilot MODE Button'), category = _('Chronometer')},
	{down = device_commands.startStopAdvBtn,	up = device_commands.startStopAdvBtn, 	cockpit_device_id = devices.CPLTLC6, value_down = 1, value_up = 0,	name = _('Chronometer Copilot START/STOP/ADVANCE Button'), category = _('Chronometer')},

	-- Fuel Probe
	{down = Keys.toggleProbe,	 name = _('AAR Probe - Extend/Retract'), category = _('General')},
	{down = device_commands.fuelProbe, up = device_commands.fuelProbe, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, value_up = 0.0, name = _('AAR Probe - Extend else Retract'), category = _('General')},
	{down = device_commands.fuelProbe, up = device_commands.fuelProbe, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, value_up = 1.0, name = _('AAR Probe - Retract else Extend'), category = _('General')},
	{down = device_commands.fuelProbe, cockpit_device_id = devices.EXTLIGHTS, value_down = 1.0, name = _('AAR Probe - Extend'), category = _('General')},
	{down = device_commands.fuelProbe, cockpit_device_id = devices.EXTLIGHTS, value_down = 0.0, name = _('AAR Probe - Retract'), category = _('General')},

	-- No. 1 Fuel Boost Pump ON/OFF (Left)
	-- {down = Keys.fuelPumpLCycle,	 name = _('No. 1 Fuel Boost Pump - ON/OFF'), category = _('General')},
	-- {down = EFM_commands.fuelPumpL, up = EFM_commands.fuelPumpL, cockpit_device_id = devices.EFM_HELPER, value_down = 1.0, value_up = 0.0, name = _('No. 1 Fuel Boost Pump - ON else OFF'), category = _('General')},
	-- {down = EFM_commands.fuelPumpL, up = EFM_commands.fuelPumpL, cockpit_device_id = devices.EFM_HELPER, value_down = 0.0, value_up = 1.0, name = _('No. 1 Fuel Boost Pump - OFF else ON'), category = _('General')},
	-- {down = EFM_commands.fuelPumpL, cockpit_device_id = devices.EFM_HELPER, value_down = 1.0, name = _('No. 1 Fuel Boost Pump - ON'), category = _('General')},
	-- {down = EFM_commands.fuelPumpL, cockpit_device_id = devices.EFM_HELPER, value_down = 0.0, name = _('No. 1 Fuel Boost Pump - OFF'), category = _('General')},

	-- No. 2 Fuel Boost Pump ON/OFF (Right)
	-- {down = Keys.fuelPumpRCycle,	 name = _('No. 2 Fuel Boost Pump - ON/OFF'), category = _('General')},
	-- {down = EFM_commands.fuelPumpR, up = EFM_commands.fuelPumpR, cockpit_device_id = devices.EFM_HELPER, value_down = 1.0, value_up = 0.0, name = _('No. 2 Fuel Boost Pump - ON else OFF'), category = _('General')},
	-- {down = EFM_commands.fuelPumpR, up = EFM_commands.fuelPumpR, cockpit_device_id = devices.EFM_HELPER, value_down = 0.0, value_up = 1.0, name = _('No. 2 Fuel Boost Pump - OFF else ON'), category = _('General')},
	-- {down = EFM_commands.fuelPumpR, cockpit_device_id = devices.EFM_HELPER, value_down = 1.0, name = _('No. 2 Fuel Boost Pump - ON'), category = _('General')},
	-- {down = EFM_commands.fuelPumpR, cockpit_device_id = devices.EFM_HELPER, value_down = 0.0, name = _('No. 2 Fuel Boost Pump - OFF'), category = _('General')},

	-- AFMS Aux Fuel Management Panel
	-- Aux Fuel Transfer Mode MAN/OFF/AUTO
	{down = device_commands.afmcpXferMode, up = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = 1.0, value_up = 0.0, 	name = _('Aux Fuel Transfer Mode - AUTO else OFF'), category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, up = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = 0.0, value_up = 1.0, 	name = _('Aux Fuel Transfer Mode - OFF else AUTO'), category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, up = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = -1.0, value_up = 0.0, name = _('Aux Fuel Transfer Mode - MAN else OFF'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, up = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = 0.0, value_up = -1.0, name = _('Aux Fuel Transfer Mode - OFF else MAN'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = 1.0, 	name = _('Aux Fuel Transfer Mode - AUTO'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = 0.0, 	name = _('Aux Fuel Transfer Mode - OFF'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferMode, cockpit_device_id = devices.AFMS, value_down = -1.0, name = _('Aux Fuel Transfer Mode - MAN'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpXferModeCycle,	 name = _('Aux Fuel Transfer Mode - MAN/OFF/AUTO'), category = _('AFMS (AUX FUEL Management Panel)')},

	-- Aux Fuel Manual Transfer RIGHT/BOTH/LEFT
	{down = device_commands.afmcpManXfer, up = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = 1.0, 	value_up = 0.0, 	name = _('Aux Fuel Manual Transfer - LEFT else BOTH'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, up = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = 0.0, 	value_up = 1.0, 	name = _('Aux Fuel Manual Transfer - BOTH else LEFT'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, up = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = -1.0, 	value_up = 0.0, 	name = _('Aux Fuel Manual Transfer - RIGHT else BOTH'), category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, up = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = 0.0, 	value_up = -1.0, 	name = _('Aux Fuel Manual Transfer - BOTH else RIGHT'), category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = 1.0, 	name = _('Aux Fuel Manual Transfer - LEFT'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = 0.0, 	name = _('Aux Fuel Manual Transfer - BOTH'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpManXfer, cockpit_device_id = devices.AFMS, value_down = -1.0, 	name = _('Aux Fuel Manual Transfer - RIGHT'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpManXferCycle,	 name = _('Aux Fuel Manual Transfer - RIGHT/BOTH/LEFT'), category = _('AFMS (AUX FUEL Management Panel)')},

	-- Aux Fuel Transfer From OUTBD/INBD
	{down = device_commands.afmcpXferFrom, up = device_commands.afmcpXferFrom, cockpit_device_id = devices.AFMS, value_down = 1.0, value_up = 0.0, 	name = _('Aux Fuel Transfer From - INBD else OUTBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferFrom, up = device_commands.afmcpXferFrom, cockpit_device_id = devices.AFMS, value_down = 0.0, value_up = 1.0, 	name = _('Aux Fuel Transfer From -  OUTBD else INBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferFrom, cockpit_device_id = devices.AFMS, value_down = 1.0, name = _('Aux Fuel Transfer From - INBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpXferFrom, cockpit_device_id = devices.AFMS, value_down = 0.0, name = _('Aux Fuel Transfer From - OUTBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpXferFromCycle,	 name = _('Aux Fuel Transfer From - OUTBD/INBD'), category = _('AFMS (AUX FUEL Management Panel)')},

	-- Aux Fuel Pressurization Selector
	{down = device_commands.afmcpPress, cockpit_device_id = devices.AFMS, value_down = 0/3,	name = _('Aux Fuel Pressurization Selector - OFF'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpPress, cockpit_device_id = devices.AFMS, value_down = 1/3,	name = _('Aux Fuel Pressurization Selector - INBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpPress, cockpit_device_id = devices.AFMS, value_down = 2/3, name = _('Aux Fuel Pressurization Selector - OUTBD'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = device_commands.afmcpPress, cockpit_device_id = devices.AFMS, value_down = 3/3, name = _('Aux Fuel Pressurization Selector - ALL'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpPressCycle,	 name = _('Aux Fuel Pressurization Selector - OFF/INBD/OUTBD/ALL'), category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpPressInc, name = _('Aux Fuel Pressurization Selector - CW/Increase'), 	category = _('AFMS (AUX FUEL Management Panel)')},
	{down = Keys.afmcpPressDec, name = _('Aux Fuel Pressurization Selector - CCW/Decrease'), 	category = _('AFMS (AUX FUEL Management Panel)')},	

	-- Collective
	{combos = {{key = 'Num+'}}, pressed 	= EFM_commands.collectiveIncrease, 	name = _('Collective Increase'), category = _('Collective')},
	{combos = {{key = 'Num-'}}, pressed 	= EFM_commands.collectiveDecrease, 	name = _('Collective Decrease'), category = _('Collective')},

	-- Cyclic
	{combos = {{key = 'Right'}},	down = iCommandPlaneRoll,	 up = iCommandPlaneRoll,	value_down = 1.0, value_up = 0.0, 	category = _('Cyclic'),	name = _('Cyclic - Bank Right')},
	{combos = {{key = 'Left'}},		down = iCommandPlaneRoll,	 up = iCommandPlaneRoll,	value_down = -1.0, value_up = 0.0, 	category = _('Cyclic'),	name = _('Cyclic - Bank Left')},
    {combos = {{key = 'Down'}},		down = iCommandPlanePitch,	 up = iCommandPlanePitch,	value_down = 1.0, value_up = 0.0,	category = _('Cyclic'),	name = _('Cyclic - Nose Up')},
    {combos = {{key = 'Up'}},		down = iCommandPlanePitch,	 up = iCommandPlanePitch,	value_down = -1.0, value_up = 0.0,	category = _('Cyclic'),	name = _('Cyclic - Nose Down')},

	-- Pedals
    {combos = {{key = 'Z'}},down = iCommandPlaneRudder, up = iCommandPlaneRudder, 	value_down = -1.0, value_up = 0.0, 	category = _('Pedals'),	name = _('Pedal Left')},
    {combos = {{key = 'X'}},down = iCommandPlaneRudder, up = iCommandPlaneRudder, 	value_down = 1.0, value_up = 0.0, 	category = _('Pedals'),	name = _('Pedal Right')},

	-- Wheel Brake
	{combos = {{key = 'W'}}, down = EFM_commands.wheelbrake, value_down = 1.0, up = EFM_commands.wheelbrake, value_up = 0,  name = _('Wheel Brakes'), category = _('General')},

	-- Night Vision Goggles
	{combos = {{key = 'N'}}, down = iCommandViewNightVisionGogglesOn,	 name = _('Toggle Night Vision Goggles'), 	category = _('NVG')},
	{combos = {{key = 'N', reformers = {'RCtrl'}}}, pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Gain NVG up')  , category = _('NVG')},
	{combos = {{key = 'N', reformers = {'RAlt'}}} , pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Gain NVG down'), category = _('NVG')},
	
    -- Multicrew
	{combos = {{key = '1'}},	down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Pilot Seat'),			category = _('Crew Control')},
	{combos = {{key = '2'}},	down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Copilot Seat'),			category = _('Crew Control')},
	{combos = {{key = '3'}},	down = iCommandViewCockpitChangeSeat, value_down = 3, name = _('Occupy Left Gunner Seat'),		category = _('Crew Control')},
	{combos = {{key = '4'}},	down = iCommandViewCockpitChangeSeat, value_down = 4, name = _('Occupy Right Gunner Seat'),		category = _('Crew Control')},
	{combos = {{key = 'C'}},	down = iCommandNetCrewRequestControl,					name = _('Request Aircraft Control'),	category = _('Crew Control')},
	
	--{combos = {{key = 'P', reformers = {'RShift'}}}, down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
	
    {combos = {{key = 'Enter', reformers = {'RShift'}}},			 down = Keys.showControlInd,				name = _('Show controls indicator - UH-60L') ,			 category = _('General')},

	{down = iCommandExtCargoHook, name = _('External Cargo Hook'), 	category = _("External Cargo")},
	{down = iCommandExternalCargoAutounhook, name = _('External Cargo Autounhook'),	category = _("External Cargo")},
	{down = iCommandExternalCargoIndicator, name = _("External Cargo Indicator"),  category = _("External Cargo"), },
	{down = iCommandEmergencyCargoUnhook, name = _('External Cargo Emergency Unhook'), 	category = _("External Cargo")},

	-- Release-less Snap Views TODO: Think of 10 different usefull views. Should be "default" for the mod
	-- Think Radios, co/pilot views. cargo views. etc.
	-- When the player presses the view, they can release the key and it will stay at the view.
	-- Make sure that iCommandViewSnapViewStop is bound by default too.
	-- Copy over to joystick/default.lua when finised.
	
	-- Set your current view up as you want it saved.
	-- Press LWin+NumN - NumN being whichever numeric keypad key you intend customising.
	-- Press RAlt+Num0 - The snap view should now be saved.
	{down = iCommandViewSnapView0,	 name = _('Snap View 0 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView1,	 name = _('Snap View 1 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView2,	 name = _('Snap View 2 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView3,	 name = _('Snap View 3 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView4,	 name = _('Snap View 4 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView5,	 name = _('Snap View 5 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView6,	 name = _('Snap View 6 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView7,	 name = _('Snap View 7 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView8,	 name = _('Snap View 8 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapView9,	 name = _('Snap View 9 (Release-less)'), category = _('View Cockpit')},
	{down = iCommandViewSnapViewStop, name = _('Snap View Stop (Release-less)'), category = _('View Cockpit')},
	
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