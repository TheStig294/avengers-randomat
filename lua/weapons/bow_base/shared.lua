SWEP.Category = "" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Gun = "" --Make sure this is unique.  
SWEP.Author = "TheForgottenArchitect" --DO NOT CHANGE, CUZ ITS ME.
SWEP.Contact = "theforgottenarchitect" --Contact me on steam.  Leave a comment first.
SWEP.Purpose = "" --Why do you want this?   Not really necesary.
SWEP.Instructions = "" --Instructions on how to use, lol.  Not really necessary.
SWEP.MuzzleAttachment = "muzzle" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment = "muzzle" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.DrawCrosshair = true -- Draw the crosshair?
SWEP.ViewModelFOV = 65 -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip = false -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)  Note that this breaks c_arms if you set it to true.
SWEP.VMOffset = vector_origin --The viewmodel offset, constantly. 
SWEP.Spawnable = false --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable = false --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.HoldType = "smg" -- This is how others view you carrying the weapon.
SWEP.Primary.Sound = Sound("") -- This is the sound of the gun/bow, when you shoot.
SWEP.Primary.Round = "" -- What kind of bullet does it shoot?
SWEP.Primary.Cone = 0.2 -- This is the accuracy of NPCs.  Not necessary in almost all cases, since I don't even think this base is compatible with NPCs.
SWEP.Primary.Recoil = 1 -- This is the recoil multiplier.  Really, you should keep this at 1 and change the KickUp, KickDown, and KickHorizontal variables.  However, you can change this as a multiplier too.
SWEP.Primary.Damage = 10 -- Damage, in standard damage points.
SWEP.Primary.Spread = .01 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.NumShots = 1 --The number of shots the gun/bow fires.  
SWEP.Primary.RPM = 0 -- This is in Rounds Per Minute / RPM
SWEP.Primary.ClipSize = 0 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.KickUp = 0 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- This is the maximum sideways recoil (no real term)
SWEP.StaticRecoilFactor = 1 / 2 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.Ammo = "none" -- What kind of ammo
SWEP.DrawTime = 1 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.Secondary.ClipSize = 0 -- Size of a clip
SWEP.Secondary.DefaultClip = 0 -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.IronFOV = 0 -- How much you 'zoom' in. Less is more! 
SWEP.SprintFOVOffset = 7.5 --Add this onto the FOV when we're sprinting.
SWEP.MaxRicochet = 1 --Max number of times to ricochet
SWEP.RicochetCoin = 1 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.BoltAction = false --Useless for bow base.
SWEP.Scoped = false --Useless for scoped base.
SWEP.ShellTime = .35 --Life of a shell.  Uselss for bow base.
SWEP.Tracer = 0 --Bullet tracer.
SWEP.UseHands = false --Use c_hands a.k.a playermodel hands?  Disable for CS:S or HL2 direct ports, or anything containing v_arms.
--Sighting Code
SWEP.CLNearWallProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLRunSightsProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLIronSightsProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLCrouchProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLJumpProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier = 0.65 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier = 1.3 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier = 1.1 --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier = 1.3 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier = 1.5 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier = 2 --Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier = 1.35 --Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.05 --The time it takes to enter crouching state
SWEP.WeaponLength = 24 --1.5 Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.DefaultFOV = 90 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.
--VAnimation Support
SWEP.ShootWhileDraw = false --Can you shoot while draw anim plays?
SWEP.ReloadWhileDraw = false --Can you reload while draw anim plays?
SWEP.SightWhileDraw = false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.ReloadWhileHolster = true --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster = true --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster = false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload = true --Cancel out ironsights for reloading.
SWEP.AllowReloadNearWall = true --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult = 1.5 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult = 0.05 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting.

SWEP.IronSightHoldTypes = {
	pistol = "revolver",
	smg = "rpg",
	grenade = "melee",
	ar2 = "rpg",
	shotgun = "ar2",
	rpg = "rpg",
	physgun = "physgun",
	crossbow = "ar2",
	melee = "melee2",
	slam = "camera",
	normal = "fist",
	melee2 = "magic",
	knife = "fist",
	duel = "duel",
	camera = "camera",
	magic = "magic",
	revolver = "revolver"
}

SWEP.SprintHoldTypes = {
	pistol = "normal",
	smg = "passive",
	grenade = "normal",
	ar2 = "passive",
	shotgun = "passive",
	rpg = "passive",
	physgun = "normal",
	crossbow = "passive",
	melee = "normal",
	slam = "normal",
	normal = "normal",
	melee2 = "melee",
	knife = "fist",
	duel = "normal",
	camera = "slam",
	magic = "normal",
	revolver = "pistol"
}

SWEP.IronSightHoldTypeOverride = "smg" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "normal" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
--Allowed VAnimations.  These are autodetected, so not really needed except as an extra precaution.  Don't change these until you get to the next category.
SWEP.DoMuzzleFlash = false
SWEP.CanDrawAnimate = true
SWEP.CanDrawAnimateEmpty = false
SWEP.CanDrawAnimateSilenced = false
SWEP.CanHolsterAnimate = true
SWEP.CanHolsterAnimateEmpty = false
SWEP.CanIdleAnimate = true
SWEP.CanIdleAnimateEmpty = false
SWEP.CanIdleAnimateSilenced = false
SWEP.CanShootAnimate = true
SWEP.CanShootAnimateSilenced = false
SWEP.CanReloadAnimate = true
SWEP.CanReloadAnimateEmpty = false
SWEP.CanReloadAnimateSilenced = false
SWEP.CanDryFireAnimate = false
SWEP.CanDryFireAnimateSilenced = false
--WAnim Support
SWEP.ThirdPersonReloadDisable = true --Disable third person reload?  True disables.--Bob code
--Custom Arrow Entity Code
SWEP.UseArrows = true --You probably want to use these for a bow, unless the velocity is over the maximum supported.
SWEP.ArrowModel = "models/weapons/w_tfa_arrow.mdl" --The arrow model.
--SWEP.ArrowVelocity = 1600 --Uncomment the first set of two dashes to enable.  This allows you to set a manual velocity.
--Stuff you shouldn't touch after this
SWEP.DrawCrosshairDefault = false
local ConDamageMultiplier = 1

if GetConVar("sv_hawkeye_damage_multiplier") == nil then
	ConDamageMultiplier = 1
	print("hawkeye_damage_multiplier is missing! You may have hit the lua limit! Reverting multiplier to 1.")
else
	ConDamageMultiplier = GetConVar("sv_hawkeye_damage_multiplier"):GetFloat()

	if ConDamageMultiplier < 0 then
		ConDamageMultiplier = ConDamageMultiplier * -1
		print("Your damage multiplier was in the negatives. What were you thinking? Your damage multiplier is now corrected to " .. ConDamageMultiplier .. ".")
	end
end

function hawkeye_convar_damage_multiplier(cvar, previous, new)
	print("multiplier has been changed ")

	if GetConVar("sv_hawkeye_damage_multiplier") == nil then
		ConDamageMultiplier = 1
		print("hawkeye_damage_multiplier is missing! Reverting to defaults.")
	else
		ConDamageMultiplier = GetConVar("sv_hawkeye_damage_multiplier"):GetFloat()

		if ConDamageMultiplier < 0 then
			ConDamageMultiplier = ConDamageMultiplier * -1
			print("Your damage multiplier was in the negatives. What were you thinking? Your damage multiplier is now corrected to " .. ConDamageMultiplier .. ".")
		end
	end
end

cvars.AddChangeCallback("sv_hawkeye_damage_multiplier", hawkeye_convar_damage_multiplier)

function hawkeye_new_clips(cvar, previous, new)
	print("The default clip multiplier has changed. A server restart will be required to apply these changes.")
