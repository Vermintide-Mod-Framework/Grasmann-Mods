local ret = {
	run = function()
		local mod = new_mod("EnemySpawner")
		mod:dofile("scripts/mods/enemy_spawner/enemy_spawner")
	end,
	packages = {
		"resource_packages/enemy_spawner/enemy_spawner"
	},
}
return ret