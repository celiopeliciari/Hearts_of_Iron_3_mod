-----------------------------------------------------------
-- LUA Hearts of Iron 3 Utility7 File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 6/30/2010
-----------------------------------------------------------

local P = {}
Utils = P

function P.LUA_DEBUGOUT(s)
	-- Uncomment to see debug logging
	local f = io.open("lua_output.txt", "a")
	f:write("LUA_DEBUG '" .. s .. "' \n")
	f:close()
end

-----------------------------------------------------------------------------
-- calls specified function in country specific AI module if it exists
--
-- tag: country tag to load library for
-- funName: name of function to call if exists
-- currentScore - current score, returned if no module found
-- rest of args are passed to resolved funName and currentScore appended.
-----------------------------------------------------------------------------
function P.CallScoredCountryAI(tag, funName, currentScore, ...)
	local funRef = P.HasCountryAIFunction(tag, funName)
	if funRef then
		return funRef(currentScore, ...)
	end
	return currentScore
end

function P.CallCountryAI(tag, funName, ...)
	local funRef = P.HasCountryAIFunction(tag, funName)
	if funRef then
		return funRef(...)
	end
end

-- returns function ref if one exists, otherwise null
function P.HasCountryAIFunction(tag, funName)
	local countryModule = _G['AI_' .. tostring(tag)]
	if countryModule then
		local funRef = countryModule[funName]
		return funRef
	end
	return nil
end

-- returns list of files in a directory matching pattern
function P.ScanDir(dirname, pattern )
	local callit = os.tmpname()
	os.execute("dir /A-D /B "..dirname .. " >"..callit)
	local f = io.open(callit,"r")
	local rv = f:read("*all")
	f:close()
	os.remove(callit)

	tabby = {}
	local from  = 1
	local delim_from, delim_to = string.find( rv, "\n", from  )
	while delim_from do
		local subs = string.sub( rv, from , delim_from-1 )
		if string.match(subs, pattern) then
			table.insert( tabby, subs )
		end
		from  = delim_to + 1
		delim_from, delim_to = string.find( rv, "\n", from  )
	end
	return tabby
end

-- Create Unit with NO attachments
--    Used to create naval, air and land divisions with no special needs.
function P.CreateDivision_nominor(voProductionData, vsType, viMaxSerial, ic, viUnitQuantity, viMaxPerDiv, vbGoOver)
	local unitType = CSubUnitDataBase.GetSubUnit(vsType)	
	local liTotalDivisions = math.floor(viUnitQuantity / viMaxPerDiv)
	
	if ic > 0.2 and voProductionData.TechStatus:IsUnitAvailable(unitType) then	
		local capitalProvId = voProductionData.ministerCountry:GetActingCapitalLocation():GetProvinceID()
		local bBuildReserve = (not voProductionData.IsAtWar) and unitType:IsRegiment()
		local i = 0 -- Counter for amount of units built
		local unitcost = voProductionData.ministerCountry:GetBuildCostIC( unitType, 1, bBuildReserve ):Get()
		
		while i < liTotalDivisions do
			local buildcount
			
			if 	liTotalDivisions >= (i + viMaxSerial) then
				buildcount = viMaxSerial
				i = i + viMaxSerial
			else
				buildcount = liTotalDivisions - i
				i = liTotalDivisions
			end
			
			local res = ic - (unitcost * viMaxPerDiv)
			if res > 0.2 or vbGoOver then
				ic = res
				
				local orderlist = SubUnitList()
				-- Add the amount of brigades requested of the main type
				if viMaxPerDiv == 1 then
					SubUnitList.Append( orderlist, unitType )
				else
					for m = 1, viMaxPerDiv, 1 do
						SubUnitList.Append( orderlist, unitType )
					end
				end
				viUnitQuantity = viUnitQuantity - (viMaxPerDiv * buildcount)
				voProductionData.ministerAI:Post(CConstructUnitCommand(voProductionData.ministerTag, orderlist, capitalProvId, buildcount, bBuildReserve, CNullTag(), CID()))
				
				if ic < 0.2 then
					i = liTotalDivisions --Causes it to exit loop
				end
			else
				i = liTotalDivisions --Causes it to exit loop
			end
		end
	end
	
	return ic, viUnitQuantity
