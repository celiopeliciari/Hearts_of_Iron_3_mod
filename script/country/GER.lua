-----------------------------------------------------------
-- LUA Hearts of Iron 3 Germany File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/28/2011
-----------------------------------------------------------

local P = {}
AI_GER = P

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


-- #######################################
-- Start of Tech Research

-- Tech weights
--   1.0 = 100% the total needs to equal 1.0
function P.TechWeights(minister)
	local laTechWeights = {
		0.24, -- landBasedWeight
		0.18, -- landDoctrinesWeight
		0.11, -- airBasedWeight
		0.18, -- airDoctrinesWeight
		0.06, -- navalBasedWeight
		0.05, -- navalDoctrinesWeight
		0.10, -- industrialWeight
		0.04, -- secretWeaponsWeight
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
			{"cavalry_guns", 3}, 
			{"cavalry_at", 3},
			{"marine_infantry", 0},
			{"jungle_warfare_equipment", 0},
			{"amphibious_warfare_equipment", 0},
			{"armored_car_armour", 0},
			{"armored_car_gun", 0}};	
	else
		ignoreTech = {{"cavalry_smallarms", 3}, 
			{"cavalry_guns", 3}, 
			{"cavalry_at", 3},
			{"marine_infantry", 0},
			{"jungle_warfare_equipment", 0},
			{"amphibious_warfare_equipment", 0},
			{"armored_car_armour", 0},
			{"armored_car_gun", 0},
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
		
	local preferTech = {"mobile_warfare",
		"elastic_defence",
		"spearhead_doctrine",
		"schwerpunkt",
		"blitzkrieg",
		"operational_level_command_structure",
		"delay_doctrine",
		"integrated_support_doctrine",
		"mechanized_offensive",
		"combined_arms_warfare",
		"infantry_warfare"};	
		
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

-- Build_Mountain(ic, minister, bergsjaeger_brigade, vbGoOver)
-- Build_Paratrooper(ic, minister, paratrooper_brigade, vbGoOver)
-- Build_Marine(ic, minister, marine_brigade, vbGoOver)
-- Build_Militia(ic, minister, militia_brigade, vbGoOver)
-- Build_Infantry(ic, minister, infantry_brigade, vbGoOver)
-- Build_Garrison(ic, minister, garrison_brigade, vbGoOver)
-- Build_Cavalry(ic, minister, cavalry_brigade, vbGoOver)
-- Build_Motorized(ic, minister, motorized_brigade, vbGoOver)
-- Build_Mechanized(ic, minister, mechanized_brigade, vbGoOver)
-- Build_LightArmor(ic, minister, light_armor_brigade, vbGoOver)
-- Build_Armor(ic, minister, armor_brigade, vbGoOver)
-- Build_HeavyArmor(ic, minister, armor_brigade, vbGoOver)
-- Build_SuperHeavyArmor(ic, minister, armor_brigade, vbGoOver)

-- Build_CAG(ic, minister, cag, vbGoOver)
-- Build_Interceptor(ic, minister, interceptor, vbGoOver)
-- Build_TacBomber(ic, minister, tactical_bomber, vbGoOver)
-- Build_NavBomber(ic, minister, naval_bomber, vbGoOver)
-- Build_CAS(ic, minister, cas, vbGoOver)
-- Build_MultiRole(ic, minister, multi_role, vbGoOver)
-- Build_StrategicBomber(ic, minister, strategic_bomber, vbGoOver)
-- Build_TransportPlane(ic, minister, transport_plane, vbGoOver)
-- Build_FlyingBomb(ic, minister, transport_plane, vbGoOver)
-- Build_FlyingRocket(ic, minister, transport_plane, vbGoOver)

-- Build_Transport(ic, minister, transport, vbGoOver)
-- Build_Destroyer(ic, minister, destroyer, vbGoOver)
-- Build_LightCruiser(ic, minister, light_cruiser, vbGoOver)
-- Build_HeavyCruiser(ic, minister, heavy_cruiser, vbGoOver)
-- Build_EscortCarrier(ic, minister, escort_carrier, vbGoOver)
-- Build_Carrier(ic, minister, carrier, vbGoOver)
-- Build_Battlecruiser(ic, minister, battlecruiser, vbGoOver)
-- Build_Battleship(ic, minister, battleship, vbGoOver)
-- Build_SuperBattleship(ic, minister, super_heavy_battleship, vbGoOver)
-- Build_Submarine(ic, minister, submarine, vbGoOver)
-- Build_NuclearSubmarine(ic, minister, nuclear_submarine, vbGoOver)

-- #####################
-- Exepected Returns
-- IC = How much IC is left after execution
-- Boolean = Flag indicating weather to execute generic code as well for the building type
-- #####################
-- Build_Underground(ic, voProductionData, vbGoOver)
-- Build_NuclearReactor(ic, voProductionData, vbGoOver)
-- Build_RocketTest(ic, voProductionData, vbGoOver)
-- Build_Industry(ic, voProductionData, vbGoOver)
-- Build_CoastalFort(ic, voProductionData, vbGoOver)
-- Build_Fort(ic, voProductionData, vbGoOver)
-- Build_AntiAir(ic, voProductionData, vbGoOver)
-- Build_Radar(ic, voProductionData, vbGoOver)
-- Build_Infrastructure(ic, voProductionData, vbGoOver)
-- Build_AirBase(ic, voProductionData, vbGoOver)

-- must return how much IC is left

-- Production Weights
--   1.0 = 100% the total needs to equal 1.0
function P.ProductionWeights(voProductionData)
	local laArray
	
	-- Check to see if manpower is to low
	-- More than 400 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 300 and voProductionData.LandCountTotal > 400)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.50, -- Air
			0.20, -- Sea
			0.30}; -- Other
	elseif voProductionData.IsAtWar then
		-- Desperation check and if so heavy production of land forces
		if voProductionData.ministerCountry:CalcDesperation():Get() > 0.4 then
			laArray = {
				0.75, -- Land
				0.20, -- Air
				0.05, -- Sea
				0.0}; -- Other
		else
			laArray = {
				0.67, -- Land
				0.20, -- Air
				0.10, -- Sea
				0.03}; -- Other
		end
	else
		-- Check to see if the fort line is finished and if so take some production away
		local land_fort = CBuildingDataBase.GetBuilding( "land_fort" )
		local loProvince = CCurrentGameState.GetProvince(2490) -- Saarlouis
		local loBuilding = loProvince:GetBuilding(land_fort)

		-- Province 2490 is last of the Siegfriend line if done then adjust build ratio
		if loBuilding:GetMax():Get() > 0 then
			laArray = {
				0.58, -- Land
				0.30, -- Air
				0.10, -- Sea
				0.02}; -- Other
		else
			laArray = {
				0.55, -- Land
				0.30, -- Air
				0.10, -- Sea
				0.05}; -- Other
		end
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Build lots of infantry in the early years
	if liYear <= 1939 then
		laArray = {
			4, -- Garrison
			15, -- Infantry
			2, -- Motorized
			1, -- Mechanized
			1, -- Armor
			0, -- Militia
			0}; -- Cavalry
	else
		laArray = {
			2, -- Garrison
			10, -- Infantry
			2, -- Motorized
			1, -- Mechanized
			2, -- Armor
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
		8, -- Fighter
		3, -- CAS
		4, -- Tactical
		1, -- Naval Bomber
		0}; -- Strategic
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(voProductionData)
	local laArray = {
		3, -- Destroyers
		6, -- Submarines
		2, -- Cruisers
		1, -- Capital
		0, -- Escort Carrier
		0}; -- Carrier
	
	return laArray
