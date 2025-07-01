local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local MoneyStat = "Money"

local TRUCK_LOCATIONS = {
    {
        name = "矿山",
        position = Vector3.new(120, 5, -80),
        color = Color3.fromRGB(150, 100, 50)
    },
    {
        name = "港口",
        position = Vector3.new(-200, 5, 300),
        color = Color3.fromRGB(0, 150, 200)
    },
    {
        name = "工厂",
        position = Vector3.new(350, 5, 150),
        color = Color3.fromRGB(200, 100, 0)
    },
    {
        name = "仓库",
        position = Vector3.new(-100, 5, -250),
        color = Color3.fromRGB(100, 100, 150)
    }
}

local TRUCK_EVENT_NAME = "TruckEvent"

local truckActive = false
local currentLocationIndex = 1
local truckModel = nil

local function createTruckModel(position)
    if truckModel then
        truckModel:Destroy()
    end
    
    truckModel = Instance.new("Model")
    truckModel.Name = "MoneyTruck"
    
    local chassis = Instance.new("Part")
    chassis.Name = "Chassis"
    chassis.Size = Vector3.new(6, 2, 12)
    chassis.Position = position
    chassis.Anchored = true
    chassis.CanCollide = true
    chassis.Color = Color3.fromRGB(50, 50, 50)
    chassis.Material = Enum.Material.Metal
    chassis.Parent = truckModel
    
    local cabin = Instance.new("Part")
    cabin.Name = "Cabin"
    cabin.Size = Vector3.new(4, 3, 4)
    cabin.Position = position + Vector3.new(0, 2.5, -3)
    cabin.Anchored = true
    cabin.CanCollide = true
    cabin.Color = Color3.fromRGB(30, 100, 200)
    cabin.Material = Enum.Material.Metal
    cabin.Parent = truckModel
    
    local cargo = Instance.new("Part")
    cargo.Name = "Cargo"
    cargo.Size = Vector3.new(5, 3, 6)
    cargo.Position = position + Vector3.new(0, 2.5, 3)
    cargo.Anchored = true
    cargo.CanCollide = true
    cargo.Color = Color3.fromRGB(200, 150, 50)
    cargo.Material = Enum.Material.Metal
    cargo.Parent = truckModel
    
    local wheelPositions = {
        Vector3.new(-2.5, -1, -4),
        Vector3.new(2.5, -1, -4),
        Vector3.new(-2.5, -1, 4),
        Vector3.new(2.5, -1, 4)
    }
    
    for i, pos in ipairs(wheelPositions) do
        local wheel = Instance.new("Part")
        wheel.Name = "Wheel"..i
        wheel.Size = Vector3.new(1.5, 1.5, 1.5)
        wheel.Position = position + pos
        wheel.Shape = Enum.PartType.Cylinder
        wheel.Orientation = Vector3.new(0, 0, 90)
        wheel.Anchored = true
        wheel.CanCollide = true
        wheel.Color = Color3.fromRGB(20, 20, 20)
        wheel.Material = Enum.Material.Metal
        wheel.Parent = truckModel
    end
    
    local moneyParticle = Instance.new("ParticleEmitter")
    moneyParticle.Name = "MoneyParticle"
    moneyParticle.Parent = cargo
    moneyParticle.Color = ColorSequence.new(Color3.new(1, 1, 0))
    moneyParticle.Size = NumberSequence.new(0.5)
    moneyParticle.Transparency = NumberSequence.new(0.5)
    moneyParticle.Lifetime = NumberRange.new(1, 2)
    moneyParticle.Rate = 20
    moneyParticle.Speed = NumberRange.new(2)
    moneyParticle.SpreadAngle = Vector2.new(45, 45)
    moneyParticle.Shape = Enum.ParticleEmitterShape.Box
    moneyParticle.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    moneyParticle.Enabled = false
    
    truckModel.Parent = workspace
    
    return truckModel
end

local function callTruckEvent(action, location)
    local event = ReplicatedStorage:FindFirstChild(TRUCK_EVENT_NAME)
    if event then
        event:FireServer(action, location)
    end
end

