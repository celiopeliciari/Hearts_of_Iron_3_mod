-----------------------------------------------------------
-- LUA Hearts of Iron 3 France File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/27/2011
-----------------------------------------------------------

local P = {}
AI_FRA = P

-- #######################################
-- Static Production Variables overide
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
		0.32, -- landBasedWeight
		0.27, -- landDoctrinesWeight
		0.10, -- airBasedWeight
		0.10, -- airDoctrinesWeight
		0.05, -- navalBasedWeight
		0.04, -- navalDoctrinesWeight
		0.08, -- industrialWeight
		0.0, -- secretWeaponsWeight
		0.04}; -- otherWeight
	
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
			{"militia_smallarms", 0},
			{"militia_support", 0},
			{"militia_guns", 0},
			{"militia_at", 0},
			{"marine_infantry", 0},
			{"jungle_warfare_equipment", 0},
			{"amphibious_warfare_equipment", 0},
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
			{"militia_smallarms", 0},
			{"militia_support", 0},
			{"militia_guns", 0},
			{"militia_at", 0},
			{"marine_infantry", 0},
			{"jungle_warfare_equipment", 0},
			{"amphibious_warfare_equipment", 0},
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
	local ignoreTech = {{"special_forces", 4},
		{"mass_assault", 0},
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
	local ignoreTech = {{"basic_strategic_bomber", 0},
		{"large_fueltank", 0},
		{"four_engine_airframe", 0},
		{"strategic_bomber_armament", 0},
		{"large_bomb", 0},
		{"large_airsearch_radar", 0},
		{"large_navagation_radar", 0}};

	local preferTech = {"single_engine_aircraft_design",
		"basic_aeroengine",
		"basic_small_fueltank",
		"basic_single_engine_airframe",
		"basic_aircraft_machinegun",
		"multi_role_fighter_development",
		"twin_engine_aircraft_design",
		"basic_medium_fueltank",
		"basic_twin_engine_airframe",
		"basic_bomb"};
		
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
		{"strategic_air_command", 0}};

	local preferTech = {"fighter_pilot_training",
		"interception_tactics",
		"cas_pilot_training",
		"cas_groundcrew_training",
		"ground_attack_tactics",
		"tac_pilot_training",
		"interdiction_tactics",
		"tactical_air_command"};		
		
	return ignoreTech, preferTech
end
		
function P.NavalTechs(minister)
	local ignoreTech = {{"battlecruiser_technology", 0},
		{"battlecruiser_antiaircraft", 0},
		{"battlecruiser_engine", 0},
		{"battlecruiser_armour", 0},
		{"super_heavy_battleship_technology", 0},
		{"cag_development", 0},
		{"escort_carrier_technology", 0},
		{"carrier_technology", 0},
		{"carrier_antiaircraft", 0},
		{"carrier_engine", 0},
		{"carrier_armour", 0},
		{"carrier_hanger", 0}};

	local preferTech = {"destroyer_technology",
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
	local ignoreTech = {{"carrier_group_doctrine", 0},
		{"carrier_crew_training", 0},
		{"carrier_task_force", 0},
		{"naval_underway_repleshment", 0},
		{"radar_training", 0}};

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
	local ignoreTech = {{"heavy_aa_guns", 0},
		{"steel_production", 0},
		{"raremetal_refinning_techniques", 0},
		{"coal_processing_technologies", 0}};

	local preferTech = {"agriculture",
		"industral_production",
		"industral_efficiency",
		"oil_to_coal_conversion",
		"supply_production",
		"oil_refinning",
		"education"};
		
	return ignoreTech, preferTech
end
		
function P.SecretWeaponTechs(minister)
	local ignoreTech = {"all"}
	
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
	-- More than 150 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 100 and voProductionData.LandCountTotal > 150)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.35, -- Air
			0.35, -- Sea
			0.30}; -- Other	
	elseif liYear >= 1940 then
		laArray = {
			0.65, -- Land
			0.20, -- Air
			0.10, -- Sea
			0.05}; -- Other
	else
		laArray = {
			0.80, -- Land
			0.15, -- Air
			0.00, -- Sea
			0.05}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray = {
		0, -- Garrison
		15, -- Infantry
		2, -- Motorized
		1, -- Mechanized
		1, -- Armor
		0, -- Militia
		0}; -- Cavalry
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(voProductionData)
	local laArray = {
		30, -- Land
		1}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		8, -- Fighter
		2, -- CAS
		5, -- Tactical
		1, -- Naval Bomber
		0}; -- Strategic
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(voProductionData)
	local laArray = {
		6, -- Destroyers
		4, -- Submarines
		4, -- Cruisers
		1, -- Capital
		0, -- Escort Carrier
		0}; -- Carrier
	
	return laArray
