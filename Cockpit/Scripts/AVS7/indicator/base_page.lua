dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(METERS)
local advisoryColor = {0,255,0,220}
local font = MakeFont({used_DXUnicodeFontData = "baseFont"}, advisoryColor)
local center = {0,0, 1.5} -- {L/R,U/D,forward/back}
local rotation = {0, 0, 0} -- main panel rotation roughly 22deg
local hudMaterial = MakeMaterial(nil,{0,255,0,220})

verts = {}
dx=.5
dy=dx
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}

local textSizeMod = 0.06
local stringdefs = {dx * textSizeMod, 0.77 * (dx * textSizeMod), 0, 0}
local lineWidth = 0.006

local handleVROption = get_param_handle("AVS7_VR")
if (handleVROption:get() == 1) then
    center = {0,0,0.6} -- {L/R,U/D,forward/back}
end

local base 			 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2,2,3,0}
base.init_pos		 = center
base.init_rot		 = rotation
base.material		 = MakeMaterial(nil,{0,0,0,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
base.element_params  = {"AVS7_PWR"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}}
Add(base)

local baroAltText           = CreateElement "ceStringPoly"
baroAltText.name            = create_guid_string()
baroAltText.material        = font
baroAltText.alignment       = "RightCenter"
baroAltText.init_pos		    = {0.38, 0.15, 0} -- L/R, D/U, F/B
baroAltText.stringdefs      = stringdefs
baroAltText.formats         = {"%0.0fB"}
baroAltText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BARO_ALT"}
baroAltText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
baroAltText.h_clip_relation  = h_clip_relations.compare
baroAltText.level			= 6
baroAltText.parent_element  = base.name
Add(baroAltText)

local RdrAltText           = CreateElement "ceStringPoly"
RdrAltText.name            = create_guid_string()
RdrAltText.material        = font
RdrAltText.alignment       = "RightCenter"
RdrAltText.init_pos		    = {0.32, -0.15, 0} -- L/R, D/U, F/B
RdrAltText.stringdefs      = stringdefs
RdrAltText.formats         = {"%03.0f"}
RdrAltText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_RDR_ALT", "AVS7_RDR_ALT_DIGITVIS"}
RdrAltText.controllers     = {{"opacity_using_parameter",2}, {"text_using_parameter",1,0}}
RdrAltText.h_clip_relation  = h_clip_relations.compare
RdrAltText.level			= 6
RdrAltText.parent_element  = base.name
Add(RdrAltText)

local RdrAltBox 			= CreateElement "ceSimpleLineObject"
RdrAltBox.name 			    = create_guid_string()
RdrAltBox.material 		    = hudMaterial
RdrAltBox.primitivetype     = "lines"
RdrAltBox.width			    = 0.01
RdrAltBox.vertices          = {{0,0}, {0.07,0}, {0.07,0.04}, {0,0.04}, {0,0}}
RdrAltBox.init_pos 		    = {0.25, -0.17, 0}
RdrAltBox.parent_element    = base.name
RdrAltBox.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
RdrAltBox.level	    		= 6
RdrAltBox.element_params    = {"AVS7_BRIGHTNESS", "AVS7_RDR_ALT_BOX"}
RdrAltBox.controllers 	    = {{"opacity_using_parameter",0}, {"parameter_in_range",1,0.7,1.1}}
Add(RdrAltBox)

local waypointBrgText           = CreateElement "ceStringPoly"
waypointBrgText.name            = create_guid_string()
waypointBrgText.material        = font
waypointBrgText.alignment       = "LeftCenter"
waypointBrgText.init_pos		    = {-0.45, 0.2, 0} -- L/R, D/U, F/B
waypointBrgText.stringdefs      = stringdefs
waypointBrgText.formats         = {"%03.0f"}
waypointBrgText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_WP_BRG"}
waypointBrgText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
waypointBrgText.h_clip_relation  = h_clip_relations.compare
waypointBrgText.level			= 6
waypointBrgText.parent_element  = base.name
Add(waypointBrgText)

local waypointDistText           = CreateElement "ceStringPoly"
waypointDistText.name            = create_guid_string()
waypointDistText.material        = font
waypointDistText.alignment       = "LeftCenter"
waypointDistText.init_pos		    = {-0.45, 0.15, 0} -- L/R, D/U, F/B
waypointDistText.stringdefs      = stringdefs
waypointDistText.formats         = {"%02.1f"}
waypointDistText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_WP_DIST"}
waypointDistText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
waypointDistText.h_clip_relation  = h_clip_relations.compare
waypointDistText.level			= 6
waypointDistText.parent_element  = base.name
Add(waypointDistText)

local e1TGTText           = CreateElement "ceStringPoly"
e1TGTText.name            = create_guid_string()
e1TGTText.material        = font
e1TGTText.alignment       = "LeftCenter"
e1TGTText.init_pos		    = {-0.45, 0.1, 0} -- L/R, D/U, F/B
e1TGTText.stringdefs      = stringdefs
e1TGTText.formats         = {"%03.0fT1"}
e1TGTText.element_params  = {"AVS7_BRIGHTNESS", "E1_TGT"}
e1TGTText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
e1TGTText.h_clip_relation  = h_clip_relations.compare
e1TGTText.level			= 6
e1TGTText.parent_element  = base.name
Add(e1TGTText)

local e2TGTText           = CreateElement "ceStringPoly"
e2TGTText.name            = create_guid_string()
e2TGTText.material        = font
e2TGTText.alignment       = "LeftCenter"
e2TGTText.init_pos		    = {-0.45, 0.05, 0} -- L/R, D/U, F/B
e2TGTText.stringdefs      = stringdefs
e2TGTText.formats         = {"%03.0fT2"}
e2TGTText.element_params  = {"AVS7_BRIGHTNESS", "E2_TGT"}
e2TGTText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
e2TGTText.h_clip_relation  = h_clip_relations.compare
e2TGTText.level			= 6
e2TGTText.parent_element  = base.name
Add(e2TGTText)

local IASText           = CreateElement "ceStringPoly"
IASText.name            = create_guid_string()
IASText.material        = font
IASText.alignment       = "LeftCenter"
IASText.init_pos		    = {-0.45, -0.05, 0} -- L/R, D/U, F/B
IASText.stringdefs      = stringdefs
IASText.formats         = {"%03.0fA"}
IASText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_IAS", "AVS7_IAS_VIS"}
IASText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0},{"opacity_using_parameter",2}}
IASText.h_clip_relation  = h_clip_relations.compare
IASText.level			= 6
IASText.parent_element  = base.name
Add(IASText)