local function nextLocation()
    currentLocationIndex = currentLocationIndex % #TRUCK_LOCATIONS + 1
    return TRUCK_LOCATIONS[currentLocationIndex]
end

local function createTechUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MoneyHackUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local glowStroke = Instance.new("UIStroke")
    glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glowStroke.Color = Color3.fromRGB(0, 150, 255)
    glowStroke.Thickness = 2
    glowStroke.Transparency = 0.3
    glowStroke.Parent = mainFrame
    
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 25, 45)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Position = UDim2.new(0.5, -100, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "卡车刷钱控制面板"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Font = Enum.Font.SciFi
    title.TextSize = 20
    title.TextStrokeTransparency = 0.8
    title.Parent = titleBar
    
    local statusIndicator =
    Instance.new("Frame")
    statusIndicator.Name = "StatusIndicator"
    statusIndicator.Size = UDim2.new(0, 12, 0, 12)
    statusIndicator.Position = UDim2.new(0, 15, 0.5, -6)
    statusIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    statusIndicator.BorderSizePixel = 0
    statusIndicator.Parent = titleBar
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = statusIndicator
    
    local statusText = Instance.new("TextLabel")
    statusText.Name = "StatusText"
    statusText.Size = UDim2.new(0, 100, 0, 20)
    statusText.Position = UDim2.new(0, 35, 0.5, -10)
    statusText.BackgroundTransparency = 1
    statusText.Text = "未启动"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.Font = Enum.Font.Code
    statusText.TextSize = 14
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = titleBar
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -130)
    contentFrame.Position = UDim2.new(0, 10, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "InfoLabel"
    infoLabel.Size = UDim2.new(1, 0, 0, 60)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "每次操作增加$10,000\n\n选择开始按钮激活卡车刷钱功能\n卡车将在不同地点之间移动"
    infoLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    infoLabel.Font = Enum.Font.Code
    infoLabel.TextSize = 16
    infoLabel.TextWrapped = true
    infoLabel.Parent = contentFrame
    
    local locationFrame = Instance.new("Frame")
    locationFrame.Name = "LocationFrame"
    locationFrame.Size = UDim2.new(1, 0, 0, 30)
    locationFrame.Position = UDim2.new(0, 0, 0, 70)
    locationFrame.BackgroundTransparency = 1
    locationFrame.Parent = contentFrame
    
    local locationLabel = Instance.new("TextLabel")
    locationLabel.Name = "LocationLabel"
    locationLabel.Size = UDim2.new(0, 80, 1, 0)
    locationLabel.BackgroundTransparency = 1
    locationLabel.Text = "当前地点:"
    locationLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
    locationLabel.Font = Enum.Font.Code
    locationLabel.TextSize = 14
    locationLabel.TextXAlignment = Enum.TextXAlignment.Left
    locationLabel.Parent = locationFrame
    
    local locationText = Instance.new("TextButton")
    locationText.Name = "LocationText"
    locationText.Size = UDim2.new(0, 150, 0.8, 0)
    locationText.Position = UDim2.new(0, 85, 0.1, 0)
    locationText.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
    locationText.Text = "矿山"
    locationText.TextColor3 = Color3.fromRGB(150, 100, 50)
    locationText.Font = Enum.Font.SciFi
    locationText.TextSize = 16
    locationText.Parent = locationFrame
    
    local locationCorner = Instance.new("UICorner")
    locationCorner.CornerRadius = UDim.new(0, 6)
    locationCorner.Parent = locationText
    
    local locationGlow = Instance.new("UIStroke")
    locationGlow.Color = Color3.fromRGB(0, 150, 255)
    locationGlow.Thickness = 1
    locationGlow.Transparency = 0.5
    locationGlow.Parent = locationText
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name =
    "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 0, 50)
    buttonContainer.Position = UDim2.new(0, 0, 1, -50)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = contentFrame
    
    local startButton = Instance.new("TextButton")
    startButton.Name = "StartButton"
    startButton.Size = UDim2.new(0, 120, 0, 40)
    startButton.Position = UDim2.new(0, 30, 0, 0)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    startButton.Text = "启动卡车"
    startButton.TextColor3 = Color3.fromRGB(200, 255, 200)
    startButton.Font = Enum.Font.SciFi
    startButton.TextSize = 18
    startButton.Parent = buttonContainer
    
    local startCorner = Instance.new("UICorner")
    startCorner.CornerRadius = UDim.new(0, 8)
    startCorner.Parent = startButton
    
    local startGlow = Instance.new("UIStroke")
    startGlow.Color = Color3.fromRGB(0, 255, 150)
    startGlow.Thickness = 1
    startGlow.Transparency = 0.7
    startGlow.Parent = startButton
    
    local stopButton = Instance.new("TextButton")
    stopButton.Name = "StopButton"
    stopButton.Size = UDim2.new(0, 120, 0, 40)
    stopButton.Position = UDim2.new(1, -150, 0, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(100, 0, 30)
    stopButton.Text = "停止卡车"
    stopButton.TextColor3 = Color3.fromRGB(255, 200, 200)
    stopButton.Font = Enum.Font.SciFi
    stopButton.TextSize = 18
    stopButton.Parent = buttonContainer
    
    local stopCorner = Instance.new("UICorner")
    stopCorner.CornerRadius = UDim.new(0, 8)
    stopCorner.Parent = stopButton
    
    local stopGlow = Instance.new("UIStroke")
    stopGlow.Color = Color3.fromRGB(255, 50, 100)
    stopGlow.Thickness = 1
    stopGlow.Transparency = 0.7
    stopGlow.Parent = stopButton
    
    local truckActionFrame = Instance.new("Frame")
    truckActionFrame.Name = "TruckActionFrame"
    truckActionFrame.Size = UDim2.new(1, 0, 0, 40)
    truckActionFrame.Position = UDim2.new(0, 0, 0, 110)
    truckActionFrame.BackgroundTransparency = 1
    truckActionFrame.Parent = contentFrame
    
    local collectButton = Instance.new("TextButton")
    collectButton.Name = "CollectButton"
    collectButton.Size = UDim2.new(0.4, 0, 1, 0)
    collectButton.BackgroundColor3 = Color3.fromRGB(0, 80, 120)
    collectButton.Text = "收集金钱"
    collectButton.TextColor3 = Color3.fromRGB(180, 230, 255)
    collectButton.Font = Enum.Font.SciFi
    collectButton.TextSize = 16
    collectButton.Parent = truckActionFrame
    
    local collectCorner = Instance.new("UICorner")
    collectCorner.CornerRadius = UDim.new(0, 6)
    collectCorner.Parent = collectButton
    
    local moveButton = Instance.new("TextButton")
    moveButton.Name = "MoveButton"
    moveButton.Size = UDim2.new(0.4, 0, 1, 0)
    moveButton.Position = UDim2.new(0.6, 0, 0, 0)
    moveButton.BackgroundColor3 = Color3.fromRGB(120, 80, 0)
    moveButton.Text = "移动卡车"
    moveButton.TextColor3 = Color3.fromRGB(255, 230, 180)
    moveButton.Font = Enum.Font.SciFi
    moveButton.TextSize = 16
    moveButton.Parent = truckActionFrame
    
    local moveCorner = Instance.new("UICorner")
    moveCorner.CornerRadius = UDim.new(0, 6)
    moveCorner.Parent = moveButton
    
    local scanLine = Instance.new("Frame")
    scanLine.Name = "ScanLine"
    scanLine.Size = UDim2.new(1, 0, 0, 2)
    scanLine.Position = UDim2.new(0, 0, 0, 0)
    scanLine.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    scanLine.BorderSizePixel = 0
    scanLine.Visible = false
    scanLine.Parent = mainFrame
    
    local truckMarker = Instance.new("Frame")
    truckMarker.Name = "TruckMarker"
    truckMarker.Size = UDim2.new(0, 20, 0, 20)
    truckMarker.AnchorPoint = Vector2.new(0.5, 0.5)
    truckMarker.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    truckMarker.BackgroundTransparency = 0.5
    truckMarker.BorderSizePixel = 0
    truckMarker.Visible = false
    truckMarker.Parent = screenGui
    
    local markerCorner = Instance.new("UICorner")
    markerCorner.CornerRadius = UDim.new(1, 0)
    markerCorner.Parent = truckMarker
    
    local markerGlow = Instance.new("UIStroke")
    markerGlow.Color = Color3.fromRGB(255, 255, 0)
    markerGlow.Thickness = 2
    markerGlow.Transparency = 0.3
    markerGlow.Parent = truckMarker
    
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        statusIndicator = statusIndicator,
        statusText = statusText,
        startButton = startButton,
        stopButton = stopButton,
        scanLine = scanLine,
        truckMarker = truckMarker,
        locationText = locationText,
        collectButton = collectButton,
        moveButton = moveButton
    }
end

local function MoneyExploitManager(ui)
    local manager = {
        active = false,
        hookEnabled = false,
        loopRunning = false,
        originalFunction = nil,
        economySystem = nil,
        loopThread = nil,
        truckThread = nil
    }
    
    local function updateStatus(status, color)
        ui.statusIndicator.BackgroundColor3 = color
        ui.statusText.Text = status
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(ui.statusIndicator, tweenInfo, {BackgroundTransparency = 0.3})
        tween:Play()
        
        tween.Completed:Connect(function()
            TweenService:Create(ui.statusIndicator, tweenInfo, {BackgroundTransparency = 0}):Play()
        end)
    end
    
    local function startScanAnimation()
        ui.scanLine.Visible = true
        ui.scanLine.Position = UDim2.new(0, 0, 0, 0)
        
        local tween = TweenService:Create(
            ui.scanLine, 
            TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            {Position = UDim2.new(0, 0, 1, 0)}
        )
        
        tween:Play()
        tween.Completed:Connect(function()
            if manager.active then
                startScanAnimation()
            else
                ui.scanLine.Visible = false
            end
        end)
    end
    
    local function updateTruckMarker()
        if truckModel and truckModel:FindFirstChild("Chassis") then
            local chassis = truckModel.Chassis
            local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(chassis.Position)
            
            if onScreen then
                ui.truckMarker.Visible = true
                ui.truckMarker.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)
            else
                ui.truckMarker.Visible = false
            end
        else
            ui.truckMarker.Visible = false
        end
    end
    
    local function findEconomySystem()
        for _, module in pairs(ReplicatedStorage:GetDescendants()) do
            if module.Name == "EconomyManager" then
                return module
            end
        end
        return nil
    end
    
    local function hookMethod()
        manager.economySystem =
        findEconomySystem()
        if manager.economySystem then
            manager.originalFunction = manager.economySystem.UpdatePlayerStats
            manager.economySystem.UpdatePlayerStats = function(...)
                local args = {...}
                if args[2] == MoneyStat then
                    args[3] = args[3] + 10000
                end
                return manager.originalFunction(unpack(args))
            end
            manager.hookEnabled = true
            return true
        end
        return false
    end
    
    local function loopMethod()
        local remoteEvent = ReplicatedStorage:FindFirstChild("UpdatePlayerData")
        if remoteEvent then
            manager.loopRunning = true
            manager.loopThread = coroutine.create(function()
                while manager.loopRunning do
                    remoteEvent:FireServer({
                        [MoneyStat] = 999999,
                        ["LastUpdated"] = os.time()
                    })
                    wait(0.5)
                end
            end)
            coroutine.resume(manager.loopThread)
            return true
        end
        return false
    end
    
    local function truckMethod()
        manager.truckThread = coroutine.create(function()
            while manager.active do
                local location = TRUCK_LOCATIONS[currentLocationIndex]
            
                if not truckModel or not truckModel.Parent then
                    truckModel = createTruckModel(location.position)
                    truckModel:SetAttribute("Location", location.name)
                   
                    local particle = truckModel:FindFirstChild("MoneyParticle")
                    if particle then
                        particle.Enabled = true
                    end
                end
                
                ui.locationText.Text = location.name
                ui.locationText.TextColor3 = location.color
                
                callTruckEvent("collect", location.name)
              
                wait(3)
                
                local nextLoc = nextLocation()
                callTruckEvent("move", nextLoc.name)
                
                if truckModel then
                    local tweenInfo