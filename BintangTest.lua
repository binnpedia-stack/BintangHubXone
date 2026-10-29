-- ==========================================
-- BINTANGHUB FULL REBUILD (MINIMIZE + FLOATING ICON)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Cleanup
pcall(function()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then for _, n in ipairs({"BintangHub", "JLXHelperGui"}) do local g = pg:FindFirstChild(n); if g then g:Destroy() end end end
    if CoreGui then for _, n in ipairs({"BintangHub", "JLXHelperGui"}) do local g = CoreGui:FindFirstChild(n); if g then g:Destroy() end end end
end)

local UI = {
    Bg = Color3.fromRGB(13, 14, 17), Sidebar = Color3.fromRGB(10, 11, 14), Card = Color3.fromRGB(17, 18, 23),
    Elevated = Color3.fromRGB(22, 23, 29), Stroke = Color3.fromRGB(32, 34, 43), StrokeDim = Color3.fromRGB(24, 25, 33),
    Text = Color3.fromRGB(255, 255, 255), TextSub = Color3.fromRGB(123, 126, 140), Accent = Color3.fromRGB(255, 255, 255),
    Radius = 12, CardRadius = 8, MainW = 720, MainH = 470, TitleH = 38
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BintangHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 99999
pcall(function() screenGui.Parent = CoreGui end)
if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- ==========================================
-- FLOATING ICON "Bh"
-- ==========================================
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 36, 0, 36)
floatBtn.Position = UDim2.new(0, 20, 0, 100) -- Posisi awal
floatBtn.BackgroundColor3 = UI.Bg
floatBtn.Text = "Bh"
floatBtn.TextColor3 = UI.Text
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 14
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1, 0)
local floatStroke = Instance.new("UIStroke", floatBtn)
floatStroke.Color = UI.Stroke
floatStroke.Thickness = 1.5

-- Draggable Floating Icon
local fDragging, fDragStart, fStartPos = false, nil, nil
floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        fDragging = true
        fDragStart = input.Position
        fStartPos = floatBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then fDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if fDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - fDragStart
        floatBtn.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- MAIN FRAME
-- ==========================================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, UI.MainW, 0, UI.MainH)
mainFrame.Position = UDim2.new(0.5, -UI.MainW/2, 0.5, -UI.MainH/2)
mainFrame.BackgroundColor3 = UI.Bg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, UI.Radius)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, UI.TitleH)
titleBar.BackgroundColor3 = UI.Sidebar
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, UI.Radius)

local titleLogo = Instance.new("TextLabel")
titleLogo.Size = UDim2.new(0, 250, 1, 0)
titleLogo.Position = UDim2.new(0, 16, 0, 0)
titleLogo.BackgroundTransparency = 1
titleLogo.RichText = true
titleLogo.Text = "<b>BintangHub</b> <font color='#7b7e8c'><font size='10'>v2.0 Free</font></font>"
titleLogo.TextColor3 = UI.Text
titleLogo.Font = Enum.Font.GothamBold
titleLogo.TextSize = 13.5
titleLogo.TextXAlignment = Enum.TextXAlignment.Left
titleLogo.Parent = titleBar

-- Minimize Button (-)
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -60, 0.5, -12)
minBtn.BackgroundTransparency = 1
minBtn.Text = "-"
minBtn.TextColor3 = UI.TextSub
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.Parent = titleBar
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -32, 0.5, -12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = UI.TextSub
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- Floating Icon Toggle Main Frame
floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Sidebar & Nav
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 50, 1, -UI.TitleH)
sidebar.Position = UDim2.new(0, 0, 0, UI.TitleH)
sidebar.BackgroundColor3 = UI.Sidebar
sidebar.Parent = mainFrame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, UI.Radius)

local sidebarScroll = Instance.new("ScrollingFrame")
sidebarScroll.Size = UDim2.new(1, 0, 1, -8)
sidebarScroll.Position = UDim2.new(0, 0, 0, 4)
sidebarScroll.BackgroundTransparency = 1
sidebarScroll.BorderSizePixel = 0
sidebarScroll.ScrollBarThickness = 0
sidebarScroll.Parent = sidebar
local sideList = Instance.new("UIListLayout")
sideList.Padding = UDim.new(0, 4)
sideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideList.Parent = sidebarScroll

