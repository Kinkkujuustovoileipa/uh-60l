dofile("Aircraft/Planes/uh60l_Plane.lua")

UH60L = plane:new()

dofile("Aircraft/Engines/uh60l_Engine.lua")
--dofile("Aircraft/Engines/APUs/BasicAPU.lua")

function UH60L:createEngines()

	for i = 1, 4 do
		self.engines[i] = engine:new()
		self.engines[i]:init(i, host)
		self.engines[i]:initCptNames()
	end

end

UH60L:createEngines()

function onUpdate(params)
	UH60L:onUpdate(params)
end