end

cvars.AddChangeCallback("sv_hawkeye_default_clip", hawkeye_new_clips)

if GetConVarNumber("sv_hawkeye_default_clip") == nil then
	print("sv_hawkeye_default_clip is missing! You have likely reached the lua limit.")
else
	if GetConVar("sv_hawkeye_default_clip"):GetInt() >= 0 then
		print("Weapons on the TFBow Base will now spawn with " .. GetConVarNumber("sv_hawkeye_default_clip") .. " clips/quivers.")
	else
		print("Default clips will be not be modified")
	end
end

local function pow(num, power)
	return math.pow(num, power)
end

local function QerpIn(progress, startval, change, totaltime)
	if not totaltime then
		totaltime = 1
	end

	return startval + change * pow(progress / totaltime, 2)
end

local function QerpOut(progress, startval, change, totaltime)
	if not totaltime then
		totaltime = 1
	end

	return startval - change * pow(progress / totaltime, 2)
end

local function Qerp(progress, startval, endval, totaltime)
	change = endval - startval

	if not totaltime then
		totaltime = 1
	end

	if progress < totaltime / 2 then return QerpIn(progress, startval, change / 2, totaltime / 2) end

	return QerpOut(totaltime - progress, endval, change / 2, totaltime / 2)
end

local function QerpAngle(progress, startang, endang, totaltime)
	if not totaltime then
		totaltime = 1
	end

	return LerpAngle(Qerp(progress, 0, 1, totaltime), startang, endang)
end

local function QerpVector(progress, startang, endang, totaltime)
	if not totaltime then
		totaltime = 1
	end

	local startx, starty, startz, endx, endy, endz
	startx = startang.x
	starty = startang.y
	startz = startang.z
	endx = endang.x
	endy = endang.y
	endz = endang.z

	return Vector(Qerp(progress, startx, endx, totaltime), Qerp(progress, starty, endy, totaltime), Qerp(progress, startz, endz, totaltime))
end

function SWEP:GetMuzzlePos()
	if not IsValid(self) then return nil end
	if not IsValid(self:GetOwner()) then return nil end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local obj = vm:LookupAttachment(self.MuzzleAttachment)
	local muzzlepos = vm:GetAttachment(obj)

	return muzzlepos
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "IronSights")
	self:NetworkVar("Bool", 1, "IronSightsRaw")
	self:NetworkVar("Bool", 2, "Holstering")
	self:NetworkVar("Bool", 3, "Sprinting")
	self:NetworkVar("Bool", 4, "Drawing")
	self:NetworkVar("Bool", 5, "Reloading")
	self:NetworkVar("Bool", 6, "Shooting")
	self:NetworkVar("Bool", 7, "NearWall")
	self:NetworkVar("Bool", 8, "Silenced")
	self:NetworkVar("Float", 0, "DrawingEnd")
	self:NetworkVar("Float", 1, "HolsteringEnd")
	self:NetworkVar("Float", 2, "ReloadingEnd")
	self:NetworkVar("Float", 3, "ShootingEnd")
	self:NetworkVar("Float", 4, "NextIdleAnim")
	self:NetworkVar("Float", 5, "IronSightsRatio")
	self:NetworkVar("Float", 6, "RunSightsRatio")
	self:NetworkVar("Float", 7, "CrouchingRatio")
	self:NetworkVar("Float", 8, "JumpingRatio")
	self:NetworkVar("Float", 9, "NearWallRatio")
end

function SWEP:ResetSightsProgress()
	self.RunSightsProgress = 0

	if CLIENT then
		self.CLNearWallProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLRunSightsProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLIronSightsProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLCrouchProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLJumpProgress = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
	end

	self:SetIronSightsRatio(0)
	self:SetRunSightsRatio(0)
end

function SWEP:DetectValidAnimations()
	if not IsValid(self) or not IsValid(self:GetOwner()) then return end
	local vm = self:GetOwner():GetViewModel()

	if IsValid(vm) then
		self.CanDrawAnimate = true
		self.CanDrawAnimateEmpty = false
		self.CanDrawAnimateSilenced = false
		self.CanHolsterAnimate = true
		self.CanHolsterAnimateEmpty = false
		self.CanIdleAnimate = true
		self.CanIdleAnimateEmpty = false
		self.CanIdleAnimateSilenced = false
		self.CanShootAnimate = true
		self.CanShootAnimateSilenced = false
		self.CanReloadAnimate = true
		self.CanReloadAnimateEmpty = false
		self.CanReloadAnimateSilenced = false
		self.CanDryFireAnimate = false
		self.CanDryFireAnimateSilenced = false
		local seq
		seq = vm:SelectWeightedSequence(ACT_VM_DRAW)

		if seq ~= -1 then
			self.CanDrawAnimate = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_DRAW_EMPTY)

		if seq ~= -1 then
			self.CanDrawAnimateEmpty = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_DRAW_SILENCED)

		if seq ~= -1 then
			self.CanDrawAnimateSilenced = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_HOLSTER)

		if seq ~= -1 then
			self.CanHolsterAnimate = true
		else
			self.CanHolsterAnimate = false
		end

		seq = vm:SelectWeightedSequence(ACT_VM_HOLSTER_EMPTY)

		if seq ~= -1 then
			self.CanHolsterAnimateEmpty = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_IDLE)

		if seq ~= -1 then
			self.CanIdleAnimate = true
		else
			self.CanIdleAnimate = false
		end

		seq = vm:SelectWeightedSequence(ACT_VM_IDLE_EMPTY)

		if seq ~= -1 then
			self.CanIdleAnimateEmpty = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_IDLE_SILENCED)

		if seq ~= -1 then
			self.CanIdleAnimateSilenced = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_PRIMARYATTACK_SILENCED)

		if seq ~= -1 then
			self.CanShootAnimateSilenced = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_RELOAD)

		if seq ~= -1 then
			self.CanReloadAnimate = true
		else
			self.CanReloadAnimate = false
		end

		seq = vm:SelectWeightedSequence(ACT_VM_RELOAD_EMPTY)

		if seq ~= -1 then
			self.CanReloadAnimateEmpty = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_RELOAD_SILENCED)

		if seq ~= -1 then
			self.CanReloadAnimateSilenced = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_DRYFIRE)

		if seq ~= -1 then
			self.CanDryFireAnimate = true
		end

		seq = vm:SelectWeightedSequence(ACT_VM_DRYFIRE_SILENCED)

		if seq ~= -1 then
			self.CanDryFireAnimateSilenced = true
		end
	else
		return false
	end

	return true
end

function SWEP:ChooseDrawAnim()
	local tanim = ACT_VM_DRAW
	local success = true

	if self.CanDrawAnimateSilenced and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
		tanim = ACT_VM_DRAW_SILENCED
	else
		if self.CanDrawAnimateEmpty then
			if self:Clip1() <= 0 then
				self:SendWeaponAnim(ACT_VM_DRAW_EMPTY)
				tanim = ACT_VM_DRAW_EMPTY
			else
				if self.CanDrawAnimate then
					self:SendWeaponAnim(ACT_VM_DRAW)
				else
					local _, tanim2 = self:ChooseIdleAnim()
					tanim = tanim2
					success = false
				end
			end
		else
			if self.CanDrawAnimate then
				self:SendWeaponAnim(ACT_VM_DRAW)
			else
				local _, tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success = false
			end
		end
	end

	return success, tanim
end

