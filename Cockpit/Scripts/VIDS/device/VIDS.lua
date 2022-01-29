dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.1  
make_default_activity(update_time_step)

local cduTestState = 0
local pilotPduTestState = 0
local copilotPduTestState = 0

local overspeed1 = 0
local overspeed2 = 0
local overspeed3 = 0

local digitUpdateInterval = 0.5
local canUpdateDigits = false
local lastTime = 0

-- Power
local pduPowerState = 0
local cpduPowerState = 0
local cduPowerState = 0

-- FM Params
local E1NP = get_param_handle("E1_NP")
local E2NP = get_param_handle("E2_NP")
local RRPM = get_param_handle("RRPM")
local E1TRQ = get_param_handle("E1_TRQ")
local E2TRQ = get_param_handle("E2_TRQ")

-- Pilot PDU Params
local paramPltPDU_e1Trq_digits = get_param_handle("PDU_PLT_E1_TRQ")
local paramPltPDU_e2Trq_digits = get_param_handle("PDU_PLT_E2_TRQ")

local PDU_PLT_E1NP_LOW = get_param_handle("PDU_PLT_E1NP_LOW")
local PDU_PLT_E1NP_HI = get_param_handle("PDU_PLT_E1NP_HI")

local PDU_PLT_E2NP_LOW = get_param_handle("PDU_PLT_E2NP_LOW")
local PDU_PLT_E2NP_HI = get_param_handle("PDU_PLT_E2NP_HI")

local PDU_PLT_RRPM_LOW = get_param_handle("PDU_PLT_RRPM_LOW")
local PDU_PLT_RRPM_HI = get_param_handle("PDU_PLT_RRPM_HI")

local PDU_PLT_E1TRQ = get_param_handle("PDU_PLT_E1TRQ")
local PDU_PLT_E2TRQ = get_param_handle("PDU_PLT_E2TRQ")

PDU_PLT_E1NP_LOW:set(E1NP:get())
PDU_PLT_E1NP_HI:set(E1NP:get())

PDU_PLT_E2NP_LOW:set(E2NP:get())
PDU_PLT_E2NP_HI:set(E2NP:get())

PDU_PLT_RRPM_LOW:set(RRPM:get())
PDU_PLT_RRPM_HI:set(RRPM:get())

PDU_PLT_E1TRQ:set(E1TRQ:get())
PDU_PLT_E2TRQ:set(E2TRQ:get())

local paramPltOverspeedLt1 = get_param_handle("PDU_PLT_OVERSPEED1")
local paramPltOverspeedLt2 = get_param_handle("PDU_PLT_OVERSPEED2")
local paramPltOverspeedLt3 = get_param_handle("PDU_PLT_OVERSPEED3")

-- Copilot PDU Params
local paramCpltPDU_e1Trq_digits = get_param_handle("PDU_CPLT_E1_TRQ")
local paramCpltPDU_e2Trq_digits = get_param_handle("PDU_CPLT_E2_TRQ")

local paramCpltPDU_e1np_low = get_param_handle("PDU_CPLT_E1NP_LOW")
local paramCpltPDU_e1np_hi = get_param_handle("PDU_CPLT_E1NP_HI")

local paramCpltPDU_e2np_low = get_param_handle("PDU_CPLT_E2NP_LOW")
local paramCpltPDU_e2np_hi = get_param_handle("PDU_CPLT_E2NP_HI")

local paramCpltPDU_rrpm_low = get_param_handle("PDU_CPLT_RRPM_LOW")
local paramCpltPDU_rrpm_hi = get_param_handle("PDU_CPLT_RRPM_HI")

local paramCpltPDU_e1trq = get_param_handle("PDU_CPLT_E1TRQ")
local paramCpltPDU_e2trq = get_param_handle("PDU_CPLT_E2TRQ")

paramCpltPDU_e1np_low:set(E1NP:get())
paramCpltPDU_e1np_hi:set(E1NP:get())

paramCpltPDU_e2np_low:set(E2NP:get())
paramCpltPDU_e2np_hi:set(E2NP:get())

