print("ThirdPersonEquipment Mod Loading")

local ret = {
	run = function()
		dofile "thirdpersonequipment_def"
		dofile "thirdpersonequipment"
	end,
	packages = {
		"resource_packages/thirdperson_zzzzzzz"
	},
}
return ret