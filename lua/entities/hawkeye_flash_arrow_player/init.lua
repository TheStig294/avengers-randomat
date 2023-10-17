AddCSLuaFile("cl_init.lua") -- Make sure clientside
AddCSLuaFile("shared.lua") -- and shared scripts are sent.
include('shared.lua')
local FLASH_INTENSITY = 2250 --the higher the number, the longer the flash will be whitening your screen

local function simplifyangle(angle)
	while angle >= 180 do
		angle = angle - 360
	end

	while angle <= -180 do
		angle = angle + 360
	end

	return angle
end

local TARGET_RADIUS = 600

function ENT:Initialize()
	self.Hit = false
	self.LastSound = CurTime()
	self:SetModel("models/weapons/w_tfa_crybow_arrow.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:DrawShadow(false)
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
		phys:EnableDrag(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:AddGameFlag(FVPHYSICS_NO_PLAYER_PICKUP)
		phys:SetMass(1)
		phys:SetBuoyancyRatio(0)
		phys:EnableGravity(false)
	end

	self.Width = self:BoundingRadius() * 0.5
	self.Target = self.Target or NULL

	timer.Create("tragetfinder", 2, 1, function()
		for k, pl in pairs(player.GetAll()) do
			if CanVictimSeeUs(self:FindTarget(pl), self) then
				self:EmitSound(Sound("weapons/flashbang/flashbang_explode" .. math.random(1, 2) .. ".wav"))
				local ang = (self:GetPos() - pl:GetShootPos()):GetNormalized():Angle()
				local tracedata = {}
				tracedata.start = pl:GetPos()
				tracedata.endpos = self:GetPos()
				tracedata.filter = pl
				local traceRes = pl:GetEyeTrace()
				local tr = util.TraceLine(tracedata)
				local pitch = simplifyangle(ang.p - pl:EyeAngles().p)
				local yaw = simplifyangle(ang.y - pl:EyeAngles().y)
				local dist = pl:GetShootPos():Distance(self:GetPos())
				local endtime = FLASH_INTENSITY / dist
				local endtime = FLASH_INTENSITY / dist

				if endtime > 6 then
					endtime = 6
				elseif endtime < 0.4 then
					endtime = 0.4
				end

				simpendtime = math.floor(endtime)
				tenthendtime = math.floor((endtime - simpendtime) * 10)

				--in FOV
				if (pitch > -45 and pitch < 45 and yaw > -45 and yaw < 45) or (pl:GetEyeTrace().Entity and pl:GetEyeTrace().Entity == self) then
				else --pl:PrintMessage(HUD_PRINTTALK, "In FOV");
					--pl:PrintMessage(HUD_PRINTTALK, "Not in FOV");
					endtime = endtime / 2
				end

				--if you're already flashed
				if pl:GetNetworkedFloat("RCS_flashed_time") > CurTime() then
					pl:SetNetworkedFloat("RCS_flashed_time", endtime + pl:GetNetworkedFloat("RCS_flashed_time") + CurTime() - pl:GetNetworkedFloat("RCS_flashed_time_start")) --add more to it
				else --not flashed
					pl:SetNetworkedFloat("RCS_flashed_time", endtime + CurTime())
				end

				pl:SetNetworkedFloat("RCS_flashed_time_start", CurTime())
			else
			end

			self:Remove()
		end
	end)
end

function ENT:Think()
end

function ENT:FindTarget(playerman)
	local target = NULL
	local shortest = TARGET_RADIUS
	local mypos = self:GetPos()

	for _, ent in pairs(ents.FindInSphere(mypos, TARGET_RADIUS)) do
		if ent:IsPlayer() and ent:Alive() and ent == playerman then
			local dist = ent:GetPos():Distance(mypos)

			if dist < shortest then
				shortest = dist
				target = ent
			end
		end
	end

	return target
end

function HasVictimLOS(TargetAng, selfang)
	local tr = util.TraceLine({
		start = selfang:GetPos(),
		endpos = TargetAng:LocalToWorld(TargetAng:OBBCenter()),
		filter = {selfang},
		mask = CONTENTS_SOLID,
		CONTENTS_OPAQUE, CONTENTS_MOVEABLE
	})

	if tr.Fraction > 0.98 then return true end

	return false
end

function CanVictimSeeUs(TargetAng, selfang)
	if selfang:GetParent() == TargetAng then
		return true
	else
		if selfang:GetModel() ~= "models/props/de_tides/vending_turtle.mdl" then
			if IsValid(TargetAng) then
				local ViewEnt = TargetAng:GetViewEntity()
				if ViewEnt == TargetAng and not HasVictimLOS(TargetAng, selfang) then return false end
				local fov = TargetAng:GetFOV()
				local Disp = selfang:GetPos() - ViewEnt:GetPos()
				local Dist = Disp:Length()
				local MaxCos = math.abs(math.cos(math.acos(Dist / math.sqrt(Dist * Dist + selfang.Width * selfang.Width)) + fov * (math.pi / 180)))
				Disp:Normalize()
				if Disp:Dot(ViewEnt:EyeAngles():Forward()) > MaxCos then return true end
			end
		end

		return false
	end
end