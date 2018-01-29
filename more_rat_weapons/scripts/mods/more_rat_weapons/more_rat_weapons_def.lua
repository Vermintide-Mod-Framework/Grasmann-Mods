local mod = get_mod("MoreRatWeapons")

mod.packages = {
	-- Default
	{
		-- Bases
		es_base = "units/beings/player/empire_soldier/third_person_base/chr_third_person_variation_1_base",
		ww_base = "units/beings/player/way_watcher/third_person_base/chr_third_person_variation_1_base",
		dr_base = "units/beings/player/dwarf_ranger/third_person_base/chr_third_person_variation_1_base",
		bw_base = "units/beings/player/bright_wizard/third_person_base/chr_third_person_variation_1_base",
		wh_base = "units/beings/player/witch_hunter/third_person_base/chr_third_person_variation_1_base",
		-- 2-handed weapons
		mrw_2h_01 = "units/weapons/player/wpn_empire_2h_hammer_01_t1/wpn_2h_hammer_01_t1_3p",
		mrw_2h_02 = "units/weapons/player/wpn_dw_2h_axe_01_t1/wpn_dw_2h_axe_01_t1_3p",
		mrw_2h_03 = "units/weapons/player/wpn_dw_2h_hammer_01_t1/wpn_dw_2h_hammer_01_t1_3p",
		mrw_2h_04 = "units/weapons/player/wpn_we_2h_axe_01_t1/wpn_we_2h_axe_01_t1_3p",
		mrw_2h_05 = "units/weapons/player/wpn_dw_pick_01_t1/wpn_dw_pick_01_t1_3p",
		-- Shields
		mrw_s_01 = "units/weapons/player/wpn_empire_shield_01_t1/wpn_emp_shield_01_t1_3p",
		mrw_s_01b = "units/weapons/player/wpn_empire_shield_02/wpn_emp_shield_02_3p",
		mrw_s_02 = "units/weapons/player/wpn_dw_shield_01_t1/wpn_dw_shield_01_3p",
		mrw_s_02b = "units/weapons/player/wpn_dw_shield_02_t1/wpn_dw_shield_02_3p",
		-- 1-handed weapons
		mrw_1h_01 = "units/weapons/player/wpn_axe_02_t1/wpn_axe_02_t1_3p",
		mrw_1h_02 = "units/weapons/player/wpn_axe_hatchet_t1/wpn_axe_hatchet_t1_3p",
		mrw_1h_03 = "units/weapons/player/wpn_brw_sword_01_t1/wpn_brw_flaming_sword_01_t1_3p",
		mrw_1h_04 = "units/weapons/player/wpn_brw_sword_01_t1/wpn_brw_sword_01_t1_3p",
		mrw_1h_05 = "units/weapons/player/wpn_dw_axe_01_t1/wpn_dw_axe_01_t1_3p",
		mrw_1h_06 = "units/weapons/player/wpn_dw_hammer_01_t1/wpn_dw_hammer_01_t1_3p",
		mrw_1h_07 = "units/weapons/player/wpn_emp_mace_02_t1/wpn_emp_mace_02_t1_3p",
		mrw_1h_08 = "units/weapons/player/wpn_emp_sword_02_t1/wpn_emp_sword_02_t1_3p",
		mrw_1h_09 = "units/weapons/player/wpn_empire_basic_mace/wpn_empire_basic_mace_t1_3p",
		mrw_1h_10 = "units/weapons/player/wpn_we_axe_01_t1/wpn_we_axe_01_t1_3p",
		mrw_1h_11 = "units/weapons/player/wpn_we_dagger_01_t1/wpn_we_dagger_01_t1_3p",
		mrw_1h_12 = "units/weapons/player/wpn_we_sword_01_t1/wpn_we_sword_01_t1_3p",
	},
	-- More 1
	{
		-- 2-handed weapons
		mrw_2h_01b = "units/weapons/player/wpn_empire_2h_hammer_01_t2/wpn_2h_hammer_01_t2_3p",
		mrw_2h_02b = "units/weapons/player/wpn_dw_2h_axe_01_t2/wpn_dw_2h_axe_01_t2_3p",
		mrw_2h_03b = "units/weapons/player/wpn_dw_2h_hammer_01_t2/wpn_dw_2h_hammer_01_t2_3p",
		mrw_2h_04b = "units/weapons/player/wpn_we_2h_axe_01_t2/wpn_we_2h_axe_01_t2_3p",
		mrw_2h_05b = "units/weapons/player/wpn_dw_pick_01_t2/wpn_dw_pick_01_t2_3p",
		-- Shields
		mrw_s_01c = "units/weapons/player/wpn_empire_shield_03/wpn_emp_shield_03_3p",
		mrw_s_01d = "units/weapons/player/wpn_empire_shield_04/wpn_emp_shield_04_3p",
		mrw_s_01e = "units/weapons/player/wpn_empire_shield_05/wpn_emp_shield_05_3p",
		mrw_s_02c = "units/weapons/player/wpn_dw_shield_03_t1/wpn_dw_shield_03_3p",
		mrw_s_02d = "units/weapons/player/wpn_dw_shield_04_t1/wpn_dw_shield_04_3p",
		mrw_s_02e = "units/weapons/player/wpn_dw_shield_05_t1/wpn_dw_shield_05_3p",
		-- 1-handed weapons
		mrw_1h_01b = "units/weapons/player/wpn_axe_02_t2/wpn_axe_02_t2_3p",
		mrw_1h_02b = "units/weapons/player/wpn_axe_hatchet_t2/wpn_axe_hatchet_t2_3p",
		mrw_1h_03b = "units/weapons/player/wpn_brw_sword_01_t2/wpn_brw_flaming_sword_01_t2_3p",
		mrw_1h_04b = "units/weapons/player/wpn_brw_sword_01_t2/wpn_brw_sword_01_t2_3p",
		mrw_1h_05b = "units/weapons/player/wpn_dw_axe_01_t2/wpn_dw_axe_01_t2_3p",
		mrw_1h_06b = "units/weapons/player/wpn_dw_hammer_01_t2/wpn_dw_hammer_01_t2_3p",
		mrw_1h_07b = "units/weapons/player/wpn_emp_mace_02_t2/wpn_emp_mace_02_t2_3p",
		mrw_1h_08b = "units/weapons/player/wpn_emp_sword_02_t2/wpn_emp_sword_02_t2_3p",
		mrw_1h_09b = "units/weapons/player/wpn_empire_basic_mace/wpn_empire_basic_mace_t2_3p",
		mrw_1h_10b = "units/weapons/player/wpn_we_axe_01_t2/wpn_we_axe_01_t2_3p",
		mrw_1h_11b = "units/weapons/player/wpn_we_dagger_01_t2/wpn_we_dagger_01_t2_3p",
		mrw_1h_12b = "units/weapons/player/wpn_we_sword_01_t2/wpn_we_sword_01_t2_3p",
	},
	-- More 2
	{
		-- 2-handed weapons
		mrw_2h_01c = "units/weapons/player/wpn_empire_2h_hammer_02_t1/wpn_2h_hammer_02_t1_3p",
		mrw_2h_02c = "units/weapons/player/wpn_dw_2h_axe_02_t1/wpn_dw_2h_axe_02_t1_3p",
		mrw_2h_03c = "units/weapons/player/wpn_dw_2h_hammer_02_t1/wpn_dw_2h_hammer_02_t1_3p",
		mrw_2h_04c = "units/weapons/player/wpn_we_2h_axe_02_t1/wpn_we_2h_axe_02_t1_3p",
		mrw_2h_05c = "units/weapons/player/wpn_dw_pick_01_t3/wpn_dw_pick_01_t3_3p",
		-- 1-handed weapons
		mrw_1h_01c = "units/weapons/player/wpn_axe_03_t1/wpn_axe_03_t1_3p",
		mrw_1h_03c = "units/weapons/player/wpn_brw_sword_02_t1/wpn_brw_flaming_sword_02_t1_3p",
		mrw_1h_04c = "units/weapons/player/wpn_brw_sword_02_t1/wpn_brw_sword_02_t1_3p",
		mrw_1h_05c = "units/weapons/player/wpn_dw_axe_02_t1/wpn_dw_axe_02_t1_3p",
		mrw_1h_06c = "units/weapons/player/wpn_dw_hammer_02_t1/wpn_dw_hammer_02_t1_3p",
		mrw_1h_07c = "units/weapons/player/wpn_emp_mace_02_t3/wpn_emp_mace_02_t3_3p",
		mrw_1h_08c = "units/weapons/player/wpn_emp_sword_03_t1/wpn_emp_sword_03_t1_3p",
		mrw_1h_10c = "units/weapons/player/wpn_we_axe_02_t1/wpn_we_axe_02_t1_3p",
		mrw_1h_11c = "units/weapons/player/wpn_we_dagger_02_t1/wpn_we_dagger_02_t1_3p",
		mrw_1h_12c = "units/weapons/player/wpn_we_sword_01_t3/wpn_we_sword_01_t3_3p",
	},
	-- More 3
	{
		-- 2-handed weapons
		mrw_2h_01d = "units/weapons/player/wpn_empire_2h_hammer_02_t2/wpn_2h_hammer_02_t2_3p",
		mrw_2h_02d = "units/weapons/player/wpn_dw_2h_axe_03_t2/wpn_dw_2h_axe_03_t2_3p",
		mrw_2h_03d = "units/weapons/player/wpn_dw_2h_hammer_02_t2/wpn_dw_2h_hammer_02_t2_3p",
		mrw_2h_04d = "units/weapons/player/wpn_we_2h_axe_02_t2/wpn_we_2h_axe_02_t2_3p",
		mrw_2h_05d = "units/weapons/player/wpn_dw_pick_01_t4/wpn_dw_pick_01_t4_3p",
		-- 1-handed weapons
		mrw_1h_01d = "units/weapons/player/wpn_axe_03_t2/wpn_axe_03_t2_3p",
		mrw_1h_03d = "units/weapons/player/wpn_brw_sword_02_t2/wpn_brw_flaming_sword_02_t2_3p",
		mrw_1h_04d = "units/weapons/player/wpn_brw_sword_02_t2/wpn_brw_sword_02_t2_3p",
		mrw_1h_05d = "units/weapons/player/wpn_dw_axe_02_t2/wpn_dw_axe_02_t2_3p",
		mrw_1h_06d = "units/weapons/player/wpn_dw_hammer_02_t2/wpn_dw_hammer_02_t2_3p",
		mrw_1h_07d = "units/weapons/player/wpn_emp_mace_03_t1/wpn_emp_mace_03_t1_3p",
		mrw_1h_08d = "units/weapons/player/wpn_emp_sword_03_t2/wpn_emp_sword_03_t2_3p",
		mrw_1h_10d = "units/weapons/player/wpn_we_axe_02_t2/wpn_we_axe_02_t2_3p",
		mrw_1h_11d = "units/weapons/player/wpn_we_dagger_02_t2/wpn_we_dagger_02_t2_3p",
		mrw_1h_12d = "units/weapons/player/wpn_we_sword_02_t1/wpn_we_sword_02_t1_3p",
	},
	-- More 4
	{
		-- 2-handed weapons
		mrw_2h_01e = "units/weapons/player/wpn_empire_2h_hammer_03_t2/wpn_2h_hammer_03_t2_3p",
		mrw_2h_02e = "units/weapons/player/wpn_dw_2h_axe_02_t2/wpn_dw_2h_axe_02_t2_3p",
		mrw_2h_03e = "units/weapons/player/wpn_dw_2h_hammer_03_t1/wpn_dw_2h_hammer_03_t1_3p",
		mrw_2h_04e = "units/weapons/player/wpn_we_2h_axe_03_t1/wpn_we_2h_axe_03_t1_3p",
		-- 1-handed weapons
		mrw_1h_03e = "units/weapons/player/wpn_brw_sword_03_t1/wpn_brw_flaming_sword_03_t1_3p",
		mrw_1h_04e = "units/weapons/player/wpn_brw_sword_03_t1/wpn_brw_sword_03_t1_3p",
		mrw_1h_05e = "units/weapons/player/wpn_dw_axe_03_t1/wpn_dw_axe_03_t1_3p",
		mrw_1h_06e = "units/weapons/player/wpn_dw_hammer_03_t1/wpn_dw_hammer_03_t1_3p",
		mrw_1h_07e = "units/weapons/player/wpn_emp_mace_03_t2/wpn_emp_mace_03_t2_3p",
		mrw_1h_08e = "units/weapons/player/wpn_emp_sword_04_t1/wpn_emp_sword_04_t1_3p",
		mrw_1h_10e = "units/weapons/player/wpn_we_axe_03_t1/wpn_we_axe_03_t1_3p",
		mrw_1h_11e = "units/weapons/player/wpn_we_dagger_02_t3/wpn_we_dagger_02_t3_3p",
		mrw_1h_12e = "units/weapons/player/wpn_we_sword_02_t2/wpn_we_sword_02_t2_3p",
	},
	-- More 5
	{
		-- 2-handed weapons
		mrw_2h_03f = "units/weapons/player/wpn_dw_2h_hammer_03_t2/wpn_dw_2h_hammer_03_t2_3p",
		mrw_2h_04f = "units/weapons/player/wpn_we_2h_axe_03_t2/wpn_we_2h_axe_03_t2_3p",
		mrw_2h_04g = "units/weapons/player/wpn_we_2h_axe_04_t1/wpn_we_2h_axe_04_t1_3p",
		mrw_2h_04h = "units/weapons/player/wpn_we_2h_axe_04_t2/wpn_we_2h_axe_04_t2_3p",
		-- 1-handed weapons
		mrw_1h_03f = "units/weapons/player/wpn_brw_sword_03_t2/wpn_brw_flaming_sword_03_t2_3p",
		mrw_1h_04f = "units/weapons/player/wpn_brw_sword_03_t2/wpn_brw_sword_03_t2_3p",
		mrw_1h_05f = "units/weapons/player/wpn_dw_axe_03_t2/wpn_dw_axe_03_t2_3p",
		mrw_1h_06f = "units/weapons/player/wpn_dw_hammer_03_t2/wpn_dw_hammer_03_t2_3p",
		mrw_1h_07f = "units/weapons/player/wpn_emp_mace_04_t1/wpn_emp_mace_04_t1_3p",
		mrw_1h_08f = "units/weapons/player/wpn_emp_sword_04_t2/wpn_emp_sword_04_t2_3p",
		mrw_1h_10f = "units/weapons/player/wpn_we_axe_03_t2/wpn_we_axe_03_t2_3p",
		mrw_1h_11f = "units/weapons/player/wpn_we_dagger_03_t1/wpn_we_dagger_03_t1_3p",
		mrw_1h_12f = "units/weapons/player/wpn_we_sword_03_t1/wpn_we_sword_03_t1_3p",
	},
	-- More 6
	{
		-- 1-handed weapons
		mrw_1h_03g = "units/weapons/player/wpn_brw_sword_04_t1/wpn_brw_flaming_sword_04_t1_3p",
		mrw_1h_04g = "units/weapons/player/wpn_brw_sword_04_t1/wpn_brw_sword_04_t1_3p",
		mrw_1h_05g = "units/weapons/player/wpn_dw_axe_04_t1/wpn_dw_axe_04_t1_3p",
		mrw_1h_07g = "units/weapons/player/wpn_emp_mace_04_t2/wpn_emp_mace_04_t2_3p",
		mrw_1h_08g = "units/weapons/player/wpn_emp_sword_05_t1/wpn_emp_sword_05_t1_3p",
		mrw_1h_11g = "units/weapons/player/wpn_we_dagger_03_t2/wpn_we_dagger_03_t2_3p",
		mrw_1h_12g = "units/weapons/player/wpn_we_sword_03_t2/wpn_we_sword_03_t2_3p",
		mrw_1h_03h = "units/weapons/player/wpn_brw_sword_04_t2/wpn_brw_flaming_sword_04_t2_3p",
		mrw_1h_04h = "units/weapons/player/wpn_brw_sword_04_t2/wpn_brw_sword_04_t2_3p",
		mrw_1h_07h = "units/weapons/player/wpn_emp_mace_04_t3/wpn_emp_mace_04_t3_3p",
		mrw_1h_08h = "units/weapons/player/wpn_emp_sword_05_t2/wpn_emp_sword_05_t2_3p",
	},
}

