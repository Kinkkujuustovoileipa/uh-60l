--[[
sounds ids 1 ... n
]]
local count = 0
local function counter()
	count = count + 1
	return count
end

SOUND_NOSOUND = -1
TOGGLECLICK_LEFT_FWD = counter()
SWITCH_BASIC = counter()
AFC_BUTTON_1 = counter()
AFC_BUTTON_2 = counter()
AFC_BUTTON_3 = counter()
AFC_BUTTON_4 = counter()
PARKING_BRAKE_UP = counter()
PARKING_BRAKE_DOWN = counter()
ESS_FWD = counter()
ESS_BACK = counter()
ECL_TO_IDLE = counter()
ECL_TO_OFF = counter()
