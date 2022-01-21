dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL}

--subset ids
LT  = 1
UTC = 2
FLT = 3
SW  = 4
DC  = 5

page_subsets  =
{
    [LT]  = LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/localTime.lua",
    [UTC] = LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/utc.lua",
    [FLT] = LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/flightTimer.lua",
    [SW]  = LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/stopwatch.lua",
    [DC]  = LockOn_Options.script_path.."LC6Chronometer/indicator/pilot/downcounter.lua",
}

pages =
{
    {
        LT,
        UTC,
        FLT,
        SW,
        DC,
    },
}