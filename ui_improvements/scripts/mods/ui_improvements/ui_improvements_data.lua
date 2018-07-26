local mod = get_mod("ui_improvements")

return {
	name = "UI Improvements",               -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = true,            -- If the mod can be enabled/disabled
	is_mutator = false,             -- If the mod is mutator
	custom_gui_textures = {
		textures = {
			"menu_frame_09_divider_middle",
		},
		ui_renderer_injections = {
			"ingame_ui",
        
        	"materials/ui_improvements/menu_frame_09_divider_middle",
		},
	},
	mutator_settings = {},          -- Extra settings, if it's mutator
	options_widgets = {
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