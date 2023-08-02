dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local dev 	    = GetSelf()

device_timer_dt = 0.2

innerNoise 			= getInnerNoise(2.5E-6, 10.0)--V/m (dB S+N/N)
frequency_accuracy 	= 0				--Hz
band_width			= 12E3				--Hz (6 dB selectivity)
power 				= 10.0				--Watts
goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

agr =
{
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI =
{
	range = {min = 108.0E6, max = 126.95E6, step = 25E3}, --Hz
	displayName = 'Radio Receiving Set AN/ARN-147',
	AM = true,
	FM = true,
}

local update_time_step = 0.1 --update will be called once per second
device_timer_dt = update_time_step

function post_initialize()
  --efm_data_bus.fm_setAvionicsAlive(1.0)
  dev:set_frequency(108.0E6)

  dev:set_modulation(MODULATION_AM) -- gives DCS.log INFO msg:  COCKPITBASE: avBaseRadio::ext_set_modulation not implemented, used direct set

  --str_ptr = string.sub(tostring(dev.link),10)
  --efm_data_bus.fm_setRadioPTR(str_ptr)
end

function listen_event()
	--print_message_to_user("LISTEN_EVENT")
end

function SetCommand(command,value)

end

need_to_be_closed = false -- close lua state after initialization
