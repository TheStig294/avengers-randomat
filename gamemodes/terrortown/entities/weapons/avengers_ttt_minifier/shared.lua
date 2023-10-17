if SERVER then
    AddCSLuaFile("shared.lua")
    resource.AddFile("materials/VGUI/ttt/lykrast/icon_minifier.vmt")
end

if CLIENT then
    SWEP.PrintName = "Ant-Man Suit"
    SWEP.Slot = 6
    SWEP.SlotPos = 6
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    SWEP.Icon = "VGUI/ttt/lykrast/icon_minifier"

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Werde so groß wie Timo."
    }
end

SWEP.Author = "Lykrast"
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.HoldType = "slam"
SWEP.Kind = WEAPON_EQUIP
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true
--- PRIMARY FIRE ---
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.NoSights = true
SWEP.Secondary.Delay = 1
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

    if self.maxified then
        self:Reset(false)
        self.maxified = false
    elseif not self.minified then
        self:Minify()
        self.minified = true
    end
end

function SWEP:SecondaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

    if self.minified then
        self:Reset(true)
        self.minified = false
    elseif not self.maxified then
        self:Maxify()
        self.maxified = true
    end
end

function SWEP:PreDrop()
    if self.minified then
        self:UnMinify()
    end
end

SWEP.ShrinkScale = 0.4

function SWEP:Minify()
    if CLIENT then return end
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    if not owner.OGAntManHeight then
        owner.OGAntManHeight = {owner:GetViewOffset().z, owner:GetViewOffsetDucked().z}
    end

    owner:EmitSound("weapons/antman/shrink.ogg")
    owner:SetModelScale(owner:GetModelScale() * self.ShrinkScale, 1)
    -- Decrease height players can automatically step up (i.e. players can't climb stairs)
    owner:SetStepSize(owner:GetStepSize() * self.ShrinkScale)
    owner:SetHealth(owner:Health() * self.ShrinkScale)
    owner:SetMaxHealth(owner:GetMaxHealth() * self.ShrinkScale)
    local ID = "TTTAntManShrink" .. owner:SteamID64()

    timer.Create(ID, 0.01, 100, function()
        local counter = 100 - timer.RepsLeft(ID)

        if counter < 100 - self.ShrinkScale * 100 then
            owner:SetViewOffset(Vector(0, 0, owner.OGAntManHeight[1] - counter * owner.OGAntManHeight[1] / 100))
            owner:SetViewOffsetDucked(Vector(0, 0, owner.OGAntManHeight[2] - counter * owner.OGAntManHeight[2] / 100))
        end
    end)
end

function SWEP:Maxify()
    if CLIENT then return end
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    local growScale = 1 / self.ShrinkScale

    if not owner.OGAntManHeight then
        owner.OGAntManHeight = {owner:GetViewOffset().z, owner:GetViewOffsetDucked().z}
    end

    owner:EmitSound("weapons/antman/unshrink.ogg")
    owner:SetModelScale(owner:GetModelScale() * growScale, 1)
    -- Decrease height players can automatically step up (i.e. players can't climb stairs)
    owner:SetStepSize(owner:GetStepSize() * growScale)
    owner:SetHealth(owner:Health() * growScale)
    owner:SetMaxHealth(owner:GetMaxHealth() * growScale)
    local ID = "TTTAntManShrink" .. owner:SteamID64()

    timer.Create(ID, 0.01, 100, function()
        local counter = 100 - timer.RepsLeft(ID)

        if counter < 100 - self.ShrinkScale * 100 then
            owner:SetViewOffset(Vector(0, 0, owner.OGAntManHeight[1] + counter * owner.OGAntManHeight[1] / 100 * growScale))
            owner:SetViewOffsetDucked(Vector(0, 0, owner.OGAntManHeight[2] + counter * owner.OGAntManHeight[2] / 100 * growScale))
        end
    end)
end

function SWEP:Reset(grow)
    if CLIENT then return end
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    local targetViewHeight
    local targetViewHeightDucked

    if owner.OGAntManHeight then
        targetViewHeight = owner.OGAntManHeight[1]
        targetViewHeightDucked = owner.OGAntManHeight[2]
    end

    local scale
    local mult

    if grow then
        scale = self.ShrinkScale
        owner:EmitSound("weapons/antman/unshrink.ogg")
        mult = 1
    else
        scale = 1 / self.ShrinkScale
        owner:EmitSound("weapons/antman/shrink.ogg")
        mult = -scale
    end

    owner:SetModelScale(owner:GetModelScale() / scale, 1)
    owner:SetStepSize(owner:GetStepSize() / scale)
    owner:SetHealth(owner:Health() / owner:GetMaxHealth() * owner:GetMaxHealth() / scale)
    owner:SetMaxHealth(owner:GetMaxHealth() / scale)
    local ID = "TTTAntManUnshrink" .. owner:SteamID64()

    timer.Create(ID, 0.01, 100, function()
        local counter = 100 - timer.RepsLeft(ID)

        if counter < 100 - self.ShrinkScale * 100 then
            owner:SetViewOffset(Vector(0, 0, targetViewHeight / (1 / scale) + counter * targetViewHeight / 100 * mult))
            owner:SetViewOffsetDucked(Vector(0, 0, targetViewHeightDucked / (1 / scale) + counter * targetViewHeightDucked / 100 * mult))
        end
    end)
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_THROW_DRAW)
    if not IsFirstTimePredicted() then return end
    local owner = self:GetOwner()

    hook.Add("PlayerButtonDown", "AntManActivateFix" .. owner:SteamID64(), function(ply, button)
        timer.Simple(0.1, function()
            if IsValid(owner) and owner == ply and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() == self then
                if button == MOUSE_LEFT then
                    self:PrimaryAttack()
                    hook.Remove("PlayerButtonDown", "AntManActivateFix" .. ply:SteamID64())
                elseif button == MOUSE_RIGHT then
                    self:SecondaryAttack()
                    hook.Remove("PlayerButtonDown", "AntManActivateFix" .. ply:SteamID64())
                end
            end
        end)
    end)

    timer.Simple(3, function()
        if IsValid(owner) then
            hook.Remove("PlayerButtonDown", "AntManActivateFix" .. owner:SteamID64())
        end
    end)

    return true
end

function SWEP:Initialize()
    hook.Add("TTTPrepareRound", "ResetAntManAvengersRandomat", function()
        if CLIENT then return end

        for _, ply in pairs(player.GetAll()) do
            ply.OGAntManHeight = nil
        end
    end)
end

function SWEP:Equip()
    timer.Simple(5, function()
        if not IsValid(self) or not IsValid(self:GetOwner()) then return end
        self:GetOwner():ChatPrint("ANT-MAN SUIT: Left-click: Shrink\nRight-click: Grow")
    end)
end