mod.custom_2h_weapons = {
	-- Default; 5;
	{
		unit_name = mod.packages[1].mrw_2h_01,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[1].mrw_2h_02,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.9},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[1].mrw_2h_03,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[1].mrw_2h_04,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[1].mrw_2h_05,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	-- More 1; 5; 10;
	{
		unit_name = mod.packages[2].mrw_2h_01b,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[2].mrw_2h_02b,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.9},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[2].mrw_2h_03b,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[2].mrw_2h_04b,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[2].mrw_2h_05b,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	-- More 2; 5; 15;
	{
		unit_name = mod.packages[3].mrw_2h_01c,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[3].mrw_2h_02c,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.9},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[3].mrw_2h_03c,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[3].mrw_2h_04c,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[3].mrw_2h_05c,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	-- More 3; 5; 20;
	{
		unit_name = mod.packages[4].mrw_2h_01d,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[4].mrw_2h_02d,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.9},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[4].mrw_2h_03d,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[4].mrw_2h_04d,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[4].mrw_2h_05d,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	-- More 4; 4; 24;
	{
		unit_name = mod.packages[5].mrw_2h_01e,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[5].mrw_2h_02e,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.9},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[5].mrw_2h_03e,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[5].mrw_2h_04e,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	-- More 5; 4; 28;
	{
		unit_name = mod.packages[6].mrw_2h_03f,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 1},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.75},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[6].mrw_2h_04f,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[6].mrw_2h_04g,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},
	{
		unit_name = mod.packages[6].mrw_2h_04h,
		attachment_node_linking = AttachmentNodeLinking.ai_spear,
		unwielded = {
			position = {0, 0, 0.7},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.75},
		},
		wielded = {
			position = {0, 0, -0.5},
			rotation = {-5, 0, 0},
			scale = {1.3, 1.3, 1.75},
		},
		dropped = {
			position = {0, 0, -0.5},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.75},
		},
	},

	name = "spear",
	count = 28,
	count_settings = {
		5,
		10,
		15,
		20,
		24,
		28,
		28,
	},
}