end
-- Transport to Land unit distribution
function P.TransportLandRatio(voProductionData)
	local laArray = {
		40, -- Land
		1}; -- Transport
	
	return laArray
end

-- Build Strong Garrison units with no police
function P.Build_Garrison(ic, voProductionData, garrison_brigade, vbGoOver)
	if garrison_brigade >= 3 and ic > 2 then
		ic, garrison_brigade = Utils.CreateDivision(voProductionData, "garrison_brigade", 4, ic, garrison_brigade, 3, Utils.BuildLegUnitArray(voProductionData), 1, vbGoOver)
	end

	return ic, garrison_brigade
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
		return P.Build_Armor(ic, voProductionData, light_armor_brigade, vbGoOver)
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
		
-- Do not build coastal forts
function P.Build_CoastalFort(ic, voProductionData, vbGoOver)
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

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "AST" 
	or lsActorTag == "CAN" 
	or lsActorTag == "SAF" 
	or lsActorTag == "NZL" 
	or lsActorTag == "ENG" 
	or lsActorTag == "USA" then
		score = score + 20
	end
	
	return score
end

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Afghanistan as they are not worth our time
	-- Ignore Ethiopia as they are going to get hammered by Italy
	-- Ignore Austria, Czechoslovakia as we will get them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Vichy, they wont join anyone unles DOWed
	local laIgnoreList = {
		"AFG",
		"ETH",
		"AUS",
		"CZE",
		"SCH",
		"VIC",
		"JAP",
		"ITA"};
	
	return laIgnoreList
end

function P.HandleMobilization(minister)
	local ai = minister:GetOwnerAI()
	
	local ministerTag =  minister:GetCountryTag()
	local gerTag = CCountryDataBase.GetTag("GER")

	-- If Germany Controls Czechoslovakia then
	if CCurrentGameState.GetProvince(2562):GetController() == gerTag then -- Praha check
		ai:Post(CToggleMobilizationCommand( ministerTag, true ))					
	else
		-- Check if a neighbor is starting to look threatening
		-- This code should be idential to the one in ai_politics_minsiter.lua
		local ministerCountry = minister:GetCountry()
		local liTotalIC = ministerCountry:GetTotalIC()
		local liNeutrality = ministerCountry:GetNeutrality():Get() * 0.9
		
		for loCountryTag in ministerCountry:GetNeighbours() do
			local liThreat = ministerCountry:GetRelation(loCountryTag):GetThreat():Get()
			
			if (liNeutrality - liThreat) < 10 then
				local loCountry = loCountryTag:GetCountry()
				
				liThreat = liThreat * CalculateAlignmentFactor(ai, ministerCountry, loCountry)
				
				if liTotalIC > 50 and loCountry:GetTotalIC() < liTotalIC then
					liThreat = liThreat / 2 -- we can handle them if they descide to attack anyway
				end
				
				if liThreat > 30 then
					if CalculateWarDesirability(ai, loCountry, ministerTag) > 70 then
						ai:Post(CToggleMobilizationCommand( ministerTag, true ))
					end
				end
			end
		end
	end
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	
	if lsRepTag == "HUN" or lsRepTag == "ROM" or lsRepTag == "BUL" or lsRepTag == "FIN" then
		score = score - 20
	elseif lsRepTag == "AST" or lsRepTag == "CAN" or lsRepTag == "SAF" or lsRepTag == "NZL" or lsRepTag == "USA" then
		score = score + 70
	end

	return score
end

return AI_FRA

