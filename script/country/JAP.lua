-----------------------------------------------------------
-- LUA Hearts of Iron 3 Japan File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/27/2011
-----------------------------------------------------------
local P = {}
AI_JAP = P

-- #######################################
-- Static Production Variables overide
function P.LandToAirRatio(voProductionData)
	local laArray = {
		5, -- Land Brigades
		1}; -- Air
	
	return laArray
end

-- Tech weights
--   1.0 = 100% the total needs to equal 1.0
function P.TechWeights(minister)
	local laTechWeights = {
		0.22, -- landBasedWeight
		0.09, -- landDoctrinesWeight
		0.12, -- airBasedWeight
		0.15, -- airDoctrinesWeight
		0.18, -- navalBasedWeight
		0.10, -- navalDoctrinesWeight
		0.10, -- industrialWeight
		0.0, -- secretWeaponsWeight
		0.04}; -- otherWeight
	
	return laTechWeights
end

-- Techs that are used in the main file to be ignored
--   techname|level (level must be 1-9 a 0 means ignore all levels
--   use as the first tech name the word "all" and it will cause the AI to ignore all the techs
function P.LandTechs(minister)
	local ignoreTech = {{"cavalry_smallarms", 0}, 
		{"cavalry_support", 0},
		{"cavalry_guns", 0}, 
		{"cavalry_at", 0},
		{"paratrooper_infantry", 0},
		{"desert_warfare_equipment", 0},
		{"artic_warfare_equipment", 0},
		{"airborne_warfare_equipment", 0},
		{"armored_car_armour", 0},
		{"armored_car_gun", 0},
		{"lighttank_brigade", 0},
		{"lighttank_gun", 0},
		{"lighttank_engine", 0},
		{"lighttank_armour", 0},
		{"lighttank_reliability", 0},
		{"tank_brigade", 0},
		{"tank_gun", 0},
		{"tank_engine", 0},
		{"tank_armour", 0},
		{"tank_reliability", 0},
		{"heavy_tank_brigade", 0},
		{"heavy_tank_gun", 0},
		{"heavy_tank_engine", 0},
		{"heavy_tank_armour", 0},
		{"heavy_tank_reliability", 0},
		{"super_heavy_tank_brigade", 0},
		{"super_heavy_tank_gun", 0},
		{"super_heavy_tank_engine", 0},
		{"super_heavy_tank_armour", 0},
		{"super_heavy_tank_reliability", 0},
		{"at_barrell_sights", 0},
		{"at_ammo_muzzel", 0},
		{"aa_barrell_ammo", 0},
		{"aa_carriage_sights", 0},
		{"rocket_art", 0},
		{"rocket_art_ammo", 0},
		{"rocket_carriage_sights", 0}};
		
	local preferTech = {"militia_smallarms",
		"militia_support",
		"militia_guns",
		"militia_at",
		"infantry_activation",
		"smallarms_technology",
		"infantry_support",
		"infantry_guns",
		"infantry_at",
		"marine_infantry",
		"art_barrell_ammo",
		"art_carriage_sights"};
		
	return ignoreTech, preferTech
end

function P.LandDoctrinesTechs(minister)
	local ignoreTech = {{"mobile_warfare", 0},
		{"elastic_defence", 0},
		{"spearhead_doctrine", 0},
		{"schwerpunkt", 0},
		{"blitzkrieg", 0},
		{"operational_level_command_structure", 0},
		{"tactical_command_structure", 0},
		{"integrated_support_doctrine", 0},
		{"superior_firepower", 0},
		{"mechanized_offensive", 0},
		{"combined_arms_warfare", 0},
		{"large_formations", 0}};
		
	local preferTech = {"infantry_warfare",
		"central_planning",
		"mass_assault",
		"peoples_army",
		"guerilla_warfare"};	
		
	return ignoreTech, preferTech
end

function P.AirTechs(minister)
	local ignoreTech = {{"basic_four_engine_airframe", 0},
		{"basic_strategic_bomber", 0},
		{"large_fueltank", 0},
		{"four_engine_airframe", 0},
		{"strategic_bomber_armament", 0},
		{"cargo_hold", 0},
		{"large_bomb", 0},
		{"large_airsearch_radar", 0},
		{"large_navagation_radar", 0},
		{"drop_tanks", 0}};

	local preferTech = {"single_engine_aircraft_design",
		"basic_aeroengine",
		"basic_small_fueltank",
		"basic_single_engine_airframe",
		"basic_aircraft_machinegun",
		"multi_role_fighter_development",
		"twin_engine_aircraft_design",
		"basic_medium_fueltank",
		"basic_twin_engine_airframe",
		"basic_bomb",
		"nav_development",
		"air_launched_torpedo"};
		
	return ignoreTech, preferTech
end

function P.AirDoctrineTechs(minister)
	local ignoreTech = {{"forward_air_control", 0},
		{"battlefield_interdiction", 0},
		{"bomber_targerting_focus", 0},
		{"fighter_targerting_focus", 0}, 
		{"heavy_bomber_pilot_training", 0},
		{"heavy_bomber_groundcrew_training", 0},
		{"strategic_bombardment_tactics", 0},
		{"airborne_assault_tactics", 0},
		{"strategic_air_command", 0}};

	local preferTech = {"fighter_pilot_training",
		"interception_tactics",
		"ground_attack_tactics",
		"tac_pilot_training",
		"interdiction_tactics",
		"tactical_air_command",
		"nav_pilot_training",
		"portstrike_tactics",
		"navalstrike_tactics",
		"naval_air_targeting",
		"naval_tactics"};		
		
	return ignoreTech, preferTech
end
		
function P.NavalTechs(minister)
	local ignoreTech = {{"battlecruiser_technology", 0},
		{"battlecruiser_antiaircraft", 0},
		{"battlecruiser_engine", 0},
		{"battlecruiser_armour", 0}};

	local preferTech = {"destroyer_technology",
		"destroyer_armament",
		"destroyer_antiaircraft",
		"destroyer_engine",
		"destroyer_armour",
		"cag_development",
		"escort_carrier_technology",
		"carrier_technology",
		"carrier_antiaircraft",
		"carrier_engine",
		"carrier_armour",
		"carrier_hanger",
		"submarine_technology",
		"submarine_engine",
		"submarine_hull",
		"submarine_torpedoes"};		
		
	return ignoreTech, preferTech
end
		
function P.NavalDoctrineTechs(minister)
	local ignoreTech = {};

	local preferTech = {"fleet_auxiliary_carrier_doctrine",
		"carrier_group_doctrine",
		"carrier_crew_training",
		"carrier_task_force"};		
		
	return ignoreTech, preferTech
end

function P.IndustrialTechs(minister)
	local ignoreTech = {{"heavy_aa_guns", 0},
		{"rocket_tests", 0},
		{"rocket_engine", 0},
		{"atomic_research", 0},
		{"nuclear_research", 0},
		{"isotope_seperation", 0},
		{"civil_nuclear_research", 0}};

	local preferTech = {"agriculture",
		"industral_production",
		"industral_efficiency",
		"oil_to_coal_conversion",
		"supply_production",
		"oil_refinning",
		"education",
		"mechnical_computing_machine"};
		
	return ignoreTech, preferTech
end
		
function P.SecretWeaponTechs(minister)
	local ignoreTech = {"all"}
	
	return ignoreTech
end

function P.OtherTechs(minister)
	local ignoreTech = {{"naval_engineering_research", 0},
		{"submarine_engineering_research", 0},
		{"aeronautic_engineering_research", 0},
		{"rocket_science_research", 0},
		{"chemical_engineering_research", 0},
		{"nuclear_physics_research", 0},
		{"jetengine_research", 0},
		{"mechanicalengineering_research", 0},
		{"automotive_research", 0},
		{"electornicegineering_research", 0},
		{"artillery_research", 0},
		{"mobile_research", 0},
		{"militia_research", 0},
		{"infantry_research", 0}};

	return ignoreTech, nil
end

-- END OF TECH RESEARCH OVERIDES
-- #######################################


-- #######################################
-- Production Overides the main LUA with country specific ones

-- Production Weights
--   1.0 = 100% the total needs to equal 1.0
function P.ProductionWeights(voProductionData)
	local laArray
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Check to see if manpower is to low
	-- More than 150 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 100 and voProductionData.LandCountTotal > 150)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.35, -- Air
			0.35, -- Sea
			0.30}; -- Other	
	elseif liYear <= 1938 and not(voProductionData.IsAtWar) then
		laArray = {
			0.55, -- Land
			0.15, -- Air
			0.25, -- Sea
			0.05}; -- Other
	else
		laArray = {
			0.30, -- Land
			0.25, -- Air
			0.40, -- Sea
			0.05}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray = {
		10, -- Garrison
		24, -- Infantry
		0, -- Motorized
		0, -- Mechanized
		0, -- Armor
		2, -- Militia
		0}; -- Cavalry
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(voProductionData)
	local laArray = {
		10, -- Land
		1}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		3, -- Fighter
		1, -- CAS
		1, -- Tactical
		1, -- Naval Bomber
		0}; -- Strategic
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(voProductionData)
	local laArray = {
		6, -- Destroyers
		2, -- Submarines
		6, -- Cruisers
		1, -- Capital
		1, -- Escort Carrier
		1}; -- Carrier
	
	return laArray
