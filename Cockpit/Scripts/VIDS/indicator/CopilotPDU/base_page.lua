dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local greenColor = {0,255,0,220}
local yellowColor = {255,255,0,220}
local redColor = {255,0,0,220}
local h60_font_7seg = MakeFont({used_DXUnicodeFontData = "h60_font_7seg"}, greenColor)
local center = calculateIndicatorCenterDash({-0.349,-0.623,2.602}) -- {L/R,U/D,forward/back}
local rotation = {0, 0, dashRotation} -- main panel rotation roughly 22deg

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
base.material		 = MakeMaterial(nil,{3,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
base.element_params  = {"CB_NO1_AC_INST", "CB_NO1_DC_INST"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",0,0.9,1.1}}
Add(base)

-------------------------------------------------------------------------------------------
-- ENG1 TRQ TEXT
-------------------------------------------------------------------------------------------
local _posY = -0.0106
local _posZ = -0.007

local eng1TrqText           = CreateElement "ceStringPoly"
eng1TrqText.name            = create_guid_string()
eng1TrqText.material        = h60_font_7seg
eng1TrqText.alignment       = "CenterCenter"
eng1TrqText.init_pos		= {0.015, _posY, _posZ} -- L/R, D/U, F/B
eng1TrqText.stringdefs      = {0.007,0.77*0.007, 0, 0} -- {size vertical, horizontal, 0, 0}
eng1TrqText.formats         = {"%3.0f"}
eng1TrqText.element_params  = {"PDU_CPLT_E1_TRQ"}
eng1TrqText.controllers     = {{"text_using_parameter",0,0}}
eng1TrqText.h_clip_relation  = h_clip_relations.compare
eng1TrqText.level			= 6
eng1TrqText.parent_element  = base.name
Add(eng1TrqText)

-------------------------------------------------------------------------------------------
-- ENG2 TRQ TEXT
-------------------------------------------------------------------------------------------
local eng2TrqText           = CreateElement "ceStringPoly"
eng2TrqText.name            = create_guid_string()
eng2TrqText.material        = h60_font_7seg
eng2TrqText.alignment       = "CenterCenter"
eng2TrqText.init_pos		= {0.033, _posY, _posZ}
eng2TrqText.stringdefs      = {0.007,0.77*0.007, 0, 0} -- {size vertical, horizontal, 0, 0}
eng2TrqText.formats         = {"%3.0f"}
eng2TrqText.element_params  = {"PDU_CPLT_E2_TRQ"}
eng2TrqText.controllers     = {{"text_using_parameter",0,0}}
eng2TrqText.h_clip_relation  = h_clip_relations.compare
eng2TrqText.level			= 6
eng2TrqText.parent_element  = base.name
Add(eng2TrqText)


local Xsize = 0.002
local Ysize = Xsize*0.59
local numSegments = 40
function addSegment(element, color)
	element.vertices	   	= {{-Xsize , Ysize},
							   { Xsize , Ysize},
							   { Xsize ,-Ysize},
							   {-Xsize ,-Ysize}}
	element.indices	   		= {0,1,2,2,3,0}
	element.material    	= MakeMaterial(nil,color)
	element.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	element.level 			= 6
	element.parent_element 	= base.name
	Add(element)
end

-------------------------------------------------------------------------------------------
-- ENG1 RPM
-------------------------------------------------------------------------------------------
local _posX = -0.025
local _posY = -0.134
local _posZ = -0.0055
local _ySpacing = 0.0015

local _i = 0
-- E1RPM 0 to 70
for x = 0, 60, 10 do
	local E1RPM_1		       = CreateElement "ceMeshPoly"
	E1RPM_1.name		 	   = "segment_".._i
	E1RPM_1.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_1.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E1RPM_1.element_params     = {"PDU_CPLT_E1NP_LOW"}
	local color	               = redColor
	addSegment(E1RPM_1, color)
	_i = _i + 1
end

-- E1RPM 70 to 90
for x = 70, 85, 5 do
	local E1RPM_2		       = CreateElement "ceMeshPoly"
	E1RPM_2.name		 	   = "segment_".._i
	E1RPM_2.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_2.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E1RPM_2.element_params     = {"PDU_CPLT_E1NP_LOW"}
	local color	               = redColor
	addSegment(E1RPM_2, color)
	_i = _i + 1
end

-- E1RPM 90 to 95
for x = 90, 94, 1 do
	local E1RPM_3		       = CreateElement "ceMeshPoly"
	E1RPM_3.name		 	   = "segment_".._i
	E1RPM_3.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_3.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E1RPM_3.element_params     = {"PDU_CPLT_E1NP_LOW"}
	local color	               = yellowColor
	if ( x < 91)
	then
		color = redColor
	end
	addSegment(E1RPM_3, color)
	_i = _i + 1
end

-- E1RPM 95 to 101
for x = 95, 100, 1 do
	local E1RPM_4		       = CreateElement "ceMeshPoly"
	E1RPM_4.name		 	   = "segment_".._i
	E1RPM_4.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_4.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E1RPM_4.element_params     = {"PDU_CPLT_E1NP_HI"}
	local color	               = greenColor
	addSegment(E1RPM_4, color)
	_i = _i + 1
end

-- E1RPM 102 to 105
for x = 101, 104, 1 do
	local E1RPM_5		       = CreateElement "ceMeshPoly"
	E1RPM_5.name		 	   = "segment_".._i
	E1RPM_5.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_5.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E1RPM_5.element_params     = {"PDU_CPLT_E1NP_HI"}
	local color	               = yellowColor
	addSegment(E1RPM_5, color)
	_i = _i + 1
end

-- E1RPM 106 to 110
for x = 105, 109, 1 do
	local E1RPM_6		       = CreateElement "ceMeshPoly"
	E1RPM_6.name		 	   = "segment_".._i
	E1RPM_6.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_6.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E1RPM_6.element_params     = {"PDU_CPLT_E1NP_HI"}
	local color	               = redColor
	addSegment(E1RPM_6, color)
	_i = _i + 1
end

-- E1RPM 111 to 130
for x = 110, 128, 2 do
	local E1RPM_7		       = CreateElement "ceMeshPoly"
	E1RPM_7.name		 	   = "segment_".._i
	E1RPM_7.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1RPM_7.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E1RPM_7.element_params     = {"PDU_CPLT_E1NP_HI"}
	local color	               = redColor
	addSegment(E1RPM_7, color)
	_i = _i + 1
end

-------------------------------------------------------------------------------------------
-- ROTOR RPM
-------------------------------------------------------------------------------------------
local _posX = -0.018

local _i = 0
-- RRPM 0 to 70
for x = 0, 60, 10 do
	local RRPM_1		       = CreateElement "ceMeshPoly"
	RRPM_1.name		 	   = "segment_".._i
	RRPM_1.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_1.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	RRPM_1.element_params     = {"PDU_CPLT_RRPM_LOW"}
	local color	               = redColor
	addSegment(RRPM_1, color)
	_i = _i + 1
end

-- RRPM 70 to 90
for x = 70, 85, 5 do
	local RRPM_2		       = CreateElement "ceMeshPoly"
	RRPM_2.name		 	   = "segment_".._i
	RRPM_2.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_2.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	RRPM_2.element_params     = {"PDU_CPLT_RRPM_LOW"}
	local color	               = redColor
	addSegment(RRPM_2, color)
	_i = _i + 1
end

-- RRPM 90 to 95
for x = 90, 94, 1 do
	local RRPM_3		       = CreateElement "ceMeshPoly"
	RRPM_3.name		 	   = "segment_".._i
	RRPM_3.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_3.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	RRPM_3.element_params     = {"PDU_CPLT_RRPM_LOW"}
	local color	               = yellowColor
	if ( x < 91)
	then
		color = redColor
	end
	addSegment(RRPM_3, color)
	_i = _i + 1
end

-- RRPM 95 to 101
for x = 95, 100, 1 do
	local RRPM_4		       = CreateElement "ceMeshPoly"
	RRPM_4.name		 	   = "segment_".._i
	RRPM_4.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_4.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	RRPM_4.element_params     = {"PDU_CPLT_RRPM_HI"}
	local color	               = greenColor
	addSegment(RRPM_4, color)
	_i = _i + 1
end

-- RRPM 102 to 105
for x = 101, 104, 1 do
	local RRPM_5		       = CreateElement "ceMeshPoly"
	RRPM_5.name		 	   = "segment_".._i
	RRPM_5.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_5.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	RRPM_5.element_params     = {"PDU_CPLT_RRPM_HI"}
	local color	               = yellowColor
	addSegment(RRPM_5, color)
	_i = _i + 1
end

-- RRPM 106 to 110
for x = 105, 109, 1 do
	local RRPM_6		       = CreateElement "ceMeshPoly"
	RRPM_6.name		 	   = "segment_".._i
	RRPM_6.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_6.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	RRPM_6.element_params     = {"PDU_CPLT_RRPM_HI"}
	local color	               = redColor
	addSegment(RRPM_6, color)
	_i = _i + 1
end

-- RRPM 111 to 130
for x = 110, 128, 2 do
	local RRPM_7		       = CreateElement "ceMeshPoly"
	RRPM_7.name		 	   = "segment_".._i
	RRPM_7.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	RRPM_7.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	RRPM_7.element_params     = {"PDU_CPLT_RRPM_HI"}
	local color	               = redColor
	addSegment(RRPM_7, color)
	_i = _i + 1
end

-------------------------------------------------------------------------------------------
-- ENG2 RPM
-------------------------------------------------------------------------------------------
local _posX = -0.011

local _i = 0
-- E2RPM 0 to 70
for x = 0, 60, 10 do
	local E2RPM_1		       = CreateElement "ceMeshPoly"
	E2RPM_1.name		 	   = "segment_".._i
	E2RPM_1.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_1.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E2RPM_1.element_params     = {"PDU_CPLT_E2NP_LOW"}
	local color	               = redColor
	addSegment(E2RPM_1, color)
	_i = _i + 1
end

-- E2RPM 70 to 90
for x = 70, 85, 5 do
	local E2RPM_2		       = CreateElement "ceMeshPoly"
	E2RPM_2.name		 	   = "segment_".._i
	E2RPM_2.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_2.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E2RPM_2.element_params     = {"PDU_CPLT_E2NP_LOW"}
	local color	               = redColor
	addSegment(E2RPM_2, color)
	_i = _i + 1
end

-- E2RPM 90 to 95
for x = 90, 94, 1 do
	local E2RPM_3		       = CreateElement "ceMeshPoly"
	E2RPM_3.name		 	   = "segment_".._i
	E2RPM_3.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_3.controllers 	   = {{"parameter_in_range", 0, x, 96}}
	E2RPM_3.element_params     = {"PDU_CPLT_E2NP_LOW"}
	local color	               = yellowColor
	if ( x < 91)
	then
		color = redColor
	end
	addSegment(E2RPM_3, color)
	_i = _i + 1
end

-- E2RPM 95 to 101
for x = 95, 100, 1 do
	local E2RPM_4		       = CreateElement "ceMeshPoly"
	E2RPM_4.name		 	   = "segment_".._i
	E2RPM_4.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_4.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E2RPM_4.element_params     = {"PDU_CPLT_E2NP_HI"}
	local color	               = greenColor
	addSegment(E2RPM_4, color)
	_i = _i + 1
end

-- E2RPM 102 to 105
for x = 101, 104, 1 do
	local E2RPM_5		       = CreateElement "ceMeshPoly"
	E2RPM_5.name		 	   = "segment_".._i
	E2RPM_5.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_5.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E2RPM_5.element_params     = {"PDU_CPLT_E2NP_HI"}
	local color	               = yellowColor
	addSegment(E2RPM_5, color)
	_i = _i + 1
end

-- E2RPM 106 to 110
for x = 105, 109, 1 do
	local E2RPM_6		       = CreateElement "ceMeshPoly"
	E2RPM_6.name		 	   = "segment_".._i
	E2RPM_6.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_6.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E2RPM_6.element_params     = {"PDU_CPLT_E2NP_HI"}
	local color	               = redColor
	addSegment(E2RPM_6, color)
	_i = _i + 1
end

-- E2RPM 111 to 130
for x = 110, 128, 2 do
	local E2RPM_7		       = CreateElement "ceMeshPoly"
	E2RPM_7.name		 	   = "segment_".._i
	E2RPM_7.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E2RPM_7.controllers 	   = {{"parameter_in_range", 0, x, 130}}
	E2RPM_7.element_params     = {"PDU_CPLT_E2NP_HI"}
	local color	               = redColor
	addSegment(E2RPM_7, color)
	_i = _i + 1
end

-------------------------------------------------------------------------------------------
-- ENG1 TRQ BAR
-------------------------------------------------------------------------------------------

local Xsize = 0.002
local Ysize = Xsize*0.563
local _ySpacing = 0.0015
local numSegments = 40
function addSegment(element, color)
	element.vertices	   	= {{-Xsize , Ysize},
							   { Xsize , Ysize},
							   { Xsize ,-Ysize},
							   {-Xsize ,-Ysize}}
	element.indices	   		= {0,1,2,2,3,0}
	element.material    	= MakeMaterial(nil,color)
	element.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	element.level 			= 6
	element.parent_element 	= base.name
	Add(element)
end


local _posX = 0.0255
local _posY = -0.1045
local _i = 0

for x = 0, 145, 5 do
	local E1TRQ		       = CreateElement "ceMeshPoly"
	E1TRQ.name		 	   = "segment_".._i
	E1TRQ.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1TRQ.controllers 	   = {{"parameter_in_range", 0, x, 160}}
	E1TRQ.element_params   = {"PDU_CPLT_E1TRQ"}
	local color	           = greenColor
	if (x > 100) then
		color = yellowColor
	end
	if (x > 135) then
		color = redColor
	end
	addSegment(E1TRQ, color)
	_i = _i + 1
end

-------------------------------------------------------------------------------------------
-- ENG2 TRQ BAR
-------------------------------------------------------------------------------------------
local _posX = 0.0325
local _i = 0

for x = 0, 145, 5 do
	local E1TRQ		       = CreateElement "ceMeshPoly"
	E1TRQ.name		 	   = "segment_".._i
	E1TRQ.init_pos	 	   = { _posX, _posY + _i*(Ysize + _ySpacing), _posZ}
	E1TRQ.controllers 	   = {{"parameter_in_range", 0, x, 160}}
	E1TRQ.element_params   = {"PDU_CPLT_E2TRQ"}
	local color	           = greenColor
	if (x > 100) then
		color = yellowColor
	end
	if (x > 135) then
		color = redColor
	end
	addSegment(E1TRQ, color)
	_i = _i + 1
end
