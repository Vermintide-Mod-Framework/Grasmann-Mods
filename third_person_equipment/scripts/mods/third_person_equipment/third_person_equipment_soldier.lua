local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment definitions
		- Provides equipment positions for soldier classes
	
	Author: grasmann
--]]

local default_node = "j_spine"
local hip_node = "j_hips"

-- ##### Potion #######################################################################################################
mod.definitions.potion.empire_soldier = {
    left = { node = default_node, position = {-0.05, -0.12, -0.15}, rotation = {-60, 70, -90},                              -- Default / V1
        es_mercenary = {
            node = default_node, position = {0.1, -0.06, -0.2}, rotation = {-30, 100, -90},								-- V2 mercenary
            skin_es_default = { node = default_node, position = {0.1, -0.06, -0.2}, rotation = {-30, 100, -90}, },		    -- V2 classic mercenary skin    2.1.0
        },
        es_knight = { node = default_node, position = {-0.05, -0.12, -0.15}, rotation = {-60, 70, -90}, },	                -- V2 knight
        es_huntsman = { node = default_node, position = {-0.05, -0.12, -0.15}, rotation = {-60, 70, -90}, },				-- V2 huntsman
    },
}

-- ##### Grenade ######################################################################################################
mod.definitions.grenade.empire_soldier = {
    right = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0},                                       -- Default / V1
        es_mercenary = {
            node = default_node, position = {0.05, -0.1, 0.2}, rotation = {40, 90, 0},								            -- V2 mercenary
            skin_es_default = { node = default_node, position = {0.05, -0.1, 0.2}, rotation = {40, 90, 0}, },		        -- V2 classic mercenary skin    2.1.0
        },
        es_knight = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0}, },	                        -- V2 knight
        es_huntsman = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0}, },				            -- V2 huntsman
    },
    left = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0},                                        -- Default / V1
        es_mercenary = {
            node = default_node, position = {0.05, -0.1, 0.2}, rotation = {40, 90, 0},								            -- V2 mercenary
            skin_es_default = { node = default_node, position = {0.05, -0.1, 0.2}, rotation = {40, 90, 0}, },		        -- V2 classic mercenary skin    2.1.0
        },
        es_knight = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0}, },	                        -- V2 knight
        es_huntsman = { node = default_node, position = {0, -0.1, 0.2}, rotation = {40, 90, 0}, },				            -- V2 huntsman
    },
}

-- ##### Healthkit ####################################################################################################
mod.definitions.healthkit_first_aid_kit_01.empire_soldier = {
    left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},                                       -- Default / V1
        es_mercenary = {
            node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90},                                    -- V2 mercenary
            skin_es_default = { node = hip_node, position = {0.1, -0.12, -0.03}, rotation = {260, 60, -90}, },		        -- V2 classic mercenary skin    2.1.0
        },
        es_huntsman = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                     -- V2 huntsman
        es_knight = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                       -- V2 knight
        empire_soldier_tutorial = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },         -- V2 tutorial
    },
}

-- ##### Healing Draught ##############################################################################################
mod.definitions.potion_healing_draught_01.empire_soldier = {
    left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},                                       -- Default / V1
        es_mercenary = {
            node = default_node, position = {0.1, -0.13, -0.16}, rotation = {-30, 100, -90},                                    -- V2 mercenary
            skin_es_default = { node = default_node, position = {0.1, -0.13, -0.16}, rotation = {-30, 100, -90}, },		    -- V2 classic mercenary skin    2.1.0
        },
        es_huntsman = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                     -- V2 huntsman
        es_knight = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                       -- V2 knight
        empire_soldier_tutorial = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },         -- V2 tutorial
    },
}

-- ##### Tome #########################################################################################################
mod.definitions.wpn_side_objective_tome_01.empire_soldier = {
    left = { node = default_node, position = {0, -0.15, 0.03}, rotation = {0, 90, 0},                                       -- Default / V1
        es_mercenary = {
            node = hip_node, position = {0.1, -0.16, 0}, rotation = {270, 75, -90},                                    -- V2 mercenary
            skin_es_default = { node = hip_node, position = {0.1, -0.16, 0}, rotation = {270, 75, -90}, },		            -- V2 classic mercenary skin    2.1.0
        },
        es_huntsman = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                     -- V2 huntsman
        es_knight = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },                       -- V2 knight
        empire_soldier_tutorial = { node = default_node, position = {0, -0.15, 0.03}, rotation = {10, 100, 150}, },         -- V2 tutorial
    },
}

-- ##### Handgun ######################################################################################################
mod.definitions.es_handgun = {
    right = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.5, -0.23, -0.17}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
    },
}

-- ##### Executioner Sword ############################################################################################
mod.definitions.es_2h_sword_exec = {
    right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},									-- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},									-- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },				-- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },		-- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },						-- V2 huntsman					2.1.0
    },
}

