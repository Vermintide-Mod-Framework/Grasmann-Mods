return {
	run = function()
		local mod = new_mod("ui_improvements")
		mod:localization("localization/ui_improvements")
		mod:initialize("scripts/mods/ui_improvements/ui_improvements")
	end,
	packages = {
		"resource_packages/ui_improvements/ui_improvements"
	}
}
