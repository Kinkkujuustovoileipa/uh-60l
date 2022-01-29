dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
	
MainPanel =
{
    "ccMainPanel",
    LockOn_Options.script_path.."mainpanel_init.lua",
    {"weap_interface", devices.WEAPON_SYS},
}

creators = {}
creators[devices.ELECTRIC_SYSTEM]           = {"avSimpleElectricSystem", LockOn_Options.script_path.."Systems/electricSystem.lua"}
creators[devices.ECQ]                       = {"avLuaDevice", LockOn_Options.script_path.."EngineControlQuadrant/device/ECQ.lua"}
creators[devices.AFCS]                      = {"avLuaDevice", LockOn_Options.script_path.."AFCS/device/AFCS.lua"}
creators[devices.AHRU]                      = {"avLuaDevice", LockOn_Options.script_path.."AHRU/device/AHRU.lua"}
creators[devices.APR39]			            = {"avSimpleRWR", LockOn_Options.script_path.."APR39/device/APR39.lua"}	
creators[devices.EXTLIGHTS]			        = {"avLuaDevice", LockOn_Options.script_path.."Systems/lighting.lua"}
creators[devices.AVIONICS]    		        = {"avLuaDevice", LockOn_Options.script_path.."Systems/Avionics.lua"}
creators[devices.ASN128B]    		        = {"avLuaDevice", LockOn_Options.script_path.."ASN128/device/ASN128.lua"}
creators[devices.CAUTION_ADVISORY_PANEL]    = {"avLuaDevice", LockOn_Options.script_path.."CautionAdvisoryPanel/device/CautionAdvisoryPanel.lua"}
creators[devices.VIDS]    		            = {"avLuaDevice",LockOn_Options.script_path.."VIDS/device/VIDS.lua"}
creators[devices.EFM_HELPER]    	        = {"avLuaDevice",LockOn_Options.script_path.."Systems/EFM_Helper.lua"} 
creators[devices.SOUNDSYSTEM]               = {"avLuaDevice",LockOn_Options.script_path.."Systems/sound_system.lua"}
creators[devices.AVS7]           	        = {"avLuaDevice",LockOn_Options.script_path.."AVS7/device/AVS7.lua"} 
creators[devices.HELMET_DEVICE] 	        = {"avNightVisionGoggles"}
creators[devices.M130]                      = {"avSimpleWeaponSystem", LockOn_Options.script_path.."M130/device/M130.lua"}
creators[devices.POSITION]                  = {"avLuaDevice", LockOn_Options.script_path.."Systems/PositionControl.lua"}
creators[devices.PLTLC6]                    = {"avLuaDevice", LockOn_Options.script_path.."LC6Chronometer/device/PilotLC6.lua"}
creators[devices.CPLTLC6]                   = {"avLuaDevice", LockOn_Options.script_path.."LC6Chronometer/device/CopilotLC6.lua"}
creators[devices.CISP]                      = {"avLuaDevice", LockOn_Options.script_path.."CISP/device/CISmode.lua"}
creators[devices.PLTCISP]                   = {"avLuaDevice", LockOn_Options.script_path.."CISP/device/pilotCISP.lua"}
creators[devices.CPLTCISP]                  = {"avLuaDevice", LockOn_Options.script_path.."CISP/device/copilotCISP.lua"}
creators[devices.DEBUG]                     = {"avLuaDevice", LockOn_Options.script_path.."Debug/device/Debug.lua"}
creators[devices.ARN149]                    = {"avLuaDevice", LockOn_Options.script_path.."ARN149/device/ARN149.lua"}
creators[devices.ARN147]                    = {"avLuaDevice", LockOn_Options.script_path.."ARN147/device/ARN147.lua"}
creators[devices.PLTAAU32A]                 = {"avLuaDevice", LockOn_Options.script_path.."AAU32A/device/pilotAAU32A.lua"}
creators[devices.CPLTAAU32A]                = {"avLuaDevice", LockOn_Options.script_path.."AAU32A/device/copilotAAU32A.lua"}
creators[devices.PLTAPN209]                 = {"avLuaDevice", LockOn_Options.script_path.."APN209/device/pilotAPN209.lua"}
creators[devices.CPLTAPN209]                = {"avLuaDevice", LockOn_Options.script_path.."APN209/device/copilotAPN209.lua"}
creators[devices.MISC]                      = {"avLuaDevice", LockOn_Options.script_path.."Misc/device/misc.lua"}
creators[devices.AFMS]                      = {"avSimpleWeaponSystem", LockOn_Options.script_path.."AFMS/device/AFMS.lua"}

-- Radios
creators[devices.PLT_ICP]       = {"avLuaDevice",   LockOn_Options.script_path.."ICPs/device/PilotICP.lua"}
creators[devices.INTERCOM]      = {"avIntercom",    LockOn_Options.script_path.."dummy_radio.lua", {devices.FM1_RADIO, devices.UHF_RADIO, devices.VHF_RADIO, devices.FM2_RADIO, devices.ELECTRIC_SYSTEM}}
creators[devices.ARC164]        = {"avLuaDevice",   LockOn_Options.script_path.."ARC164/device/ARC164.lua"}
creators[devices.UHF_RADIO]     = {"avUHF_ARC_164", LockOn_Options.script_path.."ARC164/device/radio.lua", {devices.ELECTRIC_SYSTEM}}
creators[devices.ARC201_FM1]    = {"avLuaDevice",   LockOn_Options.script_path.."ARC201/device/ARC201_FM1.lua"}
creators[devices.FM1_RADIO]     = {"avUHF_ARC_164", LockOn_Options.script_path.."ARC201/device/radioFM1.lua", {devices.ELECTRIC_SYSTEM}}
creators[devices.ARC186]        = {"avLuaDevice",   LockOn_Options.script_path.."ARC186/device/ARC186.lua"}
creators[devices.VHF_RADIO]     = {"avUHF_ARC_164", LockOn_Options.script_path.."ARC186/device/radio.lua", {devices.ELECTRIC_SYSTEM}}
creators[devices.ARC201_FM2]    = {"avLuaDevice",   LockOn_Options.script_path.."ARC201/device/ARC201_FM2.lua"}
creators[devices.FM2_RADIO]     = {"avUHF_ARC_164", LockOn_Options.script_path.."ARC201/device/radioFM2.lua", {devices.ELECTRIC_SYSTEM}}
creators[devices.BASERADIO]     = {"avLuaDevice",   LockOn_Options.script_path.."Systems/baseRadio.lua"}


indicators = {}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."VIDS/indicator/CDU/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."VIDS/indicator/PilotPDU/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."VIDS/indicator/CopilotPDU/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."APR39/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."AVS7/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ASN128/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."LC6Chronometer/indicator/copilot/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ARC164/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ARC201/indicator/FM1/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ARC201/indicator/FM2/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."AHRU/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."AFMS/indicator/init.lua",nil}

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."Debug/indicator/init.lua",nil}

indicators[#indicators + 1] = {"ccControlsIndicatorBase", LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua", nil}
indicators[#indicators + 1] = {"ccCargoIndicatorBase", LockOn_Options.script_path.."CargoIndicator/CargoIndicator.lua"}  
-- Experimental AI gunner stuff
--indicators[#indicators + 1] = {"ccCrewIndicatorBase", LockOn_Options.script_path .. "CrewIndicator/crew_indicator_init.lua", devices.CREWE}
--indicators[#indicators + 1] = {"UH1H::ccGunnersCPanel", LockOn_Options.script_path.."AI/ControlPanel/g_panel.lua",devices.WEAPON_SYS}

dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
