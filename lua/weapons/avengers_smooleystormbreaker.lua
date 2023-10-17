AddCSLuaFile()
SWEP.PrintName = "Storm Breaker"
SWEP.Author = "Smooley"
SWEP.Instructions = "Stormbreaker is an enchanted axe used by Thor. It was forged from Uru in the heart of a dying star on Nidavellir. Eitri claimed the weapon was the strongest weapon in Asgard history."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "melee"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "None"
SWEP.Primary.Damage = 80
SWEP.Primary.Delay = 0.8
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "None"
SWEP.Weight = 4
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP
SWEP.Icon = "VGUI/entities/stormbreaker.png"
SWEP.Slot = 6

if SERVER then
	resource.AddFile("materials/VGUI/entities/stormbreaker.png")
end

SWEP.LimitedStock = true

SWEP.EquipMenuData = {
	type = "Weapon",
	desc = "A weapon designed for the King of Asgard, forged in the heart of a dying star."
}

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
local FireSound = Sound("weapons/smash.wav")
local MissSound = Sound("weapons/swoosh.wav")
local zap = Sound("ambient/levels/labs/electric_explosion4.wav")
local unzap = Sound("ambient/levels/labs/electric_explosion2.wav")

function SWEP:Equip()
	timer.Simple(5, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		self:GetOwner():ChatPrint("STORM BREAKER: Left-click: High damage melee\nRight-click: Teleport")
	end)
end

function SWEP:SecondaryAttack()
	if not self:ShouldTeleport(true) then return end
	local ply = self:GetOwner()
	local tr = ply:GetEyeTrace()
	local pos = tr.HitPos - (ply:OBBMaxs() - ply:OBBMins()) * tr.Normal
	local t = {}
	t.start = pos
	t.endpos = pos
	t.filter = ply
	local tr2 = util.TraceEntity(t, ply)

	-- Prevents getting stuck inside an object
	if tr2.Hit then
		pos = pos - (ply:OBBMaxs() - ply:OBBMins()) * tr.Normal * 0.1 -- Maybe we're exactly on the edge of something
		t.start = pos
		t.endpos = pos
		t.filter = ply
		tr2 = util.TraceEntity(t, ply)

		if tr2.Hit then
			t.start = ply:GetPos()
			tr2 = util.TraceEntity(t, ply)
			pos = tr2.HitPos
		end
	end

	-- Prevents unintended teleportations
	if pos:Distance(ply:GetPos()) < 64 then
		ply:PrintMessage(HUD_PRINTCENTER, "You are too close to an object to teleport")

		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	sound.Play(zap, ply:GetPos(), 65, 100)
	self:Trace()

	timer.Simple(0.1, function()
		ply.PreTeleportPos = ply:GetPos()
		ply:SetPos(pos)
		ply:SetLocalVelocity(Vector(0, 0, 0))
		sound.Play(unzap, pos, 55, 100)
	end)
end

function SWEP:Trace()
	local ply = self:GetOwner()
	local tr = ply:GetEyeTrace()
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetStart(ply:GetShootPos())
	effectdata:SetAttachment(1)
	effectdata:SetEntity(self)
	util.Effect("ToolTracer", effectdata)
end

