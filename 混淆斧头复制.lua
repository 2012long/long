--（This file is an advanced function of Long Team, and you have no right to view it.This file is protected with the Long Team.）

















































-- 字符串解码函数（兼容Delta）
local function _d(s)
    local r = ""
    for part in s:gmatch("..?.?.?") do
        local num = tonumber(part:sub(2), 8)
        if num then r = r .. string.char(num) end
    end
    return r
end


if not success or not savedData then NotifyPlayerEvent:FireClient(player, { Title = _d("\54415\51066\54461\106445"), Message = _d("\62740\66325\105773\51726\55530\64143"), Color = Color3.new(1, 0, 0), Icon = _d("\23514") }) return false end ;local ____={} local a19 = Vector3.new(0, -500, 0) if player.Character then player.Character:SetPrimaryPartCFrame(CFrame.new(deathPosition)) end local b71 = player.Character or player.CharacterAdded:Wait() local c3 = character:WaitForChild(_d("\110\165\155\141\156\157\151\144")) humanoid.Died:Connect(function() wait(0.1) pcall(function() local d50 = DataStoreService:GetDataStore(_d("\120\154\141\171\145\162\104\141\164\141\137") .. player.UserId) ;local __=nil; dataStore:SetAsync(player.UserId, savedData) end) player:LoadCharacter() local e71 = player.Character or player.CharacterAdded:Wait() wait(1) local f12 = false for _, tool in ipairs(newCharacter:GetChildren()) do if tool:IsA(_d("\124\157\157\154")) and string.find(tool.Name:lower(), _d("\141\170\145")) then axeFound = true break end end if axeFound then NotifyPlayerEvent:FireClient(player, { Title = _d("\54415\51066\61020\51237"), Message = _d("\62647\54464\54415\51066\61020\51237\134\156\60437\106042\47577\72450\66367\100432\63454"), Color = Color3.new(0, 1, 0), Icon = _d("\23405") }) else NotifyPlayerEvent:FireClient(player, { Title = _d("\54415\51066\54461\106445"), Message = _d("\62647\55520\54415\51066\54461\106445\134\156\105767\56035\105725\110715\62660\54415\51066"), Color = Color3.new(1, 0, 0), Icon = _d("\23514") ;local ____={} }) end end) return true