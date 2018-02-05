local ret = {
	run = function()
		local mod = new_mod("GodMode")
		mod:dofile("scripts/mods/god_mode/god_mode")
	end,
	packages = {
		"resource_packages/god_mode/god_mode"
	},
}
return ret