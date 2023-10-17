AddCSLuaFile()
AddCSLuaFile("2D.lua")
include("2D.lua")
SWEP.PrintName = "Iron Man Suit"
SWEP.Author = "darky"
SWEP.Purpose = "Become Iron Man!"
SWEP.Instructions = [[
MOUSE1 - Charge repulsor beam
MOUSE2 - Release repulsor beam charge

R - Power up Thrust Boots
SHIFT - Accelerate with Thrust Boots

ALT + E - Switch weapons
ALT + MOUSE1 - Use current weapon

G (Hold) - Targets Players/NPCs, release to launch homing missiles at them
B (Hold) - Targets Players/NPCS, release to shoot bullets at them
H - Drops 10 bombs, needs relative altitude of at least 10
]]
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.Icon = "VGUI/entities/suit_ironman"

if SERVER then
    resource.AddFile("materials/VGUI/entities/suit_ironman.vmt")
end

SWEP.Slot = 6

SWEP.EquipMenuData = {
    type = "Weaponised Super Suit",
    desc = "Specialised suit of armor designed by Tony Stark. WARNING: Cannot Drop!"
}

SWEP.AllowDrop = false
SWEP.Spawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = ""

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/entities/suit_ironman.vtf")
end

SWEP.ViewModelFOV = 54
SWEP.UseHands = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Damage = 3.5
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.NW = {}
SWEP.NW.RepulsorBeamCharge = "ironman_repulsorbeamcharge"
SWEP.NW.RepulsorBeamChargeInitialize = "ironman_repulsorbeamchargeinitialize"
SWEP.NW.NextThink = "ironman_nextthink"
SWEP.NW.NextThinkRockets = "ironman_nextthink_rockets"
SWEP.NW.NextThinkWeapon = "ironman_nextthink_weapon"
SWEP.NW.NextShoot = "ironman_nextshoot"
SWEP.NW.CurrentWeapon = "ironman_currentweapon"
SWEP.NW.SuitEnergy = "ironman_suitenergy"
SWEP.NW.LastModel = "ironman_lastmodel"
SWEP.NW.Rockets = "ironman_rockets"
SWEP.MaxSuitEnergy = 40
SWEP.RepulsorBeam = {}
SWEP.RepulsorBeam.MaxCharge = 30
SWEP.RepulsorBeam.MinCharge = 0
SWEP.RepulsorBeam.MinChargeToShoot = 25
SWEP.RepulsorBeam.IncreaseRate = 40
SWEP.RepulsorBeam.DecreaseRate = 75
SWEP.Rockets = {}
SWEP.Rockets.MaxRockets = 10
SWEP.Rockets.IncreaseRate = 0.5
SWEP.Jets = {}
SWEP.Jets.Enabled = "ironman_jetsenabled"
SWEP.Jets.ToggleDelay = 2
SWEP.Jets.NextToggle = "ironman_jetsnextreload"

SWEP.Weapons = {"Machine Gun", "Missile", "Flamethrower (NOT INSTALLED)", "Laser (OFFLINE)"}

game.AddParticles("particles/exv3_explo.pcf")
PrecacheParticleSystem("btv3_energy")
PrecacheParticleSystem("btv3_explo")
game.AddParticles("particles/vman_explosion.pcf")
local plyMeta = FindMetaTable("Player")
local entMeta = FindMetaTable("Entity")

sound.Add({
    name = "repulsor_beam",
    channel = CHAN_SWEP,
    volume = 1.0,
    level = 100,
    pitch = {95, 110},
    sound = "avengers_ironman/repulsor_beam.wav"
})

sound.Add({
    name = "repulsor_cancel",
    channel = CHAN_SWEP,
    volume = 1.0,
    level = 100,
    pitch = {95, 110},
    sound = "avengers_ironman/repulsor_cancel.wav"
})

sound.Add({
    name = "repulsor_shoot",
    channel = CHAN_SWEP,
    volume = 1.0,
    level = 100,
    pitch = {75, 110},
    sound = "avengers_ironman/repulsor_shoot.wav"
})

-- jetpack
sound.Add({
    name = "jetpack_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    pitch = {95, 110},
    sound = "avengers_ironman/jetpack_start.wav"
})

sound.Add({
    name = "jetpack_loop",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    pitch = 100,
    sound = "avengers_ironman/jetpack_loop.wav"
})

sound.Add({
    name = "jetpack_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    pitch = {75, 110},
    sound = "avengers_ironman/jetpack_stop.wav"
})

if SERVER then
    util.AddNetworkString("RegisterRepulsorBeam")
    util.AddNetworkString("SendRockets")
    util.AddNetworkString("ShootTo")
    util.AddNetworkString("SpawnRocket")
    util.AddNetworkString("SwitchWeapon")
end

function SWEP:Initialize()
end

function SWEP:Equip()
    self:GetOwner():SetCurrentWeapon(69)

    timer.Simple(5, function()
        if not IsValid(self) or not IsValid(self:GetOwner()) then return end
        self:GetOwner():ChatPrint("IRON MAN SUIT: Left-click (hold): Charge beam\nRight-click: Fire beam (if charged)\nR: Toggle flight mode\nShift: Fly faster")
    end)
end

function plyMeta:GetRepulsorBeamCharge()
    local active_entity = self:GetActiveWeapon()
    if not IsValid(self) then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWInt(active_entity.NW.RepulsorBeamCharge)
end

function plyMeta:SetRepulsorBeamCharge(set)
    if not IsValid(self) then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end
    set = math.Clamp(set, active_entity.RepulsorBeam.MinCharge, active_entity.RepulsorBeam.MaxCharge)

    return self:SetNWInt(active_entity.NW.RepulsorBeamCharge, set)
