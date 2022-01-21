dofile(LockOn_Options.common_script_path.."devices_defs.lua")

dofile(LockOn_Options.script_path.."AI/ControlPanel/g_panel_definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")

StatusColors = {}
StatusColors[STC_GREEN] =  materials["GREEN"]
StatusColors[STC_RED] 	=  materials["RED"]
StatusColors[STC_WHITE] =  materials["WHITE_2"]
StatusColors[STC_YELLOW] =  materials["YELLOW"]

indicator_type      = indicator_types.COMMON
purposes 	 		= {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale   = 4;

-------PAGE IDs-------
id_Page =
{
	MAIN = 0,
}

id_pagesubset =
{
	COMMON   = 0,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."AI/ControlPanel/g_panel_page.lua"
  	
----------------------
pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON}
init_pageID     	= id_Page.MAIN
