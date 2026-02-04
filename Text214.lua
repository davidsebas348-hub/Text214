-- ======================
-- ESP Cuerpo + Texto NPCs
-- ======================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function AddBoxNPC(npc)
    if not npc or npc:FindFirstChild("BoxESP") then return end

    -- === Highlight del cuerpo ===
    local h = Instance.new("Highlight")
    h.Name = "BoxESP"
    h.FillColor = Color3.fromRGB(0, 120, 255)          -- relleno azul policía
    h.FillTransparency = 0.5                            -- semi-transparente
    h.OutlineColor = Color3.fromRGB(0, 120, 255)       -- contorno azul policía
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop  -- se ve a través de paredes
    h.Parent = npc

    -- === Texto arriba de la cabeza ===
    local hrp = npc:FindFirstChild("HumanoidRootPart")
    if hrp then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPLabel"
        billboard.Adornee = hrp
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = npc

        -- Texto azul oscuro con borde negro
        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1,0,1,0)
        label.Position = UDim2.new(0,0,0,0)
        label.BackgroundTransparency = 1
        label.Text = "GUARD"
        label.TextColor3 = Color3.fromRGB(0, 0, 139) -- azul oscuro
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.TextStrokeColor3 = Color3.new(0,0,0) -- borde negro
        label.TextStrokeTransparency = 0
    end
end

-- Aplicar a NPCs existentes
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(obj) then
        AddBoxNPC(obj)
    end
end

-- Aplicar a NPCs nuevos
Workspace.DescendantAdded:Connect(function(obj)
    if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(obj) then
        AddBoxNPC(obj)
    end
end)
