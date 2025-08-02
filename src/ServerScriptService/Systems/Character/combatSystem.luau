local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ComponentTypes = require(ReplicatedStorage.Shared.Utils.Types.ComponentTypes)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)
local components = require(ReplicatedStorage.Shared.components)

local function Combat(world)
	for id, hitFrameRecord in world:queryChanged(components.HitFrame) do
		if hitFrameRecord.new then
			local hitframe: ComponentTypes.ComponentType<ComponentTypes.HitFrameType> = hitFrameRecord.new
			local attackerExists = world:contains(hitframe.attackerId)
			local modelC = world:get(hitframe.attackerId, components.Model)
			if attackerExists and modelC and modelC.model then
				--get current attack data TEMP FOR NOW
				tempAttackData = {
					name = "punch",
					part = "RightHand",
					damage = 10,
					radius = 1.2,
				}
				local model: Model = modelC.model
				local hitPart: BasePart = modelC.model:FindFirstChild(tempAttackData.part, true)

				if hitPart then
					--get bounding box around the part depending on the radius
					local hitboxSize = hitPart.Size * tempAttackData.radius

					-- Set up the query
					local overlapParams = OverlapParams.new()
					overlapParams.FilterType = Enum.RaycastFilterType.Exclude
					overlapParams.FilterDescendantsInstances = { model } -- ignore self

					local instance = Instance.new("Part")
					instance.CanCollide = false
					instance.Anchored = true
					instance.BrickColor = BrickColor.Red()
					instance.CFrame = hitPart.CFrame
					instance.Size = hitboxSize
					instance.Parent = workspace

					-- Do the overlap trace
					local parts = workspace:GetPartBoundsInBox(hitPart.CFrame, hitboxSize, overlapParams)
					local humanoidsHit = {}
					for _, part in parts do
						local humanoid = part.Parent:FindFirstChildWhichIsA("Humanoid", true)
						if humanoid and not humanoidsHit[humanoid] then
							humanoidsHit[humanoid] = true
							humanoid:TakeDamage(tempAttackData.damage)

							--add points if player
							local playerC = world:get(hitframe.attackerId, components.Player)
							if playerC and playerC.userId then
								local CombatService = require(game.ServerScriptService.Server.Services.CombatService)
								CombatService:AddPoint(playerC.userId)
							end
						end
					end
				else
					warn("hitpart/rootPart not found")
				end
			else
				warn("attacker doesnt exist")
			end
		end
	end
end

return Combat
