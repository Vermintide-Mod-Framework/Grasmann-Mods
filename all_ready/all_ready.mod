local ret = {
	run = function()
		fassert(rawget(_G, "new_mod"), "All Ready mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
		local mod_resources = {
			mod_script       = "scripts/mods/all_ready/all_ready",
			mod_data         = "scripts/mods/all_ready/all_ready_data",
			mod_localization = "scripts/mods/all_ready/all_ready_localization"
		}
		new_mod("AllReady", mod_resources)
	end,
	packages = {
		"resource_packages/all_ready/all_ready"
	},
}
return ret