function SWEP:ShouldTeleport()
	local ply, target = self:GetOwner(), self:GetOwner():GetEyeTrace().Entity

	if ply:Crouching() then
		ply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport while crouching")

		return false
	end

	local t = ply:GetEyeTrace().HitPos

	if game.GetMap() == "ttt_minecraft_b5" then
		if t.x > 1650 or t.x < -2800 or t.y > 1500 or t.y < -1900 then
			ply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport to that location")

			return false
		end
	elseif game.GetMap():sub(1, 17) == "ttt_minecraftcity" then
		if t.x > 1488 or t.x < -1104 or t.y > 1008 then
			wply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport to that location")

			return false
		end
	elseif game.GetMap():sub(1, 11) == "ttt_67thway" then
		if (t.x > -300 and t.x < 170 and (t.y > 2340 or t.y < -1150)) or (t:WithinAABox(Vector(-2000, -1100, 200), Vector(2000, 2100, 800)) and not t:WithinAABox(Vector(-1920, -960, 200), Vector(1850, 1980, 800))) then
			ply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport to that location")

			return false
		end
	elseif game.GetMap() == "ttt_skyscraper" then
		if t.z < 0 then
			ply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport to that location")

			return false
		end
	elseif game.GetMap():sub(1, 12) == "ttt_aircraft" then
		if t.x > 974 or t.x < -966 or t.z < -1042 then
			ply:PrintMessage(HUD_PRINTCENTER, "Cannot teleport to that location")

			return false
		end
	end

	if target:IsPlayer() then
		ply:PrintMessage(HUD_PRINTCENTER, "You cannot teleport to another player!")

		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	local trace = self:GetOwner():GetEyeTrace()

	if trace.HitPos:Distance(self:GetOwner():GetShootPos()) <= 85 then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:SendWeaponAnim(ACT_VM_HITCENTER)
		bullet = {}
		bullet.Num = 1
		bullet.Src = self:GetOwner():GetShootPos()
		bullet.Dir = self:GetOwner():GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force = 2
		bullet.Damage = self.Primary.Damage
		self:GetOwner():FireBullets(bullet)
		self:EmitSound(FireSound)
	else
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:SendWeaponAnim(ACT_VM_HITCENTER)
		self:EmitSound(MissSound)
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:Deploy()
	if CLIENT then return true end
end

function SWEP:OnDrop()
	if self:GetOwner():IsValid() then
		if self:GetOwner():Health() > 0 then
			self:GetOwner():SetModel(self:GetOwner():GetVar("player_model", NULL))
		end
	end
end

