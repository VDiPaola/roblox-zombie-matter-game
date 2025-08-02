local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = require(ReplicatedStorage.Shared.components)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)
local StateEnums = require(ReplicatedStorage.Shared.Utils.Enums.StateEnums)

local function characterAdded(world)
	for _, player in ipairs(Players:GetPlayers()) do
		for _, character in Matter.useEvent(player, "CharacterAdded") do
			world:spawn(
				Components.Target(),
				Components.Model({
					model = character,
				}),
				Components.Player({
					userId = player.UserId,
				}),
				Components.State({
					current = StateEnums.State.Idle,
					time = 0,
					transitionTable = {
						[StateEnums.State.Idle] = {
							[StateEnums.State.Attacking] = true,
							[StateEnums.State.Jumping] = true,
						},
						[StateEnums.State.Attacking] = {
							[StateEnums.State.Idle] = true,
							[StateEnums.State.Jumping] = true,
						},
						[StateEnums.State.Jumping] = { [StateEnums.State.Attacking] = true },
					},
				}),
				Components.AnimationPlayer({
					animationTable = {
						[StateEnums.State.Attacking] = "133050099895224",
						[StateEnums.State.Jumping] = "569720185",
					},
				})
			)
		end
	end

	-- players can die
	for id in world:query(Components.Target):without(Components.Model) do
		world:despawn(id)
	end
end

return characterAdded
