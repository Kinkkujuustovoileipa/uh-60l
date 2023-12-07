-- Utility functions/classes
dofile(LockOn_Options.common_script_path.."tools.lua")
sensor_data = get_base_data()
Terrain = require('terrain')
weather = require('Weather')

radian_to_degree = 57.2957795
meters_to_feet = 3.2808399
msToFpm = meters_to_feet * 60
KG_TO_POUNDS = 2.20462
msToKts = 1.94384
msToKph = 3.6
kmToNm = 0.53995726994149

cockpitOffset = {0, 0.465, -2.876}

dashRotation = 27
newDashOffsetX = 0 -- L/R
newDashOffsetY = -0.012 -- U/D
newDashOffsetZ = 0.04673 -- F/B

lastTime = 0

function startup_print(...)
    print(...)
end

function sign(n)
  return n > 0 and 1
     or  n < 0 and -1
     or  0
end

-- rounds the number 'num' to the number of decimal places in 'idp'
--
-- print(round(107.75, -1))     : 110.0
-- print(round(107.75, 0))      : 108.0
-- print(round(107.75, 1))      : 107.8
function round(num, idp)
    local mult = 10^(idp or 0)
    if num < 0 then
        -- e.g. -1.5 -> -2.0, not 1
        return math.floor(num * mult - 0.5) / mult
    else
        return math.floor(num * mult + 0.5) / mult
    end
end

function clamp(value, minimum, maximum)
	return math.max(math.min(value,maximum),minimum)
end

-- calculates the x,y,z in russian coordinates of the point that is 'radius' distance away
-- from px,py,pz using the x,z angle of 'hdg' and the vertical slant angle
-- of 'slantangle'
function pointFromVector( px, py, pz, hdg, slantangle, radius )
    local x = px + (radius * math.cos(hdg) * math.cos(slantangle))
    local z = pz + (radius * math.sin(-hdg) * math.cos(slantangle))  -- pi/2 radians is west
    local y = py + (radius * math.sin(slantangle))

    return x,y,z
end
 
-- return GCD of m,n
function gcd(m, n)
    while m ~= 0 do
        m, n = math.fmod(n, m), m;
    end
    return n;
end


function LinearTodB(value)
    return math.pow(value, 3)
end


-- jumpwheel()
-- 
-- utility function to generate an animation argument for numberwhels that animate from 0.x11 to 0.x19
-- useful for "whole number" output dials, or any case where the decimal component determines when to
-- do the rollover.  All digits will roll at the same time as the ones digit, if they should roll.
--
-- input 'number' is the original raw number (e.g. 397.3275) and which digit position you want to draw
-- input 'position' is which digit position you want to generate an animation argument
--
-- technique: for aBcc.dd, where B is the position we're asking about, we break the number up into
--            component parts:
--            
--            a is throwaway.
--            B will become the first digit of the output.
--            cc tells us whether we're rolling or not.  All digits in cc must be "9".
--            dd is used for 0.Bdd as the return if we're going to be rolling B.
--
function jumpwheel(number, position)
    local rolling = false
    local a,dd = math.modf( number )                -- gives us aBcc in a, and .dd in dd

    a = math.fmod( a, 10^position )                 -- strips a to give us Bcc in a
    local B = math.floor( a / (10^(position-1)) )   -- gives us B by itself
    local cc = math.fmod( a, 10^(position-1) )      -- gives us cc by itself

    if cc == (10^(position-1)-1) then
        rolling = true                              -- if all the digits to the right are 9, then we are rolling based on the decimal component
    end

    if rolling then
        return( (B+dd)/10 )
    else
        return B/10
    end
end

---------------------------------------------
--[[
Function to recursively dump a table to a string, can be used to gain introspection into _G too
Usage:
str=dump("_G",_G)
print(str)  -- or log to DCS log file (log.alert), or print_message_to_user etc.
--]]
function basic_dump (o)
  if type(o) == "number" then
    return tostring(o)
  elseif type(o) == "string" then
    return string.format("%q", o)
  else -- nil, boolean, function, userdata, thread; assume it can be converted to a string
    return tostring(o)
  end
