dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path..'CautionAdvisoryPanel/device/cautions.lua')
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local Terrain = require('terrain')
local update_time_step = 0.1  
make_default_activity(update_time_step)

local brightness = 1
local override = false

local mcHandle = get_param_handle("MCP_MC")
local paramBrightness = get_param_handle("CAP_BRIGHTNESS")
local hasPower = false

local acknowledgedFaults = {}
local currentFaults = {}

local paramDimmerEnabled = get_param_handle("LIGHTED_SWITCHES_DIMMER_ENABLED")

function post_initialize()
    paramDimmerEnabled:set(0)
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
    elseif birth=="GROUND_COLD" then
    end
    
    --dev:performClickableAction(device_commands.CAPLampBrightness,1,true)
    --dispatch_action(nil,device_commands.CAPLampBrightness,1)
end

dev:listen_command(device_commands.CAPLampTest)
dev:listen_command(device_commands.CAPLampBrightness)
dev:listen_command(device_commands.CAPMasterCautionReset)
function SetCommand(command,value)   
    if command == device_commands.CAPLampTest then
        if value < 0 then
            override = true
            brightness = 0.75
        else
            override = false
            brightness = 0.5
        end
    elseif command == device_commands.CAPLampBrightness then
        if value > 0 then
            paramDimmerEnabled:set(1 - paramDimmerEnabled:get())
        end
    elseif command == device_commands.CAPMasterCautionReset then
        --print_message_to_user("acknowledge")
        acknowledgedFaults = {}
        for k,v in pairs(currentFaults) do
            table.insert(acknowledgedFaults, v)
        end
        mcHandle:set(0)
    end
end

function update()
    updateNetworkArgs(GetSelf())
    hasPower = paramCB_LIGHTSCAUTADVSY:get() > 0

    if hasPower then
        mcHandle:set(0) -- off by default, switched on later if outstanding faults found
        paramBrightness:set(brightness)

        for k,v in pairs(CAUTIONS) do
            if v.param ~= nil then
                local param = get_param_handle(v.param)
                local displayParam = get_param_handle("DISPLAY_"..v.param)
                if override then
                    -- FUEL LOW lights blink
                    if (v.param == "CAP_1FUELLOW" or v.param == "CAP_2FUELLOW") then
                        displayParam:set(math.sin(get_absolute_model_time() * 10))
                    else
                        displayParam:set(1)
                    end
                else
                    -- FUEL LOW lights blink
                    if (v.param == "CAP_1FUELLOW" or v.param == "CAP_2FUELLOW") then
                        displayParam:set(math.sin(get_absolute_model_time() * 10) * param:get())
                    else
                        displayParam:set(param:get())
                    end

                    --handle master caution light
                    if (param:get() > 0) then
                        local fault = v.param
                        local faultAcknowledged = false
                        for k,v in pairs(acknowledgedFaults) do
                            if v == fault then
                                faultAcknowledged = true
                            end
                        end

                        if not faultAcknowledged then
                            mcHandle:set(1)
                        end

                        local faultPresent = false
                        for i,j in pairs(currentFaults) do
                            if j == v.param then
                                faultPresent = true
                            end
                        end
                        if faultPresent == false then
                            table.insert(currentFaults, fault)
                        end
                    else
                        -- if the error is no longer present, it should be removed from the acknowledged faults table
                        -- current faults should be a small table so this shouldn't affect performance
                        for i,j in pairs(currentFaults) do
                            if j == v.param then
                                table.remove(currentFaults, i)
                            end
                        end

                        for i,j in pairs(acknowledgedFaults) do
                            if j == v.param then
                                table.remove(acknowledgedFaults, i)
                            end
                        end
                        --printsec(Dump(acknowledgedFaults))
                    end
                end
            end
        end

        -- MC assumed not lit for advisories
        for k,v in pairs(ADVISORIES) do
            if v.param ~= nil then
                local param = get_param_handle(v.param)
                local displayParam = get_param_handle("DISPLAY_"..v.param)
                if override then
                    displayParam:set(1)
                else
                    displayParam:set(param:get())
                end
            end
        end

        -- Training diagrams suggest that MC is not lit for warnings
        for k,v in pairs(WARNINGS) do
            if v.param ~= nil then
                local param = get_param_handle(v.param)
                local displayParam = get_param_handle("DISPLAY_"..v.param)
                if override then
                    -- LOW ROTOR RPM light blinks
                    if (v.param == "MCP_LOWROTORRPM") then
                        displayParam:set(math.sin(get_absolute_model_time() * 15))
                    else
                        displayParam:set(1)
                    end
                else
                    -- LOW ROTOR RPM light blinks
                    if (v.param == "MCP_LOWROTORRPM") then
                        displayParam:set(math.sin(get_absolute_model_time() * 15) * param:get() + 0.5)
                    else
                        displayParam:set(param:get())
                    end
                end

                -- TODO Low RRPM warning sound

            end
        end
    else
        paramBrightness:set(0)
    end
end

need_to_be_closed = false