paramCpltPDU_rrpm_low:set(RRPM:get())
paramCpltPDU_rrpm_hi:set(RRPM:get())

paramCpltPDU_e1trq:set(E1TRQ:get())
paramCpltPDU_e2trq:set(E2TRQ:get())

local paramCpltOverspeedLt1 = get_param_handle("PDU_CPLT_OVERSPEED1")
local paramCpltOverspeedLt2 = get_param_handle("PDU_CPLT_OVERSPEED2")
local paramCpltOverspeedLt3 = get_param_handle("PDU_CPLT_OVERSPEED3")

-- CDU Params
local CDU_XMSNTEMP_LOW = get_param_handle("CDU_XMSNTEMP_LOW")
local CDU_XMSNTEMP_MID = get_param_handle("CDU_XMSNTEMP_MID")
local CDU_XMSNTEMP_HI = get_param_handle("CDU_XMSNTEMP_HI")
local XMSN_TEMP = get_param_handle("XMSN_TEMP")

local CDU_E1OILTEMP_LOW = get_param_handle("CDU_E1OILTEMP_LOW")
local CDU_E1OILTEMP_MID = get_param_handle("CDU_E1OILTEMP_MID")
local CDU_E1OILTEMP_HI = get_param_handle("CDU_E1OILTEMP_HI")
local E1_OILTEMP = get_param_handle("E1_OILTEMP")

local CDU_E2OILTEMP_LOW = get_param_handle("CDU_E2OILTEMP_LOW")
local CDU_E2OILTEMP_MID = get_param_handle("CDU_E2OILTEMP_MID")
local CDU_E2OILTEMP_HI = get_param_handle("CDU_E2OILTEMP_HI")
local E2_OILTEMP = get_param_handle("E2_OILTEMP")

local CDU_XMSNPRESS_LOW = get_param_handle("CDU_XMSNPRESS_LOW")
local CDU_XMSNPRESS_MID = get_param_handle("CDU_XMSNPRESS_MID")
local CDU_XMSNPRESS_HI = get_param_handle("CDU_XMSNPRESS_HI")
local CDU_XMSNPRESS_HI2 = get_param_handle("CDU_XMSNPRESS_HI2")
local XMSN_PRESS = get_param_handle("XMSN_PRESS")

local CDU_E1OILPRESS_LOW = get_param_handle("CDU_E1OILPRESS_LOW")
local CDU_E1OILPRESS_MID = get_param_handle("CDU_E1OILPRESS_MID")
local CDU_E1OILPRESS_MID2 = get_param_handle("CDU_E1OILPRESS_MID2")
local CDU_E1OILPRESS_HI = get_param_handle("CDU_E1OILPRESS_HI")
local E1_OILPRESS = get_param_handle("E1_OILPRESS")

local CDU_E2OILPRESS_LOW = get_param_handle("CDU_E2OILPRESS_LOW")
local CDU_E2OILPRESS_MID = get_param_handle("CDU_E2OILPRESS_MID")
local CDU_E2OILPRESS_MID2 = get_param_handle("CDU_E2OILPRESS_MID2")
local CDU_E2OILPRESS_HI = get_param_handle("CDU_E2OILPRESS_HI")
local E2_OILPRESS = get_param_handle("E2_OILPRESS")


CDU_XMSNTEMP_LOW:set(XMSN_TEMP:get())
CDU_XMSNTEMP_MID:set(XMSN_TEMP:get())
CDU_XMSNTEMP_HI:set(XMSN_TEMP:get())

CDU_E1OILTEMP_LOW:set(E1_OILTEMP:get())
CDU_E1OILTEMP_MID:set(E1_OILTEMP:get())
CDU_E1OILTEMP_HI:set(E1_OILTEMP:get())

CDU_E2OILTEMP_LOW:set(E2_OILTEMP:get())
CDU_E2OILTEMP_MID:set(E2_OILTEMP:get())
CDU_E2OILTEMP_HI:set(E2_OILTEMP:get())

