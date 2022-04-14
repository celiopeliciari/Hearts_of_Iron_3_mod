-----------------------------------------------------------
-- LUA Hearts of Iron 3 Netherlands File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/31/2011
-----------------------------------------------------------

local P = {}
AI_HOL = P

-- Production Weights
--   1.0 = 100% the total needs to equal 1.0
function P.ProductionWeights(voProductionData)
	local laArray = {
		0.07, -- Land
		0.33, -- Air
		0.40, -- Sea
		0.20}; -- Other
	
	return laArray
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	if tostring(actor) == "JAP" then
		score = score + 30
	end
	
	return score
end

function P.DiploScore_InviteToFaction(score, ai, actor, recipient, observer)
	-- Whatever their chance is lower it by 10 makes it harder to get them in
	return (score - 10)
end

return AI_HOL

