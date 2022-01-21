dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."AI/ControlPanel/g_panel_definitions.lua")

local dbg_k = 0.5

old_K = 73.5
new_K = 73.5 --44

aspect   = LockOn_Options.screen.aspect - 0.02	

local multimonitor_setup_name =  "Config/MonitorSetup/"..get_multimonitor_preset_name()..".lua"
local f = loadfile(multimonitor_setup_name)
if	  f then
	local env = {}
	env.screen = LockOn_Options.screen
	setfenv(f,env)
	pcall(f)
	if env.UIMainView ~= nil then
		if (LockOn_Options.screen.width/2.0 > env.UIMainView.x) then 
			aspect = (env.UIMainView.width + env.UIMainView.x - LockOn_Options.screen.width/2.0)/LockOn_Options.screen.height - 0.02
		else	
			aspect = (env.UIMainView.width + env.UIMainView.x)/LockOn_Options.screen.height - 0.02
		end	
	end
end

FontSizeX1	= 0.0058 * (old_K / new_K)
FontSizeY1	= FontSizeX1

predefined_font_0 = {dbg_k* FontSizeY1, dbg_k* FontSizeX1, 0.0, 0.0}

predefined_font_1 = {dbg_k* FontSizeY1*0.8, dbg_k* FontSizeX1*0.8, 0.0, 0.0}

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

firstLineY = 0.0

local shift_X		  = -0.65
local shift_Y		  = -1
local size_X          = -shift_X + 0.02
local size_Y          = 0.35
local border_s		  = 0.01
local Y_space		  = size_Y/6.0

local orange_mat   	= MakeMaterial("",{0,0,0,150})

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = orange_mat 
base.vertices       = {{0.0,0.0},
					   {size_X,0.0},
					   {size_X, size_Y},
					   {0.0, size_Y}}        
base.indices        = default_box_indices
base.init_pos       = {aspect + shift_X,firstLineY + shift_Y}
base.controllers    = {{"show"}}

base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
base.level		      = DEFAULT_LEVEL
AddElement(base)


txt_Status				= CreateElement "ceStringPoly"
txt_Status.name			= "txt_Status"
txt_Status.value    	= "		CREW STATUS:"    
txt_Status.material		= "font_general"
txt_Status.init_pos		= {0.0 + border_s, size_Y - border_s}
txt_Status.alignment   	= "LeftTop"
txt_Status.stringdefs 	= predefined_font_0
txt_Status.parent_element = base.name
AddElement(txt_Status)

txt_Hints				= CreateElement "ceStringPoly"
txt_Hints.name			= "txt_Hints"
txt_Hints.value    		= "HEALTH	ROE	  AMMO BURST"    
txt_Hints.material		= "font_general"
txt_Hints.init_pos		= {0.0 + border_s, size_Y - border_s - Y_space*1.0}
txt_Hints.alignment   	= "LeftTop"
txt_Hints.stringdefs 	= predefined_font_0
txt_Hints.parent_element = base.name
AddElement(txt_Hints)

local m_index = 0

name_t = {"PILOT","CO-PILOT","LH GUNNER","RH GUNNER"}
status_t = {"-","HOLD","RET.FIRE","FREE FIRE","PLAYER","DEAD","NET","FAIL"}
burst_t = {"  -","SHORT","LONG"}
seats_n =    {0,1,2,3}

function add_crew_member(member)

-------------------------------
block_mat   		= MakeMaterial("",{0,0,0,0})

mem_base       			= CreateElement "ceMeshPoly"
mem_base.name			= "mem_base"..m_index
mem_base.primitivetype  = "triangles"
mem_base.material       = block_mat -- "GREEN_TRANSPARENT"
mem_base.vertices       = {{0.0,0.0},
					   {size_X,0.0},
					   {size_X, Y_space},
					   {0.0, Y_space}}        
mem_base.indices        = default_box_indices
mem_base.init_pos		= {0.0 + border_s, size_Y - Y_space*(m_index+3) }

mem_base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
mem_base.level		      = DEFAULT_LEVEL + 1
mem_base.parent_element   = base.name
mem_base.controllers    = {{"show_member",seats_n[m_index+1]}}

AddElement(mem_base)

-------------------------------

txt_member				= CreateElement "ceStringPoly"
txt_member.name			= "txt_mem"..m_index
txt_member.value    	= member    
txt_member.material		= "font_general"
txt_member.init_pos		= {0.0, Y_space }
txt_member.alignment   	= "LeftTop"
txt_member.stringdefs 	= predefined_font_0
txt_member.parent_element = mem_base.name
txt_member.controllers  = {{"health",seats_n[m_index+1]}}
AddElement(txt_member)

txt_status				= CreateElement "ceStringPoly"
txt_status.name			= "txt_status"..m_index  
txt_status.material		= "font_general"
txt_status.init_pos		= {0.23, Y_space }
txt_status.alignment   	= "LeftTop"
txt_status.stringdefs 	= predefined_font_0
txt_status.parent_element = mem_base.name
txt_status.formats    	= status_t
txt_status.controllers  = {{"status",seats_n[m_index+1]}}
AddElement(txt_status)

txt_ammo				= CreateElement "ceStringPoly"
txt_ammo.name			= "txt_ammo"..m_index
txt_ammo.material		= "font_general"
txt_ammo.init_pos		= {0.44, Y_space}
txt_ammo.alignment   	= "LeftTop"
txt_ammo.stringdefs 	= predefined_font_0
txt_ammo.parent_element = mem_base.name
txt_ammo.formats    	= {"%d%%"," -"}
txt_ammo.controllers  	= {{"ammo",seats_n[m_index+1]}}
AddElement(txt_ammo)

txt_burst				= CreateElement "ceStringPoly"
txt_burst.name			= "txt_burst"..m_index 
txt_burst.material		= "font_general"
txt_burst.init_pos		= {0.54, Y_space}
txt_burst.alignment   	= "LeftTop"
txt_burst.stringdefs 	= predefined_font_0
txt_burst.parent_element = mem_base.name
txt_burst.formats    	= burst_t
txt_burst.controllers  	= {{"burst",seats_n[m_index+1]}}
AddElement(txt_burst)

m_index = m_index + 1
end


add_crew_member(name_t[1])
add_crew_member(name_t[2])
add_crew_member(name_t[3])
add_crew_member(name_t[4])








