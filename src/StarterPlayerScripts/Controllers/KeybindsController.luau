local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local InputEnums = require(ReplicatedStorage.Shared.Utils.Enums.InputEnums)
local InputTypes = require(ReplicatedStorage.Shared.Utils.Types.InputTypes)
local TableUtil = require(ReplicatedStorage.WallyPackages.TableUtil)

--TODO: player specific keybinds saved to db

local defaults = {
	[InputEnums.Actions.LeftClick] = {
		[InputEnums.InputType.PC] = Enum.UserInputType.MouseButton1,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonB,
	},
	[InputEnums.Actions.RightClick] = {
		[InputEnums.InputType.PC] = Enum.UserInputType.MouseButton2,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonR1,
	},

	[InputEnums.Actions.Ability1] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.Q,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonA,
	},
	[InputEnums.Actions.Ability2] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.E,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonL1,
	},
	[InputEnums.Actions.Ability3] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.R,
		[InputEnums.InputType.Console] = Enum.KeyCode.DPadLeft,
	},
	[InputEnums.Actions.Ability4] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.F,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonL2,
	},

	[InputEnums.Actions.Consumable1] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.One,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonR1,
	},
	[InputEnums.Actions.Consumable2] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.Two,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonR2,
	},

	[InputEnums.Actions.Inventory] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.T,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonY,
	},
	[InputEnums.Actions.Settings] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.Escape,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonStart,
	},

	[InputEnums.Actions.Movement] = {
		[InputEnums.InputType.PC] = {
			Enum.KeyCode.W,
			Enum.KeyCode.A,
			Enum.KeyCode.S,
			Enum.KeyCode.D,
		},
		[InputEnums.InputType.Console] = Enum.KeyCode.Thumbstick1,
	},
	[InputEnums.Actions.Jump] = {
		[InputEnums.InputType.PC] = Enum.KeyCode.Space,
		[InputEnums.InputType.Console] = Enum.KeyCode.ButtonX,
	},
}

local KeybindsController = {
	Name = "KeybindsController",
	_defaults = defaults,
	_keybinds = defaults,

	_inputMethod = InputEnums.InputType.PC,
}

function KeybindsController:KnitInit()
	--set input method
	if UserInputService.GamepadEnabled then
		self._inputMethod = InputEnums.InputType.Console
	elseif UserInputService.TouchEnabled then
		self._inputMethod = InputEnums.InputType.Mobile
	end

	local mouseInputs = {
		Enum.UserInputType.MouseButton1,
		Enum.UserInputType.MouseButton2,
		Enum.UserInputType.MouseButton3,
		Enum.UserInputType.MouseMovement,
		Enum.UserInputType.MouseWheel,
	}

	local gamepadInputs = {
		Enum.UserInputType.Gamepad1,
		Enum.UserInputType.Gamepad2,
		Enum.UserInputType.Gamepad3,
		Enum.UserInputType.Gamepad4,
		Enum.UserInputType.Gamepad5,
		Enum.UserInputType.Gamepad6,
		Enum.UserInputType.Gamepad7,
		Enum.UserInputType.Gamepad8,
	}

	UserInputService.LastInputTypeChanged:Connect(function(lastInputType)
		--update input method
		if lastInputType == Enum.UserInputType.Keyboard or table.find(mouseInputs, lastInputType) ~= nil then
			self._inputMethod = InputEnums.InputType.PC
		elseif table.find(gamepadInputs, lastInputType) ~= nil then
			self._inputMethod = InputEnums.InputType.Console
		elseif lastInputType == Enum.UserInputType.Touch then
			self._inputMethod = InputEnums.InputType.Mobile
		end
	end)
end

function KeybindsController:IsGamepadEnabled(): boolean
	return UserInputService.GamepadEnabled
end

function KeybindsController:IsTouchEnabled(): boolean
	return UserInputService.TouchEnabled
end

function KeybindsController:GetInputMethod(): "PC" | "Mobile" | "Console"
	--returns active input method
	return self._inputMethod
end

function KeybindsController:GetActiveKey(action: InputTypes.InputActionType)
	--returns key(s) for the active input method
	local keybinds = self._keybinds[action]
	if keybinds then
		local key = keybinds[self._inputMethod]
		return key
	else
		local defaultKeybind = defaults[action]
		if defaultKeybind then
			local key = defaultKeybind[self._inputMethod]
			return key
		end
	end
	return nil
end

function KeybindsController:GetKeys(action: InputTypes.InputActionType)
	--returns all keys for the given action
	local keybinds = self._keybinds[action]
	if keybinds then
		local keys = TableUtil.Values(keybinds)
		return TableUtil.Flat(keys)
	else
		local defaultKeybind = defaults[action]
		if defaultKeybind then
			local keys = TableUtil.Values(defaultKeybind)
			return TableUtil.Flat(keys)
		end
	end
	return nil
end

return KeybindsController
