dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")
dofile(LockOn_Options.script_path.."utils.lua")

-- This device is used to help initialize clickable switches and to interface keyboard bindings with clickables
-- performClickableAction doesn't seem to send the command to the EFM, so dispatch_action is used for that

local update_rate = .01
make_default_activity(update_rate)
local dev = GetSelf()
local efm_data_bus = get_efm_data_bus()
local SHOW_CONTROLS  = get_param_handle("SHOW_CONTROLS")
--local option_doorsRemove = get_plugin_option_value("UH-60L","doorsRemove","local")

local brakesOn = false
local parkingBrakeUp = false
local parkingBrakeSet = false
local paramParkingBrakeAnim = get_param_handle("PARKING_BRAKE_HANDLE")
local paramWheelBrakes = get_param_handle("WHEEL_BRAKES")
local paramParkingBrakeAdvisory = get_param_handle("CAP_PARKINGBRAKEON")

local lastWheelBrakeValue = 0
local parkingBrakeOnly = false

function post_initialize()
	SHOW_CONTROLS:set(0)
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" or birth=="GROUND_HOT" then
		dev:performClickableAction(EFM_commands.batterySwitch,1,true)
		dev:performClickableAction(EFM_commands.gen1Switch,1,true)
		dev:performClickableAction(EFM_commands.gen2Switch,1,true)
		dev:performClickableAction(EFM_commands.fuelPump1,1,true)
		dev:performClickableAction(EFM_commands.fuelPump2,1,true)		
    elseif birth=="GROUND_COLD" then
		dev:performClickableAction(EFM_commands.batterySwitch,0,true)
		dev:performClickableAction(EFM_commands.gen1Switch,0,true)
		dev:performClickableAction(EFM_commands.gen2Switch,0,true)
		dev:performClickableAction(EFM_commands.fuelPump1,-1,true)
		dev:performClickableAction(EFM_commands.fuelPump2,-1,true)
    end

	--[[
	-- Parking Brake - start on if on ground
	if birth == "GROUND_HOT" or birth == "GROUND_COLD" then
		parkingBrakeSet = true
		parkingBrakeOnly = true

		update()
	end
	]]
	
	optionFuelProbe = get_aircraft_property("FuelProbeEnabled")
	dispatch_action(nil, EFM_commands.setRefuelProbeState, optionFuelProbe)
	set_aircraft_draw_argument_value(22, optionFuelProbe)

	local optionUnsprungCyclic = get_plugin_option_value("UH-60L", "UNSPRUNG_CYCLIC", "local")
	dispatch_action(nil, EFM_commands.useUnsprungCyclic, optionUnsprungCyclic)
	--print_message_to_user(tostring(optionUnsprungCyclic))
end

dev:listen_command(Keys.BattSwitchOn)
dev:listen_command(Keys.BattSwitchOff)
dev:listen_command(Keys.gen1SwitchOn)
dev:listen_command(Keys.gen1SwitchOff)
dev:listen_command(Keys.gen1SwitchTest)
dev:listen_command(Keys.gen2SwitchOn)
dev:listen_command(Keys.gen2SwitchOff)
dev:listen_command(Keys.gen2SwitchTest)
dev:listen_command(Keys.extPwrSwitchOn)
dev:listen_command(Keys.extPwrSwitchOff)
dev:listen_command(Keys.extPwrSwitchReset)
dev:listen_command(Keys.apuGenSwitchOn)
dev:listen_command(Keys.apuGenSwitchOff)
dev:listen_command(Keys.apuGenSwitchTest)
dev:listen_command(Keys.switchFuelPumpPrime)
dev:listen_command(Keys.switchFuelPumpOff)
dev:listen_command(Keys.switchFuelPumpApuBoost)
dev:listen_command(Keys.switchAirSourceApu)
dev:listen_command(Keys.switchAirSourceOff)
dev:listen_command(Keys.switchAirSourceEngine)
dev:listen_command(Keys.switchAPUOn)
dev:listen_command(Keys.switchAPUOff)

