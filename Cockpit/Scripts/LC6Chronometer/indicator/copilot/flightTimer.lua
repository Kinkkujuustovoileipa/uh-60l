dofile(LockOn_Options.script_path..'LC6Chronometer/indicator/copilot/defines.lua')

local base 			 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2,2,3,0}
base.init_pos		 = center
base.init_rot		 = rotation
base.material		 = MakeMaterial(nil,bgColor)
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw 		 = true
base.change_opacity  = false
base.isvisible		 = true
base.element_params  = {"CB_CPLT_ALTM", "COPILOT_LC6_MODE"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1},{"parameter_in_range",1,2.9,3.1}}
Add(base)

local ltHrs           = CreateElement "ceStringPoly"
ltHrs.name            = create_guid_string()
ltHrs.material        = font
ltHrs.alignment       = "CenterCenter"
ltHrs.init_pos	      = {-0.013, 0, 0} -- L/R, D/U, F/B
ltHrs.stringdefs      = stringdefsLarge
ltHrs.formats         = {"%2.0f"}
ltHrs.element_params  = {"COPILOT_LC6_FLT_HRS"}
ltHrs.controllers     = {{"text_using_parameter",0,0}}
ltHrs.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ltHrs.level			  = 6
ltHrs.parent_element  = base.name
Add(ltHrs)

local colon           = CreateElement "ceStringPoly"
colon.name            = create_guid_string()
colon.material        = font
colon.alignment       = "CenterCenter"
colon.init_pos	      = {-0.005, 0, 0} -- L/R, D/U, F/B
colon.stringdefs      = stringdefsLarge
colon.formats         = {"%s"}
colon.value           = ":"
colon.controllers     = {{"text_using_parameter",0,0}}
colon.h_clip_relation = h_clip_relations.REWRITE_LEVEL
colon.level			  = 6
colon.parent_element  = base.name
Add(colon)

local ltMins           = CreateElement "ceStringPoly"
ltMins.name            = create_guid_string()
ltMins.material        = font
ltMins.alignment       = "CenterCenter"
ltMins.init_pos	       = {0.003, 0, 0} -- L/R, D/U, F/B
ltMins.stringdefs      = stringdefsLarge
ltMins.formats         = {"%02.0f"}
ltMins.element_params  = {"COPILOT_LC6_FLT_MINS"}
ltMins.controllers     = {{"text_using_parameter",0,0}}
ltMins.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ltMins.level		= 6
ltMins.parent_element  = base.name
Add(ltMins)

local ltSecs           = CreateElement "ceStringPoly"
ltSecs.name            = create_guid_string()
ltSecs.material        = font
ltSecs.alignment       = "CenterTop"
ltSecs.init_pos	       = {0.016, 0.002, 0} -- L/R, D/U, F/B
ltSecs.stringdefs      = stringdefsMid
ltSecs.formats         = {"%02.0f"}
ltSecs.element_params  = {"COPILOT_LC6_FLT_SECS"}
ltSecs.controllers     = {{"text_using_parameter",0,0}}
ltSecs.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ltSecs.level		= 6
ltSecs.parent_element  = base.name
Add(ltSecs)

local mode           = CreateElement "ceStringPoly"
mode.name            = create_guid_string()
mode.material        = font2
mode.alignment       = "CenterTop"
mode.init_pos	     = {0, -0.005, 0} -- L/R, D/U, F/B
mode.stringdefs      = stringdefsSmall
mode.formats         = {"%s"}
mode.value           = "FLIGHT"
mode.controllers     = {{"text_using_parameter",0,0}}
mode.h_clip_relation = h_clip_relations.REWRITE_LEVEL
mode.level			 = 6
mode.parent_element  = base.name
Add(mode)