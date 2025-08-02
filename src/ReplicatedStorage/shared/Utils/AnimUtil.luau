local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")

local AnimUtil = {}

function AnimUtil.createPreviewAnimation(keyframeSequence: KeyframeSequence): Animation
	local sequence = keyframeSequence:Clone()
	sequence.Parent = workspace
	local hashId = KeyframeSequenceProvider:RegisterKeyframeSequence(sequence)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = hashId
	return Animation
end

return AnimUtil
