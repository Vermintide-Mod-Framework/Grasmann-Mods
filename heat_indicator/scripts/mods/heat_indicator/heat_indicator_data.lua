local mod = get_mod("HeatIndicator")

local mod_data = {}
mod_data.name = "Heat Indicator" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options = {
	widgets = {
		{
			setting_id = "mode",
			type = "dropdown",
			["options"] = {
				{text = "mode_option_rect_text", value = 1},
				{text = "mode_option_line_text", value = 2, show_widgets = {1}},
			},
			["default_value"] = 2,
			["sub_widgets"] = {
				{
					setting_id = "line_size",
					type = "numeric",
					["unit_text"] = "unit_text_empty",
					["range"] = {0.1, 0.9},
					["decimals_number"] = 1,
					["default_value"] = 0.3
				},
			},
		},
	},
}

return mod_data