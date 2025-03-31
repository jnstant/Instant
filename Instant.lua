local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Reference to the RemoteEvent
local flingEvent = ReplicatedStorage:WaitForChild("FlingEvent")

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Instant"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Instant Fling GUI"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.Parent = frame

local dropdown = Instance.new("TextButton")
dropdown.Text = "Select Player"
dropdown.Size = UDim2.new(0.8, 0, 0, 50)
dropdown.Position = UDim2.new(0.1, 0, 0.3, 0)
dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdown.Font = Enum.Font.SourceSans
dropdown.TextSize = 18
dropdown.Parent = frame

local flingButton = Instance.new("TextButton")
flingButton.Text = "Fling Player"
flingButton.Size = UDim2.new(0.8, 0, 0, 50)
flingButton.Position = UDim2.new(0.1, 0, 0.6, 0)
flingButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingButton.Font = Enum.Font.SourceSans
flingButton.TextSize = 18
flingButton.Parent = frame

-- Dropdown functionality
local selectedPlayer = nil
dropdown.MouseButton1Click:Connect(function()
    local playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end

    local dropdownMenu = Instance.new("Frame")
    dropdownMenu.Size = UDim2.new(0.8, 0, 0, #playerList * 30)
    dropdownMenu.Position = UDim2.new(0.1, 0, 0.4, 0)
    dropdownMenu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownMenu.Parent = frame

    for i, playerName in ipairs(playerList) do
        local button = Instance.new("TextButton")
        button.Text = playerName
        button.Size = UDim2.new(1, 0, 0, 30)
        button.Position = UDim2.new(0, 0, (i - 1) * 30 / dropdownMenu.Size.Y.Offset, 0)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18
        button.Parent = dropdownMenu

        button.MouseButton1Click:Connect(function()
            selectedPlayer = playerName
            dropdown.Text = "Selected: " .. playerName
            dropdownMenu:Destroy()
        end)
    end
end)

-- Fling button functionality
flingButton.MouseButton1Click:Connect(function()
    if selectedPlayer then
        flingEvent:FireServer(selectedPlayer)
    else
        print("No player selected!")
    end
end)
