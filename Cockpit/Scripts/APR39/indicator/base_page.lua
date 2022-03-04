dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

RWR_DEFAULT_LEVEL = 5
RWR_DEFAULT_NOCLIP_LEVEL  = RWR_DEFAULT_LEVEL - 1
RWR_SCALE = 0.12
contact_scale = RWR_SCALE
green_color			= MakeMaterial(nil,{0, 255, 5, 215})
GREEN_SOFT		= MakeMaterial(nil,{25, 255, 25, 128})

SetScale(METERS)
local cautionColor = {255,200,0,220}
local advisoryColor = {255,0,0,255}
local warningColor = {255,0,0,255}
local fontWarning = MakeFont({used_DXUnicodeFontData = "baseFont"}, warningColor)
local fontCaution = MakeFont({used_DXUnicodeFontData = "baseFont"}, cautionColor)
local fontAdvisory = MakeFont({used_DXUnicodeFontData = "baseFont"}, advisoryColor)
--local center = {0.55,-0.4,2.4} -- {L/R,U/D,forward/back} for debug
local center = calculateIndicatorCenter({0.0626,-0.769,2.5623}) -- {L/R,U/D,forward/back}
local rotation = {0, 0, dashRotation} -- main panel rotation roughly 22deg
local stringdefs = {0.006 * RWR_SCALE * 10,0.77*0.006 * RWR_SCALE * 10, 0, 0}


verts = {}
dx=.0145
dy=.0084
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}