--[[*******************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
*******************************************************]]
function SWEP:Initialize()
	self:SetWeaponHoldType("melee")

	if CLIENT then
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels

		-- init view model bone build function
		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()

			if IsValid(vm) then
				self:ResetBonePositions(vm)

				-- Init viewmodel visibility
				if self.ShowViewModel == nil or self.ShowViewModel then
					vm:SetColor(Color(255, 255, 255, 255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255, 255, 255, 1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
	if CLIENT then return end
end

function SWEP:Holster(wep)
	return true
end

if CLIENT then
	SWEP.vRenderOrder = nil

	function SWEP:ViewModelDrawn()
		local vm = self:GetOwner():GetViewModel()
		if not IsValid(vm) then return end
		if not self.VElements then return end
		self:UpdateBonePositions(vm)

		if not self.vRenderOrder then
			-- we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs(self.VElements) do
				if v.type == "Model" then
					table.insert(self.vRenderOrder, 1, k)
				elseif v.type == "Sprite" or v.type == "Quad" then
					table.insert(self.vRenderOrder, k)
				end
			end
		end

		for k, name in ipairs(self.vRenderOrder) do
			local v = self.VElements[name]

			if not v then
				self.vRenderOrder = nil
				break
			end

			if v.hide then continue end
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			if not v.bone then continue end
			local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
			if not pos then continue end

			if v.type == "Model" and IsValid(model) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				--model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix("RenderMultiply", matrix)

				if v.material == "" then
					model:SetMaterial("")
				elseif model:GetMaterial() ~= v.material then
					model:SetMaterial(v.material)
				end

				if v.skin and v.skin ~= model:GetSkin() then
					model:SetSkin(v.skin)
				end

				if v.bodygroup then
					for k, v in pairs(v.bodygroup) do
						if model:GetBodygroup(k) ~= v then
							model:SetBodygroup(k, v)
						end
					end
				end

				if v.surpresslightning then
					render.SuppressEngineLighting(true)
				end

				render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
				render.SetBlend(v.color.a / 255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)

				if v.surpresslightning then
					render.SuppressEngineLighting(false)
				end
			elseif v.type == "Sprite" and sprite then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif v.type == "Quad" and v.draw_func then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func(self)
				cam.End3D2D()
			end
		end
	end

	SWEP.wRenderOrder = nil

	function SWEP:DrawWorldModel()
		if self.ShowWorldModel == nil or self.ShowWorldModel then
			self:DrawModel()
		end

		if not self.WElements then return end

		if not self.wRenderOrder then
			self.wRenderOrder = {}

			for k, v in pairs(self.WElements) do
				if v.type == "Model" then
					table.insert(self.wRenderOrder, 1, k)
				elseif v.type == "Sprite" or v.type == "Quad" then
					table.insert(self.wRenderOrder, k)
				end
			end
		end

		if IsValid(self:GetOwner()) then
			bone_ent = self:GetOwner()
		else
			-- when the weapon is dropped
			bone_ent = self
		end

		for k, name in pairs(self.wRenderOrder) do
			local v = self.WElements[name]

			if not v then
				self.wRenderOrder = nil
				break
			end

			if v.hide then continue end
			local pos, ang

			if v.bone then
				pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
			else
				pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
			end

			if not pos then continue end
			local model = v.modelEnt
			local sprite = v.spriteMaterial

			if v.type == "Model" and IsValid(model) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				--model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix("RenderMultiply", matrix)

				if v.material == "" then
					model:SetMaterial("")
				elseif model:GetMaterial() ~= v.material then
					model:SetMaterial(v.material)
				end

				if v.skin and v.skin ~= model:GetSkin() then
					model:SetSkin(v.skin)
				end

				if v.bodygroup then
					for k, v in pairs(v.bodygroup) do
						if model:GetBodygroup(k) ~= v then
							model:SetBodygroup(k, v)
						end
					end
				end

				if v.surpresslightning then
					render.SuppressEngineLighting(true)
				end

				render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
				render.SetBlend(v.color.a / 255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)

				if v.surpresslightning then
					render.SuppressEngineLighting(false)
				end
			elseif v.type == "Sprite" and sprite then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif v.type == "Quad" and v.draw_func then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func(self)
				cam.End3D2D()
			end
		end
	end

	function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
		local bone, pos, ang

		if tab.rel and tab.rel ~= "" then
			local v = basetab[tab.rel]
			if not v then return end
			-- Technically, if there exists an element with the same name as a bone
			-- you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation(basetab, v, ent)
			if not pos then return end
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		else
			bone = ent:LookupBone(bone_override or tab.bone)
			if not bone then return end
			pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
			local m = ent:GetBoneMatrix(bone)

			if m then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end

			if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip then
				ang.r = -ang.r -- Fixes mirrored models
			end
		end

		return pos, ang
	end

	function SWEP:CreateModels(tab)
		if not tab then return end

		-- Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs(tab) do
			if v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME") then
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)

				if IsValid(v.modelEnt) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
			elseif v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME") then
				local name = v.sprite .. "-"

				local params = {
					["$basetexture"] = v.sprite
				}

				-- make sure we create a unique name based on the selected options
				local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

				for i, j in pairs(tocheck) do
					if v[j] then
						params["$" .. j] = 1
						name = name .. "1"
					else
						name = name .. "0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
			end
		end
	end

	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		if self.ViewModelBoneMods then
			if not vm:GetBoneCount() then return end
			-- !! WORKAROUND !! //
			-- We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods

			if not hasGarryFixedBoneScalingYet then
				allbones = {}

				for i = 0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)

					if self.ViewModelBoneMods[bonename] then
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = {
							scale = Vector(1, 1, 1),
							pos = Vector(0, 0, 0),
							angle = Angle(0, 0, 0)
						}
					end
				end

				loopthrough = allbones
			end

			-- !! ----------- !! //
			for k, v in pairs(loopthrough) do
				local bone = vm:LookupBone(k)
				if not bone then continue end
				-- !! WORKAROUND !! //
				local s = Vector(v.scale.x, v.scale.y, v.scale.z)
				local p = Vector(v.pos.x, v.pos.y, v.pos.z)
				local ms = Vector(1, 1, 1)

				if not hasGarryFixedBoneScalingYet then
					local cur = vm:GetBoneParent(bone)

					while cur >= 0 do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end

				s = s * ms

				-- !! ----------- !! //
				if vm:GetManipulateBoneScale(bone) ~= s then
					vm:ManipulateBoneScale(bone, s)
				end

				if vm:GetManipulateBoneAngles(bone) ~= v.angle then
					vm:ManipulateBoneAngles(bone, v.angle)
				end

				if vm:GetManipulateBonePosition(bone) ~= p then
					vm:ManipulateBonePosition(bone, p)
				end
			end
		else
			self:ResetBonePositions(vm)
		end
	end

	function SWEP:ResetBonePositions(vm)
		if not vm:GetBoneCount() then return end

		for i = 0, vm:GetBoneCount() do
			vm:ManipulateBoneScale(i, Vector(1, 1, 1))
			vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
			vm:ManipulateBonePosition(i, Vector(0, 0, 0))
		end
	end

	--[[*************************
		Global utility code
	*************************]]
	-- Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	-- Does not copy entities of course, only copies their reference.
	-- WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy(tab)
		if not tab then return nil end
		local res = {}

		for k, v in pairs(tab) do
			if type(v) == "table" then
				res[k] = table.FullCopy(v) -- recursion ho!
			elseif type(v) == "Vector" then
				res[k] = Vector(v.x, v.y, v.z)
			elseif type(v) == "Angle" then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end

		return res
	end
