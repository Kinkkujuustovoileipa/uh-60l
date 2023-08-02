dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

dev = GetSelf()
sensor_data = get_base_data()
update_time_step = 0.01 
make_default_activity(update_time_step)

paramAlt100   = get_param_handle("PILOT_BAROALT_10000") -- 0 to 100,000
paramAlt1000  = get_param_handle("PILOT_BAROALT_1000") -- 0 to 10,000
paramAlt10000 = get_param_handle("PILOT_BAROALT_100") -- 0 to 1000
paramBaroSetNxxx = get_param_handle("PILOT_BAROALT_ADJ_Nxxx") -- 1st digit, 0-10 is input
paramBaroSetxNxx = get_param_handle("PILOT_BAROALT_ADJ_xNxx") -- 2nd digit, 0-10 input
paramBaroSetxxNx = get_param_handle("PILOT_BAROALT_ADJ_xxNx") -- 3rd digit, 0-10 input
paramBaroSetxxxN = get_param_handle("PILOT_BAROALT_ADJ_xxxN") -- 4th digit, 0-10 input
paramEncoderFlag = get_param_handle("PILOT_BAROALT_ENCODER_FLAG") -- 4th digit, 0-10 input

dev:listen_command(Keys.pilotBarometricScaleSet_AXIS)
dev:listen_command(Keys.pilotBarometricScaleSetInc)
dev:listen_command(Keys.pilotBarometricScaleSetDec)

baroScaleSetCmd = device_commands.pilotBarometricScaleSet
baroScaleSetCmd_Axis = Keys.pilotBarometricScaleSet_AXIS
baroScaleSetCmdInc = Keys.pilotBarometricScaleSetInc
baroScaleSetCmdDec = Keys.pilotBarometricScaleSetDec


dofile(LockOn_Options.script_path.."AAU32A/device/altimeterCore.lua")

function update()
	updateNetworkArgs(GetSelf())
	powerState = paramCB_PILOTALTM:get()
	update_altimeter(powerState)
end

need_to_be_closed = false 