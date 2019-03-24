return {
	run = function()
		fassert(rawget(_G, "new_mod"), "i_dare_you must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("i_dare_you", {
			mod_script       = "scripts/mods/i_dare_you/i_dare_you",
			mod_data         = "scripts/mods/i_dare_you/i_dare_you_data",
			mod_localization = "scripts/mods/i_dare_you/i_dare_you_localization"
		})
	end,
	packages = {
		"resource_packages/i_dare_you/i_dare_you"
	}
}
