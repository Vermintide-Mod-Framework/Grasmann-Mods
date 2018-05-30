local mod = get_mod("AllReady")

local mod_data = {}
mod_data.name = "All Ready" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {}

return mod_data