end
-- Transport to Land unit distribution
function P.TransportLandRatio(voProductionData)
	local laArray
	local norTag = CCountryDataBase.GetTag('NOR')
	local loNorwayCountry = norTag:GetCountry()
	
	-- If Norway is present build more transports to invade it with
	if loNorwayCountry:Exists()
	and not(voProductionData.ministerCountry:GetRelation(norTag):HasAlliance()) then
		laArray = {
			70, -- Land
			1}; -- Transport	
	else
		laArray = {
			110, -- Land
			1}; -- Transport	
	end
	
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
		
-- Never build and underground
function P.Build_Underground(ic, voProductionData, vbGoOver)
	return ic, false
end

-- Have Germany Fortify the French Line
-- NOTE: if 2490 Province is not the last one please update the land production ratio
function P.Build_Fort(ic, voProductionData, vbGoOver)
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Only build the forts if its 1938 or less
	if liYear <= 1938 then
		ic = Support.Build_Fort(ic, voProductionData, 3084, 1, vbGoOver) -- Todtmoos
		ic = Support.Build_Fort(ic, voProductionData, 3016, 1, vbGoOver) -- Hinterzarten
		ic = Support.Build_Fort(ic, voProductionData, 2948, 1, vbGoOver) -- Baden
		ic = Support.Build_Fort(ic, voProductionData, 2882, 1, vbGoOver) -- Donaueschingen
		ic = Support.Build_Fort(ic, voProductionData, 2751, 1, vbGoOver) -- Villingen
		ic = Support.Build_Fort(ic, voProductionData, 2685, 1, vbGoOver) -- Achern
		ic = Support.Build_Fort(ic, voProductionData, 2619, 1, vbGoOver) -- Pirmasens
		ic = Support.Build_Fort(ic, voProductionData, 2553, 1, vbGoOver) -- Saarbrücken
		ic = Support.Build_Fort(ic, voProductionData, 2490, 1, vbGoOver) -- Saarlouis (See Note)
	end
	
	return ic, false
