dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

local update_time_step = 0.1  
make_default_activity(update_time_step)
local device = GetSelf()

local paramCB = get_param_handle(paramCB_CHAFFDISP)

local paramFlareCounterTens	= get_param_handle("M130_FLARECOUNTER_TENS")
local paramFlareCounterOnes	= get_param_handle("M130_FLARECOUNTER_ONES")
local paramChaffCounterTens	= get_param_handle("M130_CHAFFCOUNTER_TENS")
local paramChaffCounterOnes	= get_param_handle("M130_CHAFFCOUNTER_ONES")
local paramArmedLight		= get_param_handle("M130_ARMED_LIGHT")

local hasPower = false
local chaffDisplayCount = device:get_chaff_count()
local flareDisplayCount = 0
local cmArmed = false
local chaffDispenseMode = 0

device:listen_command(device_commands.cmFlareDispenseModeCover)
device:listen_command(device_commands.cmFlareCounterDial)
device:listen_command(device_commands.cmChaffCounterDial)
device:listen_command(device_commands.cmArmSwitch)
device:listen_command(device_commands.cmProgramDial)
device:listen_command(device_commands.cmChaffDispense)
device:listen_command(Keys.dispenseChaffDown)
device:listen_command(Keys.dispenseChaffUp)

function SetCommand(command,value)
    if command == device_commands.cmArmSwitch then
		cmArmed = value > 0
	elseif command == device_commands.cmChaffCounterDial then
		chaffDisplayCount = chaffDisplayCount + round(value * 10)
		if chaffDisplayCount < 0 then chaffDisplayCount = 0 end
		if chaffDisplayCount > 99 then chaffDisplayCount = 99 end
	elseif command == device_commands.cmFlareCounterDial then
		flareDisplayCount = flareDisplayCount + round(value * 10)
		if flareDisplayCount < 0 then flareDisplayCount = 0 end
		if flareDisplayCount > 99 then flareDisplayCount = 99 end
	elseif command == device_commands.cmChaffDispense then
		if hasPower and chaffDisplayCount > 0 and device:get_chaff_count() > 0 and cmArmed and value > 0 then
			device:drop_chaff()
			chaffDisplayCount = chaffDisplayCount - 1
		end
	elseif command == Keys.dispenseChaffDown then
		device:performClickableAction(device_commands.cmChaffDispense,1,true)
	elseif command == Keys.dispenseChaffUp then
		device:performClickableAction(device_commands.cmChaffDispense,0,true)
	end
end

function update()
	hasPower = paramCB:get() > 0
	if cmArmed and hasPower then
		paramArmedLight:set(1)
	else
		paramArmedLight:set(0)
	end

	local chaffCounterTens = jumpwheel(chaffDisplayCount, 2)
    local chaffCounterOnes = jumpwheel(chaffDisplayCount, 1)

	paramChaffCounterTens:set(chaffCounterTens)
	paramChaffCounterOnes:set(chaffCounterOnes)

	local flareCounterTens = jumpwheel(flareDisplayCount, 2)
    local flareCounterOnes = jumpwheel(flareDisplayCount, 1)

	paramFlareCounterTens:set(flareCounterTens)
	paramFlareCounterOnes:set(flareCounterOnes)
end

--[[
GetDevice(devices.WEAPON_SYSTEM) metatable:
weapons meta["__index"] = {}
weapons meta["__index"]["get_station_info"] = function: 00000000CCCC5780
weapons meta["__index"]["listen_event"] = function: 00000000CCC8E000
weapons meta["__index"]["drop_flare"] = function: 000000003C14E208
weapons meta["__index"]["set_ECM_status"] = function: 00000000CCCC76E0
weapons meta["__index"]["performClickableAction"] = function: 00000000CCE957B0
weapons meta["__index"]["get_ECM_status"] = function: 00000000CCE37BC0
weapons meta["__index"]["launch_station"] = function: 00000000CCC36A30
weapons meta["__index"]["SetCommand"] = function: 00000000CCE52820
weapons meta["__index"]["get_chaff_count"] = function: 00000000CCBDD650
weapons meta["__index"]["emergency_jettison"] = function: 00000000CCC26810
weapons meta["__index"]["set_target_range"] = function: 000000003AB0FDD0
weapons meta["__index"]["set_target_span"] = function: 0000000027E4E970
weapons meta["__index"]["get_flare_count"] = function: 00000000CCCC57D0
weapons meta["__index"]["get_target_range"] = function: 00000000CCC26710
weapons meta["__index"]["get_target_span"] = function: 00000000CCCC7410
weapons meta["__index"]["SetDamage"] = function: 00000000CCC384B0
weapons meta["__index"]["drop_chaff"] = function: 00000000CCE37AA0
weapons meta["__index"]["select_station"] = function: 00000000CC5C26F0
weapons meta["__index"]["listen_command"] = function: 0000000038088060
weapons meta["__index"]["emergency_jettison_rack"] = function: 00000000720F15F0
--]]

need_to_be_closed = false -- lua_state  will be closed in post_initialize()
