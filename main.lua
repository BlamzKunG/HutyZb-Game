local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
--loadstring(game:HttpGet(""))()

tab.newToggle("Auto Farm", "Auto Farm", false, function(AutoFM)
    getgenv().AutoFM = AutoFM
    if AutoFM then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/HutyZb-Game/refs/heads/main/Tpkill.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/HutyZb-Game/refs/heads/main/Tpkill.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/HutyZb-Game/refs/heads/main/Tpkill.lua"))()
    end
end)