function SWEP:ChooseHolsterAnim()
	local tanim = ACT_VM_HOLSTER
	local success = true

	if not self:GetSilenced() then
		if self.CanHolsterAnimateEmpty then
			if self:Clip1() <= 0 then
				self:SendWeaponAnim(ACT_VM_HOLSTER_EMPTY)
				tanim = ACT_VM_HOLSTER_EMPTY
			else
				if self.CanHolsterAnimate then
					self:SendWeaponAnim(ACT_VM_HOLSTER)
				else
					self:SendWeaponAnim(ACT_VM_HOLSTER_EMPTY)
					tanim = ACT_VM_HOLSTER_EMPTY
				end
			end
		else
			if self.CanHolsterAnimate then
				self:SendWeaponAnim(ACT_VM_HOLSTER)
			else
				local _, tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success = false
			end
		end
	else
		local _, tanim2 = self:ChooseIdleAnim()
		tanim = tanim2
		success = false
	end

	return success, tanim
end

function SWEP:ChooseReloadAnim()
	local tanim = ACT_VM_RELOAD
	local success = true

	if self.CanReloadAnimateSilenced and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_RELOAD_SILENCED)
		tanim = ACT_VM_RELOAD_SILENCED
	else
		if self.CanReloadAnimateEmpty then
			if self:Clip1() <= 0 then
				self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
				tanim = ACT_VM_RELOAD_EMPTY
			else
				if self.CanReloadAnimate then
					self:SendWeaponAnim(ACT_VM_RELOAD)
				else
					local _, tanim2 = self:ChooseIdleAnim()
					tanim = tanim2
					success = false
				end
			end
		else
			if self.CanReloadAnimate then
				self:SendWeaponAnim(ACT_VM_RELOAD)
			else
				local _, tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success = false
			end
		end
	end

	return success, tanim
end

function SWEP:ChooseIdleAnim()
	local tanim = ACT_VM_IDLE

	if self.CanIdleAnimateSilenced and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
		tanim = ACT_VM_IDLE_SILENCED
	else
		if self.CanIdleAnimateEmpty then
			if self:Clip1() <= 0 then
				self:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
				tanim = ACT_VM_IDLE_EMPTY
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end
		else
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end

	return true, tanim
end

function SWEP:CalculateConeRecoil()
	if not IsValid(self) then return 0, 0 end
	if not IsValid(self:GetOwner()) then return 0, 0 end
	local CurrentRecoil
	local CurrentCone
	local basedamage
	local tmpiron = self:GetIronSights()
	local dynacc = false
	local isr = self:GetIronSightsRatio()

	if GetConVarNumber("sv_hawkeye_dynamicaccuracy", 1) == 1 then
		dynacc = true
	end

	local isr_1 = math.Clamp(isr * 2, 0, 1)
	local isr_2 = math.Clamp((isr - 0.5) * 2, 0, 1)
	local acv = self.Primary.Spread or self.Primary.Accuracy
	local recv = self.Primary.Recoil

	if dynacc then
		CurrentCone = Lerp(isr_2, Lerp(isr_1, acv, acv * self.ChangeStateAccuracyMultiplier), self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr_2, Lerp(isr_1, recv, recv * self.ChangeStateRecoilMultiplier), recv * self.IronRecoilMultiplier)
	else
		CurrentCone = Lerp(isr, acv, self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr, recv, recv * self.IronRecoilMultiplier)
	end

	local crc_1 = math.Clamp(self:GetCrouchingRatio() * 2, 0, 1)
	local crc_2 = math.Clamp((self:GetCrouchingRatio() - 0.5) * 2, 0, 1)

	if dynacc then
		CurrentCone = Lerp(crc_2, Lerp(crc_1, CurrentCone, CurrentCone * self.ChangeStateAccuracyMultiplier), CurrentCone * self.CrouchAccuracyMultiplier)
		CurrentRecoil = Lerp(crc_2, Lerp(crc_1, CurrentRecoil, self.Primary.Recoil * self.ChangeStateRecoilMultiplier), CurrentCone * self.CrouchRecoilMultiplier)
	end

	local ovel = self:GetOwner():GetVelocity():Length()
	local vfc_1 = math.Clamp(ovel / 180, 0, 1)

	if dynacc then
		CurrentCone = Lerp(vfc_1, CurrentCone, CurrentCone * self.WalkAccuracyMultiplier)
		CurrentRecoil = Lerp(vfc_1, CurrentRecoil, CurrentRecoil * self.WallRecoilMultiplier)
	end

	local jr = self:GetJumpingRatio()

	if dynacc then
		CurrentCone = Lerp(jr, CurrentCone, CurrentCone * self.JumpAccuracyMultiplier)
		CurrentRecoil = Lerp(jr, CurrentRecoil, CurrentRecoil * self.JumpRecoilMultiplier)
	end

	return CurrentCone, CurrentRecoil
end

function SWEP:ClientCalculateConeRecoil()
	if not IsValid(self) then return 0, 0 end
	if not IsValid(self:GetOwner()) then return 0, 0 end
	local CurrentRecoil
	local CurrentCone
	local basedamage
	local tmpiron = self:GetIronSights()
	local dynacc = false
	local isr = self.CLIronSightsProgress

	if GetConVarNumber("sv_hawkeye_dynamicaccuracy", 1) == 1 then
		dynacc = true
	end

	local isr_1 = math.Clamp(isr * 2, 0, 1)
	local isr_2 = math.Clamp((isr - 0.5) * 2, 0, 1)
	local acv = self.Primary.Spread or self.Primary.Accuracy
	local recv = self.Primary.Recoil

	if dynacc then
		CurrentCone = Lerp(isr_2, Lerp(isr_1, acv, acv * self.ChangeStateAccuracyMultiplier), self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr_2, Lerp(isr_1, recv, recv * self.ChangeStateRecoilMultiplier), recv * self.IronRecoilMultiplier)
	else
		CurrentCone = Lerp(isr, acv, self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr, recv, recv * self.IronRecoilMultiplier)
	end

	local crc_1 = math.Clamp(self.CLCrouchProgress * 2, 0, 1)
	local crc_2 = math.Clamp((self.CLCrouchProgress - 0.5) * 2, 0, 1)

	if dynacc then
		CurrentCone = Lerp(crc_2, Lerp(crc_1, CurrentCone, CurrentCone * self.ChangeStateAccuracyMultiplier), CurrentCone * self.CrouchAccuracyMultiplier)
		CurrentRecoil = Lerp(crc_2, Lerp(crc_1, CurrentRecoil, self.Primary.Recoil * self.ChangeStateRecoilMultiplier), CurrentCone * self.CrouchRecoilMultiplier)
	end

	local ovel = self:GetOwner():GetVelocity():Length()
	local vfc_1 = math.Clamp(ovel / 180, 0, 1)

	if dynacc then
		CurrentCone = Lerp(vfc_1, CurrentCone, CurrentCone * self.WalkAccuracyMultiplier)
		CurrentRecoil = Lerp(vfc_1, CurrentRecoil, CurrentRecoil * self.WallRecoilMultiplier)
	end

	local jr = self.CLJumpProgress

	if dynacc then
		CurrentCone = Lerp(jr, CurrentCone, CurrentCone * self.JumpAccuracyMultiplier)
		CurrentRecoil = Lerp(jr, CurrentRecoil, CurrentRecoil * self.JumpRecoilMultiplier)
	end

	return CurrentCone, CurrentRecoil
end