end

function strsplit(delimiter, text)
  local list = {}
  local pos = 1
  if string.find("", delimiter, 1) then
    return {}
  end
  while 1 do
    local first, last = string.find(text, delimiter, pos)
    if first then -- found?
      table.insert(list, string.sub(text, pos, first-1))
      pos = last+1
    else
      table.insert(list, string.sub(text, pos))
      break
    end
  end
  return list
end

---------------------------------------------
---------------------------------------------
--[[
PID Controller class (Proportional-Integral-Derivative Controller)
(backward Euler discrete form)
--]]

PID = {} -- the table representing the class, which will double as the metatable for the instances
PID.__index = PID -- failed table lookups on the instances should fallback to the class table, to get methods
setmetatable(PID, {
  __call = function( cls, ... )
    return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=PID() is equivalent to a=PID.new()
  end,
})

function PID.new( Kp, Ki, Kd, umin, umax, uscale )
    local self = setmetatable({}, PID)

    self.Kp = Kp or 1   -- default to a weight=1 "P" controller
    self.Ki = Ki or 0
    self.Kd = Kd or 0

    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
    self.k3 = self.Kd

    self.e2 = 0     -- error term history for I/D functions
    self.e1 = 0
    self.e = 0

    self.du = 0     -- delta U()
    self.u = 0      -- U() term for output

    self.umax = umax or 999999  -- allow bounding of e for PID output limits
    self.umin = umin or -999999
    self.uscale = uscale or 1   -- allow embedded output scaling and range limiting

    return self
end

-- used to tune Kp on the fly
function PID:set_Kp( val )
    self.Kp = val
    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
end

-- used to tune Kp on the fly
function PID:get_Kp()
    return self.Kp
end

-- used to tune Ki on the fly
function PID:set_Ki( val )
    self.Ki = val
    self.k1 = self.Kp + self.Ki + self.Kd
end

-- used to tune Ki on the fly
function PID:get_Ki()
    return self.Ki
end

-- used to tune Kd on the fly
function PID:set_Kd( val )
    self.Kd = val
    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
    self.k3 = self.Kd
end

-- used to tune Kd on the fly
function PID:get_Kd()
    return self.Kd
end

function PID:run( setpoint, mv )
    self.e2 = self.e1
    self.e1 = self.e
    self.e = setpoint - mv

    -- backward Euler discrete PID function
    self.du = self.k1*self.e + self.k2*self.e1 + self.k3*self.e2
    self.u = self.u + self.du

    if self.u < self.umin then
        self.u = self.umin
    elseif self.u > self.umax then
        self.u = self.umax
    end

    return self.u*self.uscale
end

-- reset dynamic state
function PID:reset(u)
    self.e2 = 0
    self.e1 = 0
    self.e = 0

    self.du = 0
    if u then
        self.u = u/self.uscale
    else
        self.u = 0
    end
end


---------------------------------------------
---------------------------------------------
--[[
Weighted moving average class, useful for supplying values to gauges in an exponential decay/growth form (avoid instantaneous step values)
It keeps only a single previous value, the pseudocode is:
  prev_value = (weight*new_value + (1-weight)*prev_value)
Example usage:
myvar=WMA(0.15,0)   -- create the object (once off), first param is weight for newest values, second param is initial value, both params optional
-- use the object repeatedly, the value passed is stored internally in the object and the return value is the weighted moving average
gauge_param:set(myvar:get_WMA(new_val))

0.15 is a good value to use for gauges, it takes about 20 steps to achieve 95% of a new set point value
--]]

WMA = {} -- the table representing the class, which will double as the metatable for the instances
WMA.__index = WMA -- failed table lookups on the instances should fallback to the class table, to get methods
setmetatable(WMA, {
  __call = function (cls, ...)
    return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=WMA() is equivalent to a=WMA.new()
  end,
})