end

function plyMeta:GetRepulsorBeamChargeInitialize()
    if not IsValid(self) then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWBool(active_entity.NW.RepulsorBeamChargeInitialize)
end

function plyMeta:SetRepulsorBeamChargeInitialize(set)
    if not IsValid(self) then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    return self:SetNWBool(active_entity.NW.RepulsorBeamChargeInitialize, set)
end

function plyMeta:GetJetsNextToggle()
    if not IsValid(self) then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWInt(active_entity.Jets.NextToggle)
end

function plyMeta:SetJetsNextToggle(set)
    if not IsValid(self) then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    return self:SetNWInt(active_entity.Jets.NextToggle, set)
end

function plyMeta:GetSuitEnergy()
    if not self or not self:IsValid() then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWInt(active_entity.NW.SuitEnergy)
end

function plyMeta:SetSuitEnergy(set)
    if not self or not self:IsValid() then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    return self:SetNWInt(active_entity.NW.SuitEnergy, set)
end

function plyMeta:GetJetsEnabled()
    if not self or not self:IsValid() then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWBool(active_entity.Jets.Enabled)
end

function plyMeta:SetJetsEnabled(set)
    if not self or not self:IsValid() then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    return self:SetNWBool(active_entity.Jets.Enabled, set)
end

function plyMeta:SetRockets(set)
    if not self or not self:IsValid() then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    if set >= active_entity.Rockets.MaxRockets then
        set = 10
    end

    return self:SetNWInt(active_entity.NW.Rockets, set)
end

function plyMeta:GetRockets()
    if not self or not self:IsValid() then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    return self:GetNWInt(active_entity.NW.Rockets)
end

function plyMeta:GetCurrentWeapon()
    if not self or not self:IsValid() then return 0 end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return 0 end
    if active_entity:GetClass() ~= "avengers_ironman" then return 0 end

    return self:GetNWInt(active_entity.NW.CurrentWeapon)
end

function plyMeta:SetCurrentWeapon(set)
    if not self or not self:IsValid() then return end
    local active_entity = self:GetActiveWeapon()
    if not active_entity or not active_entity:IsValid() then return end
    if active_entity:GetClass() ~= "avengers_ironman" then return end

    if self:GetNWInt(active_entity.NW.CurrentWeapon) == 0 then
        self:SetNWInt(active_entity.NW.CurrentWeapon, 1)
    else
        self:SetNWInt(active_entity.NW.CurrentWeapon, set)
    end
end

function SWEP:PrimaryAttack()
    if CLIENT then return end
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
    local bullet = {}
    bullet.Num = num_bullets
    bullet.Src = self:GetOwner():GetShootPos() -- Source
    bullet.Dir = self:GetOwner():GetAimVector() -- Dir of bullet
    bullet.Spread = Vector(aimcone, aimcone, 0) -- Aim Cone
    bullet.Tracer = 1 -- Show a tracer on every x bullets
    bullet.Force = 1 -- Amount of force to give to phys objects
    bullet.Damage = damage
    bullet.AmmoType = "Pistol"
    self:GetOwner():FireBullets(bullet)
    self:ShootEffects()
end

function SWEP:ShootBulletDir(damage, dir)
    local bullet = {}
    bullet.Num = 1
    bullet.Src = self:GetOwner():GetShootPos() -- Source
    bullet.Dir = dir -- Dir of bullet
    bullet.Spread = Vector(0, 0, 0) -- Aim Cone
    bullet.Tracer = 1 -- Show a tracer on every x bullets
    bullet.Force = 1 -- Amount of force to give to phys objects
    bullet.Damage = damage
    bullet.AmmoType = "Pistol"
    self:GetOwner():FireBullets(bullet)
    self:ShootEffects()
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
    -- Set us up the texture
    surface.SetDrawColor(255, 255, 255, alpha)
    surface.SetTexture(self.WepSelectIcon)
    -- Lets get a sin wave to make it bounce
    local fsin = 0
    -- Borders
    y = y + 10
    x = x + 10
    wide = wide - 20
    -- Draw that mother
    surface.DrawTexturedRect(x + wide / 4, y + tall / 8, wide / 2, tall / 2)
    -- Draw weapon info box
    self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
end

function entMeta:HandleSuitWeapons(ent)
end

