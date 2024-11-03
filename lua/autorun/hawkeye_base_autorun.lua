if CLIENT then
	local function hawkeyeOption(panel)
		--Here are whatever default categories you want.
		local hawkeyeOption = {
			Options = {},
			CVars = {},
			Label = "#Presets",
			MenuButton = "1",
			Folder = "hawkeye SWEP Settings"
		}

		hawkeyeOption.Options["#Default"] = {
			sv_hawkeye_weapon_strip = "1",
			sv_hawkeye_damage_multiplier = "1",
			sv_hawkeye_default_clip = "-1",
			sv_hawkeye_velocity_multiplier = "1",
			sv_hawkeye_arrow_lifetime = "30",
			sv_hawkeye_force_multiplier = "1",
			sv_hawkeye_dynamicaccuracy = "1",
			sv_hawkeye_near_wall = "1",
			sv_hawkeye_gunbob_intensity = "1",
			sv_hawkeye_viewbob_intensity = "1",
			cl_hawkeye_scope_sensitivity_autoscale = "1",
			cl_hawkeye_scope_sensitivity = "100",
			cl_hawkeye_autoreload = "1",
			cl_hawkeye_ironsights_toggle = "0",
			cl_hawkeye_ironsights_resight = "1",
			cl_hawkeye_custom_crosshair = "1"
		}

		hawkeyeOption.Options["Realistic"] = {
			sv_hawkeye_weapon_strip = "0",
			sv_hawkeye_damage_multiplier = "0.40",
			sv_hawkeye_default_clip = "5",
			sv_hawkeye_velocity_multiplier = "2.7",
			sv_hawkeye_arrow_lifetime = "-1",
			sv_hawkeye_force_multiplier = "1",
			sv_hawkeye_dynamicaccuracy = "1",
			sv_hawkeye_near_wall = "1",
			sv_hawkeye_gunbob_intensity = "1",
			sv_hawkeye_viewbob_intensity = "1",
			cl_hawkeye_scope_sensitivity_autoscale = "1",
			cl_hawkeye_scope_sensitivity = "100",
			cl_hawkeye_autoreload = "0",
			cl_hawkeye_ironsights_toggle = "0",
			cl_hawkeye_ironsights_resight = "1",
			cl_hawkeye_custom_crosshair = "1"
		}

		panel:AddControl("ComboBox", hawkeyeOption)

		--These are the panel controls.  Adding these means that you don't have to go into the console.
		panel:AddControl("CheckBox", {
			Label = "Dynamic Accuracy",
			Command = "sv_hawkeye_dynamicaccuracy",
		})

		panel:AddControl("CheckBox", {
			Label = "Pull up weapon when near wall",
			Command = "sv_hawkeye_near_wall",
		})

		panel:AddControl("CheckBox", {
			Label = "Strip Empty Weapons",
			Command = "sv_hawkeye_weapon_strip",
		})

		panel:AddControl("Slider", {
			Label = "Damage Multiplier",
			Command = "sv_hawkeye_damage_multiplier",
			Type = "Float",
			Min = "0",
			Max = "5",
		})

		panel:AddControl("Slider", {
			Label = "Velocity Multiplier",
			Command = "sv_hawkeye_velocity_multiplier",
			Type = "Float",
			Min = "0",
			Max = "5",
		})

		panel:AddControl("Slider", {
			Label = "Impact Force Multiplier",
			Command = "sv_hawkeye_force_multiplier",
			Type = "Float",
			Min = "0",
			Max = "5",
		})

		panel:AddControl("Slider", {
			Label = "Default Clip Count (-1 = default)",
			Command = "sv_hawkeye_default_clip",
			Type = "Integer",
			Min = "-1",
			Max = "10",
		})

		panel:AddControl("Slider", {
			Label = "Arrow Entity Life Length",
			Command = "sv_hawkeye_arrow_lifetime",
			Type = "Integer",
			Min = "-1",
			Max = "120",
		})

		panel:AddControl("Slider", {
			Label = "Gun Bob Intensity",
			Command = "sv_hawkeye_gunbob_intensity",
			Type = "Float",
			Min = "0",
			Max = "2",
		})

		panel:AddControl("Slider", {
			Label = "View Bob Intensity",
			Command = "sv_hawkeye_viewbob_intensity",
			Type = "Float",
			Min = "0",
			Max = "2",
		})

		panel:AddControl("CheckBox", {
			Label = "[CL] Automatically Reload",
			Command = "cl_hawkeye_autoreload",
		})

		panel:AddControl("CheckBox", {
			Label = "[CL] Use Custom Crosshair",
			Command = "cl_hawkeye_custom_crosshair",
		})

		panel:AddControl("CheckBox", {
			Label = "[CL] Toggle Ironsights",
			Command = "cl_hawkeye_ironsights_toggle",
		})

		panel:AddControl("CheckBox", {
			Label = "[CL] Preserve Sights On Reload, Sprint, etc.",
			Command = "cl_hawkeye_ironsights_resight",
		})

		panel:AddControl("CheckBox", {
			Label = "[CL] Compensate sensitivity for FOV",
			Command = "cl_hawkeye_scope_sensitivity_autoscale",
		})

		panel:AddControl("Slider", {
			Label = "[CL] Scope sensitivity",
			Command = "cl_hawkeye_scope_sensitivity",
			Type = "Integer",
			Min = "1",
			Max = "100",
		})

		panel:AddControl("Label", {
			Text = "By TheForgottenArchitect"
		})
	end

	function hawkeyeAddOption()
		spawnmenu.AddToolMenuOption("Options", "TFBow SWEP Base Settings", "TFBow SWEP Base Settings", "TFBow SWEP Base Settings", "", "", hawkeyeOption)
	end

	hook.Add("PopulateToolMenu", "hawkeyeAddOption", hawkeyeAddOption)
