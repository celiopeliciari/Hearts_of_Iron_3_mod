-----------------------------------------------------------
-- LUA Hearts of Iron 3 Communist China File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/27/2011
-----------------------------------------------------------

local P = {}
AI_CHC = P

-- Tech weights
--   1.0 = 100% the total needs to equal 1.0
function P.TechWeights(minister)
	local laTechWeights = {
		0.60, -- landBasedWeight
		0.25, -- landDoctrinesWeight
		0.0, -- airBasedWeight
		0.0, -- airDoctrinesWeight
		0.0, -- navalBasedWeight
		0.0, -- navalDoctrinesWeight
		0.15, -- industrialWeight
		0.0, -- secretWeaponsWeight
		0.0}; -- otherWeight
	
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
		{"armored_car_armour", 0},
		{"armored_car_gun", 0},
		{"paratrooper_infantry", 0},
		{"marine_infantry", 0},
		{"imporved_police_brigade", 0},
		{"desert_warfare_equipment", 0},
		{"jungle_warfare_equipment", 0},
		{"artic_warfare_equipment", 0},
		{"amphibious_warfare_equipment", 0},
		{"airborne_warfare_equipment", 0},
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
		{"SP_brigade", 0},
		{"mechanised_infantry", 0},
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
		
	local preferTech = {"infantry_activation",
		"smallarms_technology",
		"infantry_support",
		"infantry_guns",
		"infantry_at",
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
		{"mechanized_offensive", 0},
		{"combined_arms_warfare", 0},
		{"special_forces", 0}};
		
	local preferTech = {"infantry_warfare",
		"mass_assault",
		"peoples_army"};
		
	return ignoreTech, preferTech
end

function P.AirTechs(minister)
	local ignoreTech = {"all"};
	
	return ignoreTech, nil
end

function P.AirDoctrineTechs(minister)
	local ignoreTech = {"all"};

	return ignoreTech, nil
end
		
function P.NavalTechs(minister)
	local ignoreTech = {"all"}

	return ignoreTech, nil
end
		
function P.NavalDoctrineTechs(minister)
	local ignoreTech = {"all"};

	return ignoreTech, nil
end

function P.IndustrialTechs(minister)
	local ignoreTech = {{"oil_to_coal_conversion", 0},
		{"heavy_aa_guns", 0},
		{"radio_detection_equipment", 0},
		{"radar", 0},
		{"decryption_machine", 0},
		{"encryption_machine", 0},
		{"rocket_tests", 0},
		{"rocket_engine", 0},
		{"theorical_jet_engine", 0},
		{"atomic_research", 0},
		{"nuclear_research", 0},
		{"isotope_seperation", 0},
		{"civil_nuclear_research", 0},
		{"oil_refinning", 0},
		{"steel_production", 0},
		{"raremetal_refinning_techniques", 0},
		{"coal_processing_technologies", 0}};

	local preferTech = {"agriculture",
		"industral_production",
		"industral_efficiency",
		"supply_production",
		"education"};
		
	return ignoreTech, preferTech
end
		
function P.SecretWeaponTechs(minister)
	local ignoreTech = {"all"}
	
	return ignoreTech, nil
end

function P.OtherTechs(minister)
	local ignoreTech = {"all"}

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
	local liCYear = CCurrentGameState.GetCurrentDate():GetYear()

	-- Check to see if manpower is to low
	-- More than 30 brigades so build stuff that does not use manpower
	if (voProductionData.ManpowerTotal < 30 and voProductionData.LandCountTotal > 30)
	or voProductionData.ManpowerTotal < 10 then
		laArray = {
			0.0, -- Land
			0.50, -- Air
			0.0, -- Sea
			0.50}; -- Other	
	elseif (voProductionData.PortsTotal > 0 and liCYear > 1943) then
		laArray = {
			0.40, -- Land
			0.25, -- Air
			0.25, -- Sea
			0.10}; -- Other
	else
		laArray = {
			0.90, -- Land
			0.0, -- Air
			0.0, -- Sea
			0.10}; -- Other
	end
	
	return laArray
end
-- Land ratio distribution
function P.LandRatio(voProductionData)
	local laArray = {
		0, -- Garrison
		4, -- Infantry
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
		0, -- Land
		0}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(voProductionData)
	local laArray = {
		3, -- Fighter
		1, -- CAS
		2, -- Tactical
		0, -- Naval Bomber
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
		0, -- Land
		0}; -- Transport
	
	return laArray
end

-- Build Infantry units (China builds large divisions)
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
		ic, militia_brigade = Utils.CreateDivision(voProductionData, "militia_brigade", 4, ic, militia_brigade, 4, nil, 0, vbGoOver)
	end

	return ic, militia_brigade
end

-- Build Strong Garrison units with no police
function P.Build_Garrison(ic, voProductionData, garrison_brigade, vbGoOver)
	if garrison_brigade >= 3 and ic > 2 then
		ic, garrison_brigade = Utils.CreateDivision(voProductionData, "garrison_brigade", 4, ic, garrison_brigade, 4, nil, 0, vbGoOver)
	end

	return ic, garrison_brigade
end

-- Do not build coastal forts
function P.Build_CoastalFort(ic, voProductionData, vbGoOver)
	return ic, false
end

-- Have Com. China Fortify their country
function P.Build_Fort(ic, voProductionData, vbGoOver)
	local liYear = CCurrentGameState.GetCurrentDate():GetYear()

	-- Only build the forts if its 1938 or less
	if liYear <= 1938 then
		ic = Support.Build_Fort(ic, voProductionData, 7417, 2, vbGoOver) -- Yan'an
		ic = Support.Build_Fort(ic, voProductionData, 7410, 2, vbGoOver) -- Zichang
	end
	
	return ic, false
end

-- END OF PRODUTION OVERIDES
-- #######################################


function P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)
	if not (tostring(actor:GetCountry():GetFaction():GetTag()) == 'comintern' and 
		tostring(recipient:GetCountry():GetFaction():GetTag()) == 'comintern') then
		score = 0
	end
	
	return score
end

function P.DiploScore_Alliance(score, ai, actor, recipient, observer)
	local ministerCountry = recipient:GetCountry()
	
	-- Make sure we are not in a faction already and China is the one asking
	if not(ministerCountry:HasFaction()) and tostring(actor) == "CHI" then
		local loChinaCountry = actor:GetCountry()
	
		-- If China and Japan are atwar then come to their help
		if loChinaCountry:GetRelation(CCountryDataBase.GetTag("JAP")):HasWar() then
			score = score + 50
		end
	end
	
	return score
end

function P.DiploScore_GiveMilitaryAccess(liScore, voAI, voCountry)
	local lsCountry = tostring(voCountry)

	-- Do not let Japan in our territory
	if lsCountry == "JAP" then
		liScore = 0
	end
	
	return liScore
end

return AI_CHC