-- if ent:KeyDown(IN_WALK) and ent:KeyDown(IN_ATTACK) then
--     if ent:GetCurrentWeapon() == 1 then
--         if ent:GetNWInt(self.NW.NextThinkWeapon) < CurTime() then
--             if ent:GetSuitEnergy() > 4 then
--                 self:EmitSound("Weapon_SMG1.Single")
--                 self:ShootBullet(25, 3, 0.075)
--                 ent:SetSuitEnergy(ent:GetSuitEnergy() - 0.5)
--                 ent:SetNWInt(self.NW.NextThinkWeapon, CurTime() + 0.06)
--             end
--         end
--     end
--     if ent:GetCurrentWeapon() == 2 and SERVER then
--         if ent:GetNWInt(self.NW.NextThinkWeapon) < CurTime() then
--             local energy_amount = 5
--             if ent:GetSuitEnergy() < energy_amount then return end
--             if ent:GetRockets() < 1 then return end
--             ent:SetRockets(ent:GetRockets() - 1)
--             ent:SetSuitEnergy(ent:GetSuitEnergy() - energy_amount)
--             local im_missile = ents.Create("im_missile")
--             im_missile:SetNWInt("damage", 75)
--             if not im_missile or not IsValid(im_missile) then return end
--             if not ent or not ent:IsValid() then return end
--             im_missile:SetPos(ent:EyePos() + ent:EyeAngles():Up() * 150)
--             im_missile:Spawn()
--             im_missile:GetPhysicsObject():SetAngles(ent:EyeAngles())
--             im_missile:GetPhysicsObject():SetVelocity(ent:GetEyeTrace().HitPos - ent:GetPos())
--             ent:EmitSound("doors/door_latch1.wav")
--             ent:SetNWInt(self.NW.NextThinkWeapon, CurTime() + 0.3)
--         end
--     end
-- end
function SWEP:Think()
    if not IsValid(self:GetOwner()) then return end
    local ent = self:GetOwner()

    if not ent:KeyDown(IN_WALK) and ent:KeyDown(IN_ATTACK) and ent:GetSuitEnergy() > 0 then
        if ent:GetRepulsorBeamCharge() < self.RepulsorBeam.MaxCharge and ent:GetRepulsorBeamChargeInitialize() == true then
            ent:SetRepulsorBeamCharge(ent:GetRepulsorBeamCharge() + FrameTime() * self.RepulsorBeam.IncreaseRate)

            if FrameTime() * (self.RepulsorBeam.IncreaseRate / 4) > ent:GetSuitEnergy() + 1 then
                self:SecondaryAttack()
                ent:GetRepulsorBeamChargeInitialize(false)
            end

            ent:SetSuitEnergy(ent:GetSuitEnergy() - FrameTime() * (self.RepulsorBeam.IncreaseRate / 4))
        end
    else
        if ent:GetRepulsorBeamCharge() > self.RepulsorBeam.MinCharge then
            ent:SetRepulsorBeamCharge(ent:GetRepulsorBeamCharge() - FrameTime() * self.RepulsorBeam.DecreaseRate)
            ent:SetSuitEnergy(ent:GetSuitEnergy() + FrameTime() * (self.RepulsorBeam.IncreaseRate / 4))
        end
    end

    if not ent:KeyDown(IN_WALK) then
        if ent:KeyPressed(IN_ATTACK) and ent:GetSuitEnergy() > 0 then
            self:StopSound("repulsor_cancel")
            self:EmitSound("repulsor_beam", 75, 100, 1)
            ent:SetRepulsorBeamChargeInitialize(true)
        end

        if ent:KeyReleased(IN_ATTACK) and ent:GetRepulsorBeamChargeInitialize() == true then
            self:EmitSound("repulsor_cancel")
            self:StopSound("repulsor_beam")
            ent:SetRepulsorBeamChargeInitialize(false)
        end
    end

    self:HandleSuitWeapons(ent)

    if ent:GetJetsEnabled() then
        if ent:GetSuitEnergy() > 5 then
            if ent:KeyDown(IN_SPEED) then
                local aim_vec = ent:GetAimVector()

                if Vector(ent:GetVelocity().x, ent:GetVelocity().y, 0):Length() > 1600 then
                    aim_vec.x = 0
                    aim_vec.y = 0
                end

                if aim_vec.z < 1 then
                    aim_vec.z = aim_vec.z + 1
                end

                ent:SetVelocity(aim_vec * 10)
            else
                if ent:GetVelocity().z < 0 then
                    ent:SetVelocity(Vector(0, 0, math.abs(ent:GetVelocity().z)))
                end
            end

            if ent:KeyPressed(IN_SPEED) then
                if ent:IsOnGround() then
                    ent:SetVelocity(Vector(0, 0, 350))
                end
            end
        end
    end

    if ent:GetNWInt(self.NW.NextThinkRockets) < CurTime() then
        if self:GetOwner():GetRockets() < 10 then
            self:GetOwner():SetRockets(self:GetOwner():GetRockets() + 2)
        end

        ent:SetNWInt(self.NW.NextThinkRockets, CurTime() + 2)
    end

    if ent:GetNWInt(self.NW.NextThink) < CurTime() then
        if self:GetOwner():GetJetsEnabled() then
            local random_energy = math.random(1, 5)

            if self:GetOwner():GetSuitEnergy() < random_energy then
                self:EmitSound("ambient/energy/spark" .. math.random(5, 6) .. ".wav")
                self:EmitSound("jetpack_stop")
                self:StopSound("jetpack_loop")
                self:GetOwner():SetJetsEnabled(false)
                timer.Remove("im_jetpack" .. self:GetOwner():GetName() .. self:GetOwner():SteamID())
            else
                self:GetOwner():SetSuitEnergy(self:GetOwner():GetSuitEnergy() - random_energy)
            end
        end

        if self:GetOwner():GetSuitEnergy() < self.MaxSuitEnergy then
            self:GetOwner():SetSuitEnergy(self:GetOwner():GetSuitEnergy() + math.random(2, 16))
        end

        ent:SetNWInt(self.NW.NextThink, CurTime() + math.random(0, 1))
    end
end

