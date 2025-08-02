local ReplicatedStorage = game:GetService("ReplicatedStorage")

--roact
local Roact = require(ReplicatedStorage.WallyPackages.Roact)

local PlayerDetailsComponent = require(script.Parent.points)

--root component
local InterfaceRoot = Roact.Component:extend("InterfaceRoot")

function InterfaceRoot:init()
	self.isEnabled, self.setIsEnabled = Roact.createBinding(true)
end

function InterfaceRoot:render()
	return Roact.createElement("ScreenGui", {
		Enabled = self.isEnabled,
	}, {
		PlayerDetails = Roact.createElement(PlayerDetailsComponent),
	})
end

return InterfaceRoot
