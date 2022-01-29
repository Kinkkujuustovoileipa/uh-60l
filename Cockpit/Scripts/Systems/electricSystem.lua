dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")

local dev = GetSelf()
local update_time_step = 0.1
make_default_activity(update_time_step)
local sensor_data = get_base_data()

local efm_data_bus = get_efm_data_bus()

-- Params from EFM
-- DC Supply
local paramDCEssBusOn = get_param_handle("DC_ESS_BUS_ON");
local paramDCBus1On = get_param_handle("DC_BUS1_ON");
local paramDCBus2On = get_param_handle("DC_BUS2_ON");

-- AC Supply
local paramACEssBusOn = get_param_handle("AC_ESS_BUS_ON");
local paramACBus1On = get_param_handle("AC_BUS1_ON");
local paramACBus2On = get_param_handle("AC_BUS2_ON");

-- Gens
local paramGen1On = get_param_handle("GEN1_ON");
local paramGen2On = get_param_handle("GEN2_ON");
local paramAPUGenOn = get_param_handle("APU_GEN_ON");

-- Converters
local paramConverter1On = get_param_handle("CONV_1_ON");
local paramConverter2On = get_param_handle("CONV_2_ON");

-- Battery Charge
local paramBatteryCharge = get_param_handle("BATTERY_CHARGE");

-- Cautions
local paramAdvisoryApuGenDisplay = get_param_handle("CAP_APUGENON");
local paramCautionGen1 = get_param_handle("CAP_1GEN");
local paramCautionGen2 = get_param_handle("CAP_2GEN");
local paramCautionACEssOff = get_param_handle("CAP_ACESSBUSOFF");
local paramCautionDCEssOff = get_param_handle("CAP_DCESSBUSOFF");
local paramCaution1Conv = get_param_handle("CAP_1CONV");
local paramCaution2Conv = get_param_handle("CAP_2CONV");
local paramCautionBattFault = get_param_handle("CAP_BATTFAULT");
local paramCautionBattLow = get_param_handle("CAP_BATTLOW");
local paramAdvisoryExtPwr = get_param_handle("CAP_EXTPWRCONNECTED")

-- External Power Connected
local extPwrConnected = get_param_handle("EXTERNAL_POWER")

-- Could just use param getter but this is more legible
local DCEssBusOn = 0
local DCBus1On = 0
local DCBus2On = 0

local ACEssBusOn = 0
local ACBus1On = 0
local ACBus2On = 0

local Gen1On = 0
local Gen2On = 0
local APUGenOn = 0

local converter1On = 0
local converter2On = 0

local batteryCharge = 0

-- Listen for ground power events
dev:listen_event("GroundPowerOn")
dev:listen_event("GroundPowerOff")
function CockpitEvent(event,val)
    if event == "GroundPowerOn" then
        extPwrConnected:set(1)
    elseif event == "GroundPowerOff" then
        extPwrConnected:set(0)
    end
end

function post_initialize()
    str_ptr = string.sub(tostring(dev.link),10)
    efm_data_bus.fm_setElecPTR(str_ptr)

    local birth = LockOn_Options.init_conditions.birth_place
    
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        paramDCEssBusOn:set(1)
        paramDCBus1On:set(1)
        paramDCBus2On:set(1)
        paramACEssBusOn:set(1)
        paramACBus1On:set(1)
        paramACBus2On:set(1)
        paramGen1On:set(1)
        paramGen2On:set(1)
        paramAPUGenOn:set(0)
        paramConverter1On:set(1)
        paramConverter2On:set(1)
        
        update()
    elseif birth=="GROUND_COLD" then
    end
end


function SetCommand(command,value)
end

