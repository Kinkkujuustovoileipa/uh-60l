dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 0.1  
make_default_activity(update_time_step)

local e1clickableDetent
local e2clickableDetent
local e1clickableController
local e2clickableController

local e1ControlClickable = false
local e2ControlClickable = false

dev:listen_command(device_commands.eng1FSS)
dev:listen_command(device_commands.eng2FSS)
dev:listen_command(device_commands.setEng1Control)
dev:listen_command(device_commands.setEng2Control)
dev:listen_command(device_commands.eng1ControlDetent)
dev:listen_command(device_commands.eng2ControlDetent)

dev:listen_command(Keys.e1PCL)
dev:listen_command(Keys.e2PCL)
dev:listen_command(Keys.bothPCLs)

function post_initialize()
    e1clickableDetent = get_clickable_element_reference("PNT-042")
    e2clickableDetent = get_clickable_element_reference("PNT-043")
    e1clickableController = get_clickable_element_reference("PNT-026")
    e2clickableController = get_clickable_element_reference("PNT-027")
    e1clickableStarter = get_clickable_element_reference("PNT-030")
    e2clickableStarter = get_clickable_element_reference("PNT-031")

    local birth = LockOn_Options.init_conditions.birth_place

    if birth=="AIR_HOT" or birth=="GROUND_HOT" then
        dev:performClickableAction(device_commands.eng1FSS,0.5,true)
		dev:performClickableAction(device_commands.eng2FSS,0.5,true)
		dev:performClickableAction(device_commands.eng1ControlDetent,0,true)
		dev:performClickableAction(device_commands.eng2ControlDetent,0,true)
		dev:performClickableAction(device_commands.setEng1Control,1,true)
		dev:performClickableAction(device_commands.setEng2Control,1,true)
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.eng1ControlDetent,-1,true)
		dev:performClickableAction(device_commands.eng2ControlDetent,-1,true)
    end
end

function SetCommand(command,value)
    if command == device_commands.setEng1Control then
        --print_message_to_user("E1C val: "..value)
        if value > 0.01 then
            e1clickableDetent:hide(true)
        else
            e1clickableDetent:hide(false)
        end
        dispatch_action(nil,EFM_commands.setEng1Control,value)
        e1clickableStarter:update()
    elseif command == device_commands.setEng2Control then
        --print_message_to_user("E2C val: "..value)
        if value > 0.01 then
            e2clickableDetent:hide(true)
        else
            e2clickableDetent:hide(false)
        end
        dispatch_action(nil,EFM_commands.setEng2Control,value)
        e2clickableStarter:update()
    elseif command == device_commands.eng1ControlDetent then
        --print_message_to_user("E1C detent val: "..value)
        if value < -0.5 then
            e1clickableController:hide(true)
            e1ControlClickable = false
        else
            e1clickableController:hide(false)
            e1ControlClickable = true
        end
        dispatch_action(nil,EFM_commands.setEng1Control,value)
        e1clickableStarter:update()
    elseif command == device_commands.eng2ControlDetent then
        --print_message_to_user("E2C detent val: "..value)
        if value < -0.5 then
            e2clickableController:hide(true)
            e2ControlClickable = false
        else
            e2clickableController:hide(false)
            e2ControlClickable = true
        end
        dispatch_action(nil,EFM_commands.setEng2Control,value)
        e2clickableStarter:update()
    elseif command == device_commands.eng1FSS then
        dispatch_action(nil,EFM_commands.eng1FSS,value)
    elseif command == device_commands.eng2FSS then
        dispatch_action(nil,EFM_commands.eng2FSS,value)
    elseif command == device_commands.eng1Starter then
        dispatch_action(nil,EFM_commands.eng1Starter,value)
    elseif command == device_commands.eng2Starter then
        dispatch_action(nil,EFM_commands.eng2Starter,value)
    elseif command == Keys.e1PCL then
        if e1ControlClickable then
		    dev:performClickableAction(device_commands.setEng1Control,1 - (value + 1) / 2,true)
        end
    elseif command == Keys.e2PCL then
        if e2ControlClickable then
		    dev:performClickableAction(device_commands.setEng2Control,1 - (value + 1) / 2,true)
        end
    elseif command == Keys.bothPCLs then
        if e1ControlClickable then
		    dev:performClickableAction(device_commands.setEng1Control,1 - (value + 1) / 2,true)
        end

        if e2ControlClickable then
		    dev:performClickableAction(device_commands.setEng2Control,1 - (value + 1) / 2,true)
        end
    end
end

function update()
    updateNetworkArgs(GetSelf())
end

need_to_be_closed = false
