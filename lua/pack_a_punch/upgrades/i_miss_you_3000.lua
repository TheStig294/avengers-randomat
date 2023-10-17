local UPGRADE = {}
UPGRADE.id = "i_miss_you_3000"
UPGRADE.class = "avengers_ironman"
UPGRADE.name = "I Miss You 3000"
UPGRADE.desc = "Hold ALT and Left-Click to launch a missile!"

function UPGRADE:Apply(SWEP)
    local owner = SWEP:GetOwner()

    timer.Simple(0.1, function()
        owner:SetCurrentWeapon(2)
    end)

    owner:SetMaterial(TTTPAP.camo)
    owner.PAPIMissYou3000 = true
    local entMeta = FindMetaTable("Entity")

    function entMeta:HandleSuitWeapons(ent)
        if ent:KeyDown(IN_WALK) and ent:KeyDown(IN_ATTACK) and SERVER and ent:GetCurrentWeapon() == 2 and ent:GetNWInt(self.NW.NextThinkWeapon) < CurTime() then
            local energy_amount = 5
            if ent:GetSuitEnergy() < energy_amount then return end
            if ent:GetRockets() < 1 then return end
            ent:SetRockets(ent:GetRockets() - 1)
            ent:SetSuitEnergy(ent:GetSuitEnergy() - energy_amount)
            local im_missile = ents.Create("im_missile")
            im_missile:SetNWInt("damage", 30)
            if not im_missile or not IsValid(im_missile) then return end
            if not ent or not ent:IsValid() then return end
            im_missile:SetPos(ent:EyePos() + ent:EyeAngles():Up() * 150)
            im_missile:Spawn()

            if IsValid(self:GetOwner()) and self:GetOwner().PAPIMissYou3000 then
                im_missile:SetMaterial(TTTPAP.camo)
            end

            im_missile:GetPhysicsObject():SetAngles(ent:EyeAngles())
            im_missile:GetPhysicsObject():SetVelocity(ent:GetEyeTrace().HitPos - ent:GetPos())
            im_missile:SetMaterial(TTTPAP.camo)
            ent:EmitSound("doors/door_latch1.wav")
            ent:SetNWInt(self.NW.NextThinkWeapon, CurTime() + 5)
        end
    end
end

function UPGRADE:Reset()
    for _, ply in ipairs(player.GetAll()) do
        ply.PAPIMissYou3000 = nil
    end

    local entMeta = FindMetaTable("Entity")

    function entMeta:HandleSuitWeapons(ent)
    end
end

TTTPAP:Register(UPGRADE)