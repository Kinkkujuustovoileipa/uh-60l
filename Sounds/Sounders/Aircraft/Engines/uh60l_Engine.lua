dofile("Tools.lua")

offsets = {
	core	= 0,
	core2	= 0,
	core3	= 0,
	fan		= 0,
	turb	= 0,
	jet		= 0,
	jet2	= 0,
	around	= 0,
	around2	= 0
}

engine = {number = 0}

function engine:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.number = 1
	return o
end

function engine:init(number_, host)
	self:initNames(number_)
	self:createSounds(number_, host)
end

function engine:initNames()
		self.core_name		= "Aircrafts/Engines/UH-60L/uh60l_FrontEngine" -- path to sdef files in the [Mods\aircraft\PlaneXXX\Sounds\Effects\Aircrafts\Engines\PlaneXXX] folder
		self.core2_name		= "Aircrafts/Engines/UH-60L/uh60l_FrontEngine"
		self.jet_name		= "Aircrafts/Engines/UH-60L/uh60l_Silent"
		self.jet2_name		= "Aircrafts/Engines/UH-60L/uh60l_Silent"
		self.fan_name		= "Aircrafts/Engines/UH-60L/uh60l_Silent"
		self.turb_name		= "Aircrafts/Engines/UH-60L/uh60l_Silent"
		self.around_name	= "Aircrafts/Engines/UH-60L/uh60l_ExteriorRotor"
		self.around2_name	= "Aircrafts/Engines/UH-60L/uh60l_ExteriorRotor"
		self.rotor_name		= "Aircrafts/Engines/UH-60L/uh60l_ExteriorRotor"
		self.apu_name		= "Aircrafts/Engines/UH-60L/uh60l_Silent"
end

function engine:createSounds(number_, host)
	self.number = number_

	if self.number == 3 then
		if self.rotor_name ~= nil then
			self.sndCore = ED_AudioAPI.createSource(host, self.rotor_name)
		end
	elseif self.number == 4 then
		if self.apu_name ~= nil then
			self.sndCore = ED_AudioAPI.createSource(host, self.apu_name)
		end
	else
		if self.core_name ~= nil then
			self.sndCore = ED_AudioAPI.createSource(host, self.core_name)
		end
		
		if self.core2_name ~= nil then
			self.sndCore2 = ED_AudioAPI.createSource(host, self.core2_name)
		end
		
		if self.core3_name ~= nil then
			self.sndCore3 = ED_AudioAPI.createSource(host, self.core3_name)
		end
		
		if self.jet_name ~= nil then
			self.sndJet = ED_AudioAPI.createSource(host, self.jet_name)
		end
		
		if self.jet2_name ~= nil then
			self.sndJet2 = ED_AudioAPI.createSource(host, self.jet2_name)
		end
		
		if self.around_name ~= nil then
			self.sndAround = ED_AudioAPI.createSource(host, self.around_name)
		end
		
		if self.around2_name ~= nil then
			self.sndAround2 = ED_AudioAPI.createSource(host, self.around2_name)
		end
		
		if self.fan_name ~= nil then
			self.sndFan = ED_AudioAPI.createSource(host, self.fan_name)
		end
		
		if self.turb_name ~= nil then
			self.sndTurb = ED_AudioAPI.createSource(host, self.turb_name)
		end
	end
end

function engine:initCptNames()
	self.engine_l_name  = "Aircrafts/Engines/UH-60L/uh60l_Silent" -- path to sdef files in the [Mods\aircraft\PlaneXXX\Sounds\Effects\Aircrafts\Engines\PlaneXXX] folder
	self.engine_r_name  = "Aircrafts/Engines/UH-60L/uh60l_Silent"
	self.heAmb_l_name   = "Aircrafts/Engines/UH-60L/uh60l_Silent"
	self.heAmb_r_name   = "Aircrafts/Engines/UH-60L/uh60l_Silent"
	self.rotorCpt		= "Aircrafts/Engines/UH-60L/uh60l_InteriorRotor"
	self.apuCpt			= "Aircrafts/Engines/UH-60L/uh60l_InteriorAPU"
end

