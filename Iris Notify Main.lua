local NotificationTable = {}
local Done = true
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local TemplateName = {}
local placeId = tostring(game.PlaceId)

local NotificationFolder = Instance.new("Folder")
local WallNotificationFolder = Instance.new("Folder")

local function Debug(...)
	if getgenv().DebugEnabled and Players.LocalPlayer then
		rconsolename("Data_" .. placeId)
		local args = table.concat({ ... }, " ")
		rconsolewarn(args)
		task.wait(1.5)
	end
end

local function CreateNormalNotificationArguments()
	return {
		Duration = 4,

		TitleSettings = {
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextScaled = true,
			TextWrapped = true,
			TextSize = 18.000,
			Font = Enum.Font.SourceSansBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
		},

		DescriptionSettings = {
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextScaled = true,
			TextWrapped = true,
			TextSize = 14.000,
			Font = Enum.Font.SourceSans,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		},

		IconSettings = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		},

		GradientSettings = {
			GradientEnabled = true,
			SolidColorEnabled = false,
			SolidColor = Color3.fromRGB(0, 255, 255),
			Retract = false,
			Extend = false,
		},

		Main = {
			BorderColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BackgroundTransparency = 0.050,
			Rounding = true,
			BorderSizePixel = 1,
		},
	}
end

local function RandomName(size)
	local chars = {
		"{",
		"}",
		"[",
		"]",
		"(",
		")",
		"/",
		"\\",
		"'",
		"\"",
		"~",
		",",
		";",
		":",
		".",
		"<",
		">",
		"@",
		"#",
		"$",
		"%",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"0",
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
		"p",
		"q",
		"r",
		"s",
		"t",
		"u",
		"v",
		"w",
		"x",
		"y",
		"z",
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"P",
		"Q",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z",
	}
	local randomChars = {}
	for i = 1, size do
		table.insert(randomChars, chars[math.random(#chars)])
	end
	return table.concat(randomChars)
end

local function generateTemplateName()
	if getgenv().DevBuild then
		return RandomName(15) .. "_"
	end
	return "_Template"
end

if hookmetamethod then
	local antiNameIndex
	antiNameIndex = hookmetamethod(game, "__index", function(...)
		local self, index = ...
		if table.find(NotificationTable, self) and not checkcaller() and tostring(index) == "Name" then
			return "CoreGui"
		end
		return antiNameIndex(...)
	end)
end

NotificationTable.CreateNotification = function(TitleData, Text, Image, Settings)
	local Notification = Instance.new("ScreenGui")
	local _Template = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local Title = Instance.new("TextLabel")
	local TextLabel = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local Frame = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")

	local Duration = Settings.Duration
	local TitleSettings = Settings.TitleSettings
	local DescriptionSettings = Settings.DescriptionSettings
	local IconSettings = Settings.IconSettings
	local GradientSettings = Settings.GradientSettings
	local MainSettings = Settings.Main

	if getgenv() and game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("NotificationFrame"):FindFirstChild("NotificationFolder") then
		NotificationFolder = game:GetService("CoreGui").RobloxGui.NotificationFrame.NotificationFolder
	else
		NotificationFolder = Players.LocalPlayer.PlayerGui:FindFirstChild("NotificationFolder") or Instance.new("Folder", Players.LocalPlayer.PlayerGui)
		NotificationFolder.Name = "NotificationFolder"
	end

	Notification.Name = RandomName(15)

	_Template.Name = generateTemplateName()
	Notification.Parent = NotificationFolder
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Notification.Enabled = true

	_Template.BackgroundColor3 = MainSettings.BackgroundColor3
	_Template.BackgroundTransparency = MainSettings.BackgroundTransparency
	_Template.BorderColor3 = MainSettings.BorderColor3
	_Template.Position = UDim2.new(0.713929176, 0, 0.587826073, 0)
	_Template.Size = UDim2.new(0, 270, 0, 64)
	_Template.ZIndex = 9
	_Template.Visible = false
	_Template.Parent = Notification

	Icon.Name = "Icon"
	Icon.Parent = _Template
	Icon.BackgroundColor3 = IconSettings.BackgroundColor3
	Icon.BackgroundTransparency = IconSettings.BackgroundTransparency
	Icon.Position = UDim2.new(0.0277603213, 0, 0.182097465, 0)
	Icon.Size = UDim2.new(0, 40, 0, 40)
	Icon.Image = Image

	UIAspectRatioConstraint.Parent = Icon

	Title.Name = "Title"
	Title.Parent = _Template
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0, 63, 0, 2)
	Title.Size = UDim2.new(0, 129, 0, 21)
	Title.Text = TitleData
	Title.TextColor3 = TitleSettings.TextColor3
	Title.TextScaled = TitleSettings.TextScaled
	Title.TextSize = TitleSettings.TextSize
	Title.TextWrapped = TitleSettings.TextWrapped
	Title.TextXAlignment = TitleSettings.TextXAlignment
	Title.TextYAlignment = TitleSettings.TextYAlignment
	Title.Font = TitleSettings.Font
	Title.BackgroundColor3 = TitleSettings.BackgroundColor3
	Title.RichText = true

	TextLabel.Parent = _Template
	TextLabel.BackgroundColor3 = DescriptionSettings.BackgroundColor3
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0, 63, 0, 23)
	TextLabel.Size = UDim2.new(0, 178, 0, 35)
	TextLabel.Text = Text
	TextLabel.TextColor3 = DescriptionSettings.TextColor3
	TextLabel.TextScaled = DescriptionSettings.TextScaled
	TextLabel.TextSize = DescriptionSettings.TextSize
	TextLabel.TextWrapped = DescriptionSettings.TextWrapped
	TextLabel.TextXAlignment = DescriptionSettings.TextXAlignment
	TextLabel.TextYAlignment = DescriptionSettings.TextYAlignment
	TextLabel.Font = DescriptionSettings.Font
	TextLabel.BackgroundColor3 = DescriptionSettings.BackgroundColor3
	TextLabel.RichText = true

	UICorner.Parent = MainSettings.Rounding and _Template or nil

	Frame.Parent = _Template
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 0, 1, -3)
	Frame.Size = UDim2.new(0, 263, 0, 3)
	Frame.Visible = false

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 8, 231)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(64, 0, 255)) })
	UIGradient.Parent = Frame

	if GradientSettings.GradientEnabled then
		Frame.Visible = true
	elseif GradientSettings.SolidColor then
		UIGradient:Destroy()
		Frame.BackgroundColor3 = GradientSettings.SolidColor
		Frame.Visible = true
	end

	return { _Template, Duration, GradientSettings.Retract, GradientSettings.Extend }
