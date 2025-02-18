_G.LOL = 3
_G.Disabled = true
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.LOL,_G.LOL,_G.LOL)
v.Character.HumanoidRootPart.Transparency = 1
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
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
        -- Проверяем, стоит ли персонаж на земле
        if Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
