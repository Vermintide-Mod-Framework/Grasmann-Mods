local ret = {
	run = function()
		local mod = new_mod("Healthbars")
		mod:dofile("scripts/mods/healthbars/healthbars")
	end,
	packages = {
		"resource_packages/mods/healthbars/healthbars"
	},
}
return ret