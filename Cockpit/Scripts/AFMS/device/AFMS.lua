dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 1 
make_default_activity(update_time_step)

local outbdLPresent = false
local inbdLPresent = false
local inbdRPresent = false
local outbdRPresent = false

local outbdLFuelQuantity = 0
local inbdLFuelQuantity = 0
local inbdRFuelQuantity = 0
local outbdRFuelQuantity = 0

local paramOutbdLFuelDisplay = get_param_handle("AFMS_DISPLAY_OUTBD_L")
local paramInbdLFuelDisplay = get_param_handle("AFMS_DISPLAY_INBD_L")
local paramInbdRFuelDisplay = get_param_handle("AFMS_DISPLAY_INBD_R")
local paramOutbdRFuelDisplay = get_param_handle("AFMS_DISPLAY_OUTBD_R")

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then  
    elseif birth=="GROUND_COLD" then
    end

	update()
end

dev:listen_command(device_commands.afmcpXferMode)
dev:listen_command(device_commands.afmcpManXfer)
dev:listen_command(device_commands.afmcpXferFrom)
dev:listen_command(device_commands.afmcpPress)

function SetCommand(command,value)   
    if command == device_commands.afmcpXferMode then
		--print_message_to_user(value)
		dispatch_action(nil, EFM_commands.afmcpXferMode, value)
	elseif command == device_commands.afmcpManXfer then
		--print_message_to_user(value)
		dispatch_action(nil, EFM_commands.afmcpManXfer, value)
	elseif command == device_commands.afmcpXferFrom then
		--print_message_to_user(value)
		dispatch_action(nil, EFM_commands.afmcpXferFrom, value)
	elseif command == device_commands.afmcpPress then
	end
end

function updateTanks(tank, i)
	-- General check, do we have anything on pylons?
	-- This is for the back up anim check
	if tank ~= nil then
		--print_message_to_user(i..": "..Dump(tank))
		if  tostring(tank["CLSID"]) == "<CLEAN>" then
			if i == 0 then
				outbdLPresent = false
			elseif i == 1 then
				inbdLPresent = false
			elseif i == 2 then
				inbdRPresent = false
			elseif i == 3 then
				outbdRPresent = false
			end
		else
			if i == 0 then
				outbdLPresent = true
			elseif i == 1 then
				inbdLPresent = true
			elseif i == 2 then
				inbdRPresent = true
			elseif i == 3 then
				outbdRPresent = true
			end
		end
		--[[
	else
		if i == 0 then
			outbdLPresent = false
		elseif i == 1 then
			inbdLPresent = false
		elseif i == 2 then
			inbdRPresent = false
		elseif i == 3 then
			outbdRPresent = false
		end
		]]
	end

	if outbdLPresent or inbdLPresent or inbdRPresent or outbdRPresent then
		get_param_handle("PYLONS_USED"):set(1)
	else
		get_param_handle("PYLONS_USED"):set(0)
	end
	
	-- Specific fuel bag handling
	if tank ~= nil and tostring(tank["CLSID"]) == "{UH60_FUEL_TANK_230}" then
		local tankFuelAmount = get_param_handle("AUX_FUEL_P"..i):get()
		--print_message_to_user(i..": "..Dump(tank).." fuel: "..tankFuelAmount)

		if i == 0 then
			outbdLFuelQuantity = round(tankFuelAmount / 10) * 10
			paramOutbdLFuelDisplay:set(tostring(outbdLFuelQuantity.."%"))
		elseif i == 1 then
			inbdLFuelQuantity = round(tankFuelAmount / 10) * 10
			paramInbdLFuelDisplay:set(tostring(inbdLFuelQuantity.."%"))
		elseif i == 2 then
			inbdRFuelQuantity = round(tankFuelAmount / 10) * 10
			paramInbdRFuelDisplay:set(tostring(inbdRFuelQuantity.."%"))
		elseif i == 3 then
			outbdRFuelQuantity = round(tankFuelAmount / 10) * 10
			paramOutbdRFuelDisplay:set(tostring(outbdRFuelQuantity.."%"))
		end
	else
		if i == 0 then
			outbdLFuelQuantity = 0
			paramOutbdLFuelDisplay:set("cccc%")
		elseif i == 1 then
			inbdLFuelQuantity = 0
			paramInbdLFuelDisplay:set("cccc%")
		elseif i == 2 then
			inbdRFuelQuantity = 0
			paramInbdRFuelDisplay:set("cccc%")
		elseif i == 3 then
			outbdRFuelQuantity = 0
			paramOutbdRFuelDisplay:set("cccc%")
		end
	end
end

function update()
	updateNetworkArgs(GetSelf())

	for i=0, 3, 1 do
        updateTanks(dev:get_station_info(i), i)
    end
end

need_to_be_closed = false 