local GSText           = CreateElement "ceStringPoly"
GSText.name            = create_guid_string()
GSText.material        = font
GSText.alignment       = "LeftCenter"
GSText.init_pos		    = {-0.45, -0.1, 0} -- L/R, D/U, F/B
GSText.stringdefs      = stringdefs
GSText.formats         = {"%03.0fG"}
GSText.element_params  = {"AVS7_BRIGHTNESS", "AVS7_GS"}
GSText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
GSText.h_clip_relation  = h_clip_relations.compare
GSText.level			= 6
GSText.parent_element  = base.name
Add(GSText)

local e1TRQText           = CreateElement "ceStringPoly"
e1TRQText.name            = create_guid_string()
e1TRQText.material        = font
e1TRQText.alignment       = "LeftCenter"
e1TRQText.init_pos		    = {-0.45, -0.2, 0} -- L/R, D/U, F/B
e1TRQText.stringdefs      = stringdefs
e1TRQText.formats         = {"%03.0f"}
e1TRQText.element_params  = {"AVS7_BRIGHTNESS", "E1_TRQ"}
e1TRQText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
e1TRQText.h_clip_relation  = h_clip_relations.compare
e1TRQText.level			= 6
e1TRQText.parent_element  = base.name
Add(e1TRQText)

local e1TRQBox 			= CreateElement "ceSimpleLineObject"
e1TRQBox.name 			    = create_guid_string()
e1TRQBox.material 		    = hudMaterial
e1TRQBox.primitivetype     = "lines"
e1TRQBox.width			    = 0.01
e1TRQBox.vertices          = {{0,0}, {0.07,0}, {0.07,0.04}, {0,0.04}, {0,0}}
e1TRQBox.init_pos 		    = {-0.45, -0.22, 0}
e1TRQBox.parent_element    = base.name
e1TRQBox.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
e1TRQBox.level	    		= 6
e1TRQBox.element_params    = {"AVS7_BRIGHTNESS", "E1_TRQ_BOX"}
e1TRQBox.controllers 	    = {{"opacity_using_parameter",0}, {"parameter_in_range",1,0.9,1.1}}
Add(e1TRQBox)

