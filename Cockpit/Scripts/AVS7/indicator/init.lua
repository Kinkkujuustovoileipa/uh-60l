dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.HELMET
--indicator_type = indicator_types.COLLIMATOR
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

--subset ids
BASE    = 1

shaderLineParamsUpdatable  = true
shaderLineDefaultThickness = 1.8
shaderLineDefaultFuzziness = 1.5
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false

page_subsets  = {[BASE]    		= LockOn_Options.script_path.."AVS7/indicator/base_page.lua",}
pages = {{BASE,},}