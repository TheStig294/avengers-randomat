AddCSLuaFile()

hook.Add("ScalePlayerDamage", "blocking", function(ply, hitgroup, dmginfo)
  if dmginfo:IsBulletDamage() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_ttt_shield" then
    local angle = dmginfo:GetAttacker():GetAngles().y - ply:GetAngles().y

    if angle < -180 then
      angle = 360 + angle
    end

    if not (angle <= 90 and angle >= -90) then
      dmginfo:ScaleDamage(0.50)
    end
  end
end)