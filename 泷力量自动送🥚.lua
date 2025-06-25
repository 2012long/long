local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ProteinEggDonator"
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 420)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "蛋白质蛋自动赠送系统"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = mainFrame

local playerFrame = Instance.new("Frame")
playerFrame.Name = "PlayerFrame"
playerFrame.Size = UDim2.new(0.9, 0, 0, 150)
playerFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
playerFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
playerFrame.BorderSizePixel = 0
playerFrame.Parent = mainFrame

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 6)
playerCorner.Parent = playerFrame

local playerTitle = Instance.new("TextLabel")
playerTitle.Name = "PlayerTitle"
playerTitle.Text = "选择玩家"
playerTitle.Size = UDim2.new(1, 0, 0, 30)
playerTitle.Position = UDim2.new(0, 0, 0, 0)
playerTitle.BackgroundTransparency = 1
playerTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
playerTitle.Font = Enum.Font.Gotham
playerTitle.TextSize = 18
playerTitle.Parent = playerFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "PlayerScroll"
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.Parent = playerFrame

local amountFrame = Instance.new("Frame")
amountFrame.Name = "AmountFrame"
amountFrame.Size = UDim2.new(0.9, 0, 0, 80)
amountFrame.Position = UDim2.new(0.05, 0, 0.45, 0)
amountFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
amountFrame.BorderSizePixel = 0
amountFrame.Parent = mainFrame

local amountCorner = Instance.new("UICorner")
amountCorner.CornerRadius = UDim.new(0, 6)
amountCorner.Parent = amountFrame

local amountTitle = Instance.new("TextLabel")
amountTitle.Name = "AmountTitle"
amountTitle.Text = "选择数量"
amountTitle.Size = UDim2.new(1, 0, 0, 30)
amountTitle.Position = UDim2.new(0, 0, 0, 0)
amountTitle.BackgroundTransparency = 1
amountTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
amountTitle.Font = Enum.Font.Gotham
amountTitle.TextSize = 18
amountTitle.Parent = amountFrame

local amountBox = Instance.new("TextBox")
amountBox.Name = "AmountBox"
amountBox.Size = UDim2.new(0.5, 0, 0, 30)
amountBox.Position = UDim2.new(0.25, 0, 0.5, 0)
amountBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
amountBox.Font = Enum.Font.Gotham
amountBox.TextSize = 18
amountBox.Text = "1"
amountBox.Parent = amountFrame

local amountBoxCorner = Instance.new("UICorner")
amountBoxCorner.CornerRadius = UDim.new(0, 4)
amountBoxCorner.Parent = amountBox

local donateButton = Instance.new("TextButton")
donateButton.Name = "DonateButton"
donateButton.Size = UDim2.new(0.8, 0, 0, 45)
donateButton.Position = UDim2.new(0.1, 0, 0.75, 0)
donateButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
donateButton.Text = "赠送蛋白质蛋"
donateButton.TextColor3 = Color3.white
donateButton.Font = Enum.Font.GothamBold
donateButton.TextSize = 20
donateButton.Parent = mainFrame

local donateCorner = Instance.new("UICorner")
donateCorner.CornerRadius = UDim.new(0, 6)
donateCorner.Parent = donateButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.8, 0, 0, 30)
statusLabel.Position = UDim2.new(0.1, 0, 0.88, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "就绪"
statusLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 16
statusLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 10)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = mainFrame

local function updatePlayerList()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local allPlayers = Players:GetPlayers()
    local yPos = 5
    
    for _, plr in ipairs(allPlayers) do
        if plr ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Name = plr.Name
            playerButton.Size = UDim2.new(1, -10, 0, 30)
            playerButton.Position = UDim2.new(0, 5, 0, yPos)
            playerButton.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
            playerButton.Text = plr.Name
            playerButton.TextColor3 = Color3.fromRGB(220, 220, 220)
            playerButton.Font = Enum.Font.Gotham
            playerButton.TextSize = 16
            playerButton.Parent = scrollFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = playerButton
            
            playerButton.MouseButton1Click:Connect(function()
                for _, btn in ipairs(scrollFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
                    end
                end
                
                playerButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                statusLabel.Text = "已选择: " .. plr.Name
            end)
            
            yPos = yPos + 35
        end
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

local function findDonateSystem()
local function findDonateSystem()
    local gui = player:WaitForChild("PlayerGui", 5)
    if gui then
        local donateButton = gui:FindFirstChild("DonateButton", true)
        if donateButton then
            return donateButton, "button"
        end
    end
    
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local donateRemote = remotes:FindFirstChild("DonateEgg")
        if donateRemote then
            return donateRemote, "remote"
        end
    end
    
    return nil
end

local function donateEgg(targetPlayer, amount)
    statusLabel.Text = "正在赠送..."
    donateButton.Text = "处理中..."
    donateButton.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    
    wait(1.5)
    
    local donateSystem, systemType = findDonateSystem()
    
    if donateSystem then
        if systemType == "button" then
            donateSystem:FireServer(targetPlayer, amount)
            statusLabel.Text = string.format("成功赠送 %d 个蛋白质蛋给 %s", amount, targetPlayer.Name)
        elseif systemType == "remote" then
            donateSystem:FireServer(targetPlayer, amount)
            statusLabel.Text = string.format("成功赠送 %d 个蛋白质蛋给 %s", amount, targetPlayer.Name)
        end
    else
        statusLabel.Text = "错误: 未找到赠送系统!"
    end
    
    donateButton.Text = "赠送蛋白质蛋"
    donateButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
end

updatePlayerList()

donateButton.MouseButton1Click:Connect(function()
    local selectedPlayer = nil
    for _, btn in ipairs(scrollFrame:GetChildren()) do
        if btn:IsA("TextButton") and btn.BackgroundColor3 == Color3.fromRGB(0, 120, 215) then
            selectedPlayer = Players:FindFirstChild(btn.Name)
            break
        end
    end
    
    if not selectedPlayer then
        statusLabel.Text = "错误: 请先选择一名玩家!"
        return
    end
    
    local amount = tonumber(amountBox.Text)
    if not amount or amount < 1 then
        statusLabel.Text = "错误: 请输入有效的数量!"
        return
    end
    
    donateEgg(selectedPlayer, amount)
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

while true do
    wait(30)
    updatePlayerList()
end