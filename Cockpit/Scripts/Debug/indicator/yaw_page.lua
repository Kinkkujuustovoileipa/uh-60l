dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local cautionColor = {255,200,0,255}
local advisoryColor = {0,255,0,255}
local warningColor = {255,0,0,255}
local fontWarning = MakeFont({used_DXUnicodeFontData = "baseFont"}, warningColor)
local fontCaution = MakeFont({used_DXUnicodeFontData = "baseFont"}, cautionColor)
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "baseFont"}, advisoryColor)
local center = {0,0,0} -- {L/R,U/D,forward/back}
local rotation = {0, 0, 0} -- main panel rotation roughly 22deg

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
base.material		 = MakeMaterial(nil,{120,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = true
base.element_params  = {"DEBUG_VISIBILITY"}
base.controllers     = {{"parameter_in_range",0,1.9,2.1}}
Add(base)

local pitchX = -0.5
local pitchY = -0.2
local rollX = pitchX
local rollY = 0
local yawX = pitchX
local yawY = 0.2
local yDiff = 0.015
local stringdefs = {yDiff,0.77*yDiff, 0, 0}

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
    text.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
    text.level			= 6
    text.parent_element  = base.name
    Add(text)
end

local SCALE = .3
local radius = 0.5 * SCALE
local search_tick_length = -0.05 * SCALE
local search_tick_width = 0.01 * SCALE
local search_tick_x = -search_tick_width/2
local search_tick_y = radius


local circle 			= CreateElement "ceMeshPoly"
circle.name 			= "circle"
set_circle	(circle, radius + (0.004 * SCALE), (radius - 0.004 * SCALE), 360, 32)
circle.material 		= MakeMaterial(nil,{0,255,0,255})
circle.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
circle.parent_element 	= "base"
Add(circle)

function addRadialTick(parent, params, color)
    local tick              = CreateElement "ceStringPoly"
    tick.name		   		= create_guid_string()
    tick.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
    tick.material    		= MakeMaterial(nil, color)
    tick.vertices	   		=
    {
        {search_tick_x,                     search_tick_y},
        {search_tick_x + search_tick_width, search_tick_y},	
        {search_tick_x + search_tick_width, search_tick_y + search_tick_length},
        {search_tick_x,                     search_tick_y + search_tick_length},
    }		
    tick.indices	   		= { 0,1,2,   0,2,3} -- vertex points on the tris
    tick.controllers     	= {{"rotate_using_parameter",0,1}} 
    tick.element_params  	= params
    tick.parent_element 	= parent
    Add(tick)
end

addRadialTick("base", {"paramDebugFPSYawCurrent"}, advisoryColor)
addRadialTick("base", {"paramDebugFPSYawTarget"}, warningColor)

local airspeedX = 0
local airspeedY = 0

addTextBlock({airspeedX, airspeedY,               0},  {"FPS Yaw Current: %f"},     {"paramDebugFPSYawCurrentDeg"})
addTextBlock({airspeedX, airspeedY - yDiff,      0},  {"FPS Yaw Target: %f"},     {"paramDebugFPSYawTargetDeg"})
addTextBlock({airspeedX, airspeedY - yDiff * 2,  0},  {"FPS Yaw Error: %f"},     {"paramDebugFPSYawErrorDeg"})
addTextBlock({airspeedX, airspeedY - yDiff * 3,  0},  {"FPS Yaw KP: %f"},     {"paramDebugFPSYawKP"})
addTextBlock({airspeedX, airspeedY - yDiff * 4,  0},  {"FPS Yaw KI: %f"},     {"paramDebugFPSYawKI"})
addTextBlock({airspeedX, airspeedY - yDiff * 5,  0},  {"FPS Yaw KD: %f"},     {"paramDebugFPSYawKD"})