end

-- END OF PRODUTION OVERIDES
-- #######################################

-- #######################################
-- Intelligence Hooks
-- Home_Spies(minister)


function P.Home_Spies(minister)
	return Support.Home_Spies_Interventionist(minister)
end

-- End of Intelligence Hooks
-- #######################################

function P.HandleMobilization(minister)
	local ai = minister:GetOwnerAI()
	local ministerTag =  minister:GetCountryTag()
	local sovTag = CCountryDataBase.GetTag('SOV')
	local loRelation = ai:GetRelation(ministerTag, sovTag)

	-- We have a NAP with Russia so mobilize for Poland
	if loRelation:HasNap() then
		local liYear = CCurrentGameState.GetCurrentDate():GetYear()
		local liMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()
		
		if liYear == 1939 and liMonth > 6 then
			ai:Post(CToggleMobilizationCommand( ministerTag, true ))
		end
	else
		local ministerCountry = minister:GetCountry()
		local liTotalIC = ministerCountry:GetTotalIC()
		local liNeutrality = ministerCountry:GetNeutrality():Get() * 0.9

		-- Regular loop to see if anyone is threatening to us
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

-- #######################################
-- Diplomacy Hooks
-- InfluenceIgnore(minister)

-- These all must return a numeric score (100 being 100% chance of success)

-- DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
-- DiploScore_Alliance(score, ai, actor, recipient, observer)
-- DiploScore_InviteToFaction(score, ai, actor, recipient, observer)
-- DiploScore_JoinFaction(score, minister, faction)
-- DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
-- DiploScore_Guarantee(score, ai, actor, recipient, observer)
-- DiploScore_Embargo(score, ai, actor, recipient, observer)
-- DiploScore_NonAgression(score, ai, actor, recipient, observer)
-- DiploScore_GiveMilitaryAccess(liScore, voAI, voCountry)
-- DiploScore_CallAlly(liScore, ai, actor, recipient, observer)
-- EvaluateLimitedWar(score, minister, target, warDesirability)

-- Scripted items no return value

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Austria, Czechoslovakia as we will get them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Baltic states as Russia will annex them
	-- Ignore Vichy, they wont join anyone unles DOWed
	-- Ignore Denmark if they join allies don't waste the diplomacy
	-- Ignore Poland as we will DOW them with Danzig or War event
	-- Ignore Luxumburg not worth the time
	-- Ignore Some Chinese Warlords
	local laIgnoreList = {
		"AUS",
		"CZE",
		"SCH",
		"LAT",
		"LIT",
		"EST",
		"VIC",
		"LUX",		
		"DEN",
		"POL",
		"CYN",
		"SIK"};
	
	return laIgnoreList
end

-- Influence Monitor list
function P.InfluenceMonitor(minister)
	local laMonitorList = {
		"TUR", -- Europe
		"SPA",
		"SPR",
		"POR",
		"SWE"};
	
	return laMonitorList
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	
	if lsRepTag == "JAP" then
		score = score + 1500
	elseif lsRepTag == "ITA" then
		score = score + 1200
	elseif lsRepTag == "ROM" then
		score = score + 500
	elseif lsRepTag == "BUL" or lsRepTag == "FIN" or lsRepTag == "HUN" then
		score = score + 300
	elseif lsRepTag == "SIA" then
		score = score + 120
	elseif lsRepTag == "AST" or lsRepTag == "CAN" or lsRepTag == "SAF" or lsRepTag == "NZL" then
		score = score - 100
	end

	return score
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "SOV" or lsActorTag == "SWE" or lsActorTag == "ITA" or lsActorTag == "SPA" then
		score = score + 50
	end
	
	return score
end

function P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)
	local lsTarget = tostring(recipient)
	
	if lsTarget == 'AUS' or lsTarget == 'POL' then -- we got better plans for you...
		return 0
	end
	
	return score
end

function P.DiploScore_Alliance( score, ai, actor, recipient, observer)
	if tostring(recipient) == 'AUS' then -- we got better plans for you...
		return 0
	end
	
	return score
end

function P.DiploScore_JoinFactionGoal( score, ai, actor, recipient, observer, goal )
	local lsSender = tostring(actor)
	local ministerCountry = observer:GetCountry()
	
	if lsSender == 'AUS' then -- we got better plans for you...
		return 0
	elseif lsSender == 'FIN' then
		return 0
	end
    
    return score
end

--##########################
-- Foreign Minister Hooks

-- ForeignMinister_EvaluateDecision(score, agent, decision, scope)
-- Call_Ally(minister)
-- Call_MilitaryAccess(minister)
-- ProposeDeclareWar(minister)