local e2TRQText           = CreateElement "ceStringPoly"
e2TRQText.name            = create_guid_string()
e2TRQText.material        = font
e2TRQText.alignment       = "LeftCenter"
e2TRQText.init_pos		    = {-0.45, -0.25, 0} -- L/R, D/U, F/B
e2TRQText.stringdefs      = stringdefs
e2TRQText.formats         = {"%03.0f"}
e2TRQText.element_params  = {"AVS7_BRIGHTNESS", "E2_TRQ"}
e2TRQText.controllers     = {{"opacity_using_parameter",0}, {"text_using_parameter",1,0}}
e2TRQText.h_clip_relation  = h_clip_relations.compare
e2TRQText.level			= 6
e2TRQText.parent_element  = base.name
Add(e2TRQText)

local e2TRQBox 			= CreateElement "ceSimpleLineObject"
e2TRQBox.name 			    = create_guid_string()
e2TRQBox.material 		    = hudMaterial
e2TRQBox.primitivetype     = "lines"
e2TRQBox.width			    = 0.01
e2TRQBox.vertices          = {{0,0}, {0.07,0}, {0.07,0.04}, {0,0.04}, {0,0}}
e2TRQBox.init_pos 		    = {-0.45, -0.27, 0}
e2TRQBox.parent_element    = base.name
e2TRQBox.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
e2TRQBox.level	    		= 6
e2TRQBox.element_params    = {"AVS7_BRIGHTNESS", "E2_TRQ_BOX"}
e2TRQBox.controllers 	    = {{"opacity_using_parameter",0}, {"parameter_in_range",1,0.9,1.1}}
Add(e2TRQBox)

local pageText           = CreateElement "ceStringPoly"
pageText.name            = create_guid_string()
pageText.material        = font
pageText.alignment       = "LeftCenter"
pageText.init_pos		    = {-0.45, -0.35, 0} -- L/R, D/U, F/B
pageText.stringdefs      = stringdefs
pageText.formats         = {"%s"}
pageText.value             = "1"
pageText.element_params  = {"AVS7_BRIGHTNESS"}
pageText.controllers     = {{"opacity_using_parameter", 0}}
pageText.h_clip_relation  = h_clip_relations.compare
pageText.level			= 6
pageText.parent_element  = base.name
Add(pageText)

----------------------------------------------------------------------------------
--WARNINGS

function addHardcodedStringItem(pos, value, params, controllers)
    local cautionATT           = CreateElement "ceStringPoly"
    cautionATT.name            = create_guid_string()
    cautionATT.material        = font
    cautionATT.alignment       = "LeftCenter"
    cautionATT.init_pos		    = pos -- L/R, D/U, F/B
    cautionATT.stringdefs      = stringdefs
    cautionATT.formats         = {"%s"}
    cautionATT.value             = value
    cautionATT.element_params  = params
    cautionATT.controllers     = controllers
    cautionATT.h_clip_relation  = h_clip_relations.compare
    cautionATT.level			= 6
    cautionATT.parent_element  = base.name
    Add(cautionATT)
end

addHardcodedStringItem({-0.18, -0.32, 0}, "ATT", {"AVS7_BRIGHTNESS", "PILOT_VSI_ATT_FLAG"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,-0.1,0.1}})
addHardcodedStringItem({-0.1, -0.32, 0}, "ENG1", {"AVS7_BRIGHTNESS", "MCP_1ENGOUT"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,0.9,1.1}})
addHardcodedStringItem({-0.1, -0.32, 0}, "ENG2", {"AVS7_BRIGHTNESS", "MCP_2ENGOUT", "MCP_1ENGOUT"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,0.9,1.1}, {"parameter_in_range",2,-0.1,0.1}})
addHardcodedStringItem({0, -0.32, 0}, "FIRE", {"AVS7_BRIGHTNESS", "MCP_FIRE"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,0.9,1.1}})
addHardcodedStringItem({0.1, -0.32, 0}, "RPM", {"AVS7_BRIGHTNESS", "MCP_LOWROTORRPM"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,0.9,1.1}})
addHardcodedStringItem({-0.16, -0.38, 0}, "MST", {"AVS7_BRIGHTNESS", "MCP_MC"}, {{"opacity_using_parameter", 0}, {"parameter_in_range",1,0.9,1.1}})

