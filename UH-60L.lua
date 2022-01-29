
local function fuel_tank_230(clsid)
	local data =
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= clsid,
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("CEFS Fuel Tank 200 gallons"),
		Weight_Empty	= 132,
		Weight			= 132 + 598.09478, -- 200USG = 757.082 liter * 0.79kg/l fuel weight 
		Cx_pil		= 0.000956902,
		shape_table_data = 
		{
			{
				name	= "UH60_FUEL_TANK_230";
				file	= "fueltank230";
				life	= 1;
				fire	= { 0, 1};
				username	= "UH60_FUEL_TANK_230";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "fueltank230",
			}, 
		}, 
	}
	declare_loadout(data)
end

fuel_tank_230("{UH60_FUEL_TANK_230}")

UH60L =
{
	Name										=	'UH-60L',
	Picture										=	'UH-60L.png',	-- Mission editor loadout picture
	DisplayName									=	_('UH-60L'),

	shape_table_data 	=
	{
		{
			file  	    = 'UH-60L';
			username    = 'UH-60L';
			desrt		= 'UH-60L_destr';
			index       =  WSTYPE_PLACEHOLDER;
			life  	    = 16; --   The strength of the object (ie. lifebar *)
			vis   	    = 3; -- Visibility factor (For a small objects is better to put lower nr).
			fire  	    = { 300, 2}; -- Fire on the ground after destoyed: 300sec 4m
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  ="UH-60L_destr";
			file  ="UH-60L_destr";
			fire  = { 240, 2};
		},
	},

	mapclasskey 		= "P0091000020", -- Utility Helo MIL-2525 symbol
	attribute  			= {wsType_Air, wsType_Helicopter, wsType_Battleplane, WSTYPE_PLACEHOLDER ,"Attack helicopters", "Refuelable"},
	Categories 			= {},
	Rate 				= 30,  -- RewardPoint in Multiplayer
	Countries 			= {"USA"},
	-------------- Aircraft Physical properties -----------
	length				= 19.76, -- meters
	height				= 5.13,-- meters
	rotor_RPM			= 258,
	M_empty				= 5675, --kg
	M_nominal			= 8500, --kg
	M_max				= 10659.421, --kg 23500lbs
	M_fuel_max			= 1362, -- kg	1 litre = 0.79 kg	1362.75l
	RCS					= 10, -- Radar Cross Section m^2
	IR_emission_coeff	= 0.22, -- 1 is IR emission of Su-27
	------------------------ Gear ---------------------------------------------
	nose_gear_pos 							 = {-7.436, -2.55, 0}, -- {forward/back,up/down,left/right}  used for initial aircraft placement
	--nose_gear_amortizer_direct_stroke        = 0, -- down from nose_gear_pos
	--nose_gear_amortizer_reversal_stroke      = -0.14, -- max strut compression up from nose_gear_pos
	--nose_gear_amortizer_normal_weight_stroke = -0.05,
	nose_gear_wheel_diameter				 = 0.35, 
	
	tand_gear_max							 = math.tan(180), -- nosewheel steering angle.  (tan(32.6)=0.64  +/-32 degrees) 
	
	main_gear_pos 							 = {2.658, -2.7, 1.35},	-- used for initial aircraft placement
	--main_gear_amortizer_direct_stroke	     = 0, --  down from main_gear_pos 
	--main_gear_amortizer_reversal_stroke      = -0.48, --   max strut compression up from main_gear_pos 
	--main_gear_amortizer_normal_weight_stroke = -0.4,
	main_gear_wheel_diameter				 = 0.5,
	------------------ AI defs ------------------------------
	-- From UH-60A AI (mostly)
	V_max				=	355.584, -- this must be in kph? 192kts
	V_max_cruise		=	296.32,	-- cruise speed 160kts
	Vy_max				=	12.8, --Max climb speed in m/s
	H_stat_max_L		=	4170,
	H_max 				=	5500, --km, max operation height
	H_stat_max			=	3170,
	H_din_two_eng		=	5790,
	H_din_one_eng		=	2900,
	range				=	600, --km, for AI
	flight_time_typical	=	110,
	flight_time_maximum	=	138,
	Vy_land_max			=	12.8, -- landing speed
	Ny_max				=	1.7, --max G for AI
	Sensors =
	{	-- defines what the AI can use in terms of sensors
           OPTIC = {"TADS DVO"}, -- AI can engage enemy at night
           RWR = "Abstract RWR"
	},
	--CanopyGeometry = makeHelicopterCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	CanopyGeometry =
	{
           azimuth   = {-100.0, 120.0}, -- pilot view horizontal (AI)
           elevation = {-50.0, 110.0}, -- pilot view vertical (AI)
    },
	---------------------- unknown ---------------------------------------------
	lead_stock_main		=	-0.1,
	lead_stock_support	=	-0.1,
	scheme				=	0,
	fire_rate			=	625,
	cannon_sight_type	=	0,
	------------ AI flight model probably (doesnt affect human FM)---------------
	rotor_height		=	1.791,-- meters
	rotor_diameter		=	16.4,
	blade_chord			=	0.5334,
	blades_number		=	4,
	blade_area			=	3.48,
	fuselage_Cxa0		=	0.45,
	fuselage_Cxa90		=	5.9,
	fuselage_area		=	4.9,
	centering			=	-0.09,
	tail_pos 			= 	{-10.042, 1.76, 0},
	tail_fin_area		=	4.75,
	tail_stab_area		=	2.94,
	thrust_correction	=	0.75,--0.75,
	rotor_MOI			=	8700,
	rotor_pos 			= 	{ 0, 1.646, 0 },

	-- Refuel stuff
    is_tanker                   =  false,
    tanker_type                 =  2,                     -- Tanker type if the plane is tanker
	air_refuel_receptacle_pos   =  {10.586, -1.568, 1.325},

	helicopter_hook_pos = { 0, -2, 0 },
	cargo_radius_in_menu = 2000,

	engines_count		=	4, -- don't ask, you don't want to know...
	engines_nozzles =
	{
	    -------------------------ENGINE LEFT-------------------------
		{
			pos     		= {-2.9, 0.1, -1.1}, -- important for heatblur effect
			diameter      = 0.13,
			engine_number = 1,
			--exhaust_length_ab	=	1,
			--exhaust_length_ab_K	=	0.76,
			smokiness_level = 0.01,
		},
		{
			pos     		= {-2.9, 0.1, 1.1}, -- important for heatblur effect
			diameter      = 0.13,
			engine_number = 2,
			--exhaust_length_ab	=	1,
			--exhaust_length_ab_K	=	0.76,
			smokiness_level = 0.01,
		}
	},

	sounderName = "Aircraft/Planes/UH-60L",

	crew_size = 4,
	crew_members =
	{
		[1] =
		{	ejection_seat_name	=	0, -- name of object file used for pilot ejection
			drop_canopy_name	=	0, -- name of object file used for canopy jettison
			pos = 	{5.2,0.6,0.1}, -- used for ejection location
			ejection_order    = 1,
			can_be_playable  = true,
			role = "pilot",
			role_display_name = _("Pilot"),
			canopy_arg           = 38, 
		},
		[2] =
		{	ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{5.2,0.6,0.1},
			ejection_order    = 2,
			--pilot_body_arg  = 501,
			can_be_playable  = true,
			role = "instructor",
			role_display_name = _("Copilot"),
			canopy_arg           = 38, 
		},
		[3] =
		{	ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{4.0,0.6,0.1},
			ejection_order    = 3,
			--pilot_body_arg  = 501,
			can_be_playable  = true,
			role = "lgunner",
			role_display_name = _("Left Gunner"),
			canopy_arg           = 38, 
		},
		[4] =
		{	ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{4.0,0.6,0.1},
			ejection_order    = 4,
			--pilot_body_arg  = 501,
			can_be_playable  = true,
			role = "rgunner",
			role_display_name = _("Right Gunner"),
			canopy_arg           = 38, 
		},
	},

	fires_pos =
	{
		[1] = {-2.9, 0.1, -1.1}, -- left turbine exit
		[2] = {-2.9, 0.1, 1.1}, -- right turbine exit
	},

	passivCounterm =
	{
		CMDS_Edit = false,
		SingleChargeTotal = 30,
		chaff = {default = 30, increment = 30, chargeSz = 1},
		flare = {default = 0, increment = 0, chargeSz = 0},
	},

    chaff_flare_dispenser =
	{
        [1] = { dir =  {45, 0, -20}, pos =  {-0.672, -1.273, -4.041}, },
    },

	Guns =
	{
	},

	stores_number = 4,

	Pylons =
	{
		pylon(1, 0, 0.797, -1.244, 2.844,
            {
               use_full_connector_position = true,
			   connector = "pylon4",
			   arg = 123,
			   DisplayName = "L Outbd"
            },
            {
				{
					CLSID = "{UH60_FUEL_TANK_230}",
					arg_value = 1,
					attach_point_position = {0, 0, 0},
					required = {{station = 4,loadout = {"{UH60_FUEL_TANK_230}"}}},
					attach_point_oriented = true
				},
				{
					CLSID = "<CLEAN>",
					arg_value = 0,
					required =
					{
						{station = 2,loadout = {"<CLEAN>"}},
						{station = 3,loadout = {"<CLEAN>"}},
						{station = 4,loadout = {"<CLEAN>"}},
					},
				},

            }
        ),
        pylon(2, 0, 0.797, -1.244, 2.058,
            {
               use_full_connector_position = true,
			   connector = "pylon3",
			   arg = 123,
			   DisplayName = "L Inbd"
            },
            {
				{
					CLSID = "{UH60_FUEL_TANK_230}",
					arg_value = 1,
					attach_point_position = {0, 0, 0},
					required = {{station = 3,loadout = {"{UH60_FUEL_TANK_230}"}}},
					attach_point_oriented = true
				},
				{
					CLSID = "<CLEAN>",
					arg_value = 0,
					required =
					{
						{station = 1,loadout = {"<CLEAN>"}},
						{station = 3,loadout = {"<CLEAN>"}},
						{station = 4,loadout = {"<CLEAN>"}},
					},
				},
            }
        ),
        pylon(3, 0, 0.797, -1.244, -2.058,
            {
               use_full_connector_position = true,
			   connector = "pylon2",
			   arg = 123,
			   DisplayName = "R Inbd"
            },
            {
				{
					CLSID = "{UH60_FUEL_TANK_230}",
					arg_value = 1,
					attach_point_position = {0, 0, 0},
					required = {{station = 2,loadout = {"{UH60_FUEL_TANK_230}"}}},
					attach_point_oriented = true
				},
				{
					CLSID = "<CLEAN>",
					arg_value = 0,
					required =
					{
						{station = 1,loadout = {"<CLEAN>"}},
						{station = 2,loadout = {"<CLEAN>"}},
						{station = 4,loadout = {"<CLEAN>"}},
					},
				},
            }
        ),
        pylon(4, 0, 0.797, -1.244, -2.844,
            {
               use_full_connector_position = true,
			   connector = "pylon1",
			   arg = 123,
			   DisplayName = "R Inbd"
            },
            {
				{
					CLSID = "{UH60_FUEL_TANK_230}",
					arg_value = 1,
					attach_point_position = {0, 0, 0},
					required = {{station = 1,loadout = {"{UH60_FUEL_TANK_230}"}}},
					attach_point_oriented = true
				},
				{
					CLSID = "<CLEAN>",
					arg_value = 0,
					required =
					{
						{station = 1,loadout = {"<CLEAN>"}},
						{station = 2,loadout = {"<CLEAN>"}},
						{station = 3,loadout = {"<CLEAN>"}},
					},
				},
            }
        ),
	},

	Tasks =
	{ 	-- defined in db_units_planes.lua
        aircraft_task(Transport),
        aircraft_task(Reconnaissance),
    },
	DefaultTask = aircraft_task(Transport),

	LandRWCategories = 	-- adds these takeoff and landing options avaliable in mission editor
    {
		[1] =
        {
           Name = "HelicopterCarrier",
        },
        [2] =
        {
           Name = "AircraftCarrier",
        },
    },
	TakeOffRWCategories =
    {	[1] =
        {
            Name = "HelicopterCarrier",
        },
        [2] =
        {
           Name = "AircraftCarrier",
        },
    },

	Damage = verbose_to_dmg_properties( --index meaning see in Scripts\Aircrafts\_Common\Damage.lua
	{		-- deps_cells defines what other parts get destroyed along with it
		["MAIN"]  			= {critical_damage = 10, args = {151}},
		["TAIL"]			= {critical_damage = 4, args = {159}, deps_cells = {"BLADE_5_IN", "BLADE_5_CENTER", "BLADE_6_IN", "BLADE_6_CENTER"}},
		["BLADE_1_IN"]		= {critical_damage = 1, args = {161}}, -- 64
		["BLADE_1_CENTER"]	= {critical_damage = 1, args = {161}, deps_cells = {"BLADE_1_IN"}}, -- 65
		["BLADE_2_IN"]		= {critical_damage = 1, args = {162}}, -- 67
		["BLADE_2_CENTER"]	= {critical_damage = 1, args = {162}, deps_cells = {"BLADE_2_IN"}}, -- 68
		["BLADE_3_IN"]		= {critical_damage = 1, args = {163}}, -- 70
		["BLADE_3_CENTER"]	= {critical_damage = 1, args = {163}, deps_cells = {"BLADE_3_IN"}}, -- 71
		["BLADE_4_IN"]		= {critical_damage = 1, args = {164}}, -- 73
		["BLADE_4_CENTER"]	= {critical_damage = 1, args = {164}, deps_cells = {"BLADE_4_IN"}}, -- 74
		["BLADE_5_IN"]		= {critical_damage = 1, args = {165}}, -- 76
		["BLADE_5_CENTER"]	= {critical_damage = 1, args = {165}, deps_cells = {"BLADE_5_IN"}}, -- 77
		["BLADE_6_IN"]		= {critical_damage = 1, args = {166}}, -- 79
		["BLADE_6_CENTER"]	= {critical_damage = 1, args = {166}, deps_cells = {"BLADE_6_IN"}}, -- 80
		["WHEEL_R"]         = {critical_damage = 3},
		["WHEEL_L"]         = {critical_damage = 3},
		["WHEEL_F"]         = {critical_damage = 3},
	}),

	Failures =
	{ -- not working yet
		{ id = 'engfail',	label = _('ENGINE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'rotor',		label = _('ROTOR'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

	DamageParts =
	{	-- parts that fall off when aircraft is hit or crashes
		[1] = "UH-60L_Tail",  --wing right
		[2] = "UH-60L_Skid",  --wing left
		--[3] = "",    --nose part
		[4] = "UH-60L_Skid",  -- tail part
		[5] = "UH-60L_Rotor",	--blade
	},

	--transmits draw arguments over multiplyer for others to see
	net_animation = 
	{   
		9, --collective
		11, -- stick roll
		15, --stick pitch
		37,-- main rotor spin
		14, -- stab
		900, -- rotor blur
		22, -- probe
		122, -- probe extension
		123, -- esss
		-- LIGHTS
		600, -- lower white ac
		601, -- upper white ac
		602, -- lower red ac
		603, -- upper red ac
		604, -- pos l/r non esss
		605, -- cabin blue
		606, -- cabin white
		607, -- ll extend/retract
		608, -- ll toggle
		609, -- pos l/r esss
		610, -- pos tail
		611, -- sl extend/retract
		612, -- sl swivel
		613, -- sl toggle
		614, -- formation lights
		250, -- glareshield
		251, -- dome light
		-- DOORS
		38, -- plt door
		400, -- cplt door
		401, -- l cargo door
		402, -- r cargo door
		403, -- l gunner hatch
		404, -- r gunner hatch
		-- AND THAT'S ALL FOLKS! 32
		--501, -- pedal brakes
	},

	--sound_name = "Rotor", -- rotor sound from Sounds/sdef

	engine_data =
	{  -- most of these are unknown right now, but they are only for AI
		power_take_off	=	473,
		power_max	=	473,
		power_WEP	=	473,
		power_TH_k =
		{
			[1] = 	{0,	-230.8,	2245.6},
			[2] = 	{0,	-230.8,	2245.6},
			[3] = 	{0,	-325.4,	2628.9},
			[4] = 	{0,	-235.6,	1931.9},
		},
		SFC_k = 	{2.045e-007,	-0.0006328,	0.803},
		power_RPM_k = 	{-0.08639,	0.24277,	0.84175},
		power_RPM_min	=	9.1384,
		--sound_name	= "EngineTV3117", -- engine sound from Sounds/sdef
	},

	HumanRadio =
	{
        frequency     = 124.0,
        editable     = true,
        minFrequency     = 30.000,
        maxFrequency     = 399.975,
		rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
        modulation     = MODULATION_AM
    },

    panelRadio =
	{
        [1] =
		{
            name = _("AN/ARC-201 (1)"), --30 to 87.975 MHz FM
            range =
			{
                {min = 30.0, max = 87.975}
            },
			channels =
			{
				[1] = { name = _("AN/ARC-201 Channel 1"),	default = 30.0}, --, connect = true}, -- default
				[2] = { name = _("AN/ARC-201 Channel 2"),	default = 31.0},
				[3] = { name = _("AN/ARC-201 Channel 3"),	default = 32.0},
				[4] = { name = _("AN/ARC-201 Channel 4"),	default = 33.0},
				[5] = { name = _("AN/ARC-201 Channel 5"),	default = 40.0},
				[6] = { name = _("AN/ARC-201 Channel 6"),	default = 41.0},
				[7] = { name = _("AN/ARC-201 Channel 0"),	default = 42.0},
				[8] = { name = _("AN/ARC-201 Channel RG"),	default = 50.0},
			},
        },
		[2] =
		{
			name = _("AN/ARC-164(V)"), -- 225.000 to 399.975 MHz AM
			range =
			{
				{min = 225.0, max = 399.975}
			},
			channels =
			{  -- matches L-39C except for channel 8, which was changed to a Georgian airport and #20 which is NTTR only (for now).  This radio goes 1-20 not 0-19.
				[1] = { name = _("AN/ARC-164 Channel 1"),	default = 264.0},	-- mineralnye-vody (URMM) : 264.0
				[2] = { name = _("AN/ARC-164 Channel 2"),	default = 265.0},	-- nalchik (URMN) : 265.0
				[3] = { name = _("AN/ARC-164 Channel 3"),	default = 256.0},	-- sochi-adler (URSS) : 256.0
				[4] = { name = _("AN/ARC-164 Channel 4"),	default = 254.0},	-- maykop-khanskaya (URKH), nellis (KLSV) : 254.0
				[5] = { name = _("AN/ARC-164 Channel 5"),	default = 250.0},	-- anapa (URKA) : 250.0
				[6] = { name = _("AN/ARC-164 Channel 6"),	default = 270.0},	-- beslan (URMO) : 270.0
				[7] = { name = _("AN/ARC-164 Channel 7"),	default = 257.0},	-- krasnodar-pashkovsky (URKK) : 257.0
				[8] = { name = _("AN/ARC-164 Channel 8"),	default = 258.0},	-- sukhumi-babushara (UGSS) : 255.0
				[9] = { name = _("AN/ARC-164 Channel 9"),	default = 262.0},	-- kobuleti (UG5X) : 262.0
				[10] = { name = _("AN/ARC-164 Channel 10"),	default = 259.0},	-- gudauta (UG23) : 259.0
				[11] = { name = _("AN/ARC-164 Channel 11"),	default = 268.0},	-- tbilisi-soganlug (UG24) : 268.0
				[12] = { name = _("AN/ARC-164 Channel 12"),	default = 269.0},	-- tbilisi-vaziani (UG27) : 269.0
				[13] = { name = _("AN/ARC-164 Channel 13"),	default = 260.0},	-- batumi (UGSB) : 260.0
				[14] = { name = _("AN/ARC-164 Channel 14"),	default = 263.0},	-- kutaisi-kopitnari (UGKO) : 263.0
				[15] = { name = _("AN/ARC-164 Channel 15"),	default = 261.0},	-- senaki-kolkhi (UGKS) :  261.0
				[16] = { name = _("AN/ARC-164 Channel 16"),	default = 267.0},	-- tbilisi-lochini (UGTB) : 267.0
				[17] = { name = _("AN/ARC-164 Channel 17"),	default = 251.0},	-- krasnodar-center (URKI), creech (KINS) : 251.0
				[18] = { name = _("AN/ARC-164 Channel 18"),	default = 253.0},	-- krymsk (URKW), mccarran (KLAS) : 253.0
				[19] = { name = _("AN/ARC-164 Channel 19"),	default = 266.0},	-- mozdok (XRMF) : 266.0
				[20] = { name = _("AN/ARC-164 Channel 20"),	default = 252.0},	-- N/A, groom lake/homey (KXTA) : 252.0
			},
		},
		[3] =
		{
            name = _("AN/ARC-186(V)"), --116.000 to 151.975 MHz AM
            range =
			{
                {min = 30.000, max = 151.975}
            },
			channels =
			{
				[1] = { name = _("AN/ARC-186 Channel 1"),	default = 124.000}, --, connect = true}, -- default
				[2] = { name = _("AN/ARC-186 Channel 2"),	default = 127.500}, --, connect = true}, -- default
			},
        },
		[4] =
		{
            name = _("AN/ARC-201 (2)"), --30 to 87.975 MHz FM
            range =
			{
                {min = 30.0, max = 87.975}
            },
			channels =
			{
				[1] = { name = _("AN/ARC-201 Channel 1"),	default = 30.0}, --, connect = true}, -- default
				[2] = { name = _("AN/ARC-201 Channel 2"),	default = 31.0},
				[3] = { name = _("AN/ARC-201 Channel 3"),	default = 32.0},
				[4] = { name = _("AN/ARC-201 Channel 4"),	default = 33.0},
				[5] = { name = _("AN/ARC-201 Channel 5"),	default = 40.0},
				[6] = { name = _("AN/ARC-201 Channel 6"),	default = 41.0},
				[7] = { name = _("AN/ARC-201 Channel 0"),	default = 42.0},
				[8] = { name = _("AN/ARC-201 Channel RG"),	default = 50.0},
			},
        },
		[5] =
		{
            name = _("AN/ARC-220"), -- 2.000 to 29.9999 MHz
            range =
			{
                {min = 2.0, max = 29.9999}
            },
			channels =
			{
				[1] = { name = _("AN/ARC-220 Channel 1"),	default = 3.000}, --, connect = true}, -- default
				[2] = { name = _("AN/ARC-220 Channel 2"),	default = 10.00}, --, connect = true}, -- default
			},
        },
    },

	lights_data =
	{
		typename =	"collection",
		lights 	 = 
		{
			[1]	=
			{
				typename	=	"collection", -- strobe
				lights =
				{
					{typename = "argnatostrobelight", argument_1 = 600, period = 1.2, phase_shift = 0},	-- white lower
					{typename = "argnatostrobelight", argument_1 = 601, period = 1.2, phase_shift = 0},	-- white upper
				},
			},
			[2]	=
			{
				typename = "collection", -- spot
				lights =
				{
					{typename  = "argumentlight",	argument  = 613}, -- landing light?
				},
			},
			[3]	=
			{
				typename = "collection", -- nav
				lights =
				{
					{typename  = "argumentlight",	argument  = 604}, -- left/right
					{typename  = "argumentlight",	argument  = 610}, -- tail
					{typename  = "argumentlight",	argument  = 251}, -- tail
					{typename  = "argumentlight",	argument  = 605}, -- tail
				},
			},
			[4]	=
			{
				typename = "collection", -- formation
				lights =
				{
					{typename  = "argumentlight",	argument  = 614},
				},
			},
			[5] = {}, -- tips
            [6] = {}, -- refuel
            [7] =
			{
				typename	=	"collection", -- strobe
				lights =
				{
					{typename = "argnatostrobelight", argument_1 = 602, period = 1.2, phase_shift = 0},	-- red lower
					{typename = "argnatostrobelight", argument_1 = 603, period = 1.2, phase_shift = 0},	-- red upper
				},
			},  -- Anti-Collision
		},
	},

	-- Aircraft Additional Properties
	AddPropAircraft =
	{
		{
			id = "FuelProbeEnabled",
			control = "checkbox",
			label = _("Enable Fuel Probe"),
			defValue = false,
			weightWhenOn = 80
		},
		{id = "SoloFlight", control = 'checkbox' , label = _('Solo Flight'), defValue = false, weightWhenOn = -80},
		{id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
		  values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Instructor")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}},
		  defValue  = 1,
		  wCtrl     = 150
		},
	},
}

add_aircraft(UH60L)
