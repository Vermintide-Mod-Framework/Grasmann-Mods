print("healthbars mod loading")

local ret = {
	run = function()
		dofile "healthbars"
	end,
	packages = {
		"resource_packages/thirdperson_zzzz"
	},
}
return ret