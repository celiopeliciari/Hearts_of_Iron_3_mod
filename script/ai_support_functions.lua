-----------------------------------------------------------
-- LUA Hearts of Iron 3 Support Methods File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/26/2011
-----------------------------------------------------------

local P = {}
Support = P

function P.Home_Spies_Interventionist(minister)
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local liNationalUnity = ministerCountry:GetNationalUnity():Get()
	local liNeutrality = ministerCountry:GetNeutrality():Get()
	local liPartyPopularity = ministerCountry:AccessIdeologyPopularity():GetValue(ministerCountry:GetRulingIdeology()):Get()

	local newMission
	local command
	local lbHasBadSpies = false
	
	-- Calculate spies in country
	for loCountry in ministerCountry:GetSpyingOnUs() do
		local loSpyPresence = loCountry:GetCountry():GetSpyPresence(ministerTag)
		local loSpyMission = loSpyPresence:GetMission()
		
		if loSpyMission == SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY  
			or loSpyMission == SpyMission.SPYMISSION_DISRUPT_RESEARCH
			or loSpyMission == SpyMission.SPYMISSION_DISRUPT_PRODUCTION
			or loSpyMission == SpyMission.SPYMISSION_SUPPORT_RESISTANCE then
			
			lbHasBadSpies = true
			break
		end

	end	

	if not(ministerCountry:IsAtWar()) then
		-- Counter Espionage check
		if lbHasBadSpies then 
			newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE

		elseif liNationalUnity < 70 then
			newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY				
		-- Support for our party is diminishing so raise it
		elseif liPartyPopularity < 35 then
			newMission = SpyMission.SPYMISSION_BOOST_RULING_PARTY
		
		else
			newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
		end
	else
		-- Make sure we are not close to surrendering
		if ( liNationalUnity < 70) then
			newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY

		-- Bad Spies present so get rid of them
		elseif lbHasBadSpies then 
			newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE

		-- Support for our party is diminishing so raise it
		elseif liPartyPopularity < 35 then
			newMission = SpyMission.SPYMISSION_BOOST_RULING_PARTY
		-- Having nothing else better to do
		elseif ( liNationalUnity < 90) then
			newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY
		else		-- Nothing to do so Counter
			newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
		end	
	end
	
	return newMission
end

-- Method to build a Standard Armor divisions
function P.Build_Standard_Armor(ic, voProductionData, armor_brigade, vbGoOver)
	if armor_brigade >= 2 and (ic > 5 or vbGoOver) then
		local bBuildReserve = not voProductionData.IsAtWar
		local capitalProvId =  voProductionData.ministerCountry:GetActingCapitalLocation():GetProvinceID()

		local MainUnitType = CSubUnitDataBase.GetSubUnit("armor_brigade")
		local Motorized = CSubUnitDataBase.GetSubUnit("motorized_brigade")
		local TankDestroyer = CSubUnitDataBase.GetSubUnit("tank_destroyer_brigade")
		
		local lbMotorized = voProductionData.TechStatus:IsUnitAvailable(Motorized)
		local lbTD = voProductionData.TechStatus:IsUnitAvailable(TankDestroyer)

		local liMainUnitCost = voProductionData.ministerCountry:GetBuildCostIC( MainUnitType, 1, bBuildReserve):Get()
		local liMotorized = voProductionData.ministerCountry:GetBuildCostIC( Motorized, 1, bBuildReserve):Get()		
		local liTDCost = voProductionData.ministerCountry:GetBuildCostIC( TankDestroyer, 1, bBuildReserve):Get()
		
		local maxSerial = 2
		local countPerUnit = 2
		
		while armor_brigade > 0 do
			local bIC = ic - (liMainUnitCost * countPerUnit)

			-- Performance Check
			if bIC < 0 and not(vbGoOver) then
				break
			elseif ic < 0 then
				break
			end

			local buildcount
			
			if 	math.floor(armor_brigade / countPerUnit) >= maxSerial then
				buildcount = maxSerial
			else
				buildcount = math.floor(armor_brigade / countPerUnit)
				armor_brigade = 0
			end			
			
			if buildcount > 0 then
				local orderlist = SubUnitList()
				
				-- Add the amount of brigades requested of the main type
				SubUnitList.Append( orderlist, MainUnitType )
				SubUnitList.Append( orderlist, MainUnitType )
				
				-- Figure out what minor attachments to add
				if lbMotorized then
					SubUnitList.Append( orderlist, Motorized )
					bIC = bIC - liMotorized
				end
				if lbTD then
					SubUnitList.Append( orderlist, TankDestroyer )
					bIC = bIC - liTDCost
				end

				-- Performance Check
				if bIC < 0 and not(vbGoOver) then
					-- Exit the loop
					break
				else
					ic = bIC
					armor_brigade = armor_brigade - (countPerUnit * buildcount)
					voProductionData.ministerAI:Post(CConstructUnitCommand(voProductionData.ministerTag, orderlist, capitalProvId, buildcount, bBuildReserve, CNullTag(), CID()))
				end
			end
		end
	end
	
	return ic, armor_brigade
