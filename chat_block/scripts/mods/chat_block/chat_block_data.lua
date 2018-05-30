local mod = get_mod("ChatBlock")

local mod_data = {}
mod_data.name = "Chat Block" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "mode",
		["widget_type"] = "dropdown",
		["text"] = "Mode",
		["tooltip"] = "Automatically block when you're chatting.\n\n"..
			"Your block will still break if your stamina runs out.\n\n"..
			"-- ANIMATION --\n"..
			"Blocking animation will play, works only with melee weapons.\n\n"..
			"-- ANIMATION AND PUSH --\n"..
			"You will also push when closing the chat window.",
		["options"] = {
			{text = "Animation", value = "animation"},
			{text = "Animation and Push", value = "animation_push"},
		},
		["default_value"] = "animation",
	},
}

return mod_data