dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.1  
make_default_activity(update_time_step)

handleMode = get_param_handle("COPILOT_LC6_MODE")
handleLTHrs = get_param_handle("COPILOT_LC6_LT_HRS")
handleLTMins = get_param_handle("COPILOT_LC6_LT_MINS")
handleLTSecs = get_param_handle("COPILOT_LC6_LT_SECS")
handleUTCHrs = get_param_handle("COPILOT_LC6_UTC_HRS")
handleUTCMins = get_param_handle("COPILOT_LC6_UTC_MINS")
handleUTCSecs = get_param_handle("COPILOT_LC6_UTC_SECS")
handleFLTHrs  = get_param_handle("COPILOT_LC6_FLT_HRS")
handleFLTMins = get_param_handle("COPILOT_LC6_FLT_MINS")
handleFLTSecs = get_param_handle("COPILOT_LC6_FLT_SECS")
handleSWHrs  = get_param_handle("COPILOT_LC6_SW_HRS")
handleSWMins = get_param_handle("COPILOT_LC6_SW_MINS")
handleSWSecs = get_param_handle("COPILOT_LC6_SW_SECS")

dofile(LockOn_Options.script_path..'LC6Chronometer/device/LC6Base.lua')

function update()
    updateNetworkArgs(GetSelf())
    hasPower = paramCB_CPLTALTM:get() > 0
    if hasPower then
        updateLT()
        updateUTC()
        updateFlightTimer()
        updateStopwatch()

        --print_message_to_user(modeIndex)
        handleMode:set(modeIndex)
    end
end

need_to_be_closed = false
