_G.LOL = 3 
_G.Disabled = true

local players = game:GetService("Players")

local function updateHitboxes()
    if not _G.Disabled then return end
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= players.LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

            if hrp and humanoid then
                if humanoid.Sit then
                    hrp.Size = Vector3.new(0, 0, 0) -- Убираем хитбокс
                else
                    hrp.Size = Vector3.new(_G.LOL, _G.LOL, _G.LOL) -- Восстанавливаем
                    hrp.Transparency = 1
                    hrp.BrickColor = BrickColor.new("Really blue")
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                end
            end
        end
    end
end

-- Обновляем хитбоксы раз в 0.1 секунды (чтобы моментально реагировало, но не лагало)
while task.wait(0.1) do
    updateHitboxes()
end

local player = game.Players.LocalPlayer

local function removePunchTool()
    local backpack = player.Backpack
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "Punch" then
            item:Destroy()
        end
    end
end

player.CharacterAdded:Connect(function()
    removePunchTool()
end)

removePunchTool()

local replicatedStorage = game:GetService("ReplicatedStorage")

local bulletTypes = replicatedStorage:FindFirstChild("BulletTypes")
if not bulletTypes then return end

local bullet = bulletTypes:FindFirstChild("Bullet")
if not bullet then return end

local beam = bullet:FindFirstChild("Beam")
if not beam or not beam:IsA("Beam") then return end

beam.Width0 = 0.2
beam.Width1 = 0.2
beam.TextureLength = 1
beam.TextureMode = Enum.TextureMode.Stretch
beam.LightEmission = 1
beam.TextureSpeed = 1
beam.Transparency = NumberSequence.new(0.05)
beam.FaceCamera = true
beam.Color = ColorSequence.new(Color3.new(204, 0, 204))

local InfiniteJumpEnabled = true
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Humanoid = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
