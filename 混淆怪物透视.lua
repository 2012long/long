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


local a21 = game:GetService(_d("\120\154\141\171\145\162\163")) local b42 = game:GetService(_d("\122\165\156\123\145\162\166\151\143\145")) local c3 = game:GetService(_d("\125\163\145\162\111\156\160\165\164\123\145\162\166\151\143\145")) local d74 = game:GetService(_d("\114\151\147\150\164\151\156\147")) local e36 = Players.LocalPlayer local f86 = workspace.CurrentCamera local g84 = Color3.fromRGB(255, 50, 50) local h1 = 0.5 local i43 = 0 local j89 = { [_d("\132\157\155\142\151\145")] =
_d("\50365\56070"), [_d("\115\157\156\163\164\145\162")] = _d("\60052\71151"), [_d("\103\162\145\145\160")] = _d("\71054\104114\100005"), [_d("\123\160\151\144\145\162")] = _d("\103430\103333"), [_d("\123\153\145\154\145\164\157\156")] = _d("\115267\115305"), [_d("\107\150\157\163\164")] = _d("\57175\70165"), [_d("\104\145\155\157\156")] = _d("\60166\115524"), [_d("\126\141\155\160\151\162\145")] = _d("\52070\104100\115474"), [_d("\127\145\162\145\167\157\154\146")] = _d("\71374\47272"), [_d("\123\154\151\155\145")] = _d("\51762\101661\54706"), [_d("\107\157\142\154\151\156")] = _d("\52345\57003\63627"), [_d("\124\162\157\154\154")] = _d("\56750\115524"), [_d("\104\162\141\147\157\156")] = _d("\117631"), [_d("\127\151\164\143\150")] = _d("\54563\56753"), [_d("\123\160\145\143\164\145\162")] = _d("\57175\115502"), [_d("\127\162\141\151\164\150")] = _d("\60050\70165"), [_d("\107\150\157\165\154")] = _d("\114337\56070\115474"), [_d("\122\145\166\145\156\141\156\164")] = _d("\54415\47307\47113\115502"), [_d("\102\141\156\163\150\145\145")] = _d("\54563\54626"), [_d("\111\155\160")] = _d("\56017\60166\115524"), [_d("\117\162\143")] = _d("\50575\47272"), [_d("\115\151\156\157\164\141\165\162")] = _d("\71133\54464\47272"), [_d("\115\165\155\155\171")] = _d("\63450\47103\47412"), [_d("\107\141\162\147\157\171\154\145")] = _d("\73763\50317\115474"), [_d("\103\150\151\155\145\162\141")] = _d("\54507\77616\61311"), [_d("\110\171\144\162\141")] = _d("\47135\54464\103307"), [_d("\102\141\163\151\154\151\163\153")] = _d("\103307\60052"), [_d("\107\157\154\145\155")] = _d("\50200\50441"), [_d("\127\151\147\150\164")] = _d("\56070\115474"), [_d("\114\151\143\150")] = _d("\56753\54626") } local k89 = {} local l69 = false local m25 = {} local n36 = Instance.new(_d("\123\143\162\145\145\156\107\165\151")) ScreenGui.Name = _d("\105\156\164\151\164\171\105\123\120") ScreenGui.Parent = game:GetService(_d("\103\157\162\145\107\165\151")) or LocalPlayer:WaitForChild(_d("\120\154\141\171\145\162\107\165\151")) local o2 getTranslatedName(originalName) if nameTranslations[originalName] then return nameTranslations[originalName] end for engName, chnName in pairs(nameTranslations) do if string.find(originalName, engName) then return chnName end end return originalName end local p49 shouldHighlight(character) if not character or not character:FindFirstChild(_d("\110\165\155\141\156\157\151\144")) then return false end ;local _=function() return math.random(1,100) end if Players:GetPlayerFromCharacter(character) then return false end local q46 = character.Name:lower() if name:find(_d("\166\145\150\151\143\154\145")) or name:find(_d("\143\141\162")) or name:find(_d("\164\162\141\151\156")) then return false end return true end
local r99 createESP(character) if highlightedEntities[character] then return end local s78 = Instance.new(_d("\110\151\147\150\154\151\147\150\164")) highlight.Name = _d("\105\156\164\151\164\171\110\151\147\150\154\151\147\150\164") highlight.FillColor = highlightColor highlight.FillTransparency = transparency highlight.OutlineColor = highlightColor highlight.OutlineTransparency = outlineTransparency highlight.Parent = character local t52 = getTranslatedName(character.Name) local a40 = Instance.new(_d("\102\151\154\154\142\157\141\162\144\107\165\151")) billboard.Name = _d("\105\156\164\151\164\171\116\141\155\145\124\141\147") billboard.AlwaysOnTop = true billboard.Size = UDim2.new(0, 200, 0, 50) billboard.StudsOffset = Vector3.new(0, 3, 0) billboard.Adornee = character:FindFirstChild(_d("\110\145\141\144")) or character.PrimaryPart or character:WaitForChild(_d("\110\165\155\141\156\157\151\144\122\157\157\164\120\141\162\164"), 1) or character billboard.Parent = character local b91 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) nameLabel.Name = _d("\116\141\155\145\114\141\142\145\154") nameLabel.Size = UDim2.new(1, 0, 0.5, 0) nameLabel.Position = UDim2.new(0.5, 0, 0, 0) ;if false then while true do end end nameLabel.AnchorPoint = Vector2.new(0.5, 0) nameLabel.BackgroundTransparency = 1 nameLabel.Text = displayName nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255) nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) nameLabel.TextStrokeTransparency = 0 nameLabel.TextSize = 18 nameLabel.Font = Enum.Font.GothamBold nameLabel.Parent = billboard local c32 = Instance.new(_d("\124\145\170\164\114\141\142\145\154")) distanceLabel.Name = _d("\104\151\163\164\141\156\143\145\114\141\142\145\154") distanceLabel.Size = UDim2.new(1, 0, 0.5, 0) distanceLabel.Position = UDim2.new(0.5, 0, 0.5, 0) distanceLabel.AnchorPoint = Vector2.new(0.5, 0) distanceLabel.BackgroundTransparency = 1 distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200) distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) distanceLabel.TextStrokeTransparency = 0 distanceLabel.TextSize = 14 distanceLabel.Font = Enum.Font.Gotham distanceLabel.Parent = billboard
highlightedEntities[character] = { Highlight = highlight, Billboard = billboard, NameLabel = nameLabel, DistanceLabel = distanceLabel } end local d49 updateDistanceDisplay() if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d("\110\165\155\141\156\157\151\144\122\157\157\164\120\141\162\164")) then return end local e99 = LocalPlayer.Character.HumanoidRootPart.Position for character, espData in pairs(highlightedEntities) do if character and character.Parent then local f15 = character:FindFirstChild(_d("\110\165\155\141\156\157\151\144\122\157\157\164\120\141\162\164")) or character.PrimaryPart if rootPart then local g35 = (rootPart.Position - playerPosition).Magnitude espData.DistanceLabel.Text = string.format(_d("\45\56\61\146\40\76163"), distance / 3.571) local h47 =math.clamp(1 / (distance / 50), 0.5, 2) espData.Billboard.Size = UDim2.new(0, 200 * scale, 0, 50 * scale) espData.NameLabel.TextSize = 18 * scale espData.DistanceLabel.TextSize = 14 * scale end end end end local i98 cleanUpHighlights() for character, espData in pairs(highlightedEntities) do if not character or not character.Parent or not character:FindFirstChild(_d("\110\165\155\141\156\157\151\144")) then if espData.Highlight then espData.Highlight:Destroy() end if espData.Billboard then espData.Billboard:Destroy() end highlightedEntities[character] = nil end end end local j38 toggleNightVision() nightVisionEnabled = not nightVisionEnabled if nightVisionEnabled then originalLightingSettings.Ambient = Lighting.Ambient originalLightingSettings.Brightness = Lighting.Brightness originalLightingSettings.ClockTime = Lighting.ClockTime originalLightingSettings.FogEnd = Lighting.FogEnd originalLightingSettings.OutdoorAmbient = Lighting.OutdoorAmbient Lighting.Ambient = Color3.new(0.5, 0.5, 0.5) Lighting.Brightness = 2 Lighting.ClockTime = 12 Lighting.FogEnd = 10000 Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5) else Lighting.Ambient = originalLightingSettings.Ambient or Color3.new(0, 0, 0) Lighting.Brightness = originalLightingSettings.B
rightness or 1 Lighting.ClockTime = originalLightingSettings.ClockTime or 14 Lighting.FogEnd = originalLightingSettings.FogEnd or 10000 Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient or Color3.new(0.5, 0.5, 0.5) end end ;local __=nil; local k82 onHeartbeat() cleanUpHighlights() for _, child in ipairs(workspace:GetChildren()) do if child:IsA(_d("\115\157\144\145\154")) and shouldHighlight(child) then createESP(child) end end for _, descendant in ipairs(workspace:GetDescendants()) do if descendant:IsA(_d("\115\157\144\145\154")) and shouldHighlight(descendant) then createESP(descendant) end end updateDistanceDisplay() end local l12 createToggleUI() local m94 = Instance.new(_d("\124\145\170\164\102\165\164\164\157\156")) toggleButton.Name = _d("\124\157\147\147\154\145\105\123\120")
toggleButton.Size = UDim2.new(0, 120, 0, 40) toggleButton.Position = UDim2.new(0, 10, 0.5, -20) toggleButton.AnchorPoint = Vector2.new(0, 0.5) toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) toggleButton.BackgroundTransparency = 0.5 toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) toggleButton.Text = _d("\110017\104706\72\40\57400\52057") toggleButton.TextSize = 14 toggleButton.Font = Enum.Font.GothamBold toggleButton.BorderSizePixel = 0 toggleButton.Parent = ScreenGui local n96 = true toggleButton.MouseButton1Click:Connect(function() espEnabled = not espEnabled toggleButton.Text = _d("\110017\104706\72\40") .. (espEnabled and _d("\57400\52057") or _d("\50563\112755")) for _, espData in pairs(highlightedEntities) do if espData.Highlight then espData.Highlight.Enabled = espEnabled end if espData.Billboard then espData.Billboard.Enabled = espEnabled end end end) local o21 = Instance.new(_d("\124\145\170\164\102\165\164\164\157\156")) nightVisionButton.Name = _d("\116\151\147\150\164\126\151\163\151\157\156\102\165\164\164\157\156") nightVisionButton.Size = UDim2.new(0, 120, 0, 40) nightVisionButton.Position = UDim2.new(0, 10, 0.5, 30) nightVisionButton.AnchorPoint = Vector2.new(0, 0.5) nightVisionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) nightVisionButton.BackgroundTransparency = 0.5 nightVisionButton.TextColor3 = Color3.fromRGB(255, 255, 255) nightVisionButton.Text = _d("\54434\104706\72\40\50563\112755") nightVisionButton.TextSize = 14 nightVisionButton.Font = Enum.Font.GothamBold nightVisionButton.BorderSizePixel = 0 nightVisionButton.Parent = ScreenGui nightVisionButton.MouseButton1Click:Connect(function() toggleNightVision() nightVisionButton.Text = _d("\54434\104706\72\40") .. (nightVisionEnabled and _d("\57400\52057") or _d("\50563\112755")) end) end createToggleUI() RunService.Heartbeat:Connect(onHeartbeat) print(_d("\50550\72437\71151\110017\104706\56762\67700\66473\41\40\51405\52053\110017\104706\52214\54434\104706\51237\100375\30002"))