-- Create a new instance of the object.
-- latest_weight must be between 0.01 and 1,  defaults to 0.5 if not supplied.
-- init_val sets the initial value, if not supplied it will be initialized the first time get_WMA() is called
function WMA.new (latest_weight, init_val)
  local self = setmetatable({}, WMA)

  self.cur_weight=latest_weight or 0.5 -- default to 0.5 if not passed as param
  if self.cur_weight>1.0 then
  	self.cur_weight=1.0
  end
  if self.cur_weight<0.01 then
  	self.cur_weight=0.01
  end
  self.cur_val = init_val  -- can be nil if not passed, will be initialized first time get_WMA() is called
  self.target_val = self.cur_val
  return self
end

-- this updates current value based on weighted moving average with new value v, and returns the weighted moving average
-- the target value v is kept internally and can be retrieved with the get_target_val() function
function WMA:get_WMA (v)
  self.target_val = v
  if not self.cur_val then
  	self.cur_val=v
  	return self.cur_val
  end
  self.cur_val = self.cur_val+(v-self.cur_val)*self.cur_weight
  return self.cur_val
end

-- if necessary to update the current value instantaneously (bypass weighted moving average)
function WMA:set_current_val (v)
    self.cur_val = v
    self.target_val = v
end

-- if necessary to read the current weighted average value (without updating the weighted moving average with a new value)
function WMA:get_current_val ()
    return self.cur_val
end

-- read the target value (latest value passed to the get_WMA() function)
function WMA:get_target_val ()
    return self.target_val
end

--[[
-- test code
target_cur={}
table.insert(target_cur, {600,0})
table.insert(target_cur, {0,600})

for k,v in ipairs(target_cur) do
	target=v[1]
	cur=v[2]

	print("--- "..cur,target)
	myvar=WMA(0.15,cur)
	for j=1,20 do
		print(myvar:get_WMA(target))
	end
end
--]]

---------------------------------------------


