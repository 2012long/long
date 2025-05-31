local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Revenant", true))()
Library.DefaultColor = Color3.fromRGB(255,0,0)--滑动线颜色

Library:Notification({
	Text = "有bug找泷",
	Duration = 8
})

Library:Notification({
	Text = "泷脚本持续云更新",
	Duration = 10
})

Library:Notification({
	Text = "泷祝你玩的开心",
	Duration = 12
})

game:GetService("StarterGui"):SetCore("SendNotification",{Title = "泷脚本",Text = "欢迎使用",Icon = "rbxassetid://138406365430405",Duration = 3,Callback = bindable,Button1 = "天天开心",Button2 = "天天快乐"})

game:GetService("StarterGui"):SetCore("SendNotification",{Title = "泷脚本",Text = "要加什么服务器",Icon = "rbxassetid://138406365430405",Duration = 5,Callback = bindable,Button1 = "脚本信息",Button2 = "加我QQ"})

local msg = Instance.new("Message",workspace)
msg.Text = "欢迎使用泷脚本"
wait(1.8)
msg:Destroy()

local msg = Instance.new("Message",workspace)
msg.Text = "作者名字"
wait(1.8)
msg:Destroy()

local msg = Instance.new("Message",workspace)
msg.Text = "long2012qw2"
wait(1.8)
msg:Destroy()

local msg = Instance.new("Message",workspace)
msg.Text = "泷脚本群号"
wait(1.8)
msg:Destroy()

local msg = Instance.new("Message",workspace)
msg.Text = "929573644"
wait(1.8)
msg:Destroy()

local msg = Instance.new("Message",workspace)
msg.Text = "祝你玩得开心，玩得愉快"
wait(1.8)
msg:Destroy()

if getgenv().ED_AntiKick then
	return
end

getgenv().ED_AntiKick = {
	Enabled = true, -- Set to false if you want to disable the Anti-Kick.
	SendNotifications = true, -- Set to true if you want to get notified for every event
	CheckCaller = true -- Set to true if you want to disable kicking by other executed scripts
}
local dropdown = {}
local playernamedied = ""

for i, player in pairs(game.Players:GetPlayers()) do
    dropdown[i] = player.Name
end

function Notify(top, text, ico, dur)
  game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = top,
    Text = text,
    Icon = ico,
    Duration = dur,
  })
end

local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
    LastIteration = tick()
    for Index = #FrameUpdateTable, 1, -1 do
        FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
    end
    FrameUpdateTable[1] = LastIteration
    local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
    CurrentFPS = CurrentFPS - CurrentFPS % 1
    FpsLabel.Text = ("泷时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local FpsGui = Instance.new("ScreenGui") local FpsXS = Instance.new("TextLabel") FpsGui.Name = "FPSGui" FpsGui.ResetOnSpawn = false FpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling FpsXS.Name = "FpsXS" FpsXS.Size = UDim2.new(0, 100, 0, 50) FpsXS.Position = UDim2.new(0, 10, 0, 10) FpsXS.BackgroundTransparency = 1 FpsXS.Font = Enum.Font.SourceSansBold FpsXS.Text = "帧率: 0" FpsXS.TextSize = 20 FpsXS.TextColor3 = Color3.new(1, 1, 1) FpsXS.Parent = FpsGui function updateFpsXS() local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait()) FpsXS.Text = "帧率: " .. fps end game:GetService("RunService").RenderStepped:Connect(updateFpsXS) FpsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local xiaoyiui = loadstring(game:HttpGet("https://raw.githubusercontent.com/JY6812/UI/refs/heads/main/81.lua"))()     
local win = xiaoyiui:new("泷脚本")
--
local UITab1 = win:Tab("『信息』",'16060333448')

local about = UITab1:section("『泷脚本』",true)

about:Label("泷脚本")
about:Label("作者：泷")

local about = UITab2:section("『付费功能专区』",true)
about:Button("火箭发射模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E7%81%AB%E7%AE%AD.lua", true))()
end)

about:Button("Doors", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/doors.lua", true))()
end)

about:Button("伐木大亨2", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E4%BC%90%E6%9C%A8.lua", true))()
end)

about:Button("俄亥俄州", function()

 loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E4%BF%84%E4%BA%A5%E4%BF%84%E5%B7%9E.lua", true))()
end)

about:Button("力量传奇", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E5%8A%9B%E9%87%8F.lua", true))()
end)

about:Button("河北唐县", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E5%94%90%E5%8E%BF.lua", true))()
end)

about:Button("loadstring(game:HttpGet("https://raw.githubusercontent.com/2012long/long/refs/heads/main/%E6%9F%94%E6%9C%AF.lua", true))()", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)