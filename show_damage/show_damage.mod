local ret = {
	run = function()
		local mod = new_mod("ShowDamage")
		mod:dofile("scripts/mods/show_damage/show_damage")
	end,
	packages = {
		"resource_packages/show_damage/show_damage"
	},
}
return ret