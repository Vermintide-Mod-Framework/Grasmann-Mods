local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension
	
--]]

-- Everything here is optional. You can remove unused parts.
return {
	name = "scoreboard_extension",                  -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = true,                            -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
		widgets = {                             	-- Widget settings for the mod options menu
			-- {
			-- 	setting_name = "win",
			-- 	widget_type = "keybind",
			-- 	keybind_trigger = "pressed",
			-- 	keybind_type = "function_call",
			-- 	function_name = "whatever",
			-- 	default_value = {},
			-- },
		},
	},
}