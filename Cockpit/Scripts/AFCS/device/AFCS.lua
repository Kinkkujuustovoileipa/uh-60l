dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 0.01 
make_default_activity(update_time_step)

local paramBoostLight = get_param_handle("LIGHTING_AFCS_BOOST")
local paramSAS1Light = get_param_handle("LIGHTING_AFCS_SAS1")
local paramSAS2Light = get_param_handle("LIGHTING_AFCS_SAS2")
local paramTrimLight = get_param_handle("LIGHTING_AFCS_TRIM")
local paramFPSLight = get_param_handle("LIGHTING_AFCS_FPS")
local paramStabLight = get_param_handle("LIGHTING_AFCS_STABAUTO")

local paramBoost = get_param_handle("AFCS_BOOST")
local paramSAS1 = get_param_handle("AFCS_SAS1")
local paramSAS2 = get_param_handle("AFCS_SAS2")
local paramTrim = get_param_handle("AFCS_TRIM")
local paramFPS = get_param_handle("AFCS_FPS")
local paramStabAuto = get_param_handle("AFCS_STABAUTO")

local paramCautionSAS = get_param_handle("CAP_SASOFF");
local paramCautionBoost = get_param_handle("CAP_BOOSTSERVOOFF");
local paramCautionFPS = get_param_handle("CAP_FLTPATHSTAB");

local btnBoostState = 0
local btnSas1State = 0
local btnSas2State = 0
local btnTrimState = 0
local btnFPSState = 0
local btnStabAutoState = 0

local stabPwrState = 0

local boostOn = 0
local sas1On = 0
local sas2On = 0
local trimOn = 0
local fpsOn = 0
local stabAutoOn = 0

local manSlewDir = 0

function post_initialize()
	local dev = GetSelf()
	stabPwrState = paramCB_STABCONTR1:get() * paramCB_STABCONTR2:get()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
		dev:performClickableAction(device_commands.afcsStabAuto,1,true)			  
		dev:performClickableAction(device_commands.afcsBoost,1,true)			  
		dev:performClickableAction(device_commands.afcsSAS1,1,true)			  
		dev:performClickableAction(device_commands.afcsSAS2,1,true)			  
		dev:performClickableAction(device_commands.afcsTrim,1,true)
		dev:performClickableAction(device_commands.afcsFPS,1,true)
		update()	  
    elseif birth=="GROUND_COLD" then
    end

end

dev:listen_command(device_commands.afcsStabAuto)
dev:listen_command(device_commands.afcsBoost)
dev:listen_command(device_commands.afcsSAS1)
dev:listen_command(device_commands.afcsSAS2)
dev:listen_command(device_commands.afcsTrim)
dev:listen_command(device_commands.afcsFPS)
dev:listen_command(device_commands.slewStabUp)
dev:listen_command(device_commands.slewStabDown)
dev:listen_command(Keys.slewStabUp)
dev:listen_command(Keys.slewStabDown)

function SetCommand(command,value)   
    if command == device_commands.afcsStabAuto then
		btnStabAutoState = 1 - btnStabAutoState
	elseif command == device_commands.afcsBoost then
		btnBoostState = 1 - btnBoostState
	elseif command == device_commands.afcsSAS1 then
		btnSas1State = 1 - btnSas1State
	elseif command == device_commands.afcsSAS2 then
		btnSas2State = 1 - btnSas2State
	elseif command == device_commands.afcsTrim then
		btnTrimState = 1 - btnTrimState
	elseif command == device_commands.afcsFPS then
		btnFPSState = 1 - btnFPSState
	elseif command == device_commands.slewStabUp then
		btnStabAutoState = 0
		manSlewDir = value
	elseif command == device_commands.slewStabDown then
		btnStabAutoState = 0
		manSlewDir = value
	elseif command == Keys.slewStabDown then -- I don't know why but this only works if it's ass backward...
		if value > 11.3 then
			dev:performClickableAction(device_commands.slewStabUp,-1,true)
			--dispatch_action(nil,device_commands.slewStabUp,1)
		else
			dev:performClickableAction(device_commands.slewStabUp,0,true)
			--dispatch_action(nil,device_commands.slewStabUp,0)
		end
	elseif command == Keys.slewStabUp then
		if value > 11.3 then
			dev:performClickableAction(device_commands.slewStabDown,1,true)
			--dispatch_action(nil,device_commands.slewStabDown,-1)
		else
			dev:performClickableAction(device_commands.slewStabDown,0,true)
			--dispatch_action(nil,device_commands.slewStabDown,0)
		end
	end
end

function update()
	updateNetworkArgs(GetSelf())
	boostOn = btnBoostState * paramCB_SASBOOST:get()
	sas1On = btnSas1State * paramCB_SASBOOST:get()
	sas2On = btnSas2State * paramCB_COMP:get()
	trimOn = btnTrimState * paramCB_COMP:get()
	fpsOn = btnFPSState * paramCB_COMP:get()
	
	-- Stab Auto turns on automatically when power first applied
	if stabPwrState == 0 and (paramCB_STABCONTR1:get() * paramCB_STABCONTR2:get()) == 1 then
		dev:performClickableAction(device_commands.afcsStabAuto,1,true)			  
		stabPwrState = 1
	end
	
	stabAutoOn = btnStabAutoState * stabPwrState

	paramBoostLight:set(boostOn)
	paramSAS1Light:set(sas1On)
	paramSAS2Light:set(sas2On)
	paramTrimLight:set(trimOn)
	paramFPSLight:set(fpsOn)
	paramStabLight:set(stabAutoOn)

	paramBoost:set(boostOn)
	paramSAS1:set(sas1On)
	paramSAS2:set(sas2On)
	paramTrim:set(trimOn)
	paramFPS:set(fpsOn)
	paramStabAuto:set(stabAutoOn)

	paramCautionSAS:set(1 - sas2On)
	paramCautionBoost:set(1 - boostOn)
	--paramCautionFPS:set(1 - fpsOn)

	if stabAutoOn > 0 then
		manSlewDir = 0
	end

	if manSlewDir > 0 then
		dispatch_action(nil, EFM_commands.slewStabUp, 1)
	elseif manSlewDir < 0 then
		dispatch_action(nil, EFM_commands.slewStabDown, 1)
	end
end

need_to_be_closed = false 