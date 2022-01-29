shape_name  	 			 = "uh-60l_cockpit"
draw_pilot					 = true

seat_points = 
{
	[1] = {point = {3.0 - 2.971, -0.35 + 0.55,  0.666045},},
	[2] = {point = {3.0 - 2.971, -0.35 + 0.55,  -0.666045},},
	[3] = {point = {1.85, -0.45, -0.626045, absolute_position = true }, vAngle = 0, hAngle = 90,},
	[4] = {point = {1.85, -0.45, 0.626045, absolute_position = true }, vAngle = 0, hAngle = -90,},
}

day_texture_set_value   = 0.0
night_texture_set_value = 0.1
dusk_border					 = 0.4
external_model_canopy_arg	 = 38
--render_debug_info = false

local controllers = LoRegisterPanelControls()

function addParamController(argNum, controllerString, input, output)
	local controller	= CreateGauge("parameter")
	controller.arg_number = argNum
	controller.input      = input or {0.0, 1.0}
	controller.output     = output or {0.0, 1.0}
	controller.parameter_name = controllerString
	return controller
end

-- FAT passed directly from FM
freeAirTemp = addParamController(1, "FAT_GAUGE", {-70,-60,-50,-40,-30,-20,-10,0,10,20,30,40,50}, {-1,-0.85,-0.70,-0.53,-0.37,-0.21,-0.4,0.13,0.29,0.47,0.64,0.81,1})

IASneedle							= CreateGauge()
IASneedle.arg_number				= 100
IASneedle.input						= {0,10.2889,25.7222,51.4444,64.3055,77.1667,102.889,128.611} -- knots to m/s
IASneedle.output					= {0,0.05,0.15,0.4,0.5,0.6,0.8,1}
IASneedle.controller				= controllers.base_gauge_IndicatedAirSpeed --m/s

VVneedle							= CreateGauge()
VVneedle.arg_number					= 103
VVneedle.input						= {-30.48,-20.32,-10.16,-5.08,0,5.08,10.16,20.32,30.48} --1000,2000,4000,6000 ft/min converted to m/s
VVneedle.output						= {-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1}
VVneedle.controller					= controllers.base_gauge_VerticalVelocity --m/s

-- PILOT BARO ALTIMETER
pilotBaroAlt100s              = addParamController(60, "PILOT_BAROALT_100")
pilotBaroAlt100s              = addParamController(61, "PILOT_BAROALT_1000")
pilotBaroAlt100s              = addParamController(62, "PILOT_BAROALT_10000")
pilotBaroAlt100s              = addParamController(64, "PILOT_BAROALT_ADJ_Nxxx")
pilotBaroAlt100s              = addParamController(65, "PILOT_BAROALT_ADJ_xNxx")
pilotBaroAlt100s              = addParamController(66, "PILOT_BAROALT_ADJ_xxNx")
pilotBaroAlt100s              = addParamController(67, "PILOT_BAROALT_ADJ_xxxN")
pilotBaroAlt100s              = addParamController(68, "PILOT_BAROALT_ENCODER_FLAG")

-- COPILOT ALTIMETER
copilotBaroAlt100s            = addParamController(70, "COPILOT_BAROALT_100")
copilotBaroAlt1000s           = addParamController(71, "COPILOT_BAROALT_1000")
copilotBaroAlt10000s          = addParamController(72, "COPILOT_BAROALT_10000")
copilotPressureScale1         = addParamController(74, "COPILOT_BAROALT_ADJ_Nxxx")
copilotPressureScale2         = addParamController(75, "COPILOT_BAROALT_ADJ_xNxx")
copilotPressureScale3         = addParamController(76, "COPILOT_BAROALT_ADJ_xxNx")
copilotPressureScale4         = addParamController(77, "COPILOT_BAROALT_ADJ_xxxN")
copilotBaroAltEncoderFlag     = addParamController(78, "COPILOT_BAROALT_ENCODER_FLAG")

-- MISC
parkingBrakeHandle			= addParamController(81, "PARKING_BRAKE_HANDLE")
pilotPTT					= addParamController(82, "PILOT_PTT")

-- AHRU
ahruIndSlave	= addParamController(95, "AHRU_IND_SLAVE")
ahruIndDG		= addParamController(96, "AHRU_IND_DG")
ahruIndCcal		= addParamController(97, "AHRU_IND_CCAL")
ahruIndFail		= addParamController(98, "AHRU_IND_FAIL")
ahruIndAln		= addParamController(99, "AHRU_IND_ALIGN")

-- MAG COMPASS
MagCompassBrg						= CreateGauge("parameter")
MagCompassBrg.arg_number			= 120
MagCompassBrg.input				    = {0,360}
MagCompassBrg.output				= {0,1}
MagCompassBrg.parameter_name		= "CURRENT_HDG"

MagCompassBank						= CreateGauge("parameter")
MagCompassBank.arg_number			= 121
MagCompassBank.input				= {-1,1}
MagCompassBank.output				= {-1,1}
MagCompassBank.parameter_name		= "MAGCOMPASS_BANK"

MagCompassPitch						= CreateGauge("parameter")
MagCompassPitch.arg_number			= 122
MagCompassPitch.input				= {-1,1}
MagCompassPitch.output				= {-1,1}
MagCompassPitch.parameter_name		= "MAGCOMPASS_PITCH"

--PILOT HSI
pilotHSICompass					= CreateGauge("parameter")
pilotHSICompass.arg_number		= 132
pilotHSICompass.input			= {0,360}
pilotHSICompass.output			= {0,1}
pilotHSICompass.parameter_name	= "PILOT_HSI_COMPASS"

pilotHSIHdgBug					= CreateGauge("parameter")
pilotHSIHdgBug.arg_number		= 133
pilotHSIHdgBug.input			= {0,360}
pilotHSIHdgBug.output			= {0,1}
pilotHSIHdgBug.parameter_name	= "PILOT_HSI_HDGBUG"

pilotHSINo1Bug					= CreateGauge("parameter")
pilotHSINo1Bug.arg_number		= 134
pilotHSINo1Bug.input		    = {0,360}
pilotHSINo1Bug.output			= {0,1}
pilotHSINo1Bug.parameter_name	= "PILOT_HSI_NO1BUG"

pilotHSINo2Bug					= CreateGauge("parameter")
pilotHSINo2Bug.arg_number		= 135
pilotHSINo2Bug.input		    = {0,360}
pilotHSINo2Bug.output			= {0,1}
pilotHSINo2Bug.parameter_name	= "PILOT_HSI_NO2BUG"

pilotHSICrsBug					= CreateGauge("parameter")
pilotHSICrsBug.arg_number		= 136
pilotHSICrsBug.input            = {0,360}
pilotHSICrsBug.output			= {0,1}
pilotHSICrsBug.parameter_name	= "PILOT_HSI_CRSBUG"

pilotHSICrsDev					= CreateGauge("parameter")
pilotHSICrsDev.arg_number		= 137
pilotHSICrsDev.input            = {-1,0,1}
pilotHSICrsDev.output			= {-1,0,1}
pilotHSICrsDev.parameter_name	= "PILOT_HSI_CRSDEV"

