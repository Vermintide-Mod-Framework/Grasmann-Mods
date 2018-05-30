local mod = get_mod("MoreRatWeapons")

local mod_data = {}
mod_data.name = "More Rat Weapons" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "slave_shield_chance",
		["widget_type"] = "numeric",
		["text"] = "Slave Rat Shield Chance",
		["unit_text"] = " %",
		["tooltip"] =  "Slave Rate Shield Chance\n" ..
			"Set the chance for slave rats to have shields.",
		["range"] = {0, 100},
		["decimals_number"] = 0,
		["default_value"] = 25,
	},
	{
		["setting_name"] = "clan_shield_chance",
		["widget_type"] = "numeric",
		["text"] = "Clan Rat Shield Chance",
		["unit_text"] = " %",
		["tooltip"] =  "Clan Rat Shield Chance\n" ..
			"Set the chance for clan rats to have shields.",
		["range"] = {0, 100},
		["decimals_number"] = 0,
		["default_value"] = 25,
	},
	{
		["setting_name"] = "storm_shield_chance",
		["widget_type"] = "numeric",
		["text"] = "Stormvermin Shield Chance",
		["unit_text"] = " %",
		["tooltip"] =  "Stormvermin Shield Chance\n" ..
			"Set the chance for stormvermin to have shields.",
		["range"] = {0, 100},
		["decimals_number"] = 0,
		["default_value"] = 25,
	},
	{
		["setting_name"] = "remove_running_attacks",
		["widget_type"] = "checkbox",
		["text"] = "Remove Running Attacks",
		["tooltip"] =  "Remove Running Attacks\n" ..
			"Removes the running attacks from rats that still have their shield.",
		["default_value"] = true,
	},
	{
		["setting_name"] = "shield_mechanics",
		["widget_type"] = "checkbox",
		["text"] = "Shield Mechanics",
		["tooltip"] =  "Shields Mechanics\n" ..
			"Rats can block attacks with their shields.",
		["default_value"] = false,
		["sub_widgets"] = {
			{
				["setting_name"] = "shield_type",
				["widget_type"] = "dropdown",
				["text"] = "Shields Type",
				["tooltip"] =  "Shields Type\n" ..
					"Choose how the shields are implemented.\n\n" ..
					"--- Health ---\n" ..
					"Shields have a certain health depending on the difficulty\n\n" ..
					"--- Points ---\n" ..
					"Shields block a certain number of attacks depending on the difficulty\n\n" ..
					"--- Never Break ---\n" ..
					"Shields will never break",
				["options"] = {
					{text = "Health", value = 1},
					{text = "Points", value = 2},
					{text = "Never Break", value = 3},
				},
				["default_value"] = 1,
			},
			{
				["setting_name"] = "play_comments",
				["widget_type"] = "checkbox",
				["text"] = "Play Armour Comments",
				["tooltip"] =  "Play Armour Comments\n" ..
					"Triggers comments about hitting armour on shield hits.",
				["default_value"] = true,
				["sub_widgets"] = {
					{
						["setting_name"] = "comment_pause",
						["widget_type"] = "numeric",
						["text"] = "Pause Between Comments",
						["unit_text"] = " sec",
						["tooltip"] =  "Pause Between Comments\n" ..
							"Seconds between armour comments.",
						["range"] = {10, 120},
						["decimals_number"] = 0,
						["default_value"] = 30,
					},
					{
						["setting_name"] = "comment_distance",
						["widget_type"] = "numeric",
						["text"] = "Comment Distance",
						["unit_text"] = " units",
						["tooltip"] =  "Comment Distance\n" ..
							"The maximum distance another hero can be away to comment.",
						["range"] = {3, 30},
						["decimals_number"] = 0,
						["default_value"] = 10,
					},
				},
			},
			{
				["setting_name"] = "play_particle_effects",
				["widget_type"] = "checkbox",
				["text"] = "Play Particle Effects",
				["tooltip"] =  "Play Particle Effects\n" ..
					"Triggers particle effects on shield hits.",
				["default_value"] = true,
			},
			{
				["setting_name"] = "play_shield_sounds",
				["widget_type"] = "checkbox",
				["text"] = "Play Shield Sounds",
				["tooltip"] =  "Play Shield Sounds\n" ..
					"Triggers sound effects on shield hits.",
				["default_value"] = true,
			},
			{
				["setting_name"] = "drop_shields",
				["widget_type"] = "checkbox",
				["text"] = "Physically Drop Shields",
				["tooltip"] =  "Physically Drop Shields\n" ..
					"Physically drop shields after the health is empty.",
				["default_value"] = true,
			},
		},
	},
	-- {
		-- ["setting_name"] = "use_player_weapons",
		-- --["widget_type"] = "stepper",
		-- ["widget_type"] = "checkbox",
		-- ["text"] = "Rats Use Player Weapons",
		-- ["tooltip"] =  "Rats Use Player Weapons [Local]\n" ..
			-- "Randomly give rats player weapons.",
		-- -- ["options"] = {
			-- -- {text = "Off", value = false},
			-- -- {text = "On", value = true},
		-- -- },
		-- ["default_value"] = false,
		-- ["sub_widgets"] = {
			-- {
				-- ["setting_name"] = "player_weapons_count",
				-- ["widget_type"] = "stepper",
				-- ["text"] = "Weapon Count",
				-- ["tooltip"] =  "Weapon Count [Local]\n" ..
					-- "How many player weapons should be loaded and used?\n\n" ..
					-- "--- Default ---\n" ..
					-- "17 Weapons and 4 Shields.\n" ..
					-- "--- More 1 ---\n" ..
					-- "34 Weapons and 10 Shields.\n" ..
					-- "--- More 2 ---\n" ..
					-- "49 Weapons and 10 Shields.\n" ..
					-- "--- More 3 ---\n" ..
					-- "64 Weapons and 10 Shields.\n" ..
					-- "--- More 4 ---\n" ..
					-- "77 Weapons and 10 Shields.\n" ..
					-- "--- More 5 ---\n" ..
					-- "90 Weapons and 10 Shields.\n" ..
					-- "--- More 6 ---\n" ..
					-- "101 Weapons and 10 Shields.\n",
				-- ["value_type"] = "number",
				-- ["options"] = {
					-- {text = "Default", value = 1},
					-- {text = "More 1", value = 2},
					-- {text = "More 2", value = 3},
					-- {text = "More 3", value = 4},
					-- {text = "More 4", value = 5},
					-- {text = "More 5", value = 6},
					-- {text = "More 6", value = 7},
				-- },
				-- ["default_value"] = 1,
			-- },
		-- },
	-- },
}
return mod_data