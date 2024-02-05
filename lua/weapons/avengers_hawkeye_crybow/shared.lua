-- Variables that are used on both client and server
SWEP.Gun = "hawkeye_crybow" -- must be the name of your swep but NO CAPITALS!

if GetConVar(SWEP.Gun .. "_allowed") ~= nil then
	if not GetConVar(SWEP.Gun .. "_allowed"):GetBool() then
		SWEP.Base = "hawkeye_blacklisted"
		SWEP.PrintName = SWEP.Gun

		return
	end
end

if CLIENT then
	SWEP.PrintName = "Hawkeye Bow"
	SWEP.Slot = 6
	SWEP.Icon = "vgui/ttt/FireBow"
end

if SERVER then
	resource.AddFile("materials/VGUI/ttt/FireBow.vmt")
end

SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.MuzzleAttachment = "muzzle" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName = "Hawkeye Bow" -- Weapon name (Shown on HUD)	
SWEP.SlotPos = 6 -- Position in the slot
SWEP.DrawAmmo = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair = false -- set false if you want no crosshair
SWEP.Weight = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType = "smg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_tfa_crybow.mdl" -- Weapon view model
SWEP.WorldModel = "models/weapons/w_tfa_crybow.mdl" -- Weapon world model
SWEP.ShowWorldModel = true
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound = Sound("TFACryBow.single") -- Script that calls the primary fire sound
SWEP.Primary.RPM = 140 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize = 1 -- Size of a clip
SWEP.Primary.DefaultClip = 25 -- Bullets you start with
SWEP.Primary.Recoil = 2 --Recoil multiplier
SWEP.Primary.KickUp = 3.5 -- Maximum up recoil (rise).  Keep this positive unless you understand the calculations.
SWEP.Primary.KickDown = -1 -- Maximum down recoil (skeet).  Keep this positive unless you understand the calculations.
SWEP.Primary.KickHorizontal = 1 -- Maximum up recoil (stock).
SWEP.Primary.Automatic = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo = "predator_arrow" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.Delay = 0.5

-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.Primary.ArrowMax = {"Nomral", "Fire", "Flash"}

SWEP.Secondary.IronFOV = 50 -- How much you 'zoom' in. Less is more! 
SWEP.Secondary.Automatic = false -- Automatic = true; Semi Auto = false	
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Primary.NumShots = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage = 80 -- Base damage per bullet
SWEP.Primary.Spread = 0.25 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.005 -- Ironsight accuracy, should be the same for shotguns
-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-12.25, -12.608, -1.401)
SWEP.IronSightsAng = Vector(17.553, -5, -39.5)
SWEP.RunSightsPos = Vector(0, 0, -0.5)
SWEP.RunSightsAng = Vector(-10, 2, 15)
SWEP.NearWallSightsPos = Vector(0, -11.056, -6.231)
SWEP.NearWallSightsAng = Vector(60.502, 0, 0)
local sndPowerUp = Sound("weapons/crossbow/hit1.wav")
local sndPowerDown = Sound("Airboat.FireGunRevDown")
local sndTooFar = Sound("buttons/button10.wav")
SWEP.NextShot = CurTime()

function SWEP:Initialize()
	self:GetOwner():SetNWInt('Arrow', 1)

	if CLIENT and self:Clip1() == -1 then
		self:SetClip1(self.Primary.DefaultClip)
	elseif SERVER then
		self.fingerprints = {}
		self:SetIronsights(false)
	end

	self:SetDeploySpeed(self.DeploySpeed)

	-- compat for gmod update
	if self.SetHoldType then
		self:SetHoldType(self.HoldType or "pistol")
	end
end

function SWEP:Equip()
	self:GetOwner():SetNWInt("Arrow", 1)

	timer.Simple(5, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		self:GetOwner():ChatPrint("HAWKEYE BOW: Left-Click: Shoot\nRight-click: Change arrow type")
	end)
end

function SWEP:SetZoom(state)
	if CLIENT then return end
	if not (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer()) then return end

	if state then
		self:GetOwner():SetFOV(64, 0.5)
	else
		self:GetOwner():SetFOV(0, 0.2)
	end
