local ReplicatedStorage = game:GetService("ReplicatedStorage")
local components = require(ReplicatedStorage.Shared.components)
local Players = game:GetService("Players")
local knit = require(ReplicatedStorage.WallyPackages.knit)

local CombatService = {
	Name = "CombatService",
	Client = {
		onPointsChanged = knit.CreateSignal(),
	},
}

function CombatService:KnitInit()
	CombatService._matterService = require(script.Parent.MatterService)
	CombatService._databaseService = require(script.Parent.DatabaseService)
end

function CombatService:AddPoint(playerId: number)
	for _, player: Player in Players:GetChildren() do
		if player.UserId == playerId then
			local points = CombatService._databaseService:Get(player, "points", 0)
			if points then
				local newPoints = points + 1
				CombatService._databaseService:Set(player, "points", newPoints)
				CombatService.Client.onPointsChanged:Fire(player, newPoints)
			end
			break
		end
	end
end

function CombatService.Client:Attack(player: Player)
	local server: typeof(CombatService) = self.Server
	--get players component id
	local world = server._matterService:GetWorld()
	for id, playerC in world:query(components.Player) do
		if playerC.userId == player.UserId then
			world:insert(id, components.HitFrame({ attackerId = id }))
			break
		end
	end
end

return CombatService