end
-- Transport to Land unit distribution
function P.TransportLandRatio(voProductionData)
	local laArray = {
		40, -- Land
		1}; -- Transport
	
	return laArray
end

-- Do not build battle cruisers
function P.Build_Battlecruiser(ic, voProductionData, battlecruiser, vbGoOver)
	-- Replace Battlecruiser request with a Battleship
	if voProductionData.TechStatus:IsUnitAvailable(CSubUnitDataBase.GetSubUnit("battleship")) then
		return Utils.CreateDivision_nominor(voProductionData, "battleship", 1, ic, battlecruiser, 1, vbGoOver)
	else
		return ic, 0
	end
end

-- Build Infantry units with only artillery (rare to face armor)
function P.Build_Infantry(ic, voProductionData, infantry_brigade, vbGoOver)
	if infantry_brigade >= 3 and ic > 2 then
		local LegUnitArray = {}
		local artillery_brigade = CSubUnitDataBase.GetSubUnit("artillery_brigade")

		--Check to see if they can actually build artillery brigade
		if voProductionData.TechStatus:IsUnitAvailable(artillery_brigade) then
			table.insert( LegUnitArray, artillery_brigade )
		end	
	
		ic, infantry_brigade = Utils.CreateDivision(voProductionData, "infantry_brigade", 3, ic, infantry_brigade, 3, LegUnitArray, 1, vbGoOver)
	end

	return ic, infantry_brigade
