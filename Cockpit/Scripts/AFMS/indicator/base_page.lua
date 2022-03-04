dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local advisoryColor = {0,255,0,255}
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "h60_font_7seg"}, advisoryColor)
center = calculateIndicatorCenter({-0.096,-0.75,2.584}) -- {L/R,U/D,forward/back}
rotation = {0, 0, dashRotation} -- main panel rotation roughly 22deg
stringdefs = {0.0065,0.004, 0, 0}

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

--drawGrid(0, 0, 0, 100, 100, base)

local spacingX = 0.022

local fuel1             = CreateElement "ceStringPoly"
fuel1.name              = create_guid_string()
fuel1.material          = fontAdvisory
fuel1.alignment         = "LeftCenter"
fuel1.init_pos		    = {0,0,0} -- L/R, D/U, F/B
fuel1.stringdefs        = stringdefs
fuel1.formats           = {"%s"}
fuel1.element_params    = {"AFMS_DISPLAY_OUTBD_L"}
fuel1.controllers       = {{"text_using_parameter",0,0}}
fuel1.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
fuel1.level             = 6
fuel1.parent_element    = base.name
Add(fuel1)

local fuel2             = CreateElement "ceStringPoly"
fuel2.name              = create_guid_string()
fuel2.material          = fontAdvisory
fuel2.alignment         = "LeftCenter"
fuel2.init_pos		    = {spacingX - 0.001,0,0} -- L/R, D/U, F/B
fuel2.stringdefs        = stringdefs
fuel2.formats           = {"%s"}
fuel2.element_params    = {"AFMS_DISPLAY_INBD_L"}
fuel2.controllers       = {{"text_using_parameter",0,0}}
fuel2.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
fuel2.level             = 6
fuel2.parent_element    = base.name
Add(fuel2)

local fuel3             = CreateElement "ceStringPoly"
fuel3.name              = create_guid_string()
fuel3.material          = fontAdvisory
fuel3.alignment         = "LeftCenter"
fuel3.init_pos		    = {spacingX * 2 - 0.0005,0,0} -- L/R, D/U, F/B
fuel3.stringdefs        = stringdefs
fuel3.formats           = {"%s"}
fuel3.element_params    = {"AFMS_DISPLAY_INBD_R"}
fuel3.controllers       = {{"text_using_parameter",0,0}}
fuel3.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
fuel3.level             = 6
fuel3.parent_element    = base.name
Add(fuel3)

local fuel4             = CreateElement "ceStringPoly"
fuel4.name              = create_guid_string()
fuel4.material          = fontAdvisory
fuel4.alignment         = "LeftCenter"
fuel4.init_pos		    = {spacingX * 3,0,0} -- L/R, D/U, F/B
fuel4.stringdefs        = stringdefs
fuel4.formats           = {"%s"}
fuel4.element_params    = {"AFMS_DISPLAY_OUTBD_R"}
fuel4.controllers       = {{"text_using_parameter",0,0}}
fuel4.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
fuel4.level             = 6
fuel4.parent_element    = base.name
Add(fuel4)