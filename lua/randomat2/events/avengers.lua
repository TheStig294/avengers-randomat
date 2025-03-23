local EVENT = {}
EVENT.Title = "Avengers Assemble!"
EVENT.Description = "Everyone becomes an avenger!"
EVENT.id = "avengers"

EVENT.Categories = {"largeimpact", "item"}

local musicCvar = CreateConVar("randomat_avengers_music", 1, FCVAR_NONE, "Whether music should play on event trigger", 0, 1)

local function avengername(wept)
    if wept == "avengers_hawkeye_crybow" then
        return "Hawkeye"
    elseif wept == "avengers_nick_pistol" then
        return "Nick Fury"
    elseif wept == "avengers_fists" then
        return "The Hulk"
    elseif wept == "avengers_ttt_minifier" then
        return "Ant-Man"
    elseif wept == "avengers_ttt_shield" then
        return "Captain America"
    elseif wept == "avengers_smooleystormbreaker" then
        return "Thor"
    elseif wept == "avengers_ironman" then
        return "Iron Man"
    end
end

local models = {
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=2043830417
    ["Hawkeye"] = "models/hopwire/marvel/hawkeyepm.mdl",
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=1739807857
    ["Nick Fury"] = "models/kryptonite/nick_fury/nick_fury.mdl",
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=2043850322
    ["The Hulk"] = "models/hopwire/marvel/hulkpm.mdl",
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=1431467857
    ["Ant-Man"] = "models/kryptonite/ant_man/ant_man.mdl",
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=189032607
    ["Captain America"] = "models/player/techknow/cpt_america/cpt_a_noshield.mdl",
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=1372622824
    ["Thor"] = "models/kryptonite/inf_thor/inf_thor.mdl",
    -- In-built
    ["Iron Man"] = "models/avengers/iron Man/mark7_player.mdl"
}

local function GiveWeapon(ply, class)
    ply:Give(class)
    ply:SelectWeapon(class)

    timer.Simple(3, function()
        local avengerName = avengername(class)
        ply:PrintMessage(HUD_PRINTCENTER, "You are: " .. avengerName .. "!")
    end)
end

local function IsSlotEmpty(ply, slot)
    for _, wep in pairs(ply:GetWeapons()) do
        if wep.Kind == slot then
            ply:StripWeapon(wep:GetClass())
        end
    end
end

function EVENT:Begin()
    if musicCvar:GetBool() then
        BroadcastLua("surface.PlaySound(\"avengers/avengerstheme.mp3\")")
        PrintMessage(HUD_PRINTTALK, "Press 'M' to mute music")

        self:AddHook("PlayerButtonDown", function(ply, button)
            if button == KEY_M then
                ply:ConCommand("stopsound")
            end
        end)
    end

    local OGavengersweapons = {"avengers_hawkeye_crybow", "avengers_nick_pistol", "avengers_fists", "avengers_ttt_minifier", "avengers_ttt_shield", "avengers_smooleystormbreaker", "avengers_ironman"}

    local avengersweapons = {}
    table.CopyFromTo(OGavengersweapons, avengersweapons)

    timer.Simple(0.1, function()
        for _, ply in pairs(self:GetAlivePlayers(true)) do
            IsSlotEmpty(ply, 7)
            local randomIndex = math.random(#avengersweapons)
            local weaponClass = avengersweapons[randomIndex]
            GiveWeapon(ply, weaponClass)
            local avengerName = avengername(weaponClass)
            local model = models[avengerName]

            if util.IsValidModel(model) then
                FindMetaTable("Entity").SetModel(ply, model)
            end

            table.remove(avengersweapons, randomIndex)

            if table.IsEmpty(avengersweapons) then
                table.CopyFromTo(OGavengersweapons, avengersweapons)
            end
        end
    end)
end

function EVENT:GetConVars()
    local checkboxes = {}

    for _, v in pairs({"music"}) do
        local name = "randomat_" .. self.id .. "_" .. v

        if ConVarExists(name) then
            local convar = GetConVar(name)

            table.insert(checkboxes, {
                cmd = v,
                dsc = convar:GetHelpText(),
                min = convar:GetMin(),
                max = convar:GetMax(),
                dcm = 0
            })
        end
    end

    return {}, checkboxes
end

Randomat:register(EVENT)