pilotHSIVorArrow				= CreateGauge("parameter")
pilotHSIVorArrow.arg_number		= 138
pilotHSIVorArrow.input          = {-1,0,1}
pilotHSIVorArrow.output			= {-1,0,1}
pilotHSIVorArrow.parameter_name	= "PILOT_HSI_VORARROW"

pilotHSIDistDrum1				    = CreateGauge("parameter")
pilotHSIDistDrum1.arg_number        = 139
pilotHSIDistDrum1.input             = {0,1}
pilotHSIDistDrum1.output	        = {0,1}
pilotHSIDistDrum1.parameter_name    = "PILOT_HSI_DISTDRUM1"

pilotHSIDistDrum2					= CreateGauge("parameter")
pilotHSIDistDrum2.arg_number		= 140
pilotHSIDistDrum2.input             = {0,1}
pilotHSIDistDrum2.output			= {0,1}
pilotHSIDistDrum2.parameter_name	= "PILOT_HSI_DISTDRUM2"

pilotHSIDistDrum3				    = CreateGauge("parameter")
pilotHSIDistDrum3.arg_number		= 141
pilotHSIDistDrum3.input             = {0,1}
pilotHSIDistDrum3.output			= {0,1}
pilotHSIDistDrum3.parameter_name	= "PILOT_HSI_DISTDRUM3"

pilotHSIDistDrum4					= CreateGauge("parameter")
pilotHSIDistDrum4.arg_number		= 142
pilotHSIDistDrum4.input             = {0,1}
pilotHSIDistDrum4.output			= {0,1}
pilotHSIDistDrum4.parameter_name	= "PILOT_HSI_DISTDRUM4"

pilotHSICrsDrum1					= CreateGauge("parameter")
pilotHSICrsDrum1.arg_number		    = 143
pilotHSICrsDrum1.input              = {0,1}
pilotHSICrsDrum1.output			    = {0,1}
pilotHSICrsDrum1.parameter_name	    = "PILOT_HSI_CRSDRUM1"

pilotHSICrsDrum2					= CreateGauge("parameter")
pilotHSICrsDrum2.arg_number		    = 144
pilotHSICrsDrum2.input              = {0,1}
pilotHSICrsDrum2.output			    = {0,1}
pilotHSICrsDrum2.parameter_name	    = "PILOT_HSI_CRSDRUM2"

pilotHSICrsDrum3					= CreateGauge("parameter")
pilotHSICrsDrum3.arg_number		    = 145
pilotHSICrsDrum3.input              = {0,1}
pilotHSICrsDrum3.output			    = {0,1}
pilotHSICrsDrum3.parameter_name	    = "PILOT_HSI_CRSDRUM3"

pilotHSIHdgFlag					    = CreateGauge("parameter")
pilotHSIHdgFlag.arg_number		    = 146
pilotHSIHdgFlag.input               = {0,1}
pilotHSIHdgFlag.output			    = {0,1}
pilotHSIHdgFlag.parameter_name	    = "PILOT_HSI_HDGFLAG"

pilotHSINavFlag					    = CreateGauge("parameter")
pilotHSINavFlag.arg_number		    = 147
pilotHSINavFlag.input               = {0,1}
pilotHSINavFlag.output			    = {0,1}
pilotHSINavFlag.parameter_name	    = "PILOT_HSI_NAVFLAG"

pilotHSIDistFlag					= CreateGauge("parameter")
pilotHSIDistFlag.arg_number		    = 148
pilotHSIDistFlag.input              = {0,1}
pilotHSIDistFlag.output			    = {0,1}
pilotHSIDistFlag.parameter_name	    = "PILOT_HSI_DISTFLAG"

--COPILOT HSI
copilotHSICompass					= CreateGauge("parameter")
copilotHSICompass.arg_number		= 152
copilotHSICompass.input			    = {0,360}
copilotHSICompass.output			= {0,1}
copilotHSICompass.parameter_name	= "COPILOT_HSI_COMPASS"

copilotHSIHdgBug				= CreateGauge("parameter")
copilotHSIHdgBug.arg_number		= 153
copilotHSIHdgBug.input			= {0,360}
copilotHSIHdgBug.output			= {0,1}
copilotHSIHdgBug.parameter_name	= "COPILOT_HSI_HDGBUG"

copilotHSINo1Bug				= CreateGauge("parameter")
copilotHSINo1Bug.arg_number		= 154
copilotHSINo1Bug.input		    = {0,360}
copilotHSINo1Bug.output			= {0,1}
copilotHSINo1Bug.parameter_name	= "COPILOT_HSI_NO1BUG"

copilotHSINo2Bug				= CreateGauge("parameter")
copilotHSINo2Bug.arg_number		= 155
copilotHSINo2Bug.input		    = {0,360}
copilotHSINo2Bug.output			= {0,1}
copilotHSINo2Bug.parameter_name	= "COPILOT_HSI_NO2BUG"

copilotHSICrsBug				= CreateGauge("parameter")
copilotHSICrsBug.arg_number		= 156
copilotHSICrsBug.input          = {0,360}
copilotHSICrsBug.output			= {0,1}
copilotHSICrsBug.parameter_name	= "COPILOT_HSI_CRSBUG"

copilotHSICrsDev				= CreateGauge("parameter")
copilotHSICrsDev.arg_number		= 157
copilotHSICrsDev.input          = {-1,0,1}
copilotHSICrsDev.output			= {-1,0,1}
copilotHSICrsDev.parameter_name	= "COPILOT_HSI_CRSDEV"

copilotHSIVorArrow				    = CreateGauge("parameter")
copilotHSIVorArrow.arg_number		= 158
copilotHSIVorArrow.input            = {-1,0,1}
copilotHSIVorArrow.output			= {-1,0,1}
copilotHSIVorArrow.parameter_name	= "COPILOT_HSI_VORARROW"

copilotHSIDistDrum1				    = CreateGauge("parameter")
copilotHSIDistDrum1.arg_number      = 159
copilotHSIDistDrum1.input           = {0,1}
copilotHSIDistDrum1.output	        = {0,1}
copilotHSIDistDrum1.parameter_name  = "COPILOT_HSI_DISTDRUM1"

copilotHSIDistDrum2					= CreateGauge("parameter")
copilotHSIDistDrum2.arg_number		= 160
copilotHSIDistDrum2.input           = {0,1}
copilotHSIDistDrum2.output			= {0,1}
copilotHSIDistDrum2.parameter_name	= "COPILOT_HSI_DISTDRUM2"

copilotHSIDistDrum3				    = CreateGauge("parameter")
copilotHSIDistDrum3.arg_number		= 161
copilotHSIDistDrum3.input           = {0,1}
copilotHSIDistDrum3.output			= {0,1}
copilotHSIDistDrum3.parameter_name	= "COPILOT_HSI_DISTDRUM3"

