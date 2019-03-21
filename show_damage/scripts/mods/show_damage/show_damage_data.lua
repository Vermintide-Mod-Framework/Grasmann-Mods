local mod = get_mod("ShowDamage")

local mod_data = {
	name = "Show Damage", -- Readable mod name
	description = mod:localize("mod_description"), -- Readable mod description
	is_togglable = true, -- If the mod can be enabled/disabled
	is_mutator = false, -- If the mod is mutator
	allow_rehooking = true,
	options = {
		widgets = {
			{
				setting_id = "chat_output",
				type = "checkbox",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						setting_id = "chat_damage",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{
								setting_id = "chat_damage_source",
								type = "dropdown",
								title = "source",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "chat_damage_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_damage_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_damage_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_damage_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
							{
								setting_id = "chat_mode",
								type = "dropdown",
								["options"] = {
									{text = "chat_mode_option_default_text", 	value = 2, show_widgets = {1, 2}},
									{text = "chat_mode_option_kills_text", 		value = 3, show_widgets = {1}},
									{text = "chat_mode_option_simple_text", 	value = 4},
								},
								["default_value"] = 2,
								["sub_widgets"] = {
									{ setting_id = "chat_hit_zone", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_kill", 	type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
					{
						setting_id = "chat_heal",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{
								setting_id = "chat_heal_source",
								type = "dropdown",
								title = "source",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "chat_heal_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_heal_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_heal_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_heal_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
					{
						setting_id = "chat_ammo",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{
								setting_id = "chat_ammo_source",
								type = "dropdown",
								title = "source",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "chat_ammo_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_ammo_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_ammo_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "chat_ammo_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
				},
			},
			{ 
				setting_id = "floating_numbers",
				type = "checkbox",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						setting_id = "floating_numbers_render",
						type = "dropdown",
						["options"] = {
							{text = "floating_numbers_render_option_normal_text", value = 1},
							{text = "floating_numbers_render_option_legacy_text", value = 2},
						},
						["default_value"] = 1,
					},
					{
						setting_id = "floating_numbers_size",
						type = "numeric",
						["unit_text"] = "unit_text_empty",
						["range"] = {0.5, 1.5},
						["decimals_number"] = 2,
						["default_value"] = 1,
					},
					{ setting_id = "floating_numbers_pop", type = "checkbox", ["default_value"] = false, },
					{ setting_id = "floating_numbers_fade", type = "checkbox", ["default_value"] = false, },
					{
						setting_id = "floating_damage_numbers",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{ setting_id = "floating_icons_headshot", type = "checkbox", ["default_value"] = false, },
							{ setting_id = "floating_icons_block", type = "checkbox", ["default_value"] = false, },
							{ setting_id = "floating_icons_poison", type = "checkbox", ["default_value"] = false, },
							{ setting_id = "floating_icons_burn", type = "checkbox", ["default_value"] = false, },
							{
								setting_id = "floating_numbers_source",
								type = "dropdown",
								title = "source",
								tooltip = "chat_damage_source_description",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "floating_numbers_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_numbers_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_numbers_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_numbers_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
					{
						setting_id = "floating_heal",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{ setting_id = "floating_icons_heal", type = "checkbox", ["default_value"] = false, },
							{
								setting_id = "floating_heal_source",
								type = "dropdown",
								title = "source",
								tooltip = "chat_heal_source_description",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "floating_heal_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_heal_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_heal_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_heal_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
					{
						setting_id = "floating_ammo",
						type = "checkbox",
						["default_value"] = false,
						["sub_widgets"] = {
							{ setting_id = "floating_icons_ammo", type = "checkbox", ["default_value"] = false, },
							{
								setting_id = "floating_ammo_source",
								type = "dropdown",
								title = "source",
								tooltip = "chat_ammo_source_description",
								["options"] = {
									{text = "source_option_me_text", 		value = 1},
									{text = "source_option_all_text", 		value = 2},
									{text = "source_option_custom_text", 	value = 3, show_widgets = {1, 2, 3, 4}},
								},
								["default_value"] = 1,
								["sub_widgets"] = {
									{ setting_id = "floating_ammo_player_1", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_ammo_player_2", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_ammo_player_3", type = "checkbox", ["default_value"] = false, },
									{ setting_id = "floating_ammo_player_4", type = "checkbox", ["default_value"] = false, },
								},
							},
						},
					},
				},
			},
			{
				setting_id = "toggle_suspension",
				type = "keybind",
				keybind_trigger = "pressed",
				keybind_type    = "mod_toggle",
				["default_value"] = {},
			},
		},
	},
}
if not VT1 then
	mod_data.options.widgets[#mod_data.options.widgets+1] = {
		setting_id = "disable_default_numbers",
		type = "checkbox",
		["default_value"] = false,
	}
	-- Overwrite chat text
	mod_data.options.widgets[1].sub_widgets[2].title = "heal_on_kill_text"
	mod_data.options.widgets[1].sub_widgets[2].tooltip = "heal_on_kill_description"
	mod_data.options.widgets[1].sub_widgets[3].title = "ammo_on_kill_text"
	mod_data.options.widgets[1].sub_widgets[3].tooltip = "ammo_on_kill_description"
	-- Overwrite floating text
	mod_data.options.widgets[2].sub_widgets[5].title = "heal_on_kill_text"
	mod_data.options.widgets[2].sub_widgets[5].tooltip = "heal_on_kill_description"
	mod_data.options.widgets[2].sub_widgets[6].title = "ammo_on_kill_text"
	mod_data.options.widgets[2].sub_widgets[6].tooltip = "ammo_on_kill_description"
end
return mod_data