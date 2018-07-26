local mod = get_mod("ui_improvements")

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
			["text"] = "Open Okri's Challenges",
			["tooltip"] = "Press to open Okri's Challenges book.",
			["default_value"] = {"o"},
			["action"] = "open_achievements",
		},
		{
			["setting_name"] = "crafting_buttons",
			["widget_type"] = "checkbox",
			["text"] = "Crafting Buttons",
			["tooltip"] = "Replaces crafting descriptions with seperate buttons for every crafting recipe.",
			["default_value"] = true,
		},
		{
			["setting_name"] = "remember_categories",
			["widget_type"] = "checkbox",
			["text"] = "Remember Opened Categories",
			["tooltip"] = "Remember inventory / crafting / cosmetics categories and reopen them when menu reloads.",
			["default_value"] = true,
		},
	},
}