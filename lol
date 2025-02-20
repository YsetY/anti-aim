-- MADE BY RIP#6666
-- send issues or suggestions to my discord: discord.gg/rips

if not _G.Ignore then
    _G.Ignore = {} -- Add Instances to this table to ignore them (e.g. _G.Ignore = {workspace.Map, workspace.Map2})
end
if not _G.WaitPerAmount then
    _G.WaitPerAmount = 500 -- Set Higher or Lower depending on your computer's performance
end
if _G.SendNotifications == nil then
    _G.SendNotifications = false -- Set to false if you don't want notifications
end
if _G.ConsoleLogs == nil then
    _G.ConsoleLogs = false -- Set to true if you want console logs (mainly for debugging)
end

if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end

if not _G.Settings then
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            NoMesh = false,
            NoTexture = false,
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false,
            Destroy = false
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = false,
            Invisible = false,
            Destroy = false
        },
        MeshParts = {
            LowerQuality = true,
            Invisible = false,
            NoTexture = false,
            NoMesh = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 240,
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = false,
            ["Low Rendering"] = false,
            ["Low Quality Parts"] = true,
            ["Low Quality Models"] = true,
            ["Reset Materials"] = true,
            ["Lower Quality MeshParts"] = true
        }
    }
end

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local MaterialService = game:GetService("MaterialService")
local ME = Players.LocalPlayer
local CanBeEnabled = {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}

local function PartOfCharacter(Instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end

local function DescendantOfIgnore(Instance)
    for _, v in pairs(_G.Ignore) do
        if Instance:IsDescendantOf(v) then
            return true
        end
    end
    return false
end

local function CheckIfBad(Instance)
    if not Instance:IsDescendantOf(Players) and
       (_G.Settings.Players["Ignore Others"] and not PartOfCharacter(Instance) or not _G.Settings.Players["Ignore Others"]) and
       (_G.Settings.Players["Ignore Me"] and ME.Character and not Instance:IsDescendantOf(ME.Character) or not _G.Settings.Players["Ignore Me"]) and
       (_G.Settings.Players["Ignore Tools"] and not Instance:IsA("BackpackItem") and not Instance:FindFirstAncestorWhichIsA("BackpackItem") or not _G.Settings.Players["Ignore Tools"]) and
       (_G.Ignore and not table.find(_G.Ignore, Instance) and not DescendantOfIgnore(Instance) or
       (not _G.Ignore or type(_G.Ignore) ~= "table" or #_G.Ignore <= 0)) then
        
        if Instance:IsA("DataModelMesh") then
            if _G.Settings.Meshes.NoMesh and Instance:IsA("SpecialMesh") then
                Instance.MeshId = ""
            end
            if _G.Settings.Meshes.NoTexture and Instance:IsA("SpecialMesh") then
                Instance.TextureId = ""
            end
            if _G.Settings.Meshes.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("FaceInstance") then
            if _G.Settings.Images.Invisible then
                Instance.Transparency = 1
                Instance.Shiny = 1
            end
            if _G.Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("ShirtGraphic") then
            if _G.Settings.Images.Invisible then
                Instance.Graphic = ""
            end
            if _G.Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif table.find(CanBeEnabled, Instance.ClassName) then
            if _G.Settings.Particles.Invisible then
                Instance.Enabled = false
            end
            if _G.Settings.Particles.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("PostEffect") and _G.Settings.Other["No Camera Effects"] then
            Instance.Enabled = false
        elseif Instance:IsA("Explosion") then
            if _G.Settings.Explosions.Smaller then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
            end
            if _G.Settings.Explosions.Invisible then
                Instance.Visible = false
            end
            if _G.Settings.Explosions.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("Clothing") or Instance:IsA("SurfaceAppearance") or Instance:IsA("BaseWrap") then
            if _G.Settings.Other["No Clothes"] then
                Instance:Destroy()
            end
        elseif Instance:IsA("BasePart") and not Instance:IsA("MeshPart") then
            if _G.Settings.Other["Low Quality Parts"] then
                Instance.Material = Enum.Material.Plastic
                Instance.Reflectance = 0
            end
        elseif Instance:IsA("TextLabel") and Instance:IsDescendantOf(workspace) then
            if _G.Settings.TextLabels.LowerQuality then
                Instance.Font = Enum.Font.SourceSans
                Instance.TextSize = 14
            end
            if _G.Settings.TextLabels.Invisible then
                Instance.Visible = false
            end
            if _G.Settings.TextLabels.Destroy then
                Instance:Destroy()
            end
        end
    end
end

game.DescendantAdded:Connect(function(value)
    task.wait(_G.LoadedWait or 1)
    CheckIfBad(value)
end)

local Descendants = game:GetDescendants()
local WaitNumber = _G.WaitPerAmount or 500

for i, v in pairs(Descendants) do
    CheckIfBad(v)
    if i == WaitNumber then
        task.wait()
        WaitNumber = WaitNumber + (_G.WaitPerAmount or 500)
    end
end
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
        if Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
