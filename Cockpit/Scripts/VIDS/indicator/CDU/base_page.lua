dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
local greenColor = {0,255,0,220}
local yellowColor = {255,255,0,220}
local redColor = {255,0,0,220}
local font7segment = MakeFont({used_DXUnicodeFontData = "font7segment"}, greenColor)
local center = calculateIndicatorCenterDash({-0.14,-0.582,2.553})  --- {L/R,U/D,forward/back}
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
base.element_params  = {"CB_LIGHTS_NON_FLT"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}}
Add(base)

-- FUEL DIGITAL READOUT
local posY = -0.1095
local posZ = 0.0002

local FuelAmount           = CreateElement "ceStringPoly"
FuelAmount.name            = create_guid_string()
FuelAmount.material        = font7segment
FuelAmount.alignment       = "CenterCenter"
FuelAmount.init_pos		   = {0.017, posY, posZ}
FuelAmount.stringdefs      = {0.005,0.77*0.005, 0, 0} -- {size vertical, horizontal, 0, 0}
FuelAmount.formats         = {"%4.0f"}
FuelAmount.element_params  = {"CDU_FUEL_DIGITS"}
FuelAmount.controllers     = {{"text_using_parameter",0,0}}
FuelAmount.h_clip_relation  = h_clip_relations.compare
FuelAmount.level			= 6
FuelAmount.parent_element  = base.name
Add(FuelAmount)

-- E1TGT
local E1TGT           = CreateElement "ceStringPoly"
E1TGT.name            = create_guid_string()
E1TGT.material        = font7segment
E1TGT.alignment       = "CenterCenter"
E1TGT.init_pos		   = {0.175, posY, posZ}
E1TGT.stringdefs      = {0.0045,0.75*0.005, 0, 0}  -- {size vertical, horizontal, 0, 0}
E1TGT.formats         = {"%3.0f"}
E1TGT.element_params  = {"CDU_TGT1_DIGITS"}
E1TGT.controllers     = {{"text_using_parameter",0,0}}
E1TGT.h_clip_relation = h_clip_relations.compare
E1TGT.level			  = 6
E1TGT.parent_element  = base.name
Add(E1TGT)

-- E2TGT
local E2TGT           = CreateElement "ceStringPoly"
E2TGT.name            = create_guid_string()
E2TGT.material        = font7segment
E2TGT.alignment       = "CenterCenter"
E2TGT.init_pos		   = {0.194, posY, posZ}
E2TGT.stringdefs      = {0.0045,0.75*0.005, 0, 0}  -- {size vertical, horizontal, 0, 0}
E2TGT.formats         = {"%3.0f"}
E2TGT.element_params  = {"CDU_TGT2_DIGITS"}
E2TGT.controllers     = {{"text_using_parameter",0,0}}
E2TGT.h_clip_relation = h_clip_relations.compare
E2TGT.level			  = 6
E2TGT.parent_element  = base.name
Add(E2TGT)

--N1_RPM1
local E1NG           = CreateElement "ceStringPoly"
E1NG.name            = create_guid_string()
E1NG.material        = font7segment
E1NG.alignment       = "CenterCenter"
E1NG.init_pos		   = {0.22, posY, posZ}
E1NG.stringdefs      = {0.0045,0.75*0.005, 0, 0}  -- {size vertical, horizontal, 0, 0}
E1NG.formats         = {"%3.0f"}
E1NG.element_params  = {"CDU_NG1_DIGITS"}
E1NG.controllers     = {{"text_using_parameter",0,0}}
E1NG.h_clip_relation = h_clip_relations.compare
E1NG.level			  = 6
E1NG.parent_element  = base.name
Add(E1NG)

--N1_RPM2
local E2NG           = CreateElement "ceStringPoly"
E2NG.name            = create_guid_string()
E2NG.material        = font7segment
E2NG.alignment       = "CenterCenter"
E2NG.init_pos		   = {0.237, posY, posZ}
E2NG.stringdefs      = {0.0045,0.75*0.005, 0, 0}  -- {size vertical, horizontal, 0, 0}
E2NG.formats         = {"%3.0f"}
E2NG.element_params  = {"CDU_NG2_DIGITS"}
E2NG.controllers     = {{"text_using_parameter",0,0}}
E2NG.h_clip_relation = h_clip_relations.compare
E2NG.level			  = 6
E2NG.parent_element  = base.name
Add(E2NG)

