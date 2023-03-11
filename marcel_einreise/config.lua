Config = {}

Config.Dimension = 187

Config.Marker = {
    ["helpnotify"] = "Drücke E um einen Einreisebeamten herzurufen.",
    ["type"] = 27,
    ["color"] = {
        ["r"] = 187,
        ["g"] = 187,
        ["b"] = 187
    }
}

Config.Notify = {
    ["trigger"] = "marcel_notify",
    ["standart_color"] = "#ff00ff"
}


Config.Positions = {
    ["einreise_anflug"] = vector4(-1045.0997, -2744.7717, 21.3594, 204.2888),
    ["einreise_rein"] = vector4(-1078.8, -2808.64, 27.71, 155.61),
    ["einreise_raus"] = vector4(-1032.9126, -2738.9236, 20.1693, 288.4389),
    ["einreise_klingel"] = vector3(-1086.75, -2830.6, 27.10)
}

Config.AllowedGroups = {
    "guide",
    "supporter",
    "mod",
    "admin",
    "superadmin",
    "manager",
    "stvpl",
    "pl"
}

Config.Messages = {
    ["no_perms"] = "Du hast keine Rechte dazu.",
    ["einreisedienst_an"] = "Du bist nun im Einreisedienst.",
    ["einreisedienst_aus"] = "Du bist nun aus dem Einreisedienst.",
    ["bereits_eingereist"] = "Der Spieler ist bereits eingereist.",
    ["neu"] = "Willkommen auf Creed Roleplay. Laufe vor zum Schalter und rufe einen Einreisebeamten."
}


Config.Kleidung = {
    maenlich = {
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0, -- Männliche Outfit Nummern.
        ['torso_1'] = 31,   ['torso_2'] = 6,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 77,
        ['pants_1'] = 24,   ['pants_2'] = 6,
        ['shoes_1'] = 7,   ['shoes_2'] = 0,
        ['helmet_1'] = 12,  ['helmet_2'] = 1,
        ['mask_1'] = 0,  ['mask_2'] = 0,
        ['chain_1'] = 11,    ['chain_2'] = 2,
        ['ears_1'] = 0,     ['ears_2'] = 0,
        ['bags_1'] = 0,     ['bags_2'] = 0,
        ['hair_1'] = 0,     ['hair_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
    },
    weiblich = {
        ['tshirt_1'] = 38,  ['tshirt_2'] = 0, -- Weibliche Outfit Nummern.
        ['torso_1'] = 7,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 3,
        ['pants_1'] = 23,   ['pants_2'] = 0,
        ['shoes_1'] = 0,   ['shoes_2'] = 1,
        ['helmet_1'] = 28,  ['helmet_2'] = 4,
        ['mask_1'] = 0,  ['mask_2'] = 0,
        ['chain_1'] = 23,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0,
        ['bags_1'] = 0,     ['bags_2'] = 0,
        ['hair_1'] = 0,     ['hair_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
    }  
}
