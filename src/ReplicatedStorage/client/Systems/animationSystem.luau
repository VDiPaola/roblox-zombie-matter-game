local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ComponentTypes = require(ReplicatedStorage.Shared.Utils.Types.ComponentTypes)
local Components = require(ReplicatedStorage.Shared.components)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)
local StateEnums = require(ReplicatedStorage.Shared.Utils.Enums.StateEnums)
local localComponents = require(ReplicatedStorage.Client.localComponents)

local function Animation(world)
	debug.setmemorycategory("AnimationSystem")
	debug.profilebegin("AnimationSystem")
	for id, stateRecord in world:queryChanged(Components.State) do
		--make sure theres a model
		local modelC: ComponentTypes.ModelType? = world:get(id, Components.Model)
		local animationPlayerC: ComponentTypes.AnimationPlayerType? = world:get(id, Components.AnimationPlayer)
		if modelC and modelC.model and animationPlayerC then
			--check if theres an animation for the state
			local newState: ComponentTypes.StateType = stateRecord.new
			local animator = modelC.model:FindFirstChildWhichIsA("Animator", true)
			local animationId = newState.current and animationPlayerC.animationTable[newState.current]
			if animator and newState.current and animationId then
				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://" .. animationId
				local animTrack = animator:LoadAnimation(animation)
				print("playing animation")
				animTrack:GetMarkerReachedSignal("hitframe"):Connect(function(paramString)
					print("hitframe ", paramString)
					world:insert(id, localComponents.HitFrame({ attackerId = id }))
				end)
				animTrack.KeyframeReached:Connect(function()
					print("change state request")
					world:insert(id, Components.StateChangeRequest({ target = StateEnums.State.Idle }))
				end)
				animTrack:Play()
			else
				warn("animator and newState.current and animationPlayerC.animationTable[newState.current] failed")
			end
		else
			warn("modelC and modelC.model and animationPlayerC failed")
		end
	end

	debug.profileend()
end

return Animation
