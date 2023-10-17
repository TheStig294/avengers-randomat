if SERVER then
	AddCSLuaFile()
end

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Shuriken"

function ENT:Initialize()
	self.Hits = 0
	self.TargetReached = false
	collided = false
	self.CollideCount = 0
	self.Drop = false
	self:SetModel("models/shield/cashield.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():SetMass(0.5)
end

function ENT:PhysicsCollide(data, phys)
	if self.Drop then return end
	self.CollideCount = self.CollideCount + 1
	local hitEntity = data.HitEntity

	if hitEntity == self:GetOwner() then
		self:GetOwner():Give("weapon_ttt_shield")

		if SERVER then
			self:Remove()
		end
	end

	if IsValid(hitEntity) then
		if hitEntity:IsPlayer() then
			self.Hits = self.Hits + 2
		end

		self:EmitSound("weapons/crossbow/hitbod1.wav")
		local dmg = DamageInfo()
		dmg:SetAttacker(self:GetOwner())
		dmg:SetDamage(200)
		dmg:SetDamageForce(self:GetVelocity() * 100)
		dmg:SetDamageType(DMG_SLASH)
		dmg:SetDamagePosition(hitEntity:GetPos())
		hitEntity:TakeDamageInfo(dmg)
		self:GetOwner():SetNWEntity("shield_swep", self)

		timer.Create("propTimer", 1, 1, function()
			deploySwep(self)
		end)

		self.Drop = true
	end

	if not hitEntity:IsPlayer() and hitEntity:GetClass() ~= "prop_ragdoll" then
		self:GetOwner():SetNWEntity("shield_swep", self)

		timer.Create("propTimer", 1, 1, function()
			deploySwep(self)
		end)

		self.Drop = true
	elseif IsValid(self) then
		self:SetAngles(Angle(180, 0, 0))
		self:NextThink(CurTime())
	end
end

function deploySwep(ent)
	local weapon = ents.Create("weapon_ttt_shield")
	if not IsValid(ent) or not IsValid(weapon) then return end
	weapon:SetPos(ent:GetPos())
	weapon:SetAngles(ent:GetAngles())
	weapon:SetVelocity(ent:GetVelocity())
	weapon:Spawn()
	weapon:Activate()
	weapon:SetModel("models/shield/cashield.mdl")
	weapon.Hits = ent.Hits

	if SERVER then
		ent:Remove()
	end
end

function ENT:Think()
	if self.Hits >= 4 then
		self:Remove()
	end

	if CLIENT or self.Drop then return end
	local targetPos = self:GetNWVector("targetPos")
	local Pos = self:GetPos()
	local ownerPos = self:GetOwner():GetShootPos()

	if not self.TargetReached and (targetPos:Distance(Pos) < 500) then
		self:SetVelocity(Vector(0, 0, 0))
		self:GetPhysicsObject():ApplyForceCenter(((ownerPos + Vector(180, 0, 0)) - Pos):GetNormalized() * 20000)
		self.TargetReached = true

		return
	elseif not self.TargetReached then
		self:GetPhysicsObject():ApplyForceCenter((targetPos - Pos):GetNormalized() * 1000)
	else
		self:GetPhysicsObject():ApplyForceCenter((ownerPos - Pos):GetNormalized() * 1000)
	end
end