end

-- Method to build a Standard Motorized divisions
function P.Build_Standard_Motorized(ic, voProductionData, motorized_brigade, vbGoOver)
	if motorized_brigade >= 2 and (ic > 5 or vbGoOver) then
		local bBuildReserve = not voProductionData.IsAtWar
		local capitalProvId =  voProductionData.ministerCountry:GetActingCapitalLocation():GetProvinceID()

		local MainUnitType = CSubUnitDataBase.GetSubUnit("motorized_brigade")
		local TankDestroyer = CSubUnitDataBase.GetSubUnit("tank_destroyer_brigade")
		local SPArtillery = CSubUnitDataBase.GetSubUnit("sp_artillery_brigade")
		local SPRocket = CSubUnitDataBase.GetSubUnit("sp_rct_artillery_brigade")
		
		local lbTD = voProductionData.TechStatus:IsUnitAvailable(TankDestroyer)
		local lbSPArt = voProductionData.TechStatus:IsUnitAvailable(SPArtillery)
		local lbSPRoc = voProductionData.TechStatus:IsUnitAvailable(SPRocket)

		local liMainUnitCost = voProductionData.ministerCountry:GetBuildCostIC( MainUnitType, 1, bBuildReserve):Get()
		local liTDCost = voProductionData.ministerCountry:GetBuildCostIC( TankDestroyer, 1, bBuildReserve):Get()
		local liSPArtCost = voProductionData.ministerCountry:GetBuildCostIC( SPArtillery, 1, bBuildReserve):Get()		
		local liSPRocCost = voProductionData.ministerCountry:GetBuildCostIC( SPRocket, 1, bBuildReserve):Get()		
		
		local maxSerial = 4
		local countPerUnit = 2
		
		while motorized_brigade > 0 do
			local bIC = ic - (liMainUnitCost * countPerUnit)

			-- Performance Check
			if bIC < 0 and not(vbGoOver) then
				break
			elseif ic < 0 then
				break
			end

			local buildcount
			
			if 	math.floor(motorized_brigade / countPerUnit) >= maxSerial then
				buildcount = maxSerial
			else
				buildcount = math.floor(motorized_brigade / countPerUnit)
				motorized_brigade = 0
			end			
			
			if buildcount > 0 then
				local orderlist = SubUnitList()
				
				-- Add the amount of brigades requested of the main type
				SubUnitList.Append( orderlist, MainUnitType )
				SubUnitList.Append( orderlist, MainUnitType )
				
				-- See if you can attach and artillery unit
				if lbSPArt and lbSPRoc and lbTD then
					local liItemSelect = math.random(3)
					
					if liItemSelect == 1 then
						SubUnitList.Append( orderlist, TankDestroyer )
						bIC = bIC - liTDCost
						
					elseif liItemSelect == 2 then
						SubUnitList.Append( orderlist, SPRocket )
						bIC = bIC - liSPRocCost
					else
						SubUnitList.Append( orderlist, SPArtillery )
						bIC = bIC - liSPArtCost
					end
				elseif lbSPArt and lbTD then
					if math.random(2) == 2 then
						SubUnitList.Append( orderlist, TankDestroyer )
						bIC = bIC - liTDCost
					else
						SubUnitList.Append( orderlist, SPArtillery )
						bIC = bIC - liSPArtCost
					end	
				elseif lbSPRoc and lbTD then
					if math.random(2) == 2 then
						SubUnitList.Append( orderlist, TankDestroyer )
						bIC = bIC - liTDCost
					else
						SubUnitList.Append( orderlist, SPRocket )
						bIC = bIC - liSPRocCost
					end	
					
				elseif lbSPArt and lbSPRoc then
					if math.random(2) == 2 then
						SubUnitList.Append( orderlist, SPRocket )
						bIC = bIC - liSPRocCost
					else
						SubUnitList.Append( orderlist, SPArtillery )
						bIC = bIC - liSPArtCost
					end				
				elseif lbSPArt then
					SubUnitList.Append( orderlist, SPArtillery )
					bIC = bIC - liSPArtCost
				elseif lbSPRoc then
					SubUnitList.Append( orderlist, SPRocket )
					bIC = bIC - liSPRocCost
				elseif lbTD then
					SubUnitList.Append( orderlist, TankDestroyer )
					bIC = bIC - liTDCost
				-- No support exist just attach another motor
				--   yes this is additional to the count (WAD)
				else
					SubUnitList.Append( orderlist, MainUnitType )
					bIC = bIC - liMainUnitCost
				end

				-- Pontentially have 2 TDs attached for Combined Arms bonus
				if lbTD then
					SubUnitList.Append( orderlist, TankDestroyer )
					bIC = bIC - liTDCost
				end
				
				-- Performance Check
				if bIC < 0 and not(vbGoOver) then
					-- Exit the loop
					break
				else
					ic = bIC
					motorized_brigade = motorized_brigade - (countPerUnit * buildcount)
					voProductionData.ministerAI:Post(CConstructUnitCommand(voProductionData.ministerTag, orderlist, capitalProvId, buildcount, bBuildReserve, CNullTag(), CID()))
				end
			end
		end
	end

	return ic, motorized_brigade
