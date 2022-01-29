dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

dev = GetSelf()
sensor_data = get_base_data()
Terrain = require('terrain')
update_time_step = 0.1  
make_default_activity(update_time_step)

local xmitMode = 1
local volume = 0

local rcvFM1 = false
local rcvUHF = false
local rcvVHF = false
local rcvFM2 = false
local rcvHF = false
local rcvVOR = false
local rcvADF = false

local paramPTT = get_param_handle("PILOT_PTT")

dev:listen_command(device_commands.pilotICPXmitSelector)
dev:listen_command(device_commands.pilotICPSetVolume)
dev:listen_command(device_commands.pilotICPToggleFM1)
dev:listen_command(device_commands.pilotICPToggleUHF)
dev:listen_command(device_commands.pilotICPToggleVHF)
dev:listen_command(device_commands.pilotICPToggleFM2)
dev:listen_command(device_commands.pilotICPToggleHF)
dev:listen_command(device_commands.pilotICPToggleVOR)
dev:listen_command(device_commands.pilotICPToggleADF)
dev:listen_command(Keys.ptt)
dev:listen_command(Keys.pilotICPXmitSelectorInc)
dev:listen_command(Keys.pilotICPXmitSelectorDec)

function SetCommand(command,value)   
    if command == device_commands.pilotICPXmitSelector then
        xmitMode = round(value * 5)
        setXMITMode()
        --print_message_to_user(xmitMode)
    elseif  command == device_commands.pilotICPSetVolume then
        volume = value
    elseif  command == device_commands.pilotICPToggleFM1 then
        rcvFM1 = value > 0
    elseif  command == device_commands.pilotICPToggleUHF then
        rcvUHF = value > 0
    elseif  command == device_commands.pilotICPToggleVHF then
        rcvVHF = value > 0
    elseif  command == device_commands.pilotICPToggleFM2 then
        rcvFM2 = value > 0
    elseif  command == device_commands.pilotICPToggleHF then
        rcvHF = value > 0
    elseif  command == device_commands.pilotICPToggleVOR then
        rcvVOR = value > 0
    elseif  command == device_commands.pilotICPToggleADF then
        rcvADF = value > 0
    elseif command == Keys.ptt then
        if value > 1.3 then
            paramPTT:set(1)
        else
            paramPTT:set(0)
        end
    elseif  command == Keys.pilotICPXmitSelectorInc then
        if xmitMode < 5 then
            dev:performClickableAction(device_commands.pilotICPXmitSelector, (xmitMode + 1) / 5, true)
            --dispatch_action(nil,device_commands.pilotICPXmitSelector, (xmitMode + 1) / 5)
        end
    elseif  command == Keys.pilotICPXmitSelectorDec then
        if xmitMode > 0 then
            dev:performClickableAction(device_commands.pilotICPXmitSelector, (xmitMode - 1) / 5, true)
            --dispatch_action(nil,device_commands.pilotICPXmitSelector, (xmitMode - 1) / 5)
        end
    end
end

function post_initialize()
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then 
    end

    dev:performClickableAction(device_commands.pilotICPSetVolume,1,true)
    dev:performClickableAction(device_commands.pilotICPToggleFM1,1,true)
    dev:performClickableAction(device_commands.pilotICPToggleUHF,1,true)
    dev:performClickableAction(device_commands.pilotICPToggleVHF,1,true)
    dev:performClickableAction(device_commands.pilotICPToggleFM2,1,true)
    dev:performClickableAction(device_commands.pilotICPToggleHF,1,true)
end

function setXMITMode()
    --[[
    local intercom = GetDevice(devices.INTERCOM)
    if xmitMode == 2 then
        intercom:set_communicator(devices.FM1_RADIO)
    elseif xmitMode == 3 then
        intercom:set_communicator(devices.UHF_RADIO)
    elseif xmitMode == 4 then
        intercom:set_communicator(devices.VHF_RADIO)
    else
        intercom:set_communicator(nil)
    end

    intercom:make_setup_for_communicator()
    ]]
end

function update()
    updateNetworkArgs(GetSelf())
    --paramPTT:set(0)
    --GetDevice(devices.INTERCOM):
end

need_to_be_closed = false
