print("thirdperson mod loading")

local ret = {
	run = function()
		dofile "thirdperson"
	end,
	packages = {
		"resource_packages/thirdperson_zzzzz"
	},
}
return ret