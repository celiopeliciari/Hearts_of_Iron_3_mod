-----------------------------------------------------------
-- LUA Hearts of Iron 3 Bulgaria File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/26/2011
-----------------------------------------------------------

local P = {}
AI_BUL = P

function P.Call_ForeignMinister_Tick(minister)
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = ministerTag:GetCountry()

	if not(ministerCountry:HasFaction()) then
		-- If Bulgaria controls the border provinces with Romania assume it was due to German influence and align with them
		if CCurrentGameState.GetProvince(4058):GetOwner() == ministerTag then
			local loAction = CInfluenceAllianceLeader(ministerTag, CCurrentGameState.GetFaction("axis"):GetFactionLeader())
			
			if loAction:IsSelectable() then
				minister:GetOwnerAI():PostAction(loAction)
			end
		end
	end
end
return AI_BUL
