dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(METERS)
local cautionColor = {255,200,0,220}
local advisoryColor = {255,0,0,255}
local warningColor = {255,0,0,255}
local fontWarning = MakeFont({used_DXUnicodeFontData = "baseFont"}, warningColor)
local fontCaution = MakeFont({used_DXUnicodeFontData = "baseFont"}, cautionColor)
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "baseFont"}, advisoryColor)
local center = {-0.25,-0.25,0} -- {L/R,U/D,forward/back}
local rotation = {0, 0, 0} -- main panel rotation roughly 22deg

local bgMaterial = MakeMaterial(nil,{0,0,0,255})

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
base.element_params  = {"DEBUG_VISIBILITY"}
base.controllers     = {{"parameter_in_range",0,2.9,3.1}}
Add(base)

local lineWidth = 0.003

function addLine(x,y,l,r)
    local test 			 = CreateElement "ceMeshPoly"
    test.name 			 = create_guid_string()
    test.vertices 		 = {{x, y}, {x, y + l}, {x + lineWidth, y + l}, {x + lineWidth, y}}
    test.indices 		 = {0,1,2,2,3,0}
    test.init_pos		 = center
    test.init_rot		 = {r}
    test.material		 = bgMaterial
    test.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    test.level			 = 6
    test.parent_element  = base.name
    test.collimated = true
    --test.element_params  = {"AVS7_BRIGHTNESS"}
    --test.controllers     = {{"opacity_using_parameter", 0}}
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
    test.material		 = bgMaterial
    test.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    test.level			 = 6
    test.parent_element  = base.name
    --test.element_params  = {"AVS7_BRIGHTNESS"}
    --test.controllers     = {{"opacity_using_parameter", 0}}
    Add(test)
    return test
end

function addTextBlock(position, format, params)
    local text           = CreateElement "ceStringPoly"
    text.name            = create_guid_string()
    text.material        = fontAdvisory
    text.alignment       = "CenterLeft"
    text.init_pos		 = position -- L/R, D/U, F/B
    text.stringdefs      = stringdefs -- {size vertical, horizontal, 0, 0}
    text.formats         = format
    text.element_params  = params
    text.controllers     = {{"text_using_parameter",0,0}}
    text.h_clip_relation  = h_clip_relations.compare
    text.level			= 6
    text.parent_element  = base.name
    Add(text)
end

local yAxisLine = addLine(0,0,1,0)
local xAxisLine = addHorizontalLine(0,0,1,0)
--local text = addTextBlock({0,0,0}, {"%f"}, {})
local timeY = 1000
for i=0,timeY do
    local handle = "E1_N1_GRAPH_VAL_"..i
    local value = get_param_handle(handle):get()
    local seg = addHorizontalLine(1 / timeY * i,0,1 / timeY,0)
    seg.element_params = {handle}
    seg.controllers = {{"move_up_down_using_parameter",0,0.005}}
    seg.parent_element = base.name
end

for i=0,timeY do
    local handle = "E1_N2_GRAPH_VAL_"..i
    local value = get_param_handle(handle):get()
    local seg = addHorizontalLine(1 / timeY * i,0,1 / timeY,0)
    seg.element_params = {handle}
    seg.controllers = {{"move_up_down_using_parameter",0,0.005}}
    seg.parent_element = base.name
    seg.material = MakeMaterial(nil,{255,0,0,255})
end

for i=0,timeY do
    local handle = "E1_QDM_GRAPH_VAL_"..i
    local value = get_param_handle(handle):get()
    local seg = addHorizontalLine(1 / timeY * i,0,1 / timeY,0)
    seg.element_params = {handle}
    seg.controllers = {{"move_up_down_using_parameter",0,0.005}}
    seg.parent_element = base.name
    seg.material = MakeMaterial(nil,{0,255,0,255})
end

for i=0,timeY do
    local handle = "E1_QE_GRAPH_VAL_"..i
    local value = get_param_handle(handle):get()
    local seg = addHorizontalLine(1 / timeY * i,0,1 / timeY,0)
    seg.element_params = {handle}
    seg.controllers = {{"move_up_down_using_parameter",0,0.005}}
    seg.parent_element = base.name
    seg.material = MakeMaterial(nil,{0,255,255,255})
end

--local e1n1Text = addTextBlock({0, 0}, {"NG: %f"}, {"E1_NG"})
--e1n1Text.element_params = {"E1_NG"}
--e1n1Text.controllers = {{"text_using_parameter",0,0}, {"move_up_down_using_parameter",0,0.005}}
--e1n1Text.parent_element = base.name