mod.custom_shields = {
	-- Default; 4
	{
		unit_name = mod.packages[1].mrw_s_01,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.25, 0, 0},
			rotation = {0, -30, -100},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -100},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -100},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[1].mrw_s_01b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.23, 0, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -110},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[1].mrw_s_02,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.27, 0, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -90},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[1].mrw_s_02b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.27, 0, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -90},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
	},
	-- More 1; 6; 10
	{
		unit_name = mod.packages[2].mrw_s_01c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.23, 0, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -110},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[2].mrw_s_01d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.23, 0, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -110},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[2].mrw_s_01e,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.23, 0, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -110},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -110},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[2].mrw_s_02c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.27, 0, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -90},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[2].mrw_s_02d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.27, 0, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -90},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
	},
	{
		unit_name = mod.packages[2].mrw_s_02e,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.27, 0, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
		wielded = {
			position = {0.27, 0.05, 0},
			rotation = {0, -10, -90},
			scale = {1.5, 1, 1},
		},
		dropped = {
			position = {0.25, -0.1, 0},
			rotation = {0, -30, -90},
			scale = {1.5, 1, 1},
		},
	},
	
	name = "shield",
	count = 10,
	count_settings = {
		4,
		10,
		10,
		10,
		10,
		10,
		10,
	},
}

