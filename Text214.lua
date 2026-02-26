-- ======================
-- ESP Guard + Baton TOGGLE
-- ======================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- ======================
-- TOGGLE REAL
-- ======================

if _G.ESPBatonSystem then
	
	-- Desactivar sistema
	_G.ESPBatonSystem.Enabled = false
	
	-- Desconectar eventos
	for _, conn in pairs(_G.ESPBatonSystem.Connections) do
		conn:Disconnect()
	end
	
	-- Eliminar ESP existentes
	for _, v in pairs(workspace:GetDescendants()) do
		if v.Name == "BoxESP" or v.Name == "ESPLabel" then
			v:Destroy()
		end
	end
	
	_G.ESPBatonSystem = nil
	
	return
end

-- ======================
-- CREAR SISTEMA
-- ======================

_G.ESPBatonSystem = {
	Enabled = true,
	Connections = {}
}

local ESP_COLOR = Color3.fromRGB(0,120,255)

-- ========= FUNCIÓN GENERAL ESP =========
local function AddESP(character, textName)
	if not character or character:FindFirstChild("BoxESP") then return end
	
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local h = Instance.new("Highlight")
	h.Name = "BoxESP"
	h.FillColor = ESP_COLOR
	h.FillTransparency = 0.5
	h.OutlineColor = ESP_COLOR
	h.OutlineTransparency = 0
	h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	h.Parent = character

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESPLabel"
	billboard.Adornee = hrp
	billboard.Size = UDim2.new(0, 100, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = character

	local label = Instance.new("TextLabel", billboard)
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = textName
	label.TextColor3 = ESP_COLOR
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextStrokeColor3 = Color3.new(0,0,0)
	label.TextStrokeTransparency = 0
end

-- =========================
-- GUARD
-- =========================

local guardModel = Workspace:FindFirstChild("Guard")
if guardModel and guardModel:FindFirstChild("Humanoid") then
	AddESP(guardModel, "GUARD")
end

-- =========================
-- BATON
-- =========================

local function CheckPlayerForBaton(player)

	local function ApplyIfHasBaton(character)
		if not _G.ESPBatonSystem.Enabled then return end
		
		if character:FindFirstChild("Baton") then
			AddESP(character, "BATON")
		end
	end
	
	if player.Backpack and player.Backpack:FindFirstChild("Baton") then
		if player.Character then
			AddESP(player.Character, "BATON")
		end
	end
	
	if player.Character then
		ApplyIfHasBaton(player.Character)
	end
	
	local conn = player.CharacterAdded:Connect(function(char)
		task.wait(1)
		ApplyIfHasBaton(char)
	end)
	
	table.insert(_G.ESPBatonSystem.Connections, conn)
end

for _, player in pairs(Players:GetPlayers()) do
	CheckPlayerForBaton(player)
end

local conn = Players.PlayerAdded:Connect(function(player)
	CheckPlayerForBaton(player)
end)

table.insert(_G.ESPBatonSystem.Connections, conn)