copilotHSIDistDrum4					= CreateGauge("parameter")
copilotHSIDistDrum4.arg_number		= 162
copilotHSIDistDrum4.input           = {0,1}
copilotHSIDistDrum4.output			= {0,1}
copilotHSIDistDrum4.parameter_name	= "COPILOT_HSI_DISTDRUM4"

copilotHSICrsDrum1					= CreateGauge("parameter")
copilotHSICrsDrum1.arg_number		= 163
copilotHSICrsDrum1.input            = {0,1}
copilotHSICrsDrum1.output			= {0,1}
copilotHSICrsDrum1.parameter_name	= "COPILOT_HSI_CRSDRUM1"

copilotHSICrsDrum2					= CreateGauge("parameter")
copilotHSICrsDrum2.arg_number		= 164
copilotHSICrsDrum2.input            = {0,1}
copilotHSICrsDrum2.output			= {0,1}
copilotHSICrsDrum2.parameter_name	= "COPILOT_HSI_CRSDRUM2"

copilotHSICrsDrum3					= CreateGauge("parameter")
copilotHSICrsDrum3.arg_number		= 165
copilotHSICrsDrum3.input            = {0,1}
copilotHSICrsDrum3.output			= {0,1}
copilotHSICrsDrum3.parameter_name	= "COPILOT_HSI_CRSDRUM3"

copilotHSIHdgFlag					= CreateGauge("parameter")
copilotHSIHdgFlag.arg_number		= 166
copilotHSIHdgFlag.input             = {0,1}
copilotHSIHdgFlag.output			= {0,1}
copilotHSIHdgFlag.parameter_name	= "COPILOT_HSI_HDGFLAG"

copilotHSINavFlag					= CreateGauge("parameter")
copilotHSINavFlag.arg_number		= 167
copilotHSINavFlag.input             = {0,1}
copilotHSINavFlag.output			= {0,1}
copilotHSINavFlag.parameter_name	= "COPILOT_HSI_NAVFLAG"

copilotHSIDistFlag					= CreateGauge("parameter")
copilotHSIDistFlag.arg_number		= 168
copilotHSIDistFlag.input            = {0,1}
copilotHSIDistFlag.output			= {0,1}
copilotHSIDistFlag.parameter_name	= "COPILOT_HSI_DISTFLAG"

-- PILOT AN/APN-209 RADAR ALTIMETER
apn209PilotAltNeedle					= CreateGauge("parameter")
apn209PilotAltNeedle.arg_number		    = 173
apn209PilotAltNeedle.input			    = {0, 100, 200, 500, 1000, 1500, 1510}
apn209PilotAltNeedle.output			    = {0, 0.25, 0.5, 0.65, 0.8, 0.95, 1}
apn209PilotAltNeedle.parameter_name	    = "PILOT_APN209_NEEDLE"

apn209PilotAltDigit1					= CreateGauge("parameter")
apn209PilotAltDigit1.arg_number		    = 174
apn209PilotAltDigit1.input			    = {0,10}
apn209PilotAltDigit1.output			    = {0,1}
apn209PilotAltDigit1.parameter_name	    = "PILOT_APN209_DIGIT1"

apn209PilotAltDigit2					= CreateGauge("parameter")
apn209PilotAltDigit2.arg_number		    = 175
apn209PilotAltDigit2.input			    = {0,10}
apn209PilotAltDigit2.output			    = {0,1}
apn209PilotAltDigit2.parameter_name	    = "PILOT_APN209_DIGIT2"

apn209PilotAltDigit3					= CreateGauge("parameter")
apn209PilotAltDigit3.arg_number		    = 176
apn209PilotAltDigit3.input			    = {0,10}
apn209PilotAltDigit3.output			    = {0,1}
apn209PilotAltDigit3.parameter_name	    = "PILOT_APN209_DIGIT3"

apn209PilotAltDigit4					= CreateGauge("parameter")
apn209PilotAltDigit4.arg_number		    = 177
apn209PilotAltDigit4.input			    = {0,10}
apn209PilotAltDigit4.output			    = {0,1}
apn209PilotAltDigit4.parameter_name	    = "PILOT_APN209_DIGIT4"

apn209PilotLoBug					= CreateGauge("parameter")
apn209PilotLoBug.arg_number		    = 178
apn209PilotLoBug.input			    = {0, 100, 200, 500, 1000, 1500}
apn209PilotLoBug.output			    = {0, 0.25, 0.5, 0.65, 0.8, 1}
apn209PilotLoBug.parameter_name	    = "PILOT_APN209_LOBUG"

apn209PilotHiBug					= CreateGauge("parameter")
apn209PilotHiBug.arg_number		    = 179
apn209PilotHiBug.input			    = {0, 100, 200, 500, 1000, 1500}
apn209PilotHiBug.output			    = {0, 0.25, 0.5, 0.65, 0.8, 1}
apn209PilotHiBug.parameter_name	    = "PILOT_APN209_HIBUG"

apn209PilotLoLight					= CreateGauge("parameter")
apn209PilotLoLight.arg_number		= 180
apn209PilotLoLight.input			= {0,1}
apn209PilotLoLight.output			= {0,1}
apn209PilotLoLight.parameter_name	= "PILOT_APN209_LOLIGHT"

apn209PilotHiLight					= CreateGauge("parameter")
apn209PilotHiLight.arg_number		= 181
apn209PilotHiLight.input			= {0,1}
apn209PilotHiLight.output			= {0,1}
apn209PilotHiLight.parameter_name	= "PILOT_APN209_HILIGHT"

apn209PilotFlag					= CreateGauge("parameter")
apn209PilotFlag.arg_number		= 182
apn209PilotFlag.input			= {0,1}
apn209PilotFlag.output			= {0,1}
apn209PilotFlag.parameter_name	= "PILOT_APN209_FLAG"

-- COPILOT AN/APN-209 RADAR ALTIMETER
apn209CopilotAltNeedle					= CreateGauge("parameter")
apn209CopilotAltNeedle.arg_number		= 186
apn209CopilotAltNeedle.input			= {0, 100, 200, 500, 1000, 1500, 1510}
apn209CopilotAltNeedle.output			= {0, 0.25, 0.5, 0.65, 0.8, 0.95, 1}
apn209CopilotAltNeedle.parameter_name	= "COPILOT_APN209_NEEDLE"

apn209CopilotAltDigit1					= CreateGauge("parameter")
apn209CopilotAltDigit1.arg_number		= 187
apn209CopilotAltDigit1.input			= {0,10}
apn209CopilotAltDigit1.output			= {0,1}
apn209CopilotAltDigit1.parameter_name	= "COPILOT_APN209_DIGIT1"

apn209CopilotAltDigit2					= CreateGauge("parameter")
apn209CopilotAltDigit2.arg_number		= 188
apn209CopilotAltDigit2.input			= {0,10}
apn209CopilotAltDigit2.output			= {0,1}
apn209CopilotAltDigit2.parameter_name	= "COPILOT_APN209_DIGIT2"

apn209CopilotAltDigit3					= CreateGauge("parameter")
apn209CopilotAltDigit3.arg_number		= 189
apn209CopilotAltDigit3.input			= {0,10}
apn209CopilotAltDigit3.output			= {0,1}
apn209CopilotAltDigit3.parameter_name	= "COPILOT_APN209_DIGIT3"

