local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local gui = script.Parent
local frame = gui.MainFrame

-- TOGGLE MENU WITH RIGHT SHIFT
local menuOpen = true

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		menuOpen = not menuOpen
		frame.Visible = menuOpen
	end
end)

-- DRAGGABLE FRAME
local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- UI CREATION
frame:ClearAllChildren()

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "hevji cheat menu 😈"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

-- Tab Buttons
local mainTab = Instance.new("TextButton", frame)
mainTab.Position = UDim2.new(0, 10, 0, 40)
mainTab.Size = UDim2.new(0, 100, 0, 30)
mainTab.Text = "Main"

local visualsTab = Instance.new("TextButton", frame)
visualsTab.Position = UDim2.new(0, 120, 0, 40)
visualsTab.Size = UDim2.new(0, 100, 0, 30)
visualsTab.Text = "Visuals"

-- Containers
local mainPage = Instance.new("Frame", frame)
mainPage.Position = UDim2.new(0, 0, 0, 80)
mainPage.Size = UDim2.new(1, 0, 1, -80)
mainPage.Visible = true

local visualsPage = Instance.new("Frame", frame)
visualsPage.Position = UDim2.new(0, 0, 0, 80)
visualsPage.Size = UDim2.new(1, 0, 1, -80)
visualsPage.Visible = false

-- Tab switching
mainTab.MouseButton1Click:Connect(function()
	mainPage.Visible = true
	visualsPage.Visible = false
end)

visualsTab.MouseButton1Click:Connect(function()
	mainPage.Visible = false
	visualsPage.Visible = true
end)

-- =====================
-- MAIN TAB (Speed cheat)
-- =====================

local speedButton = Instance.new("TextButton", mainPage)
speedButton.Position = UDim2.new(0, 20, 0, 20)
speedButton.Size = UDim2.new(0, 200, 0, 40)
speedButton.Text = "Toggle Speed"

local humanoid
local speedOn = false

local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")
end

getHumanoid()

speedButton.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	if speedOn then
		humanoid.WalkSpeed = 60
		speedButton.Text = "Speed: ON"
	else
		humanoid.WalkSpeed = 16
		speedButton.Text = "Speed: OFF"
	end
end)

-- =====================
-- VISUALS TAB (ESP 10 seconds)
-- =====================

local espButton = Instance.new("TextButton", visualsPage)
espButton.Position = UDim2.new(0, 20, 0, 20)
espButton.Size = UDim2.new(0, 200, 0, 40)
espButton.Text = "ESP (10s)"

local function enableESP()
	local highlights = {}

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			local highlight = Instance.new("Highlight")
			highlight.Parent = plr.Character
			highlight.FillColor = Color3.fromRGB(255, 0, 0)
			table.insert(highlights, highlight)
		end
	end

	-- Disable after 10 seconds
	task.delay(10, function()
		for _, h in pairs(highlights) do
			if h then
				h:Destroy()
			end
		end
	end)
end

espButton.MouseButton1Click:Connect(function()
	enableESP()
	espButton.Text = "ESP ON (10s)"
	task.delay(10, function()
		espButton.Text = "ESP (10s)"
	end)
end)
