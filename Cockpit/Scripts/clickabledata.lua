dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

elements = {}
-- Electric system
elements["PNT-017"]	= default_2_position_tumb(_("Battery Switch, ON/OFF"),	devices.EFM_HELPER, EFM_commands.batterySwitch, 17)
elements["PNT-018"]	= default_button_tumb_v2_inverted(_("External Power Switch, ON/OFF/RESET"),	devices.EFM_HELPER, EFM_commands.extPwrSwitch, EFM_commands.extPwrSwitch2, 18)
elements["PNT-019"]	= default_button_tumb_v2_inverted(_("APU GEN Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.apuGenSwitch, EFM_commands.apuGenSwitch2, 19)
elements["PNT-020"]	= default_button_tumb_v2_inverted(_("GEN 1 Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.gen1Switch, EFM_commands.gen1Switch2, 20)
elements["PNT-021"]	= default_button_tumb_v2_inverted(_("GEN 2 Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.gen2Switch, EFM_commands.gen2Switch2, 21)

-- Fuel and Engines
elements["PNT-022"]	= default_3_position_tumb(_("Fuel Pump Switch, FUEL PRIME/OFF/APU BOOST"),	devices.EFM_HELPER, EFM_commands.switchFuelPump, 22)
elements["PNT-023"]	= default_3_position_tumb(_("Air Source Switch, APU/OFF/ENG"),	devices.EFM_HELPER, EFM_commands.switchAirSource, 23)
elements["PNT-024"]	= default_2_position_tumb(_("APU CONTROL, ON/OFF"),	devices.EFM_HELPER, EFM_commands.switchAPU, 24)
-- PNT-025 APU EXTINGUISH
--function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_)
elements["PNT-026"]	= default_axis_limited(_("Engine 1 Control"),	devices.ECQ, device_commands.setEng1Control, 26, 0, 0.1, true, false, {0,1})
elements["PNT-027"]	= default_axis_limited(_("Engine 2 Control"),	devices.ECQ, device_commands.setEng2Control, 27, 0, 0.1, true, false, {0,1})
--multiposition_switch_relative(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
elements["PNT-028"]	= multiposition_switch(_("Engine 1 FSS, OFF/DIR/XFD"),	devices.ECQ, device_commands.eng1FSS, 28, 3, 1/2, false, 0, 1, false)
elements["PNT-028"].sound = {{ESS_FWD, ESS_BACK}}
elements["PNT-029"]	= multiposition_switch(_("Engine 2 FSS, OFF/DIR/XFD"),	devices.ECQ, device_commands.eng2FSS, 29, 3, 1/2, false, 0, 1, false)
elements["PNT-029"].sound = {{ESS_FWD, ESS_BACK}}
elements["PNT-030"]	= default_trimmer_button(_("Engine 1 Starter"),	devices.ECQ, device_commands.eng1Starter, 30)
elements["PNT-031"]	= default_trimmer_button(_("Engine 2 Starter"),	devices.ECQ, device_commands.eng2Starter, 31)

-- STAB PANEL
--springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
elements["PNT-032"]	= springloaded_3_pos_tumb(_("Stabilator Manual Slew UP/DOWN"),	devices.AFCS, device_commands.slewStabUp, device_commands.slewStabDown, 32)
elements["PNT-033"]	= push_button_tumb(_("Stabilator Auto ON/OFF"),	devices.AFCS, device_commands.afcsStabAuto, 33, 8)
elements["PNT-033"].sound = {{AFC_BUTTON_1}}
elements["PNT-034"]	= push_button_tumb(_("SAS 1 ON/OFF"),	devices.AFCS, device_commands.afcsSAS1, 34, 8)
elements["PNT-034"].sound = {{AFC_BUTTON_2}}
elements["PNT-035"]	= push_button_tumb(_("SAS 2 ON/OFF"),	devices.AFCS, device_commands.afcsSAS2, 35, 8)
elements["PNT-035"].sound = {{AFC_BUTTON_3}}
elements["PNT-036"]	= push_button_tumb(_("Trim ON/OFF"),	devices.AFCS, device_commands.afcsTrim, 36, 8)
elements["PNT-036"].sound = {{AFC_BUTTON_4}}
elements["PNT-037"]	= push_button_tumb(_("FPS ON/OFF"),	devices.AFCS, device_commands.afcsFPS, 37, 8)
elements["PNT-037"].sound = {{AFC_BUTTON_1}}
elements["PNT-038"]	= push_button_tumb(_("SAS Boost ON/OFF"),	devices.AFCS, device_commands.afcsBoost, 38, 8)
elements["PNT-038"].sound = {{AFC_BUTTON_2}}
--elements["PNT-039"]	= push_button_tumb(_("SAS Power On Reset (inop)"),	devices.EFM_HELPER, EFM_commands.stabPwrReset, 39, 8)

--FUEL PUMPS
elements["PNT-040"]	= default_2_position_tumb(_("No. 1 Fuel Boost Pump ON/OFF"),	devices.EFM_HELPER, EFM_commands.fuelPumpL, 40, 8)
elements["PNT-041"]	= default_2_position_tumb(_("No. 2 Fuel Boost Pump ON/OFF"),	devices.EXTLIGHTS, device_commands.fuelProbe, 41, 8)

-- Engine Control Locks
--default_animated_lever(hint_,device_,command_,arg_,animation_speed_,arg_lim_)
elements["PNT-042"]	= default_animated_lever(_("Engine 1 Control Level OFF/IDLE"),	devices.ECQ, device_commands.eng1ControlDetent, 42, 2, {-1, 0})
elements["PNT-042"].sound = {{ECL_TO_IDLE, ECL_TO_OFF}}
elements["PNT-042"].updatable = false
elements["PNT-043"]	= default_animated_lever(_("Engine 2 Control Level OFF/IDLE"),	devices.ECQ, device_commands.eng2ControlDetent, 43, 2, {-1, 0})
elements["PNT-043"].sound = {{ECL_TO_IDLE, ECL_TO_OFF}}
elements["PNT-043"].updatable = false

-- PILOT BARO ALTIMETER
elements["PNT-063"]	= default_axis(_("Barometric Scale Set"),    devices.PLTAAU32A, device_commands.pilotBarometricScaleSet, 63, 0, 0.1, false, true)

-- COPILOT BARO ALTIMETER
elements["PNT-073"]	= default_axis(_("Barometric Scale Set"),  devices.CPLTAAU32A, device_commands.copilotBarometricScaleSet, 73, 0, 0.1, false, true)

-- PARKING BRAKE
elements["PNT-080"]	= springloaded_2_pos_tumb(_("Parking Brake ON/OFF"),    devices.EFM_HELPER, device_commands.parkingBrake, 80)
elements["PNT-080"].sound = {{PARKING_BRAKE_UP,PARKING_BRAKE_DOWN},{SOUND_SW12_ON,SOUND_SW12_OFF}}

-- AHRU
elements["PNT-090"]	= push_button_tumb(_("AHRU Mode Selector (Inop.)"),                 devices.AHRU, device_commands.ahruMode, 90)
elements["PNT-091"]	= push_button_tumb(_("AHRU Function Selector (Inop.)"),             devices.AHRU, device_commands.ahruFunc, 91)
elements["PNT-092"]	= push_button_tumb(_("AHRU Display Cursor Movement UP (Inop.)"),    devices.AHRU, device_commands.ahruUp, 92)
elements["PNT-093"]	= push_button_tumb(_("AHRU Display Cursor Movement RIGHT (Inop.)"), devices.AHRU, device_commands.ahruRight, 93)
elements["PNT-094"]	= push_button_tumb(_("AHRU Enter Selection (Inop.)"),               devices.AHRU, device_commands.ahruEnter, 94)

-- PILOT HSI
--default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
elements["PNT-130"]	= default_axis(_("Heading Set"),	devices.PLTCISP, device_commands.pilotHSIHdgSet, 130, 0, 0.1, false, true)
elements["PNT-131"]	= default_axis(_("Course Set"),	devices.PLTCISP, device_commands.pilotHSICrsSet, 131, 0, 0.1, false, true)

-- COPILOT HSI
--default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
elements["PNT-150"]	= default_axis(_("Heading Set"),	devices.CPLTCISP, device_commands.copilotHSIHdgSet, 150, 0, 0.1, false, true)
elements["PNT-151"]	= default_axis(_("Course Set"),	    devices.CPLTCISP, device_commands.copilotHSICrsSet, 151, 0, 0.1, false, true)

-- MISC
elements["PNT-290"]	= push_button_tumb(_("Fuel Indicator Test (Inop.)"),    devices.MISC, device_commands.miscFuelIndTest, 290)
elements["PNT-291"]	= push_button_tumb(_("Tail Wheel Lock"),                devices.MISC, device_commands.miscTailWheelLock, 291)
elements["PNT-292"]	= push_button_tumb(_("Gyro Select (Inop.)"),            devices.MISC, device_commands.miscGyroEffect, 292)
elements["PNT-296"]	= default_2_position_tumb(_("Tail Servo Select NORMAL/BACKUP (Inop.)"), devices.MISC, device_commands.miscTailServo, 296)

-- CAUTION/DISPLAY PANELS
elements["PNT-301"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.cduLampTest, 301, 8)
elements["PNT-302"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.pilotPDUTest, 302, 8)
elements["PNT-303"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.copilotPDUTest, 303, 8)

elements["PNT-304"]	= default_button_tumb_v2_inverted(_("CAP Lamp Test"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPLampTest, device_commands.CAPLampBrightness, 304, 8)
elements["PNT-305"]	= default_button(_("Master Caution Reset"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPMasterCautionReset, 305, 8)
elements["PNT-306"]	= default_button(_("Master Caution Reset"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPMasterCautionReset, 306, 8)

--multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
elements["PNT-500"]	= multiposition_switch(_("AN/ASN-128B Display Selector"),	devices.ASN128B, device_commands.SelectDisplay, 500, 7, 0.01, false, 0, 16, false)
elements["PNT-501"]	= multiposition_switch(_("AN/ASN-128B Mode Selector"),	devices.ASN128B, device_commands.SelectMode,        501, 6, 0.01, false, 0, 16, false)
elements["PNT-502"]	= short_way_button(_("AN/ASN-128B Btn KYBD"),	        devices.ASN128B, device_commands.SelectBtnKybd,     502)
elements["PNT-503"]	= short_way_button(_("AN/ASN-128B Btn LTR LEFT"),	    devices.ASN128B, device_commands.SelectBtnLtrLeft,  503)
elements["PNT-504"]	= short_way_button(_("AN/ASN-128B Btn LTR MID"),	    devices.ASN128B, device_commands.SelectBtnLtrMid,   504)
elements["PNT-505"]	= short_way_button(_("AN/ASN-128B Btn LTR RIGHT"),	    devices.ASN128B, device_commands.SelectBtnLtrRight, 505)
elements["PNT-506"]	= short_way_button(_("AN/ASN-128B Btn F1"),	            devices.ASN128B, device_commands.SelectBtnF1,       506)
elements["PNT-507"]	= short_way_button(_("AN/ASN-128B Btn 1"),	            devices.ASN128B, device_commands.SelectBtn1,        507)
elements["PNT-508"]	= short_way_button(_("AN/ASN-128B Btn 2"),	            devices.ASN128B, device_commands.SelectBtn2,        508)
elements["PNT-509"]	= short_way_button(_("AN/ASN-128B Btn 3"),	            devices.ASN128B, device_commands.SelectBtn3,        509)
elements["PNT-510"]	= short_way_button(_("AN/ASN-128B Btn TGT STR"),	    devices.ASN128B, device_commands.SelectBtnTgtStr,   510)
elements["PNT-511"]	= short_way_button(_("AN/ASN-128B Btn 4"),	            devices.ASN128B, device_commands.SelectBtn4,        511)
elements["PNT-512"]	= short_way_button(_("AN/ASN-128B Btn 5"),	            devices.ASN128B, device_commands.SelectBtn5,        512)
elements["PNT-513"]	= short_way_button(_("AN/ASN-128B Btn 6"),	            devices.ASN128B, device_commands.SelectBtn6,        513)
elements["PNT-514"]	= short_way_button(_("AN/ASN-128B Btn INC"),	        devices.ASN128B, device_commands.SelectBtnInc,      514)
elements["PNT-515"]	= short_way_button(_("AN/ASN-128B Btn 7"),	            devices.ASN128B, device_commands.SelectBtn7,        515)
elements["PNT-516"]	= short_way_button(_("AN/ASN-128B Btn 8"),	            devices.ASN128B, device_commands.SelectBtn8,        516)
elements["PNT-517"]	= short_way_button(_("AN/ASN-128B Btn 9"),	            devices.ASN128B, device_commands.SelectBtn9,        517)
elements["PNT-518"]	= short_way_button(_("AN/ASN-128B Btn DEC"),	        devices.ASN128B, device_commands.SelectBtnDec,      518)
elements["PNT-519"]	= short_way_button(_("AN/ASN-128B Btn CLR"),	        devices.ASN128B, device_commands.SelectBtnClr,      519)
elements["PNT-520"]	= short_way_button(_("AN/ASN-128B Btn 0"),	            devices.ASN128B, device_commands.SelectBtn0,        520)
elements["PNT-521"]	= short_way_button(_("AN/ASN-128B Btn ENT"),	        devices.ASN128B, device_commands.SelectBtnEnt,      521)

-- CIS/MODE SEL
elements["PNT-930"]	= push_button_tumb(_("CIS Heading Mode ON/OFF"),	    devices.CISP, device_commands.PilotCISHdgToggle, 930, 8)
elements["PNT-930"].sound = {{AFC_BUTTON_3}}
elements["PNT-931"]	= push_button_tumb(_("CIS Nav Mode ON/OFF"),	        devices.CISP, device_commands.PilotCISNavToggle, 931, 8)
elements["PNT-931"].sound = {{AFC_BUTTON_1}}
elements["PNT-932"]	= push_button_tumb(_("CIS Altitude Hold Mode ON/OFF"),	devices.CISP, device_commands.PilotCISAltToggle, 932, 8)
elements["PNT-932"].sound = {{AFC_BUTTON_2}}

elements["PNT-933"]	= push_button_tumb(_("NAV Mode: Doppler/GPS ON/OFF"),	    devices.PLTCISP, device_commands.PilotNavGPSToggle, 933, 8)
elements["PNT-933"].sound = {{AFC_BUTTON_4}}
elements["PNT-934"]	= push_button_tumb(_("NAV Mode: VOR/ILS ON/OFF"),	        devices.PLTCISP, device_commands.PilotNavVORILSToggle, 934, 8)
elements["PNT-934"].sound = {{AFC_BUTTON_2}}
elements["PNT-935"]	= push_button_tumb(_("NAV Mode: Back Course ON/OFF"),	    devices.PLTCISP, device_commands.PilotNavBACKCRSToggle, 935, 8)
elements["PNT-935"].sound = {{AFC_BUTTON_1}}
elements["PNT-936"]	= push_button_tumb(_("NAV Mode: FM Homing ON/OFF"),	        devices.PLTCISP, device_commands.PilotNavFMHOMEToggle, 936, 8)
elements["PNT-936"].sound = {{AFC_BUTTON_4}}
elements["PNT-937"]	= push_button_tumb(_("Turn Rate Selector NORM/ALTR"),       devices.PLTCISP, device_commands.PilotTURNRATEToggle, 937, 8)
elements["PNT-937"].sound = {{AFC_BUTTON_3}}
elements["PNT-938"]	= push_button_tumb(_("Course Heading Selector PLT/CPLT"),	devices.PLTCISP, device_commands.PilotCRSHDGToggle, 938, 8)
elements["PNT-938"].sound = {{AFC_BUTTON_3}}
elements["PNT-939"]	= push_button_tumb(_("Vertical Gyro Selector NORM/ALTR"),	devices.PLTCISP, device_commands.PilotVERTGYROToggle, 939, 8)
elements["PNT-939"].sound = {{AFC_BUTTON_2}}
elements["PNT-940"]	= push_button_tumb(_("No. 2 Bearing Selector ADF/VOR"),	    devices.PLTCISP, device_commands.PilotBRG2Toggle, 940, 8)
elements["PNT-940"].sound = {{AFC_BUTTON_4}}

elements["PNT-941"]	= push_button_tumb(_("NAV Mode: Doppler/GPS ON/OFF"),	    devices.CPLTCISP, device_commands.CopilotNavGPSToggle, 941, 8)
elements["PNT-941"].sound = {{AFC_BUTTON_1}}
elements["PNT-942"]	= push_button_tumb(_("NAV Mode: VOR/ILS ON/OFF"),	        devices.CPLTCISP, device_commands.CopilotNavVORILSToggle, 942, 8)
elements["PNT-942"].sound = {{AFC_BUTTON_4}}
elements["PNT-943"]	= push_button_tumb(_("NAV Mode: Back Course ON/OFF"),	    devices.CPLTCISP, device_commands.CopilotNavBACKCRSToggle, 943, 8)
elements["PNT-943"].sound = {{AFC_BUTTON_2}}
elements["PNT-944"]	= push_button_tumb(_("NAV Mode: FM Homing ON/OFF"),	        devices.CPLTCISP, device_commands.CopilotNavFMHOMEToggle, 944, 8)
elements["PNT-944"].sound = {{AFC_BUTTON_3}}
elements["PNT-945"]	= push_button_tumb(_("Turn Rate Selector NORM/ALTR"),       devices.CPLTCISP, device_commands.CopilotTURNRATEToggle, 945, 8)
elements["PNT-945"].sound = {{AFC_BUTTON_1}}
elements["PNT-946"]	= push_button_tumb(_("Course Heading Selector PLT/CPLT"),	devices.CPLTCISP, device_commands.CopilotCRSHDGToggle, 946, 8)
elements["PNT-946"].sound = {{AFC_BUTTON_4}}
elements["PNT-947"]	= push_button_tumb(_("Vertical Gyro Selector NORM/ALTR"),	devices.CPLTCISP, device_commands.CopilotVERTGYROToggle, 947, 8)
elements["PNT-947"].sound = {{AFC_BUTTON_1}}
elements["PNT-948"]	= push_button_tumb(_("No. 2 Bearing Selector ADF/VOR"),	    devices.CPLTCISP, device_commands.CopilotBRG2Toggle, 948, 8)
elements["PNT-948"].sound = {{AFC_BUTTON_3}}

-- AN/AVS-7 PANEL
elements["PNT-1100"]	= default_3_position_tumb(_("AN/AVS-7 OFF/ON/ADJUST"),                      devices.AVS7, device_commands.setAVS7Power, 1100)
elements["PNT-1101"]	= default_3_position_tumb(_("AN/AVS-7 Program Pilot/Copilot (Inop)"),	    devices.AVS7, device_commands.foo, 1101)
elements["PNT-1102"]	= default_3_position_tumb(_("AN/AVS-7 Pilot MODE 1-4/DCLT (Inop)"),         devices.AVS7, device_commands.foo, 1102)
elements["PNT-1103"]	= default_3_position_tumb(_("AN/AVS-7 Copilot MODE 1-4/DCLT (Inop)"),	    devices.AVS7, device_commands.foo, 1103)
elements["PNT-1104"]	= default_3_position_tumb(_("AN/AVS-7 BIT/ACK (Inop)"),	                    devices.AVS7, device_commands.foo, 1104)
elements["PNT-1105"]	= default_3_position_tumb(_("AN/AVS-7 ALT/P/R DEC/INC PGM NXT/SEL (Inop)"),	devices.AVS7, device_commands.foo, 1105)
elements["PNT-1106"]	= springloaded_3_pos_tumb2(_("AN/AVS-7 Pilot BRT/DIM"),	                    devices.AVS7, device_commands.incAVS7Brightness, device_commands.decAVS7Brightness, 1106)
elements["PNT-1107"]	= default_3_position_tumb(_("AN/AVS-7 Pilot DSPL POS D/U (Inop)"),      	devices.AVS7, device_commands.foo, 1107)
elements["PNT-1108"]	= default_3_position_tumb(_("AN/AVS-7 Pilot DSPL POS L/R (Inop)"),      	devices.AVS7, device_commands.foo, 1108)
elements["PNT-1109"]	= default_3_position_tumb(_("AN/AVS-7 Copilot BRT/DIM (Inop)"),	            devices.AVS7, device_commands.foo, 1109)
elements["PNT-1110"]	= default_3_position_tumb(_("AN/AVS-7 Copilot DSPL POS D/U (Inop)"),    	devices.AVS7, device_commands.foo, 1110)
elements["PNT-1111"]	= default_3_position_tumb(_("AN/AVS-7 Copilot DSPL POS L/R (Inop)"),    	devices.AVS7, device_commands.foo, 1111)

-- AN/ARC-164
elements["PNT-050"]	= multiposition_switch(_("AN/ARC-164 Mode"),	            devices.ARC164, device_commands.arc164_mode,        50, 4,  0.01, false, 0, 100, false)
elements["PNT-051"]	= default_axis(_("AN/ARC-164 Volume"),    	                devices.ARC164, device_commands.arc164_volume,      51)
elements["PNT-052"]	= multiposition_switch(_("AN/ARC-164 Manual/Preset/Guard"), devices.ARC164, device_commands.arc164_xmitmode,    52, 4,  0.01, false, 0, 100, false)
elements["PNT-053"]	= multiposition_switch(_("AN/ARC-164 100s"),    	        devices.ARC164, device_commands.arc164_freq_Xooooo, 53, 2,  0.1, false, 0, 100, false)
elements["PNT-054"]	= multiposition_switch(_("AN/ARC-164 10s"),    	            devices.ARC164, device_commands.arc164_freq_oXoooo, 54, 10, 0.1, false, 0, 100, false)
elements["PNT-055"]	= multiposition_switch(_("AN/ARC-164 1s"),    	            devices.ARC164, device_commands.arc164_freq_ooXooo, 55, 10, 0.1, false, 0, 100, false)
elements["PNT-056"]	= multiposition_switch(_("AN/ARC-164 .1s"),    	            devices.ARC164, device_commands.arc164_freq_oooXoo, 56, 10, 0.1, false, 0, 100, false)
elements["PNT-057"]	= multiposition_switch(_("AN/ARC-164 .010s"),               devices.ARC164, device_commands.arc164_freq_ooooXX, 57, 4,  0.1, false, 0, 100, false)
elements["PNT-058"]	= multiposition_switch(_("AN/ARC-164 Preset"),              devices.ARC164, device_commands.arc164_preset,      58, 20, 0.05, false, 0, 100, false)

-- Pilot APN-209 Radar Altimeter
--default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
elements["PNT-170"]	= default_axis(_("Low Altitude Set"),  devices.PLTAPN209, device_commands.apn209PilotLoSet, 170, 0, 20, true, true, true)
elements["PNT-171"]	= default_axis(_("High Altitude Set"), devices.PLTAPN209, device_commands.apn209PilotHiSet, 171, 0, 20, true, true, true)

elements["PNT-183"]	= default_axis(_("Low Altitude Set"),  devices.CPLTAPN209, device_commands.apn209CopilotLoSet, 183, 0, 20, true, true, true)
elements["PNT-184"]	= default_axis(_("High Altitude Set"), devices.CPLTAPN209, device_commands.apn209CopilotHiSet, 184, 0, 20, true, true, true)

-- Lighting
elements["PNT-251"]	= default_axis_limited(_("Glareshield Lights OFF/BRT"),                 devices.EXTLIGHTS, device_commands.glareshieldLights,   251, 0, 0.1, true, false, {0,1})
elements["PNT-252"]	= default_3_position_tumb(_("Position Lights DIM/OFF/BRT"),             devices.EXTLIGHTS, device_commands.posLightIntensity,   252)
elements["PNT-253"]	= default_2_position_tumb(_("Position Lights STEADY/FLASH"),            devices.EXTLIGHTS, device_commands.posLightMode,        253)
elements["PNT-254"]	= default_3_position_tumb(_("Anticollision Lights UPPER/BOTH/LOWER"),   devices.EXTLIGHTS, device_commands.antiLightGrp,        254)
elements["PNT-255"]	= default_3_position_tumb(_("Anticollision Lights DAY/OFF/NIGHT"),      devices.EXTLIGHTS, device_commands.antiLightMode,       255)
elements["PNT-256"]	= default_2_position_tumb(_("Nav Lights NORM/IR"),                      devices.EXTLIGHTS, device_commands.navLightMode,        256)
elements["PNT-257"]	= default_3_position_tumb(_("Cabin Lights BLUE/OFF/WHITE"),             devices.EXTLIGHTS, device_commands.cabinLightMode,      257)
elements["PNT-259"]	= default_axis_limited(_("Copilot Flight Instrument Lights OFF/BRT"),   devices.EXTLIGHTS, device_commands.cpltInstrLights,     259, 0, 0.1, true, false, {0,1})
elements["PNT-260"]	= default_axis_limited(_("Lighted Switches OFF/BRT"),                   devices.EXTLIGHTS, device_commands.lightedSwitches,     260, 0, 0.1, true, false, {0,1})
elements["PNT-261"]	= multiposition_switch(_("Formation Lights OFF/1/2/3/4/5"),             devices.EXTLIGHTS, device_commands.formationLights,     261, 6, 0.2, false, 0, 100, false)
elements["PNT-262"]	= default_axis_limited(_("Upper Console Lights OFF/BRT"),               devices.EXTLIGHTS, device_commands.upperConsoleLights,  262, 0, 0.1, true, false, {0,1})
elements["PNT-263"]	= default_axis_limited(_("Lower Console Lights OFF/BRT"),               devices.EXTLIGHTS, device_commands.lowerConsoleLights,  263, 0, 0.1, true, false, {0,1})
elements["PNT-264"]	= default_axis_limited(_("Pilot Flight Instrument Lights OFF/BRT"),     devices.EXTLIGHTS, device_commands.pltInstrLights,      264, 0, 0.1, true, false, {0,1})
elements["PNT-265"]	= default_axis_limited(_("Non Flight Instrument Lights OFF/BRT"),       devices.EXTLIGHTS, device_commands.nonFltInstrLights,   265, 0, 0.1, true, false, {0,1})
elements["PNT-266"]	= default_axis_limited(_("Radar Altimeter Dimmer"),                     devices.EXTLIGHTS, device_commands.pltRdrAltLights,     266, 0, 0.1, true, false, {0,1})
elements["PNT-267"]	= default_axis_limited(_("Radar Altimeter Dimmer"),                     devices.EXTLIGHTS, device_commands.cpltRdrAltLights,    267, 0, 0.1, true, false, {0,1})
elements["PNT-268"]	= default_2_position_tumb(_("Magnetic Compass Light ON/OFF"),           devices.EXTLIGHTS, device_commands.magCompassLights,    268)
elements["PNT-269"]	= default_3_position_tumb(_("Cockpit Lights BLUE/OFF/WHITE"),           devices.EXTLIGHTS, device_commands.cockpitLightMode,    269)

-- AN/APR-39
elements["PNT-270"]	= default_2_position_tumb(_("AN/APR-39 Power ON/OFF"),	            devices.APR39, device_commands.apr39Power, 270, 8)
elements["PNT-271"]	= short_way_button(_("AN/APR-39 Self Test (Inop.)"),	            devices.APR39, device_commands.apr39SelfTest, 271)
elements["PNT-272"]	= default_2_position_tumb(_("AN/APR-39 Altitude HIGH/LOW (Inop.)"),	devices.APR39, device_commands.apr39Altitude, 272, 8)
elements["PNT-273"]	= default_axis(_("AN/APR-39 Volume"),    	                        devices.APR39, device_commands.apr39Volume, 273)
elements["PNT-274"]	= default_axis(_("AN/APR-39 Brilliance"),    	                    devices.APR39, device_commands.apr39Brightness, 274)

-- PILOT LC6 CHRONOMETER
elements["PNT-280"]	= default_button(_("Pilot's Chronometer RESET/SET Button"), devices.PLTLC6, device_commands.resetSetBtn, 280)
elements["PNT-281"]	= default_button(_("Pilot's Chronometer MODE Button"), devices.PLTLC6, device_commands.modeBtn, 281)
elements["PNT-282"]	= default_button(_("Pilot's Chronometer START/STOP/ADVANCE Button"), devices.PLTLC6, device_commands.startStopAdvBtn, 282)

-- COPILOT LC6 CHRONOMETER
elements["PNT-283"]	= default_button(_("Copilot's Chronometer RESET/SET Button"), devices.CPLTLC6, device_commands.resetSetBtn, 283)
elements["PNT-284"]	= default_button(_("Copilot's Chronometer MODE Button"), devices.CPLTLC6, device_commands.modeBtn, 284)
elements["PNT-285"]	= default_button(_("Copilot's Chronometer START/STOP/ADVANCE Button"), devices.CPLTLC6, device_commands.startStopAdvBtn, 285)

-- PILOT ICS PANEL
--multiposition_switch_relative(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
elements["PNT-400"]	= multiposition_switch(_("Pilot ICP XMIT Selector"),            devices.BASERADIO, device_commands.pilotICPXmitSelector, 400, 6,  1/5,  false, 0, 16, false)
elements["PNT-401"]	= default_axis_limited(_("Pilot ICP RCV Volume"),               devices.PLT_ICP, device_commands.pilotICPSetVolume, 401, 0, 0.1, true, false, {0,1})
elements["PNT-402"]	= default_2_position_tumb(_("Pilot ICP Hot Mike (Inop.)"),      devices.PLT_ICP, device_commands.foo, 402, 8)
elements["PNT-403"]	= default_2_position_tumb(_("Pilot ICP RCV FM1"),               devices.PLT_ICP, device_commands.pilotICPToggleFM1, 403, 8)
elements["PNT-404"]	= default_2_position_tumb(_("Pilot ICP RCV UHF"),               devices.PLT_ICP, device_commands.pilotICPToggleUHF, 404, 8)
elements["PNT-405"]	= default_2_position_tumb(_("Pilot ICP RCV VHF"),               devices.PLT_ICP, device_commands.pilotICPToggleVHF, 405, 8)
elements["PNT-406"]	= default_2_position_tumb(_("Pilot ICP RCV FM2"),               devices.PLT_ICP, device_commands.pilotICPToggleFM2, 406, 8)
elements["PNT-407"]	= default_2_position_tumb(_("Pilot ICP RCV HF"),                devices.PLT_ICP, device_commands.pilotICPToggleHF, 407, 8)
elements["PNT-408"]	= default_2_position_tumb(_("Pilot ICP RCV VOR/LOC"),           devices.PLT_ICP, device_commands.pilotICPToggleVOR, 408, 8)
elements["PNT-409"]	= default_2_position_tumb(_("Pilot ICP RCV ADF"),               devices.PLT_ICP, device_commands.pilotICPToggleADF, 409, 8)

-- TODO OTHER ICS PANELS?

-- ARC-186 VHF
elements["PNT-410"]	= default_axis_limited(_("AN/ARC-186 Volume"),                      devices.ARC186, device_commands.arc186Volume, 410, 0, 0.1, true, false, {0,1})
elements["PNT-411"]	= default_button_tumb_v2_inverted(_("AN/ARC-186 Tone (Inop.)"),	    devices.ARC186, device_commands.arc186Tone, device_commands.arc186Tone, 411)
elements["PNT-412"]	= multiposition_switch(_("AN/ARC-186 10MHz Selector"),              devices.ARC186, device_commands.arc186Selector10MHz, 412, 13,  1/12,  false, 0, 16, true)
elements["PNT-413"]	= multiposition_switch(_("AN/ARC-186 1MHz Selector"),               devices.ARC186, device_commands.arc186Selector1MHz, 413, 10,  0.1,  false, 0, 16, true)
elements["PNT-414"]	= multiposition_switch(_("AN/ARC-186 100KHz Selector"),             devices.ARC186, device_commands.arc186Selector100KHz, 414, 10,  0.1,  false, 0, 16, true)
elements["PNT-415"]	= multiposition_switch(_("AN/ARC-186 25KHz Selector"),              devices.ARC186, device_commands.arc186Selector25KHz, 415, 4,  0.25,  false, 0, 16, true)
elements["PNT-416"]	= multiposition_switch(_("AN/ARC-186 Frequency Control Selector"),  devices.ARC186, device_commands.arc186FreqSelector, 416, 4,  1/3,  false, 0, 16, false)
elements["PNT-417"]	= default_button(_("AN/ARC-186 Load Pushbutton"),                   devices.ARC186, device_commands.arc186Load, 417)
elements["PNT-418"]	= multiposition_switch(_("AN/ARC-186 Preset Channel Selector"),     devices.ARC186, device_commands.arc186PresetSelector, 418, 20,  0.05,  false, 0, 16, true)
elements["PNT-419"]	= multiposition_switch(_("AN/ARC-186 Mode Selector"),               devices.ARC186, device_commands.arc186ModeSelector, 419, 3,  0.5,  false, 0, 16, false)

-- AFMS
elements["PNT-460"]	= default_3_position_tumb(_("Aux Fuel Transfer Mode MAN/OFF/AUTO"),         devices.AFMS, device_commands.afmcpXferMode, 460)
elements["PNT-461"]	= default_3_position_tumb(_("Aux Fuel Manual Transfer RIGHT/BOTH/LEFT"),    devices.AFMS, device_commands.afmcpManXfer,461)
elements["PNT-462"]	= default_2_position_tumb(_("Aux Fuel Transfer From OUTBD/INBD"),           devices.AFMS, device_commands.afmcpXferFrom, 462, 8)
elements["PNT-463"]	= multiposition_switch(_("Aux Fuel Pressurization Selector"),               devices.AFMS, device_commands.afmcpPress, 463, 4,  1/3,  false, 0, 16, false)

-- DOORS
elements["PNT-470"]	= default_2_position_tumb(_("Copilot Door"),         devices.MISC, device_commands.doorCplt, 470)
elements["PNT-471"]	= default_2_position_tumb(_("Pilot Door"),           devices.MISC, device_commands.doorPlt, 471)
elements["PNT-472"]	= default_2_position_tumb(_("Left Gunner Window"),   devices.MISC, device_commands.doorLGnr, 472)
elements["PNT-473"]	= default_2_position_tumb(_("Right Gunner Window"),  devices.MISC, device_commands.doorRGnr, 473)
elements["PNT-474"]	= default_2_position_tumb(_("Left Cargo Door"),      devices.MISC, device_commands.doorLCargo, 474)
elements["PNT-475"]	= default_2_position_tumb(_("Right Cargo Door"),     devices.MISC, device_commands.doorRCargo, 475)

-- M130 CM System
elements["PNT-550"]	= default_2_position_tumb(_("Flare Dispenser Mode Cover (Inop.)"), devices.M130, device_commands.cmFlareDispenseModeCover, 550, 8)
--cmFlareDispenseMode
elements["PNT-552"]	= multiposition_switch_relative(_("Flare Counter"),                      devices.M130, device_commands.cmFlareCounterDial, 552, 10, 1/9, false, 0, 16, true)
elements["PNT-553"]	= multiposition_switch_relative(_("Chaff Counter"),                      devices.M130, device_commands.cmChaffCounterDial, 553, 10, 1/9, false, 0, 16, true)
elements["PNT-559"]	= default_2_position_tumb(_("Countermeasures Arming Switch"),   devices.M130, device_commands.cmArmSwitch, 559, 8)
elements["PNT-560"]	= multiposition_switch(_("Chaff Dispenser Mode Selector"),      devices.M130, device_commands.cmProgramDial, 560, 3, 1/2, false, 0, 16, false)
elements["PNT-561"]	= default_button(_("Chaff Dispense"),                           devices.M130, device_commands.cmChaffDispense, 561)
	

-- ARC-201 FM1
elements["PNT-600"]	= multiposition_switch(_("AN/ARC-201 (FM1) PRESET Selector"),   devices.ARC201_FM1, device_commands.fm1PresetSelector, 600, 8,  0.01,  false, 0, 16, false)
elements["PNT-601"]	= multiposition_switch(_("AN/ARC-201 (FM1) FUNCTION Selector"), devices.ARC201_FM1, device_commands.fm1FunctionSelector, 601, 9,  0.01,  false, 0, 16, false)
elements["PNT-602"]	= multiposition_switch(_("AN/ARC-201 (FM1) PWR Selector"),      devices.ARC201_FM1, device_commands.fm1PwrSelector, 602, 4,  0.01,  false, 0, 16, false)
elements["PNT-603"]	= multiposition_switch(_("AN/ARC-201 (FM1) MODE Selector"),     devices.ARC201_FM1, device_commands.fm1ModeSelector, 603, 4,  0.01,  false, 0, 16, false)
elements["PNT-604"]	= default_axis_limited(_("AN/ARC-201 (FM1) Volume"),            devices.ARC201_FM1, device_commands.fm1Volume, 604, 0, 0.1, true, false, {0,1})

elements["PNT-605"]	= default_button(_("AN/ARC-201 (FM1) Btn 1"),        devices.ARC201_FM1, device_commands.fm1Btn1, 605)
elements["PNT-606"]	= default_button(_("AN/ARC-201 (FM1) Btn 2"),        devices.ARC201_FM1, device_commands.fm1Btn2, 606)
elements["PNT-607"]	= default_button(_("AN/ARC-201 (FM1) Btn 3"),        devices.ARC201_FM1, device_commands.fm1Btn3, 607)
elements["PNT-608"]	= default_button(_("AN/ARC-201 (FM1) Btn 4"),        devices.ARC201_FM1, device_commands.fm1Btn4, 608)
elements["PNT-609"]	= default_button(_("AN/ARC-201 (FM1) Btn 5"),        devices.ARC201_FM1, device_commands.fm1Btn5, 609)
elements["PNT-610"]	= default_button(_("AN/ARC-201 (FM1) Btn 6"),        devices.ARC201_FM1, device_commands.fm1Btn6, 610)
elements["PNT-611"]	= default_button(_("AN/ARC-201 (FM1) Btn 7"),        devices.ARC201_FM1, device_commands.fm1Btn7, 611)
elements["PNT-612"]	= default_button(_("AN/ARC-201 (FM1) Btn 8"),        devices.ARC201_FM1, device_commands.fm1Btn8, 612)
elements["PNT-613"]	= default_button(_("AN/ARC-201 (FM1) Btn 9"),        devices.ARC201_FM1, device_commands.fm1Btn9, 613)
elements["PNT-614"]	= default_button(_("AN/ARC-201 (FM1) Btn 0"),        devices.ARC201_FM1, device_commands.fm1Btn0, 614)
elements["PNT-615"]	= default_button(_("AN/ARC-201 (FM1) Btn CLR"),      devices.ARC201_FM1, device_commands.fm1BtnClr, 615)
elements["PNT-616"]	= default_button(_("AN/ARC-201 (FM1) Btn ENT"),      devices.ARC201_FM1, device_commands.fm1BtnEnt, 616)
elements["PNT-617"]	= default_button(_("AN/ARC-201 (FM1) Btn FREQ"),     devices.ARC201_FM1, device_commands.fm1BtnFreq, 617)
elements["PNT-618"]	= default_button(_("AN/ARC-201 (FM1) Btn ERF/OFST"), devices.ARC201_FM1, device_commands.fm1BtnErfOfst, 618)
elements["PNT-619"]	= default_button(_("AN/ARC-201 (FM1) Btn TIME"),     devices.ARC201_FM1, device_commands.fm1BtnTime, 619)

-- AN/ARN-149
elements["PNT-620"]	= multiposition_switch(_("AN/ARN-149 PRESET Selector"),     devices.ARN149, device_commands.arn149Preset, 620, 3,  0.5,  false, 0, 100, false)
elements["PNT-621"]	= default_3_position_tumb(_("AN/ARN-149 TONE/OFF/TEST"),       devices.ARN149, device_commands.arn149ToneTest, 621, 8)
elements["PNT-622"]	= default_axis_limited(_("AN/ARN-149 Volume"),              devices.ARN149, device_commands.arn149Volume, 622, 0, 0.1, true, false, {0,1})
elements["PNT-623"]	= default_2_position_tumb(_("AN/ARN-149 TAKE CMD (Inop.)"),    devices.ARN149, device_commands.foo, 623, 8)
elements["PNT-624"]	= multiposition_switch(_("AN/ARN-149 POWER Selector"),      devices.ARN149, device_commands.arn149Power, 624, 3,  0.5,  false, 0, 100, false)
elements["PNT-625"]	= multiposition_switch(_("AN/ARN-149 1000s Khz Selector"),  devices.ARN149, device_commands.arn149thousands, 625, 3,  0.5,  false, 0, 100, false)
elements["PNT-626"]	= multiposition_switch(_("AN/ARN-149 100s Khz Selector"),   devices.ARN149, device_commands.arn149hundreds, 626, 10,  0.1,  false, 0, 100, true)
elements["PNT-627"]	= multiposition_switch(_("AN/ARN-149 10s Khz Selector"),    devices.ARN149, device_commands.arn149tens, 627, 10,  0.1,  false, 0, 100, true)
elements["PNT-628"]	= multiposition_switch(_("AN/ARN-149 1s Khz Selector"),     devices.ARN149, device_commands.arn149ones, 628, 10,  0.1,  false, 0, 100, true)
elements["PNT-629"]	= multiposition_switch(_("AN/ARN-149 .1s Khz Selector"),    devices.ARN149, device_commands.arn149tenths, 629, 10,  0.1,  false, 0, 100, true)

-- AN/ARN-147
elements["PNT-650"]	= multiposition_switch_relative(_("AN/ARN-147 MHz Selector"), devices.ARN147, device_commands.arn147MHz, 650, 10,  0.1,  false, 0, 100, true)
elements["PNT-651"]	= multiposition_switch_relative(_("AN/ARN-147 KHz Selector"), devices.ARN147, device_commands.arn147KHz, 651, 10,  0.1,  false, 0, 100, true)
elements["PNT-652"]	= default_2_position_tumb(_("AN/ARN-147 Marker Beacon HI/LO (Inop.)"),  devices.ARN147, device_commands.foo, 652, 8)
elements["PNT-653"]	= default_3_position_tumb(_("AN/ARN-147 Power Selector OFF/ON/TEST"),   devices.ARN147, device_commands.arn147Power, 653, 8)

-- WIPERS
elements["PNT-631"]	= multiposition_switch(_("Wipers PARK/OFF/LOW/HI"),   devices.MISC, device_commands.wiperSelector, 631, 4,  0.33,  false, 0, 16, false)

-- ARC-201 FM1
elements["PNT-700"]	= multiposition_switch(_("AN/ARC-201 (FM1) PRESET Selector"),   devices.ARC201_FM2, device_commands.fm2PresetSelector, 700, 8,  0.01,  false, 0, 16, false)
elements["PNT-701"]	= multiposition_switch(_("AN/ARC-201 (FM1) FUNCTION Selector"), devices.ARC201_FM2, device_commands.fm2FunctionSelector, 701, 9,  0.01,  false, 0, 16, false)
elements["PNT-702"]	= multiposition_switch(_("AN/ARC-201 (FM1) PWR Selector"),      devices.ARC201_FM2, device_commands.fm2PwrSelector, 702, 4,  0.01,  false, 0, 16, false)
elements["PNT-703"]	= multiposition_switch(_("AN/ARC-201 (FM1) MODE Selector"),     devices.ARC201_FM2, device_commands.fm2ModeSelector, 703, 4,  0.01,  false, 0, 16, false)
elements["PNT-704"]	= default_axis_limited(_("AN/ARC-201 (FM1) Volume"),            devices.ARC201_FM2, device_commands.fm2Volume, 704, 0, 0.1, true, false, {0,1})

elements["PNT-705"]	= default_button(_("AN/ARC-201 (FM1) Btn 1"),        devices.ARC201_FM2, device_commands.fm2Btn1, 705)
elements["PNT-706"]	= default_button(_("AN/ARC-201 (FM1) Btn 2"),        devices.ARC201_FM2, device_commands.fm2Btn2, 706)
elements["PNT-707"]	= default_button(_("AN/ARC-201 (FM1) Btn 3"),        devices.ARC201_FM2, device_commands.fm2Btn3, 707)
elements["PNT-708"]	= default_button(_("AN/ARC-201 (FM1) Btn 4"),        devices.ARC201_FM2, device_commands.fm2Btn4, 708)
elements["PNT-709"]	= default_button(_("AN/ARC-201 (FM1) Btn 5"),        devices.ARC201_FM2, device_commands.fm2Btn5, 709)
elements["PNT-710"]	= default_button(_("AN/ARC-201 (FM1) Btn 6"),        devices.ARC201_FM2, device_commands.fm2Btn6, 710)
elements["PNT-711"]	= default_button(_("AN/ARC-201 (FM1) Btn 7"),        devices.ARC201_FM2, device_commands.fm2Btn7, 711)
elements["PNT-712"]	= default_button(_("AN/ARC-201 (FM1) Btn 8"),        devices.ARC201_FM2, device_commands.fm2Btn8, 712)
elements["PNT-713"]	= default_button(_("AN/ARC-201 (FM1) Btn 9"),        devices.ARC201_FM2, device_commands.fm2Btn9, 713)
elements["PNT-714"]	= default_button(_("AN/ARC-201 (FM1) Btn 0"),        devices.ARC201_FM2, device_commands.fm2Btn0, 714)
elements["PNT-715"]	= default_button(_("AN/ARC-201 (FM1) Btn CLR"),      devices.ARC201_FM2, device_commands.fm2BtnClr, 715)
elements["PNT-716"]	= default_button(_("AN/ARC-201 (FM1) Btn ENT"),      devices.ARC201_FM2, device_commands.fm2BtnEnt, 716)
elements["PNT-717"]	= default_button(_("AN/ARC-201 (FM1) Btn FREQ"),     devices.ARC201_FM2, device_commands.fm2BtnFreq, 717)
elements["PNT-718"]	= default_button(_("AN/ARC-201 (FM1) Btn ERF/OFST"), devices.ARC201_FM2, device_commands.fm2BtnErfOfst, 718)
elements["PNT-719"]	= default_button(_("AN/ARC-201 (FM1) Btn TIME"),     devices.ARC201_FM2, device_commands.fm2BtnTime, 719)

-- CPLT ICP
elements["PNT-800"]	= multiposition_switch(_("Copilot ICP XMIT Selector (Inop.)"),            devices.CPLT_ICP, device_commands.copilotICPXmitSelector, 800, 6,  1/5,  false, 0, 16, false)
elements["PNT-801"]	= default_axis_limited(_("Copilot ICP RCV Volume (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPSetVolume, 801, 0, 0.1, true, false, {0,1})
elements["PNT-802"]	= default_2_position_tumb(_("Copilot ICP Hot Mike (Inop.)"),              devices.CPLT_ICP, device_commands.foo, 802, 8)
elements["PNT-803"]	= default_2_position_tumb(_("Copilot ICP RCV FM1 (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleFM1, 803, 8)
elements["PNT-804"]	= default_2_position_tumb(_("Copilot ICP RCV UHF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleUHF, 804, 8)
elements["PNT-805"]	= default_2_position_tumb(_("Copilot ICP RCV VHF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleVHF, 805, 8)
elements["PNT-806"]	= default_2_position_tumb(_("Copilot ICP RCV FM2 (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleFM2, 806, 8)
elements["PNT-807"]	= default_2_position_tumb(_("Copilot ICP RCV HF (Inop.)"),                devices.CPLT_ICP, device_commands.copilotICPToggleHF, 807, 8)
elements["PNT-808"]	= default_2_position_tumb(_("Copilot ICP RCV VOR/LOC (Inop.)"),           devices.CPLT_ICP, device_commands.copilotICPToggleVOR, 808, 8)
elements["PNT-809"]	= default_2_position_tumb(_("Copilot ICP RCV ADF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleADF, 809, 8)

-- DEBUG
elements["PNT-3000"]	= default_2_position_tumb(_("Debug Visualisation ON/OFF"), devices.DEBUG, device_commands.visualisationToggle, 3000, 8)
