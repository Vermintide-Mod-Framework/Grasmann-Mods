return {
	run = function()
		fassert(rawget(_G, "new_mod"), "UI Improvements mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
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
