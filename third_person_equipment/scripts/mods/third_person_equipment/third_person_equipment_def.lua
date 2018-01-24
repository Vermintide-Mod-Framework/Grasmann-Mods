local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment definitions
		- Provides configurations for equipment positions
	
	Author: grasmann
	Version: 1.1.0
--]]

local default_node = "j_spine"
local default_node_2 = "j_spine2"
--local default_node = default_node_2
local backpack_node = "a_hanging_trophy_3"
local hip_node = "j_hips"
mod.definitions = {
	-- Soldier
	es_handgun = {
		right = {
			node = default_node,
			position = {0.5, -0.2, -0.2},
			rotation = {0, 30, 90},
		},
	},
	es_2h_sword_exec = {
		right = {
			node = default_node,
			position = {0.7, -0.22, 0.2},
			rotation = {0, -110, 90},
		},
	},
	es_1h_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.21},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node,
				position = {0.5, -0.22, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	es_2h_war_hammer = {
		right = {
			node = default_node,
			position = {0.7, -0.22, 0.2},
			rotation = {0, -110, 90},
		},
	},
	es_1h_sword_shield = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.21},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node,
				position = {0.5, -0.22, 0.1},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = default_node,
				position = {0.3, -0.22, 0.1},
				rotation = {0, 90, 90},
			},
			back = {
				node = default_node,
				position = {0.3, -0.22, 0.1},
				rotation = {0, 90, 90},
			},
		},
	},
	es_2h_sword = {
		right = {
			node = default_node,
			position = {0.7, -0.22, 0.2},
			rotation = {0, -110, 90},
		},
	},
	es_1h_mace = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.21},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node,
				position = {0.5, -0.22, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	es_1h_mace_shield = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.21},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node,
				position = {0.5, -0.22, 0.1},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = default_node,
				position = {0.3, -0.22, 0.1},
				rotation = {0, 90, 90},
			},
			back = {
				node = default_node,
				position = {0.3, -0.22, 0.1},
				rotation = {0, 90, 90},
			},
		},
	},
	es_repeating_handgun = {
		right = {
			node = default_node,
			position = {0.5, -0.2, -0.2},
			rotation = {0, 30, 90},
		},
	},
	es_blunderbuss = {
		right = {
			node = default_node,
			position = {0.5, -0.2, -0.2},
			rotation = {0, 30, 90},
		},
	},
	--- Mage
	bw_flame_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_1h_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_morningstar = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_staff_beam = {
		right = {
			node = default_node_2,
			position = {0, -0.15, -0.05},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_firball = {
		right = {
			node = default_node_2,
			position = {0, -0.15, -0.05},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_geiser = {
		right = {
			node = default_node_2,
			position = {0, -0.15, -0.05},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_spear = {
		right = {
			node = default_node_2,
			position = {0, -0.15, -0.05},
			rotation = {0, 110, 180},
		},
	},
	bw_dagger = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	-- Witchhunter
	wh_2h_sword = {
		right = {
			node = default_node_2,
			position = {0.4, -0.19, 0.2},
			rotation = {0, -110, 90},
		},
	},
	wh_repeating_crossbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.2, -0.1},
			rotation = {270, 0, 110},
		},
	},
	wh_fencing_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.19, 0.1},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = hip_node,
				position = {0.1, 0, 0.2},
				rotation = {270, 0, 90},
			},
			back = {
				node = hip_node,
				position = {0.1, 0, -0.2},
				rotation = {270, 0, 90},
			},
		},
	},
	wh_1h_falchions = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.19, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	wh_1h_axes = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.15},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.19, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	wh_brace_of_pisols = {
		right = {
			node = "j_hips",
			position = {0.1, 0, 0.2},
			rotation = {270, 0, 90},
		},
		left = {
			node = "j_hips",
			position = {0.1, 0, -0.2},
			rotation = {270, 0, 90},
		},
	},
	wh_crossbow = {
		left = {
			node = default_node_2,
			position = {0.15, -0.2, -0.1},
			rotation = {270, 0, 110},
		},
	},
	wh_repeating_pistol = {
		right = {
			node = default_node_2,
			position = {0.2, -0.2, -0.1},
			rotation = {0, 30, 90},
		},
	},
	-- Waywatcher
	ww_2h_axe = {
		right = {
			node = default_node_2,
			position = {0.4, -0.15, 0.2},
			rotation = {0, -110, 90},
		},
	},
	ww_trueflight = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
		},
	},
	ww_1h_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.17},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	ww_dual_swords = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.17},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.15},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = hip_node,
				position = {0.2, 0, 0.17},
				rotation = {40, -70, 180},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, -0.15},
				rotation = {0, -60, 90},
			},
		},
	},
	ww_sword_and_dagger = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.17},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.15},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = hip_node,
				position = {0.2, 0, 0.17},
				rotation = {40, -70, 180},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, -0.15},
				rotation = {0, -60, 90},
			},
		},
	},
	ww_dual_daggers = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.1, -0.17},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, 0.15},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = hip_node,
				position = {0.2, 0, 0.17},
				rotation = {40, -70, 180},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.15, -0.15},
				rotation = {0, -60, 90},
			},
		},
	},
	ww_longbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
		},
	},
	ww_shortbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
		},
	},
	ww_hagbane = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
		},
	},
	-- Dwarf
	dr_1h_axe_shield = {
		right = {
			back = {
				node = default_node_2,
				position = {0.4, -0.2, 0.1},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.5, 0.1},
				rotation = {40, 160, 20},
			},
			belt = {
				node = hip_node,
				position = {0.13, 0.1, -0.24},
				rotation = {130, -70, 110},
			},
		},
		left = {
			back = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
			belt = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
		},
	},
	dr_handgun = {
		right = {
			backpack = {
				node = backpack_node,
				position = {-0.2, -0.45, 0.25},
				rotation = {-30, 90, -10},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.2, -0.2},
				rotation = {0, 30, 90},
			},
		},
	},
	dr_1h_hammer = {
		right = {
			back = {
				node = default_node_2,
				position = {0.4, -0.2, 0.1},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.5, 0.1},
				rotation = {40, 160, 20},
			},
			belt = {
				node = hip_node,
				position = {0.13, 0.1, -0.24},
				rotation = {130, -70, 110},
			},
		},
	},
	dr_2h_hammer = {
		right = {
			back = {
				node = default_node_2,
				position = {0.5, -0.15, 0.2},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.1, -0.8, 0.5},
				rotation = {40, 160, 20},
			},
		},
	},
	dr_1h_axes = {
		right = {
			back = {
				node = default_node_2,
				position = {0.4, -0.2, 0.1},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.5, 0.1},
				rotation = {40, 160, 20},
			},
			belt = {
				node = hip_node,
				position = {0.13, 0.1, -0.24},
				rotation = {130, -70, 110},
			},
		},
	},
	dr_1h_hammer_shield = {
		right = {
			back = {
				node = default_node_2,
				position = {0.4, -0.2, 0.1},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.5, 0.1},
				rotation = {40, 160, 20},
			},
			belt = {
				node = hip_node,
				position = {0.13, 0.1, -0.24},
				rotation = {130, -70, 110},
			},
		},
		left = {
			back = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
			backpack = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
			belt = {
				node = backpack_node,
				position = {0.3, -0.3, 0.12},
				rotation = {60, -40, -100},
			},
		},
	},
	dr_2h_axes = {
		right = {
			back = {
				node = default_node_2,
				position = {0.5, -0.15, 0.2},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.1, -0.8, 0.5},
				rotation = {40, 160, 20},
			},
		},
	},
	dr_2h_picks = {
		right = {
			back = {
				node = default_node_2,
				position = {0.5, -0.15, 0.2},
				rotation = {0, -110, 90},
			},
			backpack = {
				node = backpack_node,
				position = {0.1, -0.8, 0.5},
				rotation = {40, 160, 20},
			},
		},
	},
	dr_grudgeraker = {
		right = {
			backpack = {
				node = backpack_node,
				position = {-0.2, -0.3, 0.1},
				rotation = {-30, 90, -10},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.2, -0.2},
				rotation = {0, 30, 90},
			},
		},
	},
	dr_crossbow = {
		left = {
			backpack = {
				node = backpack_node,
				position = {-0.1, -0.3, 0.15},
				rotation = {-10, 120, -10},
			},
			back = {
				node = default_node_2,
				position = {0.2, -0.2, -0.1},
				rotation = {270, 0, 110},
			},
		},
	},
	dr_drakefire_pistols = {
		right = {
			node = "j_hips",
			position = {0.1, 0, 0.3},
			rotation = {70, 130, -70},
		},
		left = {
			node = "j_hips",
			position = {0.1, 0, -0.3},
			rotation = {90, 130, -90},
		},
	},
	-- Common
	potion = {
		empire_soldier = {
			left = {
				node = default_node,
				position = {-0.1, -0.1, -0.15},
				rotation = {40, 90, 0},
			},
		},
		bright_wizard = {
			left = {
				node = default_node,
				position = {-0.1, -0.15, -0.1},
				rotation = {120, 110, 90},
			}
		},
		wood_elf = {
			left = {
				node = default_node,
				position = {-0.1, -0.15, -0.1},
				rotation = {120, 110, 90},
			}
		},
		witch_hunter = {
			left = {
				node = default_node,
				position = {-0.1, -0.1, -0.15},
				rotation = {40, 90, 0},
			},
		},
		dwarf_ranger = {
			left = {
				node = default_node,
				position = {-0.1, -0.1, -0.2},
				rotation = {40, 90, 0},
			},
		},
		left = {
			node = default_node,
			position = {-0.1, -0.1, -0.15},
			rotation = {40, 90, 0},
		}
	},
	grenade = {
		empire_soldier = {
			right = {
				node = default_node,
				position = {0, -0.1, 0.2},
				rotation = {40, 90, 0},
			},
			left = {
				node = default_node,
				position = {0, -0.1, 0.2},
				rotation = {40, 90, 0},
			},
		},
		bright_wizard = {
			right = {
				node = default_node,
				position = {0, -0.1, 0.15},
				rotation = {40, 90, 0},
			},
			left = {
				node = default_node,
				position = {0, -0.1, 0.15},
				rotation = {40, 90, 0},
			},
		},
		wood_elf = {
			right = {
				node = default_node,
				position = {0, -0.1, 0.13},
				rotation = {40, 90, 0},
			},
			left = {
				node = default_node,
				position = {0, -0.1, 0.13},
				rotation = {40, 90, 0},
			},
		},
		witch_hunter = {
			right = {
				node = default_node,
				position = {0, -0.1, 0.13},
				rotation = {40, 90, 0},
			},
			left = {
				node = default_node,
				position = {0, -0.1, 0.13},
				rotation = {40, 90, 0},
			},
		},
		dwarf_ranger = {
			right = {
				node = default_node,
				position = {0, -0.1, 0.23},
				rotation = {40, 90, 0},
			},
			left = {
				node = default_node,
				position = {0, -0.1, 0.23},
				rotation = {40, 90, 0},
			},
		},
		right = {
			node = default_node,
			position = {0, -0.1, 0.2},
			rotation = {40, 90, 0},
		},
		left = {
			node = default_node,
			position = {0, -0.1, 0.2},
			rotation = {40, 90, 0},
		},
	},
	healthkit = {
		empire_soldier = {
			left = {
				node = default_node,
				position = {0, -0.15, 0.03},
				rotation = {0, 90, 0},
			},
		},
		bright_wizard = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
			},
		},
		wood_elf = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
			},
		},
		witch_hunter = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
			},
		},
		dwarf_ranger = {
			left = {
				node = backpack_node,
				position = {0.15, -0.2, 0.13},
				rotation = {60, -20, -10},
			},
		},
		left = {
			node = default_node,
			position = {0, -0.15, 0.03},
			rotation = {0, 90, 0},
		},
	},
	-- Default
	default = {
		right = {
			node = default_node,
			position = {0, 0, 0},
			rotation = {0, 0, 0},
		},
		left = {
			node = default_node,
			position = {0, 0, 0},
			rotation = {0, 0, 0},
		},
	},
}
mod.definitions.dwarf_weapons = {
	"dr_1h_axe_shield",
	"dr_handgun",
	"dr_1h_hammer",
	"dr_2h_hammer",
	"dr_1h_axes",
	"dr_1h_hammer_shield",
	"dr_2h_axes",
	"dr_grudgeraker",
	"dr_crossbow",
	"dr_2h_picks",
}
mod.definitions.one_handed = {
	"es_1h_sword",
	"es_1h_sword_shield",
	"es_1h_mace",
	"es_1h_mace_shield",
	"bw_flame_sword",
	"bw_1h_sword",
	"bw_morningstar",
	"bw_dagger",
	"wh_fencing_sword",
	"wh_1h_falchions",
	"wh_1h_axes",
	"ww_1h_sword",
	"ww_dual_swords",
	"ww_sword_and_dagger",
	"ww_dual_daggers",
	"dr_1h_axe_shield",
	"dr_1h_hammer",
	"dr_1h_axes",
	"dr_1h_hammer_shield",
}
mod.definitions.waywatcher_dual = {
	"ww_dual_swords",
	"ww_sword_and_dagger",
	"ww_dual_daggers",
}