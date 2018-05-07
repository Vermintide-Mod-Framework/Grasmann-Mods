local ret = {
	run = function()
		local mod = new_mod("AllReady")
		mod:initialize("scripts/mods/all_ready/all_ready")
	end,
	packages = {
		"resource_packages/all_ready/all_ready"
	},
}
return ret