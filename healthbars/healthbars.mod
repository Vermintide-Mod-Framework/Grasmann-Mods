local ret = {
	run = function()
		local mod = new_mod("Healthbars")
		mod:initialize("scripts/mods/healthbars/healthbars")
	end,
	packages = {
		"resource_packages/healthbars/healthbars"
	},
}
return ret