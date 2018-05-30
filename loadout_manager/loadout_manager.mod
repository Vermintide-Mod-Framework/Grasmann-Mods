local ret = {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/loadout_manager/loadout_manager",
			mod_data         = "scripts/mods/loadout_manager/loadout_manager_data",
			mod_localization = "scripts/mods/loadout_manager/loadout_manager_localization"
		}
		new_mod("LoadoutManager", mod_resources)
	end,
	packages = {
		"resource_packages/loadout_manager/loadout_manager"
	},
}
return ret