local directory_name = "gui"
local file_name = "gui"

print("'" ..file_name.. "' Mod loading...")

return {
	run = function()
		local mod = new_mod("basic_gui")
		mod:initialize("scripts/mods/basic_gui/basic_gui")
		local mod = new_mod("simple_ui")
		mod:initialize("scripts/mods/gui/gui")
	end,
	packages = {
		"resource_packages/" .. directory_name .. "/" .. file_name
	},
}