-----------------------------------------------------------------------------------------------------
--BARS
-----------------------------------------------------------------------------------------------------

local Xsize = 0.002
local Ysize = Xsize*0.58
local numSegments = 30
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

function colorize(value, redValue, yellowValue)
	local color = greenColor
	if ( value > redValue)
	then
		color = redColor
	else
		if (value > yellowValue)
		then
			color = yellowColor
		end
	end
	return color
end

-----------------------------------------------------------------------------------------------------
--FUEL
-----------------------------------------------------------------------------------------------------

local _baseXPos = 0.01
local _baseYPos = -0.0835
local _ySpacing = 0.0016--0.035

local _x = 0
for i = 0,190,1500/numSegments do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,200}}
	fuelL1.element_params  = {"CDU_FUEL_L_LOW"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 200,1500,1500/numSegments do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,1500}}
	fuelL1.element_params  = {"CDU_FUEL_L_HI"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end

local _baseXPos = 0.034
local _x = 0
for i = 0,190,1500/numSegments do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,200}}
	fuelL1.element_params  = {"CDU_FUEL_R_LOW"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 200,1500,1500/numSegments do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,1500}}
	fuelL1.element_params  = {"CDU_FUEL_R_HI"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--XMSN TEMP
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.048
local _x = 0
for i = -50,35,10 do
	local XMSNTEMP1bar		       = CreateElement "ceMeshPoly"
	XMSNTEMP1bar.name		 	   = "segment_"..i
	XMSNTEMP1bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNTEMP1bar.controllers 	   = {{"parameter_in_range",0,i,181}}
	XMSNTEMP1bar.element_params     = {"CDU_XMSNTEMP_LOW"}
	addSegment(XMSNTEMP1bar, greenColor)
	_x = _x + 1
end
for i = 40,119,5 do
	local color = greenColor
	local XMSNTEMP2bar		       = CreateElement "ceMeshPoly"
	XMSNTEMP2bar.name		 	   = "segment_"..i
	XMSNTEMP2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNTEMP2bar.controllers 	   = {{"parameter_in_range",0,i,181}}
	XMSNTEMP2bar.element_params     = {"CDU_XMSNTEMP_MID"}
	if ( i > 105) then
		color = yellowColor
	end
	addSegment(XMSNTEMP2bar, color)
	_x = _x + 1
end
for i = 120,165,10 do
	local XMSNTEMP3bar		       = CreateElement "ceMeshPoly"
	XMSNTEMP3bar.name		 	   = "segment_"..i
	XMSNTEMP3bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNTEMP3bar.controllers 	   = {{"parameter_in_range",0,i,181}}
	XMSNTEMP3bar.element_params     = {"CDU_XMSNTEMP_HI"}
	if ( i > 105) then
		color = yellowColor
	end
	addSegment(XMSNTEMP3bar, redColor)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--XMSN PRESSURE
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.0685
local _x = 0
for i = 0,27,5 do
	local XMSNPRESS1bar		       = CreateElement "ceMeshPoly"
	XMSNPRESS1bar.name		 	   = "segment_"..i
	XMSNPRESS1bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNPRESS1bar.controllers 	   = {{"parameter_in_range",0,i,30}}
	XMSNPRESS1bar.element_params     = {"CDU_XMSNPRESS_LOW"}
	addSegment(XMSNPRESS1bar, greenColor)
	_x = _x + 1
end
for i = 30,69,2.5 do
	local color = greenColor
	local XMSNPRESS2bar		       = CreateElement "ceMeshPoly"
	XMSNPRESS2bar.name		 	   = "segment_"..i
	XMSNPRESS2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNPRESS2bar.controllers 	   = {{"parameter_in_range",0,i,191}}
	XMSNPRESS2bar.element_params     = {"CDU_XMSNPRESS_MID"}
	if ( i > 65) then
		color = yellowColor
	end
	addSegment(XMSNPRESS2bar, color)
	_x = _x + 1
end
for i = 70,105,10 do
	local XMSNPRESS3bar		       = CreateElement "ceMeshPoly"
	XMSNPRESS3bar.name		 	   = "segment_"..i
	XMSNPRESS3bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNPRESS3bar.controllers 	   = {{"parameter_in_range",0,i,191}}
	XMSNPRESS3bar.element_params     = {"CDU_XMSNPRESS_HI"}
	addSegment(XMSNPRESS3bar, yellowColor)
	_x = _x + 1
end
for i = 110,180,20 do
	local XMSNPRESS4bar		       = CreateElement "ceMeshPoly"
	XMSNPRESS4bar.name		 	   = "segment_"..i
	XMSNPRESS4bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	XMSNPRESS4bar.controllers 	   = {{"parameter_in_range",0,i,191}}
	XMSNPRESS4bar.element_params     = {"CDU_XMSNPRESS_HI2"}
	color = yellowColor
	if ( i > 130) then
		color = redColor
	end
	addSegment(XMSNPRESS4bar, color)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG1 OIL TEMP
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.090
local _x = 0
for i = -50,70,10 do
	local E1OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E1OILTEMPbar.name		 	   = "segment_"..i
	E1OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E1OILTEMPbar.element_params     = {"CDU_E1OILTEMP_LOW"}
	addSegment(E1OILTEMPbar, greenColor)
	_x = _x + 1
end
for i = 75,135,5 do
	local E1OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E1OILTEMPbar.name		 	   = "segment_"..i
	E1OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E1OILTEMPbar.element_params     = {"CDU_E1OILTEMP_MID"}
	local color	               = greenColor
	if ( value > 130)
	then
		color = yellowColor
	end
	addSegment(E1OILTEMPbar, color)
	_x = _x + 1
end
for i = 150,180,10 do
	local E1OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E1OILTEMPbar.name		 	   = "segment_"..i
	E1OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E1OILTEMPbar.element_params     = {"CDU_E1OILTEMP_HI"}
	local color	               = yellowColor
	if ( value > 150)
	then
		color = redColor
	end
	addSegment(E1OILTEMPbar, color)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG2 OIL TEMP
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.1135
local _x = 0
for i = -50,70,10 do
	local E2OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E2OILTEMPbar.name		 	   = "segment_"..i
	E2OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E2OILTEMPbar.element_params     = {"CDU_E2OILTEMP_LOW"}
	addSegment(E2OILTEMPbar, greenColor)
	_x = _x + 1
end
for i = 75,135,5 do
	local E2OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E2OILTEMPbar.name		 	   = "segment_"..i
	E2OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E2OILTEMPbar.element_params     = {"CDU_E2OILTEMP_MID"}
	local color	               = greenColor
	if ( value > 130)
	then
		color = yellowColor
	end
	addSegment(E2OILTEMPbar, color)
	_x = _x + 1
end
for i = 150,180,10 do
	local E2OILTEMPbar		       = CreateElement "ceMeshPoly"
	local value                	   = i
	E2OILTEMPbar.name		 	   = "segment_"..i
	E2OILTEMPbar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2OILTEMPbar.controllers 	   = {{"parameter_in_range",0,value,181}}
	E2OILTEMPbar.element_params     = {"CDU_E2OILTEMP_HI"}
	local color	               = yellowColor
	if ( value > 150)
	then
		color = redColor
	end
	addSegment(E2OILTEMPbar, color)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG1 OIL PRESSURE
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.129
local _x = 0
for i = 10,39,5 do
	local E1PRESS1bar		       = CreateElement "ceMeshPoly"
	E1PRESS1bar.name		 	   = "segment_"..i
	E1PRESS1bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1PRESS1bar.controllers 	   = {{"parameter_in_range",0,i,50}}
	E1PRESS1bar.element_params     = {"CDU_E1OILPRESS_LOW"}
	color = redColor
	if ( i > 20) then
		color = yellowColor
	end
	addSegment(E1PRESS1bar, color)
	_x = _x + 1
end
for i = 40,44,2.5 do
	local E1PRESS2bar		       = CreateElement "ceMeshPoly"
	E1PRESS2bar.name		 	   = "segment_"..i
	E1PRESS2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1PRESS2bar.controllers 	   = {{"parameter_in_range",0,i,50}}
	E1PRESS2bar.element_params     = {"CDU_E1OILPRESS_MID"}
	addSegment(E1PRESS2bar, yellowColor)
	_x = _x + 1
end
for i = 45,89,2.5 do
	local E1PRESS2bar		       = CreateElement "ceMeshPoly"
	E1PRESS2bar.name		 	   = "segment_"..i
	E1PRESS2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1PRESS2bar.controllers 	   = {{"parameter_in_range",0,i,141}}
	E1PRESS2bar.element_params     = {"CDU_E1OILPRESS_MID2"}
	addSegment(E1PRESS2bar, greenColor)
	_x = _x + 1
end
for i = 90,129,10 do
	local E1PRESS3bar		       = CreateElement "ceMeshPoly"
	E1PRESS3bar.name		 	   = "segment_"..i
	E1PRESS3bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E1PRESS3bar.controllers 	   = {{"parameter_in_range",0,i,141}}
	E1PRESS3bar.element_params     = {"CDU_E1OILPRESS_HI"}
	local color = greenColor
	if ( i > 100) then
		color = redColor
	end
	addSegment(E1PRESS3bar, color)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG2 OIL PRESSURE
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.152
local _x = 0
for i = 10,39,5 do
	local E2PRESS1bar		       = CreateElement "ceMeshPoly"
	E2PRESS1bar.name		 	   = "segment_"..i
	E2PRESS1bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2PRESS1bar.controllers 	   = {{"parameter_in_range",0,i,50}}
	E2PRESS1bar.element_params     = {"CDU_E2OILPRESS_LOW"}
	color = redColor
	if ( i > 20) then
		color = yellowColor
	end
	addSegment(E2PRESS1bar, color)
	_x = _x + 1
end
for i = 40,44,2.5 do
	local E2PRESS2bar		       = CreateElement "ceMeshPoly"
	E2PRESS2bar.name		 	   = "segment_"..i
	E2PRESS2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2PRESS2bar.controllers 	   = {{"parameter_in_range",0,i,50}}
	E2PRESS2bar.element_params     = {"CDU_E2OILPRESS_MID"}
	addSegment(E2PRESS2bar, yellowColor)
	_x = _x + 1
end
for i = 45,89,2.5 do
	local E2PRESS2bar		       = CreateElement "ceMeshPoly"
	E2PRESS2bar.name		 	   = "segment_"..i
	E2PRESS2bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2PRESS2bar.controllers 	   = {{"parameter_in_range",0,i,141}}
	E2PRESS2bar.element_params     = {"CDU_E2OILPRESS_MID2"}
	addSegment(E2PRESS2bar, greenColor)
	_x = _x + 1
end
for i = 90,129,10 do
	local E2PRESS3bar		       = CreateElement "ceMeshPoly"
	E2PRESS3bar.name		 	   = "segment_"..i
	E2PRESS3bar.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	E2PRESS3bar.controllers 	   = {{"parameter_in_range",0,i,141}}
	E2PRESS3bar.element_params     = {"CDU_E2OILPRESS_HI"}
	local color = greenColor
	if ( i > 100) then
		color = redColor
	end
	addSegment(E2PRESS3bar, color)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG1 TGT TEMP
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.172
local _x = 0

for i = 0,350,50 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT1_LOW"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 400,745,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT1_MED"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 750,845,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT1_HI1"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 850,945,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT1_HI2"}
	addSegment(fuelL1, redColor)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG2 TGT TEMP
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.195
local _x = 0

