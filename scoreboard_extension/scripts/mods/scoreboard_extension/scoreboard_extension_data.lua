local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension

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
				setting_id = "autoscroll",
				type = "checkbox",
				default_value = true,
			},
		},
	},
}