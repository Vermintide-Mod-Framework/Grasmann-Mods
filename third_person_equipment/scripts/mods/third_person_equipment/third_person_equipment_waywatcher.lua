local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment definitions
		- Provides equipment positions for soldier classes
	
	Author: grasmann
--]]

local default_node = "j_spine"
local default_node_2 = "j_spine2"
local hip_node = "j_hips"
local right_leg_node = "j_rightupleg"

-- ##### Potion #######################################################################################################
mod.definitions.potion.wood_elf = {
    left = { node = default_node, position = {-0.1, -0.15, -0.1}, rotation = {120, 110, 90},                                            -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0},                                            -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.1, -0.06, 0.22}, rotation = {-30, -130, -90}, },   -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },                          -- V2 handmaiden                2.1.1
        we_shade = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },                                -- V2 shade                     2.1.1
    },
}
mod.definitions.potion.way_watcher = {
    left = { node = default_node, position = {-0.1, -0.15, -0.1}, rotation = {120, 110, 90},                                            -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0},                                            -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.1, -0.06, 0.22}, rotation = {-30, -130, -90}, },   -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = right_leg_node, position = {-0.1, -0.05, 0.12}, rotation = {-55, 110, 0}, },                          -- V2 handmaiden                2.1.1
        we_shade = { node = right_leg_node, position = {-0.07, -0.05, 0.12}, rotation = {-55, 110, 0}, },                               -- V2 shade                     2.1.1
    },
}

-- ##### Grenade ######################################################################################################
mod.definitions.grenade.wood_elf = {
    right = { node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 0},                                                 -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.1, -0.16}, rotation = {-45, 70, 0},                                                       -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, 0.012, -0.08}, rotation = {-120, -130, -90}, },    -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },                                     -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.1, -0.15}, rotation = {-45, 70, 0}, },                                            -- V2 shade                     2.1.1
    },
    left = { node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 30},                                                 -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60},                                                    -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, -0.05, -0.1}, rotation = {-160, -110, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },                                  -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.08, -0.02, -0.18}, rotation = {-50, 70, -60}, },                                        -- V2 shade                     2.1.1
    },
}
mod.definitions.grenade.way_watcher = {
    right = { node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 0},                                                 -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.1, -0.16}, rotation = {-45, 70, 0},                                                       -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, 0.012, -0.08}, rotation = {-120, -130, -90}, },    -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.05, -0.1, -0.15}, rotation = {-45, 70, 0}, },                                     -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.1, -0.15}, rotation = {-45, 70, 0}, },                                            -- V2 shade                     2.1.1
    },
    left = { node = default_node, position = {-0.1, -0.18, 0.08}, rotation = {60, 120, 30},                                                 -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60},                                                    -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, -0.05, -0.1}, rotation = {-160, -110, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.05, -0.02, -0.18}, rotation = {-50, 70, -60}, },                                  -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.08, -0.02, -0.18}, rotation = {-50, 70, -60}, },                                        -- V2 shade                     2.1.1
    },
}

-- ##### Healthkit ####################################################################################################
mod.definitions.healthkit_first_aid_kit_01.wood_elf = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                       -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90},                                                     -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.075, 0.01, 0.075}, rotation = {-50, -130, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                      -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90}, },                                         -- V2 shade                     2.1.1
    },
}
mod.definitions.healthkit_first_aid_kit_01.way_watcher = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                       -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90},                                                     -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.075, 0.01, 0.075}, rotation = {-50, -130, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                      -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90}, },                                         -- V2 shade                     2.1.1
    },
}

-- ##### Healing Draught ##############################################################################################
mod.definitions.potion_healing_draught_01.wood_elf = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                       -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.12, -0.08}, rotation = {270, 75, -90},                                                    -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, 0.012, 0.025}, rotation = {-80, -130, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                      -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.05, -0.12, -0.08}, rotation = {270, 75, -90}, },                                        -- V2 shade                     2.1.1
    },
}
mod.definitions.potion_healing_draught_01.way_watcher = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                       -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.05, -0.12, -0.08}, rotation = {270, 75, -90},                                                    -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.08, 0.012, 0.025}, rotation = {-80, -130, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                      -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.05, -0.12, -0.08}, rotation = {270, 75, -90}, },                                        -- V2 shade                     2.1.1
    },
}

-- ##### Tome #########################################################################################################
mod.definitions.wpn_side_objective_tome_01.wood_elf = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                   -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.1, -0.12, 0}, rotation = {270, 75, -90},                                                     -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.1, 0.01, 0.1}, rotation = {-70, -100, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                  -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.12, 0}, rotation = {270, 75, -90}, },                                         -- V2 shade                     2.1.1
    },
}
mod.definitions.wpn_side_objective_tome_01.way_watcher = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                                   -- Default / V1                 2.1.1
        we_waywatcher = { 
            node = hip_node, position = {0.1, -0.12, 0}, rotation = {270, 75, -90},                                                     -- V2 waystalker                2.1.1
            skin_ww_default = { attachment = 3, attachment_node = 16, position = {-0.1, 0.01, 0.1}, rotation = {-70, -100, -90}, },     -- V2 classic waywatcher skin   2.1.1
        },
        we_maidenguard = { node = hip_node, position = {0.08, -0.12, 0}, rotation = {260, 75, -90}, },                                  -- V2 handmaiden                2.1.1
        we_shade = { node = hip_node, position = {0.1, -0.12, 0}, rotation = {270, 75, -90}, },                                         -- V2 shade                     2.1.1
    },
}