function P.ForeignMinister_EvaluateDecision(score, agent, decision, scope)
	local lsDecision = tostring(decision:GetKey())
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	local liMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()
	local liDay = CCurrentGameState.GetCurrentDate():GetDayOfMonth()
	
	if lsDecision == "molotov_ribbentrop_pact" then
		if liYear == 1939 then
			if (liMonth == 7 and liDay > 5) or	liMonth > 7 then
				return 100
			end
		end
		
		score = 0
		
	elseif lsDecision == "danzig_or_war" then
		if liYear == 1939 then
			if liMonth > 7 then
				agent:GetCountry():GetStrategy():PrepareWarDecision(CCountryDataBase.GetTag("POL"), 100, decision, false)
			end
		end
		
		score = 0
		
	elseif lsDecision == "anschluss_of_austria" then
		if liYear == 1938 then
			if (liMonth == 2 and liDay > 8) or	liMonth > 2 then
				return 100
			end
		end
		
		score = 0
	
	elseif lsDecision == "the_treaty_of_munich" then
		if liYear == 1938 then
			if (liMonth == 8 and liDay > 25) or	liMonth > 8 then
				return 100
			end
		end
		
		score = 0	
		
	elseif lsDecision == "first_vienna_award" or lsDecision == "the_first_vienna_award" then
		if liYear == 1939 then
			if (liMonth == 2 and liDay > 25) or	liMonth > 2 then
				return 100
			end
		end
		
		score = 0		
	end
	
	return score
end

function P.Call_Ally(minister)
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ministerContinent = ministerCountry:GetActingCapitalLocation():GetContinent()
	local ai = minister:GetOwnerAI() 
	
	-- Loop through all wars
	for loDiploStatus in ministerCountry:GetDiplomacy() do
		local loTargetTag = loDiploStatus:GetTarget()
		local lsTargetTag = tostring(loTargetTag)
		
		if loTargetTag:IsValid() and loDiploStatus:HasWar() then
			local loWar = loDiploStatus:GetWar()
			if loWar:IsLimited() then
				local loTargetCountry = loTargetTag:GetCountry()
				
				-- Call in Puppets
				--for loPuppetTag in ministerCountry:GetVassals() do	
				--	if not loWar:IsPartOfWar(loPuppetTag) then
				--		local loAction = CCallAllyAction( ministerTag, loPuppetTag, loTargetTag )
				--		loAction:SetValue( true ) -- limited
				--		if loAction:IsSelectable() then
				--			ai:PostAction(loAction)
				--		end
				--	end
				--end					
				
				-- Call in all potential allies
				for loAllyTag in ministerCountry:GetAllies() do
					local loAllyCountry = loAllyTag:GetCountry()
					
					--Utils.LUA_DEBUGOUT("lsAllyTag: " .. tostring(tostring(loAllyTag)))
					
					-- Check to see if the two are already at war?
					if not(loAllyCountry:GetRelation(loTargetTag):HasWar()) then
						local lsAllyTag = tostring(loAllyTag)					
						
						-- Best guess as to potential Pacific Allies no point in bothering them
						--   Puppet check is added cause it means they are someone elses puppet and
						--   they should be called by that countries AI.
						-- Siam
						-- Japan
						-- Persia
						-- Sikiang
						-- Yunnan
						-- Xibei San Ma
						-- Shanxi
						-- Communist China
						-- Manchuria
						if not(lsAllyTag == "SIA") 
						and not(lsAllyTag == "JAP") 
						and not(lsAllyTag == "PER") 
						and not(lsAllyTag == "SIK") 
						and not(lsAllyTag == "CYN") 
						and not(lsAllyTag == "CXB") 
						and not(lsAllyTag == "CSX") 
						and not(lsAllyTag == "CHC") 
						and not(lsAllyTag == "MAN") then 
						
							-- We are desperate so overide all else statements
							if ministerCountry:CalcDesperation():Get() > 0.4
							or lsTargetTag == "SOV" then
								-- Call in Allies that are neighbors to our enemy or on same cotinent
								if loTargetCountry:IsNeighbour(loAllyTag)
								or ministerContinent == loAllyCountry:GetActingCapitalLocation():GetContinent() then
									P.ExecuteCallAlly(ai, ministerTag, loAllyTag, loTargetTag)
								end
								
							-- When to Call Italy into the war
							elseif lsAllyTag == "ITA" or lsAllyTag == "ETH" then
								local fraTag = CCountryDataBase.GetTag("FRA")
								local belTag = CCountryDataBase.GetTag("BEL")
								local liMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()
								local belCountry = belTag:GetCountry()
								
								-- Do not call in Italy to early as they may take unecessary losses
								--   to their fleet against the French Navy!
								--   if Belgium is gone or Paris is no longer controled by France
								if not(CCurrentGameState.GetProvince(2613):GetController() == fraTag)
								or not(CCurrentGameState.GetProvince(2311):GetController() == belTag) 
								or belCountry:IsGovernmentInExile()
								or not(belCountry:Exists()) then
									P.ExecuteCallAlly(ai, ministerTag, loAllyTag, loTargetTag)
								
								-- Or the month is between July and September and Germany is atwar with Belgium
								elseif liMonth > 5
								and liMonth < 9
								and ministerCountry:GetRelation(belTag):HasWar() then
									P.ExecuteCallAlly(ai, ministerTag, loAllyTag, loTargetTag)
								end
							elseif lsAllyTag == "HUN"
							or lsAllyTag == "ROM" 
							or  lsAllyTag == "BUL" then
								if lsTargetTag == "SOV"
								or lsTargetTag == "USA" then
									P.ExecuteCallAlly(ai, ministerTag, loAllyTag, loTargetTag)
								end
							-- Standard catch all call anyone on our enemies border
							elseif not(lsTargetTag == "POL") then
								-- Call in Allies that are neighbors to our enemy
								if loTargetCountry:IsNeighbour(loAllyTag) then
									P.ExecuteCallAlly(ai, ministerTag, loAllyTag, loTargetTag)
								end
							end
						end
					end
				end
			end
		end
	end
