local ret = {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/third_person_equipment/third_person_equipment",
			mod_data         = "scripts/mods/third_person_equipment/third_person_equipment_data",
			mod_localization = "scripts/mods/third_person_equipment/third_person_equipment_localization"
		}
  	new_mod("ThirdPersonEquipment", mod_resources)
	end,
	packages = {
		"resource_packages/third_person_equipment/third_person_equipment"
	},
}
return ret