local base 			 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2,2,3,0}
base.init_pos		 = center
base.init_rot		 = rotation
base.material		 = MakeMaterial(nil,{255,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
base.element_params  = {"APR39_POWER", "APR39_BRIGHTNESS"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter", 1}}
Add(base)

--drawGrid(0, 0, 0, 100, 100, base)

function addContact(i)
    i = "0"..i
    local radius = 0.32 * RWR_SCALE	
    local innerRadius = 0.025 * RWR_SCALE

    -- SEARCH TICK
    local search_tick_length = -0.05 * RWR_SCALE
    local search_tick_width = 0.002  
    local search_tick_x = -search_tick_width/2
    local search_tick_y = radius
    
    local	RWR_search          = CreateElement "ceStringPoly"
    RWR_search.name		   		= create_guid_string()
    RWR_search.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
    RWR_search.material    		= green_color
    RWR_search.vertices	   		=
    {
        {search_tick_x,                     search_tick_y},
        {search_tick_x + search_tick_width, search_tick_y},	
        {search_tick_x + search_tick_width, search_tick_y + search_tick_length},
        {search_tick_x,                     search_tick_y + search_tick_length},
    }		
    RWR_search.indices	   		= { 0,1,2,   0,2,3} -- vertex points on the tris
    RWR_search.controllers     	=
    {
        {"rotate_using_parameter",0,1},
        {"parameter_in_range",1,0.9,1.1},
        {"opacity_using_parameter", 2},
    } 
    RWR_search.element_params  	= {"RWR_CONTACT_"..i.."_AZIMUTH", "RWR_CONTACT_"..i.."_SIGNAL", "APR39_BRIGHTNESS"}
    RWR_search.parent_element 	= base.name
    Add(RWR_search)

    -- CONTACT BASE
    local rwrContactBase = CreateElement "ceSimple"
    rwrContactBase.name		   		= create_guid_string()
    rwrContactBase.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
    rwrContactBase.controllers     	=
    {
        {"rotate_using_parameter",0,1},
        {"move_up_down_using_parameter",1,contact_scale},
        {"parameter_in_range",1,0.01,1.09},
        {"parameter_in_range",2,1.9,4},
        {"opacity_using_parameter", 3},
    } 
    rwrContactBase.element_params  	= {"RWR_CONTACT_"..i.."_AZIMUTH", "RWR_CONTACT_"..i.."_POWER_ADJUSTED", "RWR_CONTACT_"..i.."_SIGNAL", "APR39_BRIGHTNESS"}
    rwrContactBase.parent_element 		= "base"
    rwrContactBase.alignment       = "LeftCenter"
    Add(rwrContactBase)

    -- SYMBOL BASE
    local rwrSymbolBase = CreateElement "ceSimple"
    rwrSymbolBase.name		   		= create_guid_string()
    rwrSymbolBase.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
    rwrSymbolBase.controllers     	=
    {
        {"rotate_using_parameter",0,-1},
    } 
    rwrSymbolBase.element_params  	= {"RWR_CONTACT_"..i.."_AZIMUTH"}
    rwrSymbolBase.parent_element 	= rwrContactBase.name
    rwrSymbolBase.alignment         = "LeftCenter"
    Add(rwrSymbolBase)

    -- CONTACT SYMBOL
    local RWR_contact_symbol           = CreateElement "ceStringPoly"
    RWR_contact_symbol.name            = create_guid_string()
    RWR_contact_symbol.material        = MakeFont({used_DXUnicodeFontData = "apr39Font"},{0,255,0,255})
    RWR_contact_symbol.alignment       = "LeftCenter"
    RWR_contact_symbol.stringdefs      = {0.07 * RWR_SCALE,0.07 * RWR_SCALE, 0, 0}  -- {size vertical, horizontal, 0, 0}
    RWR_contact_symbol.formats         = {"%s"} 
    RWR_contact_symbol.element_params  =
    {
        "RWR_CONTACT_" .. i .. "_GENERAL_TYPE",
        "RWR_CONTACT_" .. i .. "_AZIMUTH",
        "RWR_CONTACT_" .. i .. "_UNIT_TYPE_SYM",
        "APR39_BRIGHTNESS"
    }
    RWR_contact_symbol.controllers     =
    {
        {"parameter_in_range",0,0.5,3.1},
        --{"rotate_using_parameter",1,-1},
        {"text_using_parameter",2,0},
        {"opacity_using_parameter", 3},
    } 
    RWR_contact_symbol.parent_element  = rwrSymbolBase.name
    RWR_contact_symbol.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    Add(RWR_contact_symbol)

    -- CONTACT BOX
    local x_size 	= 0.045	* RWR_SCALE	
    local thickness = 0.85   
                
    local 	RWR_lock	 				= CreateElement "ceStringPoly"
    RWR_lock.name			  	= create_guid_string()
    RWR_lock.material    		= green_color	
    RWR_lock.vertices	   		=
    {
        {-x_size 			, x_size			},
        {-x_size 			,-x_size 			},
        {-x_size*thickness	, x_size*thickness	},
        {-x_size*thickness	,-x_size*thickness	},	
        
        {-x_size 			, x_size 			},
        { x_size  			, x_size 			},
        {-x_size*thickness	, x_size*thickness	},
        { x_size*thickness	, x_size*thickness	},	
                
        { x_size 			, x_size			},
        { x_size 			,-x_size 			},
        { x_size*thickness	, x_size*thickness  },
        { x_size*thickness	,-x_size*thickness	},	
            
        { x_size 			,-x_size			},
        {-x_size 			,-x_size 			},
        { x_size*thickness	,-x_size*thickness  },
        {-x_size*thickness	,-x_size*thickness	},
    }
    RWR_lock.alignment      = "CenterCenter"
    RWR_lock.init_pos       = {0.004,0,0}	
    RWR_lock.indices	   	=
    { 	0,1,2,		1,2,3,
        4,5,6,		5,6,7,
        8,9,10,		9,10,11,
        12,13,14,	13,14,15,
    }
    RWR_lock.element_params =
    {
        "RWR_CONTACT_" .. i .. "_LOCK_SYM",
        "RWR_CONTACT_" .. i .. "_AZIMUTH", "APR39_BRIGHTNESS"
    }
    RWR_lock.controllers    =
    {
        {"parameter_in_range",0,0.9,1.1},
        --{"rotate_using_parameter",1,-1},
        {"opacity_using_parameter", 2},
    } 
    RWR_lock.parent_element 	= RWR_contact_symbol.name
    RWR_lock.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
    Add(RWR_lock)
end

for j = 1,7 do
    addContact(j)
end