local navigationContainer = Instance.new("Frame")
navigationContainer.Size = UDim2.new(1, -58, 1, -UI.TitleH - 12)
navigationContainer.Position = UDim2.new(0, 54, 0, UI.TitleH + 6)
navigationContainer.BackgroundTransparency = 1
navigationContainer.Parent = mainFrame

local contentFolder = Instance.new("Folder")
contentFolder.Name = "Tabs"
contentFolder.Parent = navigationContainer

local tabButtons, tabContainers, activeTab = {}, {}, nil
local function switchTab(tabId)
    if activeTab == tabId then return end
    for id, btn in pairs(tabButtons) do
        local icon = btn:FindFirstChild("Icon")
        if id == tabId then btn.BackgroundColor3 = UI.Card; btn.BackgroundTransparency = 0.5; if icon then icon.TextColor3 = UI.Text end
        else btn.BackgroundColor3 = UI.Bg; btn.BackgroundTransparency = 1; if icon then icon.TextColor3 = UI.TextSub end end
    end
    for id, frame in pairs(tabContainers) do frame.Visible = (id == tabId) end
    activeTab = tabId
end

local function createTab(tabId, title, iconChar)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 36, 0, 36)
    btn.BackgroundColor3 = UI.Bg
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = sidebarScroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local label = Instance.new("TextLabel")
    label.Name = "Icon"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = iconChar
    label.TextColor3 = UI.TextSub
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.Parent = btn
    btn.MouseButton1Click:Connect(function() switchTab(tabId) end)
    tabButtons[tabId] = btn
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 2
    container.Visible = false
    container.Parent = contentFolder
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 4); padding.PaddingBottom = UDim.new(0, 20)
    padding.Parent = container
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = container
    tabContainers[tabId] = container
    return container
end

-- (UI builders: Section, Toggle, Slider, Dropdown sama kayak sebelumnya)
local function createSection(container, title)
    local frame = Instance.new("Frame"); frame.Size = UDim2.new(1, 0, 0, 22); frame.BackgroundTransparency = 1; frame.Parent = container
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0); label.Position = UDim2.new(0, 4, 0, 0); label.BackgroundTransparency = 1
    label.Text = string.upper(title); label.TextColor3 = UI.TextSub; label.Font = Enum.Font.GothamBold; label.TextSize = 11; label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = frame
end

local function createToggle(container, label, initial, callback)
    local frame = Instance.new("Frame"); frame.Size = UDim2.new(1, 0, 0, 32); frame.BackgroundColor3 = UI.Card; frame.BackgroundTransparency = 0.5; frame.Parent = container
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, UI.CardRadius)
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(0, 16, 0, 16); btn.Position = UDim2.new(0, 10, 0.5, -8); btn.BackgroundColor3 = initial and UI.Text or UI.Elevated; btn.Text = ""; btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, -50, 1, 0); lbl.Position = UDim2.new(0, 34, 0, 0); lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = UI.Text; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = frame
    local state = initial
    local function toggle()
        state = not state; btn.BackgroundColor3 = state and UI.Text or UI.Elevated
        if callback then pcall(callback, state) end
    end
    btn.MouseButton1Click:Connect(toggle)
    local clickArea = Instance.new("TextButton"); clickArea.Size = UDim2.new(1, 0, 1, 0); clickArea.BackgroundTransparency = 1; clickArea.Text = ""; clickArea.Parent = frame; clickArea.MouseButton1Click:Connect(toggle)
end

