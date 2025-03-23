ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "TFBow Arrow Stuck"
ENT.Author = "TheForgottenArchitect"
ENT.Contact = "Don't"
ENT.Purpose = "Arrow Entity"
ENT.Instructions = "Arrow that's stuck in ground"
TFArrowEnts = {}

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

function GetClosestBone(ent, pos)
	local i, count, cbone, dist
	i = 1
	count = ent:GetBoneCount()
	cbone = 0
	dist = 99999999

	while i < count do
		local bonepos, boneang = ent:GetBonePosition(i)

		if bonepos:Distance(pos) < dist then
			dist = bonepos:Distance(pos)
			cbone = i
		end

		i = i + 1
	end

	return cbone
end

function GetClosestPhysBone(ent, pos)
	local i, count, cbone, dist
	i = 1
	count = ent:GetBoneCount()
	cbone = 0
	dist = 99999999

	while i < count do
		local bonepos, boneang = ent:GetBonePosition(i)
		local boneparpos = Vector(9999, 9999, 9999)
		local par = ent:GetBoneParent(i)

		if ent:TranslateBoneToPhysBone(i) then
			if ent:TranslateBoneToPhysBone(i) >= 0 then
				if bonepos:Distance(pos) < dist then
					dist = bonepos:Distance(pos)
					cbone = ent:TranslateBoneToPhysBone(i)
				end
			end
		end

		if i and i ~= -1 then
			local boneparpost = ent:GetBonePosition(par)
			boneparpos = (boneparpost + bonepos) / 2

			if ent:TranslateBoneToPhysBone(par) then
				if ent:TranslateBoneToPhysBone(par) >= 0 then
					if boneparpos:Distance(pos) < dist then
						dist = boneparpos:Distance(pos)
						cbone = ent:TranslateBoneToPhysBone(par)
					end
				end
			end
		end

		i = i + 1
	end

	return cbone
end

function ENT:UpdatePosition()
	local posoffnw, angoffnw, targentnw, targbonenw, enthasbonesnw
	posoffnw = self:GetNWVector("posoffnw", vector_origin)
	angoffnw = self:GetNWAngle("angoffnw", Angle(0, 0, 0))
	targentnw = self:GetNWEntity("targentnw", self)
	targbonenw = self:GetNWInt("targbonenw", 0)
	enthasbonesnw = self:GetNWBool("enthasbonesnw", false)

	if targentnw:IsValid() then
		if (targentnw:IsNPC() or targentnw:IsPlayer()) and targentnw:Health() <= 0 then
			self:SetPos(Vector(0, 0, -1000))
		end

		local ent = targentnw
		local bonepos, bonerot

		if enthasbonesnw then
			ent:SetupBones(ent:GetBoneCount(), ent:GetModelPhysBoneCount())
			bonepos, bonerot = ent:GetBonePosition(targbonenw)
		else
			bonepos = ent:GetPos()
			bonerot = ent:GetAngles()
		end

		local tmppos, tmprot

		if not bonepos then
			bonepos = ent:GetPos()
			bonerot = ent:GetAngles()
		end

		tmppos, tmprot = LocalToWorld(posoffnw, angoffnw, bonepos, bonerot)
		self:SetPos(tmppos)
		self:SetAngles(tmprot)
	else
		self:SetPos(Vector(0, 0, -1000))
	end
end

function ENT:Initialize()
	--if SERVER then
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(2)
		phys:EnableGravity(false)
		phys:EnableCollisions(false)
	end

	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end

	--end
	self.glitchthreshold = 24 --threshold distance from bone to reset pos
	self.glitchthresholds = {}
	self.glitchthresholds["ValveBiped.Bip01_Head1"] = 8
	self.glitchthresholds["ValveBiped.Bip01_Head"] = 8
	self.glitchthresholds["ValveBiped.Bip01_R_Hand"] = 1
	self.glitchthresholds["ValveBiped.Bip01_L_Hand"] = 1
	self.glitchthresholds["ValveBiped.Bip01_Spine2"] = 40
	table.insert(TFArrowEnts, #TFArrowEnts + 1, self)

	if self:GetModel() and self:GetModel() == "" then
		self:SetModel("models/weapons/w_tfa_arrow.mdl")
	end

	if self.targent then
		self:SetOwner(self.targent)
	end

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	--timer.Simple(0, function()
	if self.targent then
		if IsValid(self.targent) then
			local ent, bone, bonepos, bonerot, tmppos, tmprot, myang
			ent = self.targent
			bone = self.targent:TranslatePhysBoneToBone(self.targphysbone)
			self.targbone = bone

			if not ent:GetBoneCount() or ent:GetBoneCount() <= 1 or string.find(ent:GetModel(), "door") then
				bonepos = ent:GetPos()
				bonerot = ent:GetAngles()
				self.enthasbones = false
			else
				if ent.SetupBones then
					ent:SetupBones(ent:GetBoneCount(), ent:GetModelPhysBoneCount())
				end

				bonepos, bonerot = ent:GetBonePosition(bone)
				self.enthasbones = true
			end

			if self.enthasbones == true then
				local gpos = self:GetPos()
				local bonepos2 = GetBoneCenter(ent, bone)
				local tmpgts = self.glitchthresholds[ent:LookupBone(bone)] or self.glitchthreshold

				while gpos:Distance(bonepos2) > tmpgts do
					self:SetPos((gpos + bonepos2) / 2)
					gpos = (gpos + bonepos2) / 2
				end
			end

			if not bonepos then
				bonepos = ent:GetPos()
				bonerot = ent:GetAngles()
			end

			self.posoff, self.angoff = WorldToLocal(self:GetPos(), self:GetAngles(), bonepos, bonerot)
			self:SetNWVector("posoffnw", self.posoff)
			self:SetNWAngle("angoffnw", self.angoff)
			self:SetNWEntity("targentnw", self.targent)
			self:SetNWInt("targbonenw", self.targbone)
			self:SetNWBool("enthasbonesnw", self.enthasbones)
		end
	end

	if CLIENT then
		self:UpdatePosition()
	end
	--end)
end

function ENT:Think()
	if SERVER then
		if not self.targent:IsValid() then
			self:Remove()

			return
		else
			if (self.targent:IsNPC() or self.targent:IsPlayer()) and self.targent:Health() <= 0 then
				self:Remove()
			end
		end
	end

	self:NextThink(CurTime() + 1 / 60)
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and activator:GetWeapon(self.gun) ~= NULL then
		activator:GiveAmmo(1, activator:GetWeapon(self.gun):GetPrimaryAmmoType(), false)
		self:Remove()
	end
end

function ENT:OnRemove()
	table.RemoveByValue(TFArrowEnts, self)
end