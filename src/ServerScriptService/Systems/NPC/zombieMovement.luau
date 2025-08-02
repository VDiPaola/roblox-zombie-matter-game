local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local pfService = game:GetService("PathfindingService")
local Components = require(ReplicatedStorage.Shared.components)
local Matter = require(ReplicatedStorage.WallyPackages.Matter)

local function zombieMovement(world)
	for id, zombieRecord in world:queryChanged(Components.Zombie) do
		if zombieRecord.old and zombieRecord.new.waypoints ~= zombieRecord.old.waypoints then
			--make sure old thread is ended
			if zombieRecord.old.pathfindingThread then
				task.cancel(zombieRecord.old.pathfindingThread)
			end

			local modelC = world:get(id, Components.Model)

			if not modelC.model or not zombieRecord.new.waypoints then
				continue
			end

			local humanoid: Humanoid = modelC.model:FindFirstChild("Humanoid")
			if not humanoid then
				continue
			end

			--start new thread
			local thread = task.spawn(function()
				-- Move through each waypoint
				for i, waypoint in ipairs(zombieRecord.new.waypoints) do
					if i <= 1 then
						continue
					end
					-- Check if RootPart still exists
					if not humanoid.RootPart then
						warn("RootPart was destroyed during pathfinding")
						break
					end

					--handle jumping
					if waypoint.Action == Enum.PathWaypointAction.Jump then
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end

					-- Move to the waypoint
					humanoid:MoveTo(waypoint.Position)
					humanoid.MoveToFinished:Wait()
				end
			end)

			--update component
			world:insert(
				id,
				zombieRecord.new:patch({
					pathfindingThread = thread,
				})
			)
		end
	end

	if Matter.useThrottle(0.1) then
		--recalc waypoints
		for id, zombieC, modelC in world:query(Components.Zombie, Components.Model) do
			local model = modelC.model
			if not model then
				continue
			end

			local humanoid = model:FindFirstChild("Humanoid")

			if not humanoid or not humanoid.RootPart then
				error("Root part not found in humanoid or humanoid is nil")
			end

			--calculate closest player
			local pathfinderService = require(ServerScriptService.Server.Services.PathfindingService)
			local target = pathfinderService:GetClosestPlayer(humanoid.RootPart.Position)
			if not target then
				error("No target")
			end
			local targetPos = target.PrimaryPart.Position

			--create path
			task.spawn(function()
				local path = pfService:CreatePath()
				local success, result = pcall(function()
					return path:ComputeAsync(humanoid.RootPart.Position, targetPos)
				end)
				--waypoints
				if success and path.Status == Enum.PathStatus.Success then
					local waypoints = path:GetWaypoints()
					world:insert(
						id,
						zombieC:patch({
							waypoints = waypoints,
						})
					)
				end
			end)
		end
	end
end

return zombieMovement