----------------------------------------------------------------------------------

function addLine(x,y,l,r)
    local test 			 = CreateElement "ceMeshPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x, y + l}, {x + lineWidth, y + l}, {x + lineWidth, y}}
    test.indices 		 = {0,1,2,2,3,0}
    test.init_pos		 = center
    test.init_rot		 = {r}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.compare
    test.level			 = 6
    test.parent_element  = base.name
    test.collimated = true
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

function addHorizontalLine(x,y,l,r)
    local test 			 = CreateElement "ceMeshPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x, y + lineWidth}, {x + l, y + lineWidth}, {x + l, y}}
    test.indices 		 = {0,1,2,2,3,0}
    test.init_pos		 = center
    test.init_rot		 = {r}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.compare
    test.level			 = 6
    test.parent_element  = base.name
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

function addText(x,y, string)
    local text           = CreateElement "ceStringPoly"
    text.name            = create_guid_string()
    text.material        = font
    text.alignment       = "CenterCenter"
    text.init_pos		 = {x,y,0}
    text.stringdefs      = {dx * textSizeMod, 0.77 * (dx * textSizeMod), 0, 0}
    text.formats         = {"%s"}
    text.value           = string
    text.h_clip_relation  = h_clip_relations.compare
    text.level			= 6
    text.parent_element  = base.name
    text.element_params  = {"AVS7_BRIGHTNESS"}
    text.controllers     = {{"opacity_using_parameter", 0}}
    --text.collimated 		= true
    Add(text)
    return text
end

local horizonOffset = -0.2

function addRadialLine(a,b,r)

    local test 			 = CreateElement "ceStringPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{0, a}, {0, b}, {0+lineWidth, b}, {0+lineWidth, a}}
    test.indices 		 = {0,1,2,2,3,0}
    test.init_pos		 = {0, 0.2 + horizonOffset, 0.6}
    test.init_rot		 = {r}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    test.level			 = 6
    test.parent_element  = base.name
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

for i=-90,500,10 do
    local line = addLine(-0.3 + (i) / 200, 0.58 + horizonOffset, 0.03, 0)
    line.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
    line.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.005},{"parameter_in_range",1,i-130,i+10}}

    if i == 0 or i == 360 then
        local text = addText(i / 300, 0.48 + horizonOffset, "N")
        text.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
        text.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.0033},{"parameter_in_range",1,i-70,i+70}}
    elseif i == 90 or i == 450 then
        local text = addText(i / 300, 0.48 + horizonOffset, "E")
        text.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
        text.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.0033},{"parameter_in_range",1,i-70,i+70}}
    elseif i == 180 then
        local text = addText(i / 300, 0.48 + horizonOffset, "S")
        text.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
        text.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.0033},{"parameter_in_range",1,i-70,i+70}}
    elseif i == 270 or i == -90 then
        local text = addText(i / 300, 0.48 + horizonOffset, "W")
        text.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
        text.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.0033},{"parameter_in_range",1,i-70,i+70}}
    elseif i % 30 == 0 then
        local strValue = i
        if strValue > 360 then
            strValue = strValue - 360
        elseif strValue < 0 then
            strValue = strValue + 360
        end

        local text = addText(i / 300, 0.48 + horizonOffset, tostring(strValue/10))
        text.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HEADING"}
        text.controllers     = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,-0.0033},{"parameter_in_range",1,i-70,i+70}}
    end
end

-- Heading reference line
addLine(0,0.54 + horizonOffset,0.03,0)