function SWEP:SecondaryAttack()
    local ent = self:GetOwner()

    if ent:GetRepulsorBeamCharge() > self.RepulsorBeam.MinChargeToShoot then
        self:StopSound("repulsor_cancel")
        self:StopSound("repulsor_beam")
        self:EmitSound("repulsor_shoot")
        ent:SetRepulsorBeamCharge(ent:GetRepulsorBeamCharge() - 20)
        ent:SetRepulsorBeamChargeInitialize(false)

        if SERVER then
            net.Start("RegisterRepulsorBeam")
            net.WriteEntity(self:GetOwner())
            net.Broadcast()
        end

        local trace = util.QuickTrace(ent:EyePos() - Vector(0, 0, 15), ent:EyeAngles():Forward() * 2500, ent)
        local position = trace.HitPos
        local damage = ent:GetRepulsorBeamCharge() * self.Primary.Damage
        local radius = ent:GetRepulsorBeamCharge() * 7.5
        local attacker = ent
        local inflictor = ent

        if SERVER then
            if IsValid(trace.Entity) then
                if trace.Entity:GetClass() == "prop_physics" then
                    if trace.Entity:GetPhysicsObject() then
                        trace.Entity:GetPhysicsObject():EnableMotion(true)
                        constraint.RemoveConstraints(trace.Entity, "Weld")
                    end
                end
            end
        end

        ParticleEffect("btv3_energy", position, ent:EyeAngles(), nil)
        util.BlastDamage(inflictor, attacker, position, radius, damage)

        for k, v in pairs(ents.FindInSphere(position, radius)) do
            local max_knockback = ent:GetRepulsorBeamCharge() * 50
            v:SetVelocity(-((position - v:GetPos()) * position:Distance(v:GetPos()) / 50 / max_knockback))
        end

        ent:SetVelocity(-((position - ent:GetPos()):GetNormalized() * ent:GetRepulsorBeamCharge() * 10))
        self:SetNextSecondaryFire(CurTime() + 0.1)
    end
end

function SWEP:OnRemove()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    owner:SetNWInt(self.NW.RepulsorBeamCharge, 0)
    owner:SetNWInt(self.NW.SuitEnergy, 0)

    if SERVER then
        if owner:GetJetsEnabled() == true then
            self:EmitSound("jetpack_stop")
            self:StopSound("jetpack_loop")
            timer.Remove("im_jetpack" .. owner:GetName() .. owner:SteamID())
        end

        owner:SetBloodColor(BLOOD_COLOR_RED)
    end

    if CLIENT then return end
    if owner:IsValid() then return true end
end

local max_hit = 10
local current_hit = {}
local current_hit_mg = {}
local last_bomb_dropped = 0
local last_select = 0
local chat_open = false

