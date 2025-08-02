local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.WallyPackages.Roact)
local StarterPlayer = game:GetService("StarterPlayer")

local PlayerDetailsComponent = Roact.Component:extend("PlayerDetailsComponent")

function PlayerDetailsComponent:init()
	self.points, self.setPoints = Roact.createBinding(0)
	self.interfaceController = require(StarterPlayer.StarterPlayerScripts.Client.Controllers.InterfaceController)
	self.interfaceController.pointsChanged:Connect(function(newPoints)
		self.setPoints(newPoints)
	end)
end

function PlayerDetailsComponent:render()
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, {
		Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(3, 3),
			Size = UDim2.fromScale(0.2, 0.12),
		}, {
			Roact.createElement("Frame", {
				BackgroundColor3 = Color3.new(0.6392157077789307, 0.4392157196998596, 0.22745099663734436),
				BorderColor3 = Color3.new(1, 0.9450981020927429, 0.8235294818878174),
				BorderSizePixel = 2,
				Size = UDim2.new(UDim.new(0, 100), UDim.new(1, 0)),
			}, {
				Roact.createElement("UIAspectRatioConstraint", {
					AspectType = Enum.AspectType.ScaleWithParentSize,
					DominantAxis = Enum.DominantAxis.Height,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(50, 0),
				}),
				Roact.createElement("UIStroke", {
					Thickness = 2,
					Color = Color3.fromRGB(255, 241, 210),
				}),
				Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "rbxassetid://17074424793", --Level Background image
					ImageColor3 = Color3.new(0.501960813999176, 0.9921569228172302, 1),
					Position = UDim2.fromScale(0.23, 0.63),
					Size = UDim2.new(UDim.new(0.5, 0), UDim.new(0, 100)),
					ZIndex = 3,
				}, {
					Roact.createElement("UIAspectRatioConstraint", {
						AspectType = Enum.AspectType.ScaleWithParentSize,
					}, {}),
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Font = Enum.Font.FredokaOne,
						Size = UDim2.fromScale(0.4, 0.4),
						Text = self.points, --points
						TextColor3 = Color3.new(1, 1, 1),
						TextScaled = true,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Right,
						TextYAlignment = Enum.TextYAlignment.Bottom,
						ZIndex = 3,
					}, {}),
					Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}, {}),
				}),
				Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "rbxassetid://2623669186", --TEMP profile image
					Position = UDim2.fromScale(0.044, 0.044),
					Size = UDim2.fromScale(0.89, 0.89),
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(50, 0),
					}),
				}),
			}),
			Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0.8, 1),
			}, {
				Roact.createElement("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
				Roact.createElement("UIPadding", {
					PaddingTop = UDim.new(0, 5),
				}),
				Roact.createElement("Frame", {
					BackgroundColor3 = Color3.new(0.3529411852359772, 0.40392157435417175, 0.40784314274787903),
					BorderSizePixel = 0,
					LayoutOrder = 1,
					Size = UDim2.new(UDim.new(0.89, 0), UDim.new(0, 5)),
				}, {
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.06666667014360428, 0.4549019932746887, 0),
						BorderSizePixel = 0,
						Size = UDim2.fromScale(0.69, 1),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(1, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
				}),
				Roact.createElement("Frame", {
					BackgroundColor3 = Color3.new(0.3529411852359772, 0.40392160415649414, 0.4078431725502014),
					BorderSizePixel = 0,
					LayoutOrder = 2,
					Size = UDim2.new(UDim.new(0.89, 0), UDim.new(0, 10)),
				}, {
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Font = Enum.Font.Unknown,
						Size = UDim2.fromScale(1, 1),
						Text = "100/100", --Health value
						TextColor3 = Color3.new(0.95, 0.95, 0.95),
						TextScaled = true,
						TextWrapped = true,
						ZIndex = 3,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.6235294342041016, 0.19607844948768616, 0.027450982481241226),
						BorderSizePixel = 0,
						Size = UDim2.fromScale(0.5, 1),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(1, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(1, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
				}),
				Roact.createElement("Frame", {
					BackgroundColor3 = Color3.new(0.3529411852359772, 0.40392160415649414, 0.4078431725502014),
					BorderSizePixel = 0,
					LayoutOrder = 3,
					Size = UDim2.new(UDim.new(0.89, 0), UDim.new(0, 10)),
				}, {
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0, 0, 0),
						BorderSizePixel = 0,
						Font = Enum.Font.Unknown,
						Size = UDim2.fromScale(1, 1),
						Text = "100/100", --Mana value
						TextColor3 = Color3.new(0.95, 0.95, 0.95),
						TextScaled = true,
						TextWrapped = true,
						ZIndex = 3,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.007843137718737125, 0.3294117748737335, 0.847058892250061),
						BorderSizePixel = 0,
						Size = UDim2.fromScale(0.5, 1),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(1, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
					Roact.createElement("Frame", {
						BackgroundColor3 = Color3.new(0.95, 0.95, 0.95),
						BorderColor3 = Color3.new(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(1, -0.15),
						Size = UDim2.fromScale(0.01, 1.29),
						ZIndex = 2,
					}),
				}),
			}),
			Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}),
	})
end

return PlayerDetailsComponent
