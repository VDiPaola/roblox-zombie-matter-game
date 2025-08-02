local StateUtil = {}

function StateUtil.isValidTransition(transitionTable, fromState, toState): boolean
	local stateExists = transitionTable[fromState]
	if stateExists then
		local hasToState = stateExists[toState]
		if hasToState then
			return true
		end
	end

	return false
end

return StateUtil