end

SWEP.IronSightTime = 0.4
SWEP.UseArrows = true
SWEP.ArrowModel = "models/weapons/w_tfa_crybow_arrow.mdl"
SWEP.ArrowVelocity = 2600
SWEP.SightWhileDraw = false
SWEP.ShootWhileDraw = false --Can you shoot while draw anim plays?
SWEP.ReloadWhileDraw = false --Can you reload while draw anim plays?
SWEP.SightWhileDraw = false
SWEP.ShootWhileHolster = false --Can you shoot while draw anim plays?
SWEP.ReloadWhileHolster = false --Can you reload while draw anim plays?
SWEP.SightWhileHolster = false
SWEP.UseHands = true
SWEP.SprintHoldType = "normal"
SWEP.MoveSpeed = 0.75 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.5 --Multiply the player's movespeed by this when sighting.
SWEP.DoMuzzleFlash = false

function SWEP:ShootFlare()
	local cone = self.Primary.Cone
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetOwner():GetShootPos()
	bullet.Dir = self:GetOwner():GetAimVector()
	bullet.Spread = Vector(cone, cone, 0)
	bullet.Tracer = 1
	bullet.Force = 2
	bullet.Damage = self.Primary.Damage / 2
	bullet.TracerName = self.Tracer
	bullet.Callback = IgniteTarget
	self:GetOwner():FireBullets(bullet)
end

function SWEP:Arrow()
	local cone = self.Primary.Cone
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetOwner():GetShootPos()
	bullet.Dir = self:GetOwner():GetAimVector()
	bullet.Spread = Vector(cone, cone, 0)
	bullet.Tracer = 1
	bullet.Force = 2
	bullet.Damage = self.Primary.Damage
	bullet.TracerName = self.Tracer
	-- bullet.Callback = IgniteTarget
	self:GetOwner():FireBullets(bullet)
end

function SWEP:Flash()
	local cone = self.Primary.Cone
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetOwner():GetShootPos()
	bullet.Dir = self:GetOwner():GetAimVector()
	bullet.Spread = Vector(cone, cone, 0)
	bullet.Tracer = 1
	bullet.Force = 2
	bullet.Damage = 0
	bullet.TracerName = self.Tracer
	bullet.Callback = Flashyflash
	self:GetOwner():FireBullets(bullet)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if not self:CanPrimaryAttack() then return end
	self:EmitSound(self.Primary.Sound)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	if self:GetOwner():GetNWInt("Arrow") == 1 then
		self:Arrow()
		self:TakePrimaryAmmo(1)
	elseif self:GetOwner():GetNWInt("Arrow") == 2 then
		self:ShootFlare()
		self:TakePrimaryAmmo(1)
	elseif self:GetOwner():GetNWInt("Arrow") == 3 then
		self:CreateArrow("normal", self:GetOwner(), self)
		self.NextShot = CurTime() + 0.5
		self:TakePrimaryAmmo(1)
	end

	if IsValid(self:GetOwner()) then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:GetOwner():ViewPunch(Angle(math.Rand(-0.2, -0.1) * self.Primary.Recoil, math.Rand(-0.1, 0.1) * self.Primary.Recoil, 0))
	end

	if (game.SinglePlayer() and SERVER) or CLIENT then
		self:SetNetworkedFloat("LastShootTime", CurTime())
	end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	if self:GetOwner():GetNWInt("Arrow") == table.Count(self.Primary.ArrowMax) then
		self:GetOwner():SetNWInt("Arrow", 1)
	elseif self:GetOwner():GetNWInt("Arrow") ~= table.Count(self.Primary.ArrowMax) then
		self:GetOwner():SetNWInt("Arrow", self:GetOwner():GetNWInt("Arrow") + 1)
	end

	if SERVER then
		self:GetOwner():ChatPrint(self.Primary.ArrowMax[self:GetOwner():GetNWInt("Arrow")] .. " arrow")
	end
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
	local gap = 40 * scale
	local length = gap + 20 * scale
	--				 x1,		 y1, x2,	 y2
	surface.DrawLine(x - length, y, x - gap, y) -- Left
	surface.DrawLine(x + length, y, x + gap, y) -- Right
	surface.DrawLine(x, y - length, x, y - gap) -- Top
	surface.DrawLine(x, y + length, x, y + gap) -- Bottom
	surface.SetFont("Default")
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos(128, 128)
	local arrowman = "Nomral"

	for k, v in pairs(self.Primary.ArrowMax) do
		if k == self:GetOwner():GetNWInt("Arrow") then
			arrowman = v
		end
	end

	surface.DrawText(arrowman .. " Arrow")
