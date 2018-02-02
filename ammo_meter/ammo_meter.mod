local ret = {
	run = function()
		local mod = new_mod("AmmoMeter")
		mod:dofile("scripts/mods/ammo_meter/ammo_meter")
	end,
	packages = {
		"resource_packages/mods/ammo_meter/ammo_meter"
	},
}
return ret