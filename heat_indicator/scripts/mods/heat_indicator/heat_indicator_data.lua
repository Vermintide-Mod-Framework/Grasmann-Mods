local mod = get_mod("HeatIndicator")

local mod_data = {}
mod_data.name = "Heat Indicator" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "mode",
		["widget_type"] = "dropdown",
		["text"] = "Mode",
		["tooltip"] = "Change display mode",
		["options"] = {
			{--[[1]] text = "Rectangle", value = 1},
			{--[[3]] text = "Line", value = 2},
		},
		["default_value"] = 2,
		["sub_widgets"] = {
			{
				["show_widget_condition"] = {3},
				["setting_name"] = "line_size",
				["widget_type"] = "numeric",
				["text"] = "Size",
				["unit_text"] = "",
				["tooltip"] = "Length of the charge indicator.",
				["range"] = {0.1, 0.9},
				["decimals_number"] = 1,
				["default_value"] = 0.3
			},
		},
	},
}

return mod_data