end

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 94.472361809045
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["Dummy15"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(0, 0, 0),
		angle = Angle(0, 0, 0)
	},
	["Dummy14"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(0, 0, 0),
		angle = Angle(0, 0, 0)
	}
}

SWEP.VElements = {
	["stormbreaker_lightning++"] = {
		type = "Sprite",
		sprite = "effects/stunstick",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(-2.597, 5.714, 22.337),
		size = {
			x = 8.735,
			y = 8.735
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker"] = {
		type = "Model",
		model = "models/kyle/stormbreaker.mdl",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(4.675, 0.518, -9.87),
		angle = Angle(0, -43.248, 0),
		size = Vector(1.598, 1.598, 1.598),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	},
	["stormbreaker_lightning+"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(-1.558, 6.752, 23.377),
		size = {
			x = 4.324,
			y = 4.324
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_lightning+++++"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(2.596, 0.518, 23.377),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_lightning"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(3.635, -0.519, 15.064),
		size = {
			x = 8.735,
			y = 8.735
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_lightning+++"] = {
		type = "Sprite",
		sprite = "effects/energysplash",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(3.635, -0.519, 18.181),
		size = {
			x = 8.735,
			y = 8.735
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_lightning++++"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "Bip01 R Hand",
		rel = "",
		pos = Vector(3.635, -0.519, 6.752),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	}
}

SWEP.WElements = {
	["stormbreaker_electric++++"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, -7.792, 22.337),
		size = {
			x = 6.854,
			y = 6.854
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker"] = {
		type = "Model",
		model = "models/kyle/stormbreaker.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(1.557, 1.557, 0.518),
		angle = Angle(125.065, 180, 3.506),
		size = Vector(1.598, 1.598, 1.144),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	},
	["stormbreaker_electric+++++"] = {
		type = "Sprite",
		sprite = "effects/stunstick",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, 6.752, 23.377),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_electric++++++"] = {
		type = "Sprite",
		sprite = "effects/energysplash",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, -0.519, 20.26),
		size = {
			x = 6.529,
			y = 6.529
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_electric"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, -0.519, 5.714),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_electric+++"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, -0.519, 22.337),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	},
	["stormbreaker_electric++"] = {
		type = "Sprite",
		sprite = "effects/tool_tracer",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "stormbreaker",
		pos = Vector(-1.558, -0.519, 14.026),
		size = {
			x = 10,
			y = 10
		},
		color = Color(255, 255, 255, 255),
		nocull = true,
		additive = true,
		vertexalpha = true,
		vertexcolor = true,
		ignorez = false
	}
}