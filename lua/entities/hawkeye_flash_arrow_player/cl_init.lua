 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
function ENT:Draw()
	local ang,tmpang
	tmpang=self:GetAngles()
	ang=tmpang
	if !self.roll then
		self.roll = 0
	end
	local phobj=self:GetPhysicsObject()
	if IsValid(phobj) then
		self.roll=self.roll+phobj:GetVelocity():Length()/3600*GetConVarNumber("host_timescale")
	end
	
	ang:RotateAroundAxis(ang:Forward(),self.roll)
	self:SetAngles(ang)
    self:DrawModel()       -- Draw the model.
	self:SetAngles(tmpang)
	--self:SetModel("models/props_junk/watermelon01
end
 
 
	local EFFECT = {}

	function EFFECT:Init(ed)

		local vOrig = ed:GetOrigin()
		local pe = ParticleEmitter(vOrig)
		
		for i=1,4 do

			local part = pe:Add("particle/particle_smokegrenade", vOrig)

			if (part) then

				part:SetColor(50, 50, 50)
				part:SetVelocity(VectorRand():GetNormal()*math.random(20, 40))
				part:SetRoll(math.Rand(0, 360))
				part:SetRollDelta(math.Rand(-2, 2))
				part:SetDieTime(1)
				part:SetStartSize(5)
				part:SetStartAlpha(255)
				part:SetEndSize(15)
				part:SetEndAlpha(0)
				part:SetGravity(Vector(0,0,-90))

			end

		end

	end

	function EFFECT:Think()
		return false
	end

	function EFFECT:Render()
	end

	effects.Register(EFFECT, "SmallImpact", true)
