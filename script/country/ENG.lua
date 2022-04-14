-----------------------------------------------------------
-- LUA Hearts of Iron 3 United Kingdom File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/22/2011
-----------------------------------------------------------

local P = {}
AI_ENG = P

-- #######################################
-- Static Production Variables overide
function P.LandToAirRatio(voProductionData)
	local laArray = {
		5, -- Land Briages
		1}; -- Air
	
	return laArray
end

function P._LandRatio_Units_(minister)
	local laLandRatioUnits = {
		'garrison_brigade', -- Garrison
		'infantry_brigade', -- Infantry
		'motorized_brigade', -- Motorized
		'mechanized_brigade', -- Mechanized
		'armor_brigade|heavy_armor_brigade|super_heavy_armor_brigade', -- Armor
		'militia_brigade', -- Militia
		'cavalry_brigade'}; -- Cavalry
	
	return laLandRatioUnits
end
-- #######################################

-- Tech weights
--   1.0 = 100% the total needs to equal 1.0
function P.TechWeights(minister)
	local laTechWeights = {
		0.17, -- landBasedWeight
		0.08, -- landDoctrinesWeight
		0.12, -- airBasedWeight
		0.15, -- airDoctrinesWeight
		0.22, -- navalBasedWeight
		0.10, -- navalDoctrinesWeight
		0.10, -- industrialWeight
		0.03, -- secretWeaponsWeight
		0.03}; -- otherWeight
	
	return laTechWeights
end

-- Techs that are used in the main file to be ignored
--   techname|level (level must be 1-9 a 0 means ignore all levels
--   use as the first tech name the word "all" and it will cause the AI to ignore all the techs
function P.LandTechs(minister)
	local ministerCountry = minister:GetCountry()
	local loTechStatus = ministerCountry:GetTechnologyStatus()
	local lbArmor = loTechStatus:IsUnitAvailable(CSubUnitDataBase.GetSubUnit("armor_brigade"))
	local ignoreTech
	
	if lbArmor then
		ignoreTech = {{"cavalry_smallarms", 3}, 
			{"cavalry_support", 3},
			{"cavalry_guns", 3}, 
			{"cavalry_at", 3},
			{"marine_infantry", 0},
			{"armored_car_armour", 0},
			{"armored_car_gun", 0},
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
			{"rocket_art", 0},
			{"rocket_art_ammo", 0},
			{"rocket_carriage_sights", 0}};
	else
		ignoreTech = {{"cavalry_smallarms", 3}, 
			{"cavalry_support", 3},
			{"cavalry_guns", 3}, 
			{"cavalry_at", 3},
			{"marine_infantry", 0},
			{"armored_car_armour", 0},
			{"armored_car_gun", 0},
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
			{"rocket_art", 0},
			{"rocket_art_ammo", 0},
			{"rocket_carriage_sights", 0},
			{"lighttank_gun", 2},
			{"lighttank_engine", 2},
			{"lighttank_armour", 2},
			{"lighttank_reliability", 2}};
	end
	
		
	local preferTech = {"infantry_activation",
		"smallarms_technology",
		"infantry_support",
		"infantry_guns",
		"infantry_at",
		"lighttank_brigade",
		"lighttank_gun",
		"lighttank_engine",
		"lighttank_armour",
		"lighttank_reliability",
		"tank_brigade",
		"tank_gun",
		"tank_engine",
		"tank_armour",
		"tank_reliability",
		"art_barrell_ammo",
		"art_carriage_sights"};
		
	return ignoreTech, preferTech
end

function P.LandDoctrinesTechs(minister)
	local ignoreTech = {{"mass_assault", 0},
		{"large_front", 3},
		{"guerilla_warfare", 0},
		{"peoples_army", 0},
		{"large_formations", 0}};
		
	local preferTech = {"operational_level_command_structure",
		"integrated_support_doctrine",
		"mechanized_offensive",
		"combined_arms_warfare",
		"infantry_warfare",
		"central_planning",
		"grand_battle_plan",
		"assault_concentration"};	
		
	return ignoreTech, preferTech
end

function P.AirTechs(minister)
	local ignoreTech = {};

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
		{"fighter_targerting_focus", 0}};

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
		{"battlecruiser_armour", 0},
		{"super_heavy_battleship_technology", 0},
        {"submarine_airwarningequipment", 0},
        {"submarine_antiaircraft", 0}};

	local preferTech = {"smallwarship_asw",
		"destroyer_technology",
		"destroyer_armament",
		"destroyer_antiaircraft",
		"destroyer_engine",
		"destroyer_armour",
		"heavycruiser_technology",
		"heavycruiser_armament",
		"heavycruiser_antiaircraft",
		"heavycruiser_engine",
		"heavycruiser_armour"};
		
	return ignoreTech, preferTech
end
		
