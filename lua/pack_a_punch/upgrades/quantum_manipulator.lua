local UPGRADE = {}
UPGRADE.id = "quantum_manipulator"
UPGRADE.class = "avengers_ttt_minifier"
UPGRADE.name = "Quantum Manipulator"
UPGRADE.desc = "x2 size manipulation!"

function UPGRADE:Apply(SWEP)
    SWEP.ShrinkScale = SWEP.ShrinkScale / 2
end

TTTPAP:Register(UPGRADE)