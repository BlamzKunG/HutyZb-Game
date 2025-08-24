--// ตั้งค่าเปิด-ปิดได้
getgenv().AutoFM = true  

--// Services
local VirtualInputManager = game:GetService("VirtualInputManager")

--// Key ที่จะใช้กดวน
local keyList = {"Z", "X", "C", "G", "E"}

-- ฟังก์ชันจำลองการกดปุ่ม
local function pressKey(keyCode, holdTime)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)   -- กดลง
    task.wait(holdTime or 0.5)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)  -- ปล่อยปุ่ม
end

-- ฟังก์ชันจำลองคลิกซ้ายค้าง
local function pressClick(holdTime)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)   -- กดคลิกซ้าย
    task.wait(holdTime or 0.5)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)  -- ปล่อยคลิกซ้าย
end

-- ลูปทำงาน
task.spawn(function()
    while task.wait() do
        if getgenv().AutoFM then
            for _, key in ipairs(keyList) do
                pressKey(Enum.KeyCode[key], 0.5)   -- กดปุ่ม 0.5 วิ
                task.wait(0.1)
                pressClick(0.5)                    -- คลิกซ้าย 0.5 วิ
                task.wait(0.1)
                if not getgenv().AutoFM then break end
            end
        else
            task.wait(1) -- พักถ้าปิด
        end
    end
end)