apn209CopilotAltDigit4					= CreateGauge("parameter")
apn209CopilotAltDigit4.arg_number		= 190
apn209CopilotAltDigit4.input			= {0,10}
apn209CopilotAltDigit4.output			= {0,1}
apn209CopilotAltDigit4.parameter_name	= "COPILOT_APN209_DIGIT4"

apn209CopilotLoBug					= CreateGauge("parameter")
apn209CopilotLoBug.arg_number		= 191
apn209CopilotLoBug.input			= {0, 100, 200, 500, 1000, 1500}
apn209CopilotLoBug.output			= {0, 0.25, 0.5, 0.65, 0.8, 1}
apn209CopilotLoBug.parameter_name	= "COPILOT_APN209_LOBUG"

apn209CopilotHiBug					= CreateGauge("parameter")
apn209CopilotHiBug.arg_number		= 192
apn209CopilotHiBug.input			= {0, 100, 200, 500, 1000, 1500}
apn209CopilotHiBug.output			= {0, 0.25, 0.5, 0.65, 0.8, 1}
apn209CopilotHiBug.parameter_name	= "COPILOT_APN209_HIBUG"

apn209CopilotLoLight				= CreateGauge("parameter")
apn209CopilotLoLight.arg_number		= 193
apn209CopilotLoLight.input			= {0,1}
apn209CopilotLoLight.output			= {0,1}
apn209CopilotLoLight.parameter_name	= "COPILOT_APN209_LOLIGHT"

apn209CopilotHiLight				= CreateGauge("parameter")
apn209CopilotHiLight.arg_number		= 194
apn209CopilotHiLight.input			= {0,1}
apn209CopilotHiLight.output			= {0,1}
apn209CopilotHiLight.parameter_name	= "COPILOT_APN209_HILIGHT"

apn209CopilotFlag					= CreateGauge("parameter")
apn209CopilotFlag.arg_number		= 195
apn209CopilotFlag.input			    = {0,1}
apn209CopilotFlag.output			= {0,1}
apn209CopilotFlag.parameter_name	= "COPILOT_APN209_FLAG"

-- LIGHTING 200 - 250
PLTInstLights					= CreateGauge("parameter")
PLTInstLights.arg_number		= 201
PLTInstLights.input			    = {0,1}
PLTInstLights.output			= {0,1}
PLTInstLights.parameter_name	= "LIGHTING_PLT_INST"

CPLTInstLights					= CreateGauge("parameter")
CPLTInstLights.arg_number		= 202
CPLTInstLights.input			= {0,1}
CPLTInstLights.output			= {0,1}
CPLTInstLights.parameter_name	= "LIGHTING_CPLT_INST"

NonFltInstLights				= CreateGauge("parameter")
NonFltInstLights.arg_number		= 203
NonFltInstLights.input			= {0,1}
NonFltInstLights.output			= {0,1}
NonFltInstLights.parameter_name	= "LIGHTING_NON_FLT_INST"

UpperConsoleLights					= CreateGauge("parameter")
UpperConsoleLights.arg_number		= 204
UpperConsoleLights.input			= {0,1}
UpperConsoleLights.output			= {0,1}
UpperConsoleLights.parameter_name	= "LIGHTING_UPPER_CONSOLE"

LowerConsoleLights					= CreateGauge("parameter")
LowerConsoleLights.arg_number		= 205
LowerConsoleLights.input			= {0,1}
LowerConsoleLights.output			= {0,1}
LowerConsoleLights.parameter_name	= "LIGHTING_LOWER_CONSOLE"

LightedSwitches					= CreateGauge("parameter")
LightedSwitches.arg_number		= 206
LightedSwitches.input			= {0,1}
LightedSwitches.output			= {0,1}
LightedSwitches.parameter_name	= "LIGHTING_SWITCHES"

pltRdrAltLts				= CreateGauge("parameter")
pltRdrAltLts.arg_number		= 207
pltRdrAltLts.input			= {0,1}
pltRdrAltLts.output			= {0.1,1}
pltRdrAltLts.parameter_name	= "LIGHTING_PLT_RDR_ALT"

cpltRdrAltLts					= CreateGauge("parameter")
cpltRdrAltLts.arg_number		= 208
cpltRdrAltLts.input				= {0,1}
cpltRdrAltLts.output			= {0.1,1}
cpltRdrAltLts.parameter_name	= "LIGHTING_CPLT_RDR_ALT"

GlareshieldLights			        = CreateGauge("parameter")
GlareshieldLights.arg_number		= 210
GlareshieldLights.input			    = {0,1}
GlareshieldLights.output			= {0,1}
GlareshieldLights.parameter_name	= "LIGHTING_GLARESHIELD"

magCompassLights			    = CreateGauge("parameter")
magCompassLights.arg_number		= 211
magCompassLights.input			= {0,1}
magCompassLights.output			= {0,1}
magCompassLights.parameter_name	= "LIGHTING_MAGCOMPASS"

-- CIS MODE LIGHTS
cisHdgOnLight		= addParamController(212, "LIGHTING_CIS_HDG_ON")
cisNavOnLight		= addParamController(213, "LIGHTING_CIS_NAV_ON")
cisAltOnLight		= addParamController(214, "LIGHTING_CIS_ALT_ON")
pltCisDplrLight		= addParamController(215, "LIGHTING_CIS_PLT_DPLRGPS")
pltCisVorLight		= addParamController(216, "LIGHTING_CIS_PLT_VOR")
pltCisILSLight		= addParamController(217, "LIGHTING_CIS_PLT_ILS")
pltCisBackCrsLight	= addParamController(218, "LIGHTING_CIS_PLT_BACKCRS")
pltCisFMHomeLight	= addParamController(219, "LIGHTING_CIS_PLT_FMHOME")
pltCisTRNorm		= addParamController(220, "LIGHTING_CIS_PLT_TRNORM")
pltCisTRAlt			= addParamController(221, "LIGHTING_CIS_PLT_TRALT")
pltCisCrsHdgPlt		= addParamController(222, "LIGHTING_CIS_PLT_CRSHDGPLT")
pltCisCrsHdgCplt	= addParamController(223, "LIGHTING_CIS_PLT_CRSHDGCPLT")
pltCisGyroNorm		= addParamController(224, "LIGHTING_CIS_PLT_GYRONORM")
pltCisGyroAlt		= addParamController(225, "LIGHTING_CIS_PLT_GYROALT")
pltCisBrg2ADF		= addParamController(226, "LIGHTING_CIS_PLT_BRG2ADF")
pltCisVBrg2VOR		= addParamController(227, "LIGHTING_CIS_PLT_BRG2VOR")
cpltCisDplrLight	= addParamController(228, "LIGHTING_CIS_CPLT_DPLRGPS")
cpltCisVorLight		= addParamController(229, "LIGHTING_CIS_CPLT_VOR")
cpltCisILSLight		= addParamController(230, "LIGHTING_CIS_CPLT_ILS")
cpltCisBackCrsLight	= addParamController(231, "LIGHTING_CIS_CPLT_BACKCRS")
cpltCisFMHomeLight	= addParamController(232, "LIGHTING_CIS_CPLT_FMHOME")
cpltCisTRNorm		= addParamController(233, "LIGHTING_CIS_CPLT_TRNORM")
cpltCisTRAlt		= addParamController(234, "LIGHTING_CIS_CPLT_TRALT")
cpltCisCrsHdgPlt	= addParamController(235, "LIGHTING_CIS_CPLT_CRSHDGPLT")
cpltCisCrsHdgCplt	= addParamController(236, "LIGHTING_CIS_CPLT_CRSHDGCPLT")
cpltCisGyroNorm		= addParamController(237, "LIGHTING_CIS_CPLT_GYRONORM")
cpltCisGyroAlt		= addParamController(238, "LIGHTING_CIS_CPLT_GYROALT")
cpltCisBrg2ADF		= addParamController(239, "LIGHTING_CIS_CPLT_BRG2ADF")
cpltCisVBrg2VOR		= addParamController(240, "LIGHTING_CIS_CPLT_BRG2VOR")

