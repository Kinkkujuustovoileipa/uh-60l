local self_ID = "UH-60L"
declare_plugin(self_ID,
{
	dirName			= current_mod_path,
	displayName		= _("UH-60L Black Hawk"),
	fileMenuName	= _("UH-60L"),
	version 		= "1.1",
	state			= "installed",
	info			= _("The UH-60L Black Hawk is a utility helicopter used by the US Army and other forces around the world."),

	binaries =
	{
		'UH60L',
	},
	Skins =
	{
		{
			name	= "UH-60L",
			dir		= "Skins/1"
		},
	},
	Missions =
	{
		{
			name	= _("UH-60L"),
			dir		= "Missions",
		},
	},
	LogBook =
	{
		{
			name	= _("UH-60L"),
			type	= "UH-60L",
		},
	},
	InputProfiles =
	{
		["UH-60L"] = current_mod_path .. '/Input',
	},
	Options =
	{
		{
			name		= _("UH-60L"),
			nameId		= "UH-60L",
			dir			= "Options",
			CLSID		= "{UH-60L options}"
		},
	},
})
-------------------------------------------------------------------------------
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path(current_mod_path.."/Textures")
mount_vfs_texture_path(current_mod_path.."/Textures/Cockpit")
mount_vfs_texture_path(current_mod_path.."/Textures/h60Textures") --zip
mount_vfs_texture_path(current_mod_path.."/Textures/Cockpit/h60CockpitTextures") --zip
mount_vfs_texture_path(current_mod_path.."/Textures/Avionics")--for textures used in cockpit systems i.e. digital fonts
mount_vfs_texture_path(current_mod_path.."/Skins/1/ME")

dofile(current_mod_path..'/UH-60L.lua')
dofile(current_mod_path..'/UnitPayloads/UH-60L.lua')
dofile(current_mod_path..'/KC-130J.lua')
dofile(current_mod_path.."/Views.lua")
make_view_settings('UH-60L',ViewSettings, SnapViews)
dofile(current_mod_path.."/Suspension.lua")

local FM =
{
	[1] = self_ID,
	[2] = "UH60L", -- name of dll
	center_of_mass = {-0.06,0,0},  -- center of mass position relative to object 3d model center for empty aircraft
	moment_of_inertia = {7631.899, 54232.718, 50436.427, 79.315}, -- 5629.0, 40000.0, 37200.0, 58.5 in slug-ft^2 - moment of inertia of empty (Ixx,Iyy,Izz,Ixz)	in kgm^2
	suspension = suspension
}

make_flyable('UH-60L',current_mod_path..'/Cockpit/Scripts/', FM, current_mod_path..'/comm.lua')
set_manual_path('UH-60L', current_mod_path .. '/Doc/manual')
plugin_done()