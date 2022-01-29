dofile(LockOn_Options.common_script_path..'wsTypes_SAM.lua')
dofile(LockOn_Options.common_script_path..'wsTypes_Airplane.lua')
dofile(LockOn_Options.common_script_path..'wsTypes_Ship.lua')
dofile(LockOn_Options.common_script_path..'wsTypes_Missile.lua')
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

update_time_step = 0.1
audio_time_step = 1
make_default_activity(update_time_step) 
local dev = GetSelf()
local radian_to_degree = 57.2957795
--render_debug_info = true

local apr39PowerSwitchOn = false
rwrPower = get_param_handle("APR39_POWER")
rwrBrightness = get_param_handle("APR39_BRIGHTNESS")
volume = 1

annunciatorBusy = false
prompter = {}
wordDelay = 0
lastWord = ""
highestPrioIndex = 1

rwr = {}

lastRWRTable = {}
-----------------------------------------------------------------------------
MaxThreats          = 10
EmitterLiveTime     = 7.0
EmitterSoundTime    = 0.5
LaunchSoundDelay    = 15.0
DefaultType          = 100
RWR_detection_coeff = 0.85

dofile(LockOn_Options.script_path..'APR39/device/tables.lua')

function post_initialize()
	--GetDevice(devices.RWR):set_power(true)	
	GetDevice(devices.APR39):set_power(true) -- actives the RWR script internally 
	dev:performClickableAction(device_commands.RWRBrightness,1,true)
	dev:performClickableAction(device_commands.apr39Volume,1,true)
	rwrBrightness:set(1)
	local birth = LockOn_Options.init_conditions.birth_place	--"GROUND_COLD","GROUND_HOT","AIR_HOT"
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then   
        dev:performClickableAction(device_commands.apr39Power,1,true) --true or false do action
		rwrPower:set(1)
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.apr39Power,0,true)	
		rwrPower:set(0)
    end

	--updateRWRTable()
end

dev:listen_command(device_commands.apr39Power)
dev:listen_command(device_commands.apr39Volume)
dev:listen_command(device_commands.apr39Brightness)

function SetCommand(command,value)
    if command == device_commands.apr39Power then
		apr39PowerSwitchOn = value == 1
	elseif command == device_commands.apr39Volume then
		volume = value
		--print_message_to_user("vol: "..volume)
	elseif command == device_commands.apr39Brightness then
		rwrBrightness:set(value)
	end
end

