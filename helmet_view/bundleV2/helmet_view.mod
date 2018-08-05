return {
	run = function()
		fassert(rawget(_G, "new_mod"), "helmet_view must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("helmet_view", {
			mod_script       = "scripts/mods/helmet_view/helmet_view",
			mod_data         = "scripts/mods/helmet_view/helmet_view_data",
			mod_localization = "scripts/mods/helmet_view/helmet_view_localization"
		})
	end,
	packages = {
		"resource_packages/helmet_view/helmet_view"
	}
}