end
function P.ExecuteCallAlly(ai, ministerTag, voAllyTag, voTargetTag)
	local loAction = CCallAllyAction( ministerTag, voAllyTag, voTargetTag)
	loAction:SetValue( true ) -- limited
	if loAction:IsSelectable() then
		ai:PostAction(loAction)
	end
end

function P.Call_MilitaryAccess(minister)
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()

	for loCountryTag in ministerCountry:GetNeighbours() do
		local loCountry = loCountryTag:GetCountry()
		
		-- Do not bother asking major powers for military access
		if not(loCountry:IsMajor()) then
			-- If they are already in a faction do not bother them
			-- If they are in a war already do not bother them
			if not(loCountry:HasFaction()) and not(loCountry:IsAtWar()) then
				local loRelation = ai:GetRelation(ministerTag, loCountryTag)

				-- Make sure we do not already have military access
				if not(loRelation:HasMilitaryAccess()) then
					local lbAsk = false
					
					-- Make an exception for Sweden
					if tostring(loCountryTag) == "SWE" then
						local norTag = CCountryDataBase.GetTag("NOR")
						local loNorwayCountry = norTag:GetCountry()

						-- Ask Sweden for Access if Norway is gone or allied
						if not(loNorwayCountry:Exists())
						or loNorwayCountry:IsGovernmentInExile() then
							lbAsk = true
						else
							if loNorwayCountry:HasFaction()
							and loNorwayCountry:GetFaction() == ministerCountry:GetFaction() then
								lbAsk = true
							end
						end
					else
						-- Now check their neighbors to see if they touch an enemy
						for loCountryTag2 in loCountry:GetNeighbours() do
							if not(loCountryTag2 == ministerTag) then
								local loRelation2 = ai:GetRelation(ministerTag, loCountryTag2)
							
								if loRelation2:HasWar() then
									lbAsk = true
									break
								end
							end
						end
					end
					
					if lbAsk then
						local loAction = CMilitaryAccessAction(ministerTag, loCountryTag)

						if loAction:IsSelectable() then
							local liScore = DiploScore_DemandMilitaryAccess(ai, ministerTag, loCountryTag, ministerTag)

							if liScore > 50 then
								minister:Propose(loAction, liScore)
							end
						end
					end					
				end
			end
		end
	end
end

