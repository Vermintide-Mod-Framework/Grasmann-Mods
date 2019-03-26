local mod = get_mod("i_dare_you")

-- Everything here is optional. You can remove unused parts.
return {
	name = "I dare you!",                           -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = false,                           -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
		widgets = {                             -- Widget settings for the mod options menu
			{
				setting_id = "active",
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					-- {
					-- 	setting_id = "allow_self",
					-- 	type = "checkbox",
					-- 	default_value = false,
					-- },
					{
						setting_id = "mode",
						type = "dropdown",
						options = {
							{text = "mode_option_full_party_text", 	value = 1},
							{text = "mode_option_at_least_2_text", 	value = 2},
							{text = "mode_option_alone_text", 		value = 3},
						},
						default_value = 1,
					},
					-- {
					-- 	setting_id = "allow_inn",
					-- 	type = "checkbox",
					-- 	default_value = false,
					-- },
					{
						setting_id = "debug",
						type = "checkbox",
						default_value = false,
					},
					{
						setting_id = "activate_dare_1",
						type = "keybind",
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "activate_dare_1",
						default_value = {"f5"},
					},
					{
						setting_id = "activate_dare_2",
						type = "keybind",
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "activate_dare_2",
						default_value = {"f6"},
					},
					{
						setting_id = "activate_dare_3",
						type = "keybind",
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "activate_dare_3",
						default_value = {"f7"},
					},
				},
			},
		},
	},
}