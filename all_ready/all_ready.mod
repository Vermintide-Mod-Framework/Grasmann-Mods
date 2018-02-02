local ret = {
	run = function()
		local mod = new_mod("AllReady")
		mod:dofile("scripts/mods/all_ready/all_ready")
	end,
	packages = {
		"resource_packages/mods/all_ready/all_ready"
	},
}
return ret