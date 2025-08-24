-- ฟังก์ชันตรวจสอบและโหลด AutoDoor
local function checkAndLoadDoor()
    local doorsFolder = workspace:WaitForChild("School"):WaitForChild("Doors")

    -- ตรวจหา Rooftop Door
    local rooftopDoor = doorsFolder:FindFirstChild("FenceDoor") and doorsFolder.FenceDoor:FindFirstChild("Rooftop Door")

    -- ตรวจหา DoorL (ตำแหน่งที่สองของ children)
    local doorChildren = doorsFolder:GetChildren()
    local doorL = (doorChildren[2] and doorChildren[2]:FindFirstChild("DoorL")) or nil

    if rooftopDoor or doorL then
        -- โหลดสคริปต์
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/HutyZb-Game/refs/heads/main/AutoDoor.lua"))()
    end
end

-- เรียกครั้งแรก
checkAndLoadDoor()

-- ฟังก์ชันรันทุกครั้งที่มีประตูใหม่ถูกเพิ่ม
workspace.School.Doors.ChildAdded:Connect(function(child)
    -- delay เล็กน้อยเผื่อ object ยังไม่ถูกสร้างเต็มที่
    task.wait(0.1)
    checkAndLoadDoor()
end)
