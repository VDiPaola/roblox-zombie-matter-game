local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Knit = require(ReplicatedStorage.WallyPackages.knit)

-- Add Controllers
for _, v in ipairs(StarterPlayer.StarterPlayerScripts.Client.Controllers:GetDescendants()) do
	if v:IsA("ModuleScript") and v.Name:match("Controller$") then
		Knit.CreateController(require(v))
	end
end

Knit.Start()
	:andThen(function()
		print("Knit started")
	end)
	:catch(warn)
