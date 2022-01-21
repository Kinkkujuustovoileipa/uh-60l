dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 0.1  
make_default_activity(update_time_step)

local paramDebugVis = get_param_handle("DEBUG_VISIBILITY")
paramDebugVis:set(0)

local paramDebugElemVert = get_param_handle("DEBUG_ELEM_VERT")
local paramDebugElemHoriz = get_param_handle("DEBUG_ELEM_HORIZ")
local paramDebugElemDepth = get_param_handle("DEBUG_ELEM_DEPTH")


dev:listen_command(device_commands.visualisationToggle)
dev:listen_command(Keys.debugMoveElementUp)
dev:listen_command(Keys.debugMoveElementDn)
dev:listen_command(Keys.debugMoveElementLeft)
dev:listen_command(Keys.debugMoveElementRight)
dev:listen_command(Keys.debugMoveElementForward)
dev:listen_command(Keys.debugMoveElementBack)

function SetCommand(command,value)   
    if command == device_commands.visualisationToggle then
        paramDebugVis:set(paramDebugVis:get() + 1)
        if paramDebugVis:get() > 3 then
            paramDebugVis:set(0)
        end
    elseif command == Keys.debugMoveElementUp then
        paramDebugElemVert:set(paramDebugElemVert:get() + 0.0001)
        print_message_to_user(paramDebugElemVert:get())
    elseif command == Keys.debugMoveElementDn then
        paramDebugElemVert:set(paramDebugElemVert:get() - 0.0001)
        print_message_to_user(paramDebugElemVert:get())
    elseif command == Keys.debugMoveElementLeft then
        paramDebugElemHoriz:set(paramDebugElemHoriz:get() - 0.0001)
        print_message_to_user(paramDebugElemHoriz:get())
    elseif command == Keys.debugMoveElementRight then
        paramDebugElemHoriz:set(paramDebugElemHoriz:get() + 0.0001)
        print_message_to_user(paramDebugElemHoriz:get())
    elseif command == Keys.debugMoveElementForward then
        paramDebugElemDepth:set(paramDebugElemDepth:get() + 0.0001)
        print_message_to_user(paramDebugElemDepth:get())
    elseif command == Keys.debugMoveElementBack then
        paramDebugElemDepth:set(paramDebugElemDepth:get() - 0.0001)
        print_message_to_user(paramDebugElemDepth:get())
    end
end

function update()

end

need_to_be_closed = false