function SWEP:InitDrawCode(instr)
	if CLIENT then
		local t = string.Explode(",", instr, false)

		if t[1] then
			self.CanDrawAnimate = false

			if t[1] == 1 then
				self.CanDrawAnimate = true
			end
		end

		if t[2] then
			self.CanDrawAnimateEmpty = false

			if t[2] == 1 then
				self.CanDrawAnimateEmpty = true
			end
		end
	end

	if CurTime() < self:GetReloadingEnd() then
		self:SetReloading(false)
		self:SetReloadingEnd(CurTime() - 1)
	end

	if CurTime() < self:GetHolsteringEnd() then
		self:SetHolstering(false)
		self:SetHolsteringEnd(CurTime() - 1)
	end

	local tmpact = self:GetActivity()

	if not self.LastDrawAnimTime then
		self.LastDrawAnimTime = -1
	end

	local success, anim

	if (tmpact == 0 or not (act == ACT_VM_DRAW or act == ACT_VM_DRAW_EMPTY or act == ACT_VM_DRAW_SILENCED)) and (CurTime() - self.LastDrawAnimTime > 0.2) then
		self.LastDrawAnimTime = CurTime()
		success, anim = self:ChooseDrawAnim()
	end

	self:SetDrawing(success)

	if success then
		local vm = self:GetOwner():GetViewModel()
		local seq = vm:SelectWeightedSequence(anim)
		local seqtime = vm:SequenceDuration(seq)

		if self.ShootWhileDraw == false then
			self:SetNextPrimaryFire(CurTime() + seqtime)
		end

		self:SetDrawingEnd(CurTime() + seqtime)
	end
end

function SWEP:InitHolsterCode(instr)
	self.LastDrawAnimTime = -1

	if CLIENT then
		local t = string.Explode(",", instr, false)

		if t[1] then
			self.CanDrawAnimate = false

			if t[1] == 1 then
				self.CanHolsterAnimate = true
			end
		end

		if t[2] then
			self.CanHolsterAnimateEmpty = false

			if t[2] == 1 then
				self.CanHolsterAnimateEmpty = true
			end
		end
	end

	if SERVER then
		local ha = self:ChooseHolsterAnim()

		if not ha then
			self:SetNWBool("CanHolster", true)
			self:Holster(self:GetNWEntity("SwitchToWep", nil))
			self:SetHolstering(false)

			return
		end

		local seqtime = self:GetOwner():GetViewModel():SequenceDuration()

		if self.ShootWhileHolster == false then
			self:SetNextPrimaryFire(CurTime() + seqtime)
		end

		self:SetHolstering(true)
		self:SetHolsteringEnd(CurTime() + seqtime)
	end
end

function SWEP:Initialize()
	self.DefaultHoldType = self.HoldType
	self.ViewModelFOVDefault = self.ViewModelFOV
	self.DrawCrosshairDefault = self.DrawCrosshair

	if self.DrawCrosshairDefault == nil then
		self.DrawCrosshairDefault = self.DrawCrosshair
	end

	if CLIENT then
		hook.Add("PlayerTick", self, self.PlayerThink)
	end

	self.drawcount = 0
	self.drawcount2 = 0
	self.canholster = false
	self:DetectValidAnimations()
	--self:ChooseDrawAnim()
	self:SendWeaponAnim(0)
	self:SetDeploySpeed(0.001)
end

function SWEP:Deploy()
	self.ViewModelFOVDefault = self.ViewModelFOV
	self.DefaultFOV = self:GetOwner():GetFOV()

	if self.DrawCrosshairDefault == nil then
		self.DrawCrosshairDefault = self.DrawCrosshair
	end

	self.isfirstdraw = false

	if not self.hasdrawnbefore then
		self.hasdrawnbefore = true
		self.isfirstdraw = true
		self.Primary.DefaultClip = 0
	end

	if self.isfirstdraw then
		if SERVER then
			hook.Add("PlayerTick", self, self.PlayerThink)
		end
	end

	self:ResetSightsProgress()
	self:DetectValidAnimations()

	--if (IsFirstTimePredicted()) then
	--	self:ChooseDrawAnim()
	--end
	if self:GetOwner():KeyDown(IN_ATTACK2) and self.SightWhileDraw then
		self:SetIronSights(true)
	end

	if self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():GetVelocity():Length() > 200 then
		self:SetSprinting(true)
	end

	self:SetHoldType(self.HoldType)
	self.OldIronsights = false
	self:SetIronSights(false)
	self:SetIronSightsRaw(false)
	self.OldSprinting = false
	self:SetSprinting(false)
	self:SetShooting(false)
	self:SetNWBool("CanHolster", false)
	self:SetReloading(false)
	self:SetReloadingEnd(CurTime() - 1)
	self:SetShootingEnd(CurTime() - 1)
	self:SetDrawingEnd(CurTime() - 1)
	self:SetHolsteringEnd(CurTime() - 1)
	self:SetDrawing(true)
	self:SetHolstering(false)
	self:SetIronSightsRatio(0)
	self:SetRunSightsRatio(0)
	self:SetCrouchingRatio(0)
	self:SetJumpingRatio(0)
	self:SetNextIdleAnim(CurTime() - 1)
	self:SetSilenced(self.Silenced)
	local drawtimerstring = (self.CanDrawAnimate and 1 or 0) .. "," .. (self.CanDrawAnimateEmpty and 1 or 0)
	self:SendWeaponAnim(0)
	self:InitDrawCode(drawtimerstring)

	return true
end

function SWEP:Holster(switchtowep)
	if self == switchtowep then return end

	if switchtowep then
		self:SetNWEntity("SwitchToWep", switchtowep)
	end

	self:SetReloading(false)
	self:SetDrawing(false)

	if CurTime() < self:GetDrawingEnd() then
		self:SetDrawingEnd(CurTime() - 1)
	end

	if CurTime() < self:GetReloadingEnd() then
		self:SetReloadingEnd(CurTime() - 1)
	end

	if self:GetNWBool("CanHolster", false) == false then
		if not (self:GetHolstering() and CurTime() < self:GetHolsteringEnd()) then
			local holstertimerstring = (self.CanHolsterAnimate and 1 or 0) .. "," .. (self.CanHolsterAnimateEmpty and 1 or 0)
			self:InitHolsterCode(holstertimerstring)
		else
			if self:GetHolsteringEnd() - CurTime() < 0.05 and self:GetHolstering() then
				self:SetNWBool("CanHolster", true)
				self:Holster(self:GetNWEntity("SwitchToWep", switchtowep))

				return true
			end
		end
	else
		self.DrawCrosshair = self.DrawCrosshairDefault or self.DrawCrosshair
		self:SendWeaponAnim(0)
		dholdt = self.DefaultHoldType or self.HoldType
		self:SetHoldType(dholdt)
		self:SetHolstering(false)
		self:SetHolsteringEnd(CurTime() - 0.1)
		local wep = self:GetNWEntity("SwitchToWep", switchtowep)

		if IsValid(wep) and IsValid(self:GetOwner()) and self:GetOwner():HasWeapon(wep:GetClass()) then
			self:GetOwner():ConCommand("use " .. wep:GetClass())
		end

		return true
	end
end

function SWEP:Precache()
	if self.Primary.Sound then
		util.PrecacheSound(self.Primary.Sound)
	end

	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

function SWEP:ShootBulletInformation()
	if CLIENT and not IsFirstTimePredicted() then return end
	local CurrentDamage
	local CurrentCone, CurrentRecoil = self:CalculateConeRecoil()
	local tmpranddamage = math.Rand(.85, 1.3)
	basedamage = ConDamageMultiplier * self.Primary.Damage
	CurrentDamage = basedamage * tmpranddamage
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
end