end

if GetConVar("sv_hawkeye_default_clip") == nil then
	print("sv_hawkeye_default_clip is missing! You may have hit the lua limit!")
else
	if GetConVar("sv_hawkeye_default_clip"):GetInt() ~= -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("sv_hawkeye_default_clip"):GetInt()
	end
end

if GetConVar("sv_hawkeye_unique_slots") ~= nil then
	if not GetConVar("sv_hawkeye_unique_slots"):GetBool() then
		SWEP.SlotPos = 2
	end
end

--SWEP.IronSightsPos = Vector( -6.518, -4.646, 2.134 )
--SWEP.IronSightsAng = Vector( 2.737, 0.158, 0 )
--- TTT config values
-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP
-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_PISTOL/2, then this gun can
-- be spawned as a random weapon.
SWEP.AutoSpawnable = false
-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.
SWEP.InLoadoutFor = {nil}

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true
-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true
-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false
-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = false

-- Equipment menu information is only needed on the client
if CLIENT then
	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "Very high damage assault rifle.\n\nHas very high recoil."
	}
end

function SWEP:UpdateAttack()
	self:GetOwner():LagCompensation(true)

	if not endpos then
		endpos = self.Tr.HitPos
	end

	lastpos = endpos

	if self.Tr.Entity:IsValid() then
		endpos = self.Tr.Entity:GetPos()
	end

	local vVel = endpos - self:GetOwner():GetPos()
	local Distance = endpos:Distance(self:GetOwner():GetPos())
	local et = self.startTime + (Distance / self.speed)

	if self.stufff ~= 0 then
		self.stufff = (et - CurTime()) / (et - self.startTime)
	end

	if self.stufff < 0 then
		self:EmitSound(sndPowerUp)
		self.stufff = 0
	end

	if self.stufff == 0 then
		zVel = self:GetOwner():GetVelocity().z
		vVel = vVel:GetNormalized() * math.Clamp(Distance, 0, 7)

		if SERVER then
			local gravity = GetConVarNumber("sv_Gravity")
			vVel:Add(Vector(0, 0, (gravity / 100) * 1.5)) --Player speed. DO NOT MESS WITH THIS VALUE!

			if zVel < 0 then
				vVel:Sub(Vector(0, 0, zVel / 100))
			end

			self:GetOwner():SetVelocity(vVel)
		end
	end

	endpos = nil
	self:GetOwner():LagCompensation(false)
end

function SWEP:EndAttack(shutdownsound)
	if shutdownsound then
		self:EmitSound(sndPowerDown)
	end
end

--Flash--
function SWEP:CreateArrow(aType)
	if SERVER and IsValid(self:GetOwner()) and IsValid(self) then
		local ent = ents.Create("hawkeye_flash_arrow")
		if not ent then return end
		ent.Owner = self:GetOwner()
		ent.Arrowtype = aType
		ent.Inflictor = self
		ent:SetOwner(self:GetOwner())
		local eyeang = self:GetOwner():GetAimVector():Angle()
		local right = eyeang:Right()
		local up = eyeang:Up()
		ent:SetPos(self:GetOwner():GetShootPos() + right * 3 - up * 3)
		ent:SetAngles(self:GetOwner():GetAngles())
		ent:SetPhysicsAttacker(self:GetOwner())
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetVelocity(self:GetOwner():GetAimVector() * 1750)
		end
	end
end