-- AFCS LIGHTS
afcBoostLight		= addParamController(241, "LIGHTING_AFCS_BOOST")
afcSAS1Light		= addParamController(242, "LIGHTING_AFCS_SAS1")
afcSAS2Light		= addParamController(243, "LIGHTING_AFCS_SAS2")
afcTrimLight		= addParamController(244, "LIGHTING_AFCS_TRIM")
afcFPSLight			= addParamController(245, "LIGHTING_AFCS_FPS")
afcStabLight		= addParamController(246, "LIGHTING_AFCS_STABAUTO")

-- COCKPIT DOME LTS
domeLightBlue		= addParamController(275, "LIGHTING_DOME_BLUE")
domeLightWhite		= addParamController(276, "LIGHTING_DOME_WHITE")

-- MISC PANEL LIGHTS
--miscFuelIndTestLight	= addParamController(246, "LIGHTING_AFCS_STABAUTO") -- NOT YET IMPLEMENTED
miscTailWheelLockLight	= addParamController(294, "LIGHTING_MISC_TAILWHEELLOCK")
--miscGyroEffectLight		= addParamController(246, "LIGHTING_AFCS_STABAUTO") -- NOT YET IMPLEMENTED

-- CAP & MCP LAMPS
capBrightness		= addParamController(309, "CAP_BRIGHTNESS", {0,1}, {0,0.9})

mcpEng1Out              = addParamController(310, "DISPLAY_MCP_1ENGOUT")
mcpEng2Out              = addParamController(311, "DISPLAY_MCP_2ENGOUT")
mcpFire                 = addParamController(312, "DISPLAY_MCP_FIRE")
mcpMasterCaution        = addParamController(313, "DISPLAY_MCP_MC")
mcpLowRPM               = addParamController(314, "DISPLAY_MCP_LOWROTORRPM")
capFuel1Low             = addParamController(315, "DISPLAY_CAP_1FUELLOW")
capGen1                 = addParamController(316, "DISPLAY_CAP_1GEN")
capGen2                 = addParamController(317, "DISPLAY_CAP_2GEN")
capFuel2Low             = addParamController(318, "DISPLAY_CAP_2FUELLOW")
capFuelPress1           = addParamController(319, "DISPLAY_CAP_1FUELPRESS")
capGenBrg1              = addParamController(320, "DISPLAY_CAP_1GENBRG")
capGenBrg2              = addParamController(321, "DISPLAY_CAP_2GENBRG")
capFuelPress2           = addParamController(322, "DISPLAY_CAP_2FUELPRESS")
capEngOilPress1         = addParamController(323, "DISPLAY_CAP_1ENGOILPRESS")
capConv1                = addParamController(324, "DISPLAY_CAP_1CONV")
capConv2                = addParamController(325, "DISPLAY_CAP_2CONV")
capEngOilPress2         = addParamController(326, "DISPLAY_CAP_2ENGOILPRESS")
capEngOilTemp1          = addParamController(327, "DISPLAY_CAP_1ENGOILTEMP")
capAcEssBus             = addParamController(328, "DISPLAY_CAP_ACESSBUSOFF")
capDcEssBus             = addParamController(329, "DISPLAY_CAP_DCESSBUSOFF")
capEngOilTemp2          = addParamController(330, "DISPLAY_CAP_2ENGOILTEMP")
capEng1Chip             = addParamController(331, "DISPLAY_CAP_1ENGCHIP")
capBattLow              = addParamController(332, "DISPLAY_CAP_BATTLOW")
capBattFault            = addParamController(333, "DISPLAY_CAP_BATTFAULT")
capEng2Chip             = addParamController(334, "DISPLAY_CAP_2ENGCHIP")
capFuelFltr1            = addParamController(335, "DISPLAY_CAP_1FUELFILTERBYPASS")
capGustLock             = addParamController(336, "DISPLAY_CAP_GUSTLOCK")
capPitchBias            = addParamController(337, "DISPLAY_CAP_PITCHBIASFAIL")
capFuelFltr2            = addParamController(338, "DISPLAY_CAP_2FUELFILTERBYPASS")
capEng1Starter          = addParamController(339, "DISPLAY_CAP_1ENGSTARTER")
capOilFltr1             = addParamController(340, "DISPLAY_CAP_1OILFILTERBYPASS")
capOilFltr2             = addParamController(341, "DISPLAY_CAP_2OILFILTERBYPASS")
capEng2Starter          = addParamController(342, "DISPLAY_CAP_2ENGSTARTER")
capPriServo1            = addParamController(343, "DISPLAY_CAP_1PRISERVOPRESS")
capHydPump1             = addParamController(344, "DISPLAY_CAP_1HYDPUMP")
capHydPump2             = addParamController(345, "DISPLAY_CAP_2HYDPUMP")
capPriServo2            = addParamController(346, "DISPLAY_CAP_2PRISERVOPRESS")
capTailRtrQuad          = addParamController(347, "DISPLAY_CAP_TAILROTORQUADRANT")
capIrcmInop             = addParamController(348, "DISPLAY_CAP_IRCMINOP")
capAuxFuel              = addParamController(349, "DISPLAY_CAP_AUXFUEL")
capTailRtrServo1        = addParamController(350, "DISPLAY_CAP_1TAILRTRSERVO")
capMainXmsnOilTemp      = addParamController(351, "DISPLAY_CAP_MAINXMSNOILTEMP")
capIntXmsnOilTemp       = addParamController(352, "DISPLAY_CAP_INTXMSNOILTEMP")
capTailXmsnOilTemp      = addParamController(353, "DISPLAY_CAP_TAILXMSNOILTEMP")
capApuOilTemp           = addParamController(354, "DISPLAY_CAP_APUOILTEMPHI")
capBoostServo           = addParamController(355, "DISPLAY_CAP_BOOSTSERVOOFF")
capStab                 = addParamController(356, "DISPLAY_CAP_STABILATOR")
capSAS                  = addParamController(357, "DISPLAY_CAP_SASOFF")
capTrim                 = addParamController(358, "DISPLAY_CAP_TRIMFAIL")
capLftPitot             = addParamController(359, "DISPLAY_CAP_LEFTPITOTHEAT")
capFPS                  = addParamController(360, "DISPLAY_CAP_FLTPATHSTAB")
capIFF                  = addParamController(361, "DISPLAY_CAP_IFF")
capRtPitot              = addParamController(362, "DISPLAY_CAP_RIGHTPITOTHEAT")
capLftChipInput         = addParamController(363, "DISPLAY_CAP_CHIPINPUTMDLLH")
capChipIntXmsn          = addParamController(364, "DISPLAY_CAP_CHIPINTXMSN")
capChipTailXmsn         = addParamController(365, "DISPLAY_CAP_CHIPTAILXMSN")
capRtChipInput          = addParamController(366, "DISPLAY_CAP_CHIPINPUTMDLRH")
capLftChipAccess        = addParamController(367, "DISPLAY_CAP_CHIPACCESSMDLLH")
capChipMainSump         = addParamController(368, "DISPLAY_CAP_MAINMDLSUMP")
capApuFail              = addParamController(369, "DISPLAY_CAP_APUFAIL")
capRtChipAccess         = addParamController(370, "DISPLAY_CAP_CHIPACCESSMDLRH")
capMrDeIceFault         = addParamController(371, "DISPLAY_CAP_MRDEICEFAIL")
capMrDeIceFail          = addParamController(372, "DISPLAY_CAP_MRDEICEFAULT")
capTRDeIceFail          = addParamController(373, "DISPLAY_CAP_TRDEICEFAIL")
capIce                  = addParamController(374, "DISPLAY_CAP_ICEDETECTED")
capXmsnOilPress         = addParamController(375, "DISPLAY_CAP_MAINXMSNOILPRESS")
capRsvr1Low             = addParamController(376, "DISPLAY_CAP_1RSVRLOW")
capRsvr2Low             = addParamController(377, "DISPLAY_CAP_2RSVRLOW")
capBackupRsvrLow        = addParamController(378, "DISPLAY_CAP_BACKUPRSVRLOW")
capEng1AntiIce          = addParamController(379, "DISPLAY_CAP_1ENGANTIICEON")
capEng1InletAntiIce     = addParamController(380, "DISPLAY_CAP_1ENGINLETANTIICEON")
capEng2InletAntiIce     = addParamController(381, "DISPLAY_CAP_2ENGINLETANTIICEON")
capEng2AntiIce          = addParamController(382, "DISPLAY_CAP_2ENGANTIICEON")
capApuOn                = addParamController(383, "DISPLAY_CAP_APU")
capApuGen               = addParamController(384, "DISPLAY_CAP_APUGENON")
capBoostPumpOn          = addParamController(385, "DISPLAY_CAP_PRIMEBOOSTPUMPON")
capBackUpPumpOn         = addParamController(386, "DISPLAY_CAP_BACKUPPUMPON")
capApuAccum             = addParamController(387, "DISPLAY_CAP_APUACCUMLOW")
capSearchLt             = addParamController(388, "DISPLAY_CAP_SEARCHLIGHTON")
capLdgLt                = addParamController(389, "DISPLAY_CAP_LANDINGLIGHTON")
capTailRtrServo2        = addParamController(390, "DISPLAY_CAP_2TAILRTRSERVOON")
capHookOpen             = addParamController(391, "DISPLAY_CAP_CARGOHOOKOPEN")
capHookArmed            = addParamController(392, "DISPLAY_CAP_HOOKARMED")
capGPS                  = addParamController(393, "DISPLAY_CAP_GPSPOSALERT")
capParkingBrake         = addParamController(394, "DISPLAY_CAP_PARKINGBRAKEON")
capExtPwr               = addParamController(395, "DISPLAY_CAP_EXTPWRCONNECTED")
capBlank                = addParamController(396, "DISPLAY_CAP_BLANK")

