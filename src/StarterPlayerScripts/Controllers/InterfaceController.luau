local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.WallyPackages.knit)
local Roact = require(ReplicatedStorage.WallyPackages.Roact)
local Signal = require(ReplicatedStorage.WallyPackages.Signal)
local LocalPlayer = game:GetService("Players").LocalPlayer

local InterfaceController = {
	Name = "InterfaceController",
	_elements = {},

	points = 0,
	pointsChanged = Signal.new(),
}

function InterfaceController:KnitInit()
	LocalPlayer.CharacterAdded:Connect(function()
		self:MountElements()
	end)

	InterfaceController._combatService = Knit.GetService("CombatService")
end

function InterfaceController:KnitStart()
	--get interface roots
	for _, v in ipairs(script.Parent.Parent.UI:GetChildren()) do
		if v:IsA("ModuleScript") and v.Name:match("Root$") then
			--mount
			table.insert(self._elements, require(v))
		end
	end

	if #self._elements <= 0 then
		self:MountElements()
	end

	InterfaceController._combatService.onPointsChanged:Connect(function(points)
		InterfaceController.points = points
		InterfaceController.pointsChanged:Fire(points)
	end)
end

function InterfaceController:MountElements()
	for _, element in ipairs(self._elements) do
		Roact.mount(Roact.createElement(element), LocalPlayer.PlayerGui, element.Name)
	end
end

return InterfaceController