end

-- Build Militia units (China builds smaller divisions)
function P.Build_Militia(ic, voProductionData, militia_brigade, vbGoOver)
	if militia_brigade >= 3 and ic > 2 then
		local LegUnitArray = {}
		local artillery_brigade = CSubUnitDataBase.GetSubUnit("artillery_brigade")

		--Check to see if they can actually build artillery brigade
		if voProductionData.TechStatus:IsUnitAvailable(artillery_brigade) then
			table.insert( LegUnitArray, artillery_brigade )
		end	

		ic, militia_brigade = Utils.CreateDivision(voProductionData, "militia_brigade", 4, ic, militia_brigade, 3, LegUnitArray, 1, vbGoOver)
	end

	return ic, militia_brigade
end

-- Build Strong Garrison units with artillery
function P.Build_Garrison(ic, voProductionData, garrison_brigade, vbGoOver)
	if garrison_brigade >= 3 and ic > 2 then
		local LegUnitArray = {}
		local artillery_brigade = CSubUnitDataBase.GetSubUnit("artillery_brigade")

		--Check to see if they can actually build artillery brigade
		if voProductionData.TechStatus:IsUnitAvailable(artillery_brigade) then
			table.insert( LegUnitArray, artillery_brigade )
		end	

		ic, garrison_brigade = Utils.CreateDivision(voProductionData, "garrison_brigade", 4, ic, garrison_brigade, 2, LegUnitArray, 1, vbGoOver)
	end

	return ic, garrison_brigade
end


-- Do not build Rocket Sites
function P.Build_RocketTest(ic, voProductionData, vbGoOver)
	return ic, false
end

		
-- END OF PRODUTION OVERIDES
-- #######################################

-- #######################################
-- Intelligence Hooks

-- Home_Spies(minister)
-- #######################################

function P.Home_Spies(minister)
	return Support.Home_Spies_Interventionist(minister)
end

