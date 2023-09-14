
symbols = 
{
	-- SA-2/SA-3/SA-5 Search radar "Flat Face"
	["p-19 s-125 sr"] =
	{
		symbol = "2a",

	},

	-- SA-2 TR "Fan Song"
	["SNR_75V"] =
	{
		symbol = "2a",

	},

	-- SA-3 TR "Low Blow"
	["snr s-125 tr"] = 
	{
		symbol = "3a"
	},

	-- SA-5 SR "Tin Shield"
	["RLS_19J6"] = 
	{
		symbol = "5a"
	},

	-- SA-5 TR "Square Pair"
	["RPC_5N62V"] = 
	{
		symbol = "5a"
	},

	-- SA-6 STR
	["Kub 1S91 str"] = 
	{
		symbol = "6a"
	},

	-- SA-11 LN
	["SA-11 Buk LN 9A310M1"] = 
	{
		symbol = "11a"
	},

	-- SA-11 SR
	["SA-11 Buk SR 9518M1"] = 
	{
		symbol = "11a"
	},

	-- SA-8
	["Osa 9A33 ln"] = 
	{
		symbol = "8a"
	},

	-- Shilka
	["ZSU-23-4 Shilka"] = 
	{
		symbol = "B"
	},

	-- SA-10 SR "Big Bird"
	["S-300PS 64H6E sr"] = 
	{
		symbol = "10a"
	},

	-- SA-10 SR "Clam Shell"
	["S-300PS 40B6MD sr"] = 
	{
		symbol = "10a"
	},

	-- SA-10 TR
	["S-300PS 40B6M tr"] = 
	{
		symbol = "10a"
	},

	-- SA-15
	["Tor 9A331"] = 
	{
		symbol = "8a"
	},

	-- Gepard
	["Gepard"] = 
	{
		symbol = "A"
	},
}

eyes ={}	-- sensor locations
eyes[1] =
{
	position      = {x = 1.479,y = -0.472,z =  0.674}, --{Forward/Back,U/D,L/R}
	orientation   = {azimuth  = math.rad(45),elevation = math.rad(0.0)},
	field_of_view = math.rad(120) 
}
eyes[2] =
{
	position      = {x = 1.479,y = -0.472,z = -0.674},
	orientation   = {azimuth  = math.rad(-45),elevation = math.rad(0.0)},
	field_of_view = math.rad(120) 
}
eyes[3] =
{
	position      = {x = -1.196,y = 0.519,z =  0.21},
	orientation   = {azimuth  = math.rad(135),elevation = math.rad(0.0)},
	field_of_view = math.rad(120) 
}
eyes[4] =
{
	position      = {x = -1.196,y = 0.519,z =  -0.21},
	orientation   = {azimuth  = math.rad(-135),elevation = math.rad(0.0)},
	field_of_view = math.rad(120) 
}

