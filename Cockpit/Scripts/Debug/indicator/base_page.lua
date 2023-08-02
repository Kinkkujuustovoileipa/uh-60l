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
base.controllers     = {{"parameter_in_range",0,0.9,1.1}}
Add(base)

local pitchX = -0.3
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

addTextBlock({pitchX, pitchY,             0},  {"Pitch U: %f"},    {"paramPitchDebugAeroNu"})
addTextBlock({pitchX, pitchY - yDiff,     0},  {"Pitch V: %f"},    {"paramPitchDebugAeroNv"})
addTextBlock({pitchX, pitchY - yDiff * 2, 0},   {"Pitch W: %f"},    {"paramPitchDebugAeroNw"})
addTextBlock({pitchX, pitchY - yDiff * 3, 0}, {"Pitch P: %f"},    {"paramPitchDebugAeroNp"})
addTextBlock({pitchX, pitchY - yDiff * 4, 0}, {"Pitch Q: %f"},    {"paramPitchDebugAeroNq"})
addTextBlock({pitchX, pitchY - yDiff * 5, 0},  {"Pitch R: %f"},    {"paramPitchDebugAeroNr"})
addTextBlock({pitchX, pitchY - yDiff * 6, 0},  {"Pitch Da: %f"},   {"paramPitchDebugAeroNda"})
addTextBlock({pitchX, pitchY - yDiff * 7, 0},  {"Pitch Db: %f"},   {"paramPitchDebugAeroNdb"})
addTextBlock({pitchX, pitchY - yDiff * 8, 0},   {"Pitch Dc: %f"},   {"paramPitchDebugAeroNdc"})
addTextBlock({pitchX, pitchY - yDiff * 9, 0},  {"Pitch Dp: %f"},   {"paramPitchDebugAeroNdp"})
addTextBlock({pitchX, pitchY - yDiff * 10, 0},  {"Pitch FPS/SAS: %f"},   {"paramPitchDebugAeroPSAS"})

addTextBlock({rollX, rollY,              0},  {"Roll U: %f"},    {"paramRollDebugAeroNu"})
addTextBlock({rollX, rollY - yDiff,      0},  {"Roll V: %f"},    {"paramRollDebugAeroNv"})
addTextBlock({rollX, rollY - yDiff * 2,  0},  {"Roll W: %f"},    {"paramRollDebugAeroNw"})
addTextBlock({rollX, rollY - yDiff * 3,  0},  {"Roll P: %f"},    {"paramRollDebugAeroNp"})
addTextBlock({rollX, rollY - yDiff * 4,  0},  {"Roll Q: %f"},    {"paramRollDebugAeroNq"})
addTextBlock({rollX, rollY - yDiff * 5,  0},  {"Roll R: %f"},    {"paramRollDebugAeroNr"})
addTextBlock({rollX, rollY - yDiff * 6,  0},  {"Roll Da: %f"},   {"paramRollDebugAeroNda"})
addTextBlock({rollX, rollY - yDiff * 7,  0},  {"Roll Db: %f"},   {"paramRollDebugAeroNdb"})
addTextBlock({rollX, rollY - yDiff * 8,  0},  {"Roll Dc: %f"},   {"paramRollDebugAeroNdc"})
addTextBlock({rollX, rollY - yDiff * 9,  0},  {"Roll Dp: %f"},   {"paramRollDebugAeroNdp"})
addTextBlock({rollX, rollY - yDiff * 10,  0},  {"Roll FPS/SAS: %f"},   {"paramRollDebugAeroRSAS"})

