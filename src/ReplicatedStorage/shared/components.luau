local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ComponentTypes = require(ReplicatedStorage.Shared.Utils.Types.ComponentTypes)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)

local components = {
	Roomba = Matter.component("Roomba"),
	Model = Matter.component("Model") :: ComponentTypes.ComponentType<ComponentTypes.ModelType>,
	Charge = Matter.component("Charge"),
	Health = Matter.component("Health"),
	Target = Matter.component("Target"),
	Transform = Matter.component("Transform"),
	Mothership = Matter.component("Mothership"),
	Lasering = Matter.component("Lasering"),
	DebugLabel = Matter.component("DebugLabel"),
	Spinner = Matter.component("Spinner"),
	Zombie = Matter.component("Zombie"),
	State = Matter.component("State") :: ComponentTypes.ComponentType<ComponentTypes.StateType>,
	Player = Matter.component("Player"),
	StateChangeRequest = Matter.component("StateChangeRequest") :: ComponentTypes.ComponentType<ComponentTypes.StateChangeRequestType>,
	AnimationPlayer = Matter.component("AnimationPlayer") :: ComponentTypes.ComponentType<ComponentTypes.AnimationPlayerType>,
}

return components