mod.custom_1h_weapons = {
	-- Default; 12
	{
		unit_name = mod.packages[1].mrw_1h_01,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_02,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_03,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_04,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_05,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_06,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_07,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_08,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_09,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_10,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_11,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[1].mrw_1h_12,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 1; 12, 24
	{
		unit_name = mod.packages[2].mrw_1h_01b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_02b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_03b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_04b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_05b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_06b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_07b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_08b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_09b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_10b,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_11b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[2].mrw_1h_12b,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 2; 10; 34
	{
		unit_name = mod.packages[3].mrw_1h_01c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_03c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_04c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_05c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_06c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_07c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_08c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_10c,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_11c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[3].mrw_1h_12c,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 3; 10; 44
	{
		unit_name = mod.packages[4].mrw_1h_01d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_03d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_04d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_05d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_06d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_07d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_08d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_10d,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_11d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[4].mrw_1h_12d,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 4; 9; 53
	{
		unit_name = mod.packages[5].mrw_1h_03e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_04e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_05e,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_06e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_07e,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_08e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_10e,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_11e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[5].mrw_1h_12e,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 5; 9; 62
	{
		unit_name = mod.packages[6].mrw_1h_03f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_04f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_05f,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_06f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, 0.3},
			rotation = {0, 180, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_07f,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_08f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_10f,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_11f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[6].mrw_1h_12f,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	
	-- More 6; 11; 73
	{
		unit_name = mod.packages[7].mrw_1h_03g,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_04g,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_05g,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_07g,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_08g,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_11g,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_12g,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_03h,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_04h,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_07h,
		attachment_node_linking = AttachmentNodeLinking.ai_shield,
		unwielded = {
			position = {0.1, 0.05, 0.3},
			rotation = {0, 180, 90},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},
	{
		unit_name = mod.packages[7].mrw_1h_08h,
		attachment_node_linking = AttachmentNodeLinking.ai_sword,
		unwielded = {
			position = {0, 0, -0.1},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		wielded = {
			position = {0, 0, 0},
			rotation = {0, 0, 0},
			scale = {1.3, 1.3, 1.3},
		},
		dropped = {
			position = {0, 0, 0},
			rotation = {0, 0, 90},
			scale = {1.3, 1.3, 1.3},
		},
	},

	name = "sword",
	count = 73,
	count_settings = {
		12,
		24,
		34,
		44,
		53,
		62,
		73,
	},
}

mod.replace_inventory = {
	halberd_and_shield = "custom_2h_shield",
	halberd = "custom_2h",
	sword_and_shield = "custom_1h_shield",
	slave_shield = "custom_1h_shield",
	clan_shield = "custom_1h_shield",
	sword = "custom_1h",
	spear = "custom_1h",
}

mod.replace_luck = {
	halberd_and_shield = 90,
	halberd = 90,
	sword_and_shield = 75,
	slave_shield = 75,
	clan_shield = 75,
	sword = 75,
	spear = 75,
}

InventoryConfigurations.custom_1h = table.clone(InventoryConfigurations.sword)
InventoryConfigurations.custom_1h.items[1] = mod.custom_1h_weapons

InventoryConfigurations.custom_1h_shield = table.clone(InventoryConfigurations.sword_and_shield)
InventoryConfigurations.custom_1h_shield.items[1] = mod.custom_1h_weapons
InventoryConfigurations.custom_1h_shield.items[2] = mod.custom_shields

InventoryConfigurations.custom_2h_shield = table.clone(InventoryConfigurations.sword_and_shield)
InventoryConfigurations.custom_2h_shield.items[1] = mod.custom_2h_weapons
InventoryConfigurations.custom_2h_shield.items[2] = mod.custom_shields

InventoryConfigurations.custom_2h = table.clone(InventoryConfigurations.halberd)
InventoryConfigurations.custom_2h.items[1] = mod.custom_2h_weapons