end

local function insertNotification(notification, duration, retracting, extending)
	local showPosition = UDim2.new(1, -280, 1, -70 * #NotificationFolder:GetChildren() - 1)
	local hidePosition = UDim2.new(1, 0, 1, 0)
	local tweenInfData = TweenInfo.new(0.4)
	local tweenInfData2 = TweenInfo.new(duration)

	notification.Position = hidePosition
	notification.Visible = true

	TweenService:Create(notification, tweenInfData, {
		Position = showPosition,
	}):Play()

	if retracting then
		TweenService:Create(notification.Frame, tweenInfData2, {
			Size = UDim2.new(0, 0, 0, 3),
		}):Play()
	elseif extending then
		notification.Frame.Size = UDim2.new(0, 0, 0, 3)
		TweenService:Create(notification.Frame, tweenInfData2, {
			Size = UDim2.new(0, 263, 0, 3),
		}):Play()
	end

	task.wait(tweenInfData2.Time)
	task.wait(tweenInfData.Time)

	local tween = TweenService:Create(notification, tweenInfData, {
		Position = hidePosition,
	})

	tween.Completed:Connect(function(state)
		if state == Enum.PlaybackState.Completed then
			notification.Parent:Destroy()
		end
	end)

	tween:Play()
end

NotificationTable.InsertNotification = function(notification, duration, retracting, extending)
	repeat
		game:GetService("RunService").Heartbeat:Wait()
	until Done

	insertNotification(notification, duration, retracting, extending)

	Done = false
end

NotificationTable.Notify = function(...)
	coroutine.wrap(function(...)
		local Args = { ... }

		assert(#Args >= 3 and #Args <= 4, "Error: Invalid number of arguments for Notify | Expected 3-4")

		for Index, Argument in next, Args do
			if Index ~= 4 then
				Args[Index] = tostring(Argument)
			end
		end

		Args[4] = Args[4] or CreateNormalNotificationArguments()
		Args[5] = CreateNormalNotificationArguments()

		for Property, Value in next, Args[4] do
			if type(Value) == "table" then
				for SubProperty, SubValue in next, Value do
					Args[5][Property][SubProperty] = SubValue
				end
			else
				Args[5][Property] = Value
			end
		end

		local NotifFrame = NotificationTable.CreateNotification(Args[1], Args[2], Args[3], Args[5])

		NotificationTable.InsertNotification(NotifFrame[1], NotifFrame[2], NotifFrame[3], NotifFrame[4])
	end)(...)
end

-- { Wall Notifications } --

local function CreateWallArgs()
	return {
		Duration = 5,

		MainSettings = {
			Orientation = "Middle",
			VisibleSize = UDim2.new(0.96981132, 0, 0.947604775, 0),
			HiddenSize = UDim2.new(0, 0, 0.947604775, 0),
			TweenTime = 0.8,
		},

		TitleSettings = {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextScaled = true,
			TextWrapped = true,
			TextSize = 18.000,
			Font = Enum.Font.SourceSansBold,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
		},

		DescriptionSettings = {
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextScaled = true,
			TextWrapped = true,
			TextSize = 14.000,
			Font = Enum.Font.SourceSans,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
		},
	}
end

NotificationTable.CreateWallNotification = function(TitleText, DescriptionText, Settings)
	local Duration = Settings.Duration
	local TitleSettings = Settings.TitleSettings
	local DescriptionSettings = Settings.DescriptionSettings
	local MainSettings = Settings.MainSettings

	if getgenv then
		if game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("WallNotificationFolder") then
			WallNotificationFolder = game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("WallNotificationFolder")
		else
			WallNotificationFolder.Name = "WallNotificationFolder"
			WallNotificationFolder.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
		end
	else
		if Players.LocalPlayer.PlayerGui:FindFirstChild("WallNotificationFolder") then
			WallNotificationFolder = Players.LocalPlayer.PlayerGui:FindFirstChild("WallNotificationFolder")
		else
			WallNotificationFolder.Name = "WallNotificationFolder"
			WallNotificationFolder.Parent = Players.LocalPlayer.PlayerGui
		end
	end

	local WallNotification = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Description = Instance.new("TextLabel")

	WallNotification.Name = "Notification"
	WallNotification.Parent = WallNotificationFolder
	WallNotification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	WallNotification.Enabled = true

	Main.Name = "Main"
	Main.Parent = WallNotification
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.BackgroundTransparency = 0.200
	Main.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = MainSettings.HiddenSize

	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.267834008, 0, 0.0142180091, 0)
	Title.Size = UDim2.new(0.463035017, 0, 0.0805396363, 0)
	Title.Text = TitleText
	Title.TextColor3 = TitleSettings.TextColor3
	Title.TextScaled = TitleSettings.TextScaled
	Title.TextSize = TitleSettings.TextSize
	Title.TextWrapped = TitleSettings.TextWrapped
	Title.TextXAlignment = TitleSettings.TextXAlignment
	Title.TextYAlignment = TitleSettings.TextYAlignment
	Title.Font = TitleSettings.Font
	Title.BackgroundColor3 = TitleSettings.BackgroundColor3
	Title.Visible = TitleSettings.Enabled
	Title.RichText = true

	Description.Name = "Description"
	Description.Parent = Main
	Description.BackgroundTransparency = 1.000
	Description.Position = UDim2.new(0.0149156936, 0, 0.127962083, 0)
	Description.Size = UDim2.new(0.969520092, 0, 0.830963671, 0)
	Description.Text = DescriptionText
	Description.TextColor3 = DescriptionSettings.TextColor3
	Description.TextScaled = DescriptionSettings.TextScaled
	Description.TextSize = DescriptionSettings.TextSize
	Description.TextWrapped = DescriptionSettings.TextWrapped
	Description.TextXAlignment = DescriptionSettings.TextXAlignment
	Description.TextYAlignment = DescriptionSettings.TextYAlignment
	Description.Font = DescriptionSettings.Font
	Description.BackgroundColor3 = DescriptionSettings.BackgroundColor3
	Description.RichText = true

	Main.Visible = false

	return { Main, Duration, MainSettings }
end

NotificationTable.InsertWallNotification = function(Notification, Duration, SettingsTable)
	local ShowSize = SettingsTable.VisibleSize
	local HiddenSize = SettingsTable.HiddenSize
	local PositionType = SettingsTable.Orientation
	local TweenInfData = TweenInfo.new(SettingsTable.TweenTime)

	if PositionType == "Top" then
		Notification.Visible = true
		Notification.Size = ShowSize
		Notification.Position = UDim2.new(Notification.Position.X.Scale, Notification.Position.X.Offset, 0, -(Notification.Parent.AbsoluteSize.Y / 2) - 25)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
		}):Play()

		task.wait(TweenInfData.Time + Duration)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(Notification.Position.X.Scale, Notification.Position.X.Offset, 0, -(Notification.Parent.AbsoluteSize.Y / 2) - 25),
		}):Play()

		task.wait(TweenInfData.Time)
	elseif PositionType == "Left" then
		Notification.Visible = true
		Notification.Size = ShowSize
		Notification.Position = UDim2.new(0, -(Notification.Parent.AbsoluteSize.X / 2), Notification.Position.Y.Scale, Notification.Position.Y.Offset)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
		}):Play()

		task.wait(TweenInfData.Time + Duration)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0, -(Notification.Parent.AbsoluteSize.X / 2), Notification.Position.Y.Scale, Notification.Position.Y.Offset),
		}):Play()

		task.wait(TweenInfData.Time)
	elseif PositionType == "Right" then
		Notification.Visible = true
		Notification.Size = ShowSize
		Notification.Position = UDim2.new(0, Notification.Parent.AbsoluteSize.X + Notification.AbsoluteSize.X / 2, Notification.Position.Y.Scale, Notification.Position.Y.Offset)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
		}):Play()

		task.wait(TweenInfData.Time + Duration)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0, Notification.Parent.AbsoluteSize.X + Notification.AbsoluteSize.X / 2, Notification.Position.Y.Scale, Notification.Position.Y.Offset),
		}):Play()

		task.wait(TweenInfData.Time)
	elseif PositionType == "Bottom" then
		Notification.Visible = true
		Notification.Size = ShowSize
		Notification.Position = UDim2.new(Notification.Position.X.Scale, Notification.Position.X.Offset, 0, Notification.Parent.AbsoluteSize.Y + (Notification.AbsoluteSize.Y / 2))

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
		}):Play()

		task.wait(TweenInfData.Time + Duration)

		TweenService:Create(Notification, TweenInfData, {
			Position = UDim2.new(Notification.Position.X.Scale, Notification.Position.X.Offset, 0, Notification.Parent.AbsoluteSize.Y + (Notification.AbsoluteSize.Y / 2)),
		}):Play()

		task.wait(TweenInfData.Time)
	elseif PositionType == "Middle" then
		Notification.Visible = true

		TweenInfData = TweenInfo.new(0.8)

		TweenService:Create(Notification, TweenInfData, {
			Size = ShowSize,
		}):Play()

		task.wait(TweenInfData.Time + Duration)

		TweenService:Create(Notification, TweenInfData, {
			Size = HiddenSize,
		}):Play()

		task.wait(TweenInfData.Time)
	end

	Notification.Parent:Destroy()