dev:listen_command(Keys.BattSwitch)
dev:listen_command(Keys.ExtPwrSwitch)
dev:listen_command(Keys.showControlInd)
dev:listen_command(device_commands.parkingBrake)
dev:listen_command(EFM_commands.wheelbrake)

function SetCommand(command,value)
	PwrSwpos = get_cockpit_draw_argument_value(17)

	if command == Keys.BattSwitch then
		if PwrSwpos == 1 then
			dev:performClickableAction(EFM_commands.batterySwitch,0,true)
			dispatch_action(nil,EFM_commands.batterySwitch,0)
			set_aircraft_draw_argument_value(36,0)
		elseif PwrSwpos < 1 then
			dev:performClickableAction(EFM_commands.batterySwitch,1,true)
			dispatch_action(nil,EFM_commands.batterySwitch,1)
			set_aircraft_draw_argument_value(36,1)
		end
	elseif command == Keys.ExtPwrSwitch then
		if PwrSwpos == -1 then
			dev:performClickableAction(EFM_commands.batterySwitch,0,true)
			dispatch_action(nil,EFM_commands.batterySwitch,0)
		elseif PwrSwpos > -1 then
			dev:performClickableAction(EFM_commands.batterySwitch,-1,true)
			dispatch_action(nil,EFM_commands.batterySwitch,-1)
		end
	elseif command == Keys.showControlInd then
		SHOW_CONTROLS:set(1-SHOW_CONTROLS:get())
	elseif command == device_commands.parkingBrake then
		if value > 0 then
			parkingBrakeUp = true
		else
			parkingBrakeUp = false
		end

		if brakesOn then
			parkingBrakeSet = true
		else
			parkingBrakeSet = false
		end

	elseif command == Keys.apuGenSwitchOn then
		dev:performClickableAction(EFM_commands.apuGenSwitch2,1,true)
		dispatch_action(nil,EFM_commands.apuGenSwitch2,1)
		--print_message_to_user("apuGenSwitchOn")
	elseif command == Keys.apuGenSwitchOff then
		dev:performClickableAction(EFM_commands.apuGenSwitch2,0,true)
		dispatch_action(nil,EFM_commands.apuGenSwitch2,1)
		--print_message_to_user("apuGenSwitchOff")
	elseif command == Keys.gen1SwitchOn then
		dev:performClickableAction(EFM_commands.gen1Switch2,1,true)
		dispatch_action(nil,EFM_commands.gen1Switch2,1)
		--print_message_to_user("gen1SwitchOn")
	elseif command == Keys.gen1SwitchOff then
		dev:performClickableAction(EFM_commands.gen1Switch2,0,true)
		dispatch_action(nil,EFM_commands.gen1Switch2,1)
		--print_message_to_user("gen1SwitchOff")
	elseif command == Keys.gen2SwitchOn then
		dev:performClickableAction(EFM_commands.gen2Switch2,1,true)
		dispatch_action(nil,EFM_commands.gen2Switch2,1)
		--print_message_to_user("gen2SwitchOn")
	elseif command == Keys.gen2SwitchOff then
		dev:performClickableAction(EFM_commands.gen2Switch2,0,true)
		dispatch_action(nil,EFM_commands.gen2Switch2,1)
		--print_message_to_user("gen2SwitchOff")
	elseif command == Keys.switchAPUOn then
		dev:performClickableAction(EFM_commands.switchAPU,1,true)
		dispatch_action(nil,EFM_commands.switchAPU,1)
		--print_message_to_user("switchAPUOn")
	elseif command == Keys.switchAPUOff then
		dev:performClickableAction(EFM_commands.switchAPU,0,true)
		dispatch_action(nil,EFM_commands.switchAPU,0)
		--print_message_to_user("switchAPUOff")
	elseif command == Keys.switchFuelPumpApuBoost then
		dev:performClickableAction(EFM_commands.switchFuelPump,-1,true)
		dispatch_action(nil,EFM_commands.switchFuelPump,-1)
		--print_message_to_user("switchFuelPumpApuBoost")
	elseif command == Keys.switchFuelPumpOff then
		dev:performClickableAction(EFM_commands.switchFuelPump,0,true)
		dispatch_action(nil,EFM_commands.switchFuelPump,0)
		--print_message_to_user("switchFuelPumpOff")
	elseif command == Keys.switchFuelPumpPrime then
		dev:performClickableAction(EFM_commands.switchFuelPump,1,true)
		dispatch_action(nil,EFM_commands.switchFuelPump,1)
		--print_message_to_user("switchFuelPumpPrime")
	elseif command == Keys.switchAirSourceEngine then
		dev:performClickableAction(EFM_commands.switchAirSource,-1,true)
		dispatch_action(nil,EFM_commands.switchAirSource,-1)
		--print_message_to_user("switchAirSourceEngine")
	elseif command == Keys.switchAirSourceOff then
		dev:performClickableAction(EFM_commands.switchAirSource,0,true)
		dispatch_action(nil,EFM_commands.switchAirSource,0)
		--print_message_to_user("switchAirSourceOff")
	elseif command == Keys.switchAirSourceApu then
		dev:performClickableAction(EFM_commands.switchAirSource,1,true)
		dispatch_action(nil,EFM_commands.switchAirSource,1)
		--print_message_to_user("switchAirSourceApu")
	elseif command == Keys.BattSwitchOff then
		dev:performClickableAction(EFM_commands.batterySwitch,0,true)
		dispatch_action(nil,EFM_commands.batterySwitch,0)
		--print_message_to_user("BattSwitchOff")
	elseif command == Keys.BattSwitchOn then
		dev:performClickableAction(EFM_commands.batterySwitch,1,true)
		dispatch_action(nil,EFM_commands.batterySwitch,1)
		--print_message_to_user("BattSwitchOn")
	elseif command == Keys.extPwrSwitchOff then -- TODO: there might be some switch logic missing here
		dev:performClickableAction(EFM_commands.extPwrSwitch2,0,true)
		dispatch_action(nil,EFM_commands.extPwrSwitch2,0)
		--print_message_to_user("BattSwitchOff")
	elseif command == Keys.extPwrSwitchOn then -- TODO: there might be some switch logic missing here
		dev:performClickableAction(EFM_commands.extPwrSwitch2,1,true)
		dispatch_action(nil,EFM_commands.extPwrSwitch2,1)
		--print_message_to_user("BattSwitchOn")
	end
