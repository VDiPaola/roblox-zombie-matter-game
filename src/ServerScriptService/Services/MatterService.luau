-- ServerScriptService/MatterService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local setupTags = require(ReplicatedStorage.Shared.setupTags)
local start = require(ReplicatedStorage.Shared.start)

local MatterService = {
	Name = "MatterService",
	Client = {},
}

function MatterService:KnitInit()
	-- Set up any initialization logic
end

function MatterService:KnitStart()
	-- Initialize Matter
	MatterService.world, MatterService.state, MatterService.loop = start({
		ServerScriptService.Server.Systems,
		ReplicatedStorage.Shared.Systems,
	})

	setupTags(MatterService.world)

	-- Make world available to other services
	MatterService.state.matterWorld = MatterService.world
end

-- Expose Matter functionality to other services
function MatterService:GetWorld()
	return MatterService.world
end

function MatterService.Client:GetWorld()
	return self.Server:GetWorld()
end

function MatterService:GetState()
	return MatterService.state
end

function MatterService:SpawnEntity(...)
	return MatterService.world:spawn(...)
end

function MatterService:QueryEntities(...)
	return MatterService.world:query(...)
end

function MatterService:DespawnEntity(id)
	return MatterService.world:despawn(id)
end

return MatterService
