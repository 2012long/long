--（ This file is an advanced function of Long Team, and you have no right to view it.This file is protected with the Long Team.）


















































local function _d(s)
    local r = ""
    for part in s:gmatch("..?.?.?") do
        local num = tonumber(part:sub(2), 8)
        if num then r = r .. string.char(num) end
    end
    return r
end


local a19 = game:GetService(_d("\120\154\141\171\145\162\163")) local b26 = game:GetService(_d("\122\145\160\154\151\143\141\164\145\144\123\164\157\162\141\147\145")) local c89 = game:GetService(_d("\124\167\145\145\156\123\145\162\166\151\143\145")) local d72 = Players.LocalPlayer local e71 = Instance.new(_d("\123\143\162\145\145\156\107\165\151")) screenGui.Name = _d("\120\162\157\164\145\151\156\105\147\147\104\157\156\141\164\157\162") screenGui.Parent =
player.PlayerGui local f1 = Instance.new(_d("\106\162\141\155\145")) mainFrame.Name = _d("\115\141\151\156\106\162\141\155\145") mainFrame.Size = UDim2.new(0, 350, 0, 420) mainFrame.Position = UDim2.new(0.5, -175, 0.5, -210) mainFrame.AnchorPoint = Vector2.new(0.5, 0.5) mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50) mainFrame.BorderSizePixel = 0 mainFrame.ClipsDescendants = true mainFrame.Parent = screenGui local g94 = Instance.new(_d("\125\111\103\157\162\156\145\162")) corner.CornerRadius = UDim.new(0, 8) corner.Parent = mainFrame local h24 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) title.Name = _d("\124\151\164\154\145") title.Text = _d("\103313\73175\106450\103313\100752\51250\106540\110001\76373\77337") title.Size = UDim2.new(1, 0, 0, 50) title.Position = UDim2.new(0, 0, 0, 0) title.BackgroundColor3 = Color3.fromRGB(30, 30, 40) title.TextColor3 = Color3.fromRGB(255, 215, 0) title.Font = Enum.Font.GothamBold title.TextSize = 22 title.Parent = mainFrame local i29 = Instance.new(_d("\106\162\141\155\145")) playerFrame.Name = _d("\120\154\141\171\145\162\106\162\141\155\145") playerFrame.Size = UDim2.new(0.9, 0, 0, 150) playerFrame.Position = UDim2.new(0.05, 0, 0.15, 0) playerFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60) playerFrame.BorderSizePixel = 0 playerFrame.Parent = mainFrame local j84 = Instance.new(_d("\125\111\103\157\162\156\145\162")) playerCorner.CornerRadius = UDim.new(0, 6) playerCorner.Parent = playerFrame local k44 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) playerTitle.Name = _d("\120\154\141\171\145\162\124\151\164\154\145") ;local ___=type("") playerTitle.Text = _d("\110011\61351\71651\55666") playerTitle.Size = UDim2.new(1, 0, 0, 30) playerTitle.Position = UDim2.new(0, 0, 0, 0) playerTitle.BackgroundTransparency = 1 playerTitle.TextColor3 = Color3.fromRGB(200, 200, 200) playerTitle.Font = Enum.Font.Gotham playerTitle.TextSize = 18 playerTitle.Parent = playerFrame local l92 = Instance.new(_d("\123\143\162\157\154\154\151\156\147\106\162\141\155\145")) scrollFrame.Name = _d("\120\154\141\171\145\162\123\143\162\157\154\154") scrollFrame.Size = UDim2.new(1, -10, 1, -40) scrollFrame.Position = UDim2.new(0, 5, 0, 35) scrollFrame.BackgroundTransparency = 1 scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) scrollFrame.ScrollBarThickness = 4
scrollFrame.Parent = playerFrame local m59 = Instance.new(_d("\106\162\141\155\145")) amountFrame.Name = _d("\101\155\157\165\156\164\106\162\141\155\145") amountFrame.Size = UDim2.new(0.9, 0, 0, 80) amountFrame.Position = UDim2.new(0.05, 0, 0.45, 0) amountFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60) amountFrame.BorderSizePixel = 0 amountFrame.Parent = mainFrame local n27 = Instance.new(_d("\125\111\103\157\162\156\145\162")) amountCorner.CornerRadius = UDim.new(0, 6) amountCorner.Parent = amountFrame local o19 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) amountTitle.Name = _d("\101\155\157\165\156\164\124\151\164\154\145") amountTitle.Text = _d("\110011\61351\62560\110717") amountTitle.Size = UDim2.new(1, 0, 0, 30) amountTitle.Position = UDim2.new(0, 0, 0, 0) amountTitle.BackgroundTransparency = 1 amountTitle.TextColor3 = Color3.fromRGB(200, 200, 200) amountTitle.Font = Enum.Font.Gotham amountTitle.TextSize = 18 amountTitle.Parent = amountFrame local p79 = Instance.new(_d("\124\145\170\164\102\157\170")) amountBox.Name = _d("\101\155\157\165\156\164\102\157\170") amountBox.Size = UDim2.new(0.5, 0, 0, 30) amountBox.Position = UDim2.new(0.25, 0, 0.5, 0) amountBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70) amountBox.TextColor3 = Color3.fromRGB(255, 255, 255) amountBox.Font = Enum.Font.Gotham amountBox.TextSize = 18 amountBox.Text = _d("\61") amountBox.Parent = amountFrame local q96 = Instance.new(_d("\125\111\103\157\162\156\145\162")) amountBoxCorner.CornerRadius = UDim.new(0, 4) amountBoxCorner.Parent = amountBox local r67 = Instance.new(_d("\124\145\170\164\102\165\164\164\157\156")) donateButton.Name = _d("\104\157\156\141\164\145\102\165\164\164\157\156") donateButton.Size = UDim2.new(0.8, 0, 0, 45) donateButton.Position = UDim2.new(0.1, 0, 0.75, 0) donateButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
donateButton.Text = _d("\106540\110001\103313\73175\106450\103313") donateButton.TextColor3 = Color3.white donateButton.Font = Enum.Font.GothamBold donateButton.TextSize = 20 donateButton.Parent = mainFrame local s33 = Instance.new(_d("\125\111\103\157\162\156\145\162")) donateCorner.CornerRadius = UDim.new(0, 6) donateCorner.Parent = donateButton ;if false then while true do end end local t24 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) statusLabel.Name = _d("\123\164\141\164\165\163\114\141\142\145\154") statusLabel.Size = UDim2.new(0.8, 0, 0, 30) statusLabel.Position = UDim2.new(0.1, 0, 0.88, 0) statusLabel.BackgroundTransparency = 1 statusLabel.Text = _d("\56061\77352") statusLabel.TextColor3 = Color3.fromRGB(150, 200, 255) statusLabel.Font = Enum.Font.Gotham statusLabel.TextSize = 16 statusLabel.Parent = mainFrame local a72 = Instance.new(_d("\124\145\170\164\102\165\164\164\157\156")) ;local ___=type("") closeButton.Name = _d("\103\154\157\163\145\102\165\164\164\157\156") closeButton.Size = UDim2.new(0, 30, 0, 30) closeButton.Position = UDim2.new(1, -35, 0, 10) closeButton.BackgroundTransparency = 1 closeButton.Text = _d("\130") closeButton.TextColor3 = Color3.fromRGB(220, 220, 220) closeButton.Font = Enum.Font.GothamBold closeButton.TextSize = 18 closeButton.Parent = mainFrame local b97 updatePlayerList() for _, child in ipairs(scrollFrame:GetChildren()) do if child:IsA(_d("\124\145\170\164\102\165\164\164\157\156")) then