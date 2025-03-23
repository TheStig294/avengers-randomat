AddCSLuaFile()

--Sounds
sound.Add({
	name = "TFBow.IronIn",
	channel = CHAN_USER_BASE + 20,
	volume = 1.0,
	sound = "weapons/hawkeye_uni/ironin.wav"
})

sound.Add({
	name = "TFBow.IronOut",
	channel = CHAN_USER_BASE + 21,
	volume = 1.0,
	sound = "weapons/hawkeye_uni/ironout.wav"
})

sound.Add({
	name = "Weapon_bow.boltpull",
	channel = CHAN_USER_BASE + 10,
	volume = 1.0,
	sound = "weapons/tfa_shortbow/pullback.wav"
})

sound.Add({
	name = "Weapon_bow.single",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	sound = "weapons/tfa_shortbow/fire2.wav"
})

sound.Add({
	name = "SF2Bow.Single",
	channel = CHAN_USER_BASE + 10,
	volume = 1.0,
	sound = "weapons/tfa_sf2bow/fire1.wav"
})

sound.Add({
	name = "SF2Bow.Deploy",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	sound = "weapons/tfa_sf2bow/draw.wav"
})

sound.Add({
	name = "SF2Bow.Nock",
	channel = CHAN_USER_BASE + 12,
	volume = 1.0,
	sound = "weapons/tfa_sf2bow/nock.wav"
})

sound.Add({
	name = "SF2Bow.String",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = "weapons/tfa_sf2bow/pullback.wav"
})

sound.Add({
	name = "TFACryBow.single",
	channel = CHAN_USER_BASE + 10,
	volume = 1.0,
	sound = "weapons/tfa_crybow/single.wav"
})

sound.Add({
	name = "TFACryBow.String",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = "weapons/tfa_crybow/pullback.wav"
})

--Ammo Types
game.AddAmmoType({
	name = "predator_arrow",
	dmgtype = DMG_BULLET,
	tracer = TRACER_NONE
})

--Critical SWEP Base Hooks
local function PlayerCarryingTFBowWeapon(ply)
	if not ply then
		if CLIENT then
			if IsValid(LocalPlayer()) then
				ply = LocalPlayer()
			else
				return false, nil, nil
			end
		else
			return false, nil, nil
		end
	end

	local wep = ply:GetActiveWeapon()

	if IsValid(wep) then
		local n = wep:GetClass()
		local nfind = string.find(n, "hawkeye")
		if n == 0 or n == 1 or (wep.Base and wep.Base == "bow_base") then return true, ply, wep end

		return false, ply, wep
	end

	return false, ply, nil
end

hook.Add("AllowPlayerPickup", "TFBowPickupDisable", function(ply, ent)
	local iscarryinghawkeye, pl, wep = PlayerCarryingTFBowWeapon(ply)

	if iscarryinghawkeye then
		return false
	else
		return
	end
end)

hook.Add("PreRender", "prerender_hawkeyebase", function()
	local iscarryinghawkeyeweapon, pl, wep = PlayerCarryingTFBowWeapon()

	if iscarryinghawkeyeweapon then
		wep:PlayerThinkClientFrame(pl)
	end
end)

hook.Add("SetupMove", "hawkeye_setupmove", function(ply, movedata, commanddata)
	local iscarryinghawkeyeweapon, pl, wep = PlayerCarryingTFBowWeapon(ply)

	if iscarryinghawkeyeweapon then
		local speedmult = Lerp(wep:GetIronSightsRatio(), wep.MoveSpeed or 1, wep.IronSightsMoveSpeed or 1)
		movedata:SetMaxClientSpeed(movedata:GetMaxClientSpeed() * speedmult)
		commanddata:SetForwardMove(commanddata:GetForwardMove() * speedmult)
		commanddata:SetSideMove(commanddata:GetSideMove() * speedmult)
	end
end)