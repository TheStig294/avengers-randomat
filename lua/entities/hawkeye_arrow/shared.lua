ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "TFBow Arrow"
ENT.Author = "TheForgottenArchitect"
ENT.Contact = "Don't"
ENT.Purpose = "Arrow Entity"
ENT.Instructions = "Spawn this with a velocity, get rich"

function GetBoneCenter(ent, bone)
	local bonechildren = ent:GetChildBones(bone)

	if #bonechildren <= 0 then
		return ent:GetBonePosition(bone)
	else
		local bonepos = ent:GetBonePosition(bone)
		local tmppos = bonepos

		if tmppos then
			for i = 1, #bonechildren do
				local childpos, childrot = ent:GetBonePosition(bonechildren[i])

				if childpos then
					tmppos = (tmppos + childpos) / 2
				end
			end
		else
			return ent:GetPos()
		end

		return tmppos
	end
end

function ENT:GetClosestBonePos(ent, pos)
	local i, count, cbone, dist, ppos
	i = 1
	count = ent:GetBoneCount()
	cbone = 0
	dist = 99999999
	ppos = ent:GetPos()

	while i < count do
		local bonepos, boneang = GetBoneCenter(ent, i)

		if bonepos:Distance(pos) < dist then
			dist = bonepos:Distance(pos)
			cbone = i
			ppos = bonepos
		end

		i = i + 1
	end

	return ppos
end

function ENT:Initialize()
	if SERVER then
		if not IsValid(self.myowner) then
			self.myowner = self:GetOwner()

			if not IsValid(myowner) then
				self.myowner = self
			end
		end

		timer.Simple(0, function()
			if self.model then
				self:SetModel(self.model)
			end
		end)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:Wake()
			phys:SetVelocityInstantaneous(self.velocity)
			phys:EnableCollisions(false)
			self:StartMotionController()
			self:PhysicsUpdate(phys, 0.1 * GetConVarNumber("host_timescale"))
		end
	end

	self:SetNWVector("lastpos", self:GetPos())
end

function ENT:PhysicsUpdate()
	local wl = self:WaterLevel()

	if not self.prevwaterlevel then
		self.prevwaterlevel = wl
	end

	if self.prevwaterlevel ~= wl and wl - self.prevwaterlevel >= 1 then
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		util.Effect("watersplash", ef)
	end

	self.prevwaterlevel = wl

	if wl >= 2 then
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetVelocity(phys:GetVelocity() * math.sqrt(9 / 10))
		end
	end

	local tracedata = {}
	tracedata.start = self:GetNWVector("lastpos", self:GetPos())
	tracedata.endpos = self:GetPos()
	tracedata.mask = MASK_SOLID

	tracedata.filter = {self.myowner, self:GetOwner(), self}

	local tr = util.TraceLine(tracedata)

	--self:SetAngles((((tracedata.endpos-tracedata.start):GetNormalized()+self:GetAngles():Forward())/2):Angle())
	if tr.Hit and tr.Fraction < 1 and tr.Fraction > 0 then
		debugoverlay.Line(tracedata.start, tr.HitPos, 10, Color(255, 0, 0, 255), true)
		debugoverlay.Cross(tr.HitPos, 5, 10, Color(255, 0, 0, 255), true)

		if SERVER then
			local bul = {}
			bul.Attacker = self:GetOwner()
			bul.Spread = vector_origin
			bul.Src = tracedata.start
			bul.Force = self.mydamage * 0.25
			bul.Damage = self.mydamage
			bul.Tracer = 1000000000 -- Show a tracer on every x bullets
			bul.TracerName = "None"
			bul.Dir = (tr.HitPos - bul.Src):GetNormalized()
			bul.Attacker:FireBullets(bul)

			if tr.HitWorld then
				local arrowstuck = ents.Create("hawkeye_arrow_stuck")
				arrowstuck:SetModel(self:GetModel())
				arrowstuck.gun = self.gun
				arrowstuck:SetPos(tr.HitPos)
				local phys = self:GetPhysicsObject()
				arrowstuck:SetAngles(phys:GetVelocity():Angle())
				arrowstuck:Spawn()
			else
				if IsValid(tr.Entity) then
					if not tr.Entity:IsWorld() then
						local arrowstuck = ents.Create("hawkeye_arrow_stuck_clientside")
						arrowstuck:SetModel(self:GetModel())
						arrowstuck:SetPos(tr.HitPos)
						local ang = self:GetAngles()
						arrowstuck.gun = self.gun
						arrowstuck:SetAngles(ang)
						arrowstuck.targent = tr.Entity
						arrowstuck.targphysbone = tr.PhysicsBone
						arrowstuck:Spawn()
					else
						local arrowstuck = ents.Create("hawkeye_arrow_stuck")
						arrowstuck:SetModel(self:GetModel())
						arrowstuck.gun = self.gun
						arrowstuck:SetPos(tr.HitPos)
						arrowstuck:SetAngles(self:GetAngles())
						arrowstuck:Spawn()
					end
				end
			end
		end

		timer.Simple(0, function()
			if IsValid(self) then
				self:Remove()
			end
		end)
	end

	self:SetNWVector("lastpos", self:GetPos())
end