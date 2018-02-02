local ret = {
	run = function()
		local mod = new_mod("ThirdPersonEquipment")
		mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_def")
		mod:dofile("scripts/mods/third_person_equipment/third_person_equipment")
	end,
	packages = {
		"resource_packages/mods/third_person_equipment/third_person_equipment"
	},
}
return ret