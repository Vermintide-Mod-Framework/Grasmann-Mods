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
	
	-- Soldier
	es_handgun = {
		right = {
			node = default_node,
			position = {0.5, -0.23, -0.2},
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
			position = {0.8, -0.22, 0.2},
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
				position = {0.3, -0.2, 0.1},
				rotation = {0, 90, 90},
				es_knight = {
					node = default_node,
					position = {0.3, -0.22, 0.1},
					rotation = {0, 90, 90},
				},
			},
			back = {
				node = default_node,
				position = {0.4, -0.2, 0.05},
				rotation = {0, 160, 75},
				es_knight = {
					node = default_node,
					position = {0.4, -0.22, 0.05},
					rotation = {0, 160, 75},
				},
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
				position = {0.4, -0.2, 0.05},
				rotation = {0, 160, 75},
			},
		},
	},
	es_repeating_handgun = {
		right = {
			node = default_node,
			position = {0.5, -0.22, -0.2},
			rotation = {0, 30, 90},
		},
	},
	es_blunderbuss = {
		right = {
			node = default_node,
			position = {0.5, -0.23, -0.2},
			rotation = {0, 30, 90},
		},
	},
	-- VT2
	es_2h_halberd = {
		right = {
			node = default_node,
			position = {0.5, -0.22, 0.1},
			rotation = {0, -110, 90},
		},
	},
	es_2h_sword_executioner = {
		right = {
			node = default_node,
			position = {0.7, -0.22, 0.2},
			rotation = {0, -110, 90},
		},
	},
	
	--- Mage
	bw_flame_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.05, -0.14},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.25, -0.14, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_1h_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.05, -0.14},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.25, -0.14, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_morningstar = {
		right = {
			belt = {
				node = hip_node,
				position = {0.3, 0, -0.1},
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
			position = {0, -0.15, 0},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_firball = {
		right = {
			node = default_node_2,
			position = {0, -0.15, 0},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_geiser = {
		right = {
			node = default_node_2,
			position = {0, -0.15, 0},
			rotation = {0, 110, 180},
		},
	},
	bw_staff_spear = {
		right = {
			node = default_node_2,
			position = {0, -0.15, 0},
			rotation = {0, 110, 180},
		},
	},
	bw_dagger = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.05, -0.14},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.25, -0.14, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	-- VT2
	bw_1h_dagger = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0.05, -0.14},
				rotation = {130, -70, 110},
			},
			back = {
				node = default_node_2,
				position = {0.25, -0.14, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	bw_staff_flamethrower = {
		right = {
			node = default_node_2,
			position = {0, -0.15, 0},
			rotation = {0, 110, 180},
		},
	},
	
	-- Witchhunter
	wh_2h_sword = {
		right = {
			node = default_node_2,
			position = {0.4, -0.17, 0.2},
			rotation = {0, -110, 90},
		},
	},
	wh_repeating_crossbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.2, -0.1},
			rotation = {270, 0, 110},
			we_shade = {
				attachment = 2, attachment_node = 5, position = {0, 0.05, 0.05}, rotation = {-90, -10, -125},
			},
		},
	},
	wh_fencing_sword = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0, -0.17},
				rotation = {150, -70, 150},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.17, 0.1},
				rotation = {0, -110, 90},
			},
		},
		left = {
			belt = {
				node = hip_node,
				position = {0, 0, 0.2},
				rotation = {70, 50, 100},
			},
			back = {
				node = hip_node,
				position = {0, 0, -0.2},
				rotation = {70, 50, -240},
			},
		},
	},
	wh_1h_falchions = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0, -0.17},
				rotation = {150, -70, 150},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.16, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	wh_1h_axes = {
		right = {
			belt = {
				node = hip_node,
				position = {0.1, 0.1, -0.17},
				rotation = {120, -50, 140},
			},
			back = {
				node = default_node_2,
				position = {0.3, -0.17, 0.1},
				rotation = {0, -110, 90},
			},
		},
	},
	wh_brace_of_pisols = {
		right = {
			node = hip_node,
			position = {0, 0, 0.2},
			rotation = {70, 50, 100},
		},
		left = {
			node = hip_node,
			position = {0, 0, -0.2},
			rotation = {70, 50, -240},
		},
	},
	wh_crossbow = {
		left = {
			node = default_node_2,
			position = {0.15, -0.18, -0.1},
			rotation = {270, 0, 110},
		},
	},
	wh_repeating_pistol = {
		right = {
			node = default_node_2,
			position = {0.1, -0.17, -0.1},
			rotation = {0, 30, 90},
		},
	},
	-- VT2
	es_flail = {
		right = {
			belt = {
				node = hip_node,
				position = {0.2, 0, -0.17},
				rotation = {150, -70, 150},
			},
			back = {
				node = hip_node,
				position = {0.2, 0, -0.17},
				rotation = {150, -70, 150},
			},
		},
	},
	
	-- Waywatcher
	ww_2h_axe = {
		right = {
			node = default_node_2,
			position = {0.4, -0.1, 0.1},
			rotation = {0, -110, 90},
			--we_waywatcher = {attachment = 2, attachment_node = 8, position = {-0.4, -0.3, 0.1}, rotation = {90, 90, 80}, },
			we_waywatcher = {node = default_node_2, position = {0.4, -0.1, 0.1}, rotation = {-40, -110, 50}, },
			we_maidenguard = {
				--4
				attachment = 2, attachment_node = 19, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75},
			},
			we_shade = {
				attachment = 2, attachment_node = 18, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75},
			},
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
				we_shade = {
					node = hip_node,
					position = {0.16, 0, 0.16},
					rotation = {40, -70, 220},
				},
			},
			back = {
				node = default_node_2,
				position = {0.2, -0.1, 0.1},
				rotation = {0, -110, 90},
				we_shade = {
					attachment = 2, attachment_node = 18, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75},
				}
			},
		},
	},
	ww_dual_swords = {
		right = {
			belt = {
				node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
			},
			back = {
				node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },
			},
		},
		left = {
			belt = {
				node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
			},
			back = {
				node = default_node_2, position = {0.2, -0.1, -0.2}, rotation = {0, -50, 90},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-20, 60, 100}, },
			},
		},
	},
	ww_sword_and_dagger = {
		right = {
			belt = {
				node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
			},
			back = {
				node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },
			},
		},
		left = {
			belt = {
				node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
			},
			back = {
				node = default_node_2,
				position = {0.2, -0.1, -0.2},
				rotation = {0, -50, 90},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-20, 60, 100}, },
			},
		},
	},
	ww_dual_daggers = {
		right = {
			belt = {
				node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },
			},
			back = {
				node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },
			},
		},
		left = {
			belt = {
				node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },
			},
			back = {
				node = default_node_2, position = {0.2, -0.1, -0.2}, rotation = {0, -50, 90},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-20, 60, 100}, },
			},
		},
	},
	ww_longbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
			es_huntsman = {
				node = default_node,
				position = {0.3, -0.23, 0.1},
				rotation = {0, -60, -90},
			},
			empire_soldier_tutorial = {
				node = default_node,
				position = {0.3, -0.23, 0.1},
				rotation = {0, -60, -90},
			},
			we_shade = {
				attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90},
			},
		},
	},
	ww_shortbow = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
			we_shade = {
				attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90},
			},
		},
	},
	ww_hagbane = {
		left = {
			node = default_node_2,
			position = {0.1, -0.15, 0},
			rotation = {0, -45, -90},
			we_shade = {
				attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90},
			},
		},
	},
	-- VT2
	we_2h_spear = {
		right = {
			node = default_node_2,
			position = {-0.1, -0.15, -0.1},
			rotation = {0, -290, 90},
			we_shade = {
				attachment = 2, attachment_node = 18, position = {0.2, 0.05, -0.1}, rotation = {20, -60, 90},
			}
		},
	},
	ww_2h_sword = {
		right = {
			node = default_node_2,
			position = {0.4, -0.1, 0.1},
			rotation = {0, -110, 90},
			we_shade = {
				attachment = 2, attachment_node = 18, position = {-0.1, -0.01, 0.06}, rotation = {20, 120, 90},
			},
		},
	},
	
	-- Dwarf
	dr_1h_axe_shield = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90}, 
				dr_ranger = { node = default_node_2, position = {0.3, -0.2, 0.1}, rotation = {0, -110, 90}, },
				dr_ironbreaker = { node = default_node_2, position = {0.3, -0.2, 0.1}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.3, -0.2, 0.1}, rotation = {0, -110, 90}, },
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.12, -0.03, -0.25}, rotation = {0, 15, 180}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.1}, rotation = {0, 180, 180}, },
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},
				dr_ranger = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, },
				dr_ironbreaker = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, },
				dr_slayer = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, },
			},
		},
		left = {
			back = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
			backpack = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.02, -0.07, -0.2}, rotation = {0, -140, 90}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.07, 0.1}, rotation = {0, 0, 90}, },
			},
			belt = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
		},
	},
	dr_handgun = {
		right = {
			backpack = { node = backpack_node, position = {-0.2, -0.45, 0.25}, rotation = {-30, 90, -10},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {-0.35, 0.05, -0.3}, rotation = {90, 0, 0}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.15, 0, 0.3}, rotation = {-90, 180, 0}, },
			},
			back = { node = default_node_2, position = {0.3, -0.2, -0.2}, rotation = {0, 30, 90},
				dr_ranger = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },
			},
		},
	},
	dr_1h_hammer = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.10, -0.03, -0.25}, rotation = {0, 15, 180}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.25}, rotation = {0, 180, 180}, },
				dr_slayer = { copy = "back", },
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.28}, rotation = {130, -70, 110},
				dr_ranger = { node = hip_node, position = {0.13, 0.1, -0.28}, rotation = {130, -70, 110}, },
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },
				dr_slayer = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },
			},
		},
	},
	dr_2h_hammer = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.15, 0.2}, rotation = {0, -110, 90},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, replace = "backpack", },
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -90}, },
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, replace = "back", },
			},
		},
	},
	dr_1h_axes = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},
				dr_ranger = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.21, 0.1}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.10, -0.03, -0.25}, rotation = {0, 15, 180}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.3}, rotation = {0, 180, 180}, },
				dr_slayer = { copy = "back", },
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},
				dr_ranger = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, -40}, },
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, -40}, },
				dr_slayer = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },
			},
		},
	},
	dr_1h_hammer_shield = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.12, -0.03, -0.25}, rotation = {0, 15, 180}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.25}, rotation = {0, 180, 90}, },
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},
				dr_ranger = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110}, },
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110}, },
			},
		},
		left = {
			back = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
			backpack = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.02, -0.07, -0.2}, rotation = {0, -140, 90}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.07, 0.1}, rotation = {0, 0, 90}, },
			},
			belt = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
		},
	},
	dr_2h_axes = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90},
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90}, replace = "backpack", }
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -90}, },
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, replace = "back", },
			},
		},
	},
	dr_2h_picks = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.17, 0.2}, rotation = {0, -110, 90},
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90}, replace = "backpack", },
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -60}, },
				dr_slayer = { replace = "back", node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, },
			},
		},
	},
	dr_grudgeraker = {
		right = {
			backpack = { node = backpack_node, position = {-0.2, -0.3, 0.1}, rotation = {-30, 90, -10},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {-0.35, 0.05, -0.3}, rotation = {90, 0, 0}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.15, -0.02, 0.3}, rotation = {-90, 180, 0}, },
			},
			back = { node = default_node_2, position = {0.3, -0.2, -0.2}, rotation = {0, 30, 90},
				dr_ranger = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },
			},
		},
	},
	dr_crossbow = {
		left = {
			backpack = { node = backpack_node, position = {-0.1, -0.3, 0.15}, rotation = {-10, 120, -10},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {-0.4, 0, -0.15}, rotation = {90, 0, 0}, },
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.17, -0.05, 0.22}, rotation = {90, 0, 180}, },
			},
			back = { node = default_node_2, position = {0.2, -0.2, -0.1}, rotation = {270, 0, 110},
				dr_ranger = { copy = "backpack", },
				dr_ironbreaker = { copy = "backpack", },
			},
		},
	},
	dr_drakefire_pistols = {
		right = { node = hip_node, position = {0.1, 0, 0.3}, rotation = {70, 130, -70},
			dr_ironbreaker = { node = hip_node, position = {0.1, 0, 0.3}, rotation = {-90, 130, -90}, },
		},
		left = { node = hip_node, position = {0.1, 0, -0.3}, rotation = {90, 130, -90},
			dr_ironbreaker = { node = hip_node, position = {0.1, 0, -0.3}, rotation = {-90, 130, -90}, },
		},
	},
	-- VT2
	dr_drakegun = {
		right = {
			back = { copy = "backpack", },
			backpack = { attachment = 1, attachment_node = 6, position = {0.05, -0.02, 0.25}, rotation = {90, 0, 0}, },
		},
	},
	dr_dual_axes = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, replace = "back", },
			back = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, replace = "belt", },
			backpack = { copy = "back", replace = "belt", },
		},
		left = {
			belt = { node = hip_node, position = {0.2, 0.1, 0.25}, rotation = {20, -80, 200}, replace = "back", },
			back = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {12, -50, -78}, replace = "belt", },
			backpack = { copy = "back", replace = "belt", },
		},
	},
	
	-- Common
	potion = {
		empire_soldier = {
			left = {
				node = default_node,
				position = {-0.05, -0.12, -0.15},
				rotation = {-60, 70, -90},
			},
		},
		bright_wizard = {
			left = {
				node = default_node,
				position = {-0.05, -0.1, -0.13},
				rotation = {-60, 60, -90},
				bw_adept = {
					node = default_node,
					position = {-0.08, 0.17, 0.05},
					rotation = {-70, 110, -90},
				},
				bw_scholar = {
					node = default_node,
					position = {-0.09, 0.15, 0.05},
					rotation = {-70, 110, -90},
				},
				bw_unchained = {
					node = default_node,
					position = {-0.09, 0.15, 0.05},
					rotation = {-70, 110, -90},
				},
			},
		},
		wood_elf = {
			left = {
				node = default_node,
				position = {-0.1, -0.15, -0.1},
				rotation = {120, 110, 90},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = right_leg_node,
					position = {-0.1, -0.05, 0.12},
					rotation = {-55, 110, 0},
				},
			},
		},
		witch_hunter = {
			left = {
				node = default_node,
				position = {-0.05, -0.16, -0.16},
				rotation = {-60, 60, -90},
				wh_captain = {
					node = default_node,
					position = {0, 0.17, 0.05},
					rotation = {-70, 110, -90},
				},
				wh_bountyhunter = {
					node = default_node,
					position = {0, 0.17, 0.05},
					rotation = {-70, 110, -90},
				},
				wh_zealot = {
					node = default_node,
					position = {0.03, 0.2, 0.05},
					rotation = {-70, 110, -90},
				},
			},
		},
		dwarf_ranger = {
			left = {
				node = backpack_node,
				position = {0.07, 0.04, -0.04},
				rotation = {40, -20, -10},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {0, -0.1, 0}, rotation = {-20, 180, 0}, },
				dr_ironbreaker = {
					node = default_node,
					position = {-0.05, 0.25, 0.15},
					rotation = {-70, 110, -90},
				},
				dr_slayer = {
					node = default_node,
					position = {-0.05, 0.25, 0.1},
					rotation = {-70, 110, -90},
				},
			},
		},
		left = {
			node = default_node,
			position = {-0.1, -0.3, -0.15},
			rotation = {40, 90, 0},
		},
		-- VT2
		way_watcher = {
			left = {
				node = default_node,
				position = {-0.1, -0.15, -0.1},
				rotation = {120, 110, 90},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = right_leg_node,
					position = {-0.1, -0.05, 0.12},
					rotation = {-55, 110, 0},
				},
			},
		},
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
				position = {0, -0.13, 0.08},
				rotation = {60, 120, 0},
				bw_adept = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
				bw_scholar = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
				bw_unchained = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
			},
			left = {
				node = default_node,
				position = {0, -0.13, 0.08},
				rotation = {60, 120, 30},
				bw_adept = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
				bw_scholar = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
				bw_unchained = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
			},
		},
		wood_elf = {
			right = {
				node = default_node,
				position = {-0.1, -0.18, 0.08},
				rotation = {60, 120, 0},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = hip_node,
					position = {0.05, -0.1, -0.15},
					rotation = {-45, 70, 0},
				},
			},
			left = {
				node = default_node,
				position = {-0.1, -0.18, 0.08},
				rotation = {60, 120, 30},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = hip_node,
					position = {0.05, -0.1, -0.15},
					rotation = {-45, 70, 0},
				},
			},
		},
		witch_hunter = {
			right = {
				node = default_node,
				position = {0, -0.18, 0.08},
				rotation = {60, 120, 0},
				wh_captain = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
				wh_bountyhunter = {
					node = default_node,
					position = {0, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
				wh_zealot = {
					node = default_node,
					position = {0, -0.19, 0.1},
					rotation = {60, 120, 0},
				},
			},
			left = {
				node = default_node,
				position = {0, -0.18, 0.08},
				rotation = {60, 120, 30},
				wh_captain = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
				wh_bountyhunter = {
					node = default_node,
					position = {0, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
				wh_zealot = {
					node = default_node,
					position = {0, -0.19, 0.1},
					rotation = {60, 120, 30},
				},
			},
		},
		dwarf_ranger = {
			right = {
				node = backpack_node,
				position = {0.35, -0.13, -0.07},
				rotation = {60, -20, -10},
				dr_ranger = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
				dr_ironbreaker = {
					node = default_node,
					position = {-0.1, -0.24, 0.1},
					rotation = {60, 120, 0},
				},
				dr_slayer = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 0},
				},
			},
			left = {
				node = backpack_node,
				position = {0.35, -0.13, -0.07},
				rotation = {60, -20, -10},
				dr_ranger = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
				dr_ironbreaker = {
					node = default_node,
					position = {-0.1, -0.24, 0.1},
					rotation = {60, 120, 30},
				},
				dr_slayer = {
					node = default_node,
					position = {-0.1, -0.18, 0.1},
					rotation = {60, 120, 30},
				},
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
		-- VT2
		way_watcher = {
			right = {
				node = default_node,
				position = {-0.1, -0.18, 0.08},
				rotation = {60, 120, 0},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = hip_node,
					position = {0.05, -0.1, -0.15},
					rotation = {-45, 70, 0},
				},
				-- we_shade = {
				-- 	attachment = 1, attachment_node = 4, position = {-0.1, -0.2, 0.15}, rotation = {-80, -70, 90},
				-- },
			},
			left = {
				node = default_node,
				position = {-0.1, -0.18, 0.08},
				rotation = {60, 120, 30},
				we_waywatcher = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_maidenguard = {
					node = default_node,
					position = {0, 0.15, 0.05},
					rotation = {0, 90, 20},
				},
				we_shade = {
					node = hip_node,
					position = {0.05, -0.02, -0.18},
					rotation = {-50, 70, -60},
				},
				-- we_shade = {
				-- 	attachment = 1, attachment_node = 4, position = {-0.1, -0.2, 0.15}, rotation = {-80, -70, 90},
				-- },
			},
		},
	},
	healthkit = {
		empire_soldier = {
			left = {
				node = default_node,
				position = {0, -0.15, 0.03},
				rotation = {0, 90, 0},
				es_mercenary = {
					node = default_node,
					position = {0, -0.15, 0.03},
					rotation = {10, 100, 150},
				},
				es_huntsman = {
					node = default_node,
					position = {0, -0.15, 0.03},
					rotation = {10, 100, 150},
				},
				es_knight = {
					node = default_node,
					position = {0, -0.15, 0.03},
					rotation = {10, 100, 150},
				},
				empire_soldier_tutorial = {
					node = default_node,
					position = {0, -0.15, 0.03},
					rotation = {10, 100, 150},
				},
			},
		},
		bright_wizard = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
				bw_adept = {
					node = default_node,
					position = {-0.05, -0.16, -0.05},
					rotation = {0, 90, 170},
				},
				bw_scholar = {
					node = default_node,
					position = {-0.05, -0.16, -0.05},
					rotation = {0, 90, 170},
				},
				bw_unchained = {
					node = default_node,
					position = {-0.05, -0.16, -0.05},
					rotation = {0, 90, 170},
				},
			},
		},
		wood_elf = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
				we_waywatcher = {
					node = default_node,
					position = {-0.1, -0.1, -0.13},
					rotation = {100, 110, 90},
				},
				we_maidenguard = {
					node = default_node,
					position = {-0.1, -0.1, -0.13},
					rotation = {100, 110, 90},
				},
				we_shade = {
					node = hip_node,
					position = {0.08, -0.12, 0},
					rotation = {260, 75, -90},
				},
				-- we_shade = {
				-- 	attachment = 1, attachment_node = 4, position = {-0.1, -0.25, 0}, rotation = {-80, -70, 90},
				-- },
			},
		},
		witch_hunter = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
				wh_captain = {
					node = default_node,
					position = {-0.05, -0.16, -0.05},
					rotation = {0, 90, 170},
				},
				wh_bountyhunter = {
					node = default_node,
					position = {-0.05, -0.16, -0.05},
					rotation = {0, 90, 170},
				},
				wh_zealot = {
					node = default_node,
					position = {0.05, -0.17, -0.05},
					rotation = {0, 90, 170},
				},
			},
		},
		dwarf_ranger = {
			left = {
				node = backpack_node,
				position = {0.15, -0.2, 0.13},
				rotation = {60, -20, -10},
				dr_ranger = { attachment = 1, attachment_node = 9, position = {-0.25, -0.03, -0.25}, rotation = {40, 180, 185},
					-- node = default_node,
					-- position = {-0.05, -0.16, -0.05},
					-- rotation = {0, 0, 170},
				},
				dr_ironbreaker = {
					node = default_node,
					position = {0, -0.15, -0.18},
					rotation = {-70, 70, -90},
				},
				dr_slayer = {
					node = default_node,
					position = {-0.05, -0.2, -0.05},
					rotation = {0, 90, 170},
				},
			},
		},
		left = {
			node = default_node,
			position = {0, -0.15, 0.03},
			rotation = {0, 90, 0},
		},
		-- VT2
		way_watcher = {
			left = {
				node = default_node,
				position = {0, 0.15, 0.05},
				rotation = {0, 90, 20},
				we_waywatcher = {
					node = default_node,
					position = {-0.1, -0.1, -0.13},
					rotation = {100, 110, 90},
				},
				we_maidenguard = {
					node = default_node,
					position = {-0.1, -0.1, -0.13},
					rotation = {100, 110, 90},
				},
				we_shade = {
					node = hip_node,
					position = {0.08, -0.12, 0},
					rotation = {260, 75, -90},
				},
				-- we_shade = {
				-- 	attachment = 1, attachment_node = 4, position = {-0.1, -0.25, 0}, rotation = {-80, -70, 90},
				-- },
			},
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
	"dr_dual_axes",
	"dr_drakegun",
	"dr_drakefire_pistols",
}
mod.definitions.dwarf_two_handed = {
	"dr_2h_hammer",
	"dr_2h_axes",
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
}
mod.definitions.waywatcher_dual = {
	"ww_dual_swords",
	"ww_sword_and_dagger",
	"ww_dual_daggers",
}
mod.definitions.big_weapons = {
	"dr_drakegun",
	"wh_repeating_crossbow",
	"wh_crossbow",
	"bw_staff_beam",
	"bw_staff_spear",
	"bw_staff_geiser",
	"bw_staff_firball",
	"bw_staff_flamethrower",
	"es_2h_halberd",
}