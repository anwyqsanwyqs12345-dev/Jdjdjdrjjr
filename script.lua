-- تعريف الخدمات الأساسية
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Client = Players.LocalPlayer

-- المفتاح الصحيح
local CORRECT_KEY = "123"

-- إزالة أي واجهات قديمة لمنع التكرار
if CoreGui:FindFirstChild("CyberKeyGUI") then CoreGui.CyberKeyGUI:Destroy() end
if CoreGui:FindFirstChild("CyberLoaderGUI") then CoreGui.CyberLoaderGUI:Destroy() end
if CoreGui:FindFirstChild("CyberMainGUI") then CoreGui.CyberMainGUI:Destroy() end
if CoreGui:FindFirstChild("CyberErrorGUI") then CoreGui.CyberErrorGUI:Destroy() end

--------------------------------------------------------------------------------
-- 1. واجهة إدخال المفتاح (متوسطة وأنيقة)
--------------------------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "CyberKeyGUI"
KeyGui.Parent = CoreGui
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 195)
KeyFrame.Position = UDim2.new(0.5, -160, 0.4, -97)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Color = Color3.fromRGB(138, 43, 226)
KeyStroke.Parent = KeyFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 15, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 5, 15))
})
KeyGradient.Rotation = 45
KeyGradient.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🛡️ Folden Anti-Look 🛡️"
KeyTitle.TextColor3 = Color3.fromRGB(180, 100, 255)
KeyTitle.TextSize = 15
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 270, 0, 42)
TextBox.Position = UDim2.new(0.5, -135, 0, 55)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
TextBox.BorderSizePixel = 0
TextBox.PlaceholderText = "أدخل المفتاح هنا (123)..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 110, 150)
TextBox.TextSize = 13
TextBox.Font = Enum.Font.GothamMedium
TextBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = TextBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Thickness = 1.2
BoxStroke.Color = Color3.fromRGB(138, 43, 226)
BoxStroke.Parent = TextBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0, 270, 0, 40)
SubmitBtn.Position = UDim2.new(0.5, -135, 0, 118)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "⚡ تفعيل النظام"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyFrame

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 10)
BtnCorner1.Parent = SubmitBtn

local BtnGradient = Instance.new("UIGradient")
BtnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
})
BtnGradient.Parent = SubmitBtn

--------------------------------------------------------------------------------
-- 2. واجهة الخطأ (صغيرة ومصممة بعناية)
--------------------------------------------------------------------------------
local function ShowErrorPopup()
    if CoreGui:FindFirstChild("CyberErrorGUI") then
        CoreGui.CyberErrorGUI:Destroy()
    end

    local ErrorGui = Instance.new("ScreenGui")
    ErrorGui.Name = "CyberErrorGUI"
    ErrorGui.Parent = CoreGui
    ErrorGui.ResetOnSpawn = false

    local ErrorFrame = Instance.new("Frame")
    ErrorFrame.Size = UDim2.new(0, 270, 0, 130)
    ErrorFrame.Position = UDim2.new(0.5, -135, 0.45, -65)
    ErrorFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 15)
    ErrorFrame.BorderSizePixel = 0
    ErrorFrame.Parent = ErrorGui

    ErrorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ErrorFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
    ErrorFrame.Size = UDim2.new(0, 0, 0, 0)
    
    TweenService:Create(ErrorFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 270, 0, 130)
    }):Play()

    local ErrCorner = Instance.new("UICorner")
    ErrCorner.CornerRadius = UDim.new(0, 14)
    ErrCorner.Parent = ErrorFrame

    local ErrStroke = Instance.new("UIStroke")
    ErrStroke.Thickness = 2
    ErrStroke.Color = Color3.fromRGB(255, 50, 80)
    ErrStroke.Parent = ErrorFrame

    local ErrIcon = Instance.new("TextLabel")
    ErrIcon.Size = UDim2.new(1, 0, 0, 35)
    ErrIcon.Position = UDim2.new(0, 0, 0, 10)
    ErrIcon.BackgroundTransparency = 1
    ErrIcon.Text = "❌ مفتاح غير صحيح"
    ErrIcon.TextColor3 = Color3.fromRGB(255, 80, 110)
    ErrIcon.TextSize = 14
    ErrIcon.Font = Enum.Font.GothamBold
    ErrIcon.Parent = ErrorFrame

    local ErrText = Instance.new("TextLabel")
    ErrText.Size = UDim2.new(1, -20, 0, 35)
    ErrText.Position = UDim2.new(0, 10, 0, 45)
    ErrText.BackgroundTransparency = 1
    ErrText.Text = "المفتاح الصحيح هو: 123"
    ErrText.TextColor3 = Color3.fromRGB(220, 200, 210)
    ErrText.TextSize = 12
    ErrText.Font = Enum.Font.GothamMedium
    ErrText.TextWrapped = true
    ErrText.Parent = ErrorFrame

    local CloseErrBtn = Instance.new("TextButton")
    CloseErrBtn.Size = UDim2.new(0, 100, 0, 30)
    CloseErrBtn.Position = UDim2.new(0.5, -50, 1, -38)
    CloseErrBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
    CloseErrBtn.BorderSizePixel = 0
    CloseErrBtn.Text = "حاول مجدداً"
    CloseErrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseErrBtn.TextSize = 12
    CloseErrBtn.Font = Enum.Font.GothamBold
    CloseErrBtn.Parent = ErrorFrame

    local CEBtnCorner = Instance.new("UICorner")
    CEBtnCorner.CornerRadius = UDim.new(0, 8)
    CEBtnCorner.Parent = CloseErrBtn

    CloseErrBtn.MouseButton1Click:Connect(function()
        TweenService:Create(ErrorFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.2)
        ErrorGui:Destroy()
    end)
