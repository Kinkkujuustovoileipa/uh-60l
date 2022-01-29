local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
-- down = single instance,  pressed = continuous input

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

	--Baileys UH60L Binds 2022JAN23

join(res.keyCommands,
{
	-- AFCS FPS
	{down = device_commands.afcsFPS, up = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS FPS - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsFPS, up = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS FPS - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS FPS - ON'), category = _('AFCS')},
	{down = device_commands.afcsFPS, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS FPS - OFF'), category = _('AFCS')},
	
	
	-- AFCS SAS1
	{down = device_commands.afcsSAS1, up = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS SAS1 - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, up = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS SAS1 - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS SAS1 - ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS1, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS SAS1 - OFF'), category = _('AFCS')},
	
	
	-- AFCS SAS2
	{down = device_commands.afcsSAS2, up = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS SAS2 - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, up = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS SAS2 - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS SAS2 - ON'), category = _('AFCS')},
	{down = device_commands.afcsSAS2, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS SAS2 - OFF'), category = _('AFCS')},
	
	
	-- AFCS Boost
	{down = device_commands.afcsBoost, up = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS Boost - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsBoost, up = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS Boost - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS Boost - ON'), category = _('AFCS')},
	{down = device_commands.afcsBoost, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS Boost - OFF'), category = _('AFCS')},
	
	
	-- AFCS Trim
	{down = device_commands.afcsTrim, up = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('AFCS Trim - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsTrim, up = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('AFCS Trim - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('AFCS Trim - OFF'), category = _('AFCS')},
	{down = device_commands.afcsTrim, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('AFCS Trim - ON'), category = _('AFCS')},
	
	
	-- Slew Stab Fix
	{down = device_commands.slewStabDown, up = device_commands.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Up (Momentary)'), category = _('AFCS')},
	{down = device_commands.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('Manual Stabilator Slew Up'), category = _('AFCS')},
	
	{down = device_commands.slewStabUp, up = device_commands.slewStabUp, cockpit_device_id = devices.AFCS, value_down = -1.0, value_up = 0.0, name = _('Manual Stabilator Slew Down (Momentary)'), category = _('AFCS')},
	{down = device_commands.slewStabUp, cockpit_device_id = devices.AFCS, value_down = -1.0, name = _('Manual Stabilator Slew Down'), category = _('AFCS')},
	
	{down = device_commands.afcsStabAuto, up = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Stabilator Auto - ON else OFF'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, up = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 0.0, value_up = 1.0, name = _('Stabilator Auto - OFF else ON'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 1.0, name = _('Stabilator Auto - ON'), category = _('AFCS')},
	{down = device_commands.afcsStabAuto, cockpit_device_id = devices.AFCS, value_down = 0.0, name = _('Stabilator Auto - OFF'), category = _('AFCS')},
	
	
	-- Engine Control Levers
	{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 1 Control Lever - FLY'), category = _('ECQ')},
	{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 1 Control Lever - IDLE'), category = _('ECQ')},
	{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 2 Control Lever - FLY'), category = _('ECQ')},
	{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 2 Control Lever - IDLE'), category = _('ECQ')},
	
	
	-- Engine FSS
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 1 FSS - OFF'), category = _('ECQ')},
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 0.5, name = _('Engine No. 1 FSS - DIR'), category = _('ECQ')},
	{down = device_commands.eng1FSS, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 1 FSS - XFD'), category = _('ECQ')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 2 FSS - OFF'), category = _('ECQ')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 0.5, name = _('Engine No. 2 FSS - DIR'), category = _('ECQ')},
	{down = device_commands.eng2FSS, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 2 FSS - XFD'), category = _('ECQ')},
	
	
	-- Engine Starter
	{down = device_commands.eng1Starter, up = device_commands.eng1Starter, cockpit_device_id = devices.ECQ, value_down = 1.0, value_up = 0.0, name = _('Engine No. 1 Starter'), category = _('ECQ')},
	{down = device_commands.eng2Starter, up = device_commands.eng2Starter, cockpit_device_id = devices.ECQ, value_down = 1.0, value_up = 0.0, name = _('Engine No. 2 Starter'), category = _('ECQ')},
	
	
	-- Tail Wheel
	{down = device_commands.miscTailWheelLock, up = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 1.0, value_up = 0.0, name = _('Tail Wheel Lock - ON else OFF'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, up = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 0.0, value_up = 1.0, name = _('Tail Wheel Lock - OFF else ON'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 1.0, name = _('Tail Wheel Lock - ON'), category = _('MISC')},
	{down = device_commands.miscTailWheelLock, cockpit_device_id = devices.MISC, value_down = 0.0, name = _('Tail Wheel Lock - OFF'), category = _('MISC')},
	
	
	-- VIDS
	{down = device_commands.cduLampTest, up = device_commands.cduLampTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('CDU Lamp Test'), category = _('VIDS')},
	{down = device_commands.pilotPDUTest, up = device_commands.pilotPDUTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('PDU Test Pilot'), category = _('VIDS')},
	{down = device_commands.copilotPDUTest, up = device_commands.copilotPDUTest, cockpit_device_id = devices.VIDS, value_down = 1.0, value_up = 0.0, name = _('PDU Test Copilot'), category = _('VIDS')},
	
	
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

	
	--AN/ASN-128B Selectors (by shagrat)
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.00, name = _('AN/ASN-128B Select Display 1 WIND-UTC DATA'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.01, name = _('AN/ASN-128B Select Display 2 XTX/TXC KEY'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.02, name = _('AN/ASN-128B Select Display 3 GS/TK NAV M'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.03, name = _('AN/ASN-128B Select Display 4 PP'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.04, name = _('AN/ASN-128B Select Display 5 DST/BRG TIME'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.05, name = _('AN/ASN-128B Select Display 6 WP TGT'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectDisplay, cockpit_device_id = devices.ASN128B, value_down = 0.06, name = _('AN/ASN-128B Select Display 7 DATUM ROUTE'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.0, name = _('AN/ASN-128B Select Mode 1 OFF'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.01, name = _('AN/ASN-128B Select Mode 2 LAMP TEST'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.02, name = _('AN/ASN-128B Select Mode 3 TEST'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.03, name = _('AN/ASN-128B Select Mode 4 MGRS'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.04, name = _('AN/ASN-128B Select Mode 5 LAT/LONG'), category = _('AN/ASN-128B GPS DPLR')},
	{down = device_commands.SelectMode, cockpit_device_id = devices.ASN128B, value_down = 0.05, name = _('AN/ASN-128B Select Mode 6 GPS LDG'), category = _('AN/ASN-128B GPS DPLR')},


	-- Pilot ICP Selector
	{down = device_commands.pilotICPToggleFM1, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot FM1 - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleUHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot UHF - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleVHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot VHF - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleFM2, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot FM2 - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleHF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot HF - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleVOR, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot VOR - ON'), category = _('ICP')},
	{down = device_commands.pilotICPToggleADF, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, name = _('ICP Pilot ADF - ON'), category = _('ICP')},
	
	{down = device_commands.pilotICPToggleFM1, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot FM1 - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleUHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot UHF - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleVHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot VHF - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleFM2, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot FM2 - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleHF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot HF - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleVOR, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot AUX - OFF'), category = _('ICP')},
	{down = device_commands.pilotICPToggleADF, cockpit_device_id = devices.PLT_ICP, value_down = 0.0, name = _('ICP Pilot NAV - OFF'), category = _('ICP')},
	
	
	-- Countermeasures
	{down = device_commands.cmArmSwitch, cockpit_device_id = devices.M130, value_down = 0.0, name = _('Countermeasures Arming Switch - OFF'), category = _('Countermeasures')},
	{down = device_commands.cmArmSwitch, cockpit_device_id = devices.M130, value_down = 1.0, name = _('Countermeasures Arming Switch - ON'), category = _('Countermeasures')},
	
	
	-- ARC201 FM1
	{down = device_commands.fm1Btn1, up = device_commands.fm1Btn1, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 1'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn2, up = device_commands.fm1Btn2, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 2'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn3, up = device_commands.fm1Btn3, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 3'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn4, up = device_commands.fm1Btn4, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 4'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn5, up = device_commands.fm1Btn5, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 5'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn6, up = device_commands.fm1Btn6, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 6'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn7, up = device_commands.fm1Btn7, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 7'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn8, up = device_commands.fm1Btn8, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 8'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn9, up = device_commands.fm1Btn9, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 9'), category = _('ARC-201 FM')},
	{down = device_commands.fm1Btn0, up = device_commands.fm1Btn0, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button 0'), category = _('ARC-201 FM')},
	
	{down = device_commands.fm1BtnClr, up = device_commands.fm1BtnClr, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button CLR'), category = _('ARC-201 FM')},
	{down = device_commands.fm1BtnEnt, up = device_commands.fm1BtnEnt, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button ENT'), category = _('ARC-201 FM')},
	{down = device_commands.fm1BtnFreq, up = device_commands.fm1BtnFreq, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button FREQ'), category = _('ARC-201 FM')},
	{down = device_commands.fm1BtnErfOfst, up = device_commands.fm1BtnErfOfst, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button EFF OST'), category = _('ARC-201 FM')},
	{down = device_commands.fm1BtnTime, up = device_commands.fm1BtnTime, cockpit_device_id = devices.ARC201_FM1, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM1 Button TIME'), category = _('ARC-201 FM')},
	
	
	-- ARC201 FM2 ? not detected due to error?
	{down = device_commands.FM2Btn1, up = device_commands.FM2Btn1, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 1'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn2, up = device_commands.FM2Btn2, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 2'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn3, up = device_commands.FM2Btn3, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 3'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn4, up = device_commands.FM2Btn4, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 4'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn5, up = device_commands.FM2Btn5, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 5'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn6, up = device_commands.FM2Btn6, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 6'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn7, up = device_commands.FM2Btn7, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 7'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn8, up = device_commands.FM2Btn8, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 8'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn9, up = device_commands.FM2Btn9, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 9'), category = _('ARC-201 FM')},
	{down = device_commands.FM2Btn0, up = device_commands.FM2Btn0, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button 0'), category = _('ARC-201 FM')},
	
	{down = device_commands.FM2BtnClr, up = device_commands.FM2BtnClr, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button CLR'), category = _('ARC-201 FM')},
	{down = device_commands.FM2BtnEnt, up = device_commands.FM2BtnEnt, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button ENT'), category = _('ARC-201 FM')},
	{down = device_commands.FM2BtnFreq, up = device_commands.FM2BtnFreq, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button FREQ'), category = _('ARC-201 FM')},
	{down = device_commands.FM2BtnErfOfst, up = device_commands.FM2BtnErfOfst, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button EFF OST'), category = _('ARC-201 FM')},
	{down = device_commands.FM2BtnTime, up = device_commands.FM2BtnTime, cockpit_device_id = devices.ARC201_FM2, value_down = 1.0, value_up = 0.0, name = _('ARC-201 FM2 Button TIME'), category = _('ARC-201 FM')},
	
	
	-- Pilot CISP
	{down = device_commands.PilotCISHdgToggle, up = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP HDG Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, up = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP HDG Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP HDG Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISHdgToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP HDG Pilot - ON'), category = _('CISP')},
	
	{down = device_commands.PilotCISNavToggle, up = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP NAV Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, up = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP NAV Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP NAV Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISNavToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP NAV Pilot - ON'), category = _('CISP')},
	
	{down = device_commands.PilotCISAltToggle, up = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 1.0, value_up = 0.0, name = _('CISP ALT Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, up = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 0.0, value_up = 1.0, name = _('CISP ALT Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 0.0, name = _('CISP ALT Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotCISAltToggle, cockpit_device_id = devices.CISP, value_down = 1.0, name = _('CISP ALT Pilot - ON'), category = _('CISP')},

	{down = device_commands.PilotNavGPSToggle, up = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP NAV GPS Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, up = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP NAV GPS Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP NAV GPS Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavGPSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP NAV GPS Pilot - ON'), category = _('CISP')},
	
	{down = device_commands.PilotNavVORILSToggle, up = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP VOR ILS Pilot - ILS else VOR'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, up = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP VOR ILS Pilot - VOR else ILS'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP VOR ILS Pilot - VOR'), category = _('CISP')},
	{down = device_commands.PilotNavVORILSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP VOR ILS Pilot - ILS'), category = _('CISP')},
	
	{down = device_commands.PilotNavBACKCRSToggle, up = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP BACK CRS Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, up = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP BACK CRS Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP BACK CRS Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavBACKCRSToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP BACK CRS Pilot - ON'), category = _('CISP')},
	
	{down = device_commands.PilotNavFMHOMEToggle, up = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP FM HOME Pilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, up = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP FM HOME Pilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP FM HOME Pilot - OFF'), category = _('CISP')},
	{down = device_commands.PilotNavFMHOMEToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP FM HOME Pilot - ON'), category = _('CISP')},
	
	{down = device_commands.PilotCRSHDGToggle, up = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP CRS HDG Pilot - CPLT else PLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, up = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP CRS HDG Pilot - PLT else CPLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP CRS HDG Pilot - PLT'), category = _('CISP')},
	{down = device_commands.PilotCRSHDGToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP CRS HDG Pilot - CPLT'), category = _('CISP')},
	
	{down = device_commands.PilotVERTGYROToggle, up = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP VERT GYRO Pilot - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, up = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP VERT GYRO Pilot - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP VERT GYRO Pilot - NORM'), category = _('CISP')},
	{down = device_commands.PilotVERTGYROToggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP VERT GYRO Pilot - ALTR'), category = _('CISP')},
	
	{down = device_commands.PilotBRG2Toggle, up = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, value_up = 0.0, name = _('CISP BRG2 Pilot - VOR else ADF'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, up = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, value_up = 1.0, name = _('CISP BRG2 Pilot - ADF else VOR'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 0.0, name = _('CISP BRG2 Pilot - ADF'), category = _('CISP')},
	{down = device_commands.PilotBRG2Toggle, cockpit_device_id = devices.PLTCISP, value_down = 1.0, name = _('CISP BRG2 Pilot - VOR'), category = _('CISP')},
	
	--Copilot CIS
	{down = device_commands.CopilotNavGPSToggle, up = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS NAV GPS Copilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, up = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS NAV GPS Copilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS NAV GPS Copilot - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavGPSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS NAV GPS Copilot - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotNavVORILSToggle, up = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS VOR ILS Copilot - ILS else VOR'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, up = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS VOR ILS Copilot - VOR else ILS'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS VOR ILS Copilot - VOR'), category = _('CISP')},
	{down = device_commands.CopilotNavVORILSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS VOR ILS Copilot - ILS'), category = _('CISP')},
	
	{down = device_commands.CopilotNavBACKCRSToggle, up = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS BACK CRS Copilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, up = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS BACK CRS Copilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS BACK CRS Copilot - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavBACKCRSToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS BACK CRS Copilot - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotNavFMHOMEToggle, up = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS FM HOME Copilot - ON else OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, up = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS FM HOME Copilot - OFF else ON'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS FM HOME Copilot - OFF'), category = _('CISP')},
	{down = device_commands.CopilotNavFMHOMEToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS FM HOME Copilot - ON'), category = _('CISP')},
	
	{down = device_commands.CopilotCRSHDGToggle, up = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS CRS HDG Copilot - CPLT else PLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, up = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS CRS HDG Copilot - PLT else CPLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS CRS HDG Copilot - PLT'), category = _('CISP')},
	{down = device_commands.CopilotCRSHDGToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS CRS HDG Copilot - CPLT'), category = _('CISP')},
	
	{down = device_commands.CopilotVERTGYROToggle, up = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS VERT GYRO Copilot - ALTR else NORM'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, up = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS VERT GYRO Copilot - NORM else ALTR'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS VERT GYRO Copilot - NORM'), category = _('CISP')},
	{down = device_commands.CopilotVERTGYROToggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS VERT GYRO Copilot - ALTR'), category = _('CISP')},
	
	{down = device_commands.CopilotBRG2Toggle, up = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, value_up = 0.0, name = _('CIS BRG2 Copilot - VOR else ADF'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, up = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, value_up = 1.0, name = _('CIS BRG2 Copilot - ADF else VOR'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 0.0, name = _('CIS BRG2 Copilot - ADF'), category = _('CISP')},
	{down = device_commands.CopilotBRG2Toggle, cockpit_device_id = devices.CPLTCISP, value_down = 1.0, name = _('CIS BRG2 Copilot - VOR'), category = _('CISP')},

	-- Electrical Systems
    {combos = {{key = 'B'}}, down = Keys.BattSwitch, name = _('Battery Switch'), category = _('Electrical Systems')},
	{combos = {{key = 'B', reformers = {'LCtrl'}}}, down = Keys.ExtPwrSwitch, name = _('External Power Switch'), category = _('Electrical Systems')},
	
	-- Cyclic
	{combos = {{key = ';', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimUp, name = _('Cyclic Trim Nose Up'), category = _('Cyclic')},
	{combos = {{key = '.', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimDown, name = _('Cyclic Trim Nose Down'), category = _('Cyclic')},
	{combos = {{key = ',', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimLeft, name = _('Cyclic Trim Roll Left'), category = _('Cyclic')},
	{combos = {{key = '/', reformers = {'RCtrl'}}}, pressed = EFM_commands.trimRight, name = _('Cyclic Trim Roll Right'), category = _('Cyclic')},
	{pressed = EFM_commands.trimRelease, up = EFM_commands.trimSet, name = _('Cyclic Trim Release'), category = _('Cyclic')},
    {up = EFM_commands.trimReset, name = _('Cyclic Trim Reset'), category = _('Cyclic')},

    -- AFCS These are default, but it seems that they are not "spring loaded" to center
    --{down = Keys.slewStabUp, up = Keys.slewStabUp, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Up'), category = _('AFCS')},
    --{down = Keys.slewStabDown, up = Keys.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Down'), category = _('AFCS')},

	-- Radios
	{down = Keys.ptt, up = Keys.ptt, cockpit_device_id = devices.PLT_ICP, value_down = 1.0, value_up = 0.0, name = _('PTT - Push To Talk (SRS)'), category = _('Radios')},
	{down = Keys.radioPTT, cockpit_device_id = devices.BASE_RADIO, name = _('PTT - Push To Talk (Game Comms)'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorInc, cockpit_device_id = devices.PLT_ICP, name = _('ICS XMIT Select Next Radio'), category = _('Radios')},
	{down = Keys.pilotICPXmitSelectorDec, cockpit_device_id = devices.PLT_ICP, name = _('ICS XMIT Select Previous Radio'), category = _('Radios')},

    -- Countermeasures
	{down = Keys.dispenseChaffDown, up = Keys.dispenseChaffUp, name = _('Chaff Dispense'), category = _('Countermeasures')},

	-- AN/AVS-7
	{down = Keys.avs7Toggle, name = _('AN/AVS-7 ON/OFF'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.decAVS7Brightness, up = device_commands.decAVS7Brightness, cockpit_device_id = devices.AVS7, value_down = 1.0, value_up = 0.0, name = _('AN/AVS-7 Brighten'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.incAVS7Brightness, up = device_commands.incAVS7Brightness, cockpit_device_id = devices.AVS7, value_down = -1.0, value_up = 0.0, name = _('AN/AVS-7 Dim'), category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 1.0, name = _('AN/AVS-7 ADJ'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 0.0, name = _('AN/AVS-7 ON'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = -1.0, name = _('AN/AVS-7 OFF'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, up = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = 0.0, value_up = -1.0, name = _('AN/AVS-7 ON else OFF'),	category = _('AN/AVS-7 HUD')},
	{down = device_commands.setAVS7Power, up = device_commands.setAVS7Power, cockpit_device_id = devices.AVS7, value_down = -1.0, value_up = 0.0, name = _('AN/AVS-7 OFF else ON'),	category = _('AN/AVS-7 HUD')},


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
	
    {combos = {{key = 'Enter', reformers = {'RShift'}}},			 down = Keys.showControlInd,				name = _('Show controls indicator - UH-60L') ,			 category = _('General')},
	
	{up = EFM_commands.wheelbrakeToggle,      name = _('Wheel Brakes Toggle On/Off Keyboard')},

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