dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local advisoryColor = {220,200,160,255}
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "ARC201_7segFont"}, advisoryColor)
center = calculateIndicatorCenter({0.1545,-0.954,2.186}) -- {L/R,U/D,forward/back}
rotation = {0, 0, 80} -- main panel rotation roughly 22deg

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
base.element_params  = {"CB_VHF_FM1", "ARC201_FM1_MODE"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.9,1.1}}
Add(base)

local freq           = CreateElement "ceStringPoly"
freq.name            = create_guid_string()
freq.material        = fontAdvisory
freq.alignment       = "CenterCenter"
freq.init_pos		 = {-.03, 0, 0} -- L/R, D/U, F/B
freq.stringdefs      = {0.94 * 0.01,0.75*0.01, -0.0012, 0} -- {size vertical, horizontal, 0, 0}
freq.formats         = {"%s"}
freq.element_params  = {"ARC201_FM1_FREQ_DISPLAY"}
freq.controllers     = {{"text_using_parameter",0,0}}
freq.h_clip_relation = h_clip_relations.compare
freq.level			 = 6
freq.parent_element  = base.name
Add(freq)