for i = 0,350,50 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT2_LOW"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 400,745,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT2_MED"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 750,845,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT2_HI1"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 850,945,25 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,950}}
	fuelL1.element_params  = {"CDU_TGT2_HI2"}
	addSegment(fuelL1, redColor)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG1 NG
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.2164
local _x = 0

for i = 0,35,10 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG1_LOW"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 40,67,5 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG1_MED"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 70,97,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG1_HI1"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 98,101,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG1_HI2"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 102,108,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG1_HI3"}
	addSegment(fuelL1, redColor)
	_x = _x + 1
end

-----------------------------------------------------------------------------------------------------
--ENG2 NG
-----------------------------------------------------------------------------------------------------
local _baseXPos = 0.2395
local _x = 0

for i = 0,35,10 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG2_LOW"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 40,67,5 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG2_MED"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 70,97,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG2_HI1"}
	addSegment(fuelL1, greenColor)
	_x = _x + 1
end
for i = 98,101,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG2_HI2"}
	addSegment(fuelL1, yellowColor)
	_x = _x + 1
end
for i = 102,108,2 do
	local fuelL1		   = CreateElement "ceMeshPoly"
	fuelL1.name		 	   = "segment_"..i
	fuelL1.init_pos	 	   = { _baseXPos, _baseYPos + _x*(Ysize + _ySpacing), 0.001}
	fuelL1.controllers 	   = {{"parameter_in_range",0,i,110}}
	fuelL1.element_params  = {"CDU_NG2_HI3"}
	addSegment(fuelL1, redColor)
	_x = _x + 1
end
