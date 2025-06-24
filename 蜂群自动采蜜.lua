local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local config = {
    checkInterval = 1.5,          -- 状态检测间隔(秒)
    collectionRadius = 25,        -- 采蜜随机移动半径
    convertTime = 4,              -- 酿蜜所需时间(秒)
    enableAutoUpgrade = true,     -- 是否自动升级背包
    debugMode = true,             -- 显示调试信息
    hiveDetectionRange = 100,     -- 蜂巢检测范围
    eventMode = "RemoteEvent"     -- 事件模式: "ClickSimulation", "RemoteEvent" 或 "Proximity"
}

local honeyFields = {
    -- 名称               坐标                 最低容量  花蜜类型
    {name = "新手草地",   pos = Vector3.new(42, 4, 18),    capacity = 0,   color = "Blue"},
    {name = "草莓田",     pos = Vector3.new(-45, 3, 138),  capacity = 5,   color = "Red"},
    {name = "向日葵园",   pos = Vector3.new(195, 6, 75),   capacity = 10,  color = "Yellow"},
    {name = "蓝莓丛",     pos = Vector3.new(-203, 5, -82), capacity = 15,  color = "Blue"},
    {name = "仙人掌地",   pos = Vector3.new(248, 7, -175), capacity = 20,  color = "Green"},
    {name = "蘑菇林",     pos = Vector3.new(-95, 4, -195), capacity = 25,  color = "Purple"},
    {name = "菠萝园",     pos = Vector3.new(305, 5, 110),  capacity = 30,  color = "Orange"},
    {name = "竹林",       pos = Vector3.new(-295, 6, 55),  capacity = 35,  color = "White"},
    {name = "蜘蛛洞",     pos = Vector3.new(110, 8, -290), capacity = 40,  color = "Black"}
}

local function debugPrint(msg)
    if config.debugMode then
        print("[🐝 自动采蜜] "..msg)
    end
end

-- 获取玩家背包信息
local function getBackpackInfo()
    local backpack = LocalPlayer:FindFirstChild("Backpack") or 
                     Character:FindFirstChild("Backpack") or
                     LocalPlayer:FindFirstChild("HoneyStorage")
    
    if backpack then
        local current = backpack:FindFirstChild("HoneyAmount") or 
                        backpack:FindFirstChild("Amount") or
                        backpack:FindFirstChild("CurrentHoney")
        
        local capacity = backpack:FindFirstChild("Capacity") or 
                         backpack:FindFirstChild("MaxHoney") or
                         backpack:FindFirstChild("MaxAmount")
        
        return {
            current = current and current.Value or 0,
            capacity = capacity and capacity.Value or 0
        }
    end
    return {current = 0, capacity = 0}
end

-- 检查背包是否已满
local function isBackpackFull()
    local backpack = getBackpackInfo()
    return backpack.current >= backpack.capacity
end

-- 动态选择最佳采蜜区域
local function selectOptimalField()
    local currentCapacity = getBackpackInfo().capacity
    local bestField = honeyFields[1]
    
    -- 智能选择逻辑
    for _, field in ipairs(honeyFields) do
        if (field.capacity <= currentCapacity + 5) and 
           (field.capacity > bestField.capacity) then
            bestField = field
        end
    end
    
    debugPrint("选择 "..bestField.color.."花蜜区域: "..bestField.name)
    return bestField
end

-- ===== 游戏事件适配系统 =====
local Events = {
    -- 采集事件（根据游戏实际事件调整）
    Collect = {
        RemoteEvent = function(color)
            local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if events then
                local collectEvent = events:FindFirstChild("CollectHoney") or
                                    events:FindFirstChild("GatherHoney") or
                                    events:FindFirstChild("CollectFlower")
                
                if collectEvent then
                    collectEvent:FireServer(color)
                    return true
                end
            end
            return false
        end,
        
        ClickSimulation = function()
            -- 模拟点击采集
            local flower = findNearestFlower()
            if flower t-- 实际游戏中可能需要触发点击事件
                fireclickdetector(flower:FindFirstChild("ClickDetector"))
                return true
            end
            return false
        end
    },
    
    -- 酿蜜事件（根据游戏实际事件调整）
    Convert = {
        RemoteEvent = function()
            local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if events then
                local convertEvent = events:FindFirstChild("ConvertHoney") or
                                     events:FindFirstChild("MakeHoney") or
                                     events:FindFirstChild("ProcessHoney")
                
                if convertEvent then
                    convertEvent:FireServer()
                    return true
                end
            end
            return false
        end,
        
        ClickSimulation = function()
            -- 模拟点击蜂巢
            local hive = findPlayerHiveObject()
            if hive then
                -- 实际游戏中可能需要触发点击事件
                fireclickdetector(hive:FindFirstChild("ClickDetector"))
                return true
            end
            return false
        end,
        
        Proximity = function()
            -- 靠近蜂巢自动触发
            local hivePos = findPlayerHive()
            local distance = (Character.HumanoidRootPart.Position - hivePos).Magnitude
            return distance < 10
        end
    },
    
    -- 传送回蜂巢事件
    TeleportToHive = {
        RemoteEvent = function()
            local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if events then
                local teleEvent = events:FindFirstChild("TeleportToHive") or
                                  events:FindFirstChild("GoToHive") or
                                  events:FindFirstChild("ReturnToHive")
                
                if teleEvent then
                    teleEvent:FireServer()
                    return true
                end
            end
            return false
        end,
        
        MenuSelection = function()
            -- 模拟打开菜单选择传送
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.M, false, nil)
            wait(0.2)
            -- 模拟选择蜂巢传送按钮（需要根据实际UI调整）
            return true
        end
    }
}