end

-- Create Divisions with minor attachments
--    Used only for land untis and adding artillery etc....
function P.CreateDivision(voProductionData, vsType, viMaxSerial, ic, viUnitQuantity, viMaxPerDiv, vaMinorUnitArray, viAttachments, vbGoOver)
	local unitType = CSubUnitDataBase.GetSubUnit(vsType)
	local liTotalDivisions = math.floor(viUnitQuantity / viMaxPerDiv)
	
	if ic > 0.2 and voProductionData.TechStatus:IsUnitAvailable(unitType) then
		local capitalProvId = voProductionData.ministerCountry:GetActingCapitalLocation():GetProvinceID()
		local bBuildReserve = (not voProductionData.IsAtWar) and unitType:IsRegiment()
		local i = 0 -- Counter for amount of units built
		local unitcost = voProductionData.ministerCountry:GetBuildCostIC( unitType, 1, bBuildReserve ):Get()

		while i < liTotalDivisions do
			local buildcount
			
			if 	liTotalDivisions >= (i + viMaxSerial) then
				buildcount = viMaxSerial
				i = i + viMaxSerial
			else
				buildcount = liTotalDivisions - i
				i = liTotalDivisions
			end
			
			local res = ic - (unitcost * viMaxPerDiv)
			if res > 0.2 or vbGoOver then
				ic = res
				
				local orderlist = SubUnitList()
				-- Add the amount of brigades requested of the main type
				if viMaxPerDiv == 1 then
					SubUnitList.Append( orderlist, unitType )
				else
					for m = 1, viMaxPerDiv, 1 do
						SubUnitList.Append( orderlist, unitType )
					end
				end

				-- Attach a minor brigade if one can be attached
				--   updated the ic total for the minor unit being attached
				for i = 1, viAttachments do
					local TotalMinors = table.getn(vaMinorUnitArray)
					if TotalMinors == 1 then
						SubUnitList.Append( orderlist, vaMinorUnitArray[1] )
						ic = ic - (voProductionData.ministerCountry:GetBuildCostIC( vaMinorUnitArray[1], 1, bBuildReserve ):Get())
					elseif TotalMinors > 1 then
						local minorSelected = (math.random(TotalMinors))
						SubUnitList.Append( orderlist, vaMinorUnitArray[minorSelected] )
						ic = ic - (voProductionData.ministerCountry:GetBuildCostIC( vaMinorUnitArray[minorSelected], 1, bBuildReserve ):Get())
					end
				end
				
				viUnitQuantity = viUnitQuantity - (viMaxPerDiv * buildcount)
				voProductionData.ministerAI:Post(CConstructUnitCommand(voProductionData.ministerTag, orderlist, capitalProvId, buildcount, bBuildReserve, CNullTag(), CID()))

				if ic < 0.2 then
					i = liTotalDivisions --Causes it to exit loop
				end
			else
				i = liTotalDivisions --Causes it to exit loop
			end
		end
	end

	return ic, viUnitQuantity
end

-- Setup Potential brigade attachments
-- ARMORED CARS
--    Not going to let the AI build armor cars

--- Build Leg Unit Array
function P.BuildLegUnitArray(voProductionData)
	-- Leg Brigades
	local LegUnitArray = {}
	local anti_air_brigade = CSubUnitDataBase.GetSubUnit("anti_air_brigade")
	local anti_tank_brigade = CSubUnitDataBase.GetSubUnit("anti_tank_brigade")
	local artillery_brigade = CSubUnitDataBase.GetSubUnit("artillery_brigade")
	local engineer_brigade = CSubUnitDataBase.GetSubUnit("engineer_brigade")
	local rocket_artillery_brigade = CSubUnitDataBase.GetSubUnit("rocket_artillery_brigade")
	
	--Setup potential leg UNIT minor brigades
	-- #############################################
	--Check to see if they can actually build anti_air_brigade
	if voProductionData.TechStatus:IsUnitAvailable(anti_air_brigade) then
		table.insert( LegUnitArray, anti_air_brigade )
	end
	--Check to see if they can actually build anti_tank_brigade
	if voProductionData.TechStatus:IsUnitAvailable(anti_tank_brigade) then
		table.insert( LegUnitArray, anti_tank_brigade )
	end
	--Check to see if they can actually build artillery_brigade
	if voProductionData.TechStatus:IsUnitAvailable(artillery_brigade) then
		table.insert( LegUnitArray, artillery_brigade )
	end
	--Check to see if they can actually build engineer_brigade
	if voProductionData.TechStatus:IsUnitAvailable(engineer_brigade) then
		table.insert( LegUnitArray, engineer_brigade )
	end		
	--Check to see if they can actually build rocket_artillery_brigade
	if voProductionData.TechStatus:IsUnitAvailable(rocket_artillery_brigade) then
		table.insert( LegUnitArray, rocket_artillery_brigade )
	end	
	
	return LegUnitArray
