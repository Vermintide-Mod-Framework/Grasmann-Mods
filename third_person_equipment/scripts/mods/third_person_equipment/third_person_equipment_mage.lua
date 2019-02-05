local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment definitions
		- Provides equipment positions for soldier classes
	
	Author: grasmann
--]]

local default_node = "j_spine"
local default_node_2 = "j_spine2"
local hip_node = "j_hips"

-- ##### Potion #######################################################################################################
mod.definitions.potion.bright_wizard = {
    left = { node = default_node, position = {-0.05, -0.1, -0.13}, rotation = {-60, 60, -90},                                   -- Default / V1
        bw_adept = {
            node = default_node, position = {-0.08, 0.17, 0.05}, rotation = {-70, 110, -90},                                    -- V2 battle wizard
            skin_bw_default = { node = default_node, position = {-0.08, 0.17, 0.05}, rotation = {-70, 110, -90}, },				-- V2 classic battle wizard skin
        },
        bw_scholar = { node = default_node, position = {-0.09, 0.15, 0.05}, rotation = {-70, 110, -90}, },                      -- V2 pyromancer
        bw_unchained = { node = default_node, position = {-0.09, 0.15, 0.05}, rotation = {-70, 110, -90}, },                    -- V2 unchained
    },
}

-- ##### Grenade ######################################################################################################
mod.definitions.grenade.bright_wizard = {
    right = { node = default_node, position = {0, -0.13, 0.08}, rotation = {60, 120, 0},                                        -- Default / V1
        bw_adept = {
            node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 0},                                        -- V2 battle wizard
            skin_bw_default = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 0}, },				    -- V2 classic battle wizard skin
        },
        bw_scholar = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 0}, },                          -- V2 pyromancer
        bw_unchained = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 0}, },                        -- V2 unchained
    },
    left = { node = default_node, position = {0, -0.13, 0.08}, rotation = {60, 120, 30},                                        -- Default / V1
        bw_adept = {
            node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 30},                                       -- V2 battle wizard
            skin_bw_default = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 30}, },				-- V2 classic battle wizard skin
        },
        bw_scholar = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 30}, },                         -- V2 pyromancer
        bw_unchained = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 30}, },                       -- V2 unchained
    },
}

-- ##### Healthkit ####################################################################################################
mod.definitions.healthkit.bright_wizard = {
    left = { node = default_node, position = {0, 0.15, 0.05}, rotation = {0, 90, 20},                                           -- Default / V1
        bw_adept = {
            node = default_node, position = {-0.05, -0.16, -0.05}, rotation = {0, 90, 170},                                     -- V2 battle wizard
            skin_bw_default = { node = default_node, position = {-0.1, -0.18, 0.1}, rotation = {60, 120, 0}, },				    -- V2 classic battle wizard skin
        },
        bw_scholar = { node = default_node, position = {-0.05, -0.16, -0.05}, rotation = {0, 90, 170}, },                       -- V2 pyromancer
        bw_unchained = { node = default_node, position = {-0.05, -0.16, -0.05}, rotation = {0, 90, 170}, },                     -- V2 unchained
    },
}

-- ##### Flame Sword ##################################################################################################
mod.definitions.bw_flame_sword = {
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
}

-- ##### 1H Sword #####################################################################################################
mod.definitions.bw_1h_sword = {
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
}

-- ##### Crowbill #####################################################################################################
mod.definitions.bw_1h_crowbill = {
    right = {
        belt = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110},									-- Default / V1						2.2.0
            bw_adept = { 
                node = hip_node, position = {0.2, 0.05, -0.17}, rotation = {90, -60, 110}, 										-- V2 battle wizard					2.2.0
                skin_bw_default = { node = hip_node, position = {0.2, 0.05, -0.14}, rotation = {130, -70, 110}, },				-- V2 classic battle wizard skin	2.2.0
            },
            bw_unchained = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 unchained						2.2.0
            bw_scholar = { attachment = 1, attachment_node = 4, position = {-0.1, 0.05, -0.05}, rotation = {20, 60, -90}, },	-- V2 pyromancer					2.2.0
        },
        back = { node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {0, -110, 90},								-- Default / V1						2.2.0
            bw_adept = { 
                node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60}, 								-- V2 battle wizard					2.2.0
                skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-60, -110, 30}, },			-- V2 classic battle wizard skin	2.2.0
            },
            bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },				-- V2 unchained						2.2.0
            bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },		-- V2 pyromancer					2.2.0
        },
    },
}

