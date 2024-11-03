AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.Model = "models/weapons/rocket_models/w_rocket_airstrike/w_rocket.mdl"

CreateConVar("im_missile_enablemotion", 1, {FCVAR_ARCHIVE, FCVAR_PROTECTED}, "Should missile unfreeze/unweld props upon impact?")

local phys

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end

	if IsValid(self:GetPhysicsObject()) then
		self:GetPhysicsObject():SetBuoyancyRatio(0)
		self:GetPhysicsObject():SetMass(250)
	end

	if self:GetNWInt("damage") <= 0 then
		self:SetNWInt("damage", math.random(100, 1024))
	end

	if IsValid(self:GetNWEntity("target")) then
		timer.Create("TargetEntity" .. self:GetCreationID(), 0.5, 1, function()
			if IsValid(self:GetNWEntity("target")) then
				self:SetNWEntity("LockOn", self:GetNWEntity("target"))
				self:EmitSound("rocket_loop", 75, 100, 1, CHAN_AUTO)
			end
		end)
	end
end

function ENT:Think()
	if IsValid(self:GetNWEntity("LockOn")) then
		self:GetPhysicsObject():SetAngles((self:GetNWEntity("LockOn"):EyePos() - self:GetPos()):Angle())
		self:GetPhysicsObject():SetVelocity(((self:GetNWEntity("LockOn"):EyePos() - self:GetPos()):GetNormalized() * 27500) + self:GetNWEntity("LockOn"):GetVelocity())
	end
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

function ENT:PhysicsCollide(data, physobj)
	local position = physobj:GetPos()
	local damage = self:GetNWInt("damage")
	local radius = 1000
	local attacker = self
	local inflictor = self
	local im_missile_enablemotion = GetConVar("im_missile_enablemotion")

	if im_missile_enablemotion:GetInt() == 1 then
		for k, v in pairs(ents.FindInSphere(position, radius)) do
			if IsValid(v) and IsValid(v:GetPhysicsObject()) then
				v:GetPhysicsObject():EnableMotion(true)
				constraint.RemoveConstraints(v, "Weld")
			end
		end
	end

	self:StopSound("rocket_loop")
	self:EmitSound("rocket_explode")
	util.BlastDamage(inflictor, attacker, position, radius, damage)
	ParticleEffect("dusty_explosion_rockets", self:GetPos(), Angle(0, 0, 0), nil)
	self:Remove()
end