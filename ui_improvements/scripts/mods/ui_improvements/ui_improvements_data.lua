local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Data script for UI Improvements
--]]

return {
	name = "UI Improvements",
	description = "mod_description",
	is_togglable = true,
	is_mutator = false,
	mutator_settings = {},
	custom_gui_textures = {
		textures = {
			"menu_frame_09_divider_middle",
			"icon_bg_exotic_2",
		},
		atlases = {},
		ui_renderer_injections = {
			{
				"ingame_ui",
				"materials/ui_improvements/menu_frame_09_divider_middle",
				"materials/ui_improvements/icon_bg_exotic_2",
			},
		},
	},
	options = {
		widgets = {
			{
				setting_id = "crafting_buttons",
				type = "checkbox",
				title = "crafting_buttons_text",
				["tooltip"] = "crafting_buttons_tip",
				["default_value"] = true,
			},
			{
				setting_id = "remember_categories",
				type = "checkbox",
				title = "remember_opened_text",
				["tooltip"] = "remember_opened_tip",
				["default_value"] = true,
			},
			{
				setting_id = "alternative_exotic_background",
				type = "checkbox",
				title = "alternative_exotic_background_text",
				["tooltip"] = "alternative_exotic_background_tip",
				["default_value"] = true,
			},
			-- {
			-- 	setting_id = "salvage_pages",
			-- 	type = "checkbox",
			-- 	["text"] = "salvage_pages_text",
			-- 	["tooltip"] = "salvage_pages_tip",
			-- 	["default_value"] = true,
			-- },
		},
	}
}