dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL}

--subset ids
BASE    = 1

page_subsets  = {[BASE]    		= LockOn_Options.script_path.."AHRU/indicator/base_page.lua",}
pages = {{BASE,},}