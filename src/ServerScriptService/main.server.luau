local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.WallyPackages.knit)

-- Add Services
for _, v in ipairs(script.Parent.Services:GetDescendants()) do
	if v:IsA("ModuleScript") and v.Name:match("Service$") then
		Knit.CreateService(require(v))
	end
end

-- Start Knit
Knit.Start()
	:andThen(function()
		print("Knit started")
	end)
	:catch(warn)
