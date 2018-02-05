local ret = {
	run = function()
		local mod = new_mod("MoreRatWeapons")
		mod:dofile("scripts/mods/more_rat_weapons/more_rat_weapons_def")
		mod:dofile("scripts/mods/more_rat_weapons/more_rat_weapons")
	end,
	packages = {
		"resource_packages/more_rat_weapons/more_rat_weapons"
	},
}
return ret