end

--- Build Motorized Unit Array
function P.BuildMotorizedUnitArray(voProductionData)
	-- Motorized Brigades
	local MotorizedUnitArray = {}
	local sp_artillery_brigade = CSubUnitDataBase.GetSubUnit("sp_artillery_brigade")
	local sp_rct_artillery_brigade = CSubUnitDataBase.GetSubUnit("sp_rct_artillery_brigade")
	local tank_destroyer_brigade = CSubUnitDataBase.GetSubUnit("tank_destroyer_brigade")

	--Setup potential Motorized UNIT minor brigades
	-- #############################################
	--Check to see if they can actually build sp_artillery_brigade
	if voProductionData.TechStatus:IsUnitAvailable(sp_artillery_brigade) then
		table.insert( MotorizedUnitArray, sp_artillery_brigade )
	end		
	--Check to see if they can actually build sp_rct_artillery_brigade
	if voProductionData.TechStatus:IsUnitAvailable(sp_rct_artillery_brigade) then
		table.insert( MotorizedUnitArray, sp_rct_artillery_brigade )
	end		
	--Check to see if they can actually build motorized_brigade
	if voProductionData.TechStatus:IsUnitAvailable(tank_destroyer_brigade) then
		table.insert( MotorizedUnitArray, tank_destroyer_brigade )
	end	
	
	return MotorizedUnitArray
end

--- Build Armor Unit Array
function P.BuildArmorUnitArray(voProductionData)
	-- Mechanized/Armor Brigades
	local ArmorUnitArray = {}
	local minor_motorized_brigade = CSubUnitDataBase.GetSubUnit("motorized_brigade")
	
	--Setup potential Armor UNIT minor brigades
	-- #############################################
	--Check to see if they can actually build motorized_brigade
	if voProductionData.TechStatus:IsUnitAvailable(minor_motorized_brigade) then
		table.insert( ArmorUnitArray, minor_motorized_brigade )
	end	
	
	return ArmorUnitArray
end

function P.BuildGarrisonUnitArray(voProductionData)
	-- Garrison Brigades
	local GarrisonUnitArray = {}
	local police_brigade = CSubUnitDataBase.GetSubUnit("police_brigade")
	local anti_air_brigade = CSubUnitDataBase.GetSubUnit("anti_air_brigade")
	local anti_tank_brigade = CSubUnitDataBase.GetSubUnit("anti_tank_brigade")
	local artillery_brigade = CSubUnitDataBase.GetSubUnit("artillery_brigade")
	
	--Setup potential Garrison UNIT minor brigades
	-- #############################################
	--Check to see if they can actually build anti_air_brigade
	if voProductionData.TechStatus:IsUnitAvailable(anti_air_brigade) then
		table.insert( GarrisonUnitArray, anti_air_brigade )
	end
	--Check to see if they can actually build anti_tank_brigade
	if voProductionData.TechStatus:IsUnitAvailable(anti_tank_brigade) then
		table.insert( GarrisonUnitArray, anti_tank_brigade )
	end
	--Check to see if they can actually build artillery_brigade
	if voProductionData.TechStatus:IsUnitAvailable(artillery_brigade) then
		table.insert( GarrisonUnitArray, artillery_brigade )
	end
	--Check to see if they can actually build police_brigade
	if voProductionData.TechStatus:IsUnitAvailable(police_brigade) then
		table.insert( GarrisonUnitArray, police_brigade )
	end
	
	return GarrisonUnitArray
