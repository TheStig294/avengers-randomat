include('shared.lua')
local matBeam = Material('cable/rope')

--[[---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------]]
function ENT:Initialize()
	self.Size = 0
	self.MainStart = self:GetPos()
	self.MainEnd = self:GetEndPos()
	self.dAng = (self.MainEnd - self.MainStart):Angle()
	--Changed from 3000 to match hook speed.
	self.speed = 10000
	self.startTime = CurTime()
	self.endTime = CurTime() + self.speed
	self.dt = -1
end

function ENT:Think()
	self:SetRenderBoundsWS(self:GetEndPos(), self:GetPos(), Vector() * 8)
	self.Size = math.Approach(self.Size, 1, 10 * FrameTime())
end

function ENT:DrawMainBeam(StartPos, EndPos, dt, dist)
	local TexOffset = 0
	local ca = Color(255, 255, 255, 255)
	EndPos = StartPos + (self.dAng * ((1 - dt) * dist))
	-- Cool Beam
	render.SetMaterial(matBeam)
	render.DrawBeam(EndPos, StartPos, 2, TexOffset * -0.4, TexOffset * -0.4 + StartPos:Distance(EndPos) / 256, ca) --32
end

function ENT:Draw()
	local Owner = self:GetOwner()
	if not Owner or Owner == NULL then return end
	local StartPos = self:GetPos()
	local EndPos = self:GetEndPos()
	local ViewModel = Owner == LocalPlayer()
	if EndPos == Vector(0, 0, 0) then return end

	-- If it's the local player we start at the viewmodel
	if ViewModel then
		local vm = Owner:GetViewModel()
		if not vm or vm == NULL then return end
		local attachment = vm:GetAttachment(1)
		StartPos = attachment.Pos
	else
		-- If we're viewing another player we start at their weapon
		StartPos = Owner:GetAttachment(3).Pos
		if StartPos == NULL then return end
	end

	-- Make the texture coords relative to distance so they're always a nice size
	local Distance = EndPos:Distance(StartPos) * self.Size
	local et = self.startTime + (Distance / self.speed)

	if self.dt ~= 0 then
		self.dt = (et - CurTime()) / (et - self.startTime)
	end

	if self.dt < 0 then
		self.dt = 0
	end

	self.dAng = (EndPos - StartPos):Angle():Forward()
	gbAngle = (EndPos - StartPos):Angle()
	local Normal = gbAngle:Forward()
	-- Draw the beam
	self:DrawMainBeam(StartPos, StartPos + Normal * Distance, self.dt, Distance)
end

--[[---------------------------------------------------------
   Name: IsTranslucent
---------------------------------------------------------]]
function ENT:IsTranslucent()
	return true
end