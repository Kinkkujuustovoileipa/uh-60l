dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.01  
make_default_activity(update_time_step)

local paramTailWheelLockLight = get_param_handle("LIGHTING_MISC_TAILWHEELLOCK")
local tailWheelLockedState = 0 -- 0 = unlocked, 1 = locked, -1 = transition
local tailWheelLockPwrState
local tailWheelLockTarget
local tailWheelLockTime

local wiperMode = 1
local wiperTargetVal = 0
local wiperFwd = true

local canopyTargetState = 0

local doorCpltTgt = 0
local doorLGnrTgt = 0
local doorRGnrTgt = 0
local doorLCargoTgt = 0
local doorRCargoTgt = 0

local doorCpltState = 0
local doorLGnrState = 0
local doorRGnrState = 0
local doorLCargoState = 0
local doorRCargoState = 0

-- Canopy handling
dev:listen_command(Keys.toggleDoors)
dev:listen_command(device_commands.miscTailWheelLock)
dev:listen_command(device_commands.doorCplt)
dev:listen_command(device_commands.doorPlt)
dev:listen_command(device_commands.doorLGnr)
dev:listen_command(device_commands.doorRGnr)
dev:listen_command(device_commands.doorLCargo)
dev:listen_command(device_commands.doorRCargo)
dev:listen_command(Keys.toggleCopilotDoor)
dev:listen_command(Keys.toggleLeftCargoDoor)
dev:listen_command(Keys.toggleRightCargoDoor)
dev:listen_command(Keys.toggleLeftGunnerDoor)
dev:listen_command(Keys.toggleRightGunnerDoor)

-- Wipers
dev:listen_command(device_commands.wiperSelector)

function post_initialize()
    tailWheelLockedState = 0
    tailWheelLocked = 0
	local dev = GetSelf()
    tailWheelLockPwrState = paramCB_TAILWHEELLOCK:get()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
		dev:performClickableAction(device_commands.miscTailWheelLock, 1, true)
    elseif birth=="GROUND_COLD" then
    end
end

function SetCommand(command,value)
    if command == device_commands.miscTailWheelLock then
        if paramCB_TAILWHEELLOCK:get() > 0 then
            tailWheelLockTarget = 1 - tailWheelLocked
        end
    elseif command == device_commands.wiperSelector then
		wiperMode = round(value * 3)
    elseif command == Keys.toggleDoors then
		if canopyTargetState <= 1 then
			canopyTargetState = 1 - canopyTargetState
		end
    elseif command == device_commands.doorCplt then
        doorCpltTgt = 1 - doorCpltTgt
    elseif command == device_commands.doorLGnr then
        doorLGnrTgt = 1 - doorLGnrTgt
    elseif command == device_commands.doorRGnr then
        doorRGnrTgt = 1 - doorRGnrTgt
    elseif command == device_commands.doorLCargo then
        doorLCargoTgt = 1 - doorLCargoTgt
    elseif command == device_commands.doorRCargo then
        doorRCargoTgt = 1 - doorRCargoTgt
    elseif command == Keys.toggleCopilotDoor then
        doorCpltTgt = 1 - doorCpltTgt
    elseif command == Keys.toggleLeftCargoDoor then
        doorLCargoTgt = 1 - doorLCargoTgt
    elseif command == Keys.toggleRightCargoDoor then
        doorRCargoTgt = 1 - doorRCargoTgt
    elseif command == Keys.toggleLeftGunnerDoor then
        doorLGnrTgt = 1 - doorLGnrTgt
    elseif command == Keys.toggleRightGunnerDoor then
        doorRGnrTgt = 1 - doorRGnrTgt
    end
end

function updateDoor(tgt, state)
    local animSpeed = 0.01

    if state ~= tgt then
        if state > tgt then
            state = state - math.min(animSpeed, state - tgt)
        else
            state = state + math.min(animSpeed, tgt - state)
        end
    end

    return state
end