end

-- Builds Forts in the Province requested as long as it is below the cap requested
function P.Build_Fort(ic, voProductionData, viProvinceID, viMax, vbGoOver)
	if (ic > 4 or (vbGoOver and ic > 1)) then
		local land_fort = CBuildingDataBase.GetBuilding( "land_fort" )
		local loProvince = CCurrentGameState.GetProvince(viProvinceID)
		local loBuilding = loProvince:GetBuilding(land_fort)

		if loBuilding:GetMax():Get() < viMax and loProvince:GetCurrentConstructionLevel(land_fort) == 0 then
			local land_fortCost = voProductionData.ministerCountry:GetBuildCost(land_fort):Get()
			
			if (ic - land_fortCost) >= 0 or vbGoOver then
				local constructCommand = CConstructBuildingCommand(voProductionData.ministerTag, land_fort, viProvinceID, 1)
				
				if constructCommand:IsValid() then
					voProductionData.ministerAI:Post(constructCommand)
					ic = ic - land_fortCost -- Update IC total
				end
			end
		end
	end
	
	return ic
end

-- Builds Airbases in the Province requested as long as it is below the cap requested
function P.Build_AirBase(ic, voProductionData, viProvinceID, viMax, vbGoOver)
	if (ic > 1 or (vbGoOver and ic > 0.5)) then
		local air_base = CBuildingDataBase.GetBuilding("air_base")
		local loProvince = CCurrentGameState.GetProvince(viProvinceID)
		local loBuilding = loProvince:GetBuilding(air_base)

		if loBuilding:GetMax():Get() < viMax and loProvince:GetCurrentConstructionLevel(air_base) == 0 then
			local land_fortCost = voProductionData.ministerCountry:GetBuildCost(air_base):Get()
			
			if (ic - land_fortCost) >= 0 or vbGoOver then
				local constructCommand = CConstructBuildingCommand(voProductionData.ministerTag, air_base, viProvinceID, 1 )
				
				if constructCommand:IsValid() then
					voProductionData.ministerAI:Post(constructCommand)
					ic = ic - land_fortCost -- Upodate IC total
				end
			end
		end
	end
	
	return ic
end

-- Builds Industry in the Province requested as long as it is below the cap requested
function P.Build_Industry(ic, voProductionData, viProvinceID, viMax, vbGoOver)
	if (ic > 4 or (vbGoOver and ic > 1)) then
		local industry = CBuildingDataBase.GetBuilding( "industry" )
		local loProvince = CCurrentGameState.GetProvince(viProvinceID)
		local loBuilding = loProvince:GetBuilding(industry)

		if loBuilding:GetMax():Get() < viMax and loProvince:GetCurrentConstructionLevel(industry) == 0 then
			local land_fortCost = voProductionData.ministerCountry:GetBuildCost(industry):Get()
			
			if (ic - land_fortCost) >= 0 or vbGoOver then
				local constructCommand = CConstructBuildingCommand(voProductionData.ministerTag, industry, viProvinceID, 1)
				
				if constructCommand:IsValid() then
					voProductionData.ministerAI:Post(constructCommand)
					ic = ic - land_fortCost -- Update IC total
				end
			end
		end
	end
	
	return ic
end


return Support