local ret = {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/third_person/third_person",
			mod_data         = "scripts/mods/third_person/third_person_data",
			mod_localization = "scripts/mods/third_person/third_person_localization"
		}
  	new_mod("ThirdPerson", mod_resources)
	end,
	packages = {
		"resource_packages/third_person/third_person"
	},
}
return ret