function update()
    if paramCB_LTSLWRCSL:get() > 0 then
        -- TWL turns on automatically when power first applied
        if tailWheelLockPwrState == 0 and paramCB_LTSLWRCSL:get() == 1 then
            --print_message_to_user("auto lock")
            tailWheelLockPwrState = 1
            tailWheelLockTarget = 1			  
        end
        
        if tailWheelLockTarget ~= tailWheelLockedState and tailWheelLockedState > -1 then
            --print_message_to_user("start transition")
            tailWheelLockedState = -1
            tailWheelLockTime = get_absolute_model_time()
        end
        
        if tailWheelLockedState == -1 and get_absolute_model_time() - tailWheelLockTime > 2 then
            --print_message_to_user("end transition")
            tailWheelLockedState = tailWheelLockTarget
            tailWheelLocked = tailWheelLockTarget
        end

        --print_message_to_user(tailWheelLockedState)
        dispatch_action(nil, EFM_commands.lockTailWheel, tailWheelLocked)

        if tailWheelLockedState >= 0 then
            paramTailWheelLockLight:set(tailWheelLocked * tailWheelLockPwrState)
        else
            paramTailWheelLockLight:set(0.5)
        end
    end
    -- Wipers
	local wiperBaseSpeed = 0.01
	local wiperVal = get_aircraft_draw_argument_value(630)
	local speedMult = wiperMode - 1

	if wiperMode == 0 then
		if wiperVal > 0 then
			set_aircraft_draw_argument_value(630, wiperVal -wiperBaseSpeed)
		end
	elseif wiperMode == 2 or wiperMode == 3 then
		if wiperVal <= 0 then
			wiperFwd = true
		elseif wiperVal >= 1 then
			wiperFwd = false
		end

		if wiperFwd and wiperVal < 1 then
			set_aircraft_draw_argument_value(630, wiperVal + wiperBaseSpeed * speedMult)
		elseif wiperFwd == false and wiperVal > 0 then
			set_aircraft_draw_argument_value(630, wiperVal - wiperBaseSpeed * speedMult)
		end
	end

	-- Handle canopy (doors)
	local canopyPos = get_aircraft_draw_argument_value(38)

	if (canopyTargetState == 0 and canopyPos > 0) then
        canopyPos = canopyPos - 0.01
        set_aircraft_draw_argument_value(38, canopyPos)
	elseif (canopyTargetState == 1 and canopyPos <= 0.89) then
		canopyPos = canopyPos + 0.01
        set_aircraft_draw_argument_value(38, canopyPos)
	end

    -- Doors
    doorCpltState = updateDoor(doorCpltTgt, doorCpltState)
    doorLGnrState = updateDoor(doorLGnrTgt, doorLGnrState)
    doorRGnrState = updateDoor(doorRGnrTgt, doorRGnrState)
    doorLCargoState = updateDoor(doorLCargoTgt, doorLCargoState)
    doorRCargoState = updateDoor(doorRCargoTgt, doorRCargoState)

    
    --print_message_to_user(doorCpltState)
    
    set_aircraft_draw_argument_value(400, doorCpltState)
    set_aircraft_draw_argument_value(401, doorLCargoState)
    set_aircraft_draw_argument_value(402, doorRCargoState)
    set_aircraft_draw_argument_value(403, doorLGnrState)
    set_aircraft_draw_argument_value(404, doorRGnrState)

    get_param_handle("PLT_DOOR_GLASS"):set(get_aircraft_draw_argument_value(38))
    get_param_handle("CPLT_DOOR_GLASS"):set(get_aircraft_draw_argument_value(400))
    get_param_handle("L_GNR_DOOR_GLASS"):set(get_aircraft_draw_argument_value(403))
    get_param_handle("R_GNR_DOOR_GLASS"):set(get_aircraft_draw_argument_value(404))
    get_param_handle("L_CARGO_DOOR_GLASS"):set(get_aircraft_draw_argument_value(401))
    get_param_handle("R_CARGO_DOOR_GLASS"):set(get_aircraft_draw_argument_value(402))
end

need_to_be_closed = false