wordlist =
{
	[1] = {
		name = "acquisition",
		length = 1,
		param = "SND_INST_APR39_ACQUISITION"
	},
	[2] = {
		name = "apr39failure",
		length = 2,
		param = "SND_INST_APR39_FAILURE"
	},
	[3] = {
		name = "apr39operational",
		length = 2,
		param = "SND_INST_APR39_OPERATIONAL"
	},
	[4] = {
		name = "apr39powerup",
		length = 2,
		param = "SND_INST_APR39_POWERUP"
	},
	[5] = {
		name = "eight",
		length = 0.6,
		param = "SND_INST_APR39_EIGHT"
	},
	[51] = {
		name = "eight2",
		length = 0.6,
		param = "SND_INST_APR39_EIGHT2"
	},
	[6] = {
		name = "eleven",
		length = .3,
		param = "SND_INST_APR39_ELEVEN"
	},
	[60] = {
		name = "eleven2",
		length = .3,
		param = "SND_INST_APR39_ELEVEN"
	},
	[7] = {
		name = "five",
		length = .3,
		param = "SND_INST_APR39_FIVE"
	},
	[70] = {
		name = "five2",
		length = .3,
		param = "SND_INST_APR39_FIVE"
	},
	[8] = {
		name = "fixedwing",
		length = 2,
		param = "SND_INST_APR39_FIXEDWING"
	},
	[81] = {
		name = "fixedwing2",
		length = 2,
		param = "SND_INST_APR39_FIXEDWING2"
	},
	[9] = {
		name = "four",
		length = .3,
		param = "SND_INST_APR39_FOUR"
	},
	[91] = {
		name = "four2",
		length = .3,
		param = "SND_INST_APR39_FOUR2"
	},
	[10] = {
		name = "gun",
		length = 1,
		param = "SND_INST_APR39_GUN"
	},
	[101] = {
		name = "gun2",
		length = 1,
		param = "SND_INST_APR39_GUN2"
	},
	[11] = {
		name = "helicopter",
		length = 1,
		param = "SND_INST_APR39_HELICOPTER"
	},
	[12] = {
		name = "launch",
		length = 1,
		param = "SND_INST_APR39_LAUNCH"
	},
	[13] = {
		name = "lockbroken",
		length = 1,
		param = "SND_INST_APR39_LOCKBROKEN"
	},
	[14] = {
		name = "missile",
		length = 1,
		param = "SND_INST_APR39_MISSILE"
	},
	[15] = {
		name = "nine",
		length = .3,
		param = "SND_INST_APR39_NINE"
	},
	[16] = {
		name = "oclock",
		length = .8,
		param = "SND_INST_APR39_OCLOCK"
	},
	[17] = {
		name = "one",
		length = 0.3,
		param = "SND_INST_APR39_ONE"
	},
	[18] = {
		name = "radarsearching",
		length = 2,
		param = "SND_INST_APR39_RADARSEARCHING"
	},
	[19] = {
		name = "sa",
		length = 1,
		param = "SND_INST_APR39_SA"
	},
	[192] = {
		name = "sa2",
		length = 1,
		param = "SND_INST_APR39_SA2"
	},
	[20] = {
		name = "selftest",
		length = 1,
		param = "SND_INST_APR39_SELFTEST"
	},
	[21] = {
		name = "seven",
		length = .6,
		param = "SND_INST_APR39_SEVEN"
	},
	[22] = {
		name = "signallost",
		length = 1,
		param = "SND_INST_APR39_SIGNALLOST"
	},
	[23] = {
		name = "six",
		length = .3,
		param = "SND_INST_APR39_SIX"
	},
	[232] = {
		name = "six2",
		length = .3,
		param = "SND_INST_APR39_SIX2"
	},
	[24] = {
		name = "ten",
		length = .5,
		param = "SND_INST_APR39_TEN"
	},
	[240] = {
		name = "ten2",
		length = .5,
		param = "SND_INST_APR39_TEN"
	},
	[25] = {
		name = "degraded",
		length = 1,
		param = "SND_INST_APR39_DEGRADED"
	},
	[26] = {
		name = "restored",
		length = 1,
		param = "SND_INST_APR39_RESTORED"
	},
	[27] = {
		name = "three",
		length = .5,
		param = "SND_INST_APR39_THREE"
	},
	[271] = {
		name = "three2",
		length = .5,
		param = "SND_INST_APR39_THREE2"
	},
	[28] = {
		name = "tracking",
		length = 1,
		param = "SND_INST_APR39_TRACKING"
	},
	[29] = {
		name = "twelve",
		length = .4,
		param = "SND_INST_APR39_TWELVE"
	},
	[30] = {
		name = "twenty",
		length = 0.8,
		param = "SND_INST_APR39_TWENTY"
	},
	[31] = {
		name = "two",
		length = .5,
		param = "SND_INST_APR39_TWO"
	},
	[310] = {
		name = "two2",
		length = .5,
		param = "SND_INST_APR39_TWO"
	},
	[32] = {
		name = "unknown",
		length = 1,
		param = "SND_INST_APR39_UNKNOWN"
	},
	[33] = {
		name = "zu",
		length = 1,
		param = "SND_INST_APR39_ZU"
	},
	[331] = {
		name = "zu2",
		length = 1,
		param = "SND_INST_APR39_ZU2"
	},
	[34] = {
		name = "delay1",
		length = 1,
		param = ""
	},
	[35] = {
		name = "shortdelay",
		length = 0.3,
		param = ""
	}
}

reportedContacts = {}

rwr = {}
for i = 1,10 do	
	rwr[i] =
	{
		-- from CockpitBase.dll
		elevation 	= get_param_handle("RWR_CONTACT_0" .. i .. "_ELEVATION"),
		time		= get_param_handle("RWR_CONTACT_0" .. i .. "_TIME"),
		source		= get_param_handle("RWR_CONTACT_0" .. i .. "_SOURCE"),
		priority	= get_param_handle("RWR_CONTACT_0" .. i .. "_PRIORITY"),
		unit_type	= get_param_handle("RWR_CONTACT_0" .. i .. "_UNIT_TYPE"), -- f-16=16, su-27=27 etc				
		general_type= get_param_handle("RWR_CONTACT_0" .. i .. "_GENERAL_TYPE"), -- 1:plane, 2:SAM+AAA radar, 3:ship
		signal		= get_param_handle("RWR_CONTACT_0" .. i .. "_SIGNAL"), -- 1:search, 2:lock, 3: launch
		azimuth 	= get_param_handle("RWR_CONTACT_0" .. i .. "_AZIMUTH"),
		power 		= get_param_handle("RWR_CONTACT_0" .. i .. "_POWER"), -- 0-1
			
		-- custom
		unit_type_sym	= get_param_handle("RWR_CONTACT_0" .. i .. "_UNIT_TYPE_SYM"),
		adjusted_power 	= get_param_handle("RWR_CONTACT_0" .. i .. "_POWER_ADJUSTED"),
		lock_sym 		= get_param_handle("RWR_CONTACT_0" .. i .. "_LOCK_SYM"),
	}
end