-- ##### Morning Star #################################################################################################
mod.definitions.bw_morningstar = {
    right = {
        belt = { node = hip_node, position = {0.3, 0, -0.1}, rotation = {130, -70, 110},									    -- Default / V1						2.1.0
            bw_adept = { 	
                node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60},							    -- V2 battle wizard					2.1.0
                skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-40, -110, 30}, },		    -- V2 classic battle wizard skin	2.1.0
            },
            bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },			    -- V2 unchained						2.1.0
            bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },	    -- V2 pyromancer					2.1.0
        },
        back = { node = default_node_2, position = {0.3, -0.15, 0.1}, rotation = {0, -110, 90},								    -- Default / V1						2.1.0
            bw_adept = { 
                node = default_node_2, position = {0.25, -0.14, 0.1}, rotation = {-30, -110, 60}, 							    -- V2 battle wizard					2.1.0
                skin_bw_default = { node = default_node_2, position = {0.25, -0.1, 0.1}, rotation = {-40, -110, 30}, },		    -- V2 classic battle wizard skin	2.1.0
            },
            bw_unchained = { node = default_node_2, position = {0.25, -0.09, 0.12}, rotation = {-60, -110, 30}, },			    -- V2 unchained						2.1.0
            bw_scholar = { attachment = 2, attachment_node = 39, position = {-0.1, 0, 0.1}, rotation = {20, 130, -90}, },	    -- V2 pyromancer					2.1.0
        },
    },
}

-- ##### Beam Staff ###################################################################################################
mod.definitions.bw_staff_beam = {
    right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									    -- Default / V1						2.1.0
        bw_adept = { 	
            node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										    -- V2 battle wizard					2.1.0
            skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				    -- V2 classic battle wizard skin	2.1.0
        },
        bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						    -- V2 unchained						2.1.0
        bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	    -- V2 pyromancer					2.1.0
    },
}

-- ##### Fireball Staff ###############################################################################################
mod.definitions.bw_staff_firball = {
    right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									    -- Default / V1						2.1.0
        bw_adept = { 	
            node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										    -- V2 battle wizard					2.1.0
            skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				    -- V2 classic battle wizard skin	2.1.0
        },
        bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						    -- V2 unchained						2.1.0
        bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	    -- V2 pyromancer					2.1.0
    },
}

-- ##### Geiser Staff #################################################################################################
mod.definitions.bw_staff_geiser = {
    right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									    -- Default / V1						2.1.0
        bw_adept = { 	
            node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										    -- V2 battle wizard					2.1.0
            skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				    -- V2 classic battle wizard skin	2.1.0
        },
        bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						    -- V2 unchained						2.1.0
        bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	    -- V2 pyromancer					2.1.0
    },
}

-- ##### Bolt Staff ###################################################################################################
mod.definitions.bw_staff_spear = {
    right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									    -- Default / V1						2.1.0
        bw_adept = { 	
            node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										    -- V2 battle wizard					2.1.0
            skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },				    -- V2 classic battle wizard skin	2.1.0
        },
        bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						    -- V2 unchained						2.1.0
        bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	    -- V2 pyromancer					2.1.0
    },
}

-- ##### Dagger #######################################################################################################
mod.definitions.bw_dagger = {
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
}

-- ##### V2 ###########################################################################################################
-- ##### Dagger #######################################################################################################
mod.definitions.bw_1h_dagger = {
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
}

-- ##### Flame Staff ##################################################################################################
mod.definitions.bw_staff_flamethrower = {
    right = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180},									    -- Default / V1						2.1.0
        bw_adept = { 	
            node = default_node_2, position = {0, -0.17, 0}, rotation = {0, 110, 180}, 										    -- V2 battle wizard					2.1.0
            skin_bw_default = { node = default_node_2, position = {0, -0.15, 0}, rotation = {0, 110, 180}, },			    	-- V2 classic battle wizard skin	2.1.0
        },
        bw_unchained = { node = default_node_2, position = {0, -0.17, 0}, rotation = {30, 110, 180}, },						    -- V2 unchained						2.1.0
        bw_scholar = { attachment = 2, attachment_node = 21, position = {0, 0.02, -0.03}, rotation = {-20, -110, -90}, },	    -- V2 pyromancer					2.1.0
    },
}