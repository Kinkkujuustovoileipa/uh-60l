dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

local box_height				= 0.25
local box_width					= 0.25
local narrow_height				= 0.01
local narrow_width				= 0.01
local size=0.25;
local line_width=0.0005
local width  = 1.0
local aspect        = LockOn_Options.screen.aspect

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = "GREEN_TRANSPARENT"
base.vertices       = {{-box_width, -box_height},
                       {-box_width, box_height }, 
                       { box_width, box_height },
                       { box_width, -box_height}}         
base.indices       = default_box_indices
base.init_pos       = {aspect-box_width,1.0-box_height}
base.init_rot       = {90,0,0}
base.controllers    = {{"show"}}
base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
base.level		      = DEFAULT_LEVEL
AddElement(base)

local size_narrow = 1.25

NarrowCircle       		= CreateElement "ceTexPoly"
NarrowCircle.name		    = "NarrowCircle  "
NarrowCircle.primitivetype  = "triangles"
NarrowCircle.material       = "ARCADE_3_RED"
NarrowCircle.vertices       = {{-narrow_width*size_narrow, -narrow_height*size_narrow},
                       {-narrow_width*size_narrow, narrow_height*size_narrow }, 
                       { narrow_width*size_narrow, narrow_height*size_narrow },
                       { narrow_width*size_narrow, -narrow_height*size_narrow}}    
NarrowCircle.tex_params	 = {253/722, 360/722, 75/722 / (2*narrow_width*size_narrow), 75/722 / (2*narrow_height*size_narrow)}				   
NarrowCircle.indices        = default_box_indices
NarrowCircle.init_pos       = {0.0,0.0}
NarrowCircle.controllers    = {{"show"},{"narrowPosition",aspect-box_width,1.0-box_height}}
NarrowCircle.parent_element = base.name
NarrowCircle.h_clip_relation  = h_clip_relations.COMPARE
NarrowCircle.level		      = DEFAULT_LEVEL
AddElement(NarrowCircle)


circle 						= CreateElement "ceTexPoly"
circle.name       			=  "circle"
circle.primitivetype 		= "triangles"
circle.material  		 	= "ARCADE_4_RED"
circle.vertices       =  {{-narrow_width*12.5/2, -12.5/2*narrow_height},
                       {-narrow_width*12.5/2, 12.5/2*narrow_height}, 
                       { narrow_width*12.5/2, 12.5/2*narrow_height },
                       { narrow_width*12.5/2, -12.5/2*narrow_height}}    
circle.tex_params	 = {0.5, 0.5, 720/722/(25/2*narrow_width), 720/722/ (25/2*narrow_height)}			   
circle.indices        = default_box_indices
circle.init_pos       = {0.0,0.0}
circle.controllers    = {{"show"},{"circlePosition",aspect-box_width,1.0-box_height}--[[,{"radius"}--]]}
circle.parent_element = base.name
circle.h_clip_relation  =  h_clip_relations.COMPARE
circle.level		 = DEFAULT_LEVEL
--circle.parent_element = base.name
--set_circle(circle, 0.8, 0.815)
AddElement(circle)

heightBordersCargo						= CreateElement "ceMeshPoly"
heightBordersCargo	.name       			=  "heightBordersCargo"
heightBordersCargo	.primitivetype 		= "triangles"
heightBordersCargo	.material  		 	= "BLUE"
heightBordersCargo	.vertices       = {{-line_width*5	, -size},
                         {-line_width*5	, size}, 
                         { line_width*5	, size},
                         { line_width*5	,-size}}     
heightBordersCargo	.indices        = default_box_indices
heightBordersCargo	.controllers    = {{"show"},{"showHeightBordersCargo"}}
heightBordersCargo	.init_pos       = {aspect-0.06,1.0-box_height}
heightBordersCargo	.level		 = DEFAULT_LEVEL
heightBordersCargo	.h_clip_relation  = h_clip_relations.REWRITE_LEVEL

AddElement(heightBordersCargo)


heightBordersZone						= CreateElement "ceMeshPoly"
heightBordersZone	.name       			=  "heightBordersZone"
heightBordersZone	.primitivetype 		= "triangles"
heightBordersZone	.material  		 	= "RED"
heightBordersZone	.vertices       = {{-line_width*5	, -size},
                         {-line_width*5	, size}, 
                         { line_width*5	, size},
                         { line_width*5	,-size}}     
heightBordersZone	.indices        = default_box_indices
heightBordersZone	.controllers    = {{"show"},{"showHeightBordersZone"}}
heightBordersZone	.init_pos       = {aspect-0.06,1.0-box_height}
heightBordersZone	.level		 = DEFAULT_LEVEL
heightBordersZone	.h_clip_relation  = h_clip_relations.REWRITE_LEVEL

AddElement(heightBordersZone)

zone 						= CreateElement "ceMeshPoly"
zone.name       			=  "zone"
zone.primitivetype 		= "triangles"
zone.material  		 	= "RED"
zone.vertices       = {{-line_width*5	, -0.9*size},
                         {-line_width*5	, 0.9*size}, 
                         { line_width*5	, 0.9*size},
                         { line_width*5	,-0.9*size}}     
zone.indices        = default_box_indices
zone.controllers    = {{"show"}}
zone.init_pos       = {aspect-0.06,1.0-box_height}
zone.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
zone.level		 = DEFAULT_LEVEL

AddElement(zone)


heightnarrow       		    =	 CreateElement "ceTexPoly"
heightnarrow.name		    = "heightnarrow"
heightnarrow.primitivetype  = "triangles"
heightnarrow.material       = "ARCADE_3_RED"
heightnarrow.vertices       = {{-narrow_width*size_narrow, -narrow_height*size_narrow},
                       {-narrow_width*size_narrow, narrow_height*size_narrow}, 
                       { narrow_width*size_narrow, narrow_height*size_narrow },
                       { narrow_width*size_narrow, -narrow_height*size_narrow}}        
heightnarrow.tex_params	 = {0.5, 0.5, 75/722/(2*size_narrow*narrow_width), 75/722/(2*size_narrow*narrow_height)}					   
heightnarrow.indices        = default_box_indices
heightnarrow.parent_element = base.name
heightnarrow.init_pos       = {0.0,0.0}
heightnarrow.controllers    = {{"show"},{"heightStripPosition",aspect-0.06,1.0-box_height}}
AddElement(heightnarrow)

crosshair = CreateElement "ceMeshPoly"
crosshair.name = "crosshair"
crosshair.primitivetype = "lines"
crosshair.material = "RED"
crosshair.vertices = {{-size ,0},{size , 0},
                                { 0 ,-size},{0, size}}
crosshair.indices = {0,1,2,3}
crosshair.parent_element = base.name
AddElement(crosshair)