function SWEP:DrawHUD()
    if SERVER then return end
    local ent = LocalPlayer()

    if not COMBINE_OVERLAY then
        COMBINE_OVERLAY = Material("effects/combine_binocoverlay")
        COMBINE_OVERLAY:SetFloat("$alpha", "0.2")
        COMBINE_OVERLAY:Recompute()
    end

    local crosshair_width = 2
    local crosshair_height = 20
    draw.RoundedBox(1, ScrW() / 2 - crosshair_width / 2, ScrH() / 2 - crosshair_height / 2 + 1, crosshair_width, crosshair_height, Color(255, 32, 32, 150))
    draw.RoundedBox(1, ScrW() / 2 - crosshair_height / 2, ScrH() / 2 - crosshair_height / 2 + crosshair_height / 2, crosshair_height, crosshair_width, Color(255, 32, 32, 150))
    surface.SetDrawColor(255, 255, 255, 50)
    surface.SetMaterial(COMBINE_OVERLAY)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    local pos = LocalPlayer():GetEyeTrace().HitPos

    for k, v in pairs(ents.GetAll()) do
        if v:IsNPC() or string.sub(v:GetClass(), 1, 3) == "nz_" or v:IsPlayer() and v ~= LocalPlayer() and v:Alive() and v:Health() > 0 then
            local pos = v:EyePos()
            local trace = {}
            trace.start = LocalPlayer():GetShootPos()
            trace.endpos = pos
            trace.mask = 1174421507

            trace.filter = {LocalPlayer(), v}

            local tr = util.TraceLine(trace)

            if not tr.Hit then
                local ent_pos_root = v:GetPos():ToScreen()
                local ent_pos = (v:GetPos() + v:OBBCenter()):ToScreen()
                local ent_pos_max, ent_pos_min = v:Get2DBounds()
                local ent_screen_distance = Vector(ent_pos.x, ent_pos.y, 0):Distance(Vector(ScrW() / 2, ScrH() / 2, 0))

                if ent_screen_distance < 75 then
                    draw.SimpleText("" .. v:GetClass(), "BudgetLabel", ent_pos_max.x + 5, ent_pos_min.y + 5, Color(16, 158, 249), TEXT_ALIGN_LEFT, 1)
                    draw.SimpleText("[" .. math.Round(v:GetPos():Distance(LocalPlayer():GetPos())) / 100 .. "m]", "BudgetLabel", (ent_pos_min.x + ent_pos_max.x) / 2, ent_pos_max.y + 7, Color(16, 158, 249), TEXT_ALIGN_CENTER, 1)
                end

                surface.SetDrawColor(16, 158, 249)
                surface.DrawOutlinedRect(ent_pos_min.x, ent_pos_min.y, ent_pos_max.x - ent_pos_min.x, math.abs(ent_pos_max.y - ent_pos_min.y))
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(ent_pos_min.x - 1, ent_pos_min.y - 1, ent_pos_max.x - ent_pos_min.x + 2, math.abs(ent_pos_max.y - ent_pos_min.y) + 2)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(ent_pos_min.x + 1, ent_pos_min.y + 1, ent_pos_max.x - ent_pos_min.x - 2, math.abs(ent_pos_max.y - ent_pos_min.y) - 2)
            end
        end
    end

    for k, v in pairs(player.GetAll()) do
        if v ~= LocalPlayer() then
            if IsValid(v:GetActiveWeapon()) and v:GetActiveWeapon():GetClass() == "avengers_ironman" then
                local ent_pos = v:GetPos():ToScreen()
                draw.SimpleText("IRON MAN SIGNATURE", "TargetIDSmall", ent_pos.x, ent_pos.y, Color(255, 128, 32), TEXT_ALIGN_CENTER, 1)
                draw.SimpleText(math.Round(v:GetPos():Distance(LocalPlayer():GetPos())) / 100 .. "m", "TargetIDSmall", ent_pos.x, ent_pos.y + 15, Color(255, 128, 32), TEXT_ALIGN_CENTER, 1)
            end
        end
    end
    -- if LocalPlayer():KeyDown(IN_USE) and LocalPlayer():KeyDown(IN_WALK) and not chat_open and last_select < CurTime() then
    --     net.Start("SwitchWeapon")
    --     net.SendToServer()
    --     last_select = CurTime() + 0.5
    -- end
    -- if input.IsKeyDown(KEY_G) and not chat_open then
    --     local v = LocalPlayer():GetEyeTrace().Entity
    --     if IsValid(v) and (v:IsNPC() or string.sub(v:GetClass(), 1, 3) == "nz_" or v:IsPlayer()) and LocalPlayer() ~= v then
    --         if not table.HasValue(current_hit, v) and #current_hit < max_hit then
    --             table.insert(current_hit, v)
    --             surface.PlaySound("buttons/combine_button_locked.wav")
    --         end
    --     end
    --     for k, target in pairs(current_hit) do
    --         if IsValid(target) then
    --             local screen_pos = target:EyePos():ToScreen()
    --             local screen_rt_pos = target:GetPos():ToScreen()
    --             surface.DrawCircle(screen_pos.x + 5, screen_pos.y + 5, 5, 255, 0, 0)
    --             draw.SimpleText("RELEASE G TO RELEASE ROCKETS", "HudHintTextSmall", screen_rt_pos.x, screen_rt_pos.y, Color(255, 0, 0), TEXT_ALIGN_CENTER, 1)
    --         end
    --     end
    -- else
    --     if #current_hit > 0 then
    --         net.Start("SendRockets")
    --         net.WriteTable(current_hit)
    --         net.SendToServer()
    --     end
    --     table.Empty(current_hit)
    -- end
    -- if input.IsKeyDown(KEY_B) and not chat_open then
    --     local v = LocalPlayer():GetEyeTrace().Entity
    --     if (v:IsNPC() or string.sub(v:GetClass(), 1, 3) == "nz_" or v:IsPlayer()) and LocalPlayer() ~= v then
    --         if not table.HasValue(current_hit_mg, v) and #current_hit_mg < max_hit then
    --             table.insert(current_hit_mg, v)
    --             surface.PlaySound("buttons/combine_button_locked.wav")
    --         end
    --     end
    --     for k, target in pairs(current_hit_mg) do
    --         if IsValid(target) then
    --             local screen_pos = target:EyePos():ToScreen()
    --             local screen_rt_pos = target:GetPos():ToScreen()
    --             surface.DrawCircle(screen_pos.x + 5, screen_pos.y + 5, 5, 255, 250, 0)
    --             draw.SimpleText("RELEASE B TO SHOOT", "HudHintTextSmall", screen_rt_pos.x, screen_rt_pos.y, Color(255, 250, 0), TEXT_ALIGN_CENTER, 1)
    --         end
    --     end
    -- else
    --     if #current_hit_mg > 0 then
    --         net.Start("ShootTo")
    --         net.WriteTable(current_hit_mg)
    --         net.SendToServer()
    --     end
    --     table.Empty(current_hit_mg)
    -- end
    -- if input.IsKeyDown(KEY_H) and not chat_open then
    --     local trace = {}
    --     trace.start = LocalPlayer():GetPos()
    --     trace.endpos = LocalPlayer():GetPos() - Vector(0, 0, 35000)
    --     trace.filter = LocalPlayer()
    --     local tr = util.TraceLine(trace)
    --     local groundpos = LocalPlayer():GetPos().z - tr.HitPos.z
    --     if math.abs(groundpos) > 1000 then
    --         if last_bomb_dropped < CurTime() then
    --             last_bomb_dropped = CurTime() + 1
    --             net.Start("SpawnRocket")
    --             net.WriteInt(6, 32)
    --             net.SendToServer()
    --         end
    --     end
    -- end
end

function SWEP:HUDShouldDraw(element)
    if element == "CHudChat" or element == "CHudGMod" or element == "CHudWeaponSelection" then return true end
end

function SWEP:Deploy()
    if not IsValid(self:GetOwner()) then return end

    if SERVER then
        self:GetOwner():SetBloodColor(BLOOD_COLOR_MECH)
    end

    self:GetOwner():SetNWString(self.NW.LastModel, self:GetOwner():GetModel())
    self:GetOwner():SetModel("models/Avengers/Iron Man/mark7_player.mdl")
    self:GetOwner():SetCurrentWeapon(1)
    if CLIENT then return true end
end

function SWEP:Holster(wep)
    if not IsValid(self:GetOwner()) then return false end
    self:GetOwner():SetNWInt(self.NW.RepulsorBeamCharge, 0)
    self:GetOwner():SetNWInt(self.NW.SuitEnergy, 0)
    if not IsFirstTimePredicted() then return false end

    if self:GetOwner():GetJetsEnabled() == true then
        self:EmitSound("jetpack_stop")
        self:StopSound("jetpack_loop")
        timer.Remove("im_jetpack" .. self:GetOwner():GetName() .. self:GetOwner():SteamID())
        self:GetOwner():SetJetsEnabled(false)
    end

    return true
end

