local ret = {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/show_damage/show_damage",
			mod_data         = "scripts/mods/show_damage/show_damage_data",
			mod_localization = "scripts/mods/show_damage/show_damage_localization"
		}
		new_mod("ShowDamage", mod_resources)
	end,
	packages = {
		"resource_packages/show_damage/show_damage"
	},
}
return ret