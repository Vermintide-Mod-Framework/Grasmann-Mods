local ret = {
	run = function()
		fassert(rawget(_G, "new_mod"), "Healthbars mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
		local mod_resources = {
			mod_script       = "scripts/mods/healthbars/healthbars",
			mod_data         = "scripts/mods/healthbars/healthbars_data",
			mod_localization = "scripts/mods/healthbars/healthbars_localization"
		}
		new_mod("Healthbars", mod_resources)
	end,
	packages = {
		"resource_packages/healthbars/healthbars"
	},
}
return ret