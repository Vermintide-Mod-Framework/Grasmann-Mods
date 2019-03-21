local mod = get_mod("Healthbars")
--[[
	Healthbars
		- Shows healthbars for all or specific enemies

	Author: grasmann
	Version: 2.0.2
--]]

mod.VERY_FAR = 50
local SIZE = {
	Default = {17*0.9, 7*0.9},
	Special = {17*1.4, 7*1.4},
	Ogre = {17*1.8, 7*1.8},
}
mod.enemy_settings = {
	default = {
		offset = 1.5,   size = SIZE.Default,    special = false,                setting = "NONE",
    },

    -- Animals
    critter_pig = {
		offset = 2.5,   size = SIZE.Special,    special = false,                setting = "NONE",
	},
	critter_rat = {
		offset = 0.5,   size = SIZE.Special,    special = false,                setting = "NONE",
    },
    
    -- Skaven
	skaven_slave = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "slave_rat",
    },
    skaven_dummy_slave = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "slave_rat",
	},
	skaven_clan_rat = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "clan_rat",
    },
    skaven_dummy_clan_rat = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "clan_rat",
	},
	skaven_clan_rat_tutorial = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "clan_rat",
	},
	skaven_clan_rat_with_shield = {
		offset = 3,     size = SIZE.Default,    special = false,                setting = "clan_rat",
	},
	skaven_storm_vermin = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "stormvermin",
	},
	skaven_storm_vermin_commander = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "stormvermin",
	},
	skaven_gutter_runner = {
		offset = 3,     size = SIZE.Special,    special = true,                 setting = "runner",
	},
	skaven_ratling_gunner = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "gunner",
	},
	skaven_pack_master = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "packmaster",
	},
	skaven_poison_wind_globadier = {
		offset = 3.5,   size = SIZE.Special,    special = true,                 setting = "gas_rat",
	},
	skaven_rat_ogre = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "ogre",
	},
	skaven_loot_rat = {
		offset = 4,     size = SIZE.Ogre,       special = true,                 setting = "sack_rat",
	},
	skaven_grey_seer = {
		offset = 3.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "NONE",
	},
	skaven_storm_vermin_champion = {
        offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "champion",
    },
	skaven_storm_vermin_with_shield = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "stormvermin",
	},
	skaven_plague_monk = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "plague_monk",
	},
	skaven_warpfire_thrower = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "warpfire_thrower",
	},
	skaven_stormfiend = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "stormfiend",
	},
	skaven_stormfiend_boss = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "stormfiend_boss",
	},
	skaven_stormfiend_demo = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "stormfiend",
	},
	skaven_storm_vermin_warlord = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "stormvermin_warlord",
    },
    
    -- Chaos
    chaos_fanatic = {
		offset = 4,     size = SIZE.Default,    special = false,                setting = "chaos_fanatic",
    },
    chaos_zombie = {
		offset = 4,     size = SIZE.Default,    special = false,                setting = "chaos_zombie",
    },
    chaos_marauder = {
		offset = 4,     size = SIZE.Default,    special = false,                setting = "chaos_marauder",
	},
	chaos_marauder_tutorial = {
		offset = 4,     size = SIZE.Default,    special = false,                setting = "chaos_marauder",
    },
    chaos_marauder_with_shield = {
		offset = 4,     size = SIZE.Default,    special = false,                setting = "chaos_marauder",
	},
    chaos_raider = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "chaos_raider",
	},
	chaos_raider_tutorial = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "chaos_raider",
    },
    chaos_berzerker = {
		offset = 4,     size = SIZE.Special,    special = true,                 setting = "chaos_berzerker",
	},
	chaos_warrior = {
		offset = 4,     size = SIZE.Default,    special = true,                 setting = "chaos_warrior",
    },
    chaos_vortex_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true,                 setting = "chaos_vortex_sorcerer",
    },
    -- chaos_vortex = {
	-- 	offset = 3,     size = SIZE.Default,    special = false,                setting = "vortex",
	-- },
    chaos_plague_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true,                 setting = "chaos_plague_sorcerer",
    },
    -- chaos_plague_wave_spawner = {
	-- 	offset = 3,     size = SIZE.Default,    special = false,                setting = "chaos_plague_wave_spawner",
	-- },
    chaos_corruptor_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true,                 setting = "chaos_corruptor_sorcerer",
    },
    chaos_tentacle_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true,                 setting = "chaos_tentacle_sorcerer",
    },
    -- chaos_tentacle = {
	-- 	offset = 3,     size = SIZE.Default,    special = false,                setting = "chaos_tentacle",
	-- },
    chaos_dummy_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true,                 setting = "chaos_vortex_sorcerer",
    },
    chaos_spawn = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_spawn",
    },
    chaos_troll = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_troll",
    },
    chaos_dummy_troll = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_troll",
	},
	chaos_exalted_champion = {
		offset = 5,     size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_exalted_champion",
	},
	chaos_exalted_champion_warcamp = {
		offset = 5,     size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_exalted_champion_warcamp",
	},
	chaos_exalted_champion_norsca = {
		offset = 5,     size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_exalted_champion_norsca",
    },
    chaos_spawn_exalted_champion_norsca = {
		offset = 5.5,   size = SIZE.Ogre,       special = true, boss = true,    setting = "chaos_spawn_exalted_champion_norsca",
	},
	chaos_exalted_sorcerer = {
		offset = 5,     size = SIZE.Special,    special = true, boss = true,    setting = "chaos_exalted_sorcerer",
	},
}