function engine:createSoundsCpt(hostCpt)
	if self.number == 1 then
		if self.engine_l_name ~= nil then
			self.sndCpt = ED_AudioAPI.createSource(hostCpt, self.engine_l_name)
		end
		
		if self.engine_l2_name ~= nil then
			self.sndCpt2 = ED_AudioAPI.createSource(hostCpt, self.engine_l2_name)
		end

		if self.engine_l3_name ~= nil then
			self.sndCpt3 = ED_AudioAPI.createSource(hostCpt, self.engine_l3_name)
		end
		
		if self.heAmb_l_name ~= nil then
			self.sndCptAmb = ED_AudioAPI.createSource(hostCpt, self.heAmb_l_name)
		end
	elseif self.number == 2 then
		if self.engine_r_name ~= nil then
			self.sndCpt = ED_AudioAPI.createSource(hostCpt, self.engine_r_name)
		end
		
		if self.engine_r2_name ~= nil then
			self.sndCpt2 = ED_AudioAPI.createSource(hostCpt, self.engine_r2_name)
		end
		
		if self.heAmb_r_name ~= nil then
			self.sndCptAmb = ED_AudioAPI.createSource(hostCpt, self.heAmb_r_name)
		end
	elseif self.number == 3 then
		if self.rotorCpt ~= nil then
			self.sndCpt = ED_AudioAPI.createSource(hostCpt, self.rotorCpt)
		end
	elseif self.number == 4 then
		if self.apuCpt ~= nil then
			self.sndCpt = ED_AudioAPI.createSource(hostCpt, self.apuCpt)
		end
	end
end

function engine:destroySoundsCpt()
	if self.sndCpt ~= nil then
		ED_AudioAPI.destroySource(self.sndCpt)
		self.sndCpt = nil
	end
	
	if self.sndCpt2 ~= nil then
		ED_AudioAPI.destroySource(self.sndCpt2)
		self.sndCpt2 = nil
	end
	
	if self.sndCptAmb ~= nil then
		ED_AudioAPI.destroySource(self.sndCptAmb)
		self.sndCptAmb = nil
	end
end