end

--------------------------------------------------------------------------------
-- 3. شاشة التحميل (متوسطة وسريعة)
--------------------------------------------------------------------------------
local function LoadMainCyberGUI()
    local LoaderGui = Instance.new("ScreenGui")
    LoaderGui.Name = "CyberLoaderGUI"
    LoaderGui.Parent = CoreGui
    LoaderGui.ResetOnSpawn = false

    local LoaderFrame = Instance.new("Frame")
    LoaderFrame.Size = UDim2.new(0, 290, 0, 120)
    LoaderFrame.Position = UDim2.new(0.5, -145, 0.5, -60)
    LoaderFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
    LoaderFrame.BorderSizePixel = 0
    LoaderFrame.Parent = LoaderGui

    local LCorner = Instance.new("UICorner")
    LCorner.CornerRadius = UDim.new(0, 16)
    LCorner.Parent = LoaderFrame

    local LStroke = Instance.new("UIStroke")
    LStroke.Thickness = 2
    LStroke.Color = Color3.fromRGB(0, 243, 255)
    LStroke.Parent = LoaderFrame

    local LTitle = Instance.new("TextLabel")
    LTitle.Size = UDim2.new(1, 0, 0, 35)
    LTitle.BackgroundTransparency = 1
    LTitle.Text = "⚡ جاري تحميل Folden Anti-Look..."
    LTitle.TextColor3 = Color3.fromRGB(0, 243, 255)
    LTitle.TextSize = 13
    LTitle.Font = Enum.Font.GothamBold
    LTitle.Parent = LoaderFrame

    local BarBackground = Instance.new("Frame")
    BarBackground.Size = UDim2.new(0, 250, 0, 12)
    BarBackground.Position = UDim2.new(0.5, -125, 0, 52)
    BarBackground.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    BarBackground.BorderSizePixel = 0
    BarBackground.Parent = LoaderFrame

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 6)
    BarCorner.Parent = BarBackground

    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 243, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = BarBackground

    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(0, 6)
    ProgressCorner.Parent = ProgressBar

    local ProgGradient = Instance.new("UIGradient")
    ProgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 243, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    })
    ProgGradient.Parent = ProgressBar

    local PercentLabel = Instance.new("TextLabel")
    PercentLabel.Size = UDim2.new(1, 0, 0, 30)
    PercentLabel.Position = UDim2.new(0, 0, 0, 75)
    PercentLabel.BackgroundTransparency = 1
    PercentLabel.Text = "0%"
    PercentLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
    PercentLabel.TextSize = 12
    PercentLabel.Font = Enum.Font.GothamBold
    PercentLabel.Parent = LoaderFrame

    -- تشغيل انيميشن التحميل
    task.spawn(function()
        for i = 1, 100 do
            ProgressBar.Size = UDim2.new(i / 100, 0, 1, 0)
            PercentLabel.Text = i .. "%"
            task.wait(0.01)
        end
        
        task.wait(0.15)
        LoaderGui:Destroy()

        --------------------------------------------------------------------------------
        -- 4. القائمة الرئيسية (اسم السكربت الرسمي: Folden Anti-Look)
        --------------------------------------------------------------------------------
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "CyberMainGUI"
        ScreenGui.Parent = CoreGui
        ScreenGui.ResetOnSpawn = false

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 260, 0, 160)
        MainFrame.Position = UDim2.new(0.5, -130, 0.25, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
        MainFrame.BorderSizePixel = 0
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 16)
        UICorner.Parent = MainFrame

        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 2
        UIStroke.Color = Color3.fromRGB(0, 243, 255)
        UIStroke.Parent = MainFrame

        local MainGradient = Instance.new("UIGradient")
        MainGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 15, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 5, 15))
        })
        MainGradient.Rotation = 45
        MainGradient.Parent = MainFrame

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 36)
        Title.BackgroundTransparency = 1
        Title.Text = "👑 Folden Anti-Look 👑"
        Title.TextColor3 = Color3.fromRGB(0, 243, 255)
        Title.TextSize = 13
        Title.Font = Enum.Font.GothamBold
        Title.Parent = MainFrame

        -- زر Anti-Lock (بحجم متوسط وملون)
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, 224, 0, 38)
        ToggleBtn.Position = UDim2.new(0.5, -112, 0, 44)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 80)
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.Text = "🛡️ Anti-Lock: [ OFF ]"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        ToggleBtn.TextSize = 12
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.Parent = MainFrame

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 10)
        BtnCorner.Parent = ToggleBtn

        local BtnStroke = Instance.new("UIStroke")
        BtnStroke.Thickness = 1.5
        BtnStroke.Color = Color3.fromRGB(255, 80, 80)
        BtnStroke.Parent = ToggleBtn

        -- زر Anti-Lag (بحجم متوسط وملون)
        local antiLagButton = Instance.new('TextButton')
        antiLagButton.BackgroundColor3 = Color3.fromRGB(25, 45, 80)
        antiLagButton.Font = Enum.Font.GothamBold
        antiLagButton.TextColor3 = Color3.fromRGB(255, 100, 100)
        antiLagButton.Position = UDim2.new(0.5, -112, 0, 92)
        antiLagButton.Text = '⚡ ANTI LAG: [ OFF ]'
        antiLagButton.TextSize = 12
        antiLagButton.Size = UDim2.new(0, 224, 0, 38)
        antiLagButton.Parent = MainFrame

        local antiLagCorner = Instance.new('UICorner')
        antiLagCorner.CornerRadius = UDim.new(0, 10)
        antiLagCorner.Parent = antiLagButton

        local antiLagStroke = Instance.new('UIStroke')
        antiLagStroke.Thickness = 1.5
        antiLagStroke.Color = Color3.fromRGB(255, 80, 80)
        antiLagStroke.Parent = antiLagButton

        -- تأثيرات نبض عند الضغط
        local function playTechPulse(btn)
            local wave = Instance.new("Frame")
            wave.Size = UDim2.new(1, 0, 1, 0)
            wave.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            wave.BackgroundTransparency = 0.5
            wave.BorderSizePixel = 0
            wave.Parent = btn

            local waveCorner = Instance.new("UICorner")
            waveCorner.CornerRadius = UDim.new(0, 10)
            waveCorner.Parent = wave

            TweenService:Create(wave, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 15, 1, 15),
                Position = UDim2.new(0, -7.5, 0, -7.5)
            }):Play()

            task.delay(0.3, function()
                wave:Destroy()
            end)
        end

        -- منطق الـ Anti-Lock
        _G.AntiLock = false
        local MaxDistance = 1
        local ANIM_ID = 'rbxassetid://10147821284'
        local AntiAimAnimTrack = nil
        local RealCFrame = CFrame.new()
        local RealVelocity = Vector3.zero

        local function playDanceAntiAim()
            local char = Client.Character or Client.CharacterAdded:Wait()
            local humanoid = char:WaitForChild('Humanoid')

            if AntiAimAnimTrack then
                AntiAimAnimTrack:Stop()
                AntiAimAnimTrack:Destroy()
            end

            local anim = Instance.new('Animation')
            anim.AnimationId = ANIM_ID
            AntiAimAnimTrack = humanoid:LoadAnimation(anim)
            AntiAimAnimTrack.Looped = true
            AntiAimAnimTrack:Play()
            AntiAimAnimTrack:AdjustSpeed(9999)
        end

        local function stopDanceAntiAim()
            if AntiAimAnimTrack then
                AntiAimAnimTrack:Stop()
                AntiAimAnimTrack:Destroy()
                AntiAimAnimTrack = nil
            end
        end

        local function RandomNumberRange(a)
            return math.random(-a, a)
        end

        local oldIndex
        oldIndex = hookmetamethod(game, '__index', newcclosure(function(self, key)
            if _G.AntiLock and not checkcaller() then
                if self:IsA('BasePart') and key == 'CFrame' then
                    if Client.Character and self == Client.Character:FindFirstChild('HumanoidRootPart') then
                        return RealCFrame
                    end
                end
            end
            return oldIndex(self, key)
        end))

        RunService.Heartbeat:Connect(function()
            if _G.AntiLock and Client.Character and Client.Character:FindFirstChild('HumanoidRootPart') then
                local Root = Client.Character.HumanoidRootPart
                RealCFrame = Root.CFrame
                RealVelocity = Root.AssemblyLinearVelocity

                local randomAngle = math.random(0, 360)
                local Offset = Vector3.new(RandomNumberRange(MaxDistance), RandomNumberRange(MaxDistance), RandomNumberRange(MaxDistance))

                Root.CFrame = RealCFrame * CFrame.Angles(0, math.rad(randomAngle), 0) * CFrame.new(Offset)
                Root.AssemblyLinearVelocity = Vector3.new(RandomNumberRange(500), RandomNumberRange(500), RandomNumberRange(500))

                RunService.RenderStepped:Wait()

                Root.CFrame = RealCFrame
                Root.AssemblyLinearVelocity = RealVelocity
            end
        end)

        ToggleBtn.MouseButton1Click:Connect(function()
            _G.AntiLock = not _G.AntiLock
            playTechPulse(ToggleBtn)
            
            if _G.AntiLock then
                ToggleBtn.Text = "🛡️ Anti-Lock: [ ON ] 🔥"
                ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 60, 40)
                BtnStroke.Color = Color3.fromRGB(0, 255, 170)
                playDanceAntiAim()
            else
                ToggleBtn.Text = "🛡️ Anti-Lock: [ OFF ]"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 80)
                BtnStroke.Color = Color3.fromRGB(255, 80, 80)
                stopDanceAntiAim()
            end
        end)

        -- وظيفة Anti-Lag
        local function applyAntiLag(instance)
            if instance:IsA('ParticleEmitter') then
                instance.Enabled = false
            elseif instance:IsA('Decal') then
                instance.Transparency = 1
            elseif instance:IsA('BasePart') then
                instance.Material = Enum.Material.Plastic
                instance.Reflectance = 0
                instance.CastShadow = false
            end
        end

        local antiLagEnabled = false

        antiLagButton.MouseButton1Click:Connect(function()
            antiLagEnabled = not antiLagEnabled
            antiLagButton.Text = antiLagEnabled and '⚡ ANTI LAG: [ ON ] 🔥' or '⚡ ANTI LAG: [ OFF ]'
            playTechPulse(antiLagButton)
            
            if antiLagEnabled then
                antiLagButton.TextColor3 = Color3.fromRGB(0, 255, 170)
                antiLagButton.BackgroundColor3 = Color3.fromRGB(15, 50, 70)
                antiLagStroke.Color = Color3.fromRGB(0, 255, 170)
            else
                antiLagButton.TextColor3 = Color3.fromRGB(255, 100, 100)
                antiLagButton.BackgroundColor3 = Color3.fromRGB(25, 45, 80)
                antiLagStroke.Color = Color3.fromRGB(255, 80, 80)
            end
            
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.Brightness = 1
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0

            for _, child in pairs(Lighting:GetChildren()) do
                if child:IsA('BloomEffect') or child:IsA('BlurEffect') or child:IsA('SunRaysEffect') then
                    child.Enabled = false
                end
            end
            
            for _, descendant in pairs(Workspace:GetDescendants()) do
                applyAntiLag(descendant)
            end

            Workspace.DescendantAdded:Connect(function(descendant)
                applyAntiLag(descendant)
            end)
        end)
    end)
end

--------------------------------------------------------------------------------
-- زر التحقق من المفتاح
--------------------------------------------------------------------------------
SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CORRECT_KEY then
        SubmitBtn.Text = "✅ تم التحقق!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
        
        task.wait(0.3)
        KeyGui:Destroy()
        LoadMainCyberGUI()
    else
        ShowErrorPopup()
        
        SubmitBtn.Text = "❌ مفتاح خطأ!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
        
        task.wait(1.2)
        SubmitBtn.Text = "⚡ تفعيل النظام"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    end
end)