--PILOT VSI
pltVSIPitch								= CreateGauge("parameter")
pltVSIPitch.arg_number					= 420
pltVSIPitch.input						= {-math.rad(90),0, math.rad(90)}
pltVSIPitch.output						= {-1,0,1}
pltVSIPitch.parameter_name				= "PILOT_VSI_PITCH"

pltVSIRoll								= CreateGauge("parameter")
pltVSIRoll.arg_number					= 421
pltVSIRoll.input						= {-math.pi, math.pi}
pltVSIRoll.output						= {-1, 1}
pltVSIRoll.parameter_name				= "PILOT_VSI_ROLL"

pltVSISlip								= CreateGauge("parameter")
pltVSISlip.arg_number					= 422
pltVSISlip.input						= {-1, 1}
pltVSISlip.output						= {-1, 1}
pltVSISlip.parameter_name				= "AVS7_SLIP"

pltVSIRollCmdBar					    = CreateGauge("parameter")
pltVSIRollCmdBar.arg_number		    	= 423
pltVSIRollCmdBar.input			    	= {-1,0,1}
pltVSIRollCmdBar.output			    	= {-1,0,1}
pltVSIRollCmdBar.parameter_name	    	= "PILOT_VSI_ROLL_CMD_BAR"

pltVSIPitchCmdBar					    = CreateGauge("parameter")
pltVSIPitchCmdBar.arg_number		    = 424
pltVSIPitchCmdBar.input			    	= {-1,0,1}
pltVSIPitchCmdBar.output			    = {-1,0,1}
pltVSIPitchCmdBar.parameter_name	    = "PILOT_VSI_PITCH_CMD_BAR"

pltVSICollectiveCmdBar					= CreateGauge("parameter")
pltVSICollectiveCmdBar.arg_number		= 425
pltVSICollectiveCmdBar.input			= {-1,0,1}
pltVSICollectiveCmdBar.output			= {-1,0,1}
pltVSICollectiveCmdBar.parameter_name	= "PILOT_VSI_COLLECTIVE_CMD_BAR"

pltVSITurnRateIndicator				    = CreateGauge("parameter")
pltVSITurnRateIndicator.arg_number		= 426
pltVSITurnRateIndicator.input			= {-1,0,1}
pltVSITurnRateIndicator.output			= {-1,0,1}
pltVSITurnRateIndicator.parameter_name	= "PILOT_VSI_TURN_RATE_IND"

pltVSITrackErrorIndicator					= CreateGauge("parameter")
pltVSITrackErrorIndicator.arg_number		= 427
pltVSITrackErrorIndicator.input				= {-1,0,1}
pltVSITrackErrorIndicator.output			= {-1,0,1}
pltVSITrackErrorIndicator.parameter_name	= "PILOT_VSI_TRACK_ERROR_IND"

pltVSIGlideSlopeIndicator				    = CreateGauge("parameter")
pltVSIGlideSlopeIndicator.arg_number		= 428
pltVSIGlideSlopeIndicator.input				= {-1,0,1}
pltVSIGlideSlopeIndicator.output			= {-1,0,1}
pltVSIGlideSlopeIndicator.parameter_name	= "PILOT_VSI_GLIDE_SLOPE_IND"

