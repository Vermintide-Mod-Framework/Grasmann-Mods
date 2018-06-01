local ret = {
	run = function()
		fassert(rawget(_G, "new_mod"), "More Rat Weapons mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
		local mod_resources = {
			mod_script       = "scripts/mods/more_rat_weapons/more_rat_weapons",
			mod_data         = "scripts/mods/more_rat_weapons/more_rat_weapons_data",
			mod_localization = "scripts/mods/more_rat_weapons/more_rat_weapons_localization"
		}
		new_mod("MoreRatWeapons", mod_resources)
	end,
	packages = {
		"resource_packages/more_rat_weapons/more_rat_weapons"
	},
}
return ret