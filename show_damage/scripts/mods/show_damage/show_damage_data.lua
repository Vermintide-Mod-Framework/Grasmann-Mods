local mod = get_mod("ShowDamage")

local mod_data = {
	name = "Show Damage", -- Readable mod name
	description = mod:localize("mod_description"), -- Readable mod description
	is_togglable = true, -- If the mod can be enabled/disabled
	is_mutator = false, -- If the mod is mutator
	options_widgets = {
		{
			["setting_name"] = "chat_output",
			["widget_type"] = "checkbox",
			["text"] = "Chat Output",
			["tooltip"] = "Chat Output\n" ..
				"Show information in chat.",
			["default_value"] = false,
			["sub_widgets"] = {
				{
					["setting_name"] = "chat_damage",
					["widget_type"] = "checkbox",
					["text"] = "Damage",
					["tooltip"] = "Show damage information in chat.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "chat_damage_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for the player damage output.\n\n" ..
								"-- ME ONLY --\nOnly show damage messages for yourself.\n\n" ..
								"-- ALL --\nShows damage messages for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see damage messages of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_damage_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_damage_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_damage_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_damage_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
						{
							["setting_name"] = "chat_mode",
							["widget_type"] = "dropdown",
							["text"] = "Mode",
							["tooltip"] = "Switch mode for the player damage output.\n\n" ..
								"-- DEFAULT --\nShows damage, hit zone and kill confirmation.\n\n" ..
								"-- KILLS --\nShows the default message but only on kills.\n\n" ..
								"-- SIMPLE KILLS --\nShows a simple message on a kill.",
							["options"] = {
								{text = "Default", value = 2},
								{text = "Kills", value = 3},
								{text = "Simple Kills", value = 4},
							},
							["default_value"] = 2,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {1, 2},
									["setting_name"] = "chat_hit_zone",
									["widget_type"] = "checkbox",
									["text"] = "Hitzone",
									["tooltip"] = "Will show the hitzone in chat output.",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {1},
									["setting_name"] = "chat_kill",
									["widget_type"] = "checkbox",
									["text"] = "Kill Indicator",
									["tooltip"] = "Will show an indication in chat output if hit was a kill.",
									["default_value"] = false,
								},
							},
						},
					},
				},
				{
					["setting_name"] = "chat_heal",
					["widget_type"] = "checkbox",
					["text"] = "Bloodlust / Regrowth",
					["tooltip"] = "Shows heal numbers for bloodlust and regrowth in chat.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "chat_heal_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for heal numbers in chat.\n\n" ..
								"-- ME ONLY --\nOnly show heal numbers for yourself.\n\n" ..
								"-- ALL --\nShows heal numbers for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see heal numbers of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_heal_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_heal_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_heal_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_heal_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
					},
				},
				{
					["setting_name"] = "chat_ammo",
					["widget_type"] = "checkbox",
					["text"] = "Scavenger",
					["tooltip"] = "Shows ammo numbers for scavenger in chat.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "chat_ammo_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for ammo numbers in chat.\n\n" ..
								"-- ME ONLY --\nOnly show ammo numbers for yourself.\n\n" ..
								"-- ALL --\nShows ammo numbers for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see ammo numbers of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_ammo_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_ammo_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_ammo_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "chat_ammo_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
					},
				},
			},
		},
		{
			["setting_name"] = "floating_numbers",
			["widget_type"] = "checkbox",
			["text"] = "Floating Numbers",
			["tooltip"] = "Shows floating numbers for damage and certain buffs.",
			["default_value"] = false,
			["sub_widgets"] = {
				{
					["setting_name"] = "floating_numbers_size",
					["widget_type"] = "numeric",
					["text"] = "Size",
					["unit_text"] = "",
					["tooltip"] = "Set the preferred size for floating numbers / icons.",
					["range"] = {0.5, 1.5},
					["decimals_number"] = 2,
					["default_value"] = 1,
				},
				{
					["setting_name"] = "floating_numbers_pop",
					["widget_type"] = "checkbox",
					["text"] = "Pop Effect",
					["tooltip"] = "Adds a pop-effect to high damage numbers / heal / ammo to make them stand out more.",
					["default_value"] = false,
				},
				{
					["setting_name"] = "floating_numbers_fade",
					["widget_type"] = "checkbox",
					["text"] = "Fade Effect",
					["tooltip"] = "Adds a fade-effect to all floating numbers.",
					["default_value"] = false,
				},
				{
					["setting_name"] = "floating_damage_numbers",
					["widget_type"] = "checkbox",
					["text"] = "Damage",
					["tooltip"] = "Shows floating damage numbers.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "floating_icons_headshot",
							["widget_type"] = "checkbox",
							["text"] = "Headshot Icon",
							["tooltip"] = "Shows an icon on headshots.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_icons_block",
							["widget_type"] = "checkbox",
							["text"] = "Block Icon",
							["tooltip"] = "Shows an icon when attacks are blocked.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_icons_poison",
							["widget_type"] = "checkbox",
							["text"] = "Poison Icon",
							["tooltip"] = "Shows an icon on poison damage.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_icons_burn",
							["widget_type"] = "checkbox",
							["text"] = "Burn Icon",
							["tooltip"] = "Shows an icon on burning damage.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_numbers_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for floating damage numbers.\n\n" ..
								"-- ME ONLY --\nOnly show damage numbers for yourself.\n\n" ..
								"-- ALL --\nShows damage numbers for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see damage numbers of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_numbers_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_numbers_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_numbers_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_numbers_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
					},
				},
				{
					["setting_name"] = "floating_heal",
					["widget_type"] = "checkbox",
					["text"] = "Bloodlust / Regrowth",
					["tooltip"] = "Shows floating heal numbers for bloodlust and regrowth.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "floating_icons_heal",
							["widget_type"] = "checkbox",
							["text"] = "Icon",
							["tooltip"] = "Shows an icon when with the number.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_heal_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for floating heal numbers.\n\n" ..
								"-- ME ONLY --\nOnly show heal numbers for yourself.\n\n" ..
								"-- ALL --\nShows heal numbers for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see heal numbers of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_heal_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_heal_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_heal_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_heal_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
					},
				},
				{
					["setting_name"] = "floating_ammo",
					["widget_type"] = "checkbox",
					["text"] = "Scavenger",
					["tooltip"] = "Shows floating ammo numbers for scavenger.",
					["default_value"] = false,
					["sub_widgets"] = {
						{
							["setting_name"] = "floating_icons_ammo",
							["widget_type"] = "checkbox",
							["text"] = "Icon",
							["tooltip"] = "Shows an icon when with the number.",
							["default_value"] = false,
						},
						{
							["setting_name"] = "floating_ammo_source",
							["widget_type"] = "dropdown",
							["text"] = "Source",
							["tooltip"] = "Switch source for floating ammo numbers.\n\n" ..
								"-- ME ONLY --\nOnly show ammo numbers for yourself.\n\n" ..
								"-- ALL --\nShows ammo numbers for all players, including bots.\n\n" ..
								"-- CUSTOM --\nChoose the players you want to see ammo numbers of.\n\n",
							["options"] = {
								{text = "Me Only", value = 1},
								{text = "All", value = 2},
								{text = "Custom", value = 3},
							},
							["default_value"] = 1,
							["sub_widgets"] = {
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_ammo_player_1",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_ammo_player_2",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_ammo_player_3",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
								{
									["show_widget_condition"] = {3},
									["setting_name"] = "floating_ammo_player_4",
									["widget_type"] = "checkbox",
									["text"] = "N/A",
									["default_value"] = false,
								},
							},
						},
					},
				},
			},
		},
		{
			["setting_name"] = "toggle_suspension",
			["widget_type"] = "keybind",
			["text"] = "Toggle",
			["tooltip"] = "Toggle show damage on / off.",
			["default_value"] = {},
			["action"] = "toggle_mod_state"
		},
	},
}
if not VT1 then
	mod_data.options_widgets[#mod_data.options_widgets+1] = {
		["setting_name"] = "disable_default_numbers",
		["widget_type"] = "checkbox",
		["text"] = "Disable Training Dummy Numbers",
		["tooltip"] = "Disable the default damage numbers that appear when attacking training dummies.",
		["default_value"] = false,
	}
	-- Overwrite chat text
	mod_data.options_widgets[1].sub_widgets[2].text = "Heal on Kill"
	mod_data.options_widgets[1].sub_widgets[2].tooltip = "Shows heal numbers when receiving health on kill in chat."
	mod_data.options_widgets[1].sub_widgets[3].text = "Ammo on Kill"
	mod_data.options_widgets[1].sub_widgets[3].tooltip = "Shows heal numbers when receiving ammo on kill in chat."
	-- Overwrite floating text
	mod_data.options_widgets[2].sub_widgets[5].text = "Heal on Kill"
	mod_data.options_widgets[2].sub_widgets[5].tooltip = "Shows floating heal numbers when receiving health on kill in chat."
	mod_data.options_widgets[2].sub_widgets[6].text = "Ammo on Kill"
	mod_data.options_widgets[2].sub_widgets[6].tooltip = "Shows floating ammo numbers when receiving ammo on kill in chat."
end
return mod_data