pltVSICMDFlag				    = CreateGauge("parameter")
pltVSICMDFlag.arg_number		= 429
pltVSICMDFlag.input				= {0,1}
pltVSICMDFlag.output			= {0,1}
pltVSICMDFlag.parameter_name	= "PILOT_VSI_CMD_FLAG"

pltVSIATTFlag				    = CreateGauge("parameter")
pltVSIATTFlag.arg_number		= 430
pltVSIATTFlag.input				= {0,1}
pltVSIATTFlag.output			= {0,1}
pltVSIATTFlag.parameter_name	= "PILOT_VSI_ATT_FLAG"

pltVSINAVFlag				    = CreateGauge("parameter")
pltVSINAVFlag.arg_number		= 431
pltVSINAVFlag.input				= {0,1}
pltVSINAVFlag.output			= {0,1}
pltVSINAVFlag.parameter_name	= "PILOT_VSI_NAV_FLAG"

pltVSIGSFlag				    = CreateGauge("parameter")
pltVSIGSFlag.arg_number			= 432
pltVSIGSFlag.input				= {0,1}
pltVSIGSFlag.output				= {0,1}
pltVSIGSFlag.parameter_name		= "PILOT_VSI_GS_FLAG"

-- COPILOT VSI
cpltVSIPitch							= CreateGauge("parameter")
cpltVSIPitch.arg_number					= 433
cpltVSIPitch.input						= {-math.rad(90),0, math.rad(90)}
cpltVSIPitch.output						= {-1,0,1}
cpltVSIPitch.parameter_name				= "COPILOT_VSI_PITCH"

cpltVSIRoll								= CreateGauge("parameter")
cpltVSIRoll.arg_number					= 434
cpltVSIRoll.input						= {-math.pi, math.pi}
cpltVSIRoll.output						= {-1, 1}
cpltVSIRoll.parameter_name				= "COPILOT_VSI_ROLL"

cpltVSISlip								= CreateGauge("parameter")
cpltVSISlip.arg_number					= 435
cpltVSISlip.input						= {-1, 1}
cpltVSISlip.output						= {-1, 1}
cpltVSISlip.parameter_name				= "AVS7_SLIP"

cpltVSIADIRollCmdBar					= CreateGauge("parameter")
cpltVSIADIRollCmdBar.arg_number		    = 436
cpltVSIADIRollCmdBar.input			    = {-1,0,1}
cpltVSIADIRollCmdBar.output			    = {-1,0,1}
cpltVSIADIRollCmdBar.parameter_name	    = "COPILOT_VSI_ROLL_CMD_BAR"

cpltVSIADIPitchCmdBar					= CreateGauge("parameter")
cpltVSIADIPitchCmdBar.arg_number		= 437
cpltVSIADIPitchCmdBar.input			    = {-1,0,1}
cpltVSIADIPitchCmdBar.output			= {-1,0,1}
cpltVSIADIPitchCmdBar.parameter_name	= "COPILOT_VSI_PITCH_CMD_BAR"

cpltVSIADICollectiveCmdBar					= CreateGauge("parameter")
cpltVSIADICollectiveCmdBar.arg_number		= 438
cpltVSIADICollectiveCmdBar.input			= {-1,0,1}
cpltVSIADICollectiveCmdBar.output			= {-1,0,1}
cpltVSIADICollectiveCmdBar.parameter_name	= "COPILOT_VSI_COLLECTIVE_CMD_BAR"

cpltVSIADITurnRateIndicator				    = CreateGauge("parameter")
cpltVSIADITurnRateIndicator.arg_number		= 439
cpltVSIADITurnRateIndicator.input			= {-1,0,1}
cpltVSIADITurnRateIndicator.output			= {-1,0,1}
cpltVSIADITurnRateIndicator.parameter_name	= "COPILOT_VSI_TURN_RATE_IND"

cpltVSIADITrackErrorIndicator				    = CreateGauge("parameter")
cpltVSIADITrackErrorIndicator.arg_number		= 440
cpltVSIADITrackErrorIndicator.input				= {-1,0,1}
cpltVSIADITrackErrorIndicator.output			= {-1,0,1}
cpltVSIADITrackErrorIndicator.parameter_name	= "COPILOT_VSI_TRACK_ERROR_IND"

cpltVSIADIGlideSlopeIndicator				    = CreateGauge("parameter")
cpltVSIADIGlideSlopeIndicator.arg_number		= 441
cpltVSIADIGlideSlopeIndicator.input				= {-1,0,1}
cpltVSIADIGlideSlopeIndicator.output			= {-1,0,1}
cpltVSIADIGlideSlopeIndicator.parameter_name	= "COPILOT_VSI_GLIDE_SLOPE_IND"

cpltVSIADICMDFlag				    = CreateGauge("parameter")
cpltVSIADICMDFlag.arg_number		= 442
cpltVSIADICMDFlag.input				= {0,1}
cpltVSIADICMDFlag.output			= {0,1}
cpltVSIADICMDFlag.parameter_name	= "COPILOT_VSI_CMD_FLAG"

cpltVSIADIATTFlag				    = CreateGauge("parameter")
cpltVSIADIATTFlag.arg_number		= 443
cpltVSIADIATTFlag.input				= {0,1}
cpltVSIADIATTFlag.output			= {0,1}
cpltVSIADIATTFlag.parameter_name	= "COPILOT_VSI_ATT_FLAG"

cpltVSIADINAVFlag				    = CreateGauge("parameter")
cpltVSIADINAVFlag.arg_number		= 444
cpltVSIADINAVFlag.input				= {0,1}
cpltVSIADINAVFlag.output			= {0,1}
cpltVSIADINAVFlag.parameter_name	= "COPILOT_VSI_NAV_FLAG"

cpltVSIADIGSFlag				    = CreateGauge("parameter")
cpltVSIADIGSFlag.arg_number			= 445
cpltVSIADIGSFlag.input				= {0,1}
cpltVSIADIGSFlag.output				= {0,1}
cpltVSIADIGSFlag.parameter_name		= "COPILOT_VSI_GS_FLAG"

pduPltOverspeed1  = addParamController(450, "PDU_PLT_OVERSPEED1")
pduPltOverspeed2  = addParamController(451, "PDU_PLT_OVERSPEED2")
pduPltOverspeed3  = addParamController(452, "PDU_PLT_OVERSPEED3")
pduCpltOverspeed2 = addParamController(453, "PDU_CPLT_OVERSPEED1")
pduCpltOverspeed3 = addParamController(454, "PDU_CPLT_OVERSPEED2")
pduCpltOverspeed3 = addParamController(455, "PDU_CPLT_OVERSPEED3")

