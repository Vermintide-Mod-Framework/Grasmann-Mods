return {
	run = function()
		fassert(rawget(_G, "new_mod"), "scoreboard_extension must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("scoreboard_extension", {
			mod_script       = "scripts/mods/scoreboard_extension/scoreboard_extension",
			mod_data         = "scripts/mods/scoreboard_extension/scoreboard_extension_data",
			mod_localization = "scripts/mods/scoreboard_extension/scoreboard_extension_localization"
		})
	end,
	packages = {
		"resource_packages/scoreboard_extension/scoreboard_extension"
	}
}