-- ##### Hammer and Sword #############################################################################################
mod.definitions.es_dual_wield_hammer_sword = {
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
            es_knight = { attachment = 1, attachment_node = 10, position = {-0.1, 0.02, 0.1}, rotation = {0, 120, -90}, },	-- V2 knight					2.1.0
            es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					-- V2 huntsman					2.1.0
        },
    },
    left = {
        belt = { node = hip_node, position = {0.2, 0.1, 0.21}, rotation = {50, -70, 220},									-- Default / V1					2.1.0
            es_mercenary = {
                node = hip_node, position = {0.2, 0.1, 0.18}, rotation = {50, -70, 220},									-- V2 mercenary					2.1.0
                skin_es_default = { node = hip_node, position = {0.2, 0.1, 0.18}, rotation = {50, -70, 220}, },			-- V2 classic mercenary skin	2.1.0
            },
            es_knight = { node = hip_node, position = {0.2, 0.1, 0.18}, rotation = {50, -60, 220}, },						-- V2 knight
            es_huntsman = { node = hip_node, position = {0.2, 0.1, 0.18}, rotation = {50, -60, 220}, },					-- V2 huntsman					2.1.0
        },
        back = { node = default_node, position = {0.4, -0.22, -0.1}, rotation = {0, -50, 90},								-- Default / V1					2.1.0
            es_mercenary = {
                node = default_node, position = {0.4, -0.22, -0.2}, rotation = {0, -50, 90},								-- V2 mercenary					2.1.0
                skin_es_default = { node = default_node, position = {0.4, -0.22, -0.2}, rotation = {0, -50, 90}, },			-- V2 classic mercenary skin	2.1.0
            },
            es_knight = { attachment = 1, attachment_node = 10, position = {-0.15, 0.02, -0.25}, rotation = {0, 50, -90}, },	-- V2 knight					2.1.0
            es_huntsman = { node = default_node, position = {0.4, -0.22, -0.2}, rotation = {0, -50, 90}, },					-- V2 huntsman					2.1.0
        },
    },
}

-- ##### 1H Sword #####################################################################################################
mod.definitions.es_1h_sword = {
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
}

-- ##### 2H Hammer ####################################################################################################
mod.definitions.es_2h_war_hammer = {
    right = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90},								    -- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90},								    -- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90}, },			    -- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	    -- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.8, -0.22, 0.2}, rotation = {0, -110, 90}, },					    -- V2 huntsman					2.1.0
    },
}

-- ##### Sword and Shield #############################################################################################
mod.definitions.es_1h_sword_shield = {
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
}

-- ##### 2H Sword #####################################################################################################
mod.definitions.es_2h_sword = {	
    right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								    -- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								    -- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },			    -- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	    -- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },					    -- V2 huntsman					2.1.0
    },
}

-- ##### 1H Mace ######################################################################################################
mod.definitions.es_1h_mace = {
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
}

-- ##### Mace and Shield ##############################################################################################
mod.definitions.es_1h_mace_shield = {
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
}

-- ##### Repeating Handgun ############################################################################################
mod.definitions.es_repeating_handgun = {
    right = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.5, -0.22, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
    },
}

-- ##### Blunderbuss ##################################################################################################
mod.definitions.es_blunderbuss = {
    right = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},									-- Default / V1					2.1.0
        es_mercenary = {
            node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90},										-- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },				-- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.01, 0.05, -0.15}, rotation = {0, -35, -90}, },	-- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.5, -0.23, -0.2}, rotation = {0, 30, 90}, },						-- V2 huntsman					2.1.0
    },
}

-- ##### V2 ###########################################################################################################
-- ##### Halberd ######################################################################################################
mod.definitions.es_2h_halberd = {
    right = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								    -- Default / V1					2.1.0
        es_mercenary = {	
            node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90},								    -- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },			    -- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.1, 0.04, 0}, rotation = {0, 130, -90}, },	    -- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.5, -0.22, 0.1}, rotation = {0, -110, 90}, },					    -- V2 huntsman					2.1.0
    },
}

-- ##### Executioner Sword ############################################################################################
mod.definitions.es_2h_sword_executioner = {
    right = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								    -- Default / V1					2.1.0
        es_mercenary = {	
            node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90},								    -- V2 mercenary					2.1.0
            skin_es_default = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },			    -- V2 classic mercenary skin	2.1.0
        },
        es_knight = { attachment = 1, attachment_node = 10, position = {-0.4, 0.04, 0.3}, rotation = {0, 130, -90}, },	    -- V2 knight					2.1.0
        es_huntsman = { node = default_node, position = {0.7, -0.22, 0.2}, rotation = {0, -110, 90}, },					    -- V2 huntsman					2.1.0
    },
}
