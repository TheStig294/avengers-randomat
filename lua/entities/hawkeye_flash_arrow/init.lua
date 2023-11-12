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

	if not self.Arrowtype then
		self.Arrowtype = "normal"
	end
end

function ENT:Think()
	if self.PinData then
		local ent = self.PinData.Entity
		local pos = self.PinData.Pos
		local rag

		if IsValid(ent) then
			if ent:GetMoveType() == MOVETYPE_VPHYSICS then
				rag = ents.Create("prop_physics")
			else
				rag = ents.Create("prop_ragdoll")
			end

			rag:SetModel(ent:GetModel())
			rag:SetPos(ent:GetPos())
			rag:SetAngles(ent:GetAngles())
			rag:SetColor(ent:GetColor())
			rag:SetMaterial(ent:GetMaterial())
			--rag:SetBodygroup(ent:GetBodygroup())
			rag:Spawn()
			rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			rag:Fire("Kill", 1, 60)

			--setup bone positions
			for i = 0, rag:GetPhysicsObjectCount() - 1 do
				local bone = rag:TranslatePhysBoneToBone(i)
				local phys = rag:GetPhysicsObjectNum(i)

				if phys then
					local bpos, bang = ent:GetBonePosition(bone)

					if bpos then
						phys:SetPos(bpos)
					end

					if bang then
						phys:SetAngles(bang)
					end

					phys:SetVelocity(ent:GetVelocity())
				end
			end

			if self.PinData then
				if ent:IsNPC() then
					ent:Remove()
				else
					ent:KillSilent()
				end
			end
		end

		if pos then
			local temptrace = {}
			temptrace.start = self:GetPos()
			temptrace.endpos = self:GetPos() + self:GetForward() * 350

			temptrace.filter = {self, "hawkeye_flash_arrow"}

			temptrace.mask = MASK_SHOT - CONTENTS_SOLID
			local tr = util.TraceLine(temptrace)

			if IsValid(self) then
				self:SetPos(pos)
			end

			if IsValid(rag) then
				local bone = rag:GetPhysicsObjectNum(tr.PhysicsBone)

				if bone then
					bone:SetPos(pos)
					bone:EnableMotion(false)
					constraint.Weld(game.GetWorld(), rag, 0, tr.PhysicsBone, 0, false)
				end

				if self.Arrowtype == "fire" then
					rag:Ignite(10, 25)
				end
			end
		end

		self.PinData = false
	end

	if not self.umsgSent then
		umsg.Start("xbowarrowinit")
		umsg.String(self.Arrowtype)
		umsg.Entity(self)
		umsg.End()
		self.umsgSent = true
	end

	self:NextThink(CurTime())

	return true
end

function ENT:PhysicsUpdate(phys)
	if not self.Hit then
		self:SetLocalAngles(phys:GetVelocity():Angle())
		local vel = Vector(0, 0, 0)

		if self:WaterLevel() <= 0 then
			vel = Vector(0, 0, -3)
		else
			vel = Vector(0, 0, -1.5)
		end

		phys:AddVelocity(vel)
	end
end