-- 触发游戏事件（带后备机制）
local function triggerEvent(eventType, ...)
    -- 尝试首选方式
    if Events[eventType] and Events[eventType][config.eventMode] then
        if Events[eventType][config.eventMode](...) then
            return true
        end
    end
    
    -- 后备方案：尝试其他可用方式
    for mode, func in pairs(Events[eventType]) do
        if mode ~= config.eventMode and type(func) == "function" then
            if func(...) then
                debugPrint("使用后备"..mode.."模式触发"..eventType)
                return true
            end
        end
    end
    
    debugPrint("⚠️ 无法触发"..eventType.."事件")
    return false
    end
            -- ===== 蜂巢定位系统 =====
local function findPlayerHiveObject()
    -- 方法1：查找玩家拥有的蜂巢对象
    local playerHives = workspace:FindFirstChild("PlayerHives") or workspace
    for _, hive in ipairs(playerHives:GetChildren()) do
        if hive:FindFirstChild("Owner") and hive.Owner.Value == LocalPlayer then
            return hive
        elseif hive.Name:find(LocalPlayer.Name) then
            return hive
        end
    end
    
    -- 方法2：查找蜂巢模型
    local hiveModel = workspace:FindFirstChild("HiveModel")
    if hiveModel then
        return hiveModel
    end
    
    return nil
end

local function findPlayerHive()
    local hiveObject = findPlayerHiveObject()
    if hiveObject then
        return hiveObject:GetPivot().Position
    end
    
    -- 后备：默认蜂巢位置
    return Vector3.new(15, 5, 25)
end

-- 查找附近花朵
local function findNearestFlower()
    local flowers = workspace:FindFirstChild("Flowers") or workspace
    local closest, minDist = nil, math.huge
    
    for _, flower in ipairs(flowers:GetChildren()) do
        if flower:IsA("Model") and flower:FindFirstChild("FlowerType") then
            local dist = (Character.HumanoidRootPart.Position - flower:GetPivot().Position).Magnitude
            if dist < minDist then
                closest = flower
                minDist = dist
            end
        end
    end
    
    return closest
end

-- ===== 采集系统 =====
local collectionActive = false
local function startCollection(fieldData)
    if collectionActive then return end
    collectionActive = true
    
    coroutine.wrap(function()
        while collectionActive do
            -- 随机移动采集
            local moveDir = Vector3.new(math.random(-8, 8), 0, math.random(-8, 8))
            Humanoid:MoveTo(Character.HumanoidRootPart.Position + moveDir)
            
            -- 触发采集事件
            if not triggerEvent("Collect", fieldData.color) then
                -- 后备：直接调用事件
                Events.Collect.RemoteEvent(fieldData.color)
            end
            
            wait(0.5)
        end
    end)()
end

-- ===== 蜂巢处理系统 =====
local function processAtHive()
    debugPrint("正在蜂巢处理蜂蜜...")
    local startTime = tick()
    local processed = false
    
    -- 尝试触发传送事件
    if not triggerEvent("TeleportToHive") then
        -- 后备：直接传送到坐标
        local hivePos = findPlayerHive()
        Character.HumanoidRootPart.CFrame = CFrame.new(hivePos)
        wait(1)
    end
    
    -- 酿蜜处理
    while tick() - startTime < config.convertTime do
        if triggerEvent("Convert") then
            processed = true
        end
        
        -- 随机小幅度移动
        Humanoid:MoveTo(Character.HumanoidRootPart.Position + 
            Vector3.new(math.random(-2, 2), 0, math.random(-2, 2)))
        
        wait(0.5)
    end
    
    -- 背包升级
    if config.enableAutoUpgrade and getBackpackInfo().capacity < 50 then
        debugPrint("尝试升级背包...")
        -- 实际游戏中调用升级事件
        -- game:GetService("ReplicatedStorage").Events.UpgradeBackpack:FireServer()
    end
    
    return processed
    end

