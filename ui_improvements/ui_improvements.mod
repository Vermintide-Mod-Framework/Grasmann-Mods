return {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/ui_improvements/ui_improvements",
			mod_data         = "scripts/mods/ui_improvements/ui_improvements_data",
			mod_localization = "scripts/mods/ui_improvements/ui_improvements_localization"
		}
		new_mod("ui_improvements", mod_resources)
	end,
	packages = {
		"resource_packages/ui_improvements/ui_improvements"
	}
}