function synthesiseSpeech(activity, parameters, highPriority)
	-- only one voice at a time
	--print_message_to_user("anunc state: "..tostring(annunciatorBusy).." curr prompt: "..Dump(prompter))
	if annunciatorBusy and highPriority == false then
		return
	end
	
	--print_message_to_user("synthesising: "..activity.." : "..Dump(parameters).." : "..tostring(annunciatorBusy))
	-- Lua doesn't do switch statements :(
	if (activity == "poweron") then
		prompter[#prompter + 1] = {"apr39operational"}
	elseif (activity == "selfteststart") then
		prompter[#prompter + 1] = {"selftest"}
	elseif (activity == "contact") then
		for k,v in pairs(parameters) do
			prompter[#prompter + 1] = v
		end
		prompter[#prompter + 1] = "delay1"
	end
	--print_message_to_user(Dump(prompter))
end

function speak()
	wordDelay = wordDelay - update_time_step
	if (wordDelay > 0) then
		return
	end

	local lastSound = get_param_handle(lastWord)
	lastSound:set(0)
	
	if next(prompter) == nil then
		annunciatorBusy = false
		return
	end
	
	annunciatorBusy = true
	
	-- say first word
	local wordData = {}
	
	for k,v in pairs(wordlist) do
		if (v.name == prompter[1]) then
			--print_message_to_user("V: "..v.name.." : "..prompter[1])
			wordData = v
		end
	end

	wordDelay = wordData.length + 0.1
	--print_message_to_user("word delay: "..wordDelay)
	
	if (wordData.param ~= "") then
		--print_message_to_user("Speaking: "..wordData.param)
		local sound = get_param_handle(wordData.param)
		--print_message_to_user(sound)
		sound:set(0) -- make sure it is off first
		sound:set(volume)
		lastWord = wordData.param
	end

	table.remove(prompter, 1)

	-- add 1 second gap at end of sentence
	if next(prompter) == nil then
		wordDelay = wordDelay + 1
	end
end

function getClockValue(azimuth)

	azimuth = 360 - (azimuth * radian_to_degree)
	local clockValue
	if (azimuth < 15 or azimuth >= 345) then
		clockValue = "twelve"
	elseif (azimuth >= 15 and azimuth < 45) then
		clockValue = "one"
	elseif (azimuth >= 45 and azimuth < 75) then
		clockValue = "two"
	elseif (azimuth >= 75 and azimuth < 105) then
		clockValue = "three"
	elseif (azimuth >= 105 and azimuth < 135) then
		clockValue = "four"
	elseif (azimuth >= 135 and azimuth < 165) then
		clockValue = "five"
	elseif (azimuth >= 165 and azimuth < 195) then
		clockValue = "six"
	elseif (azimuth >= 195 and azimuth < 225) then
		clockValue = "seven"
	elseif (azimuth >= 225 and azimuth < 255) then
		clockValue = "eight"
	elseif (azimuth >= 255 and azimuth < 285) then
		clockValue = "nine"
	elseif (azimuth >= 285 and azimuth < 315) then
		clockValue = "ten"
	elseif (azimuth >= 315 and azimuth < 345) then
		clockValue = "eleven"
	end

	--print_message_to_user("Clock: "..clockValue.."; Az: "..azimuth)
	return clockValue
end

function getSAMType(samData)
	local samType
	if samData.unit_type_sym:get() == "a8" then
		samType = "eight2"
	elseif samData.unit_type_sym:get() == "a10" then
		samType = "ten2"
	elseif samData.unit_type_sym:get() == "a11" then
		samType = "eleven2"
	elseif samData.unit_type_sym:get() == "a6" then
		samType = "six2"
	elseif samData.unit_type_sym:get() == "a5" then
		samType = "five2"
	elseif samData.unit_type_sym:get() == "a4" then
		samType = "four2"
	elseif samData.unit_type_sym:get() == "a3" then
		samType = "three2"
	elseif samData.unit_type_sym:get() == "a2" then
		samType = "two2"
	elseif samData.unit_type_sym:get() == "B" then
		samType = "zu"
	elseif samData.unit_type_sym:get() == "A" then
		samType = "gun"
	else
		samType = "unknown"
	end

	return samType
end

function newRadarSearching(contactData)
	--print_message_to_user("radar searching: "..contactData.unit_type:get())
	local params = {"radarsearching"}
	synthesiseSpeech("contact", params, false)
end

function signalLost(contactData)
	-- have we lost all tracks?
	local noTracks = true
	for k,v in pairs(rwr) do
		if (v.signal:get() > 0) then
			local noTracks = false
		end
	end
	if noTracks then
		--print_message_to_user("signal lost: "..contactData.unit_type:get())
		local params = {"signallost"}
		synthesiseSpeech("contact", params, false)
	end
end

function newRadarTracking(contactData)
	local clockValue = getClockValue(contactData.azimuth:get())
	--print_message_to_user(contactData.unit_type:get().." tracking from "..clockValue.." type: "..contactData.general_type:get())
	if contactData.general_type:get() == 1 then
		local params = {"fixedwing", "fixedwing2", clockValue, "oclock", "shortdelay","tracking"}
		synthesiseSpeech("contact", params, true)
	elseif contactData.general_type:get() == 2 then
		local samType = getSAMType(contactData)
		--print_message_to_user("SAM Type: "..samType)
		if samType ~= nil and samType ~= "" then
			-- Handle guns and zu's differently
			local params
			if samType == "gun" then
				params = {"gun", "gun2", clockValue, "oclock", "shortdelay","tracking"}
			elseif samType == "zu" then
				params = {"zu", "zu2", "twenty", "three2", clockValue, "oclock", "shortdelay","tracking"}
			else
				params = {"sa", "sa2", samType, clockValue, "oclock", "shortdelay","tracking"}
			end
			synthesiseSpeech("contact", params, true)
		end
	end
end

function newRadarLaunch(contactData)
	--print_message_to_user("launch: "..contactData.unit_type:get())
	local clockValue = getClockValue(contactData.azimuth:get())
	if contactData.general_type:get() == 1 then
		local params = {"fixedwing", "fixedwing2", samType, clockValue, "oclock", "launch"}
		synthesiseSpeech("contact", params, true)
	elseif contactData.general_type:get() == 2 then
		local samType = getSAMType(contactData)

		if samType ~= nil and samType ~= "" then
			local params = {"sa", "sa2", samType, clockValue, "oclock", "launch"}
			synthesiseSpeech("contact", params, true)
		end
	end
end

function contactSignalChanged(contactData)
	local currentType = contactData.unit_type:get()
	local newSignal = contactData.signal:get()
	--print_message_to_user("change: "..currentType..":"..newSignal)
	local azimuth = contactData.azimuth:get()

	if (newSignal == 1) then
		newRadarSearching(contactData)
	elseif (newSignal == 0) then
		signalLost(contactData)
	elseif (newSignal == 2) then
		newRadarTracking(contactData)
	elseif (newSignal == 3) then
		newRadarLaunch(contactData)
	end
end

function doVisual()
	local className

	for i = 1,10 do
		if rwr[i].signal:get() == 2 then				-- 2 Lock
			rwr[i].lock_sym:set(1)
		elseif rwr[i].signal:get() == 3 then			-- 3 Launch
			rwr[i].lock_sym:set(1-rwr[i].lock_sym:get()) --flashes symbol
		else	-- 1 Search or 0 nothing
			rwr[i].lock_sym:set(0)
		end
		
		rwr[i].adjusted_power:set(1-rwr[i].power:get() + 0.1)
		
		className = rwr[i].unit_type:get()
		if rwr[i].general_type:get() == 1 then -- Fixed Wing
			rwr[i].unit_type_sym:set("E")
		elseif rwr[i].general_type:get() == 2 then -- SAM or AAA
			local symbol
			for k,v in pairs(symbols) do
				if className == k then
					symbol = v.symbol
				end
			end
			
			if not symbol then
				symbol = "U"
			end
			
			rwr[i].unit_type_sym:set(symbol)
		elseif rwr[i].general_type:get() == 3 then -- ships
			rwr[i].unit_type_sym:set("U")
		end
	end
	--print_message_to_user(Dump(rwr[1].unit_type:get()))
end

function doAudio()
	audio_time_step = audio_time_step - update_time_step

	tempTable = {}
	--print_message_to_user(Dump(lastRWRTable))
	if (audio_time_step <= 0) then
		--compare changes and send events
		for k,v in pairs(rwr) do
			local currentType = v.unit_type:get()
			--print_message_to_user("checking: "..currentType.." at index "..k.." with signal: "..v.signal:get())
			--print_message_to_user(currentType)
			if (currentType == 0) then
				break
			end
			
			local currentSignal = v.signal:get()
			local currentAzimuth = v.azimuth:get()
			local currentSource = v.source:get()

			-- Iterate through this step and last step's RWR list, compare and mark appropriate changes as updates, push to event handlers
			--print_message_to_user(currentType)
			local isNewContact = true
			--iterate through old
			local exitLoop = false
			--print_message_to_user(Dump(lastRWRTable))
			if next(lastRWRTable) == nil then
				lastRWRTable = {{unit_type = currentType, source = currentSource, signal = currentSignal}}
				contactSignalChanged(v, 0, currentSignal)
				--print_message_to_user("Register unit: "..currentType..": "..currentSource..": "..currentSignal)
			else
				for k2,v2 in pairs(lastRWRTable) do
					if exitLoop == false then
						--print_message_to_user(currentType..":"..v2.unit_type:get())
						--print_message_to_user(source..":"..v2.source:get())
						if (currentType == v2.unit_type and currentSource == v2.source) then-- and source == v2.source:get()) then
							isNewContact = false
							--print_message_to_user("in: "..currentSignal..":"..v2.signal)
							-- type and pos haven't changed, has signal?
							if currentSignal == v2.signal then
								break
							else
								--print_message_to_user("Detected change: "..currentSignal.." to "..v2.signal.." at "..get_absolute_model_time())
								tempTable[#tempTable + 1] = v
								--contactSignalChanged(v, v2.signal, currentSignal) -- signal update 'event'
								v2.signal = currentSignal;
							end
							exitLoop = true
						end
					end
				end
			end
			if isNewContact then
				--print_message_to_user("Register unit: "..currentType..": "..currentSource..": "..currentSignal.." at "..#lastRWRTable+1)
				lastRWRTable[#lastRWRTable+1] = {unit_type = currentType, source = currentSource, signal = currentSignal}
				tempTable[#tempTable + 1] = v
				--contactSignalChanged(v, 0, currentSignal)
			end
		end
		--updateRWRTable()
		audio_time_step = 1
	end

	-- Clean any duplicates - this has to be done as some SAMs e.g. SA-6 are switching on and off their radar each step
	for k, v in pairs(tempTable) do
		local type = v.unit_type
		local source = v.source:get()
		local signal = v.signal:get()

		for i, j in pairs(tempTable) do
			--print_message_to_user("Checking dupes: "..k.." at "..source.." with: "..i.." at "..j.source:get())
			if (k ~= i and source == j.source:get()) then
				--delete both entries, usually no actual change has occurred
				tempTable[k] = nil
				tempTable[i] = nil
			end

			-- Let's remove searching and loss change duplicates too, so only reporting max one per update
			if (k ~= i and signal == 1 and j.signal:get() == 1) then
				tempTable[i] = nil
			end

			if (k ~= i and signal == 0 and j.signal:get() == 0) then
				tempTable[i] = nil
			end
		end
	end

	-- Now we should have no duplicates, trigger the events
	for k, v in pairs(tempTable) do
		--print_message_to_user(v.unit_type:get().." : "..v.signal:get())
		contactSignalChanged(v) -- signal update 'event'
	end
end

function update()
	updateNetworkArgs(GetSelf())
	--print_message_to_user(Dump(dev))
	if paramCB_APR39:get() == 1 and apr39PowerSwitchOn then
		GetDevice(devices.APR39):set_power(true) -- actives the RWR script internally 

		rwrPower:set(1) -- used for the indicator/display
		doVisual()
		doAudio()
		speak()

		--print_message_to_user(rwrPower:get().."; "..rwrBrightness:get())
	else
		rwrPower:set(0)
		--GetDevice(devices.APR39):set_power(false) -- actives the RWR script internally 	
	end
end


--[[
		RWR_CONTACT_01_ELEVATION:-0.000844
		RWR_CONTACT_01_SOURCE:16778240		16777472
		RWR_CONTACT_01_TIME:3.200000
		RWR_CONTACT_01_UNIT_TYPE:"MiG-29S"
		RWR_CONTACT_01_GENERAL_TYPE:1.000000
		RWR_CONTACT_01_PRIORITY:160.910660
		RWR_CONTACT_01_AZIMUTH:1.671934
		RWR_CONTACT_01_SIGNAL:1.000000
		RWR_CONTACT_01_POWER:0.910663
]]--