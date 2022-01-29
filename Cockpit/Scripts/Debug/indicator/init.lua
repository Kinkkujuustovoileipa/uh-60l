dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.HELMET
--indicator_type = indicator_types.COLLIMATOR
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

--subset ids
BASE    = 1
YAW    = 2
PITCH    = 3

page_subsets  =
{
    [BASE]    		= LockOn_Options.script_path.."Debug/indicator/base_page.lua",
    [YAW]    		= LockOn_Options.script_path.."Debug/indicator/yaw_page.lua",
    [PITCH]    		= LockOn_Options.script_path.."Debug/indicator/pitch_page.lua",
}

pages = {{BASE,YAW,PITCH},}