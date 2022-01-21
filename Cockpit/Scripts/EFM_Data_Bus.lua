


local ptr_radio = get_param_handle("THIS_RADIO_PTR")
local ptr_intercom = get_param_handle("THIS_INTERCOM_PTR")
local ptr_elec = get_param_handle("THIS_ELEC_PTR")

local fm_radio_power = get_param_handle("FM_RADIO_POWER")

local fm_avionics_alive = get_param_handle("FM_AVIONICS_ALIVE")

function fm_setRadioPower(value)
    fm_radio_power:set(value)
end

function fm_setRadioPTR(value)
    ptr_radio:set(value)
end

function fm_setIntercomPTR(value)
    ptr_intercom:set(value)
end

function fm_setElecPTR(value)
    ptr_elec:set(value)
end

function fm_setAvionicsAlive(value)
    fm_avionics_alive:set(value)
end


function get_efm_data_bus()
    local efm_data_bus = {}

    efm_data_bus.fm_setRadioPower = fm_setRadioPower
    efm_data_bus.fm_setAvionicsAlive = fm_setAvionicsAlive
    efm_data_bus.fm_setElecPTR = fm_setElecPTR
    efm_data_bus.fm_setIntercomPTR = fm_setIntercomPTR
    efm_data_bus.fm_setRadioPTR = fm_setRadioPTR


    return efm_data_bus
   
end

local EFM_enabled = true