-- ##### 2H Axe #######################################################################################################
mod.definitions.ww_2h_axe = {
    right = { node = default_node_2, position = {0.4, -0.1, 0.1}, rotation = {0, -110, 90}, 									        -- Default / V1					2.1.0
        we_waywatcher = {
            attachment = 2, attachment_node = 19, position = {-0.2, -0.05, 0}, rotation = {-30, 138, 75}, 						        -- V2 waystalker				2.1.0
            skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.07, 0.1}, rotation = {0, 120, 75}, },         -- V2 classic waywatcher skin	2.1.0
        },
        we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.2, 0.02, -0.05}, rotation = {0, 120, 75}, },	        -- V2 handmaiden				2.1.0
        we_shade = { attachment = 2, attachment_node = 18, position = {-0.2, -0.02, 0.06}, rotation = {25, 120, 75}, },			        -- V2 shade						2.1.0
    },
}

-- ##### Trueflight Bow ###############################################################################################
mod.definitions.ww_trueflight = {
    left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90}, },                                            -- Default / V1
}

-- ##### 1H Sword #####################################################################################################
mod.definitions.ww_1h_sword = {
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
}

-- ##### Dual Swords ##################################################################################################
mod.definitions.ww_dual_swords = {
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
}

-- ##### Sword and Dagger #############################################################################################
mod.definitions.ww_sword_and_dagger = {
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
}

-- ##### Dual Daggers #################################################################################################
mod.definitions.ww_dual_daggers = {
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
}

-- ##### Longbow ######################################################################################################
mod.definitions.ww_longbow = {
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
}

-- ##### Shortbow #####################################################################################################
mod.definitions.ww_shortbow = {
    left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90},												-- Default / V1
        we_waywatcher = { 
            attachment = 2, attachment_node = 5, position = {-0.2, -0.02, -0.1}, rotation = {45, 90, 0},								-- V2 waystalker				2.1.0
            skin_ww_default = { attachment = 2, attachment_node = 11, position = {-0.15, 0.07, -0.05}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
        },
        we_maidenguard = { attachment = 2, attachment_node = 4, position = {0, 0.01, 0.15}, rotation = {0, 45, 90}, },					-- V2 handmaiden				2.1.0
        we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90}, },							-- V2 shade						2.1.0
    },
}

-- ##### Hagbane ######################################################################################################
mod.definitions.ww_hagbane = {
    left = { node = default_node_2, position = {0.1, -0.15, 0}, rotation = {0, -45, -90},												-- Default / V1
        we_waywatcher = { 
            attachment = 2, attachment_node = 5, position = {-0.2, -0.02, -0.1}, rotation = {45, 90, 0},								-- V2 waystalker				2.1.0
            skin_ww_default = { attachment = 2, attachment_node = 11, position = {-0.15, 0.07, -0.05}, rotation = {-30, 60, 100}, },	-- V2 classic waywatcher skin	2.1.0
        },
        we_maidenguard = { attachment = 2, attachment_node = 4, position = {0, 0.01, 0.15}, rotation = {0, 45, 90}, },					-- V2 handmaiden				2.1.0
        we_shade = { attachment = 2, attachment_node = 5, position = {0, 0.03, 0.1}, rotation = {0, 45, 90}, },							-- V2 shade						2.1.0
    },
}

-- ##### V2 ###########################################################################################################
-- ##### Spear ########################################################################################################
mod.definitions.we_2h_spear = {
    right = { node = default_node_2, position = {-0.1, -0.15, -0.1}, rotation = {0, -290, 90},										-- Default / V1
        we_waywatcher = {
            attachment = 2, attachment_node = 19, position = {0.1, -0.2, -0.2}, rotation = {-60, 318, 75},							-- V2 waystalker				2.1.0
            skin_ww_default = { attachment = 2, attachment_node = 10, position = {0.3, 0.06, -0.2}, rotation = {0, 300, 75}, },		-- V2 classic waywatcher skin	2.1.0
        },
        we_maidenguard = { attachment = 2, attachment_node = 19, position = {0, 0.02, -0.2}, rotation = {0, 300, 75}, },			-- V2 handmaiden				2.1.0
        we_shade = { attachment = 2, attachment_node = 18, position = {0.2, 0.05, -0.1}, rotation = {20, -60, 90}, },				-- V2 shade						2.1.0
    },
}

-- ##### 2H Sword #####################################################################################################
mod.definitions.ww_2h_sword = {
    right = { node = default_node_2, position = {0.4, -0.1, 0.1}, rotation = {0, -110, 90},											-- Default / V1
        we_waywatcher = {
            attachment = 2, attachment_node = 19, position = {-0.2, -0.05, 0}, rotation = {-30, 138, 75},							-- V2 waystalker				2.1.0
            skin_ww_default = { attachment = 2, attachment_node = 10, position = {-0.1, 0.07, 0.1}, rotation = {0, 120, 75}, },		-- V2 classic waywatcher skin	2.1.0
        },
        we_maidenguard = { attachment = 2, attachment_node = 19, position = {-0.2, 0.02, -0.05}, rotation = {0, 120, 75}, },		-- V2 handmaiden				2.1.0
        we_shade = { attachment = 2, attachment_node = 18, position = {-0.1, -0.01, 0.06}, rotation = {20, 120, 90}, },				-- V2 shade						2.1.0
    },
}