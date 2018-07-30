local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Data script for UI Improvements

	Version: 1.5.1
--]]

return {
	name = "UI Improvements",
	description = mod:localize("mod_description"),
	is_togglable = true,
	is_mutator = false,
	mutator_settings = {},
	custom_gui_textures = {
		textures = {
			"menu_frame_09_divider_middle",
		},
		atlases = {},
		ui_renderer_injections = {
			{
				"ingame_ui",
        		"materials/ui_improvements/menu_frame_09_divider_middle",
			},
		},
	},
	options_widgets = {
		{
			["setting_name"] = "open_achievements",
			["widget_type"] = "keybind",
			["text"] = mod:localize("open_achievements_text"),
			["tooltip"] = mod:localize("open_achievements_tip"),
			["default_value"] = {"o"},
			["action"] = "open_achievements",
		},
		{
			["setting_name"] = "crafting_buttons",
			["widget_type"] = "checkbox",
			["text"] = mod:localize("crafting_buttons_text"),
			["tooltip"] = mod:localize("crafting_buttons_tip"),
			["default_value"] = true,
		},
		{
			["setting_name"] = "remember_categories",
			["widget_type"] = "checkbox",
			["text"] = mod:localize("remember_opened_text"),
			["tooltip"] = mod:localize("remember_opened_tip"),
			["default_value"] = true,
		},
	},
}