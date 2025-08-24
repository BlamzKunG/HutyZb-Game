local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันหาตำแหน่ง HRP
local function getHRP(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ฟังก์ชันหาตำแหน่งของประตู
local function getDoorPosition(door)
    if door:IsA("BasePart") then
        return door.Position
    elseif door:IsA("Model") then
        local prim = door.PrimaryPart or door:FindFirstChildWhichIsA("BasePart")
        return prim and prim.Position
    end
    return nil
end

-- รวมประตูทั้งหมดใน workspace.Sewers.Doors
local function collectDoors()
    local doors = {}
    for _, obj in pairs(workspace.Sewers.Doors:GetDescendants()) do
        if obj:IsA("BasePart") then
            table.insert(doors, obj)
        end
    end
    return doors
end

-- เรียงจากใกล้ไปไกล
local function sortByDistance(doors)
    local myChar = LocalPlayer.Character
    local myHRP = getHRP(myChar)
    if not myHRP then return {} end
    
    table.sort(doors, function(a, b)
        local pa = getDoorPosition(a)
        local pb = getDoorPosition(b)
        if pa and pb then
            return (myHRP.Position - pa).Magnitude < (myHRP.Position - pb).Magnitude
        end
        return false
    end)
    
    return doors
end

-- เทเลพอร์ตไปหาทีละประตู
local function teleportSequence()
    local myChar = LocalPlayer.Character
    local myHRP = getHRP(myChar)
    if not myHRP then return end

    local doors = sortByDistance(collectDoors())
    for _, door in ipairs(doors) do
        local pos = getDoorPosition(door)
        if pos then
            myHRP.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0)) -- ยืนบนประตูหน่อย
            task.wait(0.05) -- ค้าง 0.05 วิ
        end
    end
end

-- ▼ เพิ่มระบบ AutoFM
getgenv().AutoFM = true  -- true = ทำงาน, false = หยุด

task.spawn(function()
    while task.wait(1) do -- รอ 1 วิ ต่อรอบ
        if getgenv().AutoFM then
            teleportSequence()
        end
    end
end)