-- Reference Line
local attRefLine1 = addHorizontalLine(-0.15,horizonOffset,0.1,0)
local attRefLine2 = addLine(-0.05-lineWidth,-0.01 + horizonOffset,0.01,0)
local attRefLine3 = addHorizontalLine(0.05,horizonOffset,0.1,0)
local attRefLine4 = addLine(0.05,-0.01 + horizonOffset,0.01,0)

attRefLine1.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HORIZON_VIS"}
attRefLine1.controllers  = {{"opacity_using_parameter",0}, {"parameter_in_range", 1, 0.5, 1.1}}
attRefLine2.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HORIZON_VIS"}
attRefLine2.controllers  = {{"opacity_using_parameter",0}, {"parameter_in_range", 1, 0.5, 1.1}}
attRefLine3.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HORIZON_VIS"}
attRefLine3.controllers  = {{"opacity_using_parameter",0}, {"parameter_in_range", 1, 0.5, 1.1}}
attRefLine4.element_params  = {"AVS7_BRIGHTNESS", "AVS7_HORIZON_VIS"}
attRefLine4.controllers  = {{"opacity_using_parameter",0}, {"parameter_in_range", 1, 0.5, 1.1}}

-- Horizon Line
local horizonLineL3 = addHorizontalLine(-0.325,horizonOffset,0.05,0)
local horizonLineL2 = addHorizontalLine(-0.225,horizonOffset,0.05,0)
local horizonLineL1 = addHorizontalLine(-0.125,horizonOffset,0.05,0)
local horizonLineC  = addHorizontalLine(-0.025,horizonOffset,0.05,0)
local horizonLineR1 = addHorizontalLine(0.075,horizonOffset,0.05,0)
local horizonLineR2 = addHorizontalLine(0.175,horizonOffset,0.05,0)
local horizonLineR3 = addHorizontalLine(0.275,horizonOffset,0.05,0)

horizonLineL3.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineL3.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineL2.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineL2.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineL1.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineL1.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineC.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineC.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineR1.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineR1.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineR2.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineR2.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
horizonLineR3.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_HORIZON_VIS"}
horizonLineR3.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}

-- Pitch Ladder
pitchLadderU10 = addHorizontalLine(-0.025, 0.05 + horizonOffset, 0.05, 0)
pitchLadderU20 = addHorizontalLine(-0.025, 0.1 + horizonOffset, 0.05, 0)
pitchLadderU30 = addHorizontalLine(-0.025, 0.15 + horizonOffset, 0.05, 0)
pitchLadderD10 = addHorizontalLine(-0.025, -0.05 + horizonOffset, 0.05, 0)
pitchLadderD20 = addHorizontalLine(-0.025, -0.1 + horizonOffset, 0.05, 0)
pitchLadderD30 = addHorizontalLine(-0.025, -0.15 + horizonOffset, 0.05, 0)

pitchLadderU10.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderU10.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
pitchLadderU20.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderU20.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
pitchLadderU30.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderU30.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
pitchLadderD10.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderD10.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
pitchLadderD20.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderD20.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}
pitchLadderD30.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_PITCHANGLE", "AVS7_BANKANGLE_VIS"}
pitchLadderD30.controllers  = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"move_up_down_using_parameter",2,.005}, {"parameter_in_range", 3, 0.5, 1.1}}

-- Roll Scale
--addRadialLine(x,y,l,r,o)
rollIndC   = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset,   0)
rollIndL30 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset, 330)
rollIndL20 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset, 340)
rollIndL10 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset, 350)
rollIndR10 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset,  10)
rollIndR20 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset,  20)
rollIndR30 = addRadialLine(0.4 + horizonOffset, 0.43 + horizonOffset,  30)

rollInd = addRadialLine(0.35 + horizonOffset,0.38 + horizonOffset,  0)
rollInd.element_params  = {"AVS7_BRIGHTNESS", "AVS7_BANKANGLE", "AVS7_BANKANGLE_VIS"}
rollInd.controllers     = {{"opacity_using_parameter",0}, {"rotate_using_parameter",1,-1}, {"parameter_in_range", 2, 0.5, 1.1}}

vsScaleY = 0.1

