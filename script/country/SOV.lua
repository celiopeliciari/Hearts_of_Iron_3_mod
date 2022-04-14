-----------------------------------------------------------
-- LUA Hearts of Iron 3 Soviet File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/27/2011
-----------------------------------------------------------

local P = {}
AI_SOV = P

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
	local laTechWeights
	local ministerCountry = minister:GetCountry()
	local liCYear = CCurrentGameState.GetCurrentDate():GetYear()
	local lbAtWarGER = ministerCountry:GetRelation(CCountryDataBase.GetTag("GER")):HasWar()
	local lbAtWar = ministerCountry:IsAtWar()
	
	-- If we are at war with Germany or the year is less than 1941 and not wat war
	if lbAtWarGER or (liCYear < 1942 and not(lbAtWar)) then
		local ministerTag = minister:GetCountryTag()
		local lbControlMoscow = (CCurrentGameState.GetProvince(1409):GetController() == ministerTag)

		-- We still control Moscow and the year is greater than 1943 spread out research
		if lbControlMoscow and liCYear > 1942 then
			laTechWeights = {
				0.24, -- landBasedWeight
				0.18, -- landDoctrinesWeight
				0.11, -- airBasedWeight
				0.18, -- airDoctrinesWeight
				0.06, -- navalBasedWeight
				0.05, -- navalDoctrinesWeight
				0.10, -- industrialWeight
				0.04, -- secretWeaponsWeight
				0.04}; -- otherWeight		
		else
			laTechWeights = {
				0.35, -- landBasedWeight
				0.20, -- landDoctrinesWeight
				0.11, -- airBasedWeight
				0.15, -- airDoctrinesWeight
				0.00, -- navalBasedWeight
				0.00, -- navalDoctrinesWeight
				0.15, -- industrialWeight
				0.00, -- secretWeaponsWeight
				0.04}; -- otherWeight
		end
	else
		laTechWeights = {
			0.24, -- landBasedWeight
			0.18, -- landDoctrinesWeight
			0.11, -- airBasedWeight
			0.18, -- airDoctrinesWeight
			0.06, -- navalBasedWeight
			0.05, -- navalDoctrinesWeight
			0.10, -- industrialWeight
			0.04, -- secretWeaponsWeight
			0.04}; -- otherWeight			
	end

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
			{"armored_car_gun", 0}};
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
		"mass_assault",
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
		"spotting"};		
		
	return ignoreTech, preferTech
end

function P.IndustrialTechs(minister)
	local ignoreTech = {{"steel_production", 0},
		{"raremetal_refinning_techniques", 0},
		{"coal_processing_technologies", 0}};

	local preferTech = {"agriculture",
		"industral_production",
		"industral_efficiency",
		"supply_production",
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
	local gerTag = CCountryDataBase.GetTag("GER")
	local loGerCountry = gerTag:GetCountry()
	local lbAtWarGER = voProductionData.ministerCountry:GetRelation(gerTag):HasWar()
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Check to see if manpower is to low
	-- More than 400 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 300 and voProductionData.LandCountTotal > 400)
	or voProductionData.ManpowerTotal < 50 then
		laArray = {
			0.0, -- Land
			0.60, -- Air
			0.10, -- Sea
			0.30}; -- Other
	elseif lbAtWarGER then
		local lbControlMoscow = (CCurrentGameState.GetProvince(1409):GetController() == voProductionData.ministerTag)
	
		-- We control Moscow still and its 1943 so we can spread our builds out
		if lbControlMoscow and liYear > 1942 then
			laArray = {
				0.65, -- Land
				0.25, -- Air
				0.05, -- Sea
				0.05}; -- Other
		else
			laArray = {
				0.75, -- Land
				0.25, -- Air
				0.0, -- Sea
				0.0}; -- Other
		end
	-- We are atwar with someone other than Germany
	elseif voProductionData.IsAtWar then
		laArray = {
			0.50, -- Land
			0.25, -- Air
			0.15, -- Sea
			0.10}; -- Other

	-- Produce lots of industry in the early years
	--   as long as Germany is not at war with anyone
	elseif liYear <= 1939 and not(loGerCountry:IsAtWar()) then
		laArray = {
			0.35, -- Land
			0.35, -- Air
			0.0, -- Sea
			0.30}; -- Other
	
	elseif liYear <= 1940 then
		laArray = {
			0.40, -- Land
			0.50, -- Air
			0.07, -- Sea
			0.03}; -- Other
	else
		laArray = {
			0.65, -- Land
			0.25, -- Air
			0.07, -- Sea
			0.03}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	if liYear < 1942 then
		laArray = {
			0, -- Garrison
			15, -- Infantry
			0, -- Motorized
			0, -- Mechanized
			1, -- Armor
			0, -- Militia
			0}; -- Cavalry
	else
		laArray = {
			0, -- Garrison
			20, -- Infantry
			3, -- Motorized
			1, -- Mechanized
			2, -- Armor
			0, -- Militia
			0}; -- Cavalry
	end
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(voProductionData)
	local laArray
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()

	-- No special forces till 1942 or later
	if liYear > 1941 then
		laArray = {
			40, -- Land
			1}; -- Special Forces Unit
	else
		laArray = {
			0, -- Land
			0}; -- Special Forces Unit
	end
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		8, -- Fighter
		4, -- CAS
		3, -- Tactical
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
	local laArray
	local liCYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Do not build any transports in the first half of the war
	if liCYear > 1942 then
		laArray = {
			120, -- Land
			1}; -- Transport
	else
		local lbAtWarGER = voProductionData.ministerCountry:GetRelation(CCountryDataBase.GetTag("GER")):HasWar()
	
		-- If atwar with Germany no need to even think about transports!
		if lbAtWarGER then
			laArray = {
				0, -- Land
				0}; -- Transport	
		
		-- We are atwar with someone other than Germany so transports may be needed
		elseif voProductionData.IsAtWar then
			laArray = {
				120, -- Land
				1}; -- Transport
		
		-- Do not build any at all
		else
			laArray = {
				0, -- Land
				0}; -- Transport		
		end
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