end		

function P.Round(viNumber)
	-- In case of floating point issue
	viNumber = tonumber(tostring(viNumber))

	if (viNumber - math.floor(viNumber)) >= 0.5 then
		return math.ceil(viNumber)
	else
		return math.floor(viNumber)
	end
end

function P.IsFriend(ai, voFaction, voCountry, viAlignment)
	-- If they are a less than 70 toward another faction consider them a potential enemy
	local rValue = true
	
	if viAlignment == nil then
		viAlignment = 70
	end
	
	for loFaction in CCurrentGameState.GetFactions() do
		if not(loFaction == voFaction) then
			-- They are aligning with another faction
			if ai:GetCountryAlignmentDistance(voCountry, loFaction:GetFactionLeader():GetCountry()):Get() < viAlignment then
			--if ai:GetNormalizedAlignmentDistance(voCountry, loFaction):Get() < 10 then
				rValue = false
				break
			end
		end
	end
	
	return rValue
end

function P.Split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

function P.CalculateHomeProduced(loResource)
	local liDailyHome = loResource.vDailyHome
	
	if loResource.vConvoyedIn > 0 then
		-- If the Convoy in exceeds Home Produced by 10% it means they have a glutten coming in or
		--   are a sea bearing country like ENG or JAP
		--   so go ahead and count this as home produced up to 80% of it just in case something happens!
		if liDailyHome > loResource.vDailyExpense then
			liDailyHome = liDailyHome + loResource.vConvoyedIn
		elseif loResource.vConvoyedIn > (liDailyHome * 0.1) then
			liDailyHome = liDailyHome + (loResource.vConvoyedIn * 0.9)
		end
	end	
	
	return liDailyHome
end