---------------------------------------------
--[[
Weighted moving average class that treats [range_min,range_max] as wraparound, useful for supplying values to circular gauges in an exponential decay/growth form (avoid instantaneous step values)
It keeps only a single previous value, the pseudocode is:
  prev_value = ((prev_value+weight*(wrapped(new_value-old_value)))
Example usage:
myvar=WMA_wrap(0.15,0)   -- create the object (once off), first param is weight for newest values, second param is initial value, both params optional
-- use the object repeatedly, the value passed is stored internally in the object and the return value is the weighted moving average wrapped between range_min and range_max
gauge_param:set(myvar:get_WMA_wrap(new_val))

0.15 is a good value to use for gauges, it takes about 20 steps to achieve 95% of a new set point value
--]]

WMA_wrap = {} -- the table representing the class, which will double as the metatable for the instances
WMA_wrap.__index = WMA_wrap -- failed table lookups on the instances should fallback to the class table, to get methods
setmetatable(WMA_wrap, {
  __call = function (cls, ...)
    return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=WMA_wrap() is equivalent to a=WMA_wrap.new()
  end,
})

-- Create a new instance of the object.
-- latest_weight must be between 0.01 and 1,  defaults to 0.5 if not supplied.
-- init_val sets the initial value, if not supplied it will be initialized the first time get_WMA_wrap() is called
-- range_min defaults to 0, range_max defaults to 1
function WMA_wrap.new (latest_weight, init_val, range_min, range_max)
  local self = setmetatable({}, WMA_wrap)

  self.cur_weight=latest_weight or 0.5 -- default to 0.5 if not passed as param
  if self.cur_weight>1.0 then
  	self.cur_weight=1.0
  end
  if self.cur_weight<0.01 then
  	self.cur_weight=0.01
  end
  self.cur_val = init_val  -- can be nil if not passed, will be initialized first time get_WMA_wrap() is called
  self.target_val = self.cur_val
  self.range_min=math.min(range_min or 0.0, range_max or 1.0)
  self.range_max=math.max(range_min or 0.0, range_max or 1.0)
  self.range_delta=range_max-range_min;
  self.range_thresh=self.range_delta/8192
  return self
end

-- this can almost certainly be simplified, but I was lazy and did it the straightforward way
local function get_shortest_delta(target,cur,min,max)
	local d1,d2,delta
	if target>=cur then
		d1=target-cur
		d2=cur-min+(max-target)
		if d2<d1 then
			delta=-d2
		else
			delta=d1
		end
	else
		d1=cur-target
		d2=target-min+(max-cur)
		if d1<d2 then
			delta=-d1
		else
			delta=d2
		end
	end
	return delta
end

-- this updates current value based on weighted moving average with new value v, and returns the weighted moving average
-- the target value v is kept internally and can be retrieved with the get_target_val() function
-- it wraps within [range_min,range_max] and also moves in the shortest direction (clockwise or anticlockwise) between two points
function WMA_wrap:get_WMA_wrap (v)
  self.target_val = v
  if not self.cur_val then
  	self.cur_val=v
  	return self.cur_val
  end
  delta=get_shortest_delta(v, self.cur_val, self.range_min, self.range_max)
  self.cur_val=self.cur_val+(delta*self.cur_weight)
  if math.abs(delta)<self.range_thresh then
    self.cur_val=self.target_val
  end
  if self.cur_val>self.range_max then
  	self.cur_val=self.cur_val-self.range_delta
  elseif self.cur_val<self.range_min then
  	self.cur_val=self.cur_val+self.range_delta
  end
  return self.cur_val
end

-- if necessary to update the current value instantaneously (bypass weighted moving average)
function WMA_wrap:set_current_val (v)
    self.cur_val = v
    self.target_val = v
end

-- if necessary to read the current weighted average value (without updating the weighted moving average with a new value)
function WMA_wrap:get_current_val ()
    return self.cur_val
end

-- read the target value (latest value passed to the get_WMA_wrap() function)
function WMA_wrap:get_target_val ()
    return self.target_val
end

--------------------------------------------------------------------

Constant_Speed_Controller = {}
Constant_Speed_Controller.__index = Constant_Speed_Controller
setmetatable(Constant_Speed_Controller,
  {
    __call = function(cls, ...)
        return cls.new(...) --call constructor if someone calls this table
    end
  }
)

function Constant_Speed_Controller.new(speed, min, max, pos)
  local self = setmetatable({}, Constant_Speed_Controller)
  self.speed = speed
  self.min = min
  self.max = max
  self.pos = pos
  return self
end

function Constant_Speed_Controller:update(target)

  local p = self.pos
  local direction = target - self.pos

  if math.abs(direction) <= self.speed then
    self.pos = target
  elseif direction < 0.0 then
    self.pos = self.pos - self.speed
  elseif direction > 0.0 then
    self.pos = self.pos + self.speed
  end

end

function Constant_Speed_Controller:get_position()
  return self.pos
end










--------------------------------------------------------------------

--[[
Description
Recursively descends both meta and regular tables and prints their key : value pairs until
limits are reached or the table is exhausted. Returns the resulting string.

@param[in] table_to_print 		root of the tables to recursively explore
@param[in] max_depth				how many levels are recursion (not function recursion) are allowed.
@param[in] max_number_tables		how many different tables are allowed to be processed in total

@return STRING
]]--
function recursively_traverse(table_to_print, max_depth, max_number_tables)
	
  max_depth = max_depth or 100
  max_number_tables = max_number_tables or 100

	stack = {}
	
	table.insert(stack, {key = "start", value = table_to_print, level = 0})
	
	total = 0
	
	hash_table = {}

	hash_table[tostring(hash_table)] = 2
	hash_table[tostring(stack)] = 2
	
  str = ""

	item = true
	while (item) do
		item = table.remove(stack)
		
		if (item == nil) then
			break
		end
		key = item.key
		value = item.value
		level = item.level
		
		str = str..(string.rep("        ", level)..tostring(key).." = "..tostring(value).."\n")
		
		hash = hash_table[tostring(value)]
		valid_table = (hash == nil or hash < 2)
		
		if (type(value) == "table" and valid_table) then
			for k,v in pairs(value) do
				if (v ~= nil and level <= max_depth and total < max_number_tables) then
					table.insert(stack, {key = k, value = v, level = level+1})
					if (type(v) == "table") then
						if (hash_table[tostring(v)] == nil) then
							hash_table[tostring(v)] = 1
						elseif (hash_table[tostring(v)] < 2) then
							hash_table[tostring(v)] = 2
						end
						total = total + 1
					end
				end
			end
		end
		
		if (getmetatable(value) and valid_table) then
			for k,v in pairs(getmetatable(value)) do
				if (v ~= nil and level <= max_depth and total < max_number_tables) then
					table.insert(stack, {key = k, value = v, level = level+1})
					if (type(v) == "table") then
						if (hash_table[tostring(v)] == nil) then
							hash_table[tostring(v)] = 1
						elseif (hash_table[tostring(v)] < 2) then
							hash_table[tostring(v)] = 2
						end
						total = total + 1
					end
				end
			end
		end
	end

  return str
end

--[[
Description
Recursively descends both meta and regular tables and prints their key : value pairs until
limits are reached or the table is exhausted.

@param[in] table_to_print 		root of the tables to recursively explore
@param[in] max_depth				how many levels are recursion (not function recursion) are allowed.
@param[in] max_number_tables		how many different tables are allowed to be processed in total
@param[in] filepath				path to put this data

@return VOID
]]--
function recursively_print(table_to_print, max_depth, max_number_tables, filepath)
  file = io.open(filepath, "w")
	file:write("Key,Value\n")
  str = recursively_traverse(table_to_print,max_depth,max_number_tables)
  file:write(str)
  file:close()
end

--[[
-- test code
target_cur={}
table.insert(target_cur, {350,10})
table.insert(target_cur, {10,350})
table.insert(target_cur, {280,90})
table.insert(target_cur, {90,280})

for k,v in ipairs(target_cur) do
	target=v[1]
	cur=v[2]

	print("--- "..cur,target)
	myvar=WMA_wrap(0.15,cur,0,360)
	for j=1,20 do
		print(myvar:get_WMA_wrap(target))
	end
end
--]]
---------------------------------------------

function Dump(o)
  if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. Dump(v) .. ','
      end
      return s .. '} '
  else
      return tostring(o)
  end
end

function formatPrecedingZeros(str, len)
  while string.len(str) < len do
      str = "0"..str
  end

  return str
end

function formatPrecedingSpaces(str, len)
  while string.len(str) < len do
      str = " "..str
  end

  return str
end

function formatPrecedingUnderscores(str, len)
  while string.len(str) < len do
      str = "_"..str
  end

  return str
end

function formatTrailingUnderscores(str, len)
  while string.len(str) < len do
      str = str.."_"
  end

  return str
end

-- Turn a relative bearing into a compass heading
function formatCompassDir(dir)
    -- dir arrives as +/-180 from NORTH i.e. 360
    local angle = 360+dir
    local result = round(math.fmod(angle, 360))
    return result
end

function getBearingToPosition(targetPos, ownPos)
  targetX = targetPos[1]
  targetY = targetPos[2]
  targetZ = targetPos[3]
  ownX = ownPos[1]
  ownY = ownPos[2]
  ownZ = ownPos[3]
  if (targetX and targetZ and ownX and ownZ) then
    local bearing = math.deg(math.atan2((targetZ - ownZ), (targetX - ownX))) % 360
    return bearing
  else
    return 0
  end
end

function getDigit(num, digit)
	local n = 10 ^ digit
	local n1 = 10 ^ (digit - 1)
	return math.floor((num % n) / n1)
end

function getShortestRadialPath(targetBearing, currBrg)
  local smallestDistance = math.min(math.abs(targetBearing - currBrg), math.abs(targetBearing - currBrg + 360), math.abs(targetBearing - currBrg - 360))
  local totalChange = 0

  if (smallestDistance == math.abs(targetBearing - currBrg)) then
      totalChange = targetBearing - currBrg
  elseif (smallestDistance == math.abs(targetBearing - currBrg + 360)) then
      totalChange = targetBearing - currBrg + 360
  else
      totalChange = targetBearing - currBrg - 360
  end

  return totalChange
end

function getShortestCompassPath(targetAngle, currAngle)
  a = targetAngle - currAngle
  b = targetAngle - currAngle + 360
  c = targetAngle - currAngle - 360

  headingDiff = math.min(math.min(math.abs(a), math.abs(b)), math.abs(c));

  if (headingDiff == math.abs(a) and a < 0) then
      headingDiff = -headingDiff
  end
  if (headingDiff == math.abs(b) and b < 0) then
      headingDiff = -headingDiff
  end
  if (headingDiff == math.abs(c) and c < 0) then
      headingDiff = -headingDiff
  end

  return headingDiff;
end

function absMin(input1, input2)
  if math.abs(input1) < math.abs(input2) then
    return input1
  else
    return input2
  end
end

function calculateIndicatorCenter(indicatorPos)
  return {indicatorPos[1] + cockpitOffset[1], indicatorPos[2] + cockpitOffset[2], indicatorPos[3] + cockpitOffset[3]}
end

function calculateIndicatorCenterDash(indicatorPos)
  return {indicatorPos[1] + cockpitOffset[1] + newDashOffsetX, indicatorPos[2] + cockpitOffset[2] + newDashOffsetY, indicatorPos[3] + cockpitOffset[3] + newDashOffsetZ}
end

-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)
-- p = period
-- a = amplitud
function outElastic(t, b, c, d, a, p)
  if t == 0 then return b end
  t = t / d
  if t == 1 then return b + c end
  if not p then p = d * 0.3 end
  local s
  if not a or a < math.abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * math.pi) * math.asin(c/a)
  end

  return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * math.pi) / p) + c + b