-- Do not build marines
function P.Build_Marine(ic, voProductionData, marine_brigade, vbGoOver)
	return ic, 0
end

-- Build Strong Garrison units with no police
function P.Build_Garrison(ic, voProductionData, garrison_brigade, vbGoOver)
	if garrison_brigade >= 3 and ic > 2 then
		ic, garrison_brigade = Utils.CreateDivision(voProductionData, "garrison_brigade", 4, ic, garrison_brigade, 3, Utils.BuildLegUnitArray(voProductionData), 1, vbGoOver)
	end

	return ic, garrison_brigade
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

function P.Build_Industry(ic, voProductionData, vbGoOver)
	local lbProcessGeneric = false
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()
	
	-- Mass Build Industry in the Urals
	if liYear <= 1938 then
		ic = Support.Build_Industry(ic, voProductionData, 8595, 10, vbGoOver) -- Kemerovo
		ic = Support.Build_Industry(ic, voProductionData, 1330, 10, vbGoOver) -- Kaznan
		ic = Support.Build_Industry(ic, voProductionData, 8191, 10, vbGoOver) -- Perm
		ic = Support.Build_Industry(ic, voProductionData, 6632, 10, vbGoOver) -- Syktyukar
		ic = Support.Build_Industry(ic, voProductionData, 8151, 10, vbGoOver) -- Nizhnaya Tura
		ic = Support.Build_Industry(ic, voProductionData, 6727, 10, vbGoOver) -- Krasnojarskij
		ic = Support.Build_Industry(ic, voProductionData, 8393, 10, vbGoOver) -- Kurgan
		ic = Support.Build_Industry(ic, voProductionData, 968, 10, vbGoOver) -- Kologriv
		ic = Support.Build_Industry(ic, voProductionData, 8529, 10, vbGoOver) -- Blinkovo
		ic = Support.Build_Industry(ic, voProductionData, 8762, 10, vbGoOver) -- Akshtau
		ic = Support.Build_Industry(ic, voProductionData, 8928, 10, vbGoOver) -- Matay
		ic = Support.Build_Industry(ic, voProductionData, 6746, 10, vbGoOver) -- Orenburg
		ic = Support.Build_Industry(ic, voProductionData, 6768, 10, vbGoOver) -- Orsk
		ic = Support.Build_Industry(ic, voProductionData, 6788, 10, vbGoOver) -- Aktobe
		
	-- Use the Generic Industry building code once this time period is over
	else
		lbProcessGeneric = true
	end
	
	return ic, lbProcessGeneric
end

-- Have Russia Fortify some key positions
function P.Build_Fort(ic, voProductionData, vbGoOver)
	ic = Support.Build_Fort(ic, voProductionData, 1409, 3, vbGoOver) -- Moscow
	ic = Support.Build_Fort(ic, voProductionData, 782, 3, vbGoOver) -- Leningrad
	ic = Support.Build_Fort(ic, voProductionData, 823, 1, vbGoOver) -- Boksitogorsk
	ic = Support.Build_Fort(ic, voProductionData, 824, 1, vbGoOver) -- Sazonovo
	ic = Support.Build_Fort(ic, voProductionData, 952, 1, vbGoOver) -- Mar'inskoye
	ic = Support.Build_Fort(ic, voProductionData, 993, 1, vbGoOver) -- Cheshevo
	ic = Support.Build_Fort(ic, voProductionData, 1031, 1, vbGoOver) -- Msta
	
	return ic, false
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

