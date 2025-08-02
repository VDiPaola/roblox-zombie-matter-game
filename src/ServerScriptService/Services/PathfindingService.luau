local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pfService = game:GetService("PathfindingService")
local Components = require(ReplicatedStorage.Shared.components)

local PathfindingService = {
	Name = "PathfindingService",

	_matterService = nil,
}

function PathfindingService:KnitInit()
	self._matterService = require(script.Parent.MatterService)
end

--get nearest pos out of a list of positions
function PathfindingService:GetNearestModel(position: Vector3, targets: { Model }, maxDistance: number?): Model | nil
	local closestDistance = math.huge
	local closestTarget = nil

	for _, target in ipairs(targets) do
		local pos = target.PrimaryPart.Position
		local distance = (position - pos).Magnitude
		if distance < closestDistance then
			if not maxDistance or distance < maxDistance then
				closestDistance = distance
				closestTarget = target
			end
		end
	end

	return closestTarget
end

function PathfindingService:GetClosestPlayer(position: Vector3): Model?
	--gets closest player to the position
	local targetModels = {}
	local world = self._matterService:GetWorld()
	for _, modelC in world:query(Components.Model, Components.Target) do
		table.insert(targetModels, modelC.model)
	end
	local target = self:GetNearestModel(position, targetModels)
	return target
end

function PathfindingService:MoveToClosestPlayer(humanoid: Humanoid, onComplete: (() -> ())?)
	--DEPRECATED
	if not humanoid.RootPart then
		error("Root part not found in humanoid")
	end

	--calculate closest player
	local target = self:GetClosestPlayer(humanoid.RootPart.Position)
	if not target then
		error("No target")
	end
	local targetPos = target.PrimaryPart.Position

	--create path
	local path = pfService:CreatePath()
	local success, result = pcall(function()
		return path:ComputeAsync(humanoid.RootPart.Position, targetPos)
	end)

	--waypoints
	if success and path.Status == Enum.PathStatus.Success then
		local waypoints = path:GetWaypoints()

		-- Move through each waypoint
		for i, waypoint in ipairs(waypoints) do
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
	else
		warn("Pathfinding failed:", result)
	end

	if onComplete then
		onComplete()
	end
end

return PathfindingService