local function createSlider(container, label, min, max, initial, callback)
    local frame = Instance.new("Frame"); frame.Size = UDim2.new(1, 0, 0, 38); frame.BackgroundColor3 = UI.Card; frame.BackgroundTransparency = 0.5; frame.Parent = container
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, UI.CardRadius)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(0.6, 0, 0, 18); lbl.Position = UDim2.new(0, 10, 0, 4); lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = UI.Text; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = frame
    local valLbl = Instance.new("TextLabel"); valLbl.Size = UDim2.new(0, 100, 0, 18); valLbl.Position = UDim2.new(1, -110, 0, 4); valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(initial); valLbl.TextColor3 = UI.TextSub; valLbl.Font = Enum.Font.Gotham; valLbl.TextSize = 11; valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.Parent = frame
    local bar = Instance.new("Frame"); bar.Size = UDim2.new(1, -20, 0, 4); bar.Position = UDim2.new(0, 10, 0, 26); bar.BackgroundColor3 = UI.Elevated; bar.Parent = frame; Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame"); fill.Size = UDim2.new((initial - min) / (max - min), 0, 1, 0); fill.BackgroundColor3 = UI.Text; fill.Parent = bar; Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local dragging = false
    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pct = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * pct)
            fill.Size = UDim2.new(pct, 0, 1, 0); valLbl.Text = tostring(val)
            if callback then pcall(callback, val) end
        end
    end)
end

