dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.1  
make_default_activity(update_time_step)

local paramHdgMode = get_param_handle("CIS_MODE_HDG")
local paramNavMode = get_param_handle("CIS_MODE_NAV")
local paramAltMode = get_param_handle("CIS_MODE_ALT")
local PilotCISHdgTracker = 0
local PilotCISNavTracker = 0
local PilotCISAltTracker = 0

dev:listen_command(device_commands.PilotCISHdgToggle)
dev:listen_command(device_commands.PilotCISNavToggle)
dev:listen_command(device_commands.PilotCISAltToggle)

dev:listen_command(Keys.PilotCISHdgCycle)
dev:listen_command(Keys.PilotCISNavCycle)
dev:listen_command(Keys.PilotCISAltCycle)

function SetCommand(command,value)
    -- Main CIS modes shouldn't function without power
    local hasPower = paramCB_PLTMODESEL:get() > 0
        if hasPower then
        if command == device_commands.PilotCISHdgToggle then
            paramHdgMode:set(value)
            if value ~= PilotCISHdgTracker then
                PilotCISHdgTracker = 1 - PilotCISHdgTracker
            end
        elseif command == Keys.PilotCISHdgCycle then
            PilotCISHdgTracker = 1 - PilotCISHdgTracker
            dev:performClickableAction(device_commands.PilotCISHdgToggle, PilotCISHdgTracker, true)
        elseif command == device_commands.PilotCISNavToggle then
            paramNavMode:set(value)
            if value ~= PilotCISNavTracker then
                PilotCISNavTracker = 1 - PilotCISNavTracker
            end
        elseif command == Keys.PilotCISNavCycle then
            PilotCISNavTracker = 1 - PilotCISNavTracker
            dev:performClickableAction(device_commands.PilotCISNavToggle, PilotCISNavTracker, true)

        elseif command == device_commands.PilotCISAltToggle then
            paramAltMode:set(value)
            if value ~= PilotCISAltTracker then
                PilotCISAltTracker = 1 - PilotCISAltTracker
            end
        elseif command == Keys.PilotCISAltCycle then
            PilotCISAltTracker = 1 - PilotCISAltTracker
            dev:performClickableAction(device_commands.PilotCISAltToggle, PilotCISAltTracker, true)
        end
    end
end

function update()

end

need_to_be_closed = false