function P.ProposeDeclareWar(minister)
	local ministerTag =  minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local loStrategy = ministerCountry:GetStrategy()
	
	if not(loStrategy:IsPreparingWar()) then
		if ministerCountry:GetFaction() == CCurrentGameState.GetFaction("axis") then	
			local sovTag = CCountryDataBase.GetTag("SOV")
			
			-- If we are atwar with Russia then do not even think of DOWing anyone else
			if not(ministerCountry:GetRelation(sovTag):HasWar()) then
				local ai = minister:GetOwnerAI()		
				local liYear = CCurrentGameState.GetCurrentDate():GetYear()
				local liMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()
				local lbAtwar = ministerCountry:IsAtWar()
				
				local liTotalNeighborWars = 0
				
				-- Since atwar figure out how many fronts we have
				if lbAtwar then
					local norTag = CCountryDataBase.GetTag("NOR")
					local engTag = CCountryDataBase.GetTag("ENG")
					local usaTag = CCountryDataBase.GetTag("USA")
					local sprTag = CCountryDataBase.GetTag("SPR")
					local spaTag = CCountryDataBase.GetTag("SPA")
					
					local luxTag = CCountryDataBase.GetTag("LUX")
					local belTag = CCountryDataBase.GetTag("BEL")
					local holTag = CCountryDataBase.GetTag("HOL")
					
					for neighborTag in ministerCountry:GetNeighbours() do
						if ministerCountry:GetRelation(neighborTag):HasWar() then
							
							-- Do not count Norway as we are invading them
							if not(norTag == neighborTag) then
								-- Only count a front with the UK or Low Countries if they are allied with the USA
								if neighborTag == engTag
								 or neighborTag == luxTag
								 or neighborTag == belTag 
								 or neighborTag == holTag then
									-- If they are allied with the USA then count them
									if neighborTag:GetCountry():GetRelation(usaTag):HasAlliance() then
										liTotalNeighborWars = liTotalNeighborWars + 1
									end
								elseif neighborTag == sprTag or neighborTag == spaTag then
									-- Gibraltar check, if UK no longer controls Gibralatar do not count Spain anymore
									if CCurrentGameState.GetProvince(5191):GetController() == engTag then 
										liTotalNeighborWars = liTotalNeighborWars + 1
									end
								else
									liTotalNeighborWars = liTotalNeighborWars + 1
								end
							end
						end
					end				
				end
				
				-- Only process these requests if prior to 1941 for performance reasons
				--   no reason for Germany to constantly monitor countries after this time
				if lbAtwar and liYear <= 1940 then
					-- If we have more than one front do not do anything
					if liTotalNeighborWars <= 1 then
						local fraTag = CCountryDataBase.GetTag("FRA")
						
						-- Plan the Low Countries, Denmark and Norway invasions
						if ministerCountry:GetRelation(fraTag):HasWar() and ministerCountry:IsNeighbour(fraTag) then
							P.DenmarkCheck(ai, ministerCountry, loStrategy)
							P.NorwayCheck(ai, ministerCountry, loStrategy)

							-- Wait for good weather months to attack
							if liMonth >= 3 and liMonth <= 7 then
								P.LowCountriesCheck(ai, ministerCountry, loStrategy)
							end
						else
							-- Only invade Yugoslavia and Greece if there is nothing else to do
							-- 30 percent chance it will DOW on Yugoslavia
							if liTotalNeighborWars == 0
							and (math.random(100) < 10) then
								-- Do not do the Greece check if Yugo is starting as it already called GreeceCheck
								if not(P.YugoslaviaCheck(ai, ministerCountry, loStrategy)) then
									P.GreeceCheck(ai, ministerCountry, loStrategy, false)
								end
							end
						end
					end
					
				-- Something happend and no war so start one in 1940
				elseif not(lbAtwar) and liYear == 1940 then
					-- Potential Wars with neighbors
					local laPotentialWars = {}
					
					for neighborTag in ministerCountry:GetNeighbours() do
						if not(Utils.IsFriend(ai, ministerCountry:GetFaction(), neighborTag:GetCountry()))
						and not(ministerCountry:GetRelation(neighborTag):HasAlliance()) then
							table.insert(laPotentialWars, neighborTag)
						end
					end

					-- Pick a random country that is not friend to go to war with
					if table.getn(laPotentialWars) > 0 then
						-- Limited War
						loStrategy:PrepareLimitedWar(laPotentialWars[math.random(table.getn(laPotentialWars))], 100)
					end
					
				-- We have no fronts
				elseif liTotalNeighborWars == 0 then
					-- Only look at this if we are at war or the year is 1941 or greater
					if lbAtwar or liYear >= 1941 then
						local lbYugoWar = false
						local lbGreeceWar = false
						
						-- Denmark with overide true
						P.DenmarkCheck(ai, ministerCountry, loStrategy)
						P.NorwayCheck(ai, ministerCountry, loStrategy)
						
						-- Look at the Baklans for a war
						if lbAtwar then
							lbYugoWar = P.YugoslaviaCheck(ai, ministerCountry, loStrategy)
							
							-- Do not do the Greece check if Yugo is starting as it already called GreeceCheck
							if lbYugoWar then
								lbGreeceWar = P.GreeceCheck(ai, ministerCountry, loStrategy, false)
							end
						end
					
						if not(lbYugoWar) and not(lbGreeceWar) then
							-- Potential Wars with neighbors
							local laPotentialWars = {}
							
							for loTargetTag in ministerCountry:GetNeighbours() do
								-- Make sure Vichy is not part of this list!
								local lsTargetTag = tostring(loTargetTag)
								
								if lsTargetTag == "SOV" then
									-- Make sure its on solid weather when we attack them (bit earlier because prepping takes time)
									if liMonth >= 4 and liMonth <= 7 
									and (not ministerCountry:GetFlags():IsFlagSet("su_signs_peace")) -- we havent already beaten them and gotten what we want
									then
										local vicTag = CCountryDataBase.GetTag("VIC")
										
										if CCurrentGameState.GetProvince(2613):GetController() == ministerTag -- Does Germany Control Paris
										or vicTag:GetCountry():Exists() -- Vichy Exists
										then
											table.insert(laPotentialWars, loTargetTag)
										end
									end										
								elseif not(lsTargetTag == "VIC")
								and not(lsTargetTag == "SCH") then
									if not(Utils.IsFriend(ai, ministerCountry:GetFaction(), loTargetTag:GetCountry()))
									and not(ministerCountry:GetRelation(loTargetTag):HasAlliance()) then
										table.insert(laPotentialWars, loTargetTag)
									end
								end
							end

							-- Pick a random country that is not friend to go to war with
							if table.getn(laPotentialWars) > 0 then
								-- Limited War
								loStrategy:PrepareLimitedWar(laPotentialWars[math.random(table.getn(laPotentialWars))], 100)
							end	
						end
					end
				end
			end
		end
	end
