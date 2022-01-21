dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path..'ASN128/indicator/pageDefines.lua')

indicator_type = indicator_types.COMMON
init_pageID    = WINDUTC_DATA_1
purposes 	   = {render_purpose.GENERAL}

page_subsets =
{
    [WINDUTC_DATA_1]       = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [WINDUTC_DATA_2]       = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_2.lua",
    [WINDUTC_DATA_3]       = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_3.lua",
    [WINDUTC_NETWORKENTRY]    = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_network_entry.lua",
    [WINDUTC_NETWORKSTART]    = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_network_start.lua",
    [WINDUTC_NETWORKCONNECT]    = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_network_connect.lua",
    [WINDUTC_NETWORKCONNECTSTATUS]    = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_network_connectstatus.lua",
    [WINDUTC_DOWNLOAD]     = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_download.lua",
    --[WINDUTC_DAFIF]        = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_dafif.lua",
    [WINDUTC_CONFIG]       = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_config.lua",
    [XTKTKEKEY_1]          = LockOn_Options.script_path.."ASN128/indicator/xtktkekey/xtktkekey_1.lua",
    --[[
    [XTKTKEKEY_2]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [XTKTKEKEY_3]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [XTKTKEKEY_4]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [XTKTKEKEY_5]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [XTKTKEKEY_6]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [XTKTKEKEY_7]          = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    ]]
    [GSTKNAVM_1]           = LockOn_Options.script_path.."ASN128/indicator/gstknav/gstknav_1.lua",
    --[GSTKNAVM_2]           = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [PP_1]                 = LockOn_Options.script_path.."ASN128/indicator/pp/pp_1.lua",
    [PP_2]                 = LockOn_Options.script_path.."ASN128/indicator/pp/pp_2.lua",
    [DISTBRGTIME_1]        = LockOn_Options.script_path.."ASN128/indicator/distbrgtime/distbrgtime_1.lua",
    [DISTBRGTIME_2]        = LockOn_Options.script_path.."ASN128/indicator/distbrgtime/distbrgtime_2.lua",
    [DISTBRGTIME_3]        = LockOn_Options.script_path.."ASN128/indicator/distbrgtime/distbrgtime_3.lua",
    [WPTGT_1]              = LockOn_Options.script_path.."ASN128/indicator/wptgt/wptgt_1.lua",
    [WPTGT_2]              = LockOn_Options.script_path.."ASN128/indicator/wptgt/wptgt_2.lua",
    [DATUMROUTE_1]         = LockOn_Options.script_path.."ASN128/indicator/datumroute/datumroute_1.lua",
    [DATUMROUTE_2]         = LockOn_Options.script_path.."ASN128/indicator/datumroute/datumroute_2.lua",
    [DATUMROUTE_FP_1]      = LockOn_Options.script_path.."ASN128/indicator/datumroute/flightplan/datumroute_fp_1.lua",
    [DATUMROUTE_FP_2]      = LockOn_Options.script_path.."ASN128/indicator/datumroute/flightplan/datumroute_fp_2.lua",
    [DATUMROUTE_FP_3]      = LockOn_Options.script_path.."ASN128/indicator/datumroute/flightplan/datumroute_fp_3.lua",
    --[DATUMROUTE_WP]        = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    --[DATUMROUTE_IAP]       = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
    [DATUMROUTE_RTCONSEC]  = LockOn_Options.script_path.."ASN128/indicator/datumroute/flightplan/datumroute_fp_rtconsec.lua",
    --[[
        [F1_SELECTION]         = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_DIRECTTO_1]        = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_DIRECTTO_2]        = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_OBSHOLD_1]         = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_OBSHOLD_2]         = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_MESSAGE]           = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_MAHP]              = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_VECTORTOFINAL_1]   = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        [F1_VECTORTOFINAL_2]   = LockOn_Options.script_path.."ASN128/indicator/windutc/windutc_data_1.lua",
        ]]
    [POWERUP_1]  = LockOn_Options.script_path.."ASN128/indicator/powerup/powerup_1.lua",
    [POWERUP_2]  = LockOn_Options.script_path.."ASN128/indicator/powerup/powerup_2.lua",
}

pages = 
{
    pagetable
}