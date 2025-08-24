local Entities = workspace:WaitForChild("Entities")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันหาตำแหน่ง HRP
local function getHRP(model)
    return model and model:FindFirstChild("HumanoidRootPart")
end

-- ฟังก์ชันเลือกศัตรูที่ใกล้ที่สุด
local function getNearestEnemy()
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end

    local nearest, nearestDist = nil, math.huge
    for _, entity in pairs(Entities:GetChildren()) do
        local hrp = getHRP(entity)
        if hrp then
            local dist = (myHRP.Position - hrp.Position).Magnitude
            if dist < nearestDist then
                nearest = entity
                nearestDist = dist
            end
        end
    end
    return nearest
end

-- ฟังก์ชัน Teleport ไปหาเป้าหมาย
local function teleportToEnemy(enemy)
    local hrp = getHRP(enemy)
    if hrp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
    end
end

-- ระบบ Auto Target
getgenv().AutoFM = true

task.spawn(function()
    local target = nil
    while task.wait(0.2) do
        if getgenv().AutoFM then
            -- ถ้าไม่มีเป้าหมาย หรือเป้าหมายหายไป → หาใหม่
            if not target or not target.Parent or not getHRP(target) then
                target = getNearestEnemy()
            end

            -- ถ้ามีเป้าหมาย → เทเลพอร์ตไปหา
            if target then
                teleportToEnemy(target)
            end
        end
    end
end)
