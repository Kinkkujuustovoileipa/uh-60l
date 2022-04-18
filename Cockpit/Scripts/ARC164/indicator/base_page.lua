dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local advisoryColor = {220,200,160,255}
local presetsColor = {0,0,0,255}
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "14segFont"}, advisoryColor)
local fontPresets = MakeFont({used_DXUnicodeFontData = "handFont"}, presetsColor)
center = calculateIndicatorCenter({0.152,-0.9298,2.33}) -- {L/R,U/D,forward/back}
rotation = {0, 0, 81} -- main panel rotation roughly 22deg

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
Add(base)

local freq           = CreateElement "ceStringPoly"
freq.name            = create_guid_string()
freq.material        = fontAdvisory
freq.alignment       = "CenterCenter"
freq.init_pos		 = {-.0335, 0.006, 0.002} -- L/R, D/U, F/B
freq.stringdefs      = {0.007,0.79*0.009, 0, 0} -- {size vertical, horizontal, 0, 0}
freq.formats         = {"%06.0f"}
freq.element_params  = {"ARC164_FREQ", "CB_UHF_AM", "ARC164_MODE"}
freq.controllers     = {{"text_using_parameter",0,0}, {"parameter_in_range",1,0.9,1.1}, {"parameter_in_range",2,0.9,4.1}}
freq.h_clip_relation = h_clip_relations.compare
freq.level			 = 6
freq.parent_element  = base.name
Add(freq)

local preset           = CreateElement "ceStringPoly"
preset.name            = create_guid_string()
preset.material        = fontAdvisory
preset.alignment       = "CenterCenter"
preset.init_pos		   = {-0.008, 0.032, 0.0024}  -- L/R, D/U, F/B
preset.stringdefs      = {0.007,0.75*0.007, 0, 0} -- {size vertical, horizontal, 0, 0}
preset.formats         = {"%02.0f"}
preset.element_params  = {"ARC164_PRESET", "CB_UHF_AM", "ARC164_MODE", "ARC164_CH_MODE"}
preset.controllers     = {{"text_using_parameter",0,0}, {"parameter_in_range",1,0.9,1.1}, {"parameter_in_range",2,0.9,4.1}, {"parameter_in_range",3,0.9,1.1}}
preset.h_clip_relation = h_clip_relations.compare
preset.level		   = 6
preset.parent_element  = base.name
Add(preset)

function addPresetFreq(x, y, param)
    local freq           = CreateElement "ceStringPoly"
    freq.name            = create_guid_string()
    freq.material        = fontPresets
    freq.alignment       = "LeftCenter"
    freq.init_pos		   = {x, y, -0.00285}  -- L/R, D/U, F/B
    freq.stringdefs      = {0.003,0.003 * 0.65, 0.0001, 0} -- {size vertical, horizontal, 0, 0}
    freq.formats         = {"%03.3f"}
    freq.element_params  = param
    freq.controllers     = {{"text_using_parameter",0,0}}
    freq.h_clip_relation = h_clip_relations.compare
    freq.level		   = 6
    freq.parent_element  = base.name
    Add(freq)
end

local freqX = -0.086
local freqXSpacing = 0.020
local freqY = 0.0485
local freqYSpacing = 0.0040

for i=1,20 do
    local x = freqX
    local modY = 0
    if i > 13 then
        x = freqX + freqXSpacing * 2
        modY = freqYSpacing * 14
    elseif i > 6 then
        x = freqX + freqXSpacing
        modY = freqYSpacing * 7
    end
    addPresetFreq(x, (freqY - (freqYSpacing * i)) + modY, {"ARC164_PRESET_"..i})
end