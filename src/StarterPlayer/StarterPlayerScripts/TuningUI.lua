-- StarterPlayer/StarterPlayerScripts/TuningUI.lua
-- Complete tuning, shop, speed HUD and race controls

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local tuningFolder = ReplicatedStorage:WaitForChild("TuningSystem")

local remotes = {
    SpawnVehicle = tuningFolder:WaitForChild("SpawnVehicle"),
    BuyVehicle = tuningFolder:WaitForChild("BuyVehicle"),
    SellVehicle = tuningFolder:WaitForChild("SellVehicle"),
    UpgradeVehicle = tuningFolder:WaitForChild("UpgradeVehicle"),
    PaintVehicle = tuningFolder:WaitForChild("PaintVehicle"),
    PoliceAlert = tuningFolder:WaitForChild("PoliceAlert"),
    UIMessage = tuningFolder:WaitForChild("UIMessage"),
    ModShop = tuningFolder:WaitForChild("ModShop"),
    VehicleList = tuningFolder:WaitForChild("VehicleList"),
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TuningHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = gui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 420)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "OPEN WORLD TUNING WORKSHOP"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 22)
infoLabel.Position = UDim2.new(0, 10, 0, 46)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Werkstatt bereit"
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 14
infoLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
infoLabel.Parent = mainFrame

local vehicleList = {"BMW M5", "Audi RS6", "Mercedes C63 AMG", "Porsche 911 Turbo", "VW Golf GTI", "Nissan R34", "Toyota Supra", "Ford Mustang", "Ferrari F8", "Lamborghini Huracan"}
local selectedIndex = 1

local carDropdown = Instance.new("TextButton")
carDropdown.Size = UDim2.new(0, 200, 0, 38)
carDropdown.Position = UDim2.new(0, 20, 0, 80)
carDropdown.Text = vehicleList[selectedIndex]
carDropdown.Font = Enum.Font.GothamBold
carDropdown.TextSize = 17
carDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
carDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
carDropdown.BorderSizePixel = 0
carDropdown.Parent = mainFrame

carDropdown.MouseButton1Click:Connect(function()
    selectedIndex += 1
    if selectedIndex > #vehicleList then
        selectedIndex = 1
    end
    carDropdown.Text = vehicleList[selectedIndex]
end)

local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0, 120, 0, 40)
spawnBtn.Position = UDim2.new(0, 240, 0, 80)
spawnBtn.Text = "Spawn"
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.TextSize = 16
spawnBtn.BackgroundColor3 = Color3.fromRGB(48, 166, 75)
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.BorderSizePixel = 0
spawnBtn.Parent = mainFrame

spawnBtn.MouseButton1Click:Connect(function()
    remotes.SpawnVehicle:FireServer(vehicleList[selectedIndex])
end)

local buyBtn = Instance.new("TextButton")
buyBtn.Size = UDim2.new(0, 120, 0, 40)
buyBtn.Position = UDim2.new(0, 240, 0, 130)
buyBtn.Text = "Kaufen"
buyBtn.Font = Enum.Font.GothamBold
buyBtn.TextSize = 16
buyBtn.BackgroundColor3 = Color3.fromRGB(255, 145, 0)
buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyBtn.BorderSizePixel = 0
buyBtn.Parent = mainFrame

buyBtn.MouseButton1Click:Connect(function()
    remotes.BuyVehicle:FireServer(vehicleList[selectedIndex])
end)

local sellBtn = Instance.new("TextButton")
sellBtn.Size = UDim2.new(0, 120, 0, 40)
sellBtn.Position = UDim2.new(0, 240, 0, 180)
sellBtn.Text = "Verkaufen"
sellBtn.Font = Enum.Font.GothamBold
sellBtn.TextSize = 16
sellBtn.BackgroundColor3 = Color3.fromRGB(255, 86, 86)
sellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sellBtn.BorderSizePixel = 0
sellBtn.Parent = mainFrame

sellBtn.MouseButton1Click:Connect(function()
    remotes.SellVehicle:FireServer(vehicleList[selectedIndex])
end)

local turboBtn = Instance.new("TextButton")
turboBtn.Size = UDim2.new(0, 150, 0, 38)
turboBtn.Position = UDim2.new(0, 20, 0, 150)
turboBtn.Text = "Turbo"
turboBtn.Font = Enum.Font.GothamBold
turboBtn.TextSize = 15
turboBtn.BackgroundColor3 = Color3.fromRGB(255, 118, 34)
turboBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
turboBtn.BorderSizePixel = 0
turboBtn.Parent = mainFrame

