AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------]]
function ENT:Initialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
end

function ENT:Think()
end