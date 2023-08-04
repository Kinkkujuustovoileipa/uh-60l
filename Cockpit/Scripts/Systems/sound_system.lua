dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."sound_class.lua")

local SOUND_SYSTEM = GetSelf()
local update_time_step = 0.1  --20 time per second
make_default_activity(update_time_step)
device_timer_dt     = 0.1  	--0.2

local sensor_data = get_base_data()

function debug_print(message)
    -- print_message_to_user(message)
end

-- params
--local param_catapult_takeoff = get_param_handle("SOUND_CAT_TAKEOFF")


local sounds

function post_initialize()
    -- initialise soundhosts
    sndhost_aircraft    = create_sound_host("AIRCRAFT","3D",0,0,0)
    sndhost_cockpit     = create_sound_host("COCKPIT","3D",0,0,0)
    sndhost_phones      = create_sound_host("HEADPHONES","2D",0,0,0)
    
    sounds =
    {
        -- Misc
        Sound_Player(sndhost_cockpit, "a-4e_CockpitRattle", "SND_ALWS_COCKPIT_RATTLE", SOUND_ALWAYS, nil, nil, 1.0, 2.0 / device_timer_dt ),
        
        -- APU & Electrics
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorAPUStartUp", "SND_INST_APU_START", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorAPUShutoff", "SND_INST_APU_SHUTOFF", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorAPU", "SND_CONT_APU", SOUND_CONTINUOUS),
        Sound_Player(sndhost_cockpit, "DC_power", "SND_CONT_DC", SOUND_CONTINUOUS),
        Sound_Player(sndhost_cockpit, "AC_power", "SND_CONT_AC", SOUND_CONTINUOUS),
        
        -- Engine 1
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine1Starter", "SND_INST_ENG1_STARTER", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine1Combustion", "SND_INST_ENG1_COMBUST", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine1Shutdown", "SND_INST_ENG1_SHUTDOWN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine1ShutdownShort", "SND_INST_ENG1_SHUTDOWN_SHORT", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine1StarterCont", "SND_CONT_ENG1_STARTER_IDLE", SOUND_CONTINUOUS, nil, nil, 1.0, 2.0 / device_timer_dt),

        -- Engine 2
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine2Starter", "SND_INST_ENG2_STARTER", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine2Combustion", "SND_INST_ENG2_COMBUST", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine2Shutdown", "SND_INST_ENG2_SHUTDOWN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine2ShutdownShort", "SND_INST_ENG2_SHUTDOWN_SHORT", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorEngine2StarterCont", "SND_CONT_ENG2_STARTER_IDLE", SOUND_CONTINUOUS, nil, nil, 1.0, 2.0 / device_timer_dt),

        -- XMSN
        Sound_Player(sndhost_cockpit, "Aircrafts/Engines/UH-60L/uh60l_InteriorRotorIdle", "SND_CONT_XMSN_IDLE", SOUND_CONTINUOUS),
        Sound_Player(sndhost_aircraft, "Aircrafts/Engines/UH-60L/uh60l_BladeSlap", "SND_ALWS_BLADE_SLAP", SOUND_ALWAYS, 0, nil, 1.0, 2.0 / device_timer_dt, "RRPM" ),

        -- APR-39
        Sound_Player(sndhost_cockpit, "APR39/acquisition", "SND_INST_APR39_ACQUISITION", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/ap39failure", "SND_INST_APR39_FAILURE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/apr39operational", "SND_INST_APR39_OPERATIONAL", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/apr39powerup", "SND_INST_APR39_POWERUP", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/eight", "SND_INST_APR39_EIGHT", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/eight", "SND_INST_APR39_EIGHT2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/eleven", "SND_INST_APR39_ELEVEN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/five", "SND_INST_APR39_FIVE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/fixedwing", "SND_INST_APR39_FIXEDWING", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/fixedwing", "SND_INST_APR39_FIXEDWING2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/four", "SND_INST_APR39_FOUR", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/four", "SND_INST_APR39_FOUR2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/gun", "SND_INST_APR39_GUN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/gun", "SND_INST_APR39_GUN2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/helicopter", "SND_INST_APR39_HELICOPTER", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/launch", "SND_INST_APR39_LAUNCH", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/lockbroken", "SND_INST_APR39_LOCKBROKEN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/missile", "SND_INST_APR39_MISSILE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/nine", "SND_INST_APR39_NINE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/oclock", "SND_INST_APR39_OCLOCK", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/one", "SND_INST_APR39_ONE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/radarsearching", "SND_INST_APR39_RADARSEARCHING", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/sa", "SND_INST_APR39_SA", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/sa", "SND_INST_APR39_SA2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/selftest", "SND_INST_APR39_SELFTEST", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/seven", "SND_INST_APR39_SEVEN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/signallost", "SND_INST_APR39_SIGNALLOST", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/six", "SND_INST_APR39_SIX", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/six", "SND_INST_APR39_SIX2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/ten", "SND_INST_APR39_TEN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/degraded", "SND_INST_APR39_DEGRADED", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/restored", "SND_INST_APR39_RESTORED", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/three", "SND_INST_APR39_THREE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/three", "SND_INST_APR39_THREE2", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/tracking", "SND_INST_APR39_TRACKING", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/twelve", "SND_INST_APR39_TWELVE", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/twenty", "SND_INST_APR39_TWENTY", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/two", "SND_INST_APR39_TWO", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/unknown", "SND_INST_APR39_UNKNOWN", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/zu", "SND_INST_APR39_ZU", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "APR39/zu", "SND_INST_APR39_ZU2", SOUND_ONCE),

        -- ARC-201
        Sound_Player(sndhost_cockpit, "ARC201/FM1/250ms600hzBeep", "SND_INST_ARC201FM1_250MS600HZBEEP", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "ARC201/FM1/750ms600hzBeep", "SND_INST_ARC201FM1_750MS600HZBEEP", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "ARC201/FM2/250ms600hzBeep", "SND_INST_ARC201FM2_250MS600HZBEEP", SOUND_ONCE),
        Sound_Player(sndhost_cockpit, "ARC201/FM2/750ms600hzBeep", "SND_INST_ARC201FM2_750MS600HZBEEP", SOUND_ONCE),
    }
end

function update()
    --printsec(get_param_handle("SND_INST_ENG_STARTER"):get())
    for index, sound in pairs(sounds) do
        sound:update()
    end
end

-- Reset = -1, Play == 1
function playSoundOnceByParam(start_sound, stop_sound, param)
    if param:get() > -1 then
        if start_sound then
            if param:get() == 0 and start_sound:is_playing() then
                start_sound:stop()
                if stop_sound then
                    stop_sound:play_once()
                end
            else
                start_sound:play_once()
            end
        end
        param:set(-1)
    end
end

need_to_be_closed = false -- close lua state after initialization