function ENT:PhysicsCollide(data, physobj)
	local trace = {}
	trace.start = self:GetPos()
	trace.endpos = data.HitPos

	trace.filter = {self}

	trace.mask = MASK_SHOT
	trace.mins = self:OBBMins()
	trace.maxs = self:OBBMaxs()
	local tr = util.TraceHull(trace)
	local ent = data.HitEntity

	if tr.HitSky or not self:IsInWorld() then
		self:Remove()
	end

	if IsValid(self) and self.Arrowtype and not self.Hit then
		if IsValid(self.Trail) then
			self.Trail:Fire("kill", 1, 2)
		end

		if IsValid(self.Flame) then
			self.Flame:Fire("kill")
		end

		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)

		if IsValid(ent) and not data.HitEntity:IsWorld() and not ent:IsPlayer() and not ent:IsNPC() and ent:GetClass() ~= "dildo_arrow" then
			self:SetPos(data.HitPos)
			self:SetParent(ent)
		end

		if self.Arrowtype ~= "explosive" then
			if tr.Hit then
				local ef = EffectData()
				ef:SetStart(self:GetVelocity():GetNormalized() * -1)
				ef:SetOrigin(data.HitPos)

				if (tr.MatType == MAT_BLOODYFLESH) or (tr.MatType == MAT_FLESH) then
					util.Effect("BloodImpact", ef)
					self:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(5) .. ".wav", 80, 100)
					self:EmitSound("weapons/crossbow/hitbod" .. math.random(2) .. ".wav", 90, 100)
				elseif tr.MatType == MAT_CONCRETE then
					util.Effect("GlassImpact", ef)
					self:EmitSound("physics/concrete/concrete_impact_bullet" .. math.random(4) .. ".wav", 80, 100)
				elseif tr.MatType == MAT_PLASTIC then
					util.Effect("GlassImpact", ef)
					self:EmitSound("physics/plastic/plastic_box_impact_hard" .. math.random(4) .. ".wav", 80, 100)
				elseif (tr.MatType == MAT_GLASS) or (tr.MatType == MAT_TILE) then
					util.Effect("GlassImpact", ef)
					self:EmitSound("physics/concrete/concrete_impact_bullet" .. math.random(4) .. ".wav", 80, 100)
				elseif (tr.MatType == MAT_METAL) or (tr.MatType == MAT_GRATE) then
					util.Effect("MetalSpark", ef)
					self:EmitSound("physics/metal/metal_solid_impact_bullet" .. math.random(4) .. ".wav", 80, 100)
				elseif tr.MatType == MAT_WOOD then
					util.Effect("SmallImpact", ef)
					self:EmitSound("physics/wood/wood_solid_impact_bullet" .. math.random(5) .. ".wav", 80, 100)
				elseif (tr.MatType == MAT_DIRT) or (tr.MatType == MAT_SAND) then
					util.Effect("SmallImpact", ef)
					self:EmitSound("physics/surfaces/sand_impact_bullet" .. math.random(4) .. ".wav", 80, 100)
				end
			end

			if ent:IsWorld() then
				self:EmitSound("physics/metal/sawblade_stick" .. math.random(3) .. ".wav", 90, 100)
			else
				self:EmitSound("weapons/crossbow/hitbod" .. math.random(2) .. ".wav", 90, 100)
			end
		end

		local dmg = DamageInfo()
		dmg:SetAttacker(self)

		if IsValid(self.Inflictor) then
			dmg:SetInflictor(self.Inflictor)
		else
			dmg:SetInflictor(self)
		end

		dmg:SetDamagePosition(data.HitPos)
		dmg:SetDamageForce(vector_origin)

		if not self:GetParent():IsValid() and data.HitEntity:IsWorld() then
			self:SetPos(data.HitPos)

			timer.Simple(3, function()
				self:EmitSound(Sound("weapons/flashbang/flashbang_explode" .. math.random(2) .. ".wav"))

				for _, pl in pairs(player.GetAll()) do
					local ang = (self:GetPos() - pl:GetShootPos()):GetNormalized():Angle()
					local tracedata = {}
					tracedata.start = pl:GetPos()
					tracedata.endpos = self:GetPos()
					tracedata.filter = pl
					local traceRes = pl:GetEyeTrace()
					local pitch = simplifyangle(ang.p - pl:EyeAngles().p)
					local yaw = simplifyangle(ang.y - pl:EyeAngles().y)
					local dist = pl:GetShootPos():Distance(self:GetPos())

					if traceRes.HitWorld and not tr.HitWorld then
						local endtime = FLASH_INTENSITY / dist

						if endtime > 6 then
							endtime = 6
						elseif endtime < 0.4 then
							endtime = 0.4
						end

						simpendtime = math.floor(endtime)
						tenthendtime = math.floor((endtime - simpendtime) * 10)

						--in FOV
						if not ((pitch > -45 and pitch < 45 and yaw > -45 and yaw < 45) or (pl:GetEyeTrace().Entity and pl:GetEyeTrace().Entity == self)) then
							endtime = endtime / 2
						end

						--if you're already flashed
						if pl:GetNWFloat("RCS_flashed_time") > CurTime() then
							pl:SetNWFloat("RCS_flashed_time", endtime + pl:GetNWFloat("RCS_flashed_time") + CurTime() - pl:GetNWFloat("RCS_flashed_time_start")) --add more to it
						else --not flashed
							pl:SetNWFloat("RCS_flashed_time", endtime + CurTime())
						end

						pl:SetNWFloat("RCS_flashed_time_start", CurTime())
					end
				end

				self:Remove()
			end)
		end

		if IsValid(ent) then
			if ent:IsNPC() or ent:IsPlayer() then
				local tracew = {}
				tracew.start = self:GetPos()
				tracew.endpos = self:GetPos() + self:GetForward() * 350
				tracew.mask = MASK_SOLID_BRUSHONLY

				if not self.PinData then
					local angles = self:GetAngles()
					local model = ents.Create("hawkeye_flash_arrow_player")
					pos = data.HitPos
					model:SetPos(pos)
					model:SetAngles(angles)
					model:SetColor(Color(148, 0, 211, 255))
					model:Spawn()
					model:Activate()
					model:SetParent(ent)
					constraint.Weld(game.GetWorld(), ent, 0, tr.PhysicsBone, 0, false)
					model:SetNotSolid(true)

					if ent:IsPlayer() and not model:GetParent():Alive() then
						model:Remove()
					end
				end

				self:Remove()
			end

			if not self.PinData then
				ent:TakeDamageInfo(dmg)
			end
		end

		self.Hit = true
		self:Fire("kill", 1, 60)
	end
end

local function FireKillCredit(ent, dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	if IsValid(attacker) and (attacker == inflictor) and attacker:GetClass() == "entityflame" and IsValid(ent.FireCreditor) then
		dmginfo:SetInflictor(attacker)
		dmginfo:SetAttacker(ent.FireCreditor)
	end
end

hook.Add("EntityTakeDamage", "FireArrowCredit", FireKillCredit)

local function DenyArrowMoving(ply, ent)
	if ent:GetClass() == "dildo_arrow" then return false end
end

hook.Add("PhysgunPickup", "DenyArrowPhysGunning", DenyArrowMoving)