end

function moveGauge(param, target, step, dT)
  local newPos = param:get() + absMin(target - param:get(), step * dT * sign(target - param:get()))
  param:set(newPos)
end

function moveCompass(param, target, step, dT)
  local newPos = formatCompassDir(param:get() + absMin(target - param:get(), step * dT))
  param:set(newPos)
end

--[[
local gaugeTable = {}
function moveGauge(paramStr, target)
  local isNew = true
  local storedParams
  local param = get_param_handle(paramStr)

  for k, v in pairs(gaugeTable) do
    --print_message_to_user(Dump(v))
    if v.paramStr == paramStr then
      isNew = false
      if v.target ~= target then
        v.target = target
        v.startTime = get_absolute_model_time()
      end

      storedParams = v
      isNew = false
      break
    else
      isNew = true
    end
  end

  local dT = 0

  if isNew then
    table.insert(gaugeTable, {paramStr = paramStr, target = target, startTime = get_absolute_model_time()})
    --print_message_to_user("added new")
  else
    if storedParams then
      local startTime = storedParams.startTime
      dT = get_absolute_model_time() - startTime
    end
  end

  local curPos = param:get()
  
  -- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)
-- p = period
-- a = amplitud
  local newPos = outElastic(dT, curPos, target - curPos, 1, 1, 1)

  --print_message_to_user("curPos: "..curPos.."; newPos: "..newPos.."; target: "..target.."; dT: "..dT)
  param:set(newPos)
end
]]