-- VS/AGL Scale
AGL200 = addHorizontalLine(0.55, 0.15 + horizonOffset + vsScaleY,0.05,0)
AGL150 = addHorizontalLine(0.55, 0.00 + horizonOffset + vsScaleY,0.05,0)
AGL100 = addHorizontalLine(0.55,-0.15 + horizonOffset + vsScaleY,0.05,0)
AGL50  = addHorizontalLine(0.55,-0.30 + horizonOffset + vsScaleY,0.05,0)
AGL40  = addHorizontalLine(0.55,-0.33 + horizonOffset + vsScaleY,0.05,0)
AGL30  = addHorizontalLine(0.55,-0.36 + horizonOffset + vsScaleY,0.05,0)
AGL20  = addHorizontalLine(0.55,-0.39 + horizonOffset + vsScaleY,0.05,0)
AGL10  = addHorizontalLine(0.55,-0.42 + horizonOffset + vsScaleY,0.05,0)
AGL0   = addHorizontalLine(0.55,-0.45 + horizonOffset + vsScaleY,0.05,0)

-- AGL Ind
local rdrAltInd 			= CreateElement "ceSimpleLineObject"
rdrAltInd.name 			    = create_guid_string()
rdrAltInd.material 		    = hudMaterial
rdrAltInd.primitivetype     = "triangles"
rdrAltInd.width			    = 0.016
rdrAltInd.vertices          = {{0,0}, {0,0}, {.1,0}}
rdrAltInd.init_pos 		    = {0.575, -0.55, 1.5}
rdrAltInd.parent_element    = base.name
rdrAltInd.h_clip_relation   = h_clip_relations.compare
rdrAltInd.level	    		= 6
rdrAltInd.element_params    = {"AVS7_BRIGHTNESS", "AVS7_RDR_ALT_LINE", "AVS7_RDR_ALT_VIS"}
--{"line_object_set_point_using_parameters", point_nr, param_x, param_y, gain_x, gain_y} -- applies to ceSimpleLineObject at least
rdrAltInd.controllers 	    =
{
    {"line_object_set_point_using_parameters", 1, 1, 1, 0, 0.75},
    {"line_object_set_point_using_parameters", 2, 1, 1, 0, 0.75},
    {"opacity_using_parameter", 2}
}
Add(rdrAltInd)

function addChevron(x,y,w,h,r)
    local test 			 = CreateElement "ceStringPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x + w, y + h/2}, {x,y + h}}
    test.indices 		 = {0,1,2,2,1,1,0}
    test.init_pos		 = center
    test.init_rot		 = {r}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.compare
    test.level			 = 6
    test.parent_element  = base.name
    test.collimated = true
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

vsInd = addChevron(0.51, -0.171 + horizonOffset + vsScaleY, 0.04, 0.05, 0)
vsInd.element_params  = {"AVS7_BRIGHTNESS", "AVS7_VS"}
vsInd.controllers     = {{"opacity_using_parameter",0}, {"move_up_down_using_parameter",1,0.00015}}

function addWPToInd(x,y,w,h,t)
    local test 			 = CreateElement "ceStringPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x + w, y}, {(x + w) / 2 + t / 2, y + h}, {x + t, y}, {x + w + t, y}, {(x + w) / 2 + t / 2, y + h - (t * 1.2)}}
    test.indices 		 = {0,2,3, 2,3,5, 2,1,5, 2,1,4}
    test.init_pos		 = center
    test.init_rot		 = {0}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.compare
    test.level			 = 6
    test.parent_element  = base.name
    test.collimated = true
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

function addWPFromInd(x,y,w,h,t)
    local test 			 = CreateElement "ceStringPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x + w, y}, {(x + w) / 2 + t / 2, y - h}, {x + t, y}, {x + w + t, y}, {(x + w) / 2 + t / 2, y - h + (t * 1.2)}}
    test.indices 		 = {0,2,3, 2,3,5, 2,1,5, 2,1,4}
    test.init_pos		 = center
    test.init_rot		 = {0}
    test.material		 = hudMaterial
    test.h_clip_relation = h_clip_relations.compare
    test.level			 = 6
    test.parent_element  = base.name
    test.collimated = true
    test.element_params  = {"AVS7_BRIGHTNESS"}
    test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