--[[ 
some nice debug helper code taken from http://lua-users.org/wiki/DataDumper

DataDumper.lua
Copyright (c) 2007 Olivetti-Engineering SA

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

local dumplua_closure = [[
local closures = {}
local function closure(t) 
  closures[#closures+1] = t
  t[1] = assert(loadstring(t[1]))
  return t[1]
end

for _,t in pairs(closures) do
  for i = 2,#t do 
    debug.setupvalue(t[1], i-1, t[i]) 
  end 
end
]]

local lua_reserved_keywords = {
  'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 
  'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 
  'return', 'then', 'true', 'until', 'while' }

local function keys(t)
  local res = {}
  local oktypes = { stringstring = true, numbernumber = true }
  local function cmpfct(a,b)
    if oktypes[type(a)..type(b)] then
      return a < b
    else
      return type(a) < type(b)
    end
  end
  for k in pairs(t) do
    res[#res+1] = k
  end
  table.sort(res, cmpfct)
  return res
end

local c_functions = {}
for _,lib in pairs{'_G', 'string', 'table', 'math', 
    'io', 'os', 'coroutine', 'package', 'debug'} do
  local t = _G[lib] or {}
  lib = lib .. "."
  if lib == "_G." then lib = "" end
  for k,v in pairs(t) do
    if type(v) == 'function' and not pcall(string.dump, v) then
      c_functions[v] = lib..k
    end
  end
end

function P.DataDumper(value, varname, fastmode, ident)
  local defined, dumplua = {}
  -- Local variables for speed optimization
  local string_format, type, string_dump, string_rep = 
        string.format, type, string.dump, string.rep
  local tostring, pairs, table_concat = 
        tostring, pairs, table.concat
  local keycache, strvalcache, out, closure_cnt = {}, {}, {}, 0
  setmetatable(strvalcache, {__index = function(t,value)
    local res = string_format('%q', value)
    t[value] = res
    return res
  end})
  local fcts = {
    string = function(value) return strvalcache[value] end,
    number = function(value) return value end,
    boolean = function(value) return tostring(value) end,
    ['nil'] = function(value) return 'nil' end,
    ['function'] = function(value) 
      return string_format("loadstring(%q)", string_dump(value)) 
    end,
    userdata = function() error("Cannot dump userdata") end,
    thread = function() error("Cannot dump threads") end,
  }
  local function test_defined(value, path)
    if defined[value] then
      if path:match("^getmetatable.*%)$") then
        out[#out+1] = string_format("s%s, %s)\n", path:sub(2,-2), defined[value])
      else
        out[#out+1] = path .. " = " .. defined[value] .. "\n"
      end
      return true
    end
    defined[value] = path
  end
  local function make_key(t, key)
    local s
    if type(key) == 'string' and key:match('^[_%a][_%w]*$') then
      s = key .. "="
    else
      s = "[" .. dumplua(key, 0) .. "]="
    end
    t[key] = s
    return s
  end
  for _,k in ipairs(lua_reserved_keywords) do
    keycache[k] = '["'..k..'"] = '
  end
  if fastmode then 
    fcts.table = function (value)
      -- Table value
      local numidx = 1
      out[#out+1] = "{"
      for key,val in pairs(value) do
        if key == numidx then
          numidx = numidx + 1
        else
          out[#out+1] = keycache[key]
        end
        local str = dumplua(val)
        out[#out+1] = str..","
      end
      if string.sub(out[#out], -1) == "," then
        out[#out] = string.sub(out[#out], 1, -2);
      end
      out[#out+1] = "}"
      return "" 
    end
  else 
    fcts.table = function (value, ident, path)
      if test_defined(value, path) then return "nil" end
      -- Table value
      local sep, str, numidx, totallen = " ", {}, 1, 0
      local meta, metastr = (debug or getfenv()).getmetatable(value)
      if meta then
        ident = ident + 1
        metastr = dumplua(meta, ident, "getmetatable("..path..")")
        totallen = totallen + #metastr + 16
      end
      for _,key in pairs(keys(value)) do
        local val = value[key]
        local s = ""
        local subpath = path
        if key == numidx then
          subpath = subpath .. "[" .. numidx .. "]"
          numidx = numidx + 1
        else
          s = keycache[key]
          if not s:match "^%[" then subpath = subpath .. "." end
          subpath = subpath .. s:gsub("%s*=%s*$","")
        end
        s = s .. dumplua(val, ident+1, subpath)
        str[#str+1] = s
        totallen = totallen + #s + 2
      end
      if totallen > 80 then
        sep = "\n" .. string_rep("  ", ident+1)
      end
      str = "{"..sep..table_concat(str, ","..sep).." "..sep:sub(1,-3).."}" 
      if meta then
        sep = sep:sub(1,-3)
        return "setmetatable("..sep..str..","..sep..metastr..sep:sub(1,-3)..")"
      end
      return str
    end
    fcts['function'] = function (value, ident, path)
      if test_defined(value, path) then return "nil" end
      if c_functions[value] then
        return c_functions[value]
      elseif debug == nil or debug.getupvalue(value, 1) == nil then
        return string_format("loadstring(%q)", string_dump(value))
      end
      closure_cnt = closure_cnt + 1
      local res = {string.dump(value)}
      for i = 1,math.huge do
        local name, v = debug.getupvalue(value,i)
        if name == nil then break end
        res[i+1] = v
      end
      return "closure " .. dumplua(res, ident, "closures["..closure_cnt.."]")
    end
  end
  function dumplua(value, ident, path)
    return fcts[type(value)](value, ident, path)
  end
  if varname == nil then
    varname = "return "
  elseif varname:match("^[%a_][%w_]*$") then
    varname = varname .. " = "
  end
  if fastmode then
    setmetatable(keycache, {__index = make_key })
    out[1] = varname
    table.insert(out,dumplua(value, 0))
    return table.concat(out)
  else
    setmetatable(keycache, {__index = make_key })
    local items = {}
    for i=1,10 do items[i] = '' end
    items[3] = dumplua(value, ident or 0, "t")
    if closure_cnt > 0 then
      items[1], items[6] = dumplua_closure:match("(.*\n)\n(.*)")
      out[#out+1] = ""
    end
    if #out > 0 then
      items[2], items[4] = "local t = ", "\n"
      items[5] = table.concat(out)
      items[7] = varname .. "t"
    else
      items[2] = varname
    end
    return table.concat(items)
  end
end


function P.INSPECT_TABLE(...)
  P.LUA_DEBUGOUT( P.DataDumper(...) .. "\n---" )
end

return Utils