function engine:calculatePitchGainCore(coreRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function engine:calculatePitchGainCore2(coreRPM, fanRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function engine:calculatePitchGainCore3(coreRPM, fanRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function engine:calculatePitchGainFan(fanRPM)
	local gain = 1
	if fanRPM < 0.5 then
		gain = fanRPM * 2
	end
	
	return fanRPM, gain
end

function engine:calculatePitchGainTurb(fanRPM, coreRPM, turbPower)
	local pitch = fanRPM
	if pitch == 0 then
		pitch = coreRPM -- using core if no fan is present
	end
	return pitch, turbPower
end

function engine:calculatePitchGainAround(fanRPM, coreRPM, coreRPM2)
	local pitch = fanRPM
	if pitch == 0 then
		pitch = coreRPM -- using core if no fan is present
	end
	
	return pitch, math.max(0, 5.6592*coreRPM2*coreRPM2 - 13.259*coreRPM2*coreRPM + 8.3924*coreRPM2 - 0.337*coreRPM - 0.0048)
end

function engine:calculatePitchGainJet(fanRPM, coreRPM, thrust, flame)
	local RPM = fanRPM
	if RPM == 0 then
		RPM = coreRPM -- using core if no fan is present
	end
	
	local gain = math.sqrt(thrust)
	if thrust < 0.05 and flame > 0 then
		gain = 0.23 * coreRPM / 0.7
	end
		
	return 0.5 + 0.5 * RPM, gain
end

function engine:calculatePitchGainJet2(thrust)
	local gain
	if thrust > 0.4 then
		gain =  1.67 * thrust - 0.67
	else
		gain = 0
	end
		
	return 1.0, gain
end

function engine:calculatePitchGainCpt(coreRPM)
	return coreRPM, 0.4 * math.sqrt(coreRPM)
end

function engine:calculatePitchGainCpt2(coreRPM, fanRPM, turbPower, vTrue)
	return coreRPM, 1 - (math.exp(-(math.pow(coreRPM, 7))))
end

function engine:calculatePitchGainCptAmb(coreRPM, coreRPM2)
	local gain = 1
	if coreRPM < 0.6784 then
		gain = math.max(0, 2.0967 * coreRPM2 + 0.0516 * coreRPM - 6E-15)
	end
	
	return 1, gain
end

function engine:DBGstop()
	stopSRC = function(src)
		if src ~= nil then
			if ED_AudioAPI.isSourcePlaying(src) then
				dbgPrint("src: " .. src)
				ED_AudioAPI.stopSource(src)
			end
		end
	end
	
	stopSRC(self.sndCore)
	stopSRC(self.sndCore2)
	stopSRC(self.sndCore3)
	stopSRC(self.sndJet)
	stopSRC(self.sndJet2)
	stopSRC(self.sndAround)
	stopSRC(self.sndAround2)
	stopSRC(self.sndFan)
	stopSRC(self.sndTurb)
	stopSRC(self.sndRotor)
	stopSRC(self.sndAPU)
		
	stopSRC(self.sndCpt)
	stopSRC(self.sndCpt2)
	stopSRC(self.sndCptAmb)
end

function engine:controlSound(snd, pitch, gain, offsetKey)
	if gain < 0.01 then
		ED_AudioAPI.stopSource(snd)
	elseif gain >= 0.01 then
		dbgPrint("pitch: " .. pitch)
		dbgPrint("gain: " .. gain)
	
		ED_AudioAPI.setSourcePitch(snd, pitch)
		ED_AudioAPI.setSourceGain(snd, gain)
		
		if not ED_AudioAPI.isSourcePlaying(snd) then
			if offsetKey ~= nil then
				if offsets[offsetKey] ~= nil then
					ED_AudioAPI.playSourceLooped(snd, offsets[offsetKey])
					offsets[offsetKey] = offsets[offsetKey] + 0.5
				end
			else
				ED_AudioAPI.playSourceLooped(snd)
			end
		end
	end
end

function engine:update(coreRPM, fanRPM, turbPower, thrust, flame, vTrue, params)

	dbgPrint("engine:update")

	local corePitch, coreGain = self:calculatePitchGainCore(coreRPM)
	
	local coreRPM2 = coreRPM * coreRPM
	local aroundPitch, aroundGain = self:calculatePitchGainAround(fanRPM, coreRPM, coreRPM2)
	
	if self.sndCore ~= nil then
		dbgPrint("core")
		self:controlSound(self.sndCore, corePitch, coreGain, "core")
	end
	
	if self.sndCore2 ~= nil then
		dbgPrint("core2")
		local core2Pitch, core2Gain = self:calculatePitchGainCore2(coreRPM, fanRPM)
		
		self:controlSound(self.sndCore2, core2Pitch, core2Gain, "core2")
	end
	
	if self.sndCore3 ~= nil then
		dbgPrint("core3")
		local core3Pitch, core3Gain = self:calculatePitchGainCore3(coreRPM, fanRPM)
		
		self:controlSound(self.sndCore3, core3Pitch, core3Gain, "core3")
	end

	if self.sndFan ~= nil then
		dbgPrint("fan")
		local fanPitch, fanGain = self:calculatePitchGainFan(fanRPM)
		self:controlSound(self.sndFan, fanPitch, fanGain, "fan")
	end
	
	if self.sndAround ~= nil then
		dbgPrint("around")
		self:controlSound(self.sndAround, aroundPitch, aroundGain, "around")
	end
	
	if self.sndAround2 ~= nil then
		dbgPrint("around2")
		self:controlSound(self.sndAround2, aroundPitch, aroundGain, "around")
	end
	
	if self.sndTurb ~= nil then
		dbgPrint("turb")
		local turbPitch, turbGain = self:calculatePitchGainTurb(fanRPM, coreRPM, turbPower)
		self:controlSound(self.sndTurb, turbPitch, turbGain, "turb")
	end
	
	if self.sndJet ~= nil then
		dbgPrint("jet")
		local jetPitch, jetGain = self:calculatePitchGainJet(fanRPM, coreRPM, thrust, flame)
		self:controlSound(self.sndJet, jetPitch, jetGain, "jet")
	end
	
	if self.sndJet2 ~= nil then
		dbgPrint("jet2")
		local jet2Pitch, jet2Gain = self:calculatePitchGainJet2(thrust)
		self:controlSound(self.sndJet2, jet2Pitch, jet2Gain, "jet2")
	end
	
	if self.sndCpt ~= nil then
		local cptPitch, cptGain = self:calculatePitchGainCpt(coreRPM)
		self:controlSound(self.sndCpt, cptPitch, cptGain)
	end

	if self.sndCpt2 ~= nil then
		local cpt2Pitch, cpt2Gain = self:calculatePitchGainCpt2(coreRPM, fanRPM, turbPower, vTrue)
		self:controlSound(self.sndCpt2, cpt2Pitch, cpt2Gain)
	end
	
	if self.sndCptAmb ~= nil then
		local cptAmbPitch, cptAmbGain = self:calculatePitchGainCptAmb(coreRPM, coreRPM2)
		self:controlSound(self.sndCptAmb, cptAmbPitch, cptAmbGain)
	end

	if self.sndRotor ~= nil then
		self:controlSound(self.sndRotor, corePitch, coreGain, "core")
	end
end
