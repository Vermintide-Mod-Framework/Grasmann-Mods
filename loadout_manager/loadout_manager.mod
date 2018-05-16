local ret = {
	run = function()
		local mod = new_mod("LoadoutManager")
		mod:initialize("scripts/mods/loadout_manager/loadout_manager")
	end,
	packages = {
		"resource_packages/loadout_manager/loadout_manager"
	},
}
return ret