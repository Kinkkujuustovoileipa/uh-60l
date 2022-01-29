dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local dev 	    = GetSelf()

local update_time_step = 1
device_timer_dt = update_time_step

innerNoise = getInnerNoise(2.5E-6, 10.0)
frequency_accuracy = 500.0
band_width = 12E3
power = 10.0
goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

agr =
{
  input_signal_deviation = rangeUtoDb(4E-6, 0.5),
  output_signal_deviation = 5 - (-4),
  input_signal_linear_zone = 10.0,
  regulation_time = 0.25,
}

GUI =
{
  range = {min = 225E6, max = 399.975E6, step = 25E3},
  displayName = "UHF Radio AN/ARC-164",
  AM = true,
  FM = true,
}

function post_initialize()
  dev:set_frequency(261E6)
  dev:set_modulation(MODULATION_AM)
end

need_to_be_closed = false