end

-- Overide bypasses the checks in France and Belgium 
function P.DenmarkCheck(ai, ministerCountry, voStrategy)
	local rValue = false
	local denTag = CCountryDataBase.GetTag("DEN")
	local loDenmarkCountry = denTag:GetCountry()

	if loDenmarkCountry:Exists()
	and not(ministerCountry:GetRelation(denTag):HasAlliance())
	and not(loDenmarkCountry:HasFaction())
	and ministerCountry:IsNeighbour(denTag)
	and not(ministerCountry:GetRelation(denTag):HasWar()) then
		-- Limited War
		voStrategy:PrepareLimitedWar(denTag, 100)
		rValue = true
	end
	
	return rValue
end

function P.NorwayCheck(ai, ministerCountry, voStrategy)
	local rValue = false
	
	-- Make sure we have the convoy points to even do this
	local liTotalTransports
	local laTempCurrent = ai:GetDeployedSubUnitCounts()
	
	for subUnit in CSubUnitDataBase.GetSubUnitList() do
		local nIndex = subUnit:GetIndex()
		local lsUnitType = subUnit:GetKey():GetString() 

		if lsUnitType == "transport_ship" then
			if laTempCurrent:GetAt(nIndex) < 5 then
				return rValue
			end
		end
	end
	-- End of Transport check
	
	local fraTag = CCountryDataBase.GetTag("FRA")
	local belTag = CCountryDataBase.GetTag("BEL")
	local vicTag = CCountryDataBase.GetTag("VIC")
	local vicCountry = vicTag:GetCountry()
	local belCountry = belTag:GetCountry()
	
	-- Do not try and invade Norway before the fight for France starts
	--   this way the allies are to busy to help Norway
	if not(CCurrentGameState.GetProvince(2613):GetController() == fraTag) -- Paris
	or not(CCurrentGameState.GetProvince(2312):GetController() == belTag) -- Liege
	or belCountry:IsGovernmentInExile()
	or not(belCountry:Exists())
	or vicCountry:Exists() then
		local denTag = CCountryDataBase.GetTag("DEN")
		local loDenmarkCountry = denTag:GetCountry()
		
		-- Check to see if Denmark is gone
		if not(loDenmarkCountry:Exists())
		or ministerCountry:GetRelation(denTag):HasAlliance()
		or loDenmarkCountry:IsGovernmentInExile()
		or loDenmarkCountry:IsPuppet()
		or not(CCurrentGameState.GetProvince(1482):GetController() == denTag) -- Copenhagen
		then
			-- Denmark does not exist so prepare for war with Norway
			local norTag = CCountryDataBase.GetTag("NOR")
			local loNorwayCountry = norTag:GetCountry()	
			
			if loNorwayCountry:Exists()
			and not(ministerCountry:GetRelation(norTag):HasAlliance())
			and not(loNorwayCountry:HasFaction())
			and not(ministerCountry:GetRelation(norTag):HasWar()) then
				if not(Utils.IsFriend(ai, ministerCountry:GetFaction(), loNorwayCountry)) then
					-- Limited War
					voStrategy:PrepareLimitedWar(norTag, 100)
					rValue = true
				end
			end
		end
	end
	
	return rValue
end

