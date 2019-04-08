local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension

	Option file.

	author: grasmann
--]]

-- Everything here is optional. You can remove unused parts.
return {
	name = "Scoreboard Extension",                  -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = true,                            -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
		widgets = {                             	-- Widget settings for the mod options menu
			{
				setting_id = "extend",
				type = "numeric",
				range = {11, 16},
				unit_text = "unit_text_empty",
				decimals_number = 0,
				default_value = 16,
			},
			{
				setting_id = "autoscroll",
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = "direction",
						type = "dropdown",
						options = {
							{text = "direction_option_top_to_bottom_text", value = "top_to_bottom"},
							{text = "direction_option_bottom_to_top_text", value = "bottom_to_top"},
						},
						default_value = "top_to_bottom",
					},
					{
						setting_id = "initial_time",
						type = "numeric",
						range = {1, 10},
						unit_text = "unit_text_second",
						decimals_number = 0,
						default_value = 2,
					},
					{
						setting_id = "loop",
						type = "checkbox",
						default_value = true,
						sub_widgets = {
							{
								setting_id = "loop_time",
								type = "numeric",
								range = {1, 10},
								unit_text = "unit_text_second",
								decimals_number = 0,
								default_value = 2,
							},
						},
					},
				},
			},
			{
				setting_id = "network_sync",
				type = "checkbox",
				default_value = true,
			},
		},
	},
}