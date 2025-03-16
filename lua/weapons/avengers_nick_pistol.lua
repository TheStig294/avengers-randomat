AddCSLuaFile()
SWEP.HoldType = "revolver"

if CLIENT then
	SWEP.PrintName = "Nick Fury's Pistol"
	SWEP.Slot = 6
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 54
	SWEP.Icon = "vgui/ttt/icon_pistol"
	SWEP.IconLetter = "u"
end

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.WeaponID = AMMO_PISTOL
SWEP.Primary.Recoil = 1.0
SWEP.Primary.Damage = 35
SWEP.Primary.Delay = 0.20
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 40
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 40
SWEP.Primary.ClipMax = 80
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Sound = Sound("Weapon_FiveSeven.Single")
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.LimitedStock = true

SWEP.EquipMenuData = {
	type = "Weapon",
	desc = "Nick Fury's handy pistol"
}

SWEP.InLoadoutFor = nil
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true
SWEP.IronSightsPos = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Equip()
	timer.Simple(5, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		self:GetOwner():ChatPrint("NICK FURY'S PISTOL: High DPS, limited vision")
	end)
end

function SWEP:DrawHUDBackground()
	surface.SetDrawColor(0, 0, 0)
	surface.DrawRect(ScrW() / 2000, ScrH() / 2000, ScrW() / 3, ScrH())
end