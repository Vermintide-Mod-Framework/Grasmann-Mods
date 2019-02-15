local mod = get_mod("ThirdPersonEquipment")
--[[
	Third person equipment
		- Shows equipped items on characters
		- Works with player and bots

	Author: grasmann
--]]

-- Load definitions
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_def")
-- Load extension
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_ext")

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.extensions = {}
mod.firstperson = true
mod.spawned_units = mod:persistent_table("spawned_units", {})

-- Test stuff
mod.used_index = 1
mod.change_index = function()
	mod.used_index = mod.used_index + 1
	mod:echo("used index = "..tostring(mod.used_index))
	-- mod:delete_all_units()
	-- mod:hook_all_inventories()
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Delete all spawned units
--]]
mod.delete_all_units = function(self)
	-- Let the extenstion delete units
	for _, extension in pairs(self.extensions) do
		extension:remove_all()
	end
	-- If units left over delete them here
	if #mod.spawned_units > 0 then
		local world = Managers.world:world("level_world")
		for _, unit in pairs(self.spawned_units) do
			if Unit.alive(unit) then
				World.destroy_unit(world, unit)
			end
		end
		mod.spawned_units = {}
	end
end
--[[
    Hook all player inventories
--]]
mod.hook_all_inventories = function(self)
    if Managers and Managers.state and Managers.state.network then
        local players = Managers.player:players()
        for _, player in pairs(players) do
            local inventory_extension = ScriptUnit.extension(player.player_unit, "inventory_system")
            inventory_extension.tpe_extension = ThirdPersonEquipmentExtension:new(inventory_extension, player)
            inventory_extension.tpe_extension:add_all()
        end
    end
end
--[[
    Get inventory extension of local player
--]]
mod.local_third_person_extension = function(self)
	for _, extension in pairs(self.extensions) do
		if extension:is_local_player() then
			return extension
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
    Changes between 1st and 3rd person
--]]
mod:hook_safe(PlayerUnitFirstPerson, "set_first_person_mode", function(self, active, override, ...)
	mod.firstperson = active
	local extension = mod:local_third_person_extension()
	if extension then
		extension:set_equipment_visibility()
	end
end)
--[[
    Hook inventory extensions on init
--]]
local init_inventory_extension = function(self, extension_init_context, unit, extension_init_data)
	self.tpe_extension = ThirdPersonEquipmentExtension:new(self, extension_init_data.player)
end
mod:hook_safe(SimpleInventoryExtension, "init", init_inventory_extension)
mod:hook_safe(SimpleHuskInventoryExtension, "init", init_inventory_extension)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Setting changed
--]]
mod.on_setting_changed = function(setting_name)
	-- Dwarf weapons
	if setting_name == "dwarf_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "dwarf_ranger" then
				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				inventory_extension.tpe_extension:reload()
			end
		end
	end
	-- Dwarf one-handed weapons
	if setting_name == "dwarf_onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "dwarf_ranger" then
				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				inventory_extension.tpe_extension:reload()
			end
		end
	end
	-- Waywatcher dual weapons
	if setting_name == "waywatcher_dualweapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "way_watcher" then
				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				inventory_extension.tpe_extension:reload()
			end
		end
	end
	-- One-handed weapons
	if setting_name == "onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			inventory_extension.tpe_extension:reload()
		end
	end
	-- Downscale big weapons
	if setting_name == "downscale_big_weapons" then
		for unit, name in pairs(mod.current.profile) do
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			inventory_extension.tpe_extension:reload()
		end
	end
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
	mod:delete_all_units()
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
	mod:hook_all_inventories()
end
--[[
	Mod update
--]]
mod.update = function(dt)
end
--[[
	On unload
--]]
mod.on_unload = function(exit_game)
	mod:delete_all_units()
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:delete_all_units()
mod:hook_all_inventories()