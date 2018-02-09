local mod = get_mod("EnemySpawner")
--[[ 
	Enemy Spawner
		- Lets you spawn enemies
	
	Author: IamLupo
	Ported: grasmann
	Version: 1.1.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "switch",
		["widget_type"] = "keybind",
		["text"] = "Switch",
		["tooltip"] = "Switch between enemies to spawn.",
		["default_value"] = {"o"},
		["action"] = "switch"
	},
	{
		["setting_name"] = "spawn",
		["widget_type"] = "keybind",
		["text"] = "Spawn",
		["tooltip"] = "Spawn chosen enemy.",
		["default_value"] = {"p"},
		["action"] = "spawn"
	},
	{
		["setting_name"] = "despawn",
		["widget_type"] = "keybind",
		["text"] = "Despawn",
		["tooltip"] = "Despawn all enemies.",
		["default_value"] = {"i"},
		["action"] = "despawn"
	},
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Despawn enemies
--]]
mod.despawn_enemies = function(self)
	if not self:is_suspended() then
		if Managers.player.is_server then
			Managers.state.conflict:destroy_all_units()
		else
			self:pcall(function()
				local unit_spawner = Managers.state.spawn.unit_spawner
				local units = unit_spawner.unit_storage.map_goid_to_unit
				for _, unit in pairs(units) do
					-- Check unit is a breed
					if Unit.has_data(unit, "breed") then
						-- Repeat damage to fully kill all enemies
						for x = 1, 10 do
							DamageUtils.add_damage_network(unit, unit, 200, "full", "burninating", Vector3(0, 0, 0), "bw_skullstaff_beam_0048", nil)
						end
					end
				end
			end)
		end
		self:echo("Removed all enemies")
	end
end
--[[
	Spawn enemy
--]]
mod.spawn_enemy = function(self)
	if not self:is_suspended() then
		if Managers.player.is_server then
			local conflict_director = Managers.state.conflict
			conflict_director:debug_spawn_breed(0)
			self:echo("Spawn: "..tostring(conflict_director._debug_breed))
		end
	end
end
--[[
	Switch enemy
--]]
mod.switch_enemy = function(self)
	if not self:is_suspended() then
		if Managers.player.is_server then
			local conflict_director = Managers.state.conflict
			conflict_director:debug_spawn_switch_breed(0)
			self:echo("Switch: "..tostring(conflict_director._debug_breed))
		end
	end
end
--[[
	Check breed
--]]
mod.check_breed = function(self, conflict_director)
	if Managers.state.game_mode._game_mode_key == "inn" then
		while conflict_director._debug_breed ~= "skaven_rat_ogre" and conflict_director._debug_breed ~= "skaven_grey_seer" do
			conflict_director._debug_breed = next(Breeds, conflict_director._debug_breed)
		end
	else
		if conflict_director._debug_breed == "skaven_stormfiend" then
			conflict_director._debug_breed = next(Breeds, conflict_director._debug_breed)
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Check breed
--]]
mod:hook("ConflictDirector.debug_spawn_switch_breed", function(func, self, ...)
	-- Call orginal function
	func(self, ...)
	-- My patch
	mod:check_breed(self)
end)
mod:hook("ConflictDirector.debug_spawn_breed", function(func, self, ...)
	-- My patch
	mod:check_breed(self)
	-- Call orginal function
	func(self, ...)
end)
--[[
	Patch spawn_unit:
		When a ogre spawns in the inn its missing level_settings.
		I initialize it before it spawns
--]]
mod:hook("ConflictDirector.spawn_unit", function(func, self, ...)
	if self.level_settings == nil then self.level_settings = {} end
	return func(self, ...) 
end)
mod:hook("LocomotionTemplates.AILocomotionExtensionC.update", function(func, ...)
	if Managers.state.game_mode._level_key ~= "inn_level" then
		func(...)
	end
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Suspended
--]]
mod.suspended = function()
	mod:disable_all_hooks()
end
--[[
	Mod Unsuspended
--]]
mod.unsuspended = function()
	mod:enable_all_hooks()
end

-- #####  █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ######################################################
-- ##### ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ######################################################
-- ##### ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ######################################################
-- ##### ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ######################################################
-- ##### ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ######################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ######################################################
--[[
	Despawn enemies
--]]
mod.despawn = function()
	mod:despawn_enemies()
end
--[[
	Spawn enemy
--]]
mod.spawn = function()
	mod:spawn_enemy()
end
--[[
	Switch enemy
--]]
mod.switch = function()
	mod:switch_enemy()
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
--[[
	Create option widgets
--]]
mod:create_options(options_widgets, true, "Enemy Spawner", "Lets you spawn enemies")
--[[
	Suspend mod if needed
--]]
if mod:is_suspended() then mod.suspended() end