return {
	run = function()
		fassert(rawget(_G, "new_mod"), "Simple UI mod must be lower than Vermintide Mod Framework in your launcher's load order.")
		
		local mod_resources = {
			mod_script       = "scripts/mods/basic_gui/basic_gui",
		}
		new_mod("BasicUI", mod_resources)
		local mod_resources = {
			mod_script       = "scripts/mods/gui/gui",
		}
		new_mod("SimpleUI", mod_resources)
	end,
	packages = {
		"resource_packages/gui/gui"
	},
}