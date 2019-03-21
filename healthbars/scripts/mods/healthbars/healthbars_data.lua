local mod = get_mod("Healthbars")

return {
	name = "Healthbars", -- Readable mod name
	description = mod:localize("mod_description"), -- Readable mod description
	is_togglable = true, -- If the mod can be enabled/disabled
	is_mutator = false, -- If the mod is mutator
	options = {
		widgets = {
			{
				setting_id = "position",
				type = "dropdown",
				["options"] = {
					{text = "position_option_bottom_text", 	value = 1},
					{text = "position_option_top_text", 	value = 2},
				},
				["default_value"] = 2,
			},
			{
				setting_id = "mode",
				type = "dropdown",
				["options"] = {
					{text = "mode_option_all_text", 		value = 2, show_widgets = {1}},
					{text = "mode_option_specials_text", 	value = 3, show_widgets = {1}},
					{text = "mode_option_bosses_text", 		value = 4, show_widgets = {1}},
					{text = "mode_option_custom_text", 		value = 5, show_widgets = {1, 2, 3, 4, 5, 6, 7, 8, 9,
						10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32}},
				},
				["default_value"] = 2,
				["sub_widgets"] = {
					{
						setting_id = "toggle_mode",
						type = "keybind",
						keybind_trigger = "pressed",
						keybind_type    = "function_call",
						function_name   = "toggle_mode",
						["default_value"] = {},
					},
					{ setting_id = "slave_rat", 								type = "checkbox", 	["default_value"] = false, }, --2
					{ setting_id = "clan_rat", 									type = "checkbox", 	["default_value"] = false, }, --3
					{ setting_id = "stormvermin", 								type = "checkbox", 	["default_value"] = false, }, --4
					{ setting_id = "plague_monk", 								type = "checkbox", 	["default_value"] = false, }, --5
					{ setting_id = "sack_rat", 									type = "checkbox", 	["default_value"] = false, }, --6
					{ setting_id = "runner", 									type = "checkbox", 	["default_value"] = false, }, --7
					{ setting_id = "gunner", 									type = "checkbox", 	["default_value"] = false, }, --8
					{ setting_id = "packmaster", 								type = "checkbox", 	["default_value"] = false, }, --9
					{ setting_id = "gas_rat", 									type = "checkbox", 	["default_value"] = false, }, --10
					{ setting_id = "warpfire_thrower", 							type = "checkbox", 	["default_value"] = false, }, --11
					{ setting_id = "ogre", 										type = "checkbox", 	["default_value"] = false, }, --12
					{ setting_id = "champion", 									type = "checkbox", 	["default_value"] = false, }, --13
					{ setting_id = "stormfiend", 								type = "checkbox", 	["default_value"] = false, }, --14
					{ setting_id = "stormfiend_boss", 							type = "checkbox", 	["default_value"] = false, }, --15
					{ setting_id = "stormvermin_warlord", 						type = "checkbox", 	["default_value"] = false, }, --16
					-- Chaos
					{ setting_id = "chaos_fanatic", 							type = "checkbox", 	["default_value"] = false, }, --17
					{ setting_id = "chaos_zombie", 								type = "checkbox", 	["default_value"] = false, }, --18
					{ setting_id = "chaos_marauder", 							type = "checkbox", 	["default_value"] = false, }, --19
					{ setting_id = "chaos_raider", 								type = "checkbox", 	["default_value"] = false, }, --20
					{ setting_id = "chaos_berzerker", 							type = "checkbox", 	["default_value"] = false, }, --21
					{ setting_id = "chaos_warrior", 							type = "checkbox", 	["default_value"] = false, }, --22
					{ setting_id = "chaos_vortex_sorcerer", 					type = "checkbox", 	["default_value"] = false, }, --23
					-- { setting_id = "vortex", 								type = "checkbox", 	["default_value"] = false, },
					{ setting_id = "chaos_corruptor_sorcerer", 					type = "checkbox", 	["default_value"] = false, }, --24
					{ setting_id = "chaos_tentacle_sorcerer", 					type = "checkbox", 	["default_value"] = false, }, --25
					-- { setting_id = "chaos_tentacle", 						type = "checkbox", 	["default_value"] = false, },
					{ setting_id = "chaos_plague_sorcerer", 					type = "checkbox", 	["default_value"] = false, }, --26
					-- { setting_id = "chaos_plague_wave_spawner", 				type = "checkbox", 	["default_value"] = false, },
					{ setting_id = "chaos_spawn", 								type = "checkbox", 	["default_value"] = false, }, --27
					{ setting_id = "chaos_troll", 								type = "checkbox", 	["default_value"] = false, }, --28
					-- { setting_id = "chaos_exalted_champion", 				type = "checkbox", 	["default_value"] = false, },
					{ setting_id = "chaos_exalted_champion_warcamp", 			type = "checkbox", 	["default_value"] = false, }, --29
					{ setting_id = "chaos_exalted_champion_norsca", 			type = "checkbox", 	["default_value"] = false, }, --30
					{ setting_id = "chaos_spawn_exalted_champion_norsca", 		type = "checkbox", 	["default_value"] = false, }, --31
					{ setting_id = "chaos_exalted_sorcerer", 					type = "checkbox", 	["default_value"] = false, }, --32
				},
			},
			{
				setting_id = "toggle_mod",
				type = "keybind",
				keybind_trigger = "pressed",
				keybind_type    = "mod_toggle",
				["default_value"] = {},
			},
		},
	},
}