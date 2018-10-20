local mod = get_mod("helmet_view")
--[[
	Author: grasmann

	Definitions
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.overlays = {

    -- Empire Soldier
    es_hat_0000 = "mercenary_0002",
	es_hat_0001 = "mercenary_0002",
	es_hat_0002 = "mercenary_0002",
	es_hat_0003 = "mercenary_0004",
    es_helmet_0003 = "knight_0002",

    -- Mercenary
	mercenary_hat_0000 = "mercenary_0004",
	mercenary_hat_0001 = "mercenary_0001",
	mercenary_hat_0002 = "mercenary_0002",
	mercenary_hat_0003 = "mercenary_0002",
	mercenary_hat_0004 = "mercenary_0003",
	mercenary_hat_0005 = "mercenary_0002",
	mercenary_hat_0006 = "mercenary_0002",
	mercenary_hat_0007 = "mercenary_0002",
    mercenary_hat_0008 = "mercenary_0002",
    
	-- Huntsman
	huntsman_hat_0001 = "mercenary_0002",
	huntsman_hat_0000 = "huntsman_0004",
	huntsman_hat_0002 = "huntsman_0001",
	huntsman_hat_0003 = "huntsman_0001",
	huntsman_hat_0004 = "mercenary_0002",
	huntsman_hat_0005 = "mercenary_0002",
	huntsman_hat_0006 = "huntsman_0002",
	huntsman_hat_0007 = "huntsman_0003",
	huntsman_hat_0008 = "huntsman_0001",
    huntsman_hat_0009 = "huntsman_0005",
    
    -- Foot Knight
	knight_hat_0000 = "mercenary_0002",
	knight_hat_0001 = "mercenary_0002",
	knight_hat_0002 = "mercenary_0002",
	knight_hat_0003 = "knight_0001",
	knight_hat_0004 = "knight_0004",
	knight_hat_0005 = "mercenary_0002",
	knight_hat_0006 = "knight_0002",
	knight_hat_0007 = "knight_0002",
	knight_hat_0008 = "knight_0006",
	knight_hat_0009 = "knight_0002",
    knight_hat_0010 = "knight_0001",
    
    -- Wood Elf
    ww_hood_0000 = "huntsman_0005",
	ww_hood_0001 = "huntsman_0005",
	ww_hood_0002 = "none",
    ww_hood_0004 = "waywatcher_0003",

    -- Waywatcher
	waywatcher_hat_0000 = "waywatcher_0001",
	waywatcher_hat_0001 = "waywatcher_0001",
	waywatcher_hat_0002 = "waywatcher_0001",
	waywatcher_hat_0003 = "waywatcher_0001",
	waywatcher_hat_0004 = "waywatcher_0001",
	waywatcher_hat_0005 = "waywatcher_0001",
	waywatcher_hat_0006 = "waywatcher_0002",
	waywatcher_hat_0007 = "waywatcher_0003",
	waywatcher_hat_0008 = "waywatcher_0003",
	waywatcher_hat_0009 = "waywatcher_0003",
	waywatcher_hat_0010 = "waywatcher_0003",
    waywatcher_hat_0011 = "waywatcher_0003",
    
	-- Maidenguard
	maidenguard_hat_0000 = "waywatcher_0001",
	maidenguard_hat_0001 = "maidenguard_0001",
	maidenguard_hat_0002 = "maidenguard_0001",
	maidenguard_hat_0003 = "maidenguard_0001",
	maidenguard_hat_0004 = "maidenguard_0001",
	maidenguard_hat_0005 = "maidenguard_0001",
	maidenguard_hat_0006 = "maidenguard_0001",
	maidenguard_hat_0007 = "maidenguard_0002",
	maidenguard_hat_0008 = "maidenguard_0002",
	maidenguard_hat_0009 = "maidenguard_0002",
    maidenguard_hat_0010 = "maidenguard_0001",
    
    -- Shade
	shade_hat_0000 = "knight_0004",
	shade_hat_0001 = "maidenguard_0001",
	shade_hat_0002 = "maidenguard_0002",
	shade_hat_0003 = "maidenguard_0002",
	shade_hat_0004 = "maidenguard_0002",
	shade_hat_0005 = "maidenguard_0002",
	shade_hat_0006 = "knight_0004",
	shade_hat_0007 = "knight_0004",
	shade_hat_0008 = "knight_0004",
	shade_hat_0009 = "knight_0004",
    shade_hat_0010 = "huntsman_0003",
    
    -- Witchhunter
    wh_hat_0000 = "mercenary_0002",
	wh_hat_0001 = "mercenary_0002",
	wh_hat_0003 = "mercenary_0002",
	wh_hat_0007 = "huntsman_0004",
	wh_hat_0008 = "mercenary_0002",
    wh_hat_0009 = "mercenary_0002",

    -- Witchhunter Captain
	witchhunter_hat_0000 = "mercenary_0002",
	witchhunter_hat_0001 = "mercenary_0004",
	witchhunter_hat_0002 = "mercenary_0002",
	witchhunter_hat_0003 = "mercenary_0002",
	witchhunter_hat_0004 = "mercenary_0004",
	witchhunter_hat_0005 = "huntsman_0002",
	witchhunter_hat_0006 = "mercenary_0002",
	witchhunter_hat_0007 = "waywatcher_0001",
	witchhunter_hat_0008 = "huntsman_0002",
	witchhunter_hat_0009 = "mercenary_0002",
    witchhunter_hat_0010 = "waywatcher_0001",
    
	-- Bountyhunter
	bountyhunter_hat_0000 = "knight_0002",
	bountyhunter_hat_0001 = "mercenary_0002",
	bountyhunter_hat_0002 = "waywatcher_0001",
	bountyhunter_hat_0003 = "knight_0004",
	bountyhunter_hat_0004 = "knight_0004",
	bountyhunter_hat_0005 = "knight_0002",
	bountyhunter_hat_0006 = "mercenary_0002",
	bountyhunter_hat_0007 = "mercenary_0002",
	bountyhunter_hat_0008 = "mercenary_0002",
    bountyhunter_hat_0009 = "mercenary_0002",
    
    -- Zealot
	zealot_hat_0000 = "none",
	zealot_hat_0001 = "none",
	zealot_hat_0002 = "none",
	zealot_hat_0003 = "huntsman_0001",
	zealot_hat_0004 = "mercenary_0002",
	zealot_hat_0005 = "huntsman_0002",
    zealot_hat_0006 = "mercenary_0002",
    
    -- Dwarf
    dr_helmet_0000 = "mercenary_0002",
	dr_helmet_0001 = "mercenary_0002",
	dr_helmet_0002 = "knight_0004",
	dr_helmet_0003 = "mercenary_0002",
	dr_helmet_0005 = "knight_0004",
	dr_helmet_0008 = "knight_0004",
	dr_helmet_0011 = "huntsman_0004",
    dr_slayer_hair_0002 = "none",

    -- Dwarf Ranger
	ranger_hat_0000 = "mercenary_0002",
	ranger_hat_0001 = "knight_0001",
	ranger_hat_0002 = "mercenary_0002",
	ranger_hat_0003 = "knight_0002",
	ranger_hat_0004 = "mercenary_0002",
	ranger_hat_0005 = "mercenary_0002",
    ranger_hat_0006 = "huntsman_0004",
    
	-- Ironbreaker
	ironbreaker_hat_0000 = "knight_0004",
	ironbreaker_hat_0001 = "knight_0004",
	ironbreaker_hat_0004 = "knight_0004",
	ironbreaker_hat_0005 = "knight_0004",
	ironbreaker_hat_0008 = "knight_0004",
	ironbreaker_hat_0009 = "knight_0004",
	ironbreaker_hat_0010 = "knight_0004",
	ironbreaker_hat_0011 = "knight_0004",
	ironbreaker_hat_0012 = "knight_0004",
    ironbreaker_hat_0013 = "knight_0004",
    
    -- Slayer
	slayer_hat_0000 = "none",
	slayer_hat_0001 = "none",
	slayer_hat_0002 = "none",
	slayer_hat_0003 = "none",
	slayer_hat_0004 = "none",
	slayer_hat_0005 = "none",
	slayer_hat_0006 = "none",
	slayer_hat_0007 = "none",
	slayer_hat_0008 = "none",
	slayer_hat_0009 = "none",
	slayer_hat_0010 = "none",
	slayer_hat_0011 = "none",
    slayer_hat_0012 = "none",
    
    -- Mage
    bw_gate_0000 = "none",
	bw_gate_0001 = "none",
	bw_gate_0002 = "knight_0004",
	bw_gate_0006 = "knight_0004",
	bw_gate_0007 = "huntsman_0004",
    bw_gate_0008 = "none",

    -- Battle Wizard
	adept_hat_0000 = "none",
	adept_hat_0001 = "none",
	adept_hat_0002 = "none",
	adept_hat_0003 = "none",
	adept_hat_0004 = "none",
	adept_hat_0005 = "none",
	adept_hat_0006 = "none",
    adept_hat_0007 = "none",
    
	-- Pyromancer
	scholar_hat_0000 = "none",
	scholar_hat_0001 = "none",
	scholar_hat_0002 = "none",
	scholar_hat_0003 = "none",
	scholar_hat_0004 = "none",
	scholar_hat_0005 = "none",
	scholar_hat_0006 = "none",
	scholar_hat_0007 = "none",
	scholar_hat_0008 = "none",
	scholar_hat_0009 = "none",
    scholar_hat_0010 = "none",
    
    -- Unchained
	unchained_hat_0000 = "knight_0004",
	unchained_hat_0001 = "knight_0004",
	unchained_hat_0002 = "huntsman_0002",
	unchained_hat_0003 = "knight_0004",
	unchained_hat_0004 = "knight_0004",
	unchained_hat_0005 = "mercenary_0002",
	unchained_hat_0006 = "knight_0004",
	unchained_hat_0007 = "huntsman_0004",
	unchained_hat_0008 = "knight_0004",
    unchained_hat_0009 = "knight_0004",
    
}

mod.sound_effect = {

    "es_helmet_0003",
    "knight_hat_0004",
    "knight_hat_0003",
    "knight_hat_0006",
    "knight_hat_0007",
    "knight_hat_0009",
    "knight_hat_0010",
    "dr_helmet_0002",
    "dr_helmet_0005",
    "dr_helmet_0008",
    "ranger_hat_0001",
    "ironbreaker_hat_0000",
    "ironbreaker_hat_0001",
    "ironbreaker_hat_0004",
    "ironbreaker_hat_0005",
    "ironbreaker_hat_0008",
    "ironbreaker_hat_0009",
    "ironbreaker_hat_0010",
    "ironbreaker_hat_0011",
    "ironbreaker_hat_0012",
    "ironbreaker_hat_0013",
    "maidenguard_hat_0001",
    "maidenguard_hat_0007",
    "maidenguard_hat_0008",
    "maidenguard_hat_0009",
    "shade_hat_0002",
    "shade_hat_0003",
    "shade_hat_0004",
    "shade_hat_0005",
    "shade_hat_0006",
    "shade_hat_0007",
    "shade_hat_0008",
    "shade_hat_0009",
    "bountyhunter_hat_0000",
    "bountyhunter_hat_0002",
    "bountyhunter_hat_0003",
    "bountyhunter_hat_0004",
    "bountyhunter_hat_0005",
    "unchained_hat_0001",
    "unchained_hat_0003",

}
