if CLIENT then
	local ent_meta = FindMetaTable("Entity")
	function ent_meta:Get2DBounds()
	local min,max = self:OBBMins(),self:OBBMaxs()

	local corners = {
		Vector(min.x,min.y,min.z),
		Vector(min.x,min.y,max.z),
		Vector(min.x,max.y,min.z),
		Vector(min.x,max.y,max.z),
		Vector(max.x,min.y,min.z),
		Vector(max.x,min.y,max.z),
		Vector(max.x,max.y,min.z),
		Vector(max.x,max.y,max.z)
	}

	local minx,miny,maxx,maxy = math.huge, math.huge, -math.huge, -math.huge;

	for _, corner in next, corners do
		local screen = self:LocalToWorld(corner):ToScreen();
		minx,miny = math.min(minx,screen.x),math.min(miny,screen.y);
		maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y);
	end
	return Vector(maxx,maxy), Vector(minx,miny);
end

end