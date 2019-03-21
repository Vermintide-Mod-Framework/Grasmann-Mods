local mod = get_mod("ChatBlock")

return {
	name = "Chat Block",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id    = "mode",
				type          = "dropdown",
				default_value = "animation",
				options = {
					{text = "animation",          value = "animation"},
					{text = "animation_and_push", value = "animation_push"},
				},
			},
		},
	},
}