local function mainLoop()
    local currentField = selectOptimalField()
    startCollection(currentField)
    
    while true do
        -- 背包状态检测
        if isBackpackFull() then
            collectionActive = false
            debugPrint("蜂蜜已满，返回蜂巢...")
            
            -- 处理蜂巢流程
            if processAtHive() then
                debugPrint("蜂蜜处理完成")
                
                -- 等待背包清空
                while not isBackpackFull() and getBackpackInfo().current > 0 do
                    wait(1)
                end
                
                -- 重新选择采蜜点
                currentField = selectOptimalField()
                startCollection(currentField)
            else
                debugPrint("⚠️ 蜂蜜处理失败，继续尝试")
                collectionActive = true
            end
        end
        
        -- 每30秒重新评估最佳采蜜点
        if tick() % 30 < config.checkInterval then
            local newField = selectOptimalField()
            if newField.name ~= currentField.name then
                currentField = newField
                debugPrint("切换至更优区域: "..currentField.name)
            end
        end
        
        wait(config.checkInterval)
    end
end

local function createControlPanel()
    -- 创建GUI控制面板
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "BeeAutoFarmGUI"
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.8, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Parent = ScreenGui
    
    local title = Instance.new("TextLabel")
    title.Text = "蜂群自动采集系统 V3.0"
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = frame
    
    -- 控制按钮
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Text = "▶ 开始脚本"
    toggleBtn.Size = UDim2.new(0.8, 0, 0, 30)
    toggleBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
    toggleBtn.Parent = frame
    
    -- 事件模式选择
    local modeLabel = Instance.new("TextLabel")
    modeLabel.Text = "事件模式:"
    modeLabel.Size = UDim2.new(0.4, 0, 0, 25)
    modeLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
    modeLabel.TextXAlignment = Enum.TextXAlignment.Left
    modeLabel.BackgroundTransparency = 1
    modeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    modeLabel.Parent = frame
    
    local modeDropdown = Instance.new("TextButton")
    modeDropdown.Text = config.eventMode
    modeDropdown.Size = UDim2.new(0.5, 0, 0, 25)
    modeDropdown.Position = UDim2.new(0.5, 0, 0.45, 0)
    modeDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    modeDropdown.Parent = frame
    
    -- 状态显示
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Text = "状态: 待机"
    statusLabel.Size = UDim2.new(0.8, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.1, 0, 0.65, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame
    
    -- 背包信息
    local backpackLabel = Instance.new("TextLabel")
    backpackLabel.Text = "背包: 0/0"
    backpackLabel.Size = UDim2.new(0.8, 0, 0, 25)
    backpackLabel.Position = UDim2.new(0.1, 0, 0.8, 0)
    backpackLabel.BackgroundTransparency = 1
    backpackLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    backpackLabel.TextXAlignment = Enum.TextXAlignment.Left
    backpackLabel.Parent = frame
    
    -- 按钮功能
    local scriptRunning = false
    toggleBtn.MouseButton1Click:Connect(function()
        scriptRunning = not scriptRunning
        if scriptRunning then
            toggleBtn.Text = " 暂停脚本"
            statusLabel.Text = "状态: 运行中"
            collectionActive = true
        else
            toggleBtn.Text = " 开始脚本"
            statusLabel.Text = "状态: 已暂停"
            collectionActive = false
        end
    end)
    
    -- 模式选择
    local modes = {"RemoteEvent", "ClickSimulation", "Proximity"}
    modeDropdown.MouseButton1Click:Connect(function()
        local currentIndex = table.find(modes, config.eventMode) or 1
        local nextIndex = (currentIndex % #modes) + 1
        config.eventMode = modes[nextIndex]
        modeDropdown.Text = config.eventMode
        debugPrint("切换事件模式: "..config.eventMode)
    end)
    
    -- 实时更新背包信息
    RunService.Heartbeat:Connect(function()
        local backpack = getBackpackInfo()
        backpackLabel.Text = string.format("背包: %d/%d", backpack.current, backpack.capacity)
    end)
end

createControlPanel()
debugPrint("脚本启动 - 事件模式: "..config.eventMode)
mainLoop()