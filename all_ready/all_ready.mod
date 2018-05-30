local ret = {
	run = function()
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