addTextBlock({yawX, yawY,               0},  {"Yaw U: %f"},    {"paramYawDebugAeroNu"})
addTextBlock({yawX, yawY - yDiff,       0},  {"Yaw V: %f"},    {"paramYawDebugAeroNv"})
addTextBlock({yawX, yawY - yDiff * 2,   0},  {"Yaw W: %f"},    {"paramYawDebugAeroNw"})
addTextBlock({yawX, yawY - yDiff * 3,   0},  {"Yaw P: %f"},    {"paramYawDebugAeroNp"})
addTextBlock({yawX, yawY - yDiff * 4,   0},  {"Yaw Q: %f"},    {"paramYawDebugAeroNq"})
addTextBlock({yawX, yawY - yDiff * 5,   0},  {"Yaw R: %f"},    {"paramYawDebugAeroNr"})
addTextBlock({yawX, yawY - yDiff * 6,   0},  {"Yaw Da: %f"},   {"paramYawDebugAeroNda"})
addTextBlock({yawX, yawY - yDiff * 7,   0},  {"Yaw Db: %f"},   {"paramYawDebugAeroNdb"})
addTextBlock({yawX, yawY - yDiff * 8,   0},  {"Yaw Dc: %f"},   {"paramYawDebugAeroNdc"})
addTextBlock({yawX, yawY - yDiff * 9,   0},  {"Yaw Dp: %f"},   {"paramYawDebugAeroNdp"})
addTextBlock({yawX, yawY - yDiff * 10,   0},  {"Yaw FPS/SAS: %f"},   {"paramYawDebugAeroYSAS"})

local airspeedX = 0
local airspeedY = 0

addTextBlock({airspeedX, airspeedY,               0},  {"Airspeed X: %f m/sec"},     {"paramDebugAirspeedXFPS"})
addTextBlock({airspeedX, airspeedY - yDiff,       0},  {"Airspeed Y: %f m/sec"},     {"paramDebugAirspeedYFPS"})
addTextBlock({airspeedX, airspeedY - yDiff * 2,   0},  {"Airspeed Z: %f m/sec"},     {"paramDebugAirspeedZFPS"})
addTextBlock({airspeedX, airspeedY - yDiff * 3,   0},  {"Pitch Rate: %f rad/sec"},   {"paramDebugPitchRateFPS"})
addTextBlock({airspeedX, airspeedY - yDiff * 4,   0},  {"Roll Rate: %f rad/sec"},    {"paramDebugRollRateFPS"})
addTextBlock({airspeedX, airspeedY - yDiff * 5,   0},  {"Yaw Rate: %f rad/sec"},     {"paramDebugYawRateFPS"})
addTextBlock({airspeedX, airspeedY - yDiff * 6,   0},  {"Collective Input: %f"},     {"paramDebugCollectiveInput"})
addTextBlock({airspeedX, airspeedY - yDiff * 7,   0},  {"Pitch Input: %f"},          {"paramDebugPitchInput"})
addTextBlock({airspeedX, airspeedY - yDiff * 8,   0},  {"Roll Input: %f"},           {"paramDebugRollInput"})
addTextBlock({airspeedX, airspeedY - yDiff * 9,   0},  {"Pedal Input: %f"},          {"paramDebugPedalInput"})
addTextBlock({airspeedX, airspeedY - yDiff * 10,  0},  {"RPM Effect: %f"},           {"paramDebugRPMEffect"})
addTextBlock({airspeedX, airspeedY - yDiff * 11,  0},  {"Mass: %f"},                 {"paramDebugMass"})

addTextBlock({airspeedX, airspeedY - yDiff * 12,  0},  {"Raw Pitch Input: %f"},      {"paramDebugRawPitch"})
addTextBlock({airspeedX, airspeedY - yDiff * 13,  0},  {"Raw Roll Input: %f"},       {"paramDebugRawRoll"})
addTextBlock({airspeedX, airspeedY - yDiff * 14,  0},  {"Raw Pedal Input: %f"},      {"paramDebugRawPedal"})
addTextBlock({airspeedX, airspeedY - yDiff * 15,  0},  {"Pitch Trim: %f"},           {"paramDebugPitchTrim"})
addTextBlock({airspeedX, airspeedY - yDiff * 16,  0},  {"Roll Trim: %f"},            {"paramDebugRollTrim"})
addTextBlock({airspeedX, airspeedY - yDiff * 17,  0},  {"FPS Roll State: %f"},       {"ROLL_AFC"})
addTextBlock({airspeedX, airspeedY - yDiff * 18,  0},  {"FPS Pitch State: %f"},      {"PITCH_AFC"})
addTextBlock({airspeedX, airspeedY - yDiff * 19,  0},  {"Refuel Probe State: %f"},   {"paramDebugProbeState"})
addTextBlock({airspeedX, airspeedY - yDiff * 20,  0},  {"G Force: %f"},              {"paramDebugG"})
addTextBlock({airspeedX, airspeedY - yDiff * 21,  0},  {"Blade Slap Normal: %f"},              {"paramDebugBladeSlap"})
addTextBlock({airspeedX, airspeedY - yDiff * 22,  0},  {"Blade Slap G: %f"},              {"paramDebugBladeSlapG"})
addTextBlock({airspeedX, airspeedY - yDiff * 23,  0},  {"Angle of Slide: %f"},              {"paramDebugSlide"})

