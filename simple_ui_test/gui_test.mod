local ret = {
	run = function()
		local mod_resources = {
			mod_script = "scripts/mods/gui_test/gui_test",
		}
		new_mod("gui_test", mod_resources)
	end,
	packages = {
		"resource_packages/gui_test/gui_test"
	},
}
return ret