local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = require(ReplicatedStorage.Shared.components)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)

local function spawnZombies(world)
	if Matter.useThrottle(1) then
		local radius = 250
		local rayStart = Vector3.new(math.random(-radius, radius), 500, math.random(-radius, radius))

		local direction = Vector3.new(0, -1000, 0)
		local result = workspace:Raycast(rayStart, direction)

		if result and result.Instance then
			local spawnPosition = result.Position + Vector3.new(0, 3, 0)
			world:spawn(
				Components.Zombie({
					target = nil,
					waypoints = {},
				}),
				Components.Transform({
					cframe = CFrame.new(spawnPosition),
				})
			)
		end
	end

	for id, _, zombieC in world:query(Components.Transform, Components.Zombie):without(Components.Model) do
		local model = ReplicatedStorage.Assets.zombie:Clone()
		model.Parent = workspace
		model.PrimaryPart:SetNetworkOwner(nil)

		world:insert(
			id,
			Components.Model({
				model = model,
			}),
			zombieC:patch({
				onHealthChanged = model.Humanoid.HealthChanged:Connect(function(newHealth)
					print(newHealth)
				end),
			})
		)
	end
end

return spawnZombies
