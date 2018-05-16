local ret = {
	run = function()
		local mod = new_mod("ThirdPersonEquipment")
		mod:initialize("scripts/mods/third_person_equipment/third_person_equipment")
	end,
	packages = {
		"resource_packages/third_person_equipment/third_person_equipment"
	},
}
return ret