function P.NavalDoctrineTechs(minister)
	local ignoreTech = {};

	local preferTech = {"sea_lane_defence",
		"destroyer_escort_role",
		"battlefleet_concentration_doctrine",
		"destroyer_crew_training",
		"battleship_crew_training",
		"commerce_defence",
		"fire_control_system_training",
		"commander_decision_making"};		
		
	return ignoreTech, preferTech
end

function P.IndustrialTechs(minister)
	local ignoreTech = {{"steel_production", 0},
		{"raremetal_refinning_techniques", 0},
		{"coal_processing_technologies", 0}};

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
	local ignoreTech = {}
	
	return ignoreTech, nil
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
	-- More than 30 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 30 and voProductionData.LandCountTotal > 30)
	or voProductionData.ManpowerTotal < 10 then
		laArray = {
			0.0, -- Land
			0.50, -- Air
			0.0, -- Sea
			0.50}; -- Other	
	elseif liYear <= 1939 and not(voProductionData.IsAtWar) then
		laArray = {
			0.20, -- Land
			0.45, -- Air
			0.30, -- Sea
			0.05}; -- Other
	elseif voProductionData.IsAtWar then
		if liYear <= 1942 then
			laArray = {
				0.25, -- Land
				0.30, -- Air
				0.40, -- Sea
				0.05}; -- Other
		else
			laArray = {
				0.40, -- Land
				0.25, -- Air
				0.30, -- Sea
				0.05}; -- Other
		end
	else
		laArray = {
			0.40, -- Land
			0.25, -- Air
			0.30, -- Sea
			0.05}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray

	-- Check to see if manpower is to low
	-- More than 150 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 100 and voProductionData.LandCountTotal > 150)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.35, -- Air
			0.35, -- Sea
			0.30}; -- Other
	elseif voProductionData.IsAtWar then
		local loUSATag = CCountryDataBase.GetTag("USA")
		local loRelations = voProductionData.ministerAI:GetRelation(voProductionData.ministerTag, loUSATag)
	
		-- If the UK and USA are allied start building a motorized army
		if loRelations:HasAlliance() then
			laArray = {
				1, -- Garrison
				5, -- Infantry
				1, -- Motorized
				1, -- Mechanized
				1, -- Armor
				0, -- Militia
				0}; -- Cavalry
		
		-- We are alone so we need units to defend us
		else
			laArray = {
				3, -- Garrison
				15, -- Infantry
				0, -- Motorized
				0, -- Mechanized
				1, -- Armor
				0, -- Militia
				0}; -- Cavalry
		end
		
	-- We are not atwar so build stuff to protect our huge empire
	else
		laArray = {
			3, -- Garrison
			15, -- Infantry
			0, -- Motorized
			0, -- Mechanized
			1, -- Armor
			0, -- Militia
			0}; -- Cavalry
	end
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(voProductionData)
	local laArray = {
		20, -- Land
		1}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		5, -- Fighter
		1, -- CAS
		3, -- Tactical
		1, -- Naval Bomber
		2}; -- Strategic
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(voProductionData)
	local laArray = {
		9, -- Destroyers
		3, -- Submarines
		6, -- Cruisers
		3, -- Capital
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

-- Build Motorized
function P.Build_Motorized(ic, voProductionData, motorized_brigade, vbGoOver)
	return Support.Build_Standard_Motorized(ic, voProductionData, motorized_brigade, vbGoOver)
end

-- Build Armor
function P.Build_Armor(ic, voProductionData, armor_brigade, vbGoOver)
	return Support.Build_Standard_Armor(ic, voProductionData, armor_brigade, vbGoOver)
end

-- Do not build light armor (wait till you have armor or better)
function P.Build_LightArmor(ic, voProductionData, light_armor_brigade, vbGoOver)
	-- Replace Ligth Armor request with Armor
	if voProductionData.TechStatus:IsUnitAvailable(CSubUnitDataBase.GetSubUnit("armor_brigade")) then
		return P.Build_Armor(ic, voProductionData, light_armor_brigade)
	else
		return ic, 0
	end
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

function P.ProposeDeclareWar(minister)
	local ministerCountry = minister:GetCountry()
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	local axisFaction = CCurrentGameState.GetFaction("axis")
	local alliesFaction = CCurrentGameState.GetFaction("allies")
	local axisLeaderTag = axisFaction:GetFactionLeader()
	
	local loStrategy = ministerCountry:GetStrategy()
	
	-- Make sure UK is part of the allies
	if ministerCountry:GetFaction() == alliesFaction
	and not(loStrategy:IsPreparingWar()) then
		local loMinisterCapital = ministerCountry:GetCapitalLocation():GetContinent()
	
		-- Generic DOW for countries not part of the same faction
		for loTargetCountry in CCurrentGameState.GetCountries() do
			local loTargetTag = loTargetCountry:GetCountryTag()
			
			if not(loTargetCountry:GetFaction() == ministerCountry:GetFaction()) then
				if loTargetCountry:Exists() 
				and loTargetCountry:GetCapitalLocation():GetContinent() == loMinisterCapital then
					if ministerCountry:GetRelation(loTargetTag):GetThreat():Get() > ministerCountry:GetMaxNeutralityForWarWith(loTargetTag):Get()  then
						loStrategy:PrepareWar( loTargetTag, 100 )
					end
				end
			end
		end

		if not(ministerCountry:IsAtWar()) then
			local gerTag = CCountryDataBase.GetTag("GER")
			local itaTag = CCountryDataBase.GetTag("ITA")
			
			local loGerCountry = gerTag:GetCountry()
			local loItaCountry = itaTag:GetCountry()
		
			-- Generic test in case Germany is not the axis leader
			if liYear > 1939 
			and not(ministerCountry:GetRelation(axisLeaderTag):HasWar()) then
				loStrategy:PrepareWar(axisLeaderTag, 100)
			end
			
			-- Check for UK to keep an eye on Germany
			if not(ministerCountry:GetRelation(gerTag):HasWar())
			and loGerCountry:GetFaction() == axisFaction
			and loGerCountry:IsAtWar() then
				loStrategy:PrepareWar( gerTag, 100 )
			end
			
			-- Check for UK to keep an eye on Italy
			if not(ministerCountry:GetRelation(itaTag):HasWar())
			and loItaCountry:GetFaction() == axisFaction
			and loItaCountry:IsAtWar() then
				loStrategy:PrepareWar( itaTag, 100 )
			end
			
		-- If we are atwar with the leader of the Axis then look for Vichy
		elseif ministerCountry:GetRelation(axisLeaderTag):HasWar() then
			-- Vichy Check and allied with USA
			local usaTag = CCountryDataBase.GetTag("USA")
			local vicTag = CCountryDataBase.GetTag("VIC")
			
			local loVicCountry = vicTag:GetCountry()
			local loUsaCountry = usaTag:GetCountry()
			
			local loRelation = ministerCountry:GetRelation(vicTag)
			
			if loVicCountry:Exists()
			and not(loRelation:HasAlliance())
			and not(loVicCountry:HasFaction())
			and not(loRelation:HasWar()) then
				if ministerCountry:GetFaction() == loUsaCountry:GetFaction()
				and loUsaCountry:HasFaction() then
					loStrategy:PrepareWar(vicTag, 100)
				end
			end
		end
	end
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "AST" 
	or lsActorTag == "CAN" 
	or lsActorTag == "SAF" 
	or lsActorTag == "NZL" 
	or lsActorTag == "FRA" 
	or lsActorTag == "USA" then
		score = score + 20
	end
	
	return score
end

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Afghanistan as they are not worth our time
	-- Ignore Ethiopia as they are going to get hammered by Italy
	-- Ignore Austria, Czechoslovakia as we will loose them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Vichy, they wont join anyone unles DOWed
	local laIgnoreList = {
		"SIK",
		"CYN",
		"CGX",
		"CSX",
		"ETH",
		"AUS",
		"CZE",
		"SCH",
		"VIC",
		"JAP",
		"ITA"};
	
	return laIgnoreList
end

-- Influence Monitor list
function P.InfluenceMonitor(minister)
	local laMonitorList = {
		"TUR", -- Europe
		"BEL",
		"HOL",
		"POL",
		"SPA",
		"SPR",
		"POR",
		"SWE",
		"YUG",
		"AFG", -- Middle East
		"PER",
		"SAU",
		"ARG", -- South America
		"BOL",
		"BRA",
		"CHL",
		"COL",
		"ECU",
		"GUY",
		"PAR",
		"PRU",
		"URU",
		"VEN",
		"CUB", -- Central America
		"COS",
		"DOM",
		"GUA",
		"HAI",
		"HON",
		"MEX",
		"NIC",
		"PAN",
		"SAL"};
	
	return laMonitorList
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	
	if lsRepTag == "HUN" or lsRepTag == "ROM" or lsRepTag == "BUL" or lsRepTag == "FIN" then
		score = score - 20
	elseif lsRepTag == "AST" or lsRepTag == "CAN" or lsRepTag == "SAF" or lsRepTag == "NZL" or lsRepTag == "USA" then
		score = score + 70
	elseif lsRepTag == "YUG" or lsRepTag == "GRE" then
		score = score + 20
	end

	return score
end


-- Produce slightly better trained troops
function P.CallLaw_training_laws(minister, voCurrentLaw)
	local _ADVANCED_TRAINING_ = 29
	return CLawDataBase.GetLaw(_ADVANCED_TRAINING_)
end

return AI_ENG