CDU_XMSNPRESS_LOW:set(XMSN_PRESS:get())
CDU_XMSNPRESS_MID:set(XMSN_PRESS:get())
CDU_XMSNPRESS_HI:set(XMSN_PRESS:get())
CDU_XMSNPRESS_HI2:set(XMSN_PRESS:get())

CDU_E1OILPRESS_LOW:set(E1_OILPRESS:get())
CDU_E1OILPRESS_MID:set(E1_OILPRESS:get())
CDU_E1OILPRESS_MID2:set(E1_OILPRESS:get())
CDU_E1OILPRESS_HI:set(E1_OILPRESS:get())

CDU_E2OILPRESS_LOW:set(E2_OILPRESS:get())
CDU_E2OILPRESS_MID:set(E2_OILPRESS:get())
CDU_E2OILPRESS_MID2:set(E2_OILPRESS:get())
CDU_E2OILPRESS_HI:set(E2_OILPRESS:get())

-- TODO fix the mess above this line!
local paramFuelTotal = get_param_handle("CURRENT_FUELT")
local paramFuelL = get_param_handle("CURRENT_FUEL_L")
local paramFuelR = get_param_handle("CURRENT_FUEL_R")
local paramTgt1 = get_param_handle("E1_TGT")
local paramTgt2 = get_param_handle("E2_TGT")
local paramNg1 = get_param_handle("E1_NG")
local paramNg2 = get_param_handle("E2_NG")

local paramCDUFuelDigits = get_param_handle("CDU_FUEL_DIGITS")
local paramCDUTgt1Digits = get_param_handle("CDU_TGT1_DIGITS")
local paramCDUTgt2Digits = get_param_handle("CDU_TGT2_DIGITS")
local paramCDUNg1Digits = get_param_handle("CDU_NG1_DIGITS")
local paramCDUNg2Digits = get_param_handle("CDU_NG2_DIGITS")

local paramCDUFuelL_Low = get_param_handle("CDU_FUEL_L_LOW")
local paramCDUFuelL_Hi = get_param_handle("CDU_FUEL_L_HI")
local paramCDUFuelR_Low = get_param_handle("CDU_FUEL_R_LOW")
local paramCDUFuelR_Hi = get_param_handle("CDU_FUEL_R_HI")

local paramCDUTGT1Low = get_param_handle("CDU_TGT1_LOW")
local paramCDUTGT1Med = get_param_handle("CDU_TGT1_MED")
local paramCDUTGT1Hi1 = get_param_handle("CDU_TGT1_HI1")
local paramCDUTGT1Hi2 = get_param_handle("CDU_TGT1_HI2")

local paramCDUTGT2Low = get_param_handle("CDU_TGT2_LOW")
local paramCDUTGT2Med = get_param_handle("CDU_TGT2_MED")
local paramCDUTGT2Hi1 = get_param_handle("CDU_TGT2_HI1")
local paramCDUTGT2Hi2 = get_param_handle("CDU_TGT2_HI2")

local paramCDUNG1Low = get_param_handle("CDU_NG1_LOW")
local paramCDUNG1Mid = get_param_handle("CDU_NG1_MED")
local paramCDUNG1Hi1 = get_param_handle("CDU_NG1_HI1")
local paramCDUNG1Hi2 = get_param_handle("CDU_NG1_HI2")
local paramCDUNG1Hi3 = get_param_handle("CDU_NG1_HI3")

local paramCDUNG2Low = get_param_handle("CDU_NG2_LOW")
local paramCDUNG2Mid = get_param_handle("CDU_NG2_MED")
local paramCDUNG2Hi1 = get_param_handle("CDU_NG2_HI1")
local paramCDUNG2Hi2 = get_param_handle("CDU_NG2_HI2")
local paramCDUNG2Hi3 = get_param_handle("CDU_NG2_HI3")

function post_initialize()
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
		
    elseif birth=="GROUND_COLD" then
		
    end

	paramPltOverspeedLt1:set(0)
	paramPltOverspeedLt2:set(0)
	paramPltOverspeedLt3:set(0)
	paramCpltOverspeedLt1:set(0)
	paramCpltOverspeedLt2:set(0)
	paramCpltOverspeedLt3:set(0)
