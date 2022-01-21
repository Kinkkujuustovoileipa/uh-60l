BasicAPU = {cockpit = {}}

function BasicAPU:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function BasicAPU:create(APUhost)
	self.sndAPU = ED_AudioAPI.createSource(APUhost, "Aircrafts/Engines/UH-60L/APU")
	self.sndAPUbegin = ED_AudioAPI.createSource(APUhost, "Aircrafts/Engines/UH-60L/APUStart")
end

function BasicAPU:createCpt(APUhostCpt, path)
	--self.cockpit.sndAPU = ED_AudioAPI.createSource(APUhostCpt, path .. "APUIn") -- have to assign cockpit path directly!
	self.cockpit.sndAPU = ED_AudioAPI.createSource(APUhostCpt, "Aircrafts/Engines/UH-60L/APUIn")
	ED_AudioAPI.linkSource(self.sndAPU, self.cockpit.sndAPU)

	--self.cockpit.sndAPUbegin = ED_AudioAPI.createSource(APUhostCpt, path .. "APUBeginIn") -- have to assign cockpit path directly!
	self.cockpit.sndAPUbegin = ED_AudioAPI.createSource(APUhostCpt, "Aircrafts/Engines/UH-60L/APUInStart")
	ED_AudioAPI.linkSource(self.sndAPUbegin, self.cockpit.sndAPUbegin)
end

function BasicAPU:update(params)
	if params.APU_RPM < 0.01 then
		ED_AudioAPI.stopSource(self.sndAPU)
		ED_AudioAPI.stopSource(self.sndAPUbegin)
	elseif params.APU_RPM > 0.02 then
		ED_AudioAPI.setSourcePitch(self.sndAPU, params.APU_RPM)
		ED_AudioAPI.setSourceGain(self.sndAPU, math.sqrt(params.APU_RPM))
			
		if not ED_AudioAPI.isSourcePlaying(self.sndAPU) then
			ED_AudioAPI.playSourceOnce(self.sndAPUbegin)
			ED_AudioAPI.playSourceLooped(self.sndAPU)
		end
	end
end
