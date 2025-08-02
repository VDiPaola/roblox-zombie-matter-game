-- ServerScriptService/MatterService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local receiveReplication = require(ReplicatedStorage.Client.receiveReplication)
local start = require(ReplicatedStorage.Shared.start)

local MatterController = {
	Name = "MatterController",
	Client = {},
}

function MatterController:KnitInit()
	-- Set up any initialization logic
end

function MatterController:KnitStart()
	-- Initialize Matter
	MatterController.world, MatterController.state, MatterController.loop = start({
		ReplicatedStorage.Shared.Systems,
		ReplicatedStorage.Client.Systems,
	})

	receiveReplication(MatterController.world, MatterController.state)

	-- Make world available to other services
	MatterController.state.matterWorld = MatterController.world
end

-- Expose Matter functionality to other services
function MatterController:GetWorld()
	return MatterController.world
end

function MatterController:GetState()
	return MatterController.state
end

function MatterController:SpawnEntity(...)
	return MatterController.world:spawn(...)
end

function MatterController:QueryEntities(...)
	return MatterController.world:query(...)
end

function MatterController:DespawnEntity(id)
	return MatterController.world:despawn(id)
end

return MatterController
