local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputTypes = require(ReplicatedStorage.Shared.Utils.Types.InputTypes)
local StateEnums = require(ReplicatedStorage.Shared.Utils.Enums.StateEnums)
local components = require(ReplicatedStorage.Shared.components)
local InputService = {
	Name = "InputService",
	Client = {},
}

function InputService:KnitInit()
	InputService._matterService = require(script.Parent.MatterService)
end

function InputService:KnitStart() end

local function stateChange(player, targetState: string)
	local world = InputService._matterService:GetWorld()
	for id, modelC in world:query(components.Model, components.Player, components.State) do
		if modelC and modelC.model and modelC.model == player.Character then
			print("Attempting change to state: " .. targetState)
			world:insert(id, components.StateChangeRequest({ target = targetState }))
			return
		end
	end
end

function InputService.Client:Input(player: Player, key: InputTypes.InputActionType)
	if key == "LeftClick" then
		stateChange(player, StateEnums.State.Attacking)
	elseif key == "Jump" then
		stateChange(player, StateEnums.State.Jumping)
	end
end

return InputService