function P.LowCountriesCheck(ai, ministerCountry, voStrategy)
	local belTag = CCountryDataBase.GetTag('BEL')
	local holTag = CCountryDataBase.GetTag('HOL')
	local luxTag = CCountryDataBase.GetTag('LUX')
	local polTag = CCountryDataBase.GetTag('POL')

	local belCountry = belTag:GetCountry()
	local holCountry = holTag:GetCountry()
	local luxCountry = luxTag:GetCountry()
	local polCountry = polTag:GetCountry()
	
	local rValue = false
	
	-- Secondary checks to make sure they are gone!
	if (belCountry:Exists()
	or holCountry:Exists()
	or luxCountry:Exists()) 
	and ((not ministerCountry:GetRelation(polTag):HasWar()) or polCountry:IsGovernmentInExile()) -- done with POL
	then
		if not(ministerCountry:GetRelation(belTag):HasAlliance())
		and not(belCountry:HasFaction())
		and ministerCountry:IsNeighbour(belTag)
		and not(ministerCountry:GetRelation(belTag):HasWar())
		and not(belCountry:IsGovernmentInExile()) then
			-- Limited War
			voStrategy:PrepareLimitedWar(belTag, 100)
			rValue = true
		end
		
		if not(ministerCountry:GetRelation(holTag):HasAlliance())
		and not(holCountry:HasFaction())
		and ministerCountry:IsNeighbour(holTag)
		and not(ministerCountry:GetRelation(holTag):HasWar())
		and not(holCountry:IsGovernmentInExile()) then
			-- Limited War
			voStrategy:PrepareLimitedWar(holTag, 100)
			rValue = true
		end
		
		if not(ministerCountry:GetRelation(luxTag):HasAlliance())
		and not(luxCountry:HasFaction())
		and ministerCountry:IsNeighbour(luxTag)
		and not(ministerCountry:GetRelation(luxTag):HasWar())
		and not(luxCountry:IsGovernmentInExile()) then
			-- Limited War
			voStrategy:PrepareLimitedWar(luxTag, 100)
			rValue = true
		end
	end
	
	return rValue
end

function P.YugoslaviaCheck(ai, ministerCountry, voStrategy)
	local rValue = false
	local yugTag = CCountryDataBase.GetTag('YUG')
	local loYugoslaviaCountry = yugTag:GetCountry()
	local loRelation = ministerCountry:GetRelation(yugTag)
	
	if not(loRelation:HasWar())
	and loYugoslaviaCountry:Exists()
	and ministerCountry:IsNeighbour(yugTag)
	and not(loRelation:HasAlliance())
	and not(loYugoslaviaCountry:HasFaction()) then
		-- Limited War
		voStrategy:PrepareLimitedWar(yugTag, 100)
		
		-- Do A Greece check
		P.GreeceCheck(ai, ministerCountry, voStrategy, true)
		rValue = true
	end
	
	return rValue
end

function P.GreeceCheck(ai, ministerCountry, voStrategy, vbYugoDOW)
	local rValue = false
	local greTag = CCountryDataBase.GetTag('GRE')
	local loGreeceCountry = greTag:GetCountry()
	local loRelation = ministerCountry:GetRelation(greTag)

	-- Yugo Flag has been set so do not worry about being a neighbor
	if vbYugoDOW then
		if not(loGreeceCountry:IsGovernmentInExile())
		and loGreeceCountry:Exists()
		and not(loRelation:HasWar())
		and not(loRelation:HasAlliance())
		and not(loGreeceCountry:HasFaction()) then
			voStrategy:PrepareLimitedWar(greTag, 100)
			rValue = true
		end
		
	-- Check to see if we are neighbors
	else
		if not(loGreeceCountry:IsGovernmentInExile())
		and loGreeceCountry:Exists()
		and not(loRelation:HasWar())
		and ministerCountry:IsNeighbour(greTag)
		and not(loRelation:HasAlliance())
		and not(loGreeceCountry:HasFaction()) then
			-- Limited War
			voStrategy:PrepareLimitedWar(greTag, 100)
			rValue = true
		end
	end
	
	return rValue
end

--##########################
-- Politics Minister Hooks

-- HandleMobilization(minister)
-- HandlePuppets(minister)

-- Handle special Law cases, the @@@ is the law group name in string format
-- CallLaw_@@@@@(minister, loCurrentLaw)

-- Changing of Ministers
--    Each method is passed an array of ministers that can be put into the position
-- Call_ChiefOfAir(ministerCountry, vaMinisters)
-- Call_ChiefOfNavy(ministerCountry, vaMinisters)
-- Call_ChiefOfArmy(ministerCountry, vaMinisters)
-- Call_MinisterOfIntelligence(ministerCountry, vaMinisters)
-- Call_ChiefOfStaff(ministerCountry, vaMinisters)
-- Call_ForeignMinister(ministerCountry, vaMinisters)
-- Call_ArmamentMinister(ministerCountry, vaMinisters)
-- Call_MinisterOfSecurity(ministerCountry, vaMinisters)

-- Create very highly trained troops
function P.CallLaw_training_laws(minister, voCurrentLaw)
	local _SPECIALIST_TRAINING_ = 30
	return CLawDataBase.GetLaw(_SPECIALIST_TRAINING_)
end

return AI_GER