function update()
    -- Update bus states
    DCEssBusOn  = paramDCEssBusOn:get()
    DCBus1On    = paramDCBus1On:get()
    DCBus2On    = paramDCBus2On:get()
    ACEssBusOn  = paramACEssBusOn:get()
    ACBus1On    = paramACBus1On:get()
    ACBus2On    = paramACBus2On:get()
    Gen1On      = paramGen1On:get()
    Gen2On      = paramGen2On:get()
    APUGenOn    = paramAPUGenOn:get()
    converter1On = paramConverter1On:get()
    converter2On = paramConverter2On:get()
    batteryCharge = paramBatteryCharge:get()

    --print_message_to_user("AC ESS: "..ACEssBusOn)

    --print_message_to_user("DC ESS: "..DCEssBusOn.."; DC Bus 1: "..DCBus1On.."; DC Bus 2: "..DCBus2On.."; AC ESS: "..ACEssBusOn.."; AC Bus 1: "..ACBus1On.."; AC Bus 2: "..ACBus2On)
    --print_message_to_user("APU GEN: "..APUGenOn)
    -- Update all circuit breakers
    paramCB_CPLTALTM:set(DCBus1On)
    paramCB_PILOTALTM:set(DCBus2On)
    paramCB_RdrAltm:set(DCBus1On)
    paramCB_UHFAM:set(DCEssBusOn)
    paramCB_VHFAM:set(DCBus2On)
    paramCB_VHFFM1:set(DCEssBusOn)
    paramCB_VHFFM2:set(DCBus1On)
    paramCB_VORILS:set(DCEssBusOn)
    paramCB_ADF:set(DCBus1On)
    paramCB_26VACINST:set(ACEssBusOn)
    paramCB_DPLR:set(DCBus1On)
    paramCB_26VACDPLR:set(ACBus2On)
    paramCB_HUDREF:set(ACBus1On)
    paramCB_HUDSYS:set(DCBus1On)
    paramCB_LIGHTSCAUTADVSY:set(DCBus1On)
    paramCB_NO1ACINST:set(ACBus1On)
    paramCB_NO1DCINST:set(DCBus1On)
    paramCB_NO2ACINST:set(ACBus2On)
    paramCB_NO2DCINST:set(DCBus2On)
    paramCB_AHRUPLT:set(ACEssBusOn)
    paramCB_AHRUCPLT:set(ACEssBusOn)
    paramCB_PLTMODESEL:set(DCBus2On)
    paramCB_CPLTMODESEL:set(DCBus1On)
    paramCB_STABIND:set(ACEssBusOn)
    paramCB_LTSGLARESHIELD:set(ACBus1On)
    paramCB_LTSPLTFLT:set(ACBus2On)
    paramCB_LTSNONFLT:set(ACBus2On)
    paramCB_LTSCPLTFLT:set(ACBus1On)
    paramCB_LTSUPPERCSL:set(ACBus1On)
    paramCB_LTSLWRCSL:set(ACBus1On)
    paramCB_LTSCABINDOME:set(ACBus1On)
    paramCB_EXTLTSPOS:set(DCBus2On)
    paramCB_EXTLTSANTICOLL:set(ACBus2On)
    paramCB_EXTLTSRETRLDGCONT:set(DCBus1On)
    paramCB_EXTLTSRETRLDGPWR:set(DCBus1On)
    paramCB_APR39:set(ACBus1On) -- no idea where gets power from (except that it is on cplt side), let's just guess no1AC
    paramCB_SASBOOST:set(DCEssBusOn)
    paramCB_SASAMPL:set(ACEssBusOn)  
    paramCB_STABPWR:set(DCBus2On)
    paramCB_STABCONTR1:set(ACEssBusOn)
    paramCB_STABCONTR2:set(ACBus2On)
    paramCB_COMP:set(ACBus2On)
    paramCB_TAILWHEELLOCK:set(DCEssBusOn)
    paramCB_CHAFFDISP:set(DCBus1On)
    paramCB_LIGHTSSECPNL:set(DCEssBusOn)

    -- Update associated cautions and advisories
    paramAdvisoryApuGenDisplay:set(APUGenOn)
    paramCautionGen1:set(1 - Gen1On)
    paramCautionGen2:set(1 - Gen2On)
    paramCautionACEssOff:set(1 - ACEssBusOn)
    paramCautionDCEssOff:set(1 - DCEssBusOn)
    paramCaution1Conv:set(1 - converter1On)
    paramCaution2Conv:set(1 - converter2On)
    --paramCautionBattFault TODO
    if batteryCharge < 24 * 0.45 then
        paramCautionBattLow:set(1)
    else
        paramCautionBattLow:set(0)
    end
    paramAdvisoryExtPwr:set(extPwrConnected:get())
end

need_to_be_closed = false -- close lua state after initialization
