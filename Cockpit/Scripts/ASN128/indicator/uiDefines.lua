dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

greenColor = {0,255,0,220}
h60_font_7seg = MakeFont({used_DXUnicodeFontData = "dotMatrixFont"}, greenColor)
center = calculateIndicatorCenter({-0.086,-0.916,2.444}) -- {L/R,U/D,forward/back}
rotation = {0, 0, 80} -- main panel rotation roughly 22deg
--center = {0.55,-0.2,2.4} -- {L/R,U/D,forward/back}
--rotation = {0, 0, 0} -- main panel rotation roughly 22deg
stringdefs = {0.005,0.005, 0, 0}
line1Pos = {0.023, -0.003, 0}
line2Pos = {0.023, -0.0115, 0}
line3Pos = {0.023, -0.020, 0}
line4Pos = {0.023, -0.0285, 0}
line5Pos = {0.104, -0.003, 0}
line6Pos = {0.104, -0.0115, 0}
line7Pos = {0.104, -0.020, 0}
navLinePos = {0.104, -0.0285, 0}

function createTextLine(pos, params, controllers, base, align)
    local line1Text           	= CreateElement "ceStringPoly"
    line1Text.name            	= create_guid_string()
    line1Text.material        	= h60_font_7seg
    line1Text.alignment       	= align or "LeftCenter"
    line1Text.init_pos			= pos -- L/R, D/U, F/B
    line1Text.stringdefs      	= stringdefs
    line1Text.formats         	= {"%s"}
    line1Text.value				= "!error!"
    line1Text.element_params  	= params
    line1Text.controllers     	= controllers
    line1Text.h_clip_relation  	= h_clip_relations.REWRITE_LEVEL
    line1Text.level				= 6
    line1Text.parent_element  	= base.name
    Add(line1Text)
end

function createHardcodedTextLine(pos, value, base, align)
    local line1Text           	= CreateElement "ceStringPoly"
    line1Text.name            	= create_guid_string()
    line1Text.material        	= h60_font_7seg
    line1Text.alignment       	= align or "LeftCenter"
    line1Text.init_pos			= pos -- L/R, D/U, F/B
    line1Text.stringdefs      	= stringdefs
    line1Text.formats         	= {"%s"}
    line1Text.value				= value
    line1Text.h_clip_relation  	= h_clip_relations.REWRITE_LEVEL
    line1Text.level				= 6
    line1Text.parent_element  	= base.name
    Add(line1Text)
end