addTextBlock({airspeedX, airspeedY - yDiff * 24,  0},  {"E1 Fuel Flow: %f lbs/hr"},  {"E1_FUEL_FLOW"})
addTextBlock({airspeedX, airspeedY - yDiff * 25,  0},  {"E2 Fuel Flow: %f lbs/hr"},  {"E2_FUEL_FLOW"})
addTextBlock({airspeedX, airspeedY - yDiff * 26,  0},  {"Cruise Torque Req: %f"},  {"DEBUG_CRUISE_TRQ"})




local airspeedY = 0.2

addTextBlock({airspeedX + 0.3, airspeedY - yDiff,         0},  {"Xu: %f"},     {"paramDebugAeroXu"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 2,     0},  {"Xv: %f"},     {"paramDebugAeroXv"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 3,     0},  {"Xw: %f"},     {"paramDebugAeroXw"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 4,     0},  {"Xp: %f"},     {"paramDebugAeroXp"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 5,     0},  {"Xq: %f"},     {"paramDebugAeroXq"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 6,     0},  {"Xr: %f"},     {"paramDebugAeroXr"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 7,     0},  {"Xda: %f"},     {"paramDebugAeroXda"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 8,     0},  {"Xdb: %f"},     {"paramDebugAeroXdb"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 9,     0},  {"Xdc: %f"},     {"paramDebugAeroXdc"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 10,    0},  {"Xdp: %f"},     {"paramDebugAeroXdp"})

addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 13,     0},  {"Yu: %f"},     {"paramDebugAeroYu"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 14,     0},  {"Yv: %f"},     {"paramDebugAeroYv"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 15,     0},  {"Yw: %f"},     {"paramDebugAeroYw"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 16,     0},  {"Yp: %f"},     {"paramDebugAeroYp"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 17,     0},  {"Yq: %f"},     {"paramDebugAeroYq"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 18,     0},  {"Yr: %f"},     {"paramDebugAeroYr"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 19,     0},  {"Yda: %f"},     {"paramDebugAeroYda"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 20,     0},  {"Ydb: %f"},     {"paramDebugAeroYdb"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 21,     0},  {"Ydc: %f"},     {"paramDebugAeroYdc"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 22,     0},  {"Ydp: %f"},      {"paramDebugAeroYdp"})

addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 25,     0},  {"Zu: %f"},     {"paramDebugAeroZu"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 26,     0},  {"Zv: %f"},     {"paramDebugAeroZv"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 27,     0},  {"Zw: %f"},     {"paramDebugAeroZw"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 28,     0},  {"Zp: %f"},     {"paramDebugAeroZp"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 29,     0},  {"Zq: %f"},     {"paramDebugAeroZq"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 30,     0},  {"Zr: %f"},     {"paramDebugAeroZr"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 31,     0},  {"Zda: %f"},     {"paramDebugAeroZda"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 32,     0},  {"Zdb: %f"},     {"paramDebugAeroZdb"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 33,     0},  {"Zdc: %f"},     {"paramDebugAeroZdc"})
addTextBlock({airspeedX + 0.3, airspeedY - yDiff * 34,     0},  {"Zdp: %f"},     {"paramDebugAeroZdp"})