-- End of Intelligence Hooks
-- #######################################
function P.ForeignMinister_EvaluateDecision(score, agent, decision, scope)
	local lsDecision = decision:GetKey():GetString()
	
	if lsDecision == "marco_polo_bridge_incident" then
		score = 0
		local manTag = CCountryDataBase.GetTag("MAN") -- Manchuria
		local csxTag = CCountryDataBase.GetTag("CSX") -- Shanxi
		local chiTag = CCountryDataBase.GetTag("CHI") -- China
		local chcTag = CCountryDataBase.GetTag("CHC") -- Communist China
		local ministerCountry = agent:GetCountry()
		local lomanCountry = manTag:GetCountry()
		
		if ministerCountry:IsNeighbour(chiTag)
		or lomanCountry:IsNeighbour(chiTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(chiTag, 100, decision, false)
		elseif ministerCountry:IsNeighbour(csxTag)
		or lomanCountry:IsNeighbour(csxTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(csxTag, 100, decision, false)
		elseif ministerCountry:IsNeighbour(chcTag)
		or lomanCountry:IsNeighbour(chcTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(chcTag, 100, decision, false)
		end
	end
	
	return score
end
function P.ProposeDeclareWar(minister)
	local ministerCountry = minister:GetCountry()
	local loStrategy = ministerCountry:GetStrategy()
	
	if not(loStrategy:IsPreparingWar()) then
		if ministerCountry:GetFaction() == CCurrentGameState.GetFaction('axis') then
			local ministerTag = minister:GetCountryTag()
			local ai = minister:GetOwnerAI()			
			local year = ai:GetCurrentDate():GetYear()
			local month = ai:GetCurrentDate():GetMonthOfYear()
		
			local gerTag = CCountryDataBase.GetTag('GER')
			local sovTag = CCountryDataBase.GetTag('SOV')
			local engTag = CCountryDataBase.GetTag('ENG')
			local holTag = CCountryDataBase.GetTag('HOL')
			local fraTag = CCountryDataBase.GetTag('FRA')
			local usaTag = CCountryDataBase.GetTag('USA')
			local phiTag = CCountryDataBase.GetTag('PHI')
			
		
			-- Soviet War Check
			--    make sure no war with USA first
			if not(ministerCountry:GetRelation(usaTag):HasWar()) then
				if gerTag:GetCountry():GetRelation(sovTag):HasWar() then
					-- check vladivostok area for sov troups
					local vladivostokArea = { [0] = 4195, 4263, 4262, 4390, 4328, 4391, 4457, 4458 }
					local troupCount = 0
					local intelCoverage = 0
					for tmpIndex, provID in pairs(vladivostokArea) do
						local province = CCurrentGameState.GetProvince( provID )
						
						if province:GetIntelLevel(ministerTag) >= 2 then -- >= INTEL_UNITS
							intelCoverage = intelCoverage + 1
						end
						
						troupCount = troupCount + province:GetNumberOfUnits()
					end
					
					if troupCount < 1 and intelCoverage > 7 then
						-- Limited War
						loStrategy:PrepareLimitedWar(sovTag, 100)
					end
				end
			end

			-- USA War Check
			--    make sure no war with the Soviets first
			if not(ministerCountry:GetRelation(sovTag):HasWar()) then
				-- First try and go to war with the USA
				if ((year >= 1941) and (month >= 10)) or (year >= 1942) then
					if not(ministerCountry:GetRelation(usaTag):HasWar())
					and not(usaTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(usaTag, 100)

						-- Prepare for war with Philippines
						if not(ministerCountry:GetRelation(phiTag):HasAlliance())
						and not(ministerCountry:GetRelation(phiTag):HasWar())
						and not(phiTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
							-- Limited War
							loStrategy:PrepareLimitedWar(phiTag, 100)
						end
					end
					
					-- Prepare for war with France
					if not(ministerCountry:GetRelation(engTag):HasAlliance())
					and not(ministerCountry:GetRelation(engTag):HasWar())
					and not(engTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(engTag, 100)
					end
					
					-- Prepare for war with France
					if not(ministerCountry:GetRelation(fraTag):HasAlliance())
					and not(ministerCountry:GetRelation(fraTag):HasWar())
					and not(fraTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(fraTag, 100)
					end

					-- Prepare for war with Holland
					if not(ministerCountry:GetRelation(holTag):HasAlliance())
					and not(ministerCountry:GetRelation(holTag):HasWar())
					and not(holTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(holTag, 100)
					end
				end
			end
		end
	end
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "SIA" or lsActorTag == "USA" then
		score = score + 20
	end
	
	return score
end

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Denmark if they join allies don't waste the diplomacy
	-- Ignore Poland as we will DOW them with Danzig or War event
	-- Ignore Baltic states as Russia will annex them
	-- Ignore Austria, Czechoslovakia as we will get them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Vichy, they wont join anyone unles DOWed
	local laIgnoreList = {
		"AUS",
		"CZE",
		"SCH",
		"LAT",
		"LIT",
		"EST",
		"VIC",
		"DEN",
		"POL",
		"CYN"}
	
	return laIgnoreList
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	
	-- AS Japan only try and get Siam in the war
	--   Once the are in use your slider for research
	if lsRepTag == "SIA" then
		score = score + 500
	else
		score = 0
	end

	return score
end

function P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)
	local loRecipientGroup = recipient:GetCountry():GetRulingIdeology():GetGroup()
	local loActorGroup = actor:GetCountry():GetRulingIdeology():GetGroup()

	-- If they are not of the same Ideology group then dont join them no matter what!
	if loActorGroup ~= loRecipientGroup then
		score = 0
	end
	
	return score
end

function P.DiploScore_Alliance(score, ai, actor, recipient, observer)
	-- Just process the invite to faction code
	return P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)	
end

return AI_JAP