-- M130 CM System
cmFlareCounterTens	= addParamController(554, "M130_FLARECOUNTER_TENS")
cmFlareCounterOnes	= addParamController(555, "M130_FLARECOUNTER_ONES")
cmChaffCounterTens	= addParamController(556, "M130_CHAFFCOUNTER_TENS")
cmChaffCounterOnes	= addParamController(557, "M130_CHAFFCOUNTER_ONES")
cmArmedLight		= addParamController(558, "M130_ARMED_LIGHT")

pilotVSILtGA				    = CreateGauge("parameter")
pilotVSILtGA.arg_number			= 980
pilotVSILtGA.input				= {0,1}
pilotVSILtGA.output				= {0,1}
pilotVSILtGA.parameter_name		= ""

pilotVSILtDH				    = CreateGauge("parameter")
pilotVSILtDH.arg_number			= 981
pilotVSILtDH.input				= {0,1}
pilotVSILtDH.output				= {0,1}
pilotVSILtDH.parameter_name		= "PILOT_APN209_LOLIGHT"

pilotVSILtMB				    = CreateGauge("parameter")
pilotVSILtMB.arg_number			= 982
pilotVSILtMB.input				= {0,1}
pilotVSILtMB.output				= {0,1}
pilotVSILtMB.parameter_name		= ""

copilotVSILtGA				    = CreateGauge("parameter")
copilotVSILtGA.arg_number		= 983
copilotVSILtGA.input			= {0,1}
copilotVSILtGA.output			= {0,1}
copilotVSILtGA.parameter_name	= ""

copilotVSILtDH				    = CreateGauge("parameter")
copilotVSILtDH.arg_number		= 984
copilotVSILtDH.input			= {0,1}
copilotVSILtDH.output			= {0,1}
copilotVSILtDH.parameter_name	= "COPILOT_APN209_LOLIGHT"

copilotVSILtMB				    = CreateGauge("parameter")
copilotVSILtMB.arg_number		= 985
copilotVSILtMB.input			= {0,1}
copilotVSILtMB.output			= {0,1}
copilotVSILtMB.parameter_name	= ""

StabInd					= CreateGauge("parameter")
StabInd.arg_number		= 3406
StabInd.input			= {-1,1}
StabInd.output			= {-1,1}
StabInd.parameter_name	= "STABIND"

StabIndFlag					= CreateGauge("parameter")
StabIndFlag.arg_number		= 3407
StabIndFlag.input			= {0,1}
StabIndFlag.output			= {0,1}
StabIndFlag.parameter_name	= "STABINDFLAG"

-- Pilot door, cockpit window animation
PilotDoor                   = CreateGauge("parameter")
PilotDoor.arg_number		= 1001
PilotDoor.input			    = {0,1}
PilotDoor.output			= {0,1}
PilotDoor.parameter_name	= "DOOR_PLT"

-- ARN-147 dials
ARN147MHz100s                = CreateGauge("parameter")
ARN147MHz100s.arg_number		= 654
ARN147MHz100s.input			= {0,1}
ARN147MHz100s.output			= {0,1}
ARN147MHz100s.parameter_name	= "ARN147_MHZ100S"

ARN147MHz10s                = CreateGauge("parameter")
ARN147MHz10s.arg_number		= 655
ARN147MHz10s.input			= {0,1}
ARN147MHz10s.output			= {0,1}
ARN147MHz10s.parameter_name	= "ARN147_MHZ10S"

ARN147MHz1s                 = CreateGauge("parameter")
ARN147MHz1s.arg_number		= 656
ARN147MHz1s.input			= {0,1}
ARN147MHz1s.output			= {0,1}
ARN147MHz1s.parameter_name	= "ARN147_MHZ1S"

ARN147KHz100s                = CreateGauge("parameter")
ARN147KHz100s.arg_number	 = 657
ARN147KHz100s.input			 = {0,1}
ARN147KHz100s.output		 = {0,1}
ARN147KHz100s.parameter_name = "ARN147_KHZ100S"

ARN147KHz10s                 = CreateGauge("parameter")
ARN147KHz10s.arg_number		 = 658
ARN147KHz10s.input			 = {0,1}
ARN147KHz10s.output			 = {0,1}
ARN147KHz10s.parameter_name	 = "ARN147_KHZ10S"

ARN147KHz1s                 = CreateGauge("parameter")
ARN147KHz1s.arg_number		 = 659
ARN147KHz1s.input			 = {0,1}
ARN147KHz1s.output			 = {0,1}
ARN147KHz1s.parameter_name	 = "ARN147_KHZ1S"

pltDoorGlass = addParamController(1201, "PLT_DOOR_GLASS")
cpltDoorGlass = addParamController(1202, "CPLT_DOOR_GLASS")
lGnrDoorGlass = addParamController(1203, "L_GNR_DOOR_GLASS")
rGnrDoorGlass = addParamController(1204, "R_GNR_DOOR_GLASS")
lCargoDoorGlass = addParamController(1205, "L_CARGO_DOOR_GLASS")
rCargoDoorGlass = addParamController(1206, "R_CARGO_DOOR_GLASS")

need_to_be_closed = true -- close lua state after initialization

--dofile(LockOn_Options.common_script_path.."tools.lua")

--[[ available functions

 --base_gauge_RadarAltitude
 --base_gauge_BarometricAltitude
 --base_gauge_AngleOfAttack
 --base_gauge_AngleOfSlide
 --base_gauge_VerticalVelocity
 --base_gauge_TrueAirSpeed
 --base_gauge_IndicatedAirSpeed
 --base_gauge_MachNumber
 --base_gauge_VerticalAcceleration --Ny
 --base_gauge_HorizontalAcceleration --Nx
 --base_gauge_LateralAcceleration --Nz
 --base_gauge_RateOfRoll
 --base_gauge_RateOfYaw
 --base_gauge_RateOfPitch
 --base_gauge_Roll
 --base_gauge_MagneticHeading
 --base_gauge_Pitch
 --base_gauge_Heading
 --base_gauge_EngineLeftFuelConsumption
 --base_gauge_EngineRightFuelConsumption
 --base_gauge_EngineLeftTemperatureBeforeTurbine
 --base_gauge_EngineRightTemperatureBeforeTurbine
 --base_gauge_EngineLeftRPM
 --base_gauge_EngineRightRPM
 --base_gauge_WOW_RightMainLandingGear
 --base_gauge_WOW_LeftMainLandingGear
 --base_gauge_WOW_NoseLandingGear
 --base_gauge_RightMainLandingGearDown
 --base_gauge_LeftMainLandingGearDown
 --base_gauge_NoseLandingGearDown
 --base_gauge_RightMainLandingGearUp
 --base_gauge_LeftMainLandingGearUp
 --base_gauge_NoseLandingGearUp
 --base_gauge_LandingGearHandlePos
 --base_gauge_StickRollPosition
 --base_gauge_StickPitchPosition
 --base_gauge_RudderPosition
 --base_gauge_ThrottleLeftPosition
 --base_gauge_ThrottleRightPosition
 --base_gauge_CanopyPos
 --base_gauge_CanopyState
 --base_gauge_FlapsRetracted
 --base_gauge_SpeedBrakePos
 --base_gauge_FlapsPos
 --base_gauge_TotalFuelWeight
--]]