else
	AddCSLuaFile()
end

--Convars
if GetConVar("Debughawkeye") == nil then
	CreateConVar("Debughawkeye", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Debugging for some TFBow stuff, turning it on won't change much.")
end

if GetConVar("sv_hawkeye_weapon_strip") == nil then
	CreateConVar("sv_hawkeye_weapon_strip", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Allow the removal of empty weapons? 1 for true, 0 for false")
end

if GetConVar("sv_hawkeye_near_wall") == nil then
	CreateConVar("sv_hawkeye_near_wall", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Pull up your weapon and disable shooting when you're too close to a wall?")
end

if GetConVar("sv_hawkeye_damage_multiplier") == nil then
	CreateConVar("sv_hawkeye_damage_multiplier", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Multiplier for TFBow base projectile damage.")
end

if GetConVar("sv_hawkeye_default_clip") == nil then
	CreateConVar("sv_hawkeye_default_clip", "-1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many clips will a weapon spawn with? Negative reverts to default values.")
end

if GetConVar("sv_hawkeye_viewbob_intensity") == nil then
	CreateConVar("sv_hawkeye_viewbob_intensity", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How much the player view itself bobs.")
end

if GetConVar("sv_hawkeye_gunbob_intensity") == nil then
	CreateConVar("sv_hawkeye_gunbob_intensity", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How much the gun itself bobs.")
end

if GetConVar("sv_hawkeye_arrow_lifetime") == nil then
	CreateConVar("sv_hawkeye_arrow_lifetime", "-1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many seconds do arrows last?  -1 for forever, 0 for no time.")
end

if GetConVar("sv_hawkeye_unique_slots") == nil then
	CreateConVar("sv_hawkeye_unique_slots", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Give TFBow-based Weapons unique slots? 1 for true, 0 for false. RESTART AFTER CHANGING.")
end

if GetConVar("sv_hawkeye_velocity_multiplier") == nil then
	CreateConVar("sv_hawkeye_velocity_multiplier", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Arrow velocity multiplier.")
end

if GetConVar("sv_hawkeye_force_multiplier") == nil then
	CreateConVar("sv_hawkeye_force_multiplier", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Arrow force multiplier (not arrow velocity, but how much force they give on impact).")
end

if GetConVar("sv_hawkeye_dynamicaccuracy") == nil then
	CreateConVar("sv_hawkeye_dynamicaccuracy", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Dynamic acuracy?  (e.g.more accurate on crouch, less accurate on jumping.")
end

if GetConVar("cl_hawkeye_scope_sensitivity_autoscale") == nil then
	CreateClientConVar("cl_hawkeye_scope_sensitivity_autoscale", 1, true, true)
end

if GetConVar("cl_hawkeye_scope_sensitivity") == nil then
	CreateClientConVar("cl_hawkeye_scope_sensitivity", 1, true, true)
end

if GetConVar("cl_hawkeye_autoreload") == nil then
	CreateClientConVar("cl_hawkeye_autoreload", 1, true, true)
end

if GetConVar("cl_hawkeye_ironsights_toggle") == nil then
	CreateClientConVar("cl_hawkeye_ironsights_toggle", 0, true, true)
end

if GetConVar("cl_hawkeye_ironsights_resight") == nil then
	CreateClientConVar("cl_hawkeye_ironsights_resight", 1, true, true)
end

if GetConVar("cl_hawkeye_custom_crosshair") == nil then
	CreateClientConVar("cl_hawkeye_custom_crosshair", 1, true, true)
end

if GetConVar("cl_hawkeye_crosshair_r") == nil then
	CreateClientConVar("cl_hawkeye_crosshair_r", 225, true, true)
end

if GetConVar("cl_hawkeye_crosshair_g") == nil then
	CreateClientConVar("cl_hawkeye_crosshair_g", 225, true, true)
end

if GetConVar("cl_hawkeye_crosshair_b") == nil then
	CreateClientConVar("cl_hawkeye_crosshair_b", 225, true, true)
end

if GetConVar("cl_hawkeye_crosshair_a") == nil then
	CreateClientConVar("cl_hawkeye_crosshair_a", 200, true, true)
end

if GetConVar("cl_hawkeye_crosshair_length") == nil then
	CreateClientConVar("cl_hawkeye_crosshair_length", 1, true, true)
end

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