turboBtn.MouseButton1Click:Connect(function()
    remotes.UpgradeVehicle:FireServer("Turbo")
end)

local downpipeBtn = Instance.new("TextButton")
downpipeBtn.Size = UDim2.new(0, 150, 0, 38)
downpipeBtn.Position = UDim2.new(0, 20, 0, 200)
downpipeBtn.Text = "Downpipe"
downpipeBtn.Font = Enum.Font.GothamBold
downpipeBtn.TextSize = 15
downpipeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
downpipeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
downpipeBtn.BorderSizePixel = 0
downpipeBtn.Parent = mainFrame

downpipeBtn.MouseButton1Click:Connect(function()
    remotes.UpgradeVehicle:FireServer("Downpipe")
end)

local popbangBtn = Instance.new("TextButton")
popbangBtn.Size = UDim2.new(0, 150, 0, 38)
popbangBtn.Position = UDim2.new(0, 20, 0, 250)
popbangBtn.Text = "Pop & Bang"
popbangBtn.Font = Enum.Font.GothamBold
popbangBtn.TextSize = 15
popbangBtn.BackgroundColor3 = Color3.fromRGB(147, 88, 255)
popbangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
popbangBtn.BorderSizePixel = 0
popbangBtn.Parent = mainFrame

popbangBtn.MouseButton1Click:Connect(function()
    remotes.UpgradeVehicle:FireServer("PopBang")
end)

local engineBtn = Instance.new("TextButton")
engineBtn.Size = UDim2.new(0, 150, 0, 38)
engineBtn.Position = UDim2.new(0, 20, 0, 300)
engineBtn.Text = "Engine Tune"
engineBtn.Font = Enum.Font.GothamBold
engineBtn.TextSize = 15
engineBtn.BackgroundColor3 = Color3.fromRGB(52, 120, 255)
engineBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
engineBtn.BorderSizePixel = 0
engineBtn.Parent = mainFrame

engineBtn.MouseButton1Click:Connect(function()
    remotes.UpgradeVehicle:FireServer("Engine")
end)

local paintBtn = Instance.new("TextButton")
paintBtn.Size = UDim2.new(0, 140, 0, 40)
paintBtn.Position = UDim2.new(0, 230, 0, 250)
paintBtn.Text = "Farbe"
paintBtn.Font = Enum.Font.GothamBold
paintBtn.TextSize = 15
paintBtn.BackgroundColor3 = Color3.fromRGB(74, 160, 255)
paintBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
paintBtn.BorderSizePixel = 0
paintBtn.Parent = mainFrame

paintBtn.MouseButton1Click:Connect(function()
    remotes.PaintVehicle:FireServer(255, 120, 0)
end)

local policeBtn = Instance.new("TextButton")
policeBtn.Size = UDim2.new(0, 140, 0, 40)
policeBtn.Position = UDim2.new(0, 230, 0, 300)
policeBtn.Text = "Police"
policeBtn.Font = Enum.Font.GothamBold
policeBtn.TextSize = 15
policeBtn.BackgroundColor3 = Color3.fromRGB(26, 90, 255)
policeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
policeBtn.BorderSizePixel = 0
policeBtn.Parent = mainFrame

policeBtn.MouseButton1Click:Connect(function()
    remotes.PoliceAlert:FireServer("illegal street race and tuning")
end)

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 420, 0, 36)
speedLabel.Position = UDim2.new(0, 40, 0, 360)
speedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedLabel.BorderSizePixel = 0
speedLabel.Text = "0 KPH / 0 MPH"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 20
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Parent = mainFrame

local function updateSpeed()
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local speedKph = math.floor((rootPart.AssemblyLinearVelocity.Magnitude * 3.6) + 0.5)
    local speedMph = math.floor(speedKph / 1.609 + 0.5)
    speedLabel.Text = speedKph .. " KPH / " .. speedMph .. " MPH"
end

remotes.UIMessage.OnClientEvent:Connect(function(message)
    infoLabel.Text = message
end)

remotes.VehicleList.OnClientEvent:Connect(function(vehicleNames)
    -- placeholder; can be expanded later to a list UI
end)

RunService.RenderStepped:Connect(function()
    updateSpeed()
end)

print("Roblox tuning UI loaded")
