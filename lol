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
    repeat
        task.wait()
    until game:IsLoaded()
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
            Invisible = false, -- Not recommended for PVP games
            Destroy = false -- Not recommended for PVP games
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
            ["FPS Cap"] = 240, -- Set this true to uncap FPS
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
local Players, Lighting, StarterGui, MaterialService = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui"), game:GetService("MaterialService")
local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}
local function PartOfCharacter(Instance)
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end
local function DescendantOfIgnore(Instance)
    for i, v in pairs(_G.Ignore) do
        if Instance:IsDescendantOf(v) then
            return true
        end
    end
    return false
end
local function CheckIfBad(Instance)
    if not Instance:IsDescendantOf(Players) and (_G.Settings.Players["Ignore Others"] and not PartOfCharacter(Instance) or not _G.Settings.Players["Ignore Others"]) and (_G.Settings.Players["Ignore Me"] and ME.Character and not Instance:IsDescendantOf(ME.Character) or not _G.Settings.Players["Ignore Me"]) and (_G.Settings.Players["Ignore Tools"] and not Instance:IsA("BackpackItem") and not Instance:FindFirstAncestorWhichIsA("BackpackItem") or not _G.Settings.Players["Ignore Tools"])--[[not PartOfCharacter(Instance)]] and (_G.Ignore and not table.find(_G.Ignore, Instance) and not DescendantOfIgnore(Instance) or (not _G.Ignore or type(_G.Ignore) ~= "table" or #_G.Ignore <= 0)) then
        if Instance:IsA("DataModelMesh") then
            if _G.Settings.Meshes.NoMesh and Instance:IsA("SpecialMesh") then
                Instance.MeshId = ""
            end
            if _G.Settings.Meshes.NoTexture and Instance:IsA("SpecialMesh") then
                Instance.TextureId = ""
            end
            if _G.Settings.Meshes.Destroy or _G.Settings["No Meshes"] then
                Instance:Destroy()
            end
        elseif Instance:IsA("FaceInstance") then
            if _G.Settings.Images.Invisible then
                Instance.Transparency = 1
                Instance.Shiny = 1
            end
            if _G.Settings.Images.LowDetail then
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
            if _G.Settings["Invisible Particles"] or _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["Invisible Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Invisible) then
                Instance.Enabled = false
            end
            if (_G.Settings.Other and _G.Settings.Other["No Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
            Instance.Enabled = false
        elseif Instance:IsA("Explosion") then
            if _G.Settings["Smaller Explosions"] or (_G.Settings.Other and _G.Settings.Other["Smaller Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Smaller) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
            end
            if _G.Settings["Invisible Explosions"] or (_G.Settings.Other and _G.Settings.Other["Invisible Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Invisible) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
                Instance.Visible = false
            end
            if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("Clothing") or Instance:IsA("SurfaceAppearance") or Instance:IsA("BaseWrap") then
            if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
                Instance:Destroy()
            end
        elseif Instance:IsA("BasePart") and not Instance:IsA("MeshPart") then
            if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
                Instance.Material = Enum.Material.Plastic
                Instance.Reflectance = 0
            end
        elseif Instance:IsA("TextLabel") and Instance:IsDescendantOf(workspace) then
            if _G.Settings["Lower Quality TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Lower Quality TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.LowerQuality) then
                Instance.Font = Enum.Font.SourceSans
                Instance.TextScaled = false
                Instance.RichText = false
                Instance.TextSize = 14
            end
            if _G.Settings["Invisible TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Invisible TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Invisible) then
                Instance.Visible = false
            end
            if _G.Settings["No TextLabels"] or (_G.Settings.Other and _G.Settings.Other["No TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("Model") then
            if _G.Settings["Low Quality Models"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Models"]) then
                Instance.LevelOfDetail = 1
            end
        elseif Instance:IsA("MeshPart") then
            if _G.Settings["Low Quality MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.LowerQuality) then
                Instance.RenderFidelity = 2
                Instance.Reflectance = 0
                Instance.Material = Enum.Material.Plastic
            end
            if _G.Settings["Invisible MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Invisible MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Invisible) then
                Instance.Transparency = 1
                Instance.RenderFidelity = 2
                Instance.Reflectance = 0
                Instance.Material = Enum.Material.Plastic
            end
            if _G.Settings.MeshParts and _G.Settings.MeshParts.NoTexture then
                Instance.TextureID = ""
            end
            if _G.Settings.MeshParts and _G.Settings.MeshParts.NoMesh then
                Instance.MeshId = ""
            end
            if _G.Settings["No MeshParts"] or (_G.Settings.Other and _G.Settings.Other["No MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Destroy) then
                Instance:Destroy()
            end
        end
    end
end

if _G.SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "discord.gg/rips",
        Text = "Loading FPS Booster...",
        Duration = math.huge,
        Button1 = "Okay"
    })
end

game.DescendantAdded:Connect(function(value)
    wait(_G.LoadedWait or 1)
    CheckIfBad(value)
end)

local Descendants = game:GetDescendants()
local StartNumber = _G.WaitPerAmount or 500
local WaitNumber = _G.WaitPerAmount or 500
if _G.SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "discord.gg/rips",
        Text = "Checking " .. #Descendants .. " Instances...",
        Duration = 15,
        Button1 = "Okay"
    })
end

for i, v in pairs(Descendants) do
    CheckIfBad(v)
    if i == WaitNumber then
        task.wait()
        WaitNumber = WaitNumber + StartNumber
    end
end


_G.LOL = 10
_G.Disabled = true
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.9
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

beam.Width0 = 0.4
beam.Width1 = 0.4
beam.TextureLength = 1
beam.TextureMode = Enum.TextureMode.Stretch
beam.LightEmission = 1
beam.TextureSpeed = 1
beam.Transparency = NumberSequence.new(0.05)
beam.FaceCamera = true

beam.Color = ColorSequence.new(Color3.new(204, 0, 204))
