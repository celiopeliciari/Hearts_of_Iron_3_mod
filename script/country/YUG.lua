-----------------------------------------------------------
-- LUA Hearts of Iron 3 Yugoslavia File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/25/2011
-----------------------------------------------------------

local P = {}
AI_YUG = P


function P.Call_ForeignMinister_Tick(minister)
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = ministerTag:GetCountry()

	-- If Yugoslavia is at peace and Italy is involved in the war
	--    start shifting to the Allies
	if not(ministerCountry:HasFaction()) then
		local itaTag = CCountryDataBase.GetTag("ITA")
		local engTag = CCountryDataBase.GetTag("ENG")
		local loItaCountry = itaTag:GetCountry()
	
		if loItaCountry:GetRelation(engTag):HasWar() then
			local loAction = CInfluenceAllianceLeader(ministerTag, CCurrentGameState.GetFaction("allies"):GetFactionLeader())
			
			if loAction:IsSelectable() then
				minister:GetOwnerAI():PostAction(loAction)
			end
		end
	end
end

function P.DiploScore_GiveMilitaryAccess(liScore, voAI, voCountry)
	local lsCountry = tostring(voCountry)

	-- Do not let Italy in our territory
	if lsCountry == "ITA" then
		liScore = liScore - 50
	end
	
	return liScore
end

return AI_YUG
