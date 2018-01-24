print("moreratweapons mod loading")

local ret = {
	run = function()
		dofile "moreratweapons_def"
		dofile "moreratweapons"
	end,
	packages = {
		"resource_packages/thirdperson_zzzzzz"
	},
}
return ret