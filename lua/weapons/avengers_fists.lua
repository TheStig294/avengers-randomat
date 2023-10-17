AddCSLuaFile()
SWEP.PrintName = "Hulk Fists"
SWEP.Slot = 6
SWEP.SlotPos = 6
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Damage = 80
SWEP.Primary.Delay = 0.38
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Sound = Sound("sound/tankattack.wav")
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.HitDistance = 12
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.AutoSpawnable = false
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = true
SWEP.IsSilent = false
SWEP.AllowDrop = false
--Swep stats
SWEP.HitDistance = 96
--Swep sounds
local Swing = Sound("tankattack.wav")
local HitSound = Sound("hulkpunch.wav")
--ConVars for quick configuration
local knockback_force = CreateConVar("knockback_force", "100", FCVAR_USERINFO, "Sets the knockback force on hogdork2's knockback fists")

--Remove unneeded functions
function SWEP:Reload()
end

function SWEP:Equip()
    timer.Simple(5, function()
        if not IsValid(self) or not IsValid(self:GetOwner()) then return end
        self:GetOwner():ChatPrint("HULK FISTS: High damage melee, x2 size and health!")
    end)
end

SWEP.GrowScale = 1.5

function SWEP:Maxify()
    if self.Maxified or CLIENT then return end
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    local growScale = self.GrowScale

    if not owner.OGHulkHeight then
        owner.OGHulkHeight = {owner:GetViewOffset().z, owner:GetViewOffsetDucked().z}
    end

    self.Maxified = true
    owner:EmitSound("weapons/antman/unshrink.ogg")
    owner:SetModelScale(owner:GetModelScale() * growScale, 1)
    -- Decrease height players can automatically step up (i.e. players can't climb stairs)
    owner:SetStepSize(owner:GetStepSize() * growScale)
    owner:SetHealth(owner:Health() * growScale)
    owner:SetMaxHealth(owner:GetMaxHealth() * growScale)
    local ID = "TTTHulkShrink" .. owner:SteamID64()

    timer.Create(ID, 0.01, 100, function()
        local counter = 100 - timer.RepsLeft(ID)

        if counter < 100 - 1 / growScale * 100 then
            owner:SetViewOffset(Vector(0, 0, owner.OGHulkHeight[1] + counter * owner.OGHulkHeight[1] / 100 * growScale))
            owner:SetViewOffsetDucked(Vector(0, 0, owner.OGHulkHeight[2] + counter * owner.OGHulkHeight[2] / 100 * growScale))
        end
    end)
end

function SWEP:Reset()
    if not self.Maxified or CLIENT then return end
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    local targetViewHeight
    local targetViewHeightDucked

    if owner.OGHulkHeight then
        targetViewHeight = owner.OGHulkHeight[1]
        targetViewHeightDucked = owner.OGHulkHeight[2]
    end

    self.Maxified = false
    owner:EmitSound("weapons/antman/shrink.ogg")
    owner:SetModelScale(1, 0)
    owner:SetStepSize(18)
    owner:SetHealth(100)
    owner:SetMaxHealth(100)
    owner:SetViewOffset(Vector(0, 0, targetViewHeight))
    owner:SetViewOffsetDucked(Vector(0, 0, targetViewHeightDucked))
end

--Do nothing
if CLIENT then
    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Fist them."
    }
end

function SWEP:Initialize()
    self:SetHoldType("fist")
end

--also below general from Hds46
function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
    surface.SetDrawColor(255, 255, 255, alpha)
    surface.SetMaterial(self.WepSelectIcon)
    surface.DrawTexturedRect(x, y, wide, tall)
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "Cooldown")
    self:NetworkVar("Float", 1, "NextIdle")
end

function SWEP:UpdateNextIdle()
    local vm = self:GetOwner():GetViewModel()
    self:SetNextIdle(CurTime() + vm:SequenceDuration())
end

function SWEP:PrimaryAttack(right)
    self:SetNextPrimaryFire(CurTime() + 0.9)
    self:SetNextSecondaryFire(CurTime() + 0.9)
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    local anim = right and "fists_right" or "fists_left"
    local vm = self:GetOwner():GetViewModel()
    vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
    self:EmitSound(Swing)
    self:UpdateNextIdle()
    local pos = self:GetOwner():GetShootPos()
    local ang = self:GetOwner():GetAimVector()

    --// tr is aim target
    local tr = util.TraceLine({
        start = pos,
        endpos = pos + (ang * self.HitDistance),
        filter = self:GetOwner()
    })

    local is_hit = tr.Hit
    local is_world = tr.Entity:IsWorld()
    local is_player = tr.Entity:IsPlayer()
    local is_npc = tr.Entity:IsNPC()
    local knockback = knockback_force:GetInt()

    if knockback > 2147483583 then
        knockback = 2147483583
        knockback_force:SetInt(knockback)
    end

    if is_hit and not is_world then
        local is_valid = IsValid(tr.Entity:GetPhysicsObject())
        local phys_obj = (is_valid == true and tr.Entity:GetPhysicsObject()) or nil
        force = ang * math.pow(knockback, 3)
        player_force = ang * knockback

        --//player
        if is_player then
            player_hit = tr.Entity

            if SERVER then
                player_hit:TakeDamage(self.Primary.Damage, self:GetOwner(), self)
            end

            tr.Entity:SetVelocity(force)

            if IsValid(phys_obj) then
                phys_obj:ApplyForceCenter(force)
            end
        elseif is_npc then
            tr.Entity:SetVelocity(player_force)
        elseif is_valid then
            --// prop
            if IsValid(phys_obj) then
                phys_obj:ApplyForceCenter(force)
            end
        end

        self:EmitSound(HitSound)
    end
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack(true)
end

function SWEP:PreDrop()
    self:Reset()
end

function SWEP:OnDrop()
    self:Remove() -- You can't drop fists
end

function SWEP:Deploy()
    local vm = self:GetOwner():GetViewModel()
    vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
    self:UpdateNextIdle()

    return true
end

local hulkGreen = Color(0, 255, 0, 230)
local hulkGreenVector = Vector(0, 1, 0)

function SWEP:Think()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    if not owner.GetActiveWeapon or not IsValid(owner:GetActiveWeapon()) then return end

    if owner:GetActiveWeapon():GetClass() == "avengers_fists" then
        owner:SetColor(hulkGreen)
        local viewModel = owner:GetViewModel()

        if IsValid(viewModel) then
            viewModel:SetColor(hulkGreen)
        end

        owner:SetPlayerColor(hulkGreenVector)
        self:Maxify()
        owner:SetJumpPower(350)
    else
        if owner:Alive() then
            owner:SetColor(Color(255, 255, 255, 255))
            owner:SetPlayerColor(Vector(1, 1, 1))
            owner:SetJumpPower(160)
            self:Reset()
        end
    end
end