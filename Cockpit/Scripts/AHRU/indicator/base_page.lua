dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local advisoryColor = {0,255,0,255}
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "14segFont"}, advisoryColor)
center = calculateIndicatorCenter({0.07,-0.928,2.425}) -- {L/R,U/D,forward/back}
rotation = {0, 0, 80} -- main panel rotation roughly 22deg
stringdefs = {0.01,0.01, -0.0035, 0}

verts = {}
dx=.0145
dy=.0084
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}

local base 			 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2,2,3,0}
base.init_pos		 = center
base.init_rot		 = rotation
base.material		 = MakeMaterial(nil,{255,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
base.element_params  = {"CB_AHRU_PLT"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}}
Add(base)

local ahruDisplay           = CreateElement "ceStringPoly"
ahruDisplay.name            = create_guid_string()
ahruDisplay.material        = fontAdvisory
ahruDisplay.alignment       = "LeftCenter"
ahruDisplay.init_pos		= {-0.012,-0.002,0} -- L/R, D/U, F/B
ahruDisplay.stringdefs      = stringdefs
ahruDisplay.formats         = {"%s"}
ahruDisplay.element_params  = {"AHRU_DISPLAY_TEXT"}
ahruDisplay.controllers     = {{"text_using_parameter",0,0}}
ahruDisplay.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
ahruDisplay.level			= 6
ahruDisplay.parent_element  = base.name
Add(ahruDisplay)