function SWEP:PrimaryAttack()
	if self:GetHolstering() then
		if self.ShootWhileHolster == false then
			return
		else
			self:SetHolsteringEnd(CurTime() - 0.1)
			self:SetHolstering(false)
		end
	end

	if self:GetNearWallRatio() > 0.05 then return end

	if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
		if self:GetReloading() == false and self:GetSprinting() == false then
			self:ShootBulletInformation()
			self:TakePrimaryAmmo(1)
			self:SetShooting(true)
			self:SetShootingEnd(CurTime() + 1 / (self.Primary.RPM / 60))
			self:SetNextPrimaryFire(CurTime() + 1 / (self.Primary.RPM / 60))

			if self.Primary.Sound then
				self:EmitSound(self.Primary.Sound)
			end

			--if CLIENT then
			--[[
				if self:Clip1() <= 0 and self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 and ( (CLIENT and GetConVarNumber("cl_hawkeye_autoreload",0)!=0) or ( SERVER and self:GetOwner():GetInfoNum("cl_hawkeye_autoreload",0)!=0) ) then
					timer.Simple(1/(self.Primary.RPM/60),function()
						if IsValid(self) then
							if self:GetHolstering()==false then
								self:Reload()
							end
						end
					end)
				end
				]]
			--
			--end
			self:DoAmmoCheck()
		end
	end
end

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)
	if self.UseArrows and self.UseArrows then
		if ents.Create then
			local i = 0

			while i < num_bullets do
				self:GetOwner():LagCompensation(true)

				if aimcone == nil then
					aimcone = 0
				end

				local arrow = ents.Create("hawkeye_arrow")
				local arrowpos = self:GetOwner():GetShootPos()

				if self.DoMuzzleFlash then
					if not CLIENT then
						self:CallOnClient("ShootEffects", "")
					end

					self:ShootEffects()
				end

				arrow:SetPos(arrowpos)
				local randval = math.Rand(-aimcone / 2, aimcone / 2) * 90
				local tmpang = self:GetOwner():EyeAngles()
				local tmpeyeang = tmpang
				tmpang:RotateAroundAxis(tmpang:Up(), randval)
				local randval = math.Rand(-aimcone / 2, aimcone / 2) * 90
				tmpang:RotateAroundAxis(tmpang:Right(), randval)
				arrow:SetAngles(tmpang)
				arrow.velocity = tmpang:Forward() * 1600 * math.sqrt(damage) * GetConVarNumber("sv_hawkeye_velocity_multiplier", 1)

				if self.ArrowVelocity then
					arrow.velocity = tmpang:Forward() * self.ArrowVelocity * GetConVarNumber("sv_hawkeye_velocity_multiplier", 1)
				end

				arrow.velocity = arrow.velocity + self:GetOwner():GetVelocity() * 0.75
				arrow.Owner = self:GetOwner()
				arrow.mydamage = damage
				arrow:SetOwner(self:GetOwner())
				arrow.gun = self:GetClass()
				arrow:SetModel(self.ArrowModel)
				arrow:Spawn()
				i = i + 1
				self:GetOwner():LagCompensation(false)
			end
		end
	else
		num_bullets = num_bullets or 1
		aimcone = aimcone or 0
		local bullet = {}
		bullet.Num = num_bullets
		bullet.Src = self:GetOwner():GetShootPos() -- Source
		bullet.Dir = self:GetOwner():GetAimVector() -- Dir of bullet
		bullet.Spread = Vector(aimcone, aimcone, 0) -- Aim Cone
		bullet.Tracer = 1000000000 -- Show a tracer on every x bullets
		bullet.TracerName = "None"
		bullet.Force = damage * 0.25 -- Amount of force to give to phys objects
		bullet.Damage = damage
		self:GetOwner():FireBullets(bullet)
	end

	local tmprecoilang = Angle(math.Rand(-self.Primary.KickDown, self.Primary.KickUp) * recoil * -1, math.Rand(-self.Primary.KickHorizontal, self.Primary.KickHorizontal) * recoil, 0)
	self:GetOwner():ViewPunch(tmprecoilang * (1 - self.StaticRecoilFactor))

	if SERVER and game.SinglePlayer() and not self:GetOwner():IsNPC() then
		local sp_eyes = self:GetOwner():EyeAngles()
		sp_eyes.pitch = sp_eyes.pitch + tmprecoilang.pitch
		sp_eyes.yaw = sp_eyes.yaw + tmprecoilang.yaw
		self:GetOwner():SetEyeAngles(sp_eyes)
	end

	if CLIENT and not game.SinglePlayer() and not self:GetOwner():IsNPC() then
		local tmprecoilang2 = Angle(math.Rand(-self.Primary.KickDown, self.Primary.KickUp) * recoil * -1, math.Rand(-self.Primary.KickHorizontal, self.Primary.KickHorizontal) * recoil, 0)
		local eyes = self:GetOwner():EyeAngles()
		eyes.pitch = eyes.pitch + (tmprecoilang2.pitch * self.StaticRecoilFactor)
		eyes.yaw = eyes.yaw + (tmprecoilang2.yaw * self.StaticRecoilFactor)
		self:GetOwner():SetEyeAngles(eyes)
	end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) -- View model animation
	self:GetOwner():SetAnimation(PLAYER_ATTACK1) -- 3rd Person Animation
end

function SWEP:ShootEffects()
	if not IsValid(self) or not IsValid(self:GetOwner()) then return end
	self:GetOwner():MuzzleFlash()
end

function SWEP:DoAmmoCheck()
	if IsValid(self) then
		if SERVER and GetConVar("sv_hawkeye_weapon_strip"):GetBool() then
			if self:Clip1() == 0 and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) == 0 then
				timer.Simple(.1, function()
					if SERVER then
						if IsValid(self) then
							if IsValid(self:GetOwner()) then
								self:GetOwner():StripWeapon(self.Gun)
							end
						end
					end
				end)
			end
		end
	end
end

function SWEP:UserInput()
	self.OldIronsights = self:GetIronSights()
	local is = false

	if IsValid(self:GetOwner()) then
		if (CLIENT and GetConVarNumber("cl_hawkeye_ironsights_toggle", 0) == 0) or (SERVER and self:GetOwner():GetInfoNum("cl_hawkeye_ironsights_toggle", 0) == 0) then
			if self:GetOwner():KeyDown(IN_ATTACK2) then
				is = true
			end
		else
			is = self:GetIronSightsRaw()

			if self:GetOwner():KeyPressed(IN_ATTACK2) then
				is = not is
			end
		end
	end

	self:SetIronSightsRaw(is)
	self:SetIronSights(is)
	self.OldSprinting = self:GetSprinting()
	local spr = false

	if IsValid(self:GetOwner()) then
		local isnumber = is and 1 or 0

		if self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():GetVelocity():Length() > 200 * (self.MoveSpeed * (1 - isnumber) + self.IronSightsMoveSpeed * isnumber) then
			spr = true
		end
	end

	self:SetSprinting(spr)
end

function SWEP:CalculateNearWallSH()
	if not IsValid(self:GetOwner()) then return end
	local vnearwall
	vnearwall = false
	local tracedata = {}
	tracedata.start = self:GetOwner():GetShootPos()
	tracedata.endpos = tracedata.start + self:GetOwner():EyeAngles():Forward() * selfLength
	tracedata.mask = MASK_SHOT
	tracedata.ignoreworld = false
	tracedata.filter = self:GetOwner()
	local traceres = util.TraceLine(tracedata)

	if traceres.Hit then
		if traceres.Fraction > 0 and traceres.Fraction < 1 then
			if traceres.MatType ~= MAT_FLESH and traceres.MatType ~= MAT_GLASS then
				vnearwall = true
			end
		end
	end

	if GetConVarNumber("sv_hawkeye_near_wall", 1) == 0 then
		vnearwall = false
	end

	self:SetNearWallRatio(math.Approach(self:GetNearWallRatio(), vnearwall and 1 or 0, FrameTime() / self.NearWallTime))
end

