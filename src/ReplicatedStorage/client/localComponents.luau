local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ComponentTypes = require(ReplicatedStorage.Shared.Utils.Types.ComponentTypes)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)

export type HitFrameType = {
	attackerId: string,
}

local components = {
	HitFrame = Matter.component("HitFrame") :: ComponentTypes.ComponentType<HitFrameType>,
}

return components