function SWEP:Reload()
    if not IsValid(self:GetOwner()) then return end
    if CurTime() < self:GetOwner():GetJetsNextToggle() then return end
    local ent = self:GetOwner()
    if not IsValid(ent) then return end
    ent:SetJetsEnabled(not ent:GetJetsEnabled())

    if ent:GetJetsEnabled() == true then
        self:EmitSound("jetpack_start")

        timer.Simple(0.2, function()
            ent:SetVelocity(Vector(0, 0, 350))

            timer.Create("im_jetpack" .. self:GetOwner():GetName() .. self:GetOwner():SteamID(), SoundDuration("avengers_ironman/jetpack_loop.wav") - 0.8, 0, function()
                if not IsValid(self) then return end
                if not IsValid(self:GetOwner():GetActiveWeapon()) then return end
                local active_entity = self:GetOwner():GetActiveWeapon()
                if not active_entity or not active_entity:IsValid() then return end

                if active_entity:GetClass() ~= "avengers_ironman" then
                    timer.Remove("im_jetpack" .. self:GetOwner():GetName() .. self:GetOwner():SteamID())
                    self:GetOwner():SetJetsEnabled(false)

                    return
                end

                self:EmitSound("jetpack_loop")
            end)
        end)
    end

    if ent:GetJetsEnabled() == false then
        self:EmitSound("jetpack_stop")
        self:StopSound("jetpack_loop")
        timer.Remove("im_jetpack" .. self:GetOwner():GetName() .. self:GetOwner():SteamID())
    end

    ent:SetJetsNextToggle(CurTime() + self.Jets.ToggleDelay)
end

net.Receive("SwitchWeapon", function(len, ply)
    local current_weapon = ply:GetCurrentWeapon()
    local next_weapon = ply:GetCurrentWeapon() + 1

    if IsValid(ply:GetActiveWeapon()) then
        local active_weapon = ply:GetActiveWeapon()

        if next_weapon > #active_weapon.Weapons then
            next_weapon = 1
        end

        ply:SetCurrentWeapon(next_weapon)
        ply:EmitSound("buttons/button3.wav")
    end
end)

net.Receive("SendRockets", function(len, ply)
    local players = net.ReadTable()

    for k, v in pairs(players) do
        local energy_amount = 5
        if ply:GetSuitEnergy() < 5 then continue end
        if ply:GetRockets() < 1 then continue end
        ply:SetSuitEnergy(ply:GetSuitEnergy() - 5)
        ply:SetRockets(ply:GetRockets() - 1)
        local trace = {}
        trace.start = ply:GetPos()
        trace.endpos = ply:GetPos() + Vector(0, 0, 35000)
        trace.filter = ply
        local tr = util.TraceLine(trace)
        local max_height = math.Round(math.abs(ply:GetPos().z - tr.HitPos.z))
        local im_missile = ents.Create("im_missile")
        im_missile:SetNWInt("damage", 100)
        im_missile:SetNWEntity("target", v)

        timer.Create("Rocket" .. im_missile:GetCreationID(), 0.12 * k, 1, function()
            if not im_missile or not IsValid(im_missile) then return end
            if not v or not ply or not v:IsValid() then return end
            im_missile:SetPos(ply:EyePos() + Vector(0, 0, 150))
            im_missile:Spawn()
            im_missile:GetPhysicsObject():SetAngles(Angle(-89, 0, 0))
            im_missile:GetPhysicsObject():SetVelocity(Vector(0, 0, math.min(10000, max_height)))
            ply:EmitSound("doors/door_latch1.wav")
        end)
    end
end)

net.Receive("ShootTo", function(len, ply)
    local players = net.ReadTable()

    for k, v in pairs(players) do
        local energy_amount = math.random(10, 50)
        if ply:GetSuitEnergy() < energy_amount then return end
        ply:SetSuitEnergy(ply:GetSuitEnergy() - energy_amount)
        ply:EmitSound("doors/door_latch1.wav")

        timer.Create("Ammo" .. v:GetCreationID(), 0.1 * k, 1, function()
            if not v or not ply or not v:IsValid() or not IsValid(ply:GetActiveWeapon()) then return end
            ply:EmitSound("weapons/crossbow/hit1.wav")
            ply:GetActiveWeapon():ShootBulletDir(math.random(50, 120), v:GetPos() + v:OBBCenter() - ply:EyePos())
        end)
    end
end)

net.Receive("SpawnRocket", function(len, ply)
    if ply:GetNWInt("NextRocketSpawn") > CurTime() then return end
    ply:SetNWInt("NextRocketSpawn", CurTime() + 10)
    local rockets = net.ReadInt(32)

    for i = 0, rockets do
        local energy_amount = 5
        if ply:GetSuitEnergy() < energy_amount then continue end
        if ply:GetRockets() < 1 then continue end
        ply:SetSuitEnergy(ply:GetSuitEnergy() - energy_amount)
        local im_missile = ents.Create("im_missile")

        timer.Create("Rocket" .. im_missile:GetCreationID(), 0.3 * i, 1, function()
            if not im_missile or not IsValid(im_missile) then return end
            if not ply then return end

            if ply:GetRockets() > 1 then
                ply:SetRockets(ply:GetRockets() - 1)
            end

            im_missile:SetPos(ply:GetPos() - Vector(0, 0, 50))
            im_missile:Spawn()
            ply:EmitSound("doors/door_latch1.wav")
        end)
    end
end)