function SWEP:CalculateNearWallCLF()
	if not CLIENT then return end
	if not IsValid(self:GetOwner()) then return end
	local vnearwall
	vnearwall = false
	local tracedata = {}
	tracedata.start = self:GetOwner():GetShootPos()
	tracedata.endpos = tracedata.start + self:GetOwner():EyeAngles():Forward() * selfLength
	tracedata.mask = MASK_SHOT
	tracedata.ignoreworld = false
	tracedata.filter = self:GetOwner()
	local traceres = util.TraceLine(tracedata)

	if traceres.Hit then
		if traceres.Fraction > 0 and traceres.Fraction < 1 then
			if traceres.MatType ~= MAT_FLESH and traceres.MatType ~= MAT_GLASS then
				vnearwall = true
			end
		end
	end

	if GetConVarNumber("sv_hawkeye_near_wall", 1) == 0 then
		vnearwall = false
	end

	self.CLNearWallProgress = math.Approach(self.CLNearWallProgress, vnearwall and 1 or 0, FrameTime() / self.NearWallTime * GetConVarNumber("host_timescale", 1))
end

function SWEP:IronsSprint()
	local is, oldis, spr, rld, dr, hl, nw
	spr = self:GetSprinting()
	is = self:GetIronSights()
	oldis = self.OldIronsights
	rld = self:GetReloading()
	dr = self:GetDrawing()
	hl = self:GetHolstering()
	nw = false

	if self:GetNearWallRatio() > 0.01 then
		nw = true
	end

	if spr then
		is = false
	end

	if self.UnSightOnReload then
		if rld then
			is = false
		end
	end

	if dr then
		if not self.SightWhileDraw then
			is = false
		end
	end

	if hl then
		if not self.SightWhileHolster then
			is = false
		end
	end

	if nw then
		is = false
	end

	if (oldis ~= is) and IsFirstTimePredicted() then
		if is == false then
			self:EmitSound("TFBow.IronOut")
		else
			self:EmitSound("TFBow.IronIn")
		end
	end

	self:SetIronSights(is)
	self:SetSprinting(spr)

	if (CLIENT and GetConVarNumber("cl_hawkeye_ironsights_resight", 0) == 0) or (SERVER and self:GetOwner():GetInfoNum("cl_hawkeye_ironsights_resight", 0) == 0) then
		self:SetIronSightsRaw(is)
	end
end

function SWEP:ProcessHoldType()
	local dholdt, sprintholdtype
	dholdt = self.DefaultHoldType or self.HoldType
	sprintholdtype = self.SprintHoldTypes[dholdt]

	if self.SprintHoldTypeOverride then
		if self.SprintHoldTypeOverride ~= "" then
			sprintholdtype = self.SprintHoldTypeOverride
		end
	end

	if not sprintholdtype or sprintholdtype == "" then
		sprintholdtype = dholdt
	end

	ironholdtype = self.IronSightHoldTypes[dholdt]

	if self.IronSightHoldTypeOverride then
		if self.IronSightHoldTypeOverride ~= "" then
			ironholdtype = self.IronSightHoldTypeOverride
		end
	end

	if not ironholdtype or ironholdtype == "" then
		ironholdtype = dholdt
	end

	if self:GetSprinting() ~= self.OldSprinting then
		if self:GetSprinting() then
			self:SetHoldType(sprintholdtype)
		else
			self:SetHoldType(dholdt)
		end
	end

	if self:GetIronSights() ~= self.OldIronsights then
		if self:GetIronSights() then
			self:SetHoldType(ironholdtype)
		else
			if self:GetSprinting() then
				self:SetHoldType(sprintholdtype)
			else
				self:SetHoldType(dholdt)
			end
		end
	end
end

function SWEP:ProcessTimers()
	local isreloading, isshooting, isdrawing, isholstering, issighting, issprinting
	isreloading = self:GetReloading()
	isshooting = self:GetShooting()
	isdrawing = self:GetDrawing()
	isholstering = self:GetHolstering()
	issighting = self:GetIronSights()
	issprinting = self:GetSprinting()

	if isreloading and CurTime() > self:GetReloadingEnd() then
		if IsValid(self:GetOwner()) then
			local maxclip = self.Primary.ClipSize
			local curclip = self:Clip1()
			local amounttoreplace = math.min(maxclip - curclip, self:GetOwner():GetAmmoCount(self.Primary.Ammo))
			self:SetClip1(curclip + amounttoreplace)
			self:GetOwner():RemoveAmmo(amounttoreplace, self.Primary.Ammo)
		end

		self:SetReloading(false)
		isreloading = false
	end

	if isholstering and CurTime() > self:GetHolsteringEnd() then
		self:SetNWBool("CanHolster", true)
		self:Holster(self:GetNWEntity("SwitchToWep", nil))
		self:SetHolstering(false)
		isholstering = false
	end

	if isdrawing and CurTime() > self:GetDrawingEnd() then
		self:SetDrawing(false)
		isdrawing = false
	end

	if isshooting and CurTime() > self:GetShootingEnd() then
		self:SetShooting(false)
		isshooting = false

		if self:Clip1() <= 0 and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and ((CLIENT and GetConVarNumber("cl_hawkeye_autoreload", 0) ~= 0) or (SERVER and self:GetOwner():GetInfoNum("cl_hawkeye_autoreload", 0) ~= 0)) then
			if not self:GetHolstering() then
				self:Reload()
				self:SetNextIdleAnim(CurTime() + 0.05)
			end
		end
	end

	if isreloading or isshooting or isdrawing or isholstering then
		self:SetNextIdleAnim(CurTime() - 1)
	else
		if self:GetNextIdleAnim() < CurTime() then
			self:ChooseIdleAnim()
			self:SetNextIdleAnim(CurTime() + self:SequenceDuration())
		end
	end
end

function SWEP:PlayerThink(ply)
	if SERVER then
		if self.PlayerThinkServer then
			self:PlayerThinkServer(ply)
		end
	end

	if CLIENT then
		self:PlayerThinkClient(ply)
	end

	if ply ~= self:GetOwner() then return end
	self:CalculateNearWallSH()
	local is = 0
	local isr = self:GetIronSightsRatio()
	local rs = 0
	local rsr = self:GetRunSightsRatio()
	local tsv = GetConVarNumber("host_timescale", 1)

	if self:GetIronSights() then
		is = 1
	end

	if self:GetSprinting() then
		rs = 1
	end

	local val1, val2
	val1 = isr
	local newratio = math.Approach(isr, is, FrameTime() / self.IronSightTime)
	self:SetIronSightsRatio(newratio)
	val2 = self:GetIronSightsRatio()
	self:SetRunSightsRatio(math.Approach(rsr, rs, FrameTime() / self.IronSightTime))
	self:SetCrouchingRatio(math.Approach(self:GetCrouchingRatio(), self:GetOwner():Crouching() and 1 or 0, FrameTime() / self.ToCrouchTime))
	local jv = not self:GetOwner():IsOnGround()
	self:SetJumpingRatio(math.Approach(self:GetJumpingRatio(), jv and 1 or 0, FrameTime() / self.ToCrouchTime))
end

function SWEP:PlayerThinkServer(ply)
end

function SWEP:PlayerThinkClient(ply)
end

