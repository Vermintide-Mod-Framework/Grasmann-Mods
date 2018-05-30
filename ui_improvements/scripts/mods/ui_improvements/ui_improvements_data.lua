local mod = get_mod("ui_improvements")

return {
	name = "UI Improvements",               -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = true,            -- If the mod can be enabled/disabled
	is_mutator = false,             -- If the mod is mutator
	mutator_settings = {},          -- Extra settings, if it's mutator
	options_widgets = {},
}