dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(METERS)
local cautionColor = {255,200,0,220}
local advisoryColor = {255,0,0,255}
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
base.material		 = MakeMaterial(nil,{255,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
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

local airspeedX = -0.4
local airspeedY = 0.2

addTextBlock({airspeedX, airspeedY,                 0},  {"Xu: %f"},     {"paramDebugAeroXu"})
addTextBlock({airspeedX, airspeedY - yDiff,         0},  {"Xu: %f"},     {"paramDebugAeroXu"})
addTextBlock({airspeedX, airspeedY - yDiff * 2,     0},  {"Xv: %f"},     {"paramDebugAeroXv"})
addTextBlock({airspeedX, airspeedY - yDiff * 3,     0},  {"Xw: %f"},     {"paramDebugAeroXw"})
addTextBlock({airspeedX, airspeedY - yDiff * 4,     0},  {"Xp: %f"},     {"paramDebugAeroXp"})
addTextBlock({airspeedX, airspeedY - yDiff * 5,     0},  {"Xq: %f"},     {"paramDebugAeroXq"})
addTextBlock({airspeedX, airspeedY - yDiff * 6,     0},  {"Xr: %f"},     {"paramDebugAeroXr"})
addTextBlock({airspeedX, airspeedY - yDiff * 7,     0},  {"Xda: %f"},     {"paramDebugAeroXda"})
addTextBlock({airspeedX, airspeedY - yDiff * 8,     0},  {"Xdb: %f"},     {"paramDebugAeroXdb"})
addTextBlock({airspeedX, airspeedY - yDiff * 9,     0},  {"Xdc: %f"},     {"paramDebugAeroXdc"})
addTextBlock({airspeedX, airspeedY - yDiff * 10,    0},  {"Xdp: %f"},     {"paramDebugAeroXdp"})

addTextBlock({airspeedX, airspeedY - yDiff * 12,     0},  {"Yu: %f"},     {"paramDebugAeroYu"})
addTextBlock({airspeedX, airspeedY - yDiff * 13,     0},  {"Yu: %f"},     {"paramDebugAeroYu"})
addTextBlock({airspeedX, airspeedY - yDiff * 14,     0},  {"Yv: %f"},     {"paramDebugAeroYv"})
addTextBlock({airspeedX, airspeedY - yDiff * 15,     0},  {"Yw: %f"},     {"paramDebugAeroYw"})
addTextBlock({airspeedX, airspeedY - yDiff * 16,     0},  {"Yp: %f"},     {"paramDebugAeroYp"})
addTextBlock({airspeedX, airspeedY - yDiff * 17,     0},  {"Yq: %f"},     {"paramDebugAeroYq"})
addTextBlock({airspeedX, airspeedY - yDiff * 18,     0},  {"Yr: %f"},     {"paramDebugAeroYr"})
addTextBlock({airspeedX, airspeedY - yDiff * 19,     0},  {"Yda: %f"},     {"paramDebugAeroYda"})
addTextBlock({airspeedX, airspeedY - yDiff * 20,     0},  {"Ydb: %f"},     {"paramDebugAeroYdb"})
addTextBlock({airspeedX, airspeedY - yDiff * 21,     0},  {"Ydc: %f"},     {"paramDebugAeroYdc"})
addTextBlock({airspeedX, airspeedY - yDiff * 22,     0},  {"Ydp: %f"},      {"paramDebugAeroYdp"})

addTextBlock({airspeedX, airspeedY - yDiff * 24,     0},  {"Zu: %f"},     {"paramDebugAeroZu"})
addTextBlock({airspeedX, airspeedY - yDiff * 25,     0},  {"Zu: %f"},     {"paramDebugAeroZu"})
addTextBlock({airspeedX, airspeedY - yDiff * 26,     0},  {"Zv: %f"},     {"paramDebugAeroZv"})
addTextBlock({airspeedX, airspeedY - yDiff * 27,     0},  {"Zw: %f"},     {"paramDebugAeroZw"})
addTextBlock({airspeedX, airspeedY - yDiff * 28,     0},  {"Zp: %f"},     {"paramDebugAeroZp"})
addTextBlock({airspeedX, airspeedY - yDiff * 29,     0},  {"Zq: %f"},     {"paramDebugAeroZq"})
addTextBlock({airspeedX, airspeedY - yDiff * 30,     0},  {"Zr: %f"},     {"paramDebugAeroZr"})
addTextBlock({airspeedX, airspeedY - yDiff * 31,     0},  {"Zda: %f"},     {"paramDebugAeroZda"})
addTextBlock({airspeedX, airspeedY - yDiff * 32,     0},  {"Zdb: %f"},     {"paramDebugAeroZdb"})
addTextBlock({airspeedX, airspeedY - yDiff * 33,     0},  {"Zdc: %f"},     {"paramDebugAeroZdc"})
addTextBlock({airspeedX, airspeedY - yDiff * 34,     0},  {"Zdp: %f"},     {"paramDebugAeroZdp"})