--[[
local debugPitchText           = CreateElement "ceStringPoly"
debugPitchText.name            = create_guid_string()
debugPitchText.material        = fontAdvisory
debugPitchText.alignment       = "CenterCenter"
debugPitchText.init_pos		    = {pitchX, 0, 0} -- L/R, D/U, F/B
debugPitchText.stringdefs      = stringdefs
debugPitchText.formats         = {"Pitch: %f"}
debugPitchText.element_params  = {"DEBUG_PITCH"}
debugPitchText.controllers     = {{"text_using_parameter",0,0}}
debugPitchText.h_clip_relation  = h_clip_relations.compare
debugPitchText.level			= 6
debugPitchText.parent_element  = base.name
Add(debugPitchText)

local debugFPSPitchText           = CreateElement "ceStringPoly"
debugFPSPitchText.name            = create_guid_string()
debugFPSPitchText.material        = fontAdvisory
debugFPSPitchText.alignment       = "CenterCenter"
debugFPSPitchText.init_pos		    = {pitchX, -0.01, 0} -- L/R, D/U, F/B
debugFPSPitchText.stringdefs      = stringdefs
debugFPSPitchText.formats         = {"FPS Pitch: %f"}
debugFPSPitchText.element_params  = {"DEBUG_FPSPITCH"}
debugFPSPitchText.controllers     = {{"text_using_parameter",0,0}}
debugFPSPitchText.h_clip_relation  = h_clip_relations.compare
debugFPSPitchText.level			= 6
debugFPSPitchText.parent_element  = base.name
Add(debugFPSPitchText)

local debugFPSPitchDiffText           = CreateElement "ceStringPoly"
debugFPSPitchDiffText.name            = create_guid_string()
debugFPSPitchDiffText.material        = fontAdvisory
debugFPSPitchDiffText.alignment       = "CenterCenter"
debugFPSPitchDiffText.init_pos		 = {pitchX, -0.02, 0} -- L/R, D/U, F/B
debugFPSPitchDiffText.stringdefs      = stringdefs
debugFPSPitchDiffText.formats         = {"FPS Pitch Diff: %f"}
debugFPSPitchDiffText.element_params  = {"DEBUG_FPSPITCHDIFF"}
debugFPSPitchDiffText.controllers     = {{"text_using_parameter",0,0}}
debugFPSPitchDiffText.h_clip_relation  = h_clip_relations.compare
debugFPSPitchDiffText.level			= 6
debugFPSPitchDiffText.parent_element  = base.name
Add(debugFPSPitchDiffText)

local debugPitchRotSpeed           = CreateElement "ceStringPoly"
debugPitchRotSpeed.name            = create_guid_string()
debugPitchRotSpeed.material        = fontAdvisory
debugPitchRotSpeed.alignment       = "CenterCenter"
debugPitchRotSpeed.init_pos		 = {pitchX, -0.03, 0} -- L/R, D/U, F/B
debugPitchRotSpeed.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugPitchRotSpeed.formats         = {"FPS Pitch RotSpd: %f"}
debugPitchRotSpeed.element_params  = {"DEBUG_PITCHROTSPEED"}
debugPitchRotSpeed.controllers     = {{"text_using_parameter",0,0}}
debugPitchRotSpeed.h_clip_relation  = h_clip_relations.compare
debugPitchRotSpeed.level			= 6
debugPitchRotSpeed.parent_element  = base.name
Add(debugPitchRotSpeed)

local debugFPSPitchForceText           = CreateElement "ceStringPoly"
debugFPSPitchForceText.name            = create_guid_string()
debugFPSPitchForceText.material        = fontAdvisory
debugFPSPitchForceText.alignment       = "CenterCenter"
debugFPSPitchForceText.init_pos		 = {pitchX, -0.04, 0} -- L/R, D/U, F/B
debugFPSPitchForceText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSPitchForceText.formats         = {"FPS Pitch Force: %f"}
debugFPSPitchForceText.element_params  = {"DEBUG_FPSPITCHFORCE"}
debugFPSPitchForceText.controllers     = {{"text_using_parameter",0,0}}
debugFPSPitchForceText.h_clip_relation  = h_clip_relations.compare
debugFPSPitchForceText.level			= 6
debugFPSPitchForceText.parent_element  = base.name
Add(debugFPSPitchForceText)

local debugPitchAccText           = CreateElement "ceStringPoly"
debugPitchAccText.name            = create_guid_string()
debugPitchAccText.material        = fontAdvisory
debugPitchAccText.alignment       = "CenterCenter"
debugPitchAccText.init_pos		 = {pitchX, -0.05, 0} -- L/R, D/U, F/B
debugPitchAccText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugPitchAccText.formats         = {"FPS Pitch Acc: %f"}
debugPitchAccText.element_params  = {"DEBUG_PITCHACC"}
debugPitchAccText.controllers     = {{"text_using_parameter",0,0}}
debugPitchAccText.h_clip_relation  = h_clip_relations.compare
debugPitchAccText.level			= 6
debugPitchAccText.parent_element  = base.name
Add(debugPitchAccText)

----------------------------------------------------------------------------------------------------
--ROLL
----------------------------------------------------------------------------------------------------

local debugRollText           = CreateElement "ceStringPoly"
debugRollText.name            = create_guid_string()
debugRollText.material        = fontAdvisory
debugRollText.alignment       = "CenterCenter"
debugRollText.init_pos		    = {rollX, 0, 0} -- L/R, D/U, F/B
debugRollText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugRollText.formats         = {"Roll: %f"}
debugRollText.element_params  = {"DEBUG_ROLL"}
debugRollText.controllers     = {{"text_using_parameter",0,0}}
debugRollText.h_clip_relation  = h_clip_relations.compare
debugRollText.level			= 6
debugRollText.parent_element  = base.name
Add(debugRollText)

local debugFPSRollText           = CreateElement "ceStringPoly"
debugFPSRollText.name            = create_guid_string()
debugFPSRollText.material        = fontAdvisory
debugFPSRollText.alignment       = "CenterCenter"
debugFPSRollText.init_pos		    = {rollX, -0.01, 0} -- L/R, D/U, F/B
debugFPSRollText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSRollText.formats         = {"FPS Roll: %f"}
debugFPSRollText.element_params  = {"DEBUG_FPSROLL"}
debugFPSRollText.controllers     = {{"text_using_parameter",0,0}}
debugFPSRollText.h_clip_relation  = h_clip_relations.compare
debugFPSRollText.level			= 6
debugFPSRollText.parent_element  = base.name
Add(debugFPSRollText)

local debugFPSRollDiffText           = CreateElement "ceStringPoly"
debugFPSRollDiffText.name            = create_guid_string()
debugFPSRollDiffText.material        = fontAdvisory
debugFPSRollDiffText.alignment       = "CenterCenter"
debugFPSRollDiffText.init_pos		 = {rollX, -0.02, 0} -- L/R, D/U, F/B
debugFPSRollDiffText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSRollDiffText.formats         = {"FPS Roll Diff: %f"}
debugFPSRollDiffText.element_params  = {"DEBUG_FPSROLLDIFF"}
debugFPSRollDiffText.controllers     = {{"text_using_parameter",0,0}}
debugFPSRollDiffText.h_clip_relation  = h_clip_relations.compare
debugFPSRollDiffText.level			= 6
debugFPSRollDiffText.parent_element  = base.name
Add(debugFPSRollDiffText)

local debugRollRotSpeed           = CreateElement "ceStringPoly"
debugRollRotSpeed.name            = create_guid_string()
debugRollRotSpeed.material        = fontAdvisory
debugRollRotSpeed.alignment       = "CenterCenter"
debugRollRotSpeed.init_pos		 = {rollX, -0.03, 0} -- L/R, D/U, F/B
debugRollRotSpeed.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugRollRotSpeed.formats         = {"FPS Roll RotSpd: %f"}
debugRollRotSpeed.element_params  = {"DEBUG_ROLLROTSPEED"}
debugRollRotSpeed.controllers     = {{"text_using_parameter",0,0}}
debugRollRotSpeed.h_clip_relation  = h_clip_relations.compare
debugRollRotSpeed.level			= 6
debugRollRotSpeed.parent_element  = base.name
Add(debugRollRotSpeed)

local debugFPSRollForceText           = CreateElement "ceStringPoly"
debugFPSRollForceText.name            = create_guid_string()
debugFPSRollForceText.material        = fontAdvisory
debugFPSRollForceText.alignment       = "CenterCenter"
debugFPSRollForceText.init_pos		 = {rollX, -0.04, 0} -- L/R, D/U, F/B
debugFPSRollForceText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSRollForceText.formats         = {"FPS Roll Force: %f"}
debugFPSRollForceText.element_params  = {"DEBUG_FPSROLLFORCE"}
debugFPSRollForceText.controllers     = {{"text_using_parameter",0,0}}
debugFPSRollForceText.h_clip_relation  = h_clip_relations.compare
debugFPSRollForceText.level			= 6
debugFPSRollForceText.parent_element  = base.name
Add(debugFPSRollForceText)


----------------------------------------------------------------------------------------------------
--YAW
----------------------------------------------------------------------------------------------------

local debugYawText           = CreateElement "ceStringPoly"
debugYawText.name            = create_guid_string()
debugYawText.material        = fontAdvisory
debugYawText.alignment       = "CenterCenter"
debugYawText.init_pos		 = {yawX, 0, 0} -- L/R, D/U, F/B
debugYawText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugYawText.formats         = {"Yaw: %f"}
debugYawText.element_params  = {"DEBUG_YAW"}
debugYawText.controllers     = {{"text_using_parameter",0,0}}
debugYawText.h_clip_relation  = h_clip_relations.compare
debugYawText.level			= 6
debugYawText.parent_element  = base.name
Add(debugYawText)

local debugFPSYawText           = CreateElement "ceStringPoly"
debugFPSYawText.name            = create_guid_string()
debugFPSYawText.material        = fontAdvisory
debugFPSYawText.alignment       = "CenterCenter"
debugFPSYawText.init_pos		 = {yawX, -0.01, 0} -- L/R, D/U, F/B
debugFPSYawText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSYawText.formats         = {"FPS Yaw: %f"}
debugFPSYawText.element_params  = {"DEBUG_FPSYAW"}
debugFPSYawText.controllers     = {{"text_using_parameter",0,0}}
debugFPSYawText.h_clip_relation  = h_clip_relations.compare
debugFPSYawText.level			= 6
debugFPSYawText.parent_element  = base.name
Add(debugFPSYawText)

local debugFPSYawDiffText           = CreateElement "ceStringPoly"
debugFPSYawDiffText.name            = create_guid_string()
debugFPSYawDiffText.material        = fontAdvisory
debugFPSYawDiffText.alignment       = "CenterCenter"
debugFPSYawDiffText.init_pos		 = {yawX, -0.02, 0} -- L/R, D/U, F/B
debugFPSYawDiffText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSYawDiffText.formats         = {"FPS Yaw Diff: %f"}
debugFPSYawDiffText.element_params  = {"DEBUG_FPSYAWDIFF"}
debugFPSYawDiffText.controllers     = {{"text_using_parameter",0,0}}
debugFPSYawDiffText.h_clip_relation  = h_clip_relations.compare
debugFPSYawDiffText.level			= 6
debugFPSYawDiffText.parent_element  = base.name
Add(debugFPSYawDiffText)

local debugYawRotSpeed           = CreateElement "ceStringPoly"
debugYawRotSpeed.name            = create_guid_string()
debugYawRotSpeed.material        = fontAdvisory
debugYawRotSpeed.alignment       = "CenterCenter"
debugYawRotSpeed.init_pos		 = {yawX, -0.03, 0} -- L/R, D/U, F/B
debugYawRotSpeed.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugYawRotSpeed.formats         = {"FPS Yaw RotSpd: %f"}
debugYawRotSpeed.element_params  = {"DEBUG_YAWROTSPEED"}
debugYawRotSpeed.controllers     = {{"text_using_parameter",0,0}}
debugYawRotSpeed.h_clip_relation  = h_clip_relations.compare
debugYawRotSpeed.level			= 6
debugYawRotSpeed.parent_element  = base.name
Add(debugYawRotSpeed)

local debugFPSYawForceText           = CreateElement "ceStringPoly"
debugFPSYawForceText.name            = create_guid_string()
debugFPSYawForceText.material        = fontAdvisory
debugFPSYawForceText.alignment       = "CenterCenter"
debugFPSYawForceText.init_pos		 = {yawX, -0.04, 0} -- L/R, D/U, F/B
debugFPSYawForceText.stringdefs      = {0.003,0.77*0.003, 0, 0} -- {size vertical, horizontal, 0, 0}
debugFPSYawForceText.formats         = {"FPS Yaw Force: %f"}
debugFPSYawForceText.element_params  = {"DEBUG_FPSYAWFORCE"}
debugFPSYawForceText.controllers     = {{"text_using_parameter",0,0}}
debugFPSYawForceText.h_clip_relation  = h_clip_relations.compare
debugFPSYawForceText.level			= 6
debugFPSYawForceText.parent_element  = base.name
Add(debugFPSYawForceText)
]]