function SWEP:PlayerThinkClientFrame(ply)
	if ply ~= self:GetOwner() then return end
	if not CLIENT then return end
	self:CalculateNearWallCLF()
	local is = 0
	local isr = self.CLIronSightsProgress
	local rs = 0
	local rsr = self.CLRunSightsProgress
	local tsv = GetConVarNumber("host_timescale", 1)
	local crouchr = self.CLCrouchProgress
	local jumpr = self.CLJumpProgress
	local ftv = FrameTime()
	local ftvc = tsv * ftv

	if self:GetIronSights() then
		is = 1
	end

	if self:GetSprinting() then
		rs = 1
	end

	local compensatedft = ftv / self.IronSightTime -- * tsv
	local compensatedft_cr = ftv / self.ToCrouchTime -- * tsv
	local newratio = math.Approach(isr, is, compensatedft)
	self.CLIronSightsProgress = newratio
	newratio = math.Approach(rsr, rs, compensatedft)
	self.CLRunSightsProgress = newratio
	newratio = math.Approach(crouchr, self:GetOwner():Crouching() and 1 or 0, compensatedft_cr)
	self.CLCrouchProgress = newratio
	newratio = math.Approach(jumpr, 1 - (self:GetOwner():IsOnGround() and 1 or 0), compensatedft_cr)
	self.CLJumpProgress = newratio
	local owvel, meetswalkgate, meetssprintgate, walkfactorv, runfactorv, sprintfactorv

	if not self.bobtimevar then
		self.bobtimevar = 0
	end

	owvel = self:GetOwner():GetVelocity():Length()
	meetssprintgate = false
	meetswalkgate = false

	if owvel <= self:GetOwner():GetWalkSpeed() * 0.55 then
		meetswalkgate = true
	end

	if owvel > self:GetOwner():GetWalkSpeed() * 1.2 then
		meetssprintgate = true
	end

	walkfactorv = 10.25
	runfactorv = 16
	sprintfactorv = 24

	if not self.bobtimehasbeensprinting then
		self.bobtimehasbeensprinting = 0
	end

	if not meetssprintgate then
		self.bobtimehasbeensprinting = math.Approach(self.bobtimehasbeensprinting, 0, ftv / (self.IronSightTime / 2))
	else
		self.bobtimehasbeensprinting = math.Approach(self.bobtimehasbeensprinting, 3, ftv)
	end

	if not self:GetOwner():IsOnGround() then
		self.bobtimehasbeensprinting = math.Approach(self.bobtimehasbeensprinting, 0, ftv / (2 / 60))
	end

	if owvel > 1 and self.meetswalkgate then
		if self:GetOwner():IsOnGround() then
			self.bobtimevar = math.Approach(self.bobtimevar, math.Round(self.bobtimevar / 2) * 2, ftv / (2 / 60))
		end
	else
		if self:GetOwner():IsOnGround() then
			self.bobtimevar = self.bobtimevar + ftv * math.max(1, owvel / (runfactorv + (sprintfactorv - runfactorv) * (meetssprintgate and 1 or 0) - (runfactorv - walkfactorv) * (meetswalkgate and 1 or 0)))
		else
			self.bobtimevar = self.bobtimevar + ftv
		end
	end
end

function SWEP:AdjustMouseSensitivity()
	if self:GetIronSights() then
		local sensval = 1 * GetConVarNumber("cl_hawkeye_scope_sensitivity", 1) / 100

		if GetConVarNumber("cl_hawkeye_scope_sensitivity_autoscale", 1) == 1 then
			return sensval * (self:GetOwner():GetFOV() / self.DefaultFOV)
		else
			return sensval
		end
	end

	return 1
end

function SWEP:TranslateFOV(fov)
	--self.ViewModelFOV = fov/self.ViewModelFOVDefault
	local nfov = Lerp(self.CLIronSightsProgress, fov, self.Secondary.IronFOV)

	return Lerp(self.CLRunSightsProgress, nfov, nfov + self.SprintFOVOffset)
end

function SWEP:Think()
	self:ProcessTimers()
	self:UserInput()
	self:IronsSprint()
	self:ProcessHoldType()
	--self:NextThink(CurTime())
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	if self:GetReloading() then return end

	if self.AllowReloadNearWall == false then
		if self:GetNearWallRatio() > 0.05 then return end
	end

	if self:GetHolstering() then
		if self.ReloadWhileHolster == false then
			return
		else
			self:SetHolsteringEnd(CurTime() - 0.1)
			self:SetHolstering(false)
		end
	end

	if self:GetDrawing() and self.ReloadWhileDraw == false then return end

	if CurTime() < self:GetReloadingEnd() then
		self:SetReloadingEnd(CurTime() - 1)
	end

	if self:Clip1() < self.Primary.ClipSize and self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0 then
		if timer.Exists(self:EntIndex() .. "HolsterTimer") then
			timer.Destroy(self:EntIndex() .. "HolsterTimer")
			self:SetHolstering(false)
		end

		self:SetReloading(true)
		--self:DefaultReload( ACT_VM_RELOAD )
		self:ChooseReloadAnim()

		if not self.ThirdPersonReloadDisable then
			self:GetOwner():SetAnimation(PLAYER_RELOAD) -- 3rd Person Animation
		end

		local AnimationTime = self:GetOwner():GetViewModel():SequenceDuration()
		self.prevdrawcount = self.drawcount
		self:SetReloadingEnd(CurTime() + AnimationTime)
		self.ReloadingTime = CurTime() + AnimationTime
		self:SetNextPrimaryFire(CurTime() + AnimationTime)
		self:SetNextSecondaryFire(CurTime() + AnimationTime)
	end
end

function SWEP:CalculateBob(pos, ang)
	local customboboffsetx, customboboffsety, customboboffsetz, customboboffset, mypi, curtimecompensated, owvel, runspeed, sprintspeed, timehasbeensprinting, tironsightscale
	tironsightscale = 1 - 0.6 * self:GetIronSightsRatio()
	owvel = self:GetOwner():GetVelocity():Length()
	runspeed = self:GetOwner():GetWalkSpeed()
	curtimecompensated = self.bobtimevar or 0
	timehasbeensprinting = self.bobtimehasbeensprinting or 0

	if not self.BobScaleCustom then
		self.BobScaleCustom = 1
	end

	mypi = 0.5 * 3.14159
	customboboffsetx = math.cos(mypi * curtimecompensated * 0.5)
	customboboffsetz = math.sin(mypi * curtimecompensated)
	customboboffsety = math.sin(mypi * curtimecompensated * 3 / 8) * 0.5
	customboboffsetx = customboboffsetx - (math.sin(mypi * (timehasbeensprinting / 2)) * 0.5 + math.sin(mypi * (timehasbeensprinting / 6)) * 2) * math.max(0, (owvel - runspeed * 0.8) / runspeed)
	customboboffset = Vector(customboboffsetx, customboboffsety, customboboffsetz)
	customboboffset = customboboffset * self.BobScaleCustom * 0.3
	ang:RotateAroundAxis(ang:Right(), customboboffset.x)
	ang:RotateAroundAxis(ang:Up(), customboboffset.y)
	ang:RotateAroundAxis(ang:Forward(), customboboffset.z)
	local localisedmove, localisedangle = WorldToLocal(self:GetOwner():GetVelocity(), self:GetOwner():GetVelocity():Angle(), Vector(0, 0, 0), self:GetOwner():EyeAngles())
	ang:RotateAroundAxis(ang:Forward(), -(math.Approach(localisedmove.y, 0, 1) / (runspeed / 8) * tironsightscale))
	ang:RotateAroundAxis(ang:Right(), -(math.Approach(localisedmove.x, 0, 1) / runspeed) * tironsightscale)
	pos:Add(ang:Right() * customboboffset.x)
	pos:Add(ang:Forward() * customboboffset.y)
	pos:Add(ang:Up() * customboboffset.z)
	--And now you're done with the messiest part of ALL of my code!  :D

	return pos, ang
end

