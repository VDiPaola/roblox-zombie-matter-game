local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local InputEnums = require(ReplicatedStorage.Shared.Utils.Enums.InputEnums)
local Knit = require(ReplicatedStorage.WallyPackages.knit)

local InputController = {
	Name = "InputController",
}

function InputController:KnitInit()
	InputController._keybindsController = require(script.Parent.KeybindsController)
	InputController._matterController = require(script.Parent.MatterController)

	InputController.InputService = Knit.GetService("InputService")
end

function InputController:KnitStart()
	UserInputService.InputBegan:Connect(function(input)
		local clickKey = InputController._keybindsController:GetActiveKey(InputEnums.Actions.LeftClick)
		if input.KeyCode == clickKey or input.UserInputType == clickKey then
			--try to punch when user clicks
			InputController.InputService:Input(InputEnums.Actions.LeftClick)
		elseif input.KeyCode == InputController._keybindsController:GetActiveKey(InputEnums.Actions.Jump) then
			InputController.InputService:Input(InputEnums.Actions.Jump)
		end
	end)
end

return InputController
