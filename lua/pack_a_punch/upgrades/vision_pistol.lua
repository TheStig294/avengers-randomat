local UPGRADE = {}
UPGRADE.id = "vision_pistol"
UPGRADE.class = "avengers_nick_pistol"
UPGRADE.name = "Vision Pistol"
UPGRADE.desc = "x1.5 firerate, wider FOV"
UPGRADE.firerateMult = 1.5

function UPGRADE:Apply(SWEP)
    SWEP:GetOwner():SetFOV(150)

    function SWEP:Deploy()
        SWEP:GetOwner():SetFOV(150)
    end

    function SWEP:Holster()
        SWEP:GetOwner():SetFOV(0)

        return true
    end
end

TTTPAP:Register(UPGRADE)