function updateNetworkArgs(dev)
  local networkArgString = get_param_handle("NETWORK_UPDATE_ARG"):get()
	if networkArgString then
		local vals = strsplit(",", networkArgString)
		
		local arg = tonumber(vals[1])
		local val = tonumber(vals[2])
    
    if (arg) then
      --print_message_to_user(Dump(vals))
      if (val) then
        
        if (lastArg == arg and lastVal == val) then
          return
        end
        
        --print_message_to_user("Network Arg update: "..arg..", "..val)
        
        --for k,v in pairs(devices) do
        --local device = GetDevice(v):performClickableAction(arg, val, true)
        --end
        
        dev:performClickableAction(arg, val, true)
        dispatch_action(nil, 1e9 + arg, val)
        
        lastArg = arg
        lastVal = val
      end
    else
      --print_message_to_user("nil arg: "..networkArgString)
    end
	end
end

function printsec(str)
  if get_absolute_model_time() - lastTime > 1 then
    print_message_to_user(str)
    lastTime = get_absolute_model_time()
  end
end

-- A4 functions
local mdir      = lfs.tempdir()
local cfile     = lfs.writedir()..'Data\\h60TempMission.lua'
local userPath  = lfs.writedir()..'Data\\'

function scandir(directory)
	local i, t = 0, {}
	for file in lfs.dir(directory) do
		if string.match(file, "~mis") then
			i = i + 1
			t[i] = directory .. file
		end
	end
	return t
