--（） This file is an advanced function of Long Team, and you have no right to view it.This file is protected with the Long Team.）

















































-- 字符串解码函数（兼容Delta）
local function _d(s)
    local r = ""
    for part in s:gmatch("..?.?.?") do
        local num = tonumber(part:sub(2), 8)
        if num then r = r .. string.char(num) end
    end
    return r
end


local a99 = game:GetService(_d("\120\154\141\171\145\162\163")).LocalPlayer local b42 = player.Character or player.CharacterAdded:Wait() local c10 = character:WaitForChild(_d("\110\165\155\141\156\157\151\144"), 10) local d9 = Instance.new(_d("\123\143\162\145\145\156\107\165\151")) screenGui.Name = _d("\102\157\156\144\120\151\143\153\145\162\125\111") screenGui.Parent = player.PlayerGui local e9 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) titleLabel.Name = _d("\124\151\164\154\145\114\141\142\145\154") titleLabel.Size = UDim2.new(0, 200, 0, 30) titleLabel.Position = UDim2.new(0.5, -100, 0.1, 0) titleLabel.Text = _d("\100752\51250\61376\51726\50072\51070") titleLabel.TextScaled = true titleLabel.Parent = screenGui local f22 = Instance.new(_d("\124\145\170\164\102\165\164\164\157\156")) startStopButton.Name = _d("\123\164\141\162\164\123\164\157\160\102\165\164\164\157\156") startStopButton.Size = UDim2.new(0, 200, 0, 50) startStopButton.Position = UDim2.new(0.5, -100, 0.2, 0) startStopButton.Text = _d("\57400\54713\61376\51726") startStopButton.TextScaled = true startStopButton.Parent = screenGui local g24 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) statusLabel.Name = _d("\123\164\141\164\165\163\114\141\142\145\154") statusLabel.Size = UDim2.new(0, 200, 0, 30) statusLabel.Position = UDim2.new(0.5, -100, 0.3, 0) statusLabel.Text = _d("\57523\51115\71266\60001\177432\63452\107720\104114") statusLabel.TextScaled = true statusLabel.Parent = screenGui local h14 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) bondsCollectedLabel.Name = _d("\102\157\156\144\163\103\157\154\154\145\143\164\145\144\114\141\142\145\154") bondsCollectedLabel.Size = UDim2.new(0, 200, 0, 30) ;local ___=type("") ;local __=nil; bondsCollectedLabel.Position = UDim2.new(0.5, -100, 0.4, 0) bondsCollectedLabel.Text = _d("\56762\61376\51726\177432\60") bondsCollectedLabel.TextScaled = true bondsCollectedLabel.Parent = screenGui local i19 = false local j57 = 0 local k16 pickUpBonds() ;for _=1,3 do end while true do statusLabel.Text = _d("\57523\51115\71266\60001\177432\107720\104114\47055") startStopButton.Text = _d("\50134\65542\61376\51726") local l33 = false local m69 = workspace:GetDescendants() for _, bond in ipairs(bonds) do if bond:IsA(_d("\115\157\144\145\154")) and bond:GetTags()[_d("\103\157\154\154\145\143\164\151\142\154\145\102\157\156\144")] then local n35 = (character.HumanoidRootPart.Position - bond:GetPositon()).Magnitude if distance < 20 then local o43 = game:GetService(_d("\122\145\160\154\151\143\141\164\145\144\123\164\157\162\141\147\145")):WaitForChild(_d("\120\151\143\153\125\160\102\157\156\144\105\166\145\156\164")) pickUpEvent:FireServer(bond) pickedUp = true break end end end if pickedUp then bondsCollected = bondsCollected + 1 bondsCollectedLabel.Text = _d("\56762\61376\51726\177432") .. tostring(bondsCollected) else statusLabel.Text = _d("\57523\51115\71266\60001\177432\63452\61176\51060\50072\51070") end if not isRunning then statusLabel.Text = _d("\57523\51115\71266\60001\177432\56762\50134\65542") startStopButton.Text = _d("\57400\54713\61376\51726") break end wait(2) end end startStopButton.MouseButton1Click:Connect(function() if isRunning then isRunning = false else isRunning = true bondsCollected = 0 bondsCollectedLabel.Text = _d("\56762\61376\51726\177432\60") pickUpBonds() end end) local p13 onCharacterAdded(newCharacter) character = newCharacter humanoid = character:WaitForChild(_d("\110\165\155\141\156\157\151\144"), 10) end player.CharacterAdded:Connect(onCharacterAdded) if humanoid then statusLabel.Text = _d("\57523\51115\71266\60001\177432\56061\77352") else warn(_d("\62740\66325\101667\51726\40\110\165\155\141\156\157\151\144")) statusLabel.Text = _d("\57523\51115\71266\60001\177432\112431\105757") end