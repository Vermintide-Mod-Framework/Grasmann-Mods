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
	
	-- kinght 3, 10, 17

	-- Soldier
	es_handgun = {
		right = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.5, -0.23, -0.17}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
		},
	},
	es_2h_sword_exec = {
		right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},									-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},									-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },				-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },		-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },						-- V2 huntsman					2.1.0
		},
	},
	es_1h_sword = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- Default / V1					2.1.0
				es_mercenary = {
					node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -70, 110},									-- V2 mercenary					2.1.0
					skin_es_default = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -70, 110}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },						-- V2 knight
				es_huntsman = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },					-- V2 huntsman					2.1.0
			},
			back = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
					skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {-0.2, 0.04, 0.1}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
			},
		},
	},
	es_2h_war_hammer = {
		right = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
		},
	},
	es_1h_sword_shield = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- Default / V1					2.1.0
				es_mercenary = {
					node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- V2 mercenary					2.1.0
					skin_es_default = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -70, 110}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },						-- V2 knight					2.1.0
				es_huntsman = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },					-- V2 huntsman					2.1.0
			},
			back = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- V2 mercenary
					skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {-0.2, 0.04, 0.1}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
			},
		},
		left = {
			belt = { node = default_node, position = {0.3, -0.2, 0.1}, rotation = {0, 90, 90},									-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90},									-- V2 mercenary					2.1.0
					skin_es_default = { node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {0.1, 0.05, 0.1}, rotation = {0, -65, -100}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90}, },					-- V2 huntsman					2.1.0
			},
			back = { copy = "belt" },																							-- Default / V1					2.1.0
		},
	},
	es_2h_sword = {	
		right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
		},
	},
	es_1h_mace = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- Default / V1					2.1.0
				es_mercenary = {
					node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- V2 mercenary					2.1.0
					skin_es_default = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -70, 110}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },						-- V2 knight					2.1.0
				es_huntsman = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },					-- V2 huntsman					2.1.0
			},
			back = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
					skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {-0.2, 0.04, 0.1}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
			},
		},
	},
	es_1h_mace_shield = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- Default / V1					2.1.0
				es_mercenary = {
					node = hip_node, position = {0.2, 0.1, -0.21}, rotation = {130, -70, 110},									-- V2 mercenary					2.1.0
					skin_es_default = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -70, 110}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },						-- V2 knight					2.1.0
				es_huntsman = { node = hip_node, position = {0.2, 0.1, -0.18}, rotation = {130, -60, 110}, },					-- V2 huntsman					2.1.0
			},
			back = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
					skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {-0.2, 0.04, 0.1}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
			},
		},
		left = {
			belt = { node = default_node, position = {0.3, -0.22, 0.1}, rotation = {0, 90, 90},									-- Default / V1					2.1.0
				es_mercenary = {
					node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90},									-- V2 mercenary					2.1.0
					skin_es_default = { node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90}, },			-- V2 classic mercenary skin	2.1.0
				},
				es_knight = { attachment = 1, attachment_node = 10, position = {0.1, 0.05, 0.1}, rotation = {0, -65, -100}, },	-- V2 knight					2.1.0
				es_huntsman = { node = default_node, position = {0.3, -0.27, 0.1}, rotation = {0, 90, 90}, },					-- V2 huntsman					2.1.0
			},
			back = { copy = "belt" },																							-- Default / V1					2.1.0
		},
	},
	es_repeating_handgun = {
		right = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
		},
	},
	es_blunderbuss = {
		right = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
			es_mercenary = {
				node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
		},
	},
	-- VT2
	es_2h_halberd = {
		right = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
			es_mercenary = {	
				node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.1, 0.04, 0}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
		},
	},
	es_2h_sword_executioner = {
		right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
			es_mercenary = {	
				node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								-- V2 mercenary					2.1.0
				skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },			-- V2 classic mercenary skin	2.1.0
			},
			es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	-- V2 knight					2.1.0
			es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
		},
	},
	
	--- Mage
	bw_flame_sword = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110},									-- Default / V1						2.1.0
				bw_adept = { 
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
			back = { node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.1.0
				bw_adept = { 
					node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60}, 								-- V2 battle wizard					2.1.0
					skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-60, -110, 30}, },			-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },				-- V2 unchained						2.1.0
				bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },		-- V2 pyromancer					2.1.0
			},
		},
	},
	bw_1h_sword = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110},									-- Default / V1						2.1.0
				bw_adept = { 
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
			back = { node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.1.0
				bw_adept = { 
					node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60}, 								-- V2 battle wizard					2.1.0
					skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-60, -110, 30}, },			-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },				-- V2 unchained						2.1.0
				bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },		-- V2 pyromancer					2.1.0
			},
		},
	},
	bw_morningstar = {
		right = {
			belt = { node = hip_node, position = {0.3, 0, -0.1}, rotation = {130, -70, 110},									-- Default / V1						2.1.0
				bw_adept = { 	
					node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60},							-- V2 battle wizard					2.1.0
					skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-40, -110, 30}, },		-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },			-- V2 unchained						2.1.0
				bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },	-- V2 pyromancer					2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.15, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.1.0
				bw_adept = { 
					node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60}, 							-- V2 battle wizard					2.1.0
					skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-40, -110, 30}, },		-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },			-- V2 unchained						2.1.0
				bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },	-- V2 pyromancer					2.1.0
			},
		},
	},
	bw_staff_beam = {
		right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									-- Default / V1						2.1.0
			bw_adept = { 	
				node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										-- V2 battle wizard					2.1.0
				skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				-- V2 classic battle wizard skin	2.1.0
			},
			bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						-- V2 unchained						2.1.0
			bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	-- V2 pyromancer					2.1.0
		},
	},
	bw_staff_firball = {
		right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									-- Default / V1						2.1.0
			bw_adept = { 	
				node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										-- V2 battle wizard					2.1.0
				skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				-- V2 classic battle wizard skin	2.1.0
			},
			bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						-- V2 unchained						2.1.0
			bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	-- V2 pyromancer					2.1.0
		},
	},
	bw_staff_geiser = {
		right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									-- Default / V1						2.1.0
			bw_adept = { 	
				node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										-- V2 battle wizard					2.1.0
				skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				-- V2 classic battle wizard skin	2.1.0
			},
			bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						-- V2 unchained						2.1.0
			bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	-- V2 pyromancer					2.1.0
		},
	},
	bw_staff_spear = {
		right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									-- Default / V1						2.1.0
			bw_adept = { 	
				node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										-- V2 battle wizard					2.1.0
				skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				-- V2 classic battle wizard skin	2.1.0
			},
			bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						-- V2 unchained						2.1.0
			bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	-- V2 pyromancer					2.1.0
		},
	},
	bw_dagger = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110},									-- Default / V1						2.1.0
				bw_adept = { 	
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
			back = { node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.1.0
				bw_adept = { 
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
		},
	},
	-- VT2
	bw_1h_dagger = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110},									-- Default / V1						2.1.0
				bw_adept = { 	
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
			back = { node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.1.0
				bw_adept = { 
					node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.1.0
					skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.1.0
				},
				bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.1.0
				bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.1.0
			},
		},
	},
	bw_staff_flamethrower = {
		right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									-- Default / V1						2.1.0
			bw_adept = { 	
				node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										-- V2 battle wizard					2.1.0
				skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				-- V2 classic battle wizard skin	2.1.0
			},
			bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						-- V2 unchained						2.1.0
			bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	-- V2 pyromancer					2.1.0
		},
	},
	
	-- Witchhunter
	wh_2h_sword = {
		right = { node = default_node_2, position = {0.4, -0.17, 0.2}, rotation = {0, -110, 90},						-- Default / V1					2.1.0
			wh_captain = {
				node = default_node_2, position = {0.4, -0.16, 0.2}, rotation = {-10, -110, 90},						-- V2 captain					2.1.0
				skin_wh_default = { node = default_node_2, position = {0.3, -0.1, 0.2}, rotation = {-20, -130, 70}, },	-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = default_node_2, position = {0.4, -0.18, 0.2}, rotation = {-10, -110, 90}, },		-- V2 bountyhunter				2.1.0
			wh_zealot = { node = default_node_2, position = {0.4, -0.14, 0.2}, rotation = {-20, -110, 90}, },			-- V2 zealot					2.1.0
		},
	},
	wh_repeating_crossbow = {
		left = { node = default_node_2, position = {0.1, -0.2, -0.1}, rotation = {270, 0, 110},								-- Default / V1					2.1.0
			wh_captain = {
				node = default_node_2, position = {0.1, -0.23, -0.1}, rotation = {270, 0, 110},								-- V2 captain					2.1.0
				skin_wh_default = { node = default_node_2, position = {0.1, -0.2, -0.1}, rotation = {270, 0, 110}, },		-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = default_node_2, position = {0.1, -0.24, -0.1}, rotation = {270, 0, 110}, },			-- V2 bountyhunter				2.1.0
			wh_zealot = { node = default_node_2, position = {0.1, -0.23, -0.1}, rotation = {270, 0, 110}, },				-- V2 zealot					2.1.0
			we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.05, 0.05}, rotation = {-90, -10, -125}, },	-- V2 shade						2.1.0
		},
	},
	wh_fencing_sword = {
		right = {
			belt = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150},									-- Default / V1					2.1.0
				wh_captain = {
					attachment = 5, attachment_node = 2, position = {0, 0.04, 0}, rotation = {90, 90, 0},						-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },				-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },					-- V2 bountyhunter				2.1.0
				wh_zealot = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },						-- V2 zealot					2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				wh_captain = {
					node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {-10, -110, 90},							-- V2 captain					2.1.0
					skin_wh_default = { node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {-10, -110, 90}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = default_node_2, position = {0.3, -0.18, 0.1}, rotation = {-20, -110, 90}, },			-- V2 bountyhunter				2.1.0
				wh_zealot = { node = default_node_2, position = {0.3, -0.16, 0.1}, rotation = {-20, -110, 90}, },				-- V2 zealot					2.1.0
			},
		},
		left = {
			belt = { node = hip_node, position = {0, 0, 0.2}, rotation = {70, 50, 100},									-- Default / V1					2.1.0
				wh_captain = {
					attachment = 2, attachment_node = 4, position = {0.04, 0.05, 0}, rotation = {-50, -120, 50},		-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.1, 0, 0.17}, rotation = {70, 50, 100}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.1, 0, 0.2}, rotation = {60, 45, 100}, },				-- V2 bountyhunter				2.1.0
				wh_zealot = { attachment = 1, attachment_node = 2, position = {0.15, 0.06, -0.05}, rotation = {210, -50, -50}, },						-- V2 zealot					2.1.0
			},
			back = { node = hip_node, position = {0, 0, -0.2}, rotation = {70, 50, -240},								-- Default / V1					2.1.0
				wh_captain = {
					attachment = 2, attachment_node = 4, position = {0.04, 0.05, 0}, rotation = {-50, -120, 50},		-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.1, 0, -0.17}, rotation = {70, 50, -240}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.1, 0, 0.2}, rotation = {60, 45, 100}, },				-- V2 bountyhunter				2.1.0
				wh_zealot = { attachment = 1, attachment_node = 2, position = {0.15, 0.06, -0.05}, rotation = {210, -50, -50}, },					-- V2 zealot					2.1.0
			},
		},
	},
	wh_1h_falchions = {
		right = {
			belt = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150},									-- Default / V1					2.1.0
				wh_captain = {
					attachment = 5, attachment_node = 2, position = {0, 0.04, 0}, rotation = {90, 90, 0},						-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.2, 0, -0.15}, rotation = {150, -70, 150}, },				-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },					-- V2 bountyhunter				2.1.0
				wh_zealot = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },						-- V2 zealot					2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.16, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				wh_captain = {
					node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {-10, -110, 90},							-- V2 captain					2.1.0
					skin_wh_default = { node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {-10, -110, 90}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = default_node_2, position = {0.3, -0.18, 0.1}, rotation = {-20, -110, 90}, },			-- V2 bountyhunter				2.1.0
				wh_zealot = { node = default_node_2, position = {0.3, -0.16, 0.1}, rotation = {-20, -110, 90}, },				-- V2 zealot					2.1.0
			},
		},
	},
	wh_1h_axes = {
		right = {
			belt = { node = hip_node, position = {0.1, 0.1, -0.17}, rotation = {120, -50, 140},									-- Default / V1					2.1.0
				wh_captain = {
					attachment = 5, attachment_node = 2, position = {0, 0.04, 0}, rotation = {90, 90, 0},						-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.2, 0, -0.15}, rotation = {150, -70, 150}, },				-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },					-- V2 bountyhunter				2.1.0
				wh_zealot = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },						-- V2 zealot					2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {0, -110, 90},								-- Default / V1					2.1.0
				wh_captain = {
					node = default_node_2, position = {0.3, -0.18, 0.1}, rotation = {0, -110, 90},								-- V2 captain					2.1.0
					skin_wh_default = { node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {0, -110, 90}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = default_node_2, position = {0.3, -0.2, 0.1}, rotation = {0, -110, 90}, },			-- V2 bountyhunter				2.1.0
				wh_zealot = { node = default_node_2, position = {0.3, -0.18, 0.1}, rotation = {0, -110, 90}, },					-- V2 zealot					2.1.0
			},
		},
	},
	wh_brace_of_pisols = {
		right = { node = hip_node, position = {0, 0, 0.2}, rotation = {70, 50, 100},										-- Default / V1					2.1.0
			wh_captain = {
				attachment = 5, attachment_node = 2, position = {0.26, 0.01, 0}, rotation = {50, -50, -50},					-- V2 captain					2.1.0
				skin_wh_default = { node = hip_node, position = {0.1, 0, 0.17}, rotation = {70, 50, 100}, },				-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = hip_node, position = {0.1, 0, -0.2}, rotation = {70, 50, -240}, },					-- V2 bountyhunter				2.1.0
			wh_zealot = { node = hip_node, position = {0, 0, 0.2}, rotation = {70, 50, 100}, },								-- V2 zealot					2.1.0
		},
		left = { node = hip_node, position = {0, 0, -0.2}, rotation = {70, 50, -240},										-- Default / V1					2.1.0
			wh_captain = {
				node = hip_node, position = {0.15, 0, 0.2}, rotation = {110, 50, 100},										-- V2 captain					2.1.0
				skin_wh_default = { node = hip_node, position = {0.1, 0, -0.17}, rotation = {70, 50, -240}, },				-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = hip_node, position = {0, 0, 0.23}, rotation = {70, 50, 100}, },						-- V2 bountyhunter				2.1.0
			wh_zealot = { node = hip_node, position = {0, 0, -0.23}, rotation = {70, 50, -240}, },							-- V2 zealot					2.1.0
		},
	},
	wh_crossbow = {
		left = { node = default_node_2, position = {0.15, -0.18, -0.1}, rotation = {270, 0, 110},							-- Default / V1					2.1.0
			wh_captain = {
				node = default_node_2, position = {0.15, -0.22, -0.1}, rotation = {270, 0, 110},							-- V2 captain					2.1.0
				skin_wh_default = { node = default_node_2, position = {0.15, -0.2, -0.1}, rotation = {270, 0, 110}, },		-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = default_node_2, position = {0.15, -0.24, -0.1}, rotation = {270, 0, 110}, },			-- V2 bountyhunter				2.1.0
			wh_zealot = { node = default_node_2, position = {0.15, -0.22, -0.1}, rotation = {270, 0, 110}, },				-- V2 zealot					2.1.0
		},
	},
	wh_repeating_pistol = {
		right = { node = default_node_2, position = {0.1, -0.17, -0.1}, rotation = {0, 30, 90},							-- Default / V1					2.1.0
			wh_captain = {
				node = default_node_2, position = {0.1, -0.22, -0.1}, rotation = {0, 30, 90},							-- V2 captain
				skin_wh_default = { node = default_node_2, position = {0.1, -0.17, -0.1}, rotation = {0, 30, 90}, },	-- V2 classic captain skin		2.1.0
			},
			wh_bountyhunter = { node = default_node_2, position = {0.1, -0.24, -0.1}, rotation = {0, 30, 90}, },		-- V2 bountyhunter				2.1.0
			wh_zealot = { node = default_node_2, position = {0.1, -0.23, -0.1}, rotation = {0, 30, 90}, },				-- V2 zealot					2.1.0
		},
	},
	-- VT2
	es_flail = {
		right = {
			belt = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150},							-- Default / V1					2.1.0
				wh_captain = {
					node = hip_node, position = {0.2, 0, -0.22}, rotation = {150, -70, 150},							-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },			-- V2 bountyhunter				2.1.0
				wh_zealot = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },				-- V2 zealot
			},
			back = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150},							-- Default / V1					2.1.0
				wh_captain = {
					node = hip_node, position = {0.2, 0, -0.22}, rotation = {150, -70, 150},							-- V2 captain					2.1.0
					skin_wh_default = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },		-- V2 classic captain skin		2.1.0
				},
				wh_bountyhunter = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },			-- V2 bountyhunter				2.1.0
				wh_zealot = { node = hip_node, position = {0.2, 0, -0.17}, rotation = {150, -70, 150}, },				-- V2 zealot
			},
		},
	},
	
	-- Waywatcher
	ww_2h_axe = {
		right = { node = default_node_2, position = {0.4, -0.1, 0.1}, rotation = {0, -110, 90}, 									-- Default / V1					2.1.0
			we_waywatcher = {
				attachment = 2, attachment_node = 19, position = {-0.2, -0.05, 0}, rotation = {-30, 138, 75}, 						-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.07, 0.1}, rotation = {0, 120, 75}, }, -- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.2, 0.02, -0.05}, rotation = {0, 120, 75}, },	-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 18, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75}, },			-- V2 shade						2.1.0
		},
	},
	ww_trueflight = {
		left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90}, }, -- Default / V1
	},
	ww_1h_sword = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110}, 											-- Default / V1
				we_waywatcher = { 
					node = hip_node, position = {0.16, 0, 0.15}, rotation = {40, -70, 220}, 												-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0, 0.14}, rotation = {40, -70, 220}, },							-- V2 classic waywatcher skin 	2.1.0
				},
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },								-- V2 handmaiden				2.1.0
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },										-- V2 shade						2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 19, position = {-0.15, -0.05, -0.03}, rotation = {0, 120, 40},						-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.07, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
				},
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.2, 0.02, -0.05}, rotation = {0, 120, 75}, },		-- V2 handmaiden				2.1.0
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75}, },				-- V2 shade						2.1.0
			},
		},
	},
	ww_dual_swords = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},												-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, 0.15}, rotation = {40, -70, 220},													-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0, 0.14}, rotation = {40, -70, 220}, },							-- V2 classic waywatcher skin 	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },										-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 19, position = {-0.15, -0.05, -0.03}, rotation = {0, 120, 40},						-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.08, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },					-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },				-- V2 handmaiden				2.1.0
			},
		},
		left = {
			belt = { node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},													-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, -0.16}, rotation = {130, -70, 140},												-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0.1, -0.12}, rotation = {130, -50, 110}, },						-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },									-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, -0.2}, rotation = {0, -50, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 4, position = {-0.15, 0, 0}, rotation = {90, 90, 0},									-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, -0.01, -0.2}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },				-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-10, 50, 100}, },				-- V2 handmaiden				2.1.0
			},
		},
	},
	ww_sword_and_dagger = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},												-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, 0.15}, rotation = {40, -70, 220},													-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0, 0.14}, rotation = {40, -70, 220}, },							-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },										-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
				we_waywatcher = { 	
					attachment = 2, attachment_node = 19, position = {-0.15, -0.05, -0.03}, rotation = {0, 120, 40},						-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.08, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },					-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },				-- V2 handmaiden				2.1.0
			},
		},
		left = {
			belt = { node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},													-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, -0.16}, rotation = {130, -70, 140},												-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0.1, -0.12}, rotation = {130, -50, 110}, },						-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },									-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, -0.2}, rotation = {0, -50, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 4, position = {-0.15, 0, 0}, rotation = {90, 90, 0},									-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, -0.01, -0.2}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },				-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-10, 50, 100}, },				-- V2 handmaiden				2.1.0
			},
		},
	},
	ww_dual_daggers = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.17}, rotation = {130, -70, 110},												-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, 0.15}, rotation = {40, -70, 220},													-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0, 0.14}, rotation = {40, -70, 220}, },							-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },										-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, 0.16}, rotation = {40, -70, 220}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 19, position = {-0.15, -0.05, -0.03}, rotation = {0, 120, 40},						-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.08, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, 0, 0.06}, rotation = {20, 120, 80}, },					-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.1, 0, 0}, rotation = {20, 120, 80}, },				-- V2 handmaiden				2.1.0
			},
		},
		left = {
			belt = { node = hip_node, position = {0.2, 0, 0.17}, rotation = {40, -70, 180},													-- Default / V1
				we_waywatcher = {
					node = hip_node, position = {0.16, 0, -0.16}, rotation = {130, -70, 140},												-- V2 waystalker				2.1.0
					skin_ww_default = { node = hip_node, position = {0.2, 0.1, -0.12}, rotation = {130, -50, 110}, },						-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },									-- V2 shade						2.1.0
				we_maidenguard = { node = hip_node, position = {0.16, 0, -0.17}, rotation = {130, -70, 140}, },								-- V2 handmaiden				2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.1, -0.2}, rotation = {0, -50, 90},											-- Default / V1
				we_waywatcher = { 
					attachment = 2, attachment_node = 4, position = {-0.15, 0, 0}, rotation = {90, 90, 0},									-- V2 waystalker				2.1.0
					skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, -0.01, -0.2}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
				},
				we_shade = { attachment = 2, attachment_node = 5, position = {-0.1, 0, -0.06}, rotation = {-20, 60, 100}, },				-- V2 shade						2.1.0
				we_maidenguard = { attachment = 2, attachment_node = 4, position = {-0.1, 0, 0}, rotation = {-20, 60, 100}, },				-- V2 handmaiden				2.1.0
			},
		},
	},
	ww_longbow = {
		left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90},												-- Default / V1
			es_huntsman = { node = default_node, position = {0.3, -0.23, 0.1}, rotation = {0, -60, -90}, },									-- V2 huntsman
			empire_soldier_tutorial = { node = default_node, position = {0.3, -0.23, 0.1}, rotation = {0, -60, -90}, },						-- V2 tutorial
			we_waywatcher = { 
				attachment = 2, attachment_node = 5, position = {-0.2, -0.02, -0.1}, rotation = {45, 90, 0},								-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 11, position = {-0.15, 0.07, -0.05}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 4, position = {0, 0.01, 0.15}, rotation = {0, 45, 90}, },					-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90}, },							-- V2 shade						2.1.0
		},
	},
	ww_shortbow = {
		left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90},												-- Default / V1
			we_waywatcher = { 
				attachment = 2, attachment_node = 5, position = {-0.2, -0.02, -0.1}, rotation = {45, 90, 0},								-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 11, position = {-0.15, 0.07, -0.05}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 4, position = {0, 0.01, 0.15}, rotation = {0, 45, 90}, },					-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90}, },							-- V2 shade						2.1.0
		},
	},
	ww_hagbane = {
		left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90},												-- Default / V1
			we_waywatcher = { 
				attachment = 2, attachment_node = 5, position = {-0.2, -0.02, -0.1}, rotation = {45, 90, 0},								-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 11, position = {-0.15, 0.07, -0.05}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 4, position = {0, 0.01, 0.15}, rotation = {0, 45, 90}, },					-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90}, },							-- V2 shade						2.1.0
		},
	},
	-- VT2
	we_2h_spear = {
		right = { node = default_node_2, position = {-0.1, -0.15, -0.1}, rotation = {0, -290, 90},										-- Default / V1
			we_waywatcher = {
				attachment = 2, attachment_node = 19, position = {0.1, -0.2, -0.2}, rotation = {-60, 318, 75},							-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 10, position = {0.3, 0.06, -0.2}, rotation = {0, 300, 75}, },		-- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 19, position = {0, 0.02, -0.2}, rotation = {0, 300, 75}, },			-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 18, position = {0.2, 0.05, -0.1}, rotation = {20, -60, 90}, },				-- V2 shade						2.1.0
		},
	},
	ww_2h_sword = {
		right = { node = default_node_2, position = {0.4, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
			we_waywatcher = {
				attachment = 2, attachment_node = 19, position = {-0.2, -0.05, 0}, rotation = {-30, 138, 75},							-- V2 waystalker				2.1.0
				skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.07, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
			},
			we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.2, 0.02, -0.05}, rotation = {0, 120, 75}, },		-- V2 handmaiden				2.1.0
			we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, -0.01, 0.06}, rotation = {20, 120, 90}, },				-- V2 shade						2.1.0
		},
	},
	
	-- Dwarf
	dr_1h_axe_shield = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90}, 												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.3, -0.17, 0.1}, rotation = {0, -110, 90}, 												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.35, -0.15, 0.1}, rotation = {0, -110, 90}, },						-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.3, -0.2, 0.1}, rotation = {0, -110, 90}, },								-- V2 ironbreaker			2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0.12, -0.03, -0.25}, rotation = {0, 15, 180},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.26, -0.5, 0.1}, rotation = {40, 150, 20}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.1}, rotation = {0, 180, 180}, },			-- V2 ironbreaker			2.1.0
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},												-- Default / V1				2.1.0
				dr_ranger = {
					node = hip_node, position = {0.2, 0.1, -0.28}, rotation = {110, -70, -70},													-- V2 ranger				2.1.0
					skin_dr_default = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },							-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, },								-- V2 ironbreaker			2.1.0
			},
		},
		left = {
			back = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},											-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},										-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0.02, -0.07, -0.2}, rotation = {0, -140, 90},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.07, 0.1}, rotation = {0, 0, 90}, },				-- V2 ironbreaker
			},
			belt = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},											-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
		},
	},
	dr_handgun = {
		right = {
			backpack = { node = backpack_node, position = {-0.2, -0.45, 0.25}, rotation = {-30, 90, -10},										-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {-0.35, 0.05, -0.3}, rotation = {90, 0, 0},									-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {-0.2, -0.25, 0.12}, rotation = {-30, 90, -10}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.15, 0, 0.3}, rotation = {-90, 180, 0}, },					-- V2 ironbreaker			2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.2, -0.2}, rotation = {0, 30, 90},												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90},												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },							-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },								-- V2 ironbreaker			2.1.0
			},
		},
	},
	dr_1h_hammer = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },									-- V2 slayer				2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {0.10, -0.03, -0.25}, rotation = {0, 15, 180},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.26, -0.5, 0.1}, rotation = {40, 150, 20}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.25}, rotation = {0, 180, 180}, },			-- V2 ironbreaker			2.1.0
				dr_slayer = { copy = "back", },																									-- V2 slayer				2.1.0
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.28}, rotation = {130, -70, 110},												-- Default / V1
				dr_ranger = {
					node = hip_node, position = {0.13, 0.1, -0.28}, rotation = {130, -70, 110},													-- V2 ranger				2.1.0
					skin_dr_default = { node = hip_node, position = {0.13, 0.1, -0.26}, rotation = {130, -70, 110}, },							-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },								-- V2 ironbreaker			2.1.0
				dr_slayer = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, 110}, },									-- V2 slayer				2.1.0
			},
		},
	},
	dr_2h_hammer = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.15, 0.2}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },							-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, replace = "backpack", },			-- V2 slayer				2.1.0
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0, -0.8, 0.4}, rotation = {40, 150, 20}, },			-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -60}, },			-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, replace = "back", },				-- V2 slayer				2.1.0
			},
		},
	},
	dr_1h_axes = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90},												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.35, -0.15, 0.1}, rotation = {0, -110, 90}, },						-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.21, 0.1}, rotation = {0, -110, 90}, },							-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, },									-- V2 slayer				2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {0.10, -0.03, -0.25}, rotation = {0, 15, 180},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.26, -0.5, 0.1}, rotation = {40, 150, 20}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.3}, rotation = {0, 180, 180}, },			-- V2 ironbreaker			2.1.0
				dr_slayer = { copy = "back", },																									-- V2 slayer				2.1.0
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},												-- Default / V1				2.1.0
				dr_ranger = {
					node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, -40},													-- V2 ranger				2.1.0
					skin_dr_default = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, -40}, },							-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, -40}, },								-- V2 ironbreaker			2.1.0
				dr_slayer = { node = hip_node, position = {0.13, 0.1, -0.25}, rotation = {130, -70, -40}, },									-- V2 slayer				2.1.0
			},
		},
	},
	dr_1h_hammer_shield = {
		right = {
			back = { node = default_node_2, position = {0.4, -0.2, 0.1}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.5, 0.1}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {0.12, -0.03, -0.25}, rotation = {0, 15, 180},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.26, -0.5, 0.1}, rotation = {40, 150, 20}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.25}, rotation = {0, 180, 90}, },			-- V2 ironbreaker			2.1.0
			},
			belt = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},												-- Default / V1				2.1.0
				dr_ranger = {
					node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110},													-- V2 ranger				2.1.0
					skin_dr_default = { node = hip_node, position = {0.13, 0.1, -0.26}, rotation = {130, -70, 110}, },							-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = hip_node, position = {0.13, 0.1, -0.27}, rotation = {130, -70, 110}, },								-- V2 ironbreaker			2.1.0
			},
		},
		left = {
			back = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},											-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
			backpack = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},										-- Default / V1				2.1.0
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {0.02, -0.07, -0.2}, rotation = {0, -140, 90},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.07, 0.1}, rotation = {0, 0, 90}, },				-- V2 ironbreaker			2.1.0
			},
			belt = { node = backpack_node, position = {0.3, -0.3, 0.12}, rotation = {60, -40, -100},											-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
		},
	},
	dr_2h_axes = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90},												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.5, -0.15, 0.2}, rotation = {0, -110, 90}, },						-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },							-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90}, replace = "backpack", }				-- V2 slayer				2.1.0
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0, -0.8, 0.4}, rotation = {40, 150, 20}, },			-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -90}, },			-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, replace = "back", },				-- V2 slayer				2.1.0
			},
		},
	},
	dr_2h_picks = {
		right = {
			back = { node = default_node_2, position = {0.5, -0.17, 0.2}, rotation = {0, -110, 90},												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.5, -0.17, 0.2}, rotation = {0, -110, 90},												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.5, -0.15, 0.2}, rotation = {0, -110, 90}, },						-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.5, -0.22, 0.2}, rotation = {0, -110, 90}, },							-- V2 ironbreaker			2.1.0
				dr_slayer = { node = default_node_2, position = {0.5, -0.2, 0.2}, rotation = {0, -110, 90}, replace = "backpack", },			-- V2 slayer				2.1.0
			},
			backpack = { node = backpack_node, position = {0.1, -0.8, 0.5}, rotation = {40, 160, 20},											-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0.3, -0.12, -0.6}, rotation = {0, -40, 90},								-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0, -0.8, 0.4}, rotation = {40, 150, -10}, },			-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {-0.15, -0.03, 0.7}, rotation = {0, 180, -60}, },			-- V2 ironbreaker			2.1.0
				dr_slayer = { replace = "back", node = default_node_2, position = {0.5, -0.2, -0.3}, rotation = {0, -60, -90}, },				-- V2 slayer				2.1.0
			},
		},
	},
	dr_grudgeraker = {
		right = {
			backpack = { node = backpack_node, position = {-0.2, -0.3, 0.1}, rotation = {-30, 90, -10},											-- Default / V1				2.1.0
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {-0.35, 0.05, -0.3}, rotation = {90, 0, 0},									-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {-0.19, -0.35, 0.1}, rotation = {-30, 50, -10}, },		-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.15, -0.02, 0.3}, rotation = {-90, 180, 0}, },				-- V2 ironbreaker			2.1.0
			},
			back = { node = default_node_2, position = {0.3, -0.2, -0.2}, rotation = {0, 30, 90},												-- Default / V1				2.1.0
				dr_ranger = {
					node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90},												-- V2 ranger				2.1.0
					skin_dr_default = { node = default_node_2, position = {0.2, -0.15, -0.2}, rotation = {0, 30, 90}, },						-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {0, 30, 90}, },								-- V2 ironbreaker			2.1.0
			},
		},
	},
	dr_crossbow = {
		left = {
			backpack = { node = backpack_node, position = {-0.1, -0.3, 0.15}, rotation = {-10, 120, -10},										-- Default / V1				2.1.0
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {-0.4, 0, -0.15}, rotation = {90, 0, 0},									-- V2 ranger				2.1.0
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {-0.14, -0.2, 0.07}, rotation = {-30, 150, -10}, },	-- V2 classic ranger skin	2.1.0
				},
				dr_ironbreaker = { attachment = 1, attachment_node = 6, position = {0.17, -0.05, 0.22}, rotation = {90, 0, 180}, },				-- V2 ironbreaker			2.1.0
			},
			back = { node = default_node_2, position = {0.2, -0.2, -0.1}, rotation = {270, 0, 110},												-- Default / V1				2.1.0
				dr_ranger = { copy = "backpack", },																								-- V2 ranger				2.1.0
				dr_ironbreaker = { copy = "backpack", },																						-- V2 ironbreaker			2.1.0
			},
		},
	},
	dr_drakefire_pistols = {
		right = { node = hip_node, position = {0.1, 0, 0.3}, rotation = {70, 130, -70},						-- Default / V1		2.1.0
			dr_ironbreaker = { node = hip_node, position = {0.1, 0, 0.3}, rotation = {-90, 130, -90}, },	-- V2 ironbreaker	2.1.0
		},
		left = { node = hip_node, position = {0.1, 0, -0.3}, rotation = {90, 130, -90},						-- Default / V1		2.1.0
			dr_ironbreaker = { node = hip_node, position = {0.1, 0, -0.3}, rotation = {-90, 130, -90}, },	-- V2 ironbreaker	2.1.0
		},
	},
	-- VT2
	dr_drakegun = {
		right = {
			back = { copy = "backpack", },																					-- Default / V1		2.1.0
			backpack = { attachment = 1, attachment_node = 6, position = {0.05, -0.02, 0.25}, rotation = {90, 0, 0}, },		-- Default / V1		2.1.0
		},
	},
	dr_dual_axes = {
		right = {
			belt = { node = hip_node, position = {0.2, 0.1, -0.25}, rotation = {110, -70, -70}, replace = "back", },		-- Default / V1		2.1.0
			back = { node = default_node_2, position = {0.2, -0.2, 0.1}, rotation = {0, -110, 90}, replace = "belt", },		-- Default / V1		2.1.0
			backpack = { copy = "back", replace = "belt", },																-- Default / V1		2.1.0
		},
		left = {
			belt = { node = hip_node, position = {0.2, 0.1, 0.25}, rotation = {20, -80, 200}, replace = "back", },			-- Default / V1		2.1.0
			back = { node = default_node_2, position = {0.2, -0.2, -0.2}, rotation = {12, -50, -78}, replace = "belt", },	-- Default / V1		2.1.0
			backpack = { copy = "back", replace = "belt", },																-- Default / V1		2.1.0
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
				node = default_node, position = {-0.1, -0.15, -0.1}, rotation = {120, 110, 90},
				we_waywatcher = { 
					node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0},
					skin_ww_default = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
				},
				we_maidenguard = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
				we_shade = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
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
				node = backpack_node, position = {0.07, 0.04, -0.04}, rotation = {40, -20, -10},
				dr_ranger = {
					attachment = 1, attachment_node = 9, position = {0, -0.1, 0}, rotation = {-20, 180, 0}, 
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.07, 0.04, -0.04}, rotation = {40, -20, -10}, },
				},
				dr_ironbreaker = { node = default_node, position = {-0.05, 0.25, 0.15}, rotation = {-70, 110, -90}, },
				dr_slayer = { node = default_node, position = {-0.05, 0.25, 0.1}, rotation = {-70, 110, -90}, },
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
				node = default_node, position = {-0.1, -0.15, -0.1}, rotation = {120, 110, 90},
				we_waywatcher = { 
					node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0},
					skin_ww_default = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
				},
				we_maidenguard = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
				we_shade = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },
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
				node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 0},
				we_waywatcher = { 
					node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0},
					skin_ww_default = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
				},
				we_maidenguard = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
				we_shade = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
			},
			left = {
				node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 30},
				we_waywatcher = { 
					node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60},
					skin_ww_default = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
				},
				we_maidenguard = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
				we_shade = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
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
				node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 0},
				we_waywatcher = { 
					node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0},
					skin_ww_default = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
				},
				we_maidenguard = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
				we_shade = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },
			},
			left = {
				node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 30},
				we_waywatcher = { 
					node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60},
					skin_ww_default = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
				},
				we_maidenguard = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
				we_shade = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },
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
				node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},
				we_waywatcher = { 
					node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90},
					skin_ww_default = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
				},
				we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
				we_shade = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
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
				node = backpack_node, position = {0.15, -0.2, 0.13}, rotation = {60, -20, -10},
				dr_ranger = { 
					attachment = 1, attachment_node = 9, position = {-0.25, -0.03, -0.25}, rotation = {40, 180, 185},
					skin_dr_default = { attachment = 2, attachment_node = 13, position = {0.15, -0.2, 0.13}, rotation = {60, -20, -10}, },
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
				node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},
				we_waywatcher = { 
					node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90},
					skin_ww_default = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
				},
				we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
				we_shade = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },
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