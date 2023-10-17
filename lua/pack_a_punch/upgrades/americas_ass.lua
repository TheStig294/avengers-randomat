local UPGRADE = {}
UPGRADE.id = "americas_ass"
UPGRADE.class = "avengers_ttt_shield"
UPGRADE.name = "America's Ass"
UPGRADE.desc = "1-shot kills!"
UPGRADE.damageMult = 50
UPGRADE.noCamo = true

function UPGRADE:Apply(SWEP)
    if CLIENT and SWEP.VElements and SWEP.WElements then
        SWEP.VElements.boomerang.material = TTTPAP.camo
        SWEP.WElements.boomerang.material = TTTPAP.camo
    end

    SWEP:GetOwner().PAPAvengersShield = true

    self:AddHook("WeaponEquip", function(weapon, owner)
        local class = weapon:GetClass()

        if owner.PAPAvengersShield and class == self.class then
            timer.Simple(0.1, function()
                self.noDesc = true
                TTTPAP:ApplyUpgrade(weapon, self)
            end)
        end
    end)
end

function UPGRADE:Reset()
    timer.Simple(0.1, function()
        for _, ply in ipairs(player.GetAll()) do
            ply.PAPAvengersShield = false
        end
    end)
end

TTTPAP:Register(UPGRADE)