function P.HandleMobilization(minister)
	local ministerCountry = minister:GetCountry()
	local gerTag = CCountryDataBase.GetTag("GER")
	local loGerCountry = gerTag:GetCountry()
	
	-- Make sure Germany is at war and has a border with us
	if loGerCountry:IsAtWar() and ministerCountry:IsNeighbour(gerTag) and not(ministerCountry:IsAtWar()) then
		local ministerTag = minister:GetCountryTag()
		local ai = minister:GetOwnerAI()
		local fraTag = CCountryDataBase.GetTag("FRA")
		local year = ai:GetCurrentDate():GetYear()
		
		-- Check to see if France no longer controls Paris
		if not(CCurrentGameState.GetProvince(2613):GetController() == fraTag) then
			local liGermanFrontWarsCount = 0
			local norTag = CCountryDataBase.GetTag("NOR")
			
			for neighborTag in loGerCountry:GetNeighbours() do
				if loGerCountry:GetRelation(neighborTag):HasWar() then
					
					-- Do not count Norway as we are invading them
					if not(norTag == neighborTag) then
						liGermanFrontWarsCount = liGermanFrontWarsCount + 1
					end
				end
			end			
			
			-- 10% random Chance if Germany is in a war and no fronts if the year is 1941 or better then mobilize
			if math.random(100) < 11 and liGermanFrontWarsCount == 0 then
				ai:Post(CToggleMobilizationCommand( ministerTag, true ))
			elseif math.random(100) < 26 and year >= 1941 then
				ai:Post(CToggleMobilizationCommand( ministerTag, true ))
			end
		
		-- Germany is atwar and has a front with us so go ahead and mobilize
		elseif year >= 1942 then
			ai:Post(CToggleMobilizationCommand( ministerTag, true ))
		end
	end
end

function P.ProposeDeclareWar( minister )
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local gerTag = CCountryDataBase.GetTag('GER')
	local logerCountry = gerTag:GetCountry()
		
	-- Do the Russians control Moscow?
	if CCurrentGameState.GetProvince(1409):GetController() == ministerTag then
		if logerCountry:IsAtWar() and not(ministerCountry:IsAtWar()) then
			local ai = minister:GetOwnerAI()
			local fraTag = CCountryDataBase.GetTag('FRA')
			local polTag = CCountryDataBase.GetTag('POL')
			local year = ai:GetCurrentDate():GetYear()
			local loRelation = ai:GetRelation(ministerTag, gerTag)
			
			-- If Germany is neighbors with France and Russia at the same time
			if logerCountry:IsNeighbour(fraTag)
			and ministerCountry:IsNeighbour(gerTag)
			and logerCountry:GetRelation(fraTag):HasWar()
			and not(loRelation:HasNap()) then
				ministerCountry:GetStrategy():PrepareLimitedWar(gerTag, 100)
			
			elseif year < 1943 -- germany grabbed london early, backstab imo
			and (CCurrentGameState.GetProvince(1964):GetController() == gerTag)
			then
				ministerCountry:GetStrategy():PrepareLimitedWar(gerTag, 100)
			
			-- 20% Chance of war
			elseif year >= 1942 
			and ministerCountry:IsNeighbour(gerTag)
			and not(loRelation:HasNap())
			and math.random(100) < 21 then
				ministerCountry:GetStrategy():PrepareLimitedWar(gerTag, 100)
				
			elseif year >= 1942 
			and ministerCountry:IsNeighbour(polTag)
			and math.random(100) < 21 then
				ministerCountry:GetStrategy():PrepareLimitedWar(polTag, 100)
				
			end
		end
	end
end

function P.ForeignMinister_EvaluateDecision(score, agent, decision, scope)
	local lsDecision = decision:GetKey():GetString()
	
	if lsDecision == "finnish_winter_war" then
		-- lets not prepare too much, we can take the fins easily
		score = 100
	elseif lsDecision == "ultimatum_to_the_baltic_states" then
		local liYear = CCurrentGameState.GetCurrentDate():GetYear()
		local fraTag = CCountryDataBase.GetTag("FRA")
		local belTag = CCountryDataBase.GetTag("BEL")
		
		if liYear >= 1941
		or not(CCurrentGameState.GetProvince(2613):GetController() == fraTag) -- Paris
		or not(CCurrentGameState.GetProvince(2311):GetController() == belTag) then -- Brussels
			score = 100
		else
			score = 0
		end
	end
	
	return score
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "GER"
	or lsActorTag == "SIK" 
	or lsActorTag == "CHC" then
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
		"JAP",
		"ITA"};
	
	return laIgnoreList
end

-- Soviets want more troops, let them learn on the battlefield.
--   helps them produce troops faster
function P.CallLaw_training_laws(minister, voCurrentLaw)
	local ministerCountry = minister:GetCountry()
	local lbAtWarGER = ministerCountry:GetRelation(CCountryDataBase.GetTag("GER")):HasWar()
	
	-- If atwar with Germany check for special conditions on training
	if lbAtWarGER then
		local liCYear = CCurrentGameState.GetCurrentDate():GetYear()
		local lbControlMoscow = (CCurrentGameState.GetProvince(1409):GetController() == ministerTag)
		
		-- If its 1943 and we still control Moscow make better trained troops
		if liCYear > 1942 and lbControlMoscow then
			return CLawDataBase.GetLaw(28) -- _BASIC_TRAINING_
		else
			return CLawDataBase.GetLaw(27) -- _MINIMAL_TRAINING_
		end
	else
		return CLawDataBase.GetLaw(28) -- _BASIC_TRAINING_
	end
end

return AI_SOV
