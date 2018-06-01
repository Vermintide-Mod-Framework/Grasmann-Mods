local ret = {
	run = function()
		fassert(rawget(_G, "new_mod"), "Simple UI Test mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
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