local ret = {
	run = function()
		local mod = new_mod("HeatIndicator")
		mod:dofile("scripts/mods/heat_indicator/heat_indicator")
	end,
	packages = {
		"resource_packages/heat_indicator/heat_indicator"
	},
}
return ret