end

dev:listen_command(device_commands.cduLampTest)
dev:listen_command(device_commands.pilotPDUTest)
dev:listen_command(device_commands.copilotPDUTest)

function SetCommand(command,value)   
    if command == device_commands.cduLampTest then
		cduTestState = value * cduPowerState
	elseif command == device_commands.pilotPDUTest then
		pilotPduTestState = value * pduPowerState
	elseif command == device_commands.copilotPDUTest then
		copilotPduTestState = value * cpduPowerState
	end
end

function updateFuel()
	if cduPowerState > 0 then
		if cduTestState > 0 then
			paramCDUFuelDigits:set(8888)

			paramCDUFuelL_Low:set(190)
			paramCDUFuelL_Hi:set(1490)

			paramCDUFuelR_Low:set(190)
			paramCDUFuelR_Hi:set(1490)
		else
			if canUpdateDigits then
				paramCDUFuelDigits:set(math.floor(paramFuelTotal:get() / 10) * 10)
			end

			paramCDUFuelL_Low:set(paramFuelL:get())
			paramCDUFuelL_Hi:set(paramFuelL:get())

			paramCDUFuelR_Low:set(paramFuelR:get())
			paramCDUFuelR_Hi:set(paramFuelR:get())
		end
	end
end

function updateTGT()
	if cduPowerState > 0 then
		if cduTestState > 0 then
			paramCDUTgt1Digits:set(888)
			paramCDUTgt2Digits:set(888)

			paramCDUTGT1Low:set(945)
			paramCDUTGT1Med:set(945)
			paramCDUTGT1Hi1:set(945)
			paramCDUTGT1Hi2:set(945)
			
			paramCDUTGT2Low:set(945)
			paramCDUTGT2Med:set(945)
			paramCDUTGT2Hi1:set(945)
			paramCDUTGT2Hi2:set(945)
		else
			local tgt1 = paramTgt1:get()
			if tgt1 > 999 then
				tgt1 = tgt1 / 10
			end
			local tgt2 = paramTgt2:get()
			if tgt2 > 999 then
				tgt2 = tgt2 / 10
			end

			if canUpdateDigits then
				paramCDUTgt1Digits:set(tgt1)
				paramCDUTgt2Digits:set(tgt2)
			end
			
			paramCDUTGT1Low:set(paramTgt1:get())
			paramCDUTGT1Med:set(paramTgt1:get())
			paramCDUTGT1Hi1:set(paramTgt1:get())
			paramCDUTGT1Hi2:set(paramTgt1:get())

			paramCDUTGT2Low:set(paramTgt2:get())
			paramCDUTGT2Med:set(paramTgt2:get())
			paramCDUTGT2Hi1:set(paramTgt2:get())
			paramCDUTGT2Hi2:set(paramTgt2:get())
		end
	end
end

function updateNG()
	if cduPowerState > 0 then
		if cduTestState > 0 then
			paramCDUNg1Digits:set(888)
			paramCDUNg2Digits:set(888)

			paramCDUNG1Low:set(109)
			paramCDUNG1Mid:set(109)
			paramCDUNG1Hi1:set(109)
			paramCDUNG1Hi2:set(109)
			paramCDUNG1Hi3:set(109)

			paramCDUNG2Low:set(109)
			paramCDUNG2Mid:set(109)
			paramCDUNG2Hi1:set(109)
			paramCDUNG2Hi2:set(109)
			paramCDUNG2Hi3:set(109)
		else
			local ng1 = paramNg1:get()
			if ng1 <= 999 then
				ng1 = ng1 * 10
			end
			local ng2 = paramNg2:get()
			if ng2 <= 999 then
				ng2 = ng2 * 10
			end

			if canUpdateDigits then
				paramCDUNg1Digits:set(ng1)
				paramCDUNg2Digits:set(ng2)
			end
			
			paramCDUNG1Low:set(paramNg1:get())
			paramCDUNG1Mid:set(paramNg1:get())
			paramCDUNG1Hi1:set(paramNg1:get())
			paramCDUNG1Hi2:set(paramNg1:get())
			paramCDUNG1Hi3:set(paramNg1:get())

			paramCDUNG2Low:set(paramNg2:get())
			paramCDUNG2Mid:set(paramNg2:get())
			paramCDUNG2Hi1:set(paramNg2:get())
			paramCDUNG2Hi2:set(paramNg2:get())
			paramCDUNG2Hi3:set(paramNg2:get())
		end
	end