if CLIENT then
    local material_redlaser = Material("cable/redlaser")
    local material_repulsor = Material("cable/physbeam")
    local material_repulsor2 = Material("effects/laser1")
    local material_repulsor_test = Material("effects/beam_generic_2")
    local beam_table = {}

    net.Receive("RegisterRepulsorBeam", function(len)
        local ply = net.ReadEntity()
        local trace = util.QuickTrace(ply:EyePos() - Vector(0, 0, 15), ply:EyeAngles():Forward() * 2500, ply)

        local add_table = {
            {ply:EyePos() - Vector(0, 0, 1), trace.HitPos, CurTime() + 2}
        }

        table.Add(beam_table, add_table)
    end)

    local health_lerp = 0
    local armor_lerp = 0
    local charge_lerp = 0

    local function DrawIMHud()
        local pl = LocalPlayer()
        if not IsValid(pl) then return end
        local active_entity = pl:GetActiveWeapon()
        if not active_entity or not active_entity:IsValid() then return 0 end
        if active_entity:GetClass() ~= "avengers_ironman" then return 0 end
        local fov = pl:GetFOV()
        local aspect = ScrW() / ScrH()
        local factor = 1000
        local ang = pl:EyeAngles()
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), 90)
        ang:RotateAroundAxis(ang:Right(), -15)
        local pos = Vector(1.01, aspect / 2, 0.5) * factor
        pos:Rotate(pl:EyeAngles())
        pos:Add(pl:GetBonePosition(pl:LookupBone("ValveBiped.Bip01_Head1")))
        local width = math.max(0.2 * ScrW(), 200)
        local height = 64
        local scale = (1 / ScrW()) * aspect * factor
        cam.IgnoreZ(true)

        if pl:Alive() then
            local mat = Matrix()
            mat:Translate(pos)
            mat:Rotate(ang)
            mat:Scale(Vector(scale, -scale, scale))
            cam.Start3D2D(Vector(), Angle(), 1)
            cam.PushModelMatrix(mat)
            health_lerp = Lerp(10 * FrameTime(), health_lerp, LocalPlayer():Health())
            armor_lerp = Lerp(10 * FrameTime(), armor_lerp, LocalPlayer():GetSuitEnergy())
            charge_lerp = Lerp(10 * FrameTime(), charge_lerp, LocalPlayer():GetRepulsorBeamCharge())
            local health_height = 44
            draw.RoundedBox(1, 5, ScrH() - health_height - 7, 160, 15, Color(0, 0, 0, 180))
            draw.RoundedBox(1, 10, ScrH() - health_height - 4, math.min(health_lerp, 100) * 1.5, 9, Color(0, 177, 247, 249))
            draw.SimpleText(LocalPlayer():Health() .. "% LIFE VITALS", "Default", 75, ScrH() - health_height, Color(0, 0, 0), TEXT_ALIGN_CENTER, 1)
            local suit_height = 23
            draw.RoundedBox(1, 5, ScrH() - suit_height - 7, 160, 15, Color(0, 0, 0, 180))
            draw.RoundedBox(1, 10, ScrH() - suit_height - 4, math.min(armor_lerp * 1.5, 150), 9, Color(0, 177, 247, 249))
            draw.SimpleText(math.Round(LocalPlayer():GetSuitEnergy()) .. "% SUIT ENERGY", "Default", 75, ScrH() - suit_height, Color(0, 0, 0), TEXT_ALIGN_CENTER, 1)
            local charge_height = 65
            draw.RoundedBox(1, 5, ScrH() - charge_height - 7, 160, 15, Color(0, 0, 0, 180))
            draw.RoundedBox(1, 10, ScrH() - charge_height - 4, charge_lerp * 1.5, 9, Color(0, 177, 247, 249))
            draw.SimpleText(math.Round(charge_lerp) .. " CHARGE", "Default", 75, ScrH() - charge_height, Color(0, 0, 0), TEXT_ALIGN_CENTER, 1)
            local hud_height = 0
            draw.SimpleText("HORIZONTAL VELOCITY: " .. math.Round(Vector(LocalPlayer():GetVelocity().x, LocalPlayer():GetVelocity().y, 0):Length()), "Trebuchet24", -100, height / 2, Color(255, 255, 255), TEXT_ALIGN_LEFT, 1)
            hud_height = hud_height + 30
            draw.SimpleText("ALTITUDE: " .. math.Round(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, -100000):Distance(LocalPlayer():GetPos()) / 100), "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 255), TEXT_ALIGN_LEFT, 1)
            hud_height = hud_height + 30
            local trace = {}
            trace.start = LocalPlayer():GetPos()
            trace.endpos = LocalPlayer():GetPos() - Vector(0, 0, 35000)
            trace.filter = LocalPlayer()
            local tr = util.TraceLine(trace)
            draw.SimpleText("RELATIVE ALTITUDE: " .. math.Round(math.abs(LocalPlayer():GetPos().z - tr.HitPos.z) / 100), "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 255), TEXT_ALIGN_LEFT, 1)
            hud_height = hud_height + 30

            -- if IsValid(pl:GetActiveWeapon()) and pl:GetCurrentWeapon() > 0 then
            --     draw.SimpleText("CURRENT WEAPON: " .. pl:GetActiveWeapon().Weapons[pl:GetCurrentWeapon()], "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 255), TEXT_ALIGN_LEFT, 1)
            --     hud_height = hud_height + 30
            -- end
            -- draw.SimpleText("ROCKETS: " .. math.Round(pl:GetRockets()), "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 255), TEXT_ALIGN_LEFT, 1)
            -- hud_height = hud_height + 30
            if #current_hit > 0 then
                draw.SimpleText("TARGETS LOCKED: " .. #current_hit .. " (MAX 10)", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 0, 0), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if #current_hit_mg > 0 then
                draw.SimpleText("TARGETS LOCKED: " .. #current_hit_mg .. " (MAX 10)", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 0), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if LocalPlayer():GetSuitEnergy() > 75 and LocalPlayer():GetSuitEnergy() < 150 then
                draw.SimpleText("SUIT POWER BELOW AVG: " .. math.Round(LocalPlayer():GetSuitEnergy()) .. "% ", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 255, 64), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if LocalPlayer():GetSuitEnergy() > 35 and LocalPlayer():GetSuitEnergy() < 75 then
                draw.SimpleText("SUIT POWER LOW: " .. math.Round(LocalPlayer():GetSuitEnergy()) .. "% ", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 64, 64), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if LocalPlayer():GetSuitEnergy() <= 35 then
                draw.SimpleText("SUIT POWER CRITICAL: " .. math.Round(LocalPlayer():GetSuitEnergy()) .. "% ", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 64, 64), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if LocalPlayer():Health() <= 35 then
                draw.SimpleText("LIFE VITALS CRITICAL: " .. math.Round(LocalPlayer():Health()) .. "% ", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 64, 64), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            if LocalPlayer():GetSuitEnergy() <= 5.5 then
                draw.SimpleText("FLIGHT SYSTEMS WARNING", "Trebuchet24", -100, height / 2 + hud_height, Color(255, 0, 0), TEXT_ALIGN_LEFT, 1)
                hud_height = hud_height + 30
            end

            cam.PopModelMatrix()
            cam.End3D2D()
        end

        cam.IgnoreZ(false)
    end

    hook.Add("StartChat", "chat_thing", function()
        chat_open = true
    end)

    hook.Add("FinishChat", "chat_thing2", function()
        chat_open = false
    end)

    hook.Add("PreDrawTranslucentRenderables", "draw_repulsorbeam", function()
        if LocalPlayer():GetRepulsorBeamChargeInitialize() == true then
            local ply = LocalPlayer()
            local trace = util.QuickTrace(LocalPlayer():EyePos() - Vector(0, 0, 15), LocalPlayer():EyeAngles():Forward() * 2500, LocalPlayer())
            render.SetMaterial(material_repulsor2)
            render.DrawBeam(LocalPlayer():EyePos() - Vector(0, 0, 15), trace.HitPos, LocalPlayer():GetRepulsorBeamCharge() / 7, 0, 12.5, Color(0, (LocalPlayer():GetRepulsorBeamCharge() / 65) * 255, 255, 255))
            local dlight = DynamicLight(LocalPlayer():EntIndex())

            if dlight then
                dlight.pos = LocalPlayer():GetShootPos()
                dlight.r = 0
                dlight.g = (LocalPlayer():GetRepulsorBeamCharge() / 65) * 255
                dlight.b = 255
                dlight.brightness = 2
                dlight.Decay = 1000
                dlight.Size = 125
                dlight.DieTime = CurTime() + 1
            end

            local dlight2 = DynamicLight(LocalPlayer():EntIndex())

            if dlight2 then
                dlight2.pos = trace.HitPos
                dlight2.r = 0
                dlight2.g = (LocalPlayer():GetRepulsorBeamCharge() / 65) * 255
                dlight2.b = 255
                dlight2.brightness = 2
                dlight2.Decay = 1000
                dlight2.Size = 125
                dlight2.DieTime = CurTime() + 1
            end
        end

        if LocalPlayer():GetJetsEnabled() == true then
            local dlight = DynamicLight(LocalPlayer():EntIndex())

            if dlight then
                dlight.pos = LocalPlayer():GetPos()
                dlight.r = (LocalPlayer():GetSuitEnergy() / 300) * 255
                dlight.g = (LocalPlayer():GetSuitEnergy() / 300) * 255 / 1.2
                dlight.b = (LocalPlayer():GetSuitEnergy() / 300) * 255 / 2
                dlight.brightness = 2
                dlight.Decay = 1000
                dlight.Size = 1024
                dlight.DieTime = CurTime() + 1
            end
        end

        for k, v in pairs(beam_table) do
            if CurTime() > v[3] then
                table.remove(beam_table, k)
            end

            material_repulsor_test:SetInt("$vertexalpha", 1)
            render.SetMaterial(material_repulsor_test)
            render.DrawBeam(v[1], v[2], 2, 0, 12.5, Color(255, 255, 255, ((v[3] - CurTime()) / 10) * 255))
        end

        DrawIMHud()
    end)
end

if SERVER then
    hook.Add("GetFallDamage", "im_falldmg", function(ply, speed)
        local active_entity = ply:GetActiveWeapon()

        if active_entity and active_entity:IsValid() then
            if active_entity:GetClass() == "avengers_ironman" then
                if ply:GetSuitEnergy() < speed / 30 then return end
                ply:SetSuitEnergy(ply:GetSuitEnergy() - speed / 30)
                ply:EmitSound("physics/metal/metal_barrel_impact_hard" .. math.random(5, 7) .. ".wav")

                return 0
            end
        end
    end)

    hook.Add("EntityTakeDamage", "im_takedmg", function(ply, dmg)
        if not ply:IsPlayer() then return end
        local damage = dmg:GetDamage()
        local active_entity = ply:GetActiveWeapon()

        if active_entity and active_entity:IsValid() then
            if active_entity:GetClass() == "avengers_ironman" then
                if ply:GetSuitEnergy() < damage / 10 then return end
                ply:SetSuitEnergy(ply:GetSuitEnergy() - damage / 10)
            end
        end
    end)

    hook.Add("PlayerFootstep", "im_footstep", function(ply, pos, foot, sound, volume, filter)
        local active_entity = ply:GetActiveWeapon()
        if not active_entity or not active_entity:IsValid() then return false end
        if active_entity:GetClass() ~= "avengers_ironman" then return false end
        ply:EmitSound("player/footsteps/metal" .. math.random(1, 4) .. ".wav")

        return true
    end)
end