local x = 0
local y = 0.34
local w = 0.038
local h = 0.03
local t = 0.006

wpToInd = addWPToInd(x, y, w, h, t)
wpToInd.init_pos		 = {0 - (w / 2),0, 1.5}
wpToInd.element_params  = {"AVS7_WPIND", "AVS7_WPTO_DISPLAY"}
wpToInd.controllers     = {{"move_left_right_using_parameter",0, 0.35, -0.35}, {"opacity_using_parameter",1}}

wpFromInd = addWPFromInd(x, y + h, w, h, t)
wpFromInd.init_pos		 = {0 - (w / 2),0, 1.5}
wpFromInd.element_params  = {"AVS7_WPIND", "AVS7_WPFROM_DISPLAY"}
wpFromInd.controllers     = {{"move_left_right_using_parameter",0, 0.35, -0.35}, {"opacity_using_parameter",1}}

-- SLIP Ind
local slipYAdjust = 0.1
addHorizontalLine(-0.25, -0.75 + slipYAdjust,0.5,0)
addLine(-0.05,-0.75 + slipYAdjust,0.1,0)
addLine(0.05,-0.75 + slipYAdjust,0.1,0)

local   slipCircle 			= CreateElement "ceMeshPoly"
slipCircle.init_pos		    = {0.001, -0.372, 0}
slipCircle.name 			= "slipCircle"
slipCircle.material 		= hudMaterial
slipCircle.h_clip_relation	= h_clip_relations.compare
slipCircle.parent_element 	= base.name
slipCircle.element_params	= {"AVS7_BRIGHTNESS", "AVS7_SLIP"}
slipCircle.controllers 		= {{"opacity_using_parameter",0}, {"move_left_right_using_parameter", 1, 0.2, -0.2}}
set_circle	(slipCircle, 0.045 * 0.6, 0.05 * 0.6, 360, 32)
Add(slipCircle)

local vvBase 			= CreateElement "ceMeshPoly"
vvBase.name 			= create_guid_string()
vvBase.vertices 		= verts
vvBase.indices 		    = {0,1,2,2,3,0}
vvBase.init_pos		    = {0,horizonOffset,1.5}
vvBase.material		    = MakeMaterial(nil,{0,0,0,144})
vvBase.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
vvBase.level			= 6
vvBase.isvisible		= false
vvBase.parent_element   = base.name
vvBase.element_params   = {"AVS7_BRIGHTNESS", "AVS7_VV_ROT", "AVS7_VV_VIS"}
vvBase.controllers      = {{"opacity_using_parameter",0}, {"rotate_using_parameter", 1, 1}, {"parameter_in_range", 2, 0.9, 1.1}}
Add(vvBase)

local vvLine 			= CreateElement "ceSimpleLineObject"
vvLine.name 		    = create_guid_string()
vvLine.material 		= hudMaterial
vvLine.primitivetype    = "lines"
vvLine.width			= 0.01
vvLine.vertices         = {{0,0}, {0,0}}
vvLine.init_pos 		= {0,0,0}
vvLine.parent_element   = vvBase.name
vvLine.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
vvLine.level	    	= 6
vvLine.element_params   = {"AVS7_BRIGHTNESS", "AVS7_VV_MAG"}
vvLine.controllers 	    = {{"opacity_using_parameter",0}, {"line_object_set_point_using_parameters", 0, 1, 1, 0, 0.18}}
Add(vvLine)

local vvInd 			= CreateElement "ceSimpleLineObject"
vvInd.name 			    = create_guid_string()
vvInd.material 		    = hudMaterial
vvInd.primitivetype     = "lines"
vvInd.width			    = 0.01
vvInd.vertices          = {{0,-0.02}, {-0.02,0}, {0,0.02}, {0.02,0}, {0,-0.02}}
vvInd.init_pos 		    = {0,0,0}
vvInd.parent_element    = vvLine.name
vvInd.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
vvInd.level	    		= 6
vvInd.element_params    = {"AVS7_BRIGHTNESS", "AVS7_VV_MAG"}
vvInd.controllers 	    = {{"opacity_using_parameter",0}, {"move_up_down_using_parameter", 1, 0.2}}
Add(vvInd)
