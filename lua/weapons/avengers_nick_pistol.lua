AddCSLuaFile()
SWEP.HoldType = "pistol"

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
	desc = "Nick Furys handly pistol"
}

SWEP.InLoadoutFor = nil
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true

function SWEP:TranslateFOV(fov)
	return fov - 20
end

SWEP.IronSightsPos = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Equip()
	timer.Simple(5, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		self:GetOwner():ChatPrint("NICK FURY'S PISTOL: High DPS, limited vision")
	end)
end

function SWEP:DrawHUD()
	if self:GetNetworkedBool("Ironsights") then return end
	local x, y -- local, always

	-- If we're drawing the local player, draw the crosshair where they're aiming
	-- instead of in the center of the screen.
	if self:GetOwner() == LocalPlayer() and self:GetOwner():ShouldDrawLocalPlayer() then
		local tr = util.GetPlayerTrace(self:GetOwner())
		tr.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_MONSTER + CONTENTS_WINDOW + CONTENTS_DEBRIS + CONTENTS_GRATE + CONTENTS_AUX -- List the enums that should mask the crosshair on camrea/thridperson
		local trace = util.TraceLine(tr)
		local coords = trace.HitPos:ToScreen()
		x, y = coords.x, coords.y
	else
		x, y = ScrW() / 2.0, ScrH() / 2.0 -- Center of screen
	end

	local scale = 10 * self.Primary.Cone
	local LastShootTime = self:GetNetworkedFloat("LastShootTime", 0)
	-- Scale the size of the crosshair according to how long ago we fired our weapon
	scale = scale * (2 - math.Clamp((CurTime() - LastShootTime) * 5, 0.0, 1.0))
	--					R	G	B Alpha
	surface.SetDrawColor(0, 255, 0, 255) -- Sets the color of the lines we're drawing
	-- Draw a crosshair
	local gap = 25 * scale
	local length = gap + 80 * scale
	--				 x1,		 y1, x2,	 y2
	surface.DrawLine(x - length, y, x - gap, y) -- Left
	surface.DrawLine(x + length, y, x + gap, y) -- Right
	surface.DrawLine(x, y - length, x, y - gap) -- Top
	surface.DrawLine(x, y + length, x, y + gap) -- Bottom
	surface.SetFont("Default")
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos(128, 128)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(ScrW() / 2000, ScrH() / 2000.0, ScrW() / 30, ScrH())
end