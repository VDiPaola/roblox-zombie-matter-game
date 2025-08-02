local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputTypes = require(ReplicatedStorage.Shared.Utils.Types.InputTypes)

local InputEnums = {}

local actions: { [InputTypes.InputActionType]: InputTypes.InputActionType } = {
	LeftClick = "LeftClick",
	RightClick = "RightClick",
	Ability1 = "Ability1",
	Ability2 = "Ability2",
	Ability3 = "Ability3",
	Ability4 = "Ability4",
	Consumable1 = "Consumable1",
	Consumable2 = "Consumable2",
	Inventory = "Inventory",
	Settings = "Settings",
	Movement = "Movement",
	Jump = "Jump",
}

InputEnums.Actions = actions

InputEnums.InputType = {
	PC = "PC",
	Mobile = "Mobile",
	Console = "Console",
}

return InputEnums