function SWEP:GetViewModelPosition(pos, ang)
	local isp = self.CLIronSightsProgress --self:GetIronSightsRatio()
	local rsp = self.CLRunSightsProgress --self:GetRunSightsRatio()
	local nwp = self.CLNearWallProgress --self:GetNearWallRatio()
	local tmp_ispos = self.SightsPos or self.IronSightsPos
	local tmp_isa = self.SightsAng or self.IronSightsAng
	local tmp_rspos = self.RunSightsPos or tmp_ispos
	local tmp_rsa = self.RunSightsAng or tmp_isa
	if tmp_isa == nil then return end
	local ang2 = Angle(ang.p, ang.y, ang.r)
	local ang3 = Angle(ang.p, ang.y, ang.r)
	local ang4 = Angle(ang.p, ang.y, ang.r)
	self.SwayScale = Lerp(isp, 1, self.IronBobMult)
	self.SwayScale = Lerp(rsp, self.SwayScale, self.SprintBobMult)
	--self.BobScale 	= Lerp(isp,1,self.IronBobMult)
	--self.BobScale  = Lerp(rsp,self.BobScale,self.SprintBobMult)
	self.BobScale = 0
	self.BobScaleCustom = Lerp(isp, 1, self.IronBobMult)
	self.BobScaleCustom = Lerp(rsp, self.BobScaleCustom, self.SprintBobMult)
	ang2:RotateAroundAxis(ang2:Right(), tmp_isa.x)
	ang2:RotateAroundAxis(ang2:Up(), tmp_isa.y)
	ang2:RotateAroundAxis(ang2:Forward(), tmp_isa.z)
	ang = QerpAngle(isp, ang, ang2)
	ang3:RotateAroundAxis(ang3:Right(), tmp_rsa.x)
	ang3:RotateAroundAxis(ang3:Up(), tmp_rsa.y)
	ang3:RotateAroundAxis(ang3:Forward(), tmp_rsa.z)
	ang = QerpAngle(rsp, ang, ang3)
	local tmp_nwsightsang = tmp_rsa

	if self.NearWallSightsAng then
		tmp_nwsightsang = self.NearWallSightsAng
	end

	ang4:RotateAroundAxis(ang4:Right(), tmp_nwsightsang.x)
	ang4:RotateAroundAxis(ang4:Up(), tmp_nwsightsang.y)
	ang4:RotateAroundAxis(ang4:Forward(), tmp_nwsightsang.z)
	ang = QerpAngle(nwp, ang, ang4)
	pos = pos + self.VMOffset
	target = pos * 1 -- Copy pos to target
	target:Add(ang:Right() * tmp_ispos.x)
	target:Add(ang:Forward() * tmp_ispos.y)
	target:Add(ang:Up() * tmp_ispos.z)
	pos = QerpVector(isp, pos, target)
	target = pos * 1 -- Copy pos to target
	target:Add(ang:Right() * tmp_rspos.x)
	target:Add(ang:Forward() * tmp_rspos.y)
	target:Add(ang:Up() * tmp_rspos.z)
	pos = QerpVector(rsp, pos, target)
	local tmp_nwsightspos = tmp_rspos

	if self.NearWallSightsPos then
		tmp_nwsightspos = self.NearWallSightsPos
	end

	target = pos * 1 -- Copy pos to target
	target:Add(ang:Right() * tmp_nwsightspos.x)
	target:Add(ang:Forward() * tmp_nwsightspos.y)
	target:Add(ang:Up() * tmp_nwsightspos.z)
	pos = QerpVector(nwp, pos, target)
	--Start viewbob code
	local gunbobintensity = GetConVarNumber("sv_hawkeye_gunbob_intensity", 1)
	local newpos, newang = self:CalculateBob(Vector(0, 0, 0), Angle(0, 0, 0))
	ang:RotateAroundAxis(ang:Right(), newang.p * gunbobintensity)
	ang:RotateAroundAxis(ang:Up(), newang.y * gunbobintensity)
	ang:RotateAroundAxis(ang:Forward(), newang.r * gunbobintensity)
	pos:Add(ang:Right() * newpos.y * gunbobintensity)
	pos:Add(ang:Forward() * newpos.x * gunbobintensity)
	pos:Add(ang:Up() * newpos.z * gunbobintensity)

	return pos, ang
end

function SWEP:CalcView(ply, pos, ang, fov)
	if ply ~= LocalPlayer() then return end
	if not CLIENT then return end
	local viewbobintensity = 0.3 * GetConVarNumber("sv_hawkeye_viewbob_intensity", 1)
	local newpos, newang = self:CalculateBob(Vector(0, 0, 0), Angle(0, 0, 0))
	ang:RotateAroundAxis(ang:Right(), newang.p * viewbobintensity * -0.3)
	ang:RotateAroundAxis(ang:Up(), newang.y * viewbobintensity * -0.3)
	ang:RotateAroundAxis(ang:Forward(), newang.r * viewbobintensity * -0.3)
	pos:Add(ang:Right() * newpos.x * -1 * viewbobintensity)
	pos:Add(ang:Forward() * newpos.y * -1 * viewbobintensity)
	pos:Add(ang:Up() * newpos.z * -1 * viewbobintensity)

	return pos, ang, fov
end

function SWEP:DrawHUD()
	local drawcrossy
	drawcrossy = self.DrawCrosshairDefault

	if not drawcrossy then
		drawcrossy = self.DrawCrosshair
	end

	local crossa = GetConVarNumber("cl_hawkeye_crosshair_a", 220) * math.min(1 - self.CLIronSightsProgress, 1 - self.CLRunSightsProgress, 1 - self.CLNearWallProgress)
	--[[
	if self:GetIronSights() then
		drawcrossy = false
	end
	
	if self:GetSprinting() then
		drawcrossy = false
	end
	
	if self:GetNearWallRatio()>0.05 then
		drawcrossy = false
	end
	]]
	--
	self.DrawCrosshair = false

	if drawcrossy then
		if GetConVarNumber("cl_hawkeye_custom_crosshair") == 1 then
			if IsValid(LocalPlayer()) and self:GetOwner() == LocalPlayer() then
				local x, y -- local, always
				local s_cone, recoil = self:ClientCalculateConeRecoil()

				-- If we're drawing the local player, draw the crosshair where they're aiming
				-- instead of in the center of the screen.
				if self:GetOwner():ShouldDrawLocalPlayer() then
					local tr = util.GetPlayerTrace(self:GetOwner())
					tr.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_MONSTER + CONTENTS_WINDOW + CONTENTS_DEBRIS + CONTENTS_GRATE + CONTENTS_AUX -- List the enums that should mask the crosshair on camrea/thridperson
					local trace = util.TraceLine(tr)
					local coords = trace.HitPos:ToScreen()
					x, y = coords.x, coords.y
				else
					x, y = ScrW() / 2.0, ScrH() / 2.0 -- Center of screen
				end

				local crossr, crossg, crossb, crosslen
				crossr = GetConVarNumber("cl_hawkeye_crosshair_r", 225)
				crossg = GetConVarNumber("cl_hawkeye_crosshair_g", 225)
				crossb = GetConVarNumber("cl_hawkeye_crosshair_b", 225)
				crosslen = GetConVarNumber("cl_hawkeye_crosshair_length", 1) * 0.01
				local scale = (s_cone * 90) / self:GetOwner():GetFOV() * 480
				local gap = scale
				local length = gap + ScrW() * crosslen
				surface.SetDrawColor(crossr, crossg, crossb, crossa)
				surface.DrawLine(x - length, y, x - gap, y) -- Left
				surface.DrawLine(x + length, y, x + gap, y) -- Right
				surface.DrawLine(x, y - length, x, y - gap) -- Top
				surface.DrawLine(x, y + length, x, y + gap) -- Bottom
			end
		else
			if math.min(1 - self.CLIronSightsProgress, 1 - self.CLRunSightsProgress, 1 - self.CLNearWallProgress) > 0.5 then
				self.DrawCrosshair = true
			end
		end
	end
end