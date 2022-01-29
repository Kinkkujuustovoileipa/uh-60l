
ViewSettings =
{
	Cockpit =
	{
		[1] =
		{-- player slot 1 (pilot)
			CameraViewAngleLimits  = {20,140},-- FOV Min Max (how much zoom in/out)
			CockpitLocalPoint      = {2.971,-0.519,0},	--where to line up center of cockpit model  {forward/back,up/down,left/right}
			CameraAngleRestriction = {false,90,0.50},
			CameraAngleLimits      = {200,-90,90}, -- View right/left, View down/up
			EyePoint               = {-0.15,0,0.0}, -- Distance from pivot point. To simulate pivot around human neck, use {0.16,0.1,0}
			ShoulderSize		   = 0.25,
			Allow360rotation	   = false,
			limits_6DOF            = {x = {-10,10},y ={-10,10},z = {-10,10},roll = 90.000000},-- movement back/front bottom/top right/left
		},
		[2] =
		{-- player slot 2 (copilot)
			CameraViewAngleLimits  = {20,140},
			CockpitLocalPoint      = {2.971,-0.519,0},	--where to line up center of cockpit model  {forward/back,up/down,left/right}
			CameraAngleRestriction = {false,90,0.50},
			CameraAngleLimits      = {200,-90,90},
			EyePoint               = {-0.15,0,0.0},
			ShoulderSize		   = 0.25,
			Allow360rotation	   = false,
			limits_6DOF            = {x = {-10,10},y ={-10,10},z = {-10,10},roll = 90.000000},
		},
		[3] =
		{-- player slot 3 (crew chief/rightgunner)
			CameraViewAngleLimits  = {20,140},
			CockpitLocalPoint      = {0,0,0},	--where to line up center of cockpit model  {forward/back,up/down,left/right}
			CameraAngleRestriction = {false,90,0.50},
			CameraAngleLimits      = {200,-90,90},
			EyePoint               = {-0.15,0,0.0},
			ShoulderSize		   = 0.25,
			Allow360rotation	   = false,
			limits_6DOF            = {x = {-10,10},y ={-10,10},z = {-10,10},roll = 90.000000},
		},
		[4] =
		{-- player slot 4 (leftgunner)
			CameraViewAngleLimits  = {20,140},
			CockpitLocalPoint      = {0,0,0},	--where to line up center of cockpit model  {forward/back,up/down,left/right}
			CameraAngleRestriction = {false,90,0.50},
			CameraAngleLimits      = {200,-90,90},
			EyePoint               = {-0.15,0,0.0},
			ShoulderSize		   = 0.25,
			Allow360rotation	   = false,
			limits_6DOF            = {x = {-10,10},y ={-10,10},z = {-10,10},roll = 90.000000},
		},
	},
	Chase = { -- F4 view
		LocalPoint      = {-0.4,-1.0,2},
		AnglesDefault   = {0.000000,0.000000},
	},
	Arcade = {
		LocalPoint      = {-21.500000,5.000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	},
}

local function head_pos_default(tab)
    if not tab then
	   tab = {}
	end
	tab.viewAngle = tab.viewAngle  or 90 -- FOV
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -8 -- angles down pilot view
	tab.x_trans   = tab.x_trans    or  2.3 --moves pilot view forward .725
	tab.y_trans   = tab.y_trans    or -0.3-- moves view up
	tab.z_trans   = tab.z_trans    or  0.666045-- moves view to right seat
	tab.rollAngle = tab.rollAngle  or  0
	return tab
end

local function head_pos_default2(tab)
    if not tab then
	   tab = {}
	end
	tab.viewAngle = tab.viewAngle  or 90 -- FOV
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -8 -- angles down pilot view
	tab.x_trans   = tab.x_trans    or  2.3 --moves pilot view forward
	tab.y_trans   = tab.y_trans    or -0.3-- moves view up
	tab.z_trans   = tab.z_trans    or -0.626045 -- moves view to left seat
	tab.rollAngle = tab.rollAngle  or  0
	return tab
end

local function head_pos_default3(tab)
    if not tab then
	   tab = {}
	end
	tab.viewAngle = tab.viewAngle  or 75 -- FOV
	tab.hAngle    = tab.hAngle     or  -90
	tab.vAngle    = tab.vAngle     or -8 -- angles down pilot view
	tab.x_trans   = tab.x_trans    or  1 --moves pilot view forward
	tab.y_trans   = tab.y_trans    or -0.3-- moves view up
	tab.z_trans   = tab.z_trans    or -0.626045 -- moves view to left seat
	tab.rollAngle = tab.rollAngle  or  0
	return tab
end

local function head_pos_default4(tab)
    if not tab then
	   tab = {}
	end
	tab.viewAngle = tab.viewAngle  or 75 -- FOV
	tab.hAngle    = tab.hAngle     or  90
	tab.vAngle    = tab.vAngle     or -8 -- angles down pilot view
	tab.x_trans   = tab.x_trans    or  1 --moves pilot view forward
	tab.y_trans   = tab.y_trans    or -0.3-- moves view up
	tab.z_trans   = tab.z_trans    or 0.666045 -- moves view to left seat
	tab.rollAngle = tab.rollAngle  or  0
	return tab
end

SnapViews =
{
	[1] =
	{-- player slot 1 (pilot)
		[1]  = head_pos_default(),--Num 0
		[2]  = head_pos_default(),--Num 1
		[3]  = head_pos_default(),--Num 2
		[4]  = head_pos_default(),--Num 3
		[5]  = head_pos_default(),--Num 4
		[6]  = head_pos_default(),--Num 5
		[7]  = head_pos_default(),--Num 6
		[8]  = head_pos_default(),--Num 7
		[9]  = head_pos_default(),--Num 8
		[10]  = head_pos_default(),--Num 9
		[11]  = head_pos_default(),--left mirror
		[12]  = head_pos_default(),--right mirror
		[13]  = head_pos_default({viewAngle = 75, hAngle = 0, vAngle = -5, x_trans = 0, y_trans = 0, z_trans = 0, rollAngle = 0}),--default
	},
	[2] =
	{-- player slot 2 (copilot)
		[1]  = head_pos_default(),--Num 0
		[2]  = head_pos_default(),--Num 1
		[3]  = head_pos_default(),--Num 2
		[4]  = head_pos_default(),--Num 3
		[5]  = head_pos_default(),--Num 4
		[6]  = head_pos_default(),--Num 5
		[7]  = head_pos_default(),--Num 6
		[8]  = head_pos_default(),--Num 7
		[9]  = head_pos_default(),--Num 8
		[10]  = head_pos_default(),--Num 9
		[11]  = head_pos_default(),--left mirror
		[12]  = head_pos_default(),--right mirror
		[13]  = head_pos_default({viewAngle = 75, hAngle = 0, vAngle = -5, x_trans = 0, y_trans = 0, z_trans = 0, rollAngle = 0}),--default
	},
	[3] =
	{-- player slot 2 (copilot)
		[1]  = head_pos_default3(),--Num 0
	},
	[4] =
	{-- player slot 2 (copilot)
		[1]  = head_pos_default4(),--Num 0
	},
}
