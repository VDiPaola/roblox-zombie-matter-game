local ServerScriptService = game:GetService("ServerScriptService")
local DatabaseService = require(ServerScriptService.Server.Services.DatabaseService)

return function(context)
	local points = DatabaseService:Get(context.Executor, "Points") or 0
	DatabaseService:Set(context.Executor, "points", points + 1)
	return "Added point"
end
