local ret = {
	run = function()
		local mod = new_mod("ThirdPerson")
		mod:dofile("scripts/mods/third_person/third_person")
	end,
	packages = {
		"resource_packages/third_person/third_person"
	},
}
return ret