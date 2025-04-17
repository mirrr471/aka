local Players = game:GetService("Players")

-- 플레이어와 캐릭터 가져오기
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- R6 오른손 가져오기
local rightArm = character:WaitForChild("Right Arm")

-- ReversalRed Part 생성 (XML 기반)
local reversalRed = Instance.new("Part")
reversalRed.Name = "ReversalRed"
reversalRed.Anchored = false
reversalRed.CanCollide = false
reversalRed.Size = Vector3.new(0.001, 0.001, 0.001)
reversalRed.Transparency = 0.2
reversalRed.Material = Enum.Material.Neon
reversalRed.Color = Color3.fromRGB(255, 0, 0)
reversalRed.Massless = true

-- Weld로 오른손에 고정
local weld = Instance.new("Weld")
weld.Name = "Weld"
weld.Part0 = rightArm
weld.Part1 = reversalRed
weld.C0 = CFrame.new(0, 0, 0)
weld.C1 = CFrame.new(0, -1, 0)
weld.Parent = reversalRed

-- Attachment 생성
local centerAttachment = Instance.new("Attachment")
centerAttachment.Name = "Center"
centerAttachment.Visible = false
centerAttachment.Parent = reversalRed

-- ParticleEmitter: Sparks1 (XML 기반)
local sparks1 = Instance.new("ParticleEmitter")
sparks1.Name = "Sparks1"
sparks1.Enabled = false
sparks1.Brightness = 15
sparks1.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
sparks1.Drag = 15
sparks1.EmissionDirection = Enum.NormalId.Top -- 기본값
sparks1.Lifetime = NumberRange.new(0.3, 0.3)
sparks1.Rate = 200
sparks1.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 0)
})
sparks1.Speed = NumberRange.new(40, 70)
sparks1.SpreadAngle = Vector2.new(360, 360)
sparks1.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -1),
    NumberSequenceKeypoint.new(1, -1)
})
sparks1.Texture = "rbxassetid://179123233"
sparks1.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0)
})
sparks1.LockedToPart = true
sparks1.Parent = centerAttachment

-- ParticleEmitter: Charge (XML 기반)
local charge = Instance.new("ParticleEmitter")
charge.Name = "Charge"
charge.Enabled = false
charge.Brightness = 10
charge.Color = ColorSequence.new(Color3.fromRGB(255, 28, 28))
charge.EmissionDirection = Enum.NormalId.Front -- 기본값
charge.Lifetime = NumberRange.new(0.2, 0.3)
charge.Rate = 200
charge.RotSpeed = NumberRange.new(-1500, -500)
charge.Rotation = NumberRange.new(-360, 360)
charge.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 5),
    NumberSequenceKeypoint.new(0.294479, 4.45946),
    NumberSequenceKeypoint.new(0.607362, 2.86486),
    NumberSequenceKeypoint.new(1, 0)
})
charge.Speed = NumberRange.new(0.1, 0.1)
charge.SpreadAngle = Vector2.new(360, 360)
charge.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -0.3),
    NumberSequenceKeypoint.new(1, -0.3)
})
charge.Texture = "rbxassetid://6952384420"
charge.TimeScale = 0.25
charge.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.2, 0),
    NumberSequenceKeypoint.new(0.530675, 0.0441989),
    NumberSequenceKeypoint.new(0.768405, 0.198895),
    NumberSequenceKeypoint.new(1, 1)
})
charge.LockedToPart = true
charge.Parent = centerAttachment

-- PointLight (XML 기반)
local light = Instance.new("PointLight")
light.Name = "Light"
light.Enabled = false
light.Brightness = 5
light.Color = Color3.fromRGB(255, 0, 0)
light.Range = 15
light.Shadows = true
light.Parent = centerAttachment

-- ParticleEmitter: Sparks2 (XML 기반)
local sparks2 = Instance.new("ParticleEmitter")
sparks2.Name = "Sparks2"
sparks2.Enabled = false
sparks2.Brightness = 15
sparks2.Color = ColorSequence.new(Color3.fromRGB(255, 83, 83))
sparks2.Drag = 15
sparks2.EmissionDirection = Enum.NormalId.Top -- 기본값
sparks2.Lifetime = NumberRange.new(0.3, 0.3)
sparks2.Rate = 500
sparks2.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 0)
})
sparks2.Speed = NumberRange.new(40, 70)
sparks2.SpreadAngle = Vector2.new(360, 360)
sparks2.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -1),
    NumberSequenceKeypoint.new(1, -1)
})
sparks2.Texture = "rbxassetid://179123233"
sparks2.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0)
})
sparks2.LockedToPart = true
sparks2.Parent = centerAttachment

-- Part를 캐릭터에 부모 설정
reversalRed.Parent = character

-- 가능한 EmissionDirection 값
local directions = {
    Enum.NormalId.Top,
    Enum.NormalId.Bottom,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Front,
    Enum.NormalId.Back
}

-- 이펙트 활성화/비활성화 함수
local function activateEffects()
    -- 랜덤 방향 설정
    local randomDirection = directions[math.random(1, #directions)]
    sparks1.EmissionDirection = randomDirection
    charge.EmissionDirection = randomDirection
    sparks2.EmissionDirection = randomDirection

    -- 이펙트 활성화
    sparks1.Enabled = true
    charge.Enabled = true
    sparks2.Enabled = true
    light.Enabled = true

    -- 짧은 시간 후 Rate를 0으로 설정해 추가 방출 방지
    task.delay(0.3, function()
        sparks1.Rate = 0
        charge.Rate = 0
        sparks2.Rate = 0
    end)
end

local function deactivateEffects()
    sparks1.Enabled = false
    charge.Enabled = false
    sparks2.Enabled = false
    light.Enabled = false
    -- Rate를 초기값으로 복구
    sparks1.Rate = 200
    charge.Rate = 200
    sparks2.Rate = 500
end

-- 재생 중 플래그
local isPlaying = false

-- 이펙트를 자동으로 활성화하는 함수
local function autoActivateEffects()
    if not isPlaying then
        isPlaying = true
        activateEffects()
        task.delay(1, function()
            deactivateEffects()
            isPlaying = false
        end)
    end
end

-- 스크립트 시작 시 이펙트 자동 활성화
autoActivateEffects()

-- 캐릭터 리셋 시 이펙트 다시 설정
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rightArm = character:WaitForChild("Right Arm")
    
    -- ReversalRed 재설정
    reversalRed.Parent = nil
    weld.Part0 = rightArm
    reversalRed.Parent = character
    
    -- 이펙트 비활성화 상태로 초기화
    deactivateEffects()
    
    -- 캐릭터 리셋 후 이펙트 자동 활성화
    autoActivateEffects()
end)