end

function updateCDU()
	if cduPowerState then
		if cduTestState > 0 then
			CDU_XMSNTEMP_LOW:set(180)
			CDU_XMSNTEMP_MID:set(180)
			CDU_XMSNTEMP_HI:set(180)

			CDU_E1OILTEMP_LOW:set(180)
			CDU_E1OILTEMP_MID:set(180)
			CDU_E1OILTEMP_HI:set(180)

			CDU_E2OILTEMP_LOW:set(180)
			CDU_E2OILTEMP_MID:set(180)
			CDU_E2OILTEMP_HI:set(180)

			CDU_XMSNPRESS_LOW:set(29)
			CDU_XMSNPRESS_MID:set(190)
			CDU_XMSNPRESS_HI:set(190)
			CDU_XMSNPRESS_HI2:set(190)

			CDU_E1OILPRESS_LOW:set(49)
			CDU_E1OILPRESS_MID:set(49)
			CDU_E1OILPRESS_MID2:set(140)
			CDU_E1OILPRESS_HI:set(140)

			CDU_E2OILPRESS_LOW:set(49)
			CDU_E2OILPRESS_MID:set(49)
			CDU_E2OILPRESS_MID2:set(140)
			CDU_E2OILPRESS_HI:set(140)

			-- Weirdly the RRPM overspeed lights are controlled by the CDU test...
			paramPltOverspeedLt1:set(1)
			paramPltOverspeedLt2:set(1)
			paramPltOverspeedLt3:set(1)
			paramCpltOverspeedLt1:set(1)
			paramCpltOverspeedLt2:set(1)
			paramCpltOverspeedLt3:set(1)
		else
			CDU_XMSNTEMP_LOW:set(XMSN_TEMP:get())
			CDU_XMSNTEMP_MID:set(XMSN_TEMP:get())
			CDU_XMSNTEMP_HI:set(XMSN_TEMP:get())

			CDU_E1OILTEMP_LOW:set(E1_OILTEMP:get())
			CDU_E1OILTEMP_MID:set(E1_OILTEMP:get())
			CDU_E1OILTEMP_HI:set(E1_OILTEMP:get())

			CDU_E2OILTEMP_LOW:set(E2_OILTEMP:get())
			CDU_E2OILTEMP_MID:set(E2_OILTEMP:get())
			CDU_E2OILTEMP_HI:set(E2_OILTEMP:get())

			CDU_XMSNPRESS_LOW:set(XMSN_PRESS:get())
			CDU_XMSNPRESS_MID:set(XMSN_PRESS:get())
			CDU_XMSNPRESS_HI:set(XMSN_PRESS:get())
			CDU_XMSNPRESS_HI2:set(XMSN_PRESS:get())

			CDU_E1OILPRESS_LOW:set(E1_OILPRESS:get())
			CDU_E1OILPRESS_MID:set(E1_OILPRESS:get())
			CDU_E1OILPRESS_MID2:set(E1_OILPRESS:get())
			CDU_E1OILPRESS_HI:set(E1_OILPRESS:get())

			CDU_E2OILPRESS_LOW:set(E2_OILPRESS:get())
			CDU_E2OILPRESS_MID:set(E2_OILPRESS:get())
			CDU_E2OILPRESS_MID2:set(E2_OILPRESS:get())
			CDU_E2OILPRESS_HI:set(E2_OILPRESS:get())

			-- These lights never go off once on, unless fixed by ground crew
			if RRPM:get() > 127 then
				overspeed1 = 1
			end
			if RRPM:get() > 137 then
				overspeed2 = 1
			end
			if RRPM:get() > 142 then
				overspeed3 = 1
			end

			paramPltOverspeedLt1:set(overspeed1)
			paramCpltOverspeedLt1:set(overspeed1)
			paramPltOverspeedLt2:set(overspeed2)
			paramCpltOverspeedLt2:set(overspeed2)
			paramPltOverspeedLt3:set(overspeed3)
			paramCpltOverspeedLt3:set(overspeed3)
		end
	end
	--print_message_to_user(XMSN_PRESS:get())