end

NotificationTable.WallNotification = function(...)
	--coroutine.wrap(function(...)
	local Args = { ... }

	assert(#Args > 1 and #Args < 4, "Error: Invalid number of arguments for WallNotification | Expected 2-3")

	for Index, Argument in next, Args do
		if Index ~= 3 then
			Args[Index] = tostring(Argument)
		end
	end

	Args[3] = Args[3] or CreateWallArgs()
	Args[4] = CreateWallArgs()

	for Property, Value in next, Args[3] do
		if type(Value) == "table" then
			for SubProperty, SubValue in next, Value do
				Args[4][Property][SubProperty] = SubValue
			end
		else
			Args[4][Property] = Value
		end
	end
	local NotifFrame = NotificationTable.CreateWallNotification(Args[1], Args[2], Args[4])
	NotificationTable.InsertWallNotification(NotifFrame[1], NotifFrame[2], NotifFrame[3])
	--end)(...)
end

NotificationTable.ClearOverride = function()
	for _, Folder in next, game:GetService("CoreGui"):FindFirstChild("RobloxGui"):GetChildren() do
		if Folder.Name:match("NotificationFolder") or Folder.Name:match("WallNotificationFolder") then
			Folder:Destroy()
		end
	end
	for _, Folder in next, Players.LocalPlayer.PlayerGui:GetChildren() do
		if Folder.Name:match("NotificationFolder") or Folder.Name:match("WallNotificationFolder") then
			Folder:Destroy()
		end
	end
end
return NotificationTable
