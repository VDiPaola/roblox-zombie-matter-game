local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ComponentTypes = require(ReplicatedStorage.Shared.Utils.Types.ComponentTypes)
local Components = require(ReplicatedStorage.Shared.components)
local StateUtil = require(ReplicatedStorage.Shared.Utils.StateUtil)

local function state(world)
	for id, stateChangeRequestRecord in world:queryChanged(Components.StateChangeRequest) do
		local stateC: ComponentTypes.ComponentType<ComponentTypes.StateType>? = world:get(id, Components.State)
		--make sure components exist
		if world:contains(id) and stateC then
			--check state change request
			local oldTarget = stateChangeRequestRecord.old and stateChangeRequestRecord.old.target
			local hasStateChangeRequest = stateChangeRequestRecord.new.target ~= oldTarget
			local isDifferentState = stateChangeRequestRecord.new.target ~= stateC.current
			if hasStateChangeRequest and isDifferentState then
				--transition state if exist
				local canTransition = StateUtil.isValidTransition(
					stateC.transitionTable,
					stateC.current,
					stateChangeRequestRecord.new.target
				)
				if canTransition then
					print("changing to state: " .. stateChangeRequestRecord.new.target)
					world:insert(
						id,
						stateC:patch({
							current = stateChangeRequestRecord.new.target,
							time = os.time(),
						})
					)
					continue
				else
					warn("canTransition failed")
				end
			else
				warn("hasStateChangeRequest and isDifferentState failed")
			end
		else
			warn("world:contains(id) and stateC failed")
		end
	end
end

return state