local function createDropdown(container, label, options, default, callback)
    local frame = Instance.new("Frame"); frame.Size = UDim2.new(1, 0, 0, 40); frame.BackgroundColor3 = UI.Card; frame.BackgroundTransparency = 0.5; frame.Parent = container; Instance.new("UICorner", frame).CornerRadius = UDim.new(0, UI.CardRadius)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, -20, 0, 20); lbl.Position = UDim2.new(0, 10, 0, 5); lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = UI.Text; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = frame
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(1, -20, 0, 24); btn.Position = UDim2.new(0, 10, 0, 25); btn.BackgroundColor3 = UI.Elevated; btn.Text = default; btn.TextColor3 = UI.TextSub; btn.Font = Enum.Font.Gotham; btn.TextSize = 11; btn.Parent = frame; Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    local dd = Instance.new("Frame"); dd.Size = UDim2.new(1, 0, 0, 0); dd.Position = UDim2.new(0, 0, 1, 2); dd.BackgroundColor3 = UI.Elevated; dd.Visible = false; dd.ClipsDescendants = true; dd.ZIndex = 50; dd.Parent = btn; Instance.new("UICorner", dd).CornerRadius = UDim.new(0, 4)
    local layout = Instance.new("UIListLayout", dd); layout.Padding = UDim.new(0, 2)
    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton"); optBtn.Size = UDim2.new(1, 0, 0, 24); optBtn.BackgroundColor3 = UI.Card; optBtn.Text = opt; optBtn.TextColor3 = UI.Text; optBtn.Font = Enum.Font.Gotham; optBtn.TextSize = 11; optBtn.ZIndex = 51; optBtn.Parent = dd
        optBtn.MouseButton1Click:Connect(function() btn.Text = opt; dd.Visible = false; if callback then pcall(callback, opt) end end)
    end
    btn.MouseButton1Click:Connect(function() dd.Visible = not dd.Visible; if dd.Visible then dd.Size = UDim2.new(1, 0, 0, #options * 26 + 4) else dd.Size = UDim2.new(1, 0, 0, 0) end end)
end

local cfg = { SkillMode = "Perfect", AutoSkill = false, ParryEnabled = false, ParryRange = 14, ParryFacing = true, ESP = { Player = false, Gen = false, Pallet = false, Vault = false, Hook = false, Gate = false, Trap = false, Pumpkin = false } }

local tabHome = createTab("Home", "Home", "H")
local tabESP = createTab("ESP", "ESP", "E")
local tabFarm = createTab("Farm", "Farm", "F")
local tabCombat = createTab("Combat", "Combat", "C")

createSection(tabHome, "Status")
createToggle(tabHome, "Premium Unlocked", true, function() end)

createSection(tabESP, "Players")
createToggle(tabESP, "Player ESP", false, function(s) cfg.ESP.Player = s end)
createSection(tabESP, "Map Objects (Highlight)")
createToggle(tabESP, "Generator", false, function(s) cfg.ESP.Gen = s end)
createToggle(tabESP, "Pallet", false, function(s) cfg.ESP.Pallet = s end)
createToggle(tabESP, "Window / Vault", false, function(s) cfg.ESP.Vault = s end)
createToggle(tabESP, "Hook", false, function(s) cfg.ESP.Hook = s end)
createToggle(tabESP, "Exit Gate", false, function(s) cfg.ESP.Gate = s end)
createToggle(tabESP, "Bear Trap", false, function(s) cfg.ESP.Trap = s end)
createToggle(tabESP, "Pumpkin", false, function(s) cfg.ESP.Pumpkin = s end)

createSection(tabFarm, "Skill Check")
createToggle(tabFarm, "Auto Skill Check", false, function(s) cfg.AutoSkill = s end)
createDropdown(tabFarm, "Skill Check Mode", {"Legit", "Normal", "Instant", "Perfect"}, "Perfect", function(v) cfg.SkillMode = v end)

createSection(tabCombat, "Auto Parry")
createToggle(tabCombat, "Enable Auto Parry", false, function(s) cfg.ParryEnabled = s end)
createSlider(tabCombat, "Parry Range", 6, 25, 14, function(v) cfg.ParryRange = v end)
createToggle(tabCombat, "Facing Check", true, function(s) cfg.ParryFacing = s end)

-- MAP ESP
local mapESPs = {}
local mapColors = { Generator = Color3.fromRGB(0, 210, 255), Hook = Color3.fromRGB(255, 150, 0), Pallet = Color3.fromRGB(200, 160, 80), Vault = Color3.fromRGB(180, 180, 180), Gate = Color3.fromRGB(255, 255, 0), Trap = Color3.fromRGB(190, 100, 255), Pumpkin = Color3.fromRGB(255, 140, 0) }
local function getObjType(obj)
    local n = obj.Name:lower()
    if n:find("generator") then return "Generator" elseif n:find("pallet") then return "Pallet" elseif n:find("vault") or n:find("window") then return "Vault" elseif n:find("hook") then return "Hook" elseif n:find("gate") or n:find("door") or n:find("lever") then return "Gate" elseif n:find("trap") or n:find("beartrap") then return "Trap" elseif n:find("pumpkin") then return "Pumpkin" end
    return nil
end
RunService.Heartbeat:Connect(function()
    for obj, data in pairs(mapESPs) do
        if not obj or not obj.Parent then if data and data.Highlight then data.Highlight:Destroy() end mapESPs[obj] = nil
        else
            local keep = false
            if data.Type == "Generator" and cfg.ESP.Gen then keep = true elseif data.Type == "Pallet" and cfg.ESP.Pallet then keep = true elseif data.Type == "Vault" and cfg.ESP.Vault then keep = true elseif data.Type == "Hook" and cfg.ESP.Hook then keep = true elseif data.Type == "Gate" and cfg.ESP.Gate then keep = true elseif data.Type == "Trap" and cfg.ESP.Trap then keep = true elseif data.Type == "Pumpkin" and cfg.ESP.Pumpkin then keep = true end
            if not keep then if data.Highlight then data.Highlight:Destroy() end mapESPs[obj] = nil end
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj and obj.Parent and (obj:IsA("Model") or obj:IsA("BasePart")) and not mapESPs[obj] then
                local t = getObjType(obj)
                if t then
                    local en = false
                    if t == "Generator" and cfg.ESP.Gen then en = true elseif t == "Pallet" and cfg.ESP.Pallet then en = true elseif t == "Vault" and cfg.ESP.Vault then en = true elseif t == "Hook" and cfg.ESP.Hook then en = true elseif t == "Gate" and cfg.ESP.Gate then en = true elseif t == "Trap" and cfg.ESP.Trap then en = true elseif t == "Pumpkin" and cfg.ESP.Pumpkin then en = true end
                    if en then
                        local hl = Instance.new("Highlight"); hl.Name = "BintangESP"; hl.FillColor = mapColors[t] or Color3.new(1,1,1); hl.OutlineColor = Color3.new(1,1,1); hl.FillTransparency = 0.5; hl.OutlineTransparency = 0; hl.Parent = obj; mapESPs[obj] = { Highlight = hl, Type = t }
                    end
                end
            end
        end
    end
end)

-- PLAYER ESP
local playerESPs = {}
RunService.RenderStepped:Connect(function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            if cfg.ESP.Player then
                if not playerESPs[char] or not playerESPs[char].Parent then
                    local hl = Instance.new("Highlight"); hl.FillColor = Color3.fromRGB(255, 0, 0); hl.OutlineColor = Color3.new(1,1,1); hl.Parent = char; playerESPs[char] = hl
                end
            else if playerESPs[char] then playerESPs[char]:Destroy(); playerESPs[char] = nil end end
        end
    end
end)

-- SKILL CHECK
local lastSkillTime = 0
local function fireSkillCheck()
    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        if UserInputService.TouchEnabled then
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui"); local sm = pg and (pg:FindFirstChild("Survivor-mob") or pg:FindFirstChild("Survivor")); local act = sm and sm:FindFirstChild("Controls") and sm.Controls:FindFirstChild("action")
            if act then if firesignal then firesignal(act.MouseButton1Down); firesignal(act.MouseButton1Click) end; if getconnections then for _, c in ipairs(getconnections(act.MouseButton1Down)) do c:Fire() end end end
        else vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game); task.wait(0.02); vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game) end
    end)
