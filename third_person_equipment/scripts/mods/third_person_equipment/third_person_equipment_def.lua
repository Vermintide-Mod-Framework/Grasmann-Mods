local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment definitions
		- Provides configurations for equipment positions
	
	Author: grasmann
--]]

local default_node = "j_spine"
local default_node_2 = "j_spine2"
local backpack_node = VT1 and "a_hanging_trophy_3" or default_node
local hip_node = "j_hips"
local left_leg_node = "j_leftupleg"
local right_leg_node = "j_rightupleg"

mod.definitions = {
	dwarf_weapons = {
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
		"dr_dual_axes",
		"dr_drakegun",
		"dr_drakefire_pistols",
	},
	dwarf_two_handed = {
		"dr_2h_hammer",
		"dr_2h_axes",
		"dr_2h_picks",
	},
	one_handed = {
		"es_1h_sword",
		"es_1h_sword_shield",
		"es_1h_mace",
		"es_1h_mace_shield",
		"bw_flame_sword",
		"bw_1h_sword",
		"bw_morningstar",
		"bw_dagger",
		"bw_1h_dagger",
		"wh_fencing_sword",
		"wh_1h_falchions",
		"wh_1h_axes",
		"es_flail",
		"ww_1h_sword",
		"ww_dual_swords",
		"ww_sword_and_dagger",
		"ww_dual_daggers",
		"dr_1h_axe_shield",
		"dr_1h_hammer",
		"dr_1h_axes",
		"dr_1h_hammer_shield",
		"dr_dual_axes",
	},
	waywatcher_dual = {
		"ww_dual_swords",
		"ww_sword_and_dagger",
		"ww_dual_daggers",
	},
	big_weapons = {
		"dr_drakegun",
		"wh_repeating_crossbow",
		"wh_crossbow",
		"bw_staff_beam",
		"bw_staff_spear",
		"bw_staff_geiser",
		"bw_staff_firball",
		"bw_staff_flamethrower",
		"es_2h_halberd",
	},

	-- Pickups
	wpn_side_objective_tome_01 = {
		left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},
		},
	},
	potion_healing_draught_01 = {
		left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},
		},
	},
	healthkit_first_aid_kit_01 = {
		left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},
		},
	},
	potion = {
		left = { node = default_node, position = {-0.1, -0.3, -0.15}, rotation = {40, 90, 0},
		},
	},
	grenade = {
		right = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0},
		},
		left = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0},
		},
	},
	healthkit = {
		left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},
		},
	},

	-- Default
	default = {
		right = { node = default_node, position = {0, 0, 0}, rotation = {0, 0, 0},
		},
		left = { node = default_node, position = {0, 0, 0}, rotation = {0, 0, 0},
		},
	},
}
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_soldier")
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_mage")
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_witchhunter")
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_waywatcher")
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_dwarf")