end

local lastArg
local lastVal

function update()
	updateNetworkArgs(dev)

	local wheelBrakeValue = paramWheelBrakes:get()
	if wheelBrakeValue > 0.3 then
		--print_message_to_user(paramWheelBrakes:get())
		brakesOn = true
		if parkingBrakeSet and parkingBrakeOnly then
			parkingBrakeSet = false
			parkingBrakeOnly = false
		end
	else
		brakesOn = false
	end
	if wheelBrakeValue ~= lastWheelBrakeValue then
		if wheelBrakeValue < 0.1 and wheelBrakeValue < lastWheelBrakeValue and parkingBrakeSet then
			parkingBrakeOnly = true
		end
		lastWheelBrakeValue = wheelBrakeValue
	end

	if parkingBrakeSet or parkingBrakeUp and paramParkingBrakeAnim:get() == 0 then
		paramParkingBrakeAnim:set(1)
		dispatch_action(nil, EFM_commands.setParkingBrake, 1)
		paramParkingBrakeAdvisory:set(1)
	elseif not parkingBrakeSet and not parkingBrakeUp and paramParkingBrakeAnim:get() == 1 then
		paramParkingBrakeAnim:set(0)
		dispatch_action(nil, EFM_commands.setParkingBrake, 0)
		paramParkingBrakeAdvisory:set(0)
	end
end

need_to_be_closed = false -- close lua state after initialization