end

function findMissionFile(fileList)
	local correctFile = 0
	local newest = 0
	local file_attr

	for fileNumber, filepath in pairs(fileList) do
	
    if correctFile == 0 then
      file = io.open(filepath, "r") 
    
      local fLine = file:read()
      
      if string.match(fLine, "mission") then
        file_attr = lfs.attributes(filepath)
        if file_attr.modification > newest then
          correctFile = filepath
          newest = file_attr.modification
        end
      end
      if file then
      file:close()
      end
    end
	end
	return correctFile
end

function copyFile(fpath, cpath)
	infile = io.open(fpath, "r")
	instr = infile:read("*a")
	infile:close()

	outfile = io.open(cpath, "w+")
	outfile:write(instr)
	outfile:close()
end


function load_tempmission_file()

	local fList = scandir(mdir)
	local rf 	= findMissionFile(fList)
	copyFile(rf, cfile)
  
	dofile(userPath..'h60TempMission.lua')

	log.info("Temp mission file loaded")
end
-- end of A4 functions

function getMissionBeacons(mission)
  local beacons = {}

  if mission then
    local triggers = mission.trigrules
    for k,v in pairs(triggers) do
      if v.actions then
        for i,j in pairs(v.actions) do
          if j.frequency and j.zone then
            local freq = j.frequency * 1e6
            local zoneID = j.zone
            
            for a,b in pairs(mission.triggers.zones) do
              if b.zoneId == zoneID then
                table.insert(beacons, {frequency = freq, position = {b.x, 0, b.y}})
              end
            end
          end
        end
      end
    end
  else
    return {}
  end
  return beacons
end

function drawGrid(x2, y2, z2, columns, rows, parent)
  for i = 0,columns do
    local x = x2 + i * 0.002
    local y = y2
    local w = columns * 0.002
    local h = rows * 0.002
    local lineWidth = 0.0003

    local columnLine 			 = CreateElement "ceMeshPoly"
    columnLine.name 			 = create_guid_string()
    columnLine.vertices 		 = {{x, 0}, {x, 0 + h}, {x + lineWidth, y + h}, {x + lineWidth, y}}
    columnLine.indices 		 = {0,1,2,2,3,0}
    columnLine.init_pos		 = {0,0,z2}
    columnLine.init_rot		 = 0
    if i % 10 == 0 then
      columnLine.material		 = MakeMaterial(nil,{255,0,0,255})
    else
      columnLine.material		 = MakeMaterial(nil,{64,224,208,255})
    end
    columnLine.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    columnLine.level			 = 6
    columnLine.parent_element  = parent.name
    Add(columnLine)
  end
end

-- Calculates magnetic variation using true and mag heading.
function getDeclination()
    local magHeading = sensor_data.getMagneticHeading()
    -- weird fudge factor as regular heading was way off.
    -- Maybe it's weird for helos?
    local heading = 2*math.pi - sensor_data.getHeading()
    local magVar = math.deg(magHeading-heading)
    if magVar > 180 then
        magVar = magVar - 360 - 0.5
    else
        magVar = magVar + 0.5
    end
    -- no math.round function, so use the floor+0.5 fudge
    return math.floor(magVar)
end

function getAircraftHeading()
    local aircraftMagHeading = math.deg(sensor_data.getMagneticHeading())
    return round(aircraftMagHeading)
end

function getRelativeBearing(bearing)
    local aircraftMagHeading = getAircraftHeading()
    local path = getShortestCompassPath(bearing, aircraftMagHeading)
    return path
end