end
RunService.RenderStepped:Connect(function()
    if not cfg.AutoSkill then return end
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui"); if not pg then return end
    local gui1 = pg:FindFirstChild("SkillCheckPromptGui") or pg:FindFirstChild("SkillCheckPromptGui-con"); if not gui1 then return end
    local check = gui1:FindFirstChild("Check"); local line = check and check:FindFirstChild("Line"); local zone = check and (check:FindFirstChild("TrapPerfect") or check:FindFirstChild("Goal")); if not line or not zone then return end
    local rot = line.Rotation % 360; local zRot = zone.Rotation % 360
    if rot < 0 then rot = rot + 360 end; if zRot < 0 then zRot = zRot + 360 end
    local minR, maxR = (zRot + 104) % 360, (zRot + 114) % 360
    if cfg.SkillMode == "Normal" then minR, maxR = (zRot + 125) % 360, (zRot + 155) % 360 elseif cfg.SkillMode == "Legit" then minR, maxR = (zRot + 106) % 360, (zRot + 112) % 360 end
    if cfg.SkillMode == "Instant" then if tick() - lastSkillTime > 0.1 then line.Rotation = zRot + 109; fireSkillCheck(); lastSkillTime = tick() end return end
    local inZone = false; if minR > maxR then inZone = rot >= minR or rot <= maxR else inZone = rot >= minR and rot <= maxR end
    if inZone and tick() - lastSkillTime > 0.15 then lastSkillTime = tick(); fireSkillCheck() end
end)

-- AUTO PARRY
local lastParry = 0
local function doParry()
    pcall(function()
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui"); local sm = pg and (pg:FindFirstChild("Survivor-mob") or pg:FindFirstChild("Survivor")); local act = sm and sm:FindFirstChild("Controls") and (sm.Controls:FindFirstChild("Gui-mob") or sm.Controls:FindFirstChild("action"))
        if act then if firesignal then firesignal(act.MouseButton1Down) end; if getconnections then for _, c in ipairs(getconnections(act.MouseButton1Down)) do c:Fire() end end end
    end)
end
workspace.DescendantAdded:Connect(function(part)
    if not cfg.ParryEnabled or not part or not part.Parent then return end
    if part:IsA("BasePart") and (part.Name:lower():find("hitbox") or part.Name:lower():find("slash")) then
        local model = part:FindFirstAncestorOfClass("Model")
        if model and model ~= LocalPlayer.Character then
            local killerHrp = model:FindFirstChild("HumanoidRootPart"); local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if killerHrp and myHrp then
                local dist = (killerHrp.Position - myHrp.Position).Magnitude; local facing = true
                if cfg.ParryFacing then local look = myHrp.CFrame.LookVector; local dir = (killerHrp.Position - myHrp.Position).Unit; facing = look:Dot(dir) > -0.1 end
                if dist <= cfg.ParryRange and facing and tick() - lastParry > 0.2 then lastParry = tick(); doParry() end
            end
        end
    end
end)

-- DRAGGABLE MAIN FRAME
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = mainFrame.Position end end)
UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

switchTab("Home")