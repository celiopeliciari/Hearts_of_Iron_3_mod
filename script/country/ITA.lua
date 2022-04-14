-----------------------------------------------------------
-- LUA Hearts of Iron 3 Italy File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/27/2011
-----------------------------------------------------------

local P = {}
AI_ITA = P

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
		"heavy_tank_brigade",
		"heavy_tank_gun",
		"heavy_tank_engine",
		"heavy_tank_armour",
		"heavy_tank_reliability",
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
	local ignoreTech = {{"smallwarship_asw", 0},
		{"battlecruiser_technology", 0},
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
		"heavycruiser_armour",
		"submarine_technology",
		"submarine_antiaircraft",
		"submarine_engine",
		"submarine_hull",
		"submarine_torpedoes",
		"submarine_sonar",
		"submarine_airwarningequipment"};		
		
	return ignoreTech, preferTech
end
		
function P.NavalDoctrineTechs(minister)
	local ignoreTech = {{"carrier_group_doctrine", 0},
		{"carrier_crew_training", 0},
		{"carrier_task_force", 0},
		{"naval_underway_repleshment", 0},
		{"radar_training", 0}};

	local preferTech = {"fleet_auxiliary_submarine_doctrine",
		"trade_interdiction_submarine_doctrine",
		"cruiser_warfare",
		"submarine_crew_training",
		"cruiser_crew_training",
		"unrestricted_submarine_warfare_doctrine",
		"spotting",
		"fire_control_system_training",
		"commander_decision_making"};		
		
	return ignoreTech, preferTech
end

function P.IndustrialTechs(minister)
	local ignoreTech = {{"steel_production", 0},
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
	
	-- Check to see if manpower is to low
	-- More than 200 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 100 and voProductionData.LandCountTotal > 100)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.35, -- Air
			0.35, -- Sea
			0.30}; -- Other	
	elseif voProductionData.IsAtWar then
		laArray = {
			0.40, -- Land
			0.20, -- Air
			0.40, -- Sea
			0.0}; -- Other
	else
		laArray = {
			0.35, -- Land
			0.20, -- Air
			0.43, -- Sea
			0.02}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray = {
		5, -- Garrison
		15, -- Infantry
		1, -- Motorized
		1, -- Mechanized
		1, -- Armor
		0, -- Militia
		0}; -- Cavalry
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(voProductionData)
	local laArray = {
		40, -- Land
		1}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		5, -- Fighter
		1, -- CAS
		2, -- Tactical
		2, -- Naval Bomber
		0}; -- Strategic
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(voProductionData)
	local laArray = {
		4, -- Destroyers
		5, -- Submarines
		3, -- Cruisers
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

-- Do not build battle cruisers
function P.Build_Battlecruiser(ic, voProductionData, battlecruiser, vbGoOver)
	-- Replace Battlecruiser request with a Battleship
	if voProductionData.TechStatus:IsUnitAvailable(CSubUnitDataBase.GetSubUnit("battleship")) then
		return Utils.CreateDivision_nominor(voProductionData, "battleship", 1, ic, battlecruiser, 1, vbGoOver)
	else
		return ic, 0
	end
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

function P.HandlePuppets(minister)
	local ministerCountry = minister:GetCountry()
	for loPuppetTag in ministerCountry:GetPossiblePuppets() do
		if tostring(loPuppetTag) == "ETH" then
			minister:GetOwnerAI():Post(CCreateVassalCommand(loPuppetTag, minister:GetCountryTag()))
		end
	end
end

-- End of Intelligence Hooks
-- #######################################
function P.ForeignMinister_EvaluateDecision(score, agent, decision, scope)
	local lsDecision = decision:GetKey():GetString()
	
	if lsDecision == "the_future_of_greece" then
		score = 0 -- ai will select decision when we are ready for war
		
		local fraTag = CCountryDataBase.GetTag("FRA")
		local vicTag = CCountryDataBase.GetTag("VIC")
		local loVicCountry = vicTag:GetCountry()
		
		
		-- Vichy exists go for Greece
		if loVicCountry:Exists() then
			agent:GetCountry():GetStrategy():PrepareWarDecision(CCountryDataBase.GetTag("GRE"), 100, decision, false)
		
		-- 10% random Chance and Check to see if France no longer controls Paris		
		elseif not(CCurrentGameState.GetProvince(2613):GetController() == fraTag)
		and math.random(100) <= 10 then
			agent:GetCountry():GetStrategy():PrepareWarDecision(CCountryDataBase.GetTag("GRE"), 100, decision, false)
		end
		
	elseif lsDecision == "annexation_of_albania" then
		agent:GetCountry():GetStrategy():PrepareWarDecision(CCountryDataBase.GetTag("ALB"), 100, decision, false)
		score = 0 -- ai will select decision when we are ready for war
	end
	
	return score
end

function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local loStrategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local gerTag = CCountryDataBase.GetTag('GER')
	local fraTag = CCountryDataBase.GetTag('FRA')
	local greTag = CCountryDataBase.GetTag('GRE')
	local vicTag = CCountryDataBase.GetTag('VIC')
	
	-- If Italy is leaning to the Axis Faction and Greece is not atwar
	if ministerCountry:GetFaction() == gerTag:GetCountry():GetFaction()
	and not(ministerCountry:GetRelation(greTag):HasWar()) then
		local loFraTagCountry = fraTag:GetCountry()
		
		-- Is France in Exile, Vichy Exist or is France gone?
		if loFraTagCountry:IsGovernmentInExile() 
		or vicTag:GetCountry():Exists()
		or not(loFraTagCountry:Exists())then
			-- Check to make sure Paris is not controlled by France
			if not(CCurrentGameState.GetProvince(2613):GetOwner() == fraTag) then
				loStrategy:PrepareWar(greTag, 100)
			end
		end
	end
end

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Austria, Czechoslovakia as we will get them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Baltic states as Russia will annex them
	-- Ignore Vichy, they wont join anyone unles DOWed
	-- Ignore Denmark if they join allies don't waste the diplomacy
	-- Ignore Poland as we will DOW them with Danzig or War event
	-- Ignore Some Chinese Warlords
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
		"CYN",
		"SIK"};
	
	return laIgnoreList
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	local lsFaction = tostring(actor:GetCountry():GetFaction():GetTag())
	
	if lsFaction == "axis" then
		if lsRepTag == "ROM" then
			score = score + 500
		elseif lsRepTag == "BUL" or lsRepTag == "FIN" then
			score = score + 300
		elseif lsRepTag == "HUN" then
			score = score + 120
		elseif lsRepTag == "AST" or lsRepTag == "CAN" or lsRepTag == "SAF" or lsRepTag == "NZL" then
			score = score - 100
		end
	end

	return score
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	if tostring(actor) == "GER" or tostring(actor) == "SPA" then
		score = score + 15
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

return AI_ITA
