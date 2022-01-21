local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

local kneeboard_id = 100
if devices and devices.KNEEBOARD then
   kneeboard_id = devices.KNEEBOARD
end

return
{
    forceFeedback =
    {
        trimmer = 1.0,
        shake = 0.5,
        swapAxes = false,
        invertX = false,
        invertY = false,
    },

    keyCommands =
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
		{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 1 Control Lever - Fly'), category = _('ECQ')},
		{down = device_commands.setEng1Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 1 Control Lever - Idle'), category = _('ECQ')},
		{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 1.0, name = _('Engine No. 2 Control Lever - Fly'), category = _('ECQ')},
		{down = device_commands.setEng2Control, cockpit_device_id = devices.ECQ, value_down = 0.0, name = _('Engine No. 2 Control Lever - Idle'), category = _('ECQ')},
		
		
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
		{down = device_commands.SelectBtn1, up = device_commands.SelectBtn1, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 1'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn2, up = device_commands.SelectBtn2, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 2'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn3, up = device_commands.SelectBtn3, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 3'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn4, up = device_commands.SelectBtn4, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 4'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn5, up = device_commands.SelectBtn5, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 5'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn6, up = device_commands.SelectBtn6, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 6'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn7, up = device_commands.SelectBtn7, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 7'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn8, up = device_commands.SelectBtn8, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 8'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn9, up = device_commands.SelectBtn9, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 9'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtn0, up = device_commands.SelectBtn0, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button 0'), category = _('ASN128B GPS DPLR')},
		
		{down = device_commands.SelectBtnTgtStr, up = device_commands.SelectBtnTgtStr, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button TGT STR'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnEnt, up = device_commands.SelectBtnEnt, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button ENT'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnClr, up = device_commands.SelectBtnClr, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button CLR'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnDec, up = device_commands.SelectBtnDec, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button DEC'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnInc, up = device_commands.SelectBtnInc, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button INC'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnLtrRight, up = device_commands.SelectBtnLtrRight, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button LTR Right'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnLtrMid, up = device_commands.SelectBtnLtrMid, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button LTR MID'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnLtrLeft, up = device_commands.SelectBtnLtrLeft, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button LTR Left'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnKybd, up = device_commands.SelectBtnKybd, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button KYBD'), category = _('ASN128B GPS DPLR')},
		{down = device_commands.SelectBtnF1, up = device_commands.SelectBtnF1, cockpit_device_id = devices.ASN128B, value_down = 1.0, value_up = 0.0, name = _('ASN 128 - Button F1'), category = _('ASN128B GPS DPLR')},
		
		
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
			
		-- Input
		{pressed 	= EFM_commands.collectiveIncrease, 	name = _('Collective Increase'), category = _('Collective')},
		{pressed 	= EFM_commands.collectiveDecrease, 	name = _('Collective Decrease'), category = _('Collective')},
		
        -- Electrical Systems
        {down = Keys.BattSwitch, name = _('Battery Switch'), category = _('Electrical Systems')},
        {down = Keys.ExtPwrSwitch, name = _('External Power Switch'), category = _('Electrical Systems')},

        -- Cyclic
        {pressed = EFM_commands.trimUp, name = _('Cyclic Trim Nose Up'), category = _('Cyclic')},
        {pressed = EFM_commands.trimDown, name = _('Cyclic Trim Nose Down'), category = _('Cyclic')},
        {pressed = EFM_commands.trimLeft, name = _('Cyclic Trim Roll Left'), category = _('Cyclic')},
        {pressed = EFM_commands.trimRight, name = _('Cyclic Trim Roll Right'), category = _('Cyclic')},
        {pressed = EFM_commands.trimRelease, up = EFM_commands.trimSet, name = _('Trim Release'), category = _('Cyclic')},
        {up = EFM_commands.trimReset, name = _('Trim Reset'), category = _('Cyclic')},

        -- AFCS
        --{down = Keys.slewStabUp, up = Keys.slewStabUp, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Up'), category = _('AFCS')},
        --{down = Keys.slewStabDown, up = Keys.slewStabDown, cockpit_device_id = devices.AFCS, value_down = 1.0, value_up = 0.0, name = _('Manual Stabilator Slew Down'), category = _('AFCS')},

        -- Radio
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

        {down = 3256, cockpit_device_id  = 0,	value_down = 1.0,	name = _('Flashlight'),	category = _('Lighting')},

    -- Others
        {down = iCommandPlaneEject, 	name = _('Eject (3 times)'), category = _('General')},
        {down = Keys.toggleDoors,     name = _('Canopy Open/Close'), category = _('General')},
        {down = Keys.toggleCopilotDoor,		name = _('Copilot Door Open/Close'), category = _('General')},
        {down = Keys.toggleLeftCargoDoor,	name = _('Left Cargo Door Open/Close'), category = _('General')},
        {down = Keys.toggleRightCargoDoor,	 name = _('Right Cargo Door Open/Close'), category = _('General')},
        {down = Keys.toggleLeftGunnerDoor,	 name = _('Left Gunner Hatch Open/Close'), category = _('General')},
        {down = Keys.toggleRightGunnerDoor,	 name = _('Right Gunner Hatch Open/Close'), category = _('General')},

        {down = Keys.toggleProbe,	 name = _('AAR Probe Extend/Retract'), category = _('General')},
       
        -- Night Vision Goggles
        {down = iCommandViewNightVisionGogglesOn,	 name = _('Toggle Night Vision Goggles'), 	category = _('NVG')},
        {pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Gain NVG up')  , category = _('NVG')},
        {pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Gain NVG down'), category = _('NVG')},
        
        -- Multicrew
        {down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Pilot Seat'),	category = _('Crew Control')},
        {down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Copilot Seat'),	category = _('Crew Control')},
        {down = iCommandNetCrewRequestControl,				name = _('Request Aircraft Control'),category = _('Crew Control')},
        
        --{combos = {{key = 'P', reformers = {'RShift'}}}, down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
        
        {down = Keys.showControlInd,				name = _('Show controls indicator') ,			 category = _('General')},
               
        {down = EFM_commands.wheelbrakeToggle,      name = _('Wheel Brakes Toggle On/Off Device')},
        
        {down = iCommandExtCargoHook, name = _('External Cargo Hook'), 	category = _("External Cargo")},
        {down = iCommandExternalCargoAutounhook, name = _('External Cargo Autounhook'),	category = _("External Cargo")},
        {down = iCommandExternalCargoIndicator, name = _("External Cargo Indicator"),  category = _("External Cargo"), },
        {down = iCommandEmergencyCargoUnhook, name = _('External Cargo Emergency Unhook'), 	category = _("External Cargo")},
        
        ------------------------------- from common_keyboard_binding.lua   ---------------------------------

        -- Debug
        {down = ICommandToggleConsole,	name = _('Toggle Console'),	 category = _('Debug')},
        {down = iCommandMissionRestart,	name = _('Restart Mission'), category = _('Debug')},

        -- General (Gameplay)
        {down = iCommandQuit,				name = _('End mission'),	 category = _('General')},
        {down = iCommandBrakeGo,			name = _('Pause'),			 category = _('General')},
        {down = iCommandAccelerate,			name = _('Time accelerate'), category = _('General')},
        {down = iCommandDecelerate,			name = _('Time decelerate'), category = _('General')},
        {down = iCommandNoAcceleration,		name = _('Time normal'),	 category = _('General')},
        {down = iCommandScoresWindowToggle,	name = _('Score window'),	 category = _('General')},

        {down = iCommandInfoOnOff,						name = _('Info bar view toggle'),				 category = _('General')},
        {down = iCommandRecoverHuman,					name = _('Get new plane - respawn'),			 category = _('General')},
        {down = iCommandPlaneJump,						name = _('Jump into selected aircraft'),		 category = _('General')},
        {down = iCommandScreenShot,						name = _('Screenshot'),							 category = _('General')},
        {down = iCommandGraphicsFrameRate,				name = _('Frame rate counter - Service info'),	 category = _('General')},
        {down = iCommandViewCoordinatesInLinearUnits,	name = _('Info bar coordinate units toggle'),	 category = _('General')},
        {down = iCommandCockpitClickModeOnOff,			name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},
        {down = iCommandSoundOnOff,						name = _('Sound On/Off'),						 category = _('General')},
        {down = iCommandMissionResourcesManagement,		name = _('Rearming and Refueling Window'),		 category = _('General')},
        {down = iCommandViewBriefing,					name = _('View briefing on/off'),				 category = _('General')},
        {down = iCommandActivePauseOnOff,				name = _('Active Pause'),						 category = _('Cheat')},

        -- Communications
        {down = iCommandToggleCommandMenu,			name = _('Communication menu'),					  category = _('Communications')},
        {down = ICommandSwitchDialog,				name = _('Switch dialog'),						  category = _('Communications')},
        {down = ICommandSwitchToCommonDialog,		name = _('Switch to main menu'),				  category = _('Communications')},

        --{down = iCommandToggleReceiveMode, name = _('Receive Mode'), category = _('Communications')},

        -- View
        {pressed = iCommandViewLeftSlow,		 up = iCommandViewStopSlow, name = _('View Left slow'),		  category = _('View')},
        {pressed = iCommandViewRightSlow,	 up = iCommandViewStopSlow, name = _('View Right slow'),	  category = _('View')},
        {pressed = iCommandViewUpSlow,		 up = iCommandViewStopSlow, name = _('View Up slow'),		  category = _('View')},
        {pressed = iCommandViewDownSlow,		 up = iCommandViewStopSlow, name = _('View Down slow'),		  category = _('View')},
        {pressed = iCommandViewUpRightSlow,	 up = iCommandViewStopSlow, name = _('View Up Right slow'),	  category = _('View')},
        {pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
        {pressed = iCommandViewDownLeftSlow,	 up = iCommandViewStopSlow, name = _('View Down Left slow'),  category = _('View')},
        {pressed = iCommandViewUpLeftSlow,	 up = iCommandViewStopSlow, name = _('View Up Left slow'),	  category = _('View')},
        {pressed = iCommandViewCenter,		 							name = _('View Center'),		  category = _('View')},

        {pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},
        {pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
        {down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
        {pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
        {pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
        {down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
        {down = iCommandViewSpeedUp, name = _('F11 Camera moving forward'), category = _('View')},
        {down = iCommandViewSlowDown, name = _('F11 Camera moving backward'), category = _('View')},

        {down = iCommandViewCockpit, name = _('F1 Cockpit view'), category = _('View')},
        {down = iCommandNaturalViewCockpitIn, name = _('F1 Natural head movement view'), category = _('View')},
        {down = iCommandViewHUDOnlyOnOff, name = _('F1 HUD only view switch'), category = _('View')},
        {down = iCommandViewAir, name = _('F2 Aircraft view'), category = _('View')},
        {down = iCommandViewMe, name = _('F2 View own aircraft'), category = _('View')},
        {down = iCommandViewFromTo, name = _('F2 Toggle camera position'), category = _('View')},
        {down = iCommandViewLocal, name = _('F2 Toggle local camera control'), category = _('View')},
        {down = iCommandViewTower, name = _('F3 Fly-By view'), category = _('View')},
        {down = iCommandViewTowerJump, name = _('F3 Fly-By jump view'), category = _('View')},
        {down = iCommandViewRear, name = _('F4 Look back view'), category = _('View')},
        {down = iCommandViewChase, name = _('F4 Chase view'), category = _('View')},
        {down = iCommandViewChaseArcade, name = _('F4 Arcade Chase view'), category = _('View')},
        {down = iCommandViewFight, name = _('F5 nearest AC view'), category = _('View')},
        {down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
        {down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
        {down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
        {down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
        {down = iCommandViewTargets, name = _('F8 Target view'), category = _('View')},
        {down = iCommandViewTargetType, name = _('F8 Player targets/All targets filter'), category = _('View')},
        {down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
        {down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
        {down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
        {down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
        {down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
        {down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
        {down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
        {down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
        {down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},
        {down = iCommandViewPitHeadOnOff, name = _('F1 Head shift movement on / off'), category = _('View')},

        {down = iCommandViewFastKeyboard, name = _('Keyboard Rate Fast'), category = _('View')},
        {down = iCommandViewSlowKeyboard, name = _('Keyboard Rate Slow'), category = _('View')},
        {down = iCommandViewNormalKeyboard, name = _('Keyboard Rate Normal'), category = _('View')},
        {down =  iCommandViewFastMouse, name = _('Mouse Rate Fast'), category = _('View')},
        {down = iCommandViewSlowMouse, name = _('Mouse Rate Slow'), category = _('View')},
        {down = iCommandViewNormalMouse, name = _('Mouse Rate Normal'), category = _('View')},

        -- Cockpit view
        {down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = _('Cockpit panel view in'), category = _('View Cockpit')},
        {down = iCommandViewTempCockpitToggle, name = _('Cockpit panel view toggle'), category = _('View Cockpit')},
        --// Save current cockpit camera angles for fast numpad jumps
        {down = iCommandViewSaveAngles, name = _('Save Cockpit Angles'), category = _('View Cockpit')},
        {pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View Cockpit')},
        {pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View Cockpit')},
        {pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View Cockpit')},
        {pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View Cockpit')},
        {pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View Cockpit')},
        {pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View Cockpit')},
        {pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View Cockpit')},
        {pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View Cockpit')},

        -- Cockpit Camera Motion
        {pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Up'), category = _('View Cockpit')},
        {pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Down'), category = _('View Cockpit')},
        {pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Left'), category = _('View Cockpit')},
        {pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Right'), category = _('View Cockpit')},
        {pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Forward'), category = _('View Cockpit')},
        {pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Back'), category = _('View Cockpit')},
        {down = iCommandViewPitCameraMoveCenter, name = _('Cockpit Camera Move Center'), category = _('View Cockpit')},

        {down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Glance up'), category = _('View Cockpit')},
        {down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = _('Glance down'), category = _('View Cockpit')},
        {down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = _('Glance left'), category = _('View Cockpit')},
        {down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = _('Glance right'), category = _('View Cockpit')},
        {down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = _('Glance up-left'), category = _('View Cockpit')},
        {down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = _('Glance down-left'), category = _('View Cockpit')},
        {down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = _('Glance up-right'), category = _('View Cockpit')},
        {down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = _('Glance down-right'), category = _('View Cockpit')},
        {down = iCommandViewPanToggle, name = _('Camera pan mode toggle'), category = _('View Cockpit')},

        {down = iCommandViewCameraUpSlow, name = _('Camera snap view up'), category = _('View Cockpit')},
        {down = iCommandViewCameraDownSlow, name = _('Camera snap view down'), category = _('View Cockpit')},
        {down = iCommandViewCameraLeftSlow, name = _('Camera snap view left'), category = _('View Cockpit')},
        {down = iCommandViewCameraRightSlow, name = _('Camera snap view right'), category = _('View Cockpit')},
        {down = iCommandViewCameraUpLeftSlow, name = _('Camera snap view up-left'), category = _('View Cockpit')},
        {down = iCommandViewCameraDownLeftSlow, name = _('Camera snap view down-left'), category = _('View Cockpit')},
        {down = iCommandViewCameraUpRightSlow, name = _('Camera snap view up-right'), category = _('View Cockpit')},
        {down = iCommandViewCameraDownRightSlow, name = _('Camera snap view down-right'), category = _('View Cockpit')},
        {down = iCommandViewCameraCenter, name = _('Center Camera View'), category = _('View Cockpit')},
        {down = iCommandViewCameraReturn, name = _('Return Camera'), category = _('View Cockpit')},
        {down = iCommandViewCameraBaseReturn, name = _('Return Camera Base'), category = _('View Cockpit')},

        {down = iCommandViewSnapView0,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  0'), category = _('View Cockpit')},
        {down = iCommandViewSnapView1,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  1'), category = _('View Cockpit')},
        {down = iCommandViewSnapView2,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  2'), category = _('View Cockpit')},
        {down = iCommandViewSnapView3,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  3'), category = _('View Cockpit')},
        {down = iCommandViewSnapView4,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  4'), category = _('View Cockpit')},
        {down = iCommandViewSnapView5,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  5'), category = _('View Cockpit')},
        {down = iCommandViewSnapView6,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  6'), category = _('View Cockpit')},
        {down = iCommandViewSnapView7,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  7'), category = _('View Cockpit')},
        {down = iCommandViewSnapView8,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  8'), category = _('View Cockpit')},
        {down = iCommandViewSnapView9,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  9'), category = _('View Cockpit')},

        {pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},
        {pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},

        -- Extended view
        {down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
        {down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
        {down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
        {down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
        {down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},
        {down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
        {down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View Extended')},
        {down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View Extended')},
        {down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View Extended')},
        {down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View Extended')},

        -- Padlock
        --{down = iCommandViewLock, name = _('Lock View (cycle padlock)'), category = _('View Padlock')},
        --{down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
        --{down = iCommandAllMissilePadlock, name = _('All missiles padlock'), category = _('View Padlock')},
        --{down = iCommandThreatMissilePadlock, name = _('Threat missile padlock'), category = _('View Padlock')},
        --{down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},

        -- Labels
        {down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
        {down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
        {down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
        {down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},

        --Kneeboard
        {down = iCommandPlaneShowKneeboard	, name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
        {down = iCommandPlaneShowKneeboard	, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
        {down = 3001		, cockpit_device_id  = kneeboard_id, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
        {down = 3002		, cockpit_device_id  = kneeboard_id, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
        {down = 3003		, cockpit_device_id  = kneeboard_id,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},
        --shortcuts navigation
        {down = 3004		, cockpit_device_id  = kneeboard_id,value_down =  1.0, name = _('Kneeboard Make Shortcut'), category = _('Kneeboard')},
        {down = 3005		, cockpit_device_id  = kneeboard_id,value_down =  1.0, name = _('Kneeboard Next Shortcut'), category = _('Kneeboard')},
        {down = 3005		, cockpit_device_id  = kneeboard_id,value_down = -1.0, name = _('Kneeboard Previous Shortcut')  , category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 0   , name = _('Kneeboard Jump To Shortcut  1'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 1   , name = _('Kneeboard Jump To Shortcut  2'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 2   , name = _('Kneeboard Jump To Shortcut  3'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 3   , name = _('Kneeboard Jump To Shortcut  4'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 4   , name = _('Kneeboard Jump To Shortcut  5'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 5   , name = _('Kneeboard Jump To Shortcut  6'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 6   , name = _('Kneeboard Jump To Shortcut  7'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 7   , name = _('Kneeboard Jump To Shortcut  8'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 8   , name = _('Kneeboard Jump To Shortcut  9'), category = _('Kneeboard')},
        {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 9   , name = _('Kneeboard Jump To Shortcut 10'), category = _('Kneeboard')},
    },

    -- joystick axis
    axisCommands =
    {
        {action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
        {action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
        {action = iCommandViewZoomAbs				, name = _('Zoom View')},
        {action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
        {action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
        {action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
        {action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

        {combos = defaultDeviceAssignmentFor("roll")	, action = iCommandPlaneRoll,			name = _('Roll Cyclic')},
        {combos = defaultDeviceAssignmentFor("pitch")	, action = iCommandPlanePitch,			name = _('Pitch Cyclic')},
        {combos = defaultDeviceAssignmentFor("rudder")	, action = iCommandPlaneRudder, 		name = _('Pedals')},
        {combos = defaultDeviceAssignmentFor("thrust")	, action = iCommandPlaneThrustCommon,	name = _('Collective')},
        {action = EFM_commands.wheelbrake,  name = _('Wheel Brakes')},


        {action = Keys.e1PCL,  name = _('Engine 1 Power Control Lever'), category = _('Engine Control Quadrant')},
        {action = Keys.e2PCL,  name = _('Engine 2 Power Control Lever'), category = _('Engine Control Quadrant')},
        {action = Keys.bothPCLs,  name = _('Engine 1 + 2 Power Control Levers'), category = _('Engine Control Quadrant')},
		
		--
		{action = Keys.e1PCL,  name = _('Engine 1 Power Control Lever'), category = _('Engine Control Quadrant')},
    },
}
