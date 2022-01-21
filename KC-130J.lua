WOLALIGHT_STROBES 		   = 1--must be collection
WOLALIGHT_SPOTS  		   = 2--must be collection
WOLALIGHT_NAVLIGHTS 	   = 3--must be collection
WOLALIGHT_FORMATION_LIGHTS = 4--must be collection
WOLALIGHT_TIPS_LIGHTS      = 5--must be collection

KC130J =
{

	Name 				=   'KC130J',
	DisplayName			= _('KC-130J'),

	Picture 			= "KC130.png",
	Rate 				= 70, -- RewardPoint in Multiplayer
	Shape 				= "kc-130",
		
    WorldID == WSTYPE_PLACEHOLDER,		
	-------------------------
	shape_table_data 	=
	{
		{
			file  	 = 'kc-130';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'kc-130-oblomok'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'KC130';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "kc-130-oblomok";
			file  = "kc-130-oblomok";
			fire  = { 240, 2};
		},

	},
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	-------------------------
	mapclasskey = "P0091000064",
	attribute = {
		wsType_Air, 
		wsType_Airplane, 
		wsType_Cruiser,
		WSTYPE_PLACEHOLDER,
		"Tankers",
		"Refuelable",
	},
	
	Categories = {"{8A302789-A55D-4897-B647-66493FA6826F}", "Tanker",},
	
	--------- General Characteristics ---------
    singleInFlight				= 	true,
    length						=	29.79,
    height						=	11.66,
    wing_area					=	152.1,
    wing_span					=	40.4,
    wing_tip_pos				= 	{-2.57742 , 2.45707, 19.75358},
    RCS							=	80,
    has_speedbrake				=	false,
    stores_number				=	0,
    tanker_type					=	0,
    is_tanker					=	true,
    refueling_points_count		=	2,

    refueling_points = 
    {
		--          Front/Rear, Up/Down, Left/Right
		--            +   -      +  -      -    +
        [1] = 	{ pos = {-28.338, -3.153, -13.884}, clientType = 3 },
        [2] = 	{ pos = {-28.338, -3.153,  13.913}, clientType = 3 },
    }, -- end of refueling_points

    crew_members = 
    {
        [1] = 
        {
            ejection_seat_name	=	0,
            drop_canopy_name	=	0,
            pos = 	{7.0,	0.0,	-0.8},
			bailout_arg = -1,
        }, -- end of [1]
        [2] = 
        {
            ejection_seat_name	=	0,
            drop_canopy_name	=	0,
            pos = 	{7.0,	0.0,	0.8},
			bailout_arg = -1,
        }, -- end of [2]
    }, -- end of crew_members
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
            {Transition = {"Open", "Close"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
            {Transition = {"Open", "Board"}, Sequence = {{C = {{"Sleep", "for", 50.0}}}, {C = {{"Arg", 38, "to", 0.1 + 0.011, "in", 0.6}}}, {C = {{"Sleep", "for", 2.5}}}, {C = {{"Arg", 38, "to", 1.0, "in", 3.3}}}}},
            {Transition = {"Board", "Open"}, Sequence = {{C = {{"Sleep", "for", 10.0}}}, {C = {{"Arg", 38, "set", 0.0}}},                   {C = {{"Sleep", "for", 1.5}}}, {C = {{"Arg", 38, "to", 0.0, "in", 4.7}}}}, Flags = {"StepsBackwards"}},
        },
    },

    EmptyWeight					= "36400",
    MaxFuelWeight				= "30000",
    MaxHeight					= "10000",
    MaxSpeed					= "610",
    MaxTakeOffWeight			= "79380",
    Picture						= "C-130.png",
    Rate						= "70",
    WingSpan					= "40.4",
    
	----- Weight & Fuel Characteristics  ------
	M_empty						=	36400,
    M_nominal					=	70000,
    M_max						=	79380,
    M_fuel_max					=	30000,
    H_max						=	9315, --ceiling
    CAS_min						=	54,
    average_fuel_consumption	=	0.06,
	
	---------- AI Flight Parameters -----------
    V_opt						=	61.7333,
    V_take_off					=	58,
    V_land						=	61,
    V_max_sea_level				=	61.7333,
    V_max_h						=	61.7333,
    Vy_max						=	9.1, --maximal climb rate
    Mach_max					=	0.22,
    Ny_min						=	0.3, --minimal safe acceleration
    Ny_max						=	2.5, --maximal safe acceleration
	Ny_max_e					=	7.0,
    Ny_max_e					=	2,
    AOA_take_off				=	0.17,
    bank_angle_max				=	45,
    flaps_maneuver				=	0.5,
    range						=	8260, --operational range
	
	-------- Suspension Characteristics -------
    has_differential_stabilizer	=	false,
    tand_gear_max				=	0.577,
    nose_gear_pos				= 	{8.133,	-2.5,	0},
    nose_gear_wheel_diameter	=	0.754,
    main_gear_pos				= 	{-2.654,	-2.5,	2.746},
    main_gear_wheel_diameter	=	0.972,
	
	---------- Engine Characteristics ---------
    has_afteburner				=	false,
    thrust_sum_max				=	44400,
    thrust_sum_ab				=	44400,
    engines_count				=	4,
    IR_emission_coeff			=	1,
    IR_emission_coeff_ab		=	0,
	
    engines_nozzles = 
    {

        {
            pos = 	{-0.73,	1.105,	-10.335},
            elevation	=	0,
            diameter	=	1.523,
            exhaust_length_ab	=	11.794,
            exhaust_length_ab_K	=	0.76,
            smokiness_level     = 	0.1, 
        }, 	
        {
            pos = 	{-0.742,	1.248,	-5.152},
            elevation	=	0,
            diameter	=	1.523,
            exhaust_length_ab	=	11.794,
            exhaust_length_ab_K	=	0.76,
            smokiness_level     = 	0.1, 
        },
        {
            pos = 	{-0.742,	1.248,	5.152},
            elevation	=	0,
            diameter	=	1.523,
            exhaust_length_ab	=	11.794,
            exhaust_length_ab_K	=	0.76,
            smokiness_level     = 	0.1, 
        }, 
        {
            pos = 	{-0.73,	1.105,	10.335},
            elevation	=	0,
            diameter	=	1.523,
            exhaust_length_ab	=	11.794,
            exhaust_length_ab_K	=	0.76,
            smokiness_level     = 	0.1, 
        },

    }, -- end of engines_nozzles
	
	--------- Sensors Characteristics ---------
    radar_can_see_ground		= false,
    detection_range_max			= 0,
	
    Sensors = {
        RWR = "Abstract RWR"
    },
	
	---------- Radio Characteristics ----------
	TACAN = true,
	
	----------- ECM Characteristics -----------
    passivCounterm = {
        CMDS_Edit = true,
        SingleChargeTotal = 240,
        chaff = {default = 120, increment = 30, chargeSz = 1},
        flare = {default = 60, increment = 15, chargeSz = 2}
    },
    
    Countermeasures = {         
        IRCM = "AN/ALQ-157",
        DISPENSER = "AN/ALE-47"
    },
    
	--------- Armament Characteristics ---------
    Pylons = {
    },
	
	Tasks = {
        aircraft_task(Refueling),
    },
    
	DefaultTask = aircraft_task(Refueling),	
	
	------------- Damage Table Reference -------------
    fires_pos = 
    {
        [1] = 	{-2.33,  1.807,	  0},
        [2] = 	{-2.333, 1.807,   5.463},
        [3] = 	{-2.333, 1.807,  -5.463},
        [4] = 	{-0.82,  0.265,   2.774},
        [5] = 	{-0.82,  0.265,  -2.774},
        [6] = 	{-0.82,  0.255,   4.274},
        [7] = 	{-0.82,  0.255,  -4.274},
        [8] = 	{0.586,  1.66,    4.841},
        [9] = 	{0.586,  1.66,   -4.841},
        [10] = 	{0.586,  1.546,  10.05},
        [11] = 	{0.586,  1.546, -10.05},
    }, -- end of fires_pos    
	
	DamageParts = 
 	{
		[1] = "kc-130-OBLOMOK-WING-R",
		[2] = "kc-130-OBLOMOK-WING-L",
	},	
	
	------- Flight Model Characteristics -------
	SFM_Data =
	{
		aerodynamics = 
		{
			Cy0	=	0.1,				-- zero AoA lift coefficient
			Mzalfa	=	6.6,		-- coefficients for pitch agility
			Mzalfadt	=	1,		-- coefficients for pitch agility
			kjx	=	2.85,
			kjz	=	0.00125,
			Czbe	=	-0.012,		-- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	=	0.015,		-- coefficient, drag, gear
			cx_flap	=	0.08,		-- coefficient, drag, full flaps
			cy_flap	=	2,			-- coefficient, normal force, lift, flaps
			cx_brk	=	0.06,		-- coefficient, drag, breaks
			table_data = 
			{
				-- M - Mach number
				-- Cx0 - Coefficient, drag, profile, of the airplane
				-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
				-- B - Polar quad coeff
				-- B4 - Polar 4th power coeff
				-- Omxmax - roll rate, rad/s
				-- Aldop - Alfadop Max AOA at current M - departure threshold
				-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
				-- 		M		Cx0		Cya		B		B4		Omxmax	Alpdop Cymax
				[1] = 	{0,		0.024,	0.3,	0.0384,	1e-006,	0.5,	20,	2},
				[2] = 	{0.2,	0.024,	0.3,	0.0384,	1e-006,	1.5,	20,	2},
				[3] = 	{0.4,	0.024,	0.3,	0.0384,	1e-006,	2.5,	20,	2},
				[4] = 	{0.5,	0.024,	0.3,	0.0384,	1e-006,	2.5,	20,	2},
				[5] = 	{0.6,	0.027,	0.3,	0.0,	0.3,	3.5,	20,	2},
				[6] = 	{0.7,	0.031,	0.3,	0.045,	0.9,	3.5,	20,	1},
				[7] = 	{0.8,	0.036,	0.3,	0.107,	1,		3.5,	20,	0.8},
				[8] = 	{0.9,	0.045,	0.3,	0.148,	0.058,	3.5,	20,	0.6},
				[9] = 	{1,		0.054,	0.3,	0.199,	0.1,	3.5,	20,	0.53333333333333},
				[10] = 	{1.5,	0.054,	0.3,	0.199,	0.1,	3.5,	20,	0.2},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	60.00001,--67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			type	=	"TurboProp",
			hMaxEng	=	19.5,
			dcx_eng	=	0.0085,
			cemax	=	0.37,
			cefor	=	0.37,
			dpdh_m	=	4820,
			dpdh_f	=	4820,
			table_data = 
			{
				[1] = 	{0,		150791.9,	150791.9},
				[2] = 	{0.1,	148287.6,	148287.6},
				[3] = 	{0.2,	123531.3,	123531.3},
				[4] = 	{0.3,	103801.6,	103801.6},
				[5] = 	{0.4,	87546.7,	87546.7},
				[6] = 	{0.5,	71708.3,	71708.3},
				[7] = 	{0.6,	58458.4,	58458.4},
				[8] = 	{0.7,	48624.7,	48624.7},
				[9] = 	{0.8,	41438.6,	41438.6},
				[10] = 	{0.9,	33000,		33000},
			}, -- end of table_data
		}, -- end of engine
	}, -- end of [SFM_Data]
	
	-- External Lights
	lights_data = 	{
		typename = "collection",
		lights = {
	        [WOLALIGHT_STROBES]   		 = {},--must be collection
	        [WOLALIGHT_FORMATION_LIGHTS] = {},
			[WOLALIGHT_SPOTS]			 = {},
	        [WOLALIGHT_TAXI_LIGHTS] 	 = {
				typename = "collection",
				lights = {
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_L_WING",
						argument  = 209,
					},
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_R_WING",
						argument  = 209,
					},
				},
			},
	        [WOLALIGHT_LANDING_LIGHTS] 	 = {
				typename = "collection",
				lights = {
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_L_WING",
						argument  = 209,
					},
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_R_WING",
						argument  = 209,
					},
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_L_GEAR",
						argument  = 208,
					},
					{
						typename  = "argumentlight" ,
						connector = "LIGHT_R_GEAR",
						argument  = 208,
					},
				},
			},
	        [WOLALIGHT_NAVLIGHTS] 		 = {
				typename = "collection",
				lights = {
					{
						typename  = "argumentlight" ,
						connector = "BANO_0",
						color     = {1,1,1},
						position  = {-6.079, 2.896, 0.0},
						argument  = 192,
					},
					{
						typename  = "argumentlight" ,
						connector = "BANO_1",
						color     = {0.99,0.11,0.3},
						position  = {-1.516, -0.026, -7.249},
						argument  = 190,
					},
					{
						typename  = "argumentlight" ,
						connector = "BANO_2",
						color     = {0,0.894,0.6},
						position  = {-1.516, -0.026,  7.249},
						argument  = 191,
					},	
				},
			},
            [WOLALIGHT_CABIN_NIGHT] = {
                typename = "collection",
                lights = {
                    {
						typename = "argumentlight", 
						connector = "LIGHT_COCKPIT_1",
						argument = 193,
                    },
                    {
						typename = "argumentlight", 
						connector = "LIGHT_COCKPIT_2",
						argument = 193,
                    },
                    {
						typename = "argumentlight", 
						connector = "LIGHT_COCKPIT_3",
						argument = 193,
                    },
                },
			},
		},
	},  -- end of [lights_data]
}

add_aircraft(KC130J)