end

function updatePilotPDU()
	if pduPowerState > 0 then
		if pilotPduTestState > 0 then
			paramPltPDU_e1Trq_digits:set(188)
			paramPltPDU_e2Trq_digits:set(188)

			PDU_PLT_E1NP_LOW:set(95)
			PDU_PLT_E1NP_HI:set(129)
			PDU_PLT_E2NP_LOW:set(95)
			PDU_PLT_E2NP_HI:set(129)
			PDU_PLT_RRPM_LOW:set(95)
			PDU_PLT_RRPM_HI:set(129)
			PDU_PLT_E1TRQ:set(146)
			PDU_PLT_E2TRQ:set(146)
		else
			if canUpdateDigits then
				paramPltPDU_e1Trq_digits:set(E1TRQ:get())
				paramPltPDU_e2Trq_digits:set(E2TRQ:get())
			end

			PDU_PLT_E1NP_LOW:set(E1NP:get())
			PDU_PLT_E1NP_HI:set(E1NP:get())
			PDU_PLT_E2NP_LOW:set(E2NP:get())
			PDU_PLT_E2NP_HI:set(E2NP:get())
			PDU_PLT_RRPM_LOW:set(RRPM:get())
			PDU_PLT_RRPM_HI:set(RRPM:get())
			PDU_PLT_E1TRQ:set(E1TRQ:get())
			PDU_PLT_E2TRQ:set(E2TRQ:get())
		end
	end
end

function updateCopilotPDU()
	if cpduPowerState > 0 then
		if copilotPduTestState > 0 then
			paramCpltPDU_e1Trq_digits:set(188)
			paramCpltPDU_e2Trq_digits:set(188)

			paramCpltPDU_e1np_low:set(95)
			paramCpltPDU_e1np_hi:set(129)
			paramCpltPDU_e2np_low:set(95)
			paramCpltPDU_e2np_hi:set(129)
			paramCpltPDU_rrpm_low:set(95)
			paramCpltPDU_rrpm_hi:set(129)
			paramCpltPDU_e1trq:set(146)
			paramCpltPDU_e2trq:set(146)
		else
			if canUpdateDigits then
				paramCpltPDU_e1Trq_digits:set(E1TRQ:get())
				paramCpltPDU_e2Trq_digits:set(E2TRQ:get())
			end

			paramCpltPDU_e1np_low:set(E1NP:get())
			paramCpltPDU_e1np_hi:set(E1NP:get())
			paramCpltPDU_e2np_low:set(E2NP:get())
			paramCpltPDU_e2np_hi:set(E2NP:get())
			paramCpltPDU_rrpm_low:set(RRPM:get())
			paramCpltPDU_rrpm_hi:set(RRPM:get())
			paramCpltPDU_e1trq:set(E1TRQ:get())
			paramCpltPDU_e2trq:set(E2TRQ:get())
		end
	end
end

function update()
	pduPowerState = paramCB_NO2ACINST:get() * paramCB_NO2DCINST:get()
	cpduPowerState = paramCB_NO1ACINST:get() * paramCB_NO1DCINST:get()
	cduPowerState = math.max(paramCB_NO1ACINST:get() * paramCB_NO1DCINST:get(), paramCB_NO2ACINST:get() * paramCB_NO2DCINST:get())

	if (get_absolute_model_time() - lastTime) > digitUpdateInterval then
		lastTime = get_absolute_model_time()
		canUpdateDigits = true
	else
		canUpdateDigits = false
	end

	updateNetworkArgs(GetSelf())
	updateFuel()
	updateTGT()
	updateNG()
	updateCDU()

	updatePilotPDU()
	updateCopilotPDU()
end

need_to_be_closed = false 