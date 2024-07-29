local UPGRADE = {}
UPGRADE.id = "vision_pistol"
UPGRADE.class = "avengers_nick_pistol"
UPGRADE.name = "Vision Pistol"
UPGRADE.desc = "x1.5 firerate, wider FOV"
UPGRADE.firerateMult = 1.5

function UPGRADE:Apply(SWEP)
    local own = self:GetOwner()

    if IsValid(own) then
        own:SetFOV(150)
    end

    function SWEP:Deploy()
        local owner = self:GetOwner()
        if not IsValid(owner) then return end
        owner:SetFOV(150)
    end

    function SWEP:Holster()
        local owner = self:GetOwner()
        if not IsValid(owner) then return end
        owner:SetFOV(0)

        return true
    end
end

TTTPAP:Register(UPGRADE)