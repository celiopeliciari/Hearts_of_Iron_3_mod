-----------------------------------------------------------
-- LUA Hearts of Iron 3 Switzerland File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 7/25/2011
-----------------------------------------------------------

local P = {}
AI_SCH = P

function P.HandleMobilization(minister)
	-- Do not do anything as we never want to mobilize
end

function P.DiploScore_InviteToFaction(liScore, voAI, voActorTag, voRecipientTag, voObserverTag)
	-- Stay out of the war, we do not care whats happening around us
	if not(voRecipientTag:GetCountry():IsAtWar()) then
		score = 0
	end
	
	return score
end

function P.DiploScore_Alliance(liScore, voAI, voActorTag, voRecipientTag, voObserverTag)
	-- Stay out of the war, we do not care whats happening around us
	if not(voRecipientTag:GetCountry():IsAtWar()) then
		liScore = 0
	end
	
	return liScore	
end

function P.DiploScore_GiveMilitaryAccess(liScore, voAI, voCountry)
	-- We stay out of everything
	return 0
end

-- Create very highly trained troops
function P.CallLaw_training_laws(minister, voCurrentLaw)
	local _SPECIALIST_TRAINING_ = 30
	return CLawDataBase.GetLaw(_SPECIALIST_TRAINING_)
end

function P.DiploScore_ConsiderAccess(score, ai, actor, recipient, observer)
	return 0
end

return AI_SCH
