-- ✅ Toggle เปิดปิดระบบ
getgenv().AutoReloadDoors = true  

local url = "https://raw.githubusercontent.com/BlamzKunG/HutyZb-Game/refs/heads/main/Autodooorsw.lua" -- 🔹 แก้เป็นลิงก์ของคุณ

local function loadDoorsScript()
    if getgenv().AutoReloadDoors then
        loadstring(game:HttpGet(url))()
    end
end

-- ฟังก์ชันตรวจว่ามี workspace.Sewers.Doors หรือยัง
local function checkDoorsFolder()
    local sewers = workspace:FindFirstChild("Sewers")
    if sewers then
        local doors = sewers:FindFirstChild("Doors")
        if doors then
            loadDoorsScript()
            
            -- ฟัง event เวลา Doors มีการเปลี่ยนแปลง
            doors.ChildAdded:Connect(function()
                loadDoorsScript()
            end)
            doors.ChildRemoved:Connect(function()
                loadDoorsScript()
            end)
        end
    end
end

-- รอ workspace.Sewers.Doors โผล่มา
if workspace:FindFirstChild("Sewers") then
    if workspace.Sewers:FindFirstChild("Doors") then
        checkDoorsFolder()
    else
        workspace.Sewers.ChildAdded:Connect(function(child)
            if child.Name == "Doors" then
                checkDoorsFolder()
            end
        end)
    end
else
    workspace.ChildAdded:Connect(function(child)
        if child.Name == "Sewers" then
            child.ChildAdded:Connect(function(grandChild)
                if grandChild.Name == "Doors" then
                    checkDoorsFolder()
                end
            end)
        end
    end)
end
