local mod = get_mod("ThirdPersonEquipment")
--[[
	Third person equipment
		- Shows equipped items on characters
		- Works with player and bots

	Author: grasmann
--]]

-- Global to keep track of spawned units
local spawned_units = mod:persistent_table("spawned_units", {})
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
mod.current = {
	slot = {},
	equipment = {},
	profile = {},
	firstperson = true,
}

-- Test stuff
mod.used_index = 1
mod.change_index = function()
	mod.used_index = mod.used_index + 1
	mod:echo("used index = "..tostring(mod.used_index))
	mod:delete_all_units()
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
	if spawned_units then
		local world = Managers.world:world("level_world")
		-- Iterate through spawned units and delete them directly
		for _, unit in pairs(spawned_units) do
			if unit ~= nil and Unit.alive(unit) then
				World.destroy_unit(world, unit)
			end
		end
		-- Set spawned units and equipment nil
		spawned_units = {}
		self.current.equipment = {}
	end
end
--[[
	Delete specific i_unit
--]]
mod.delete_item_unit = function(self, item_unit)
	local world = Managers.world:world("level_world")
	-- Delete both left and right unit
	if item_unit.right ~= nil then
		spawned_units[item_unit.right] = nil
		if Unit.alive(item_unit.right) then World.destroy_unit(world, item_unit.right) end
	end
	if item_unit.left ~= nil then
		spawned_units[item_unit.left] = nil
		if Unit.alive(item_unit.left) then World.destroy_unit(world, item_unit.left) end
	end
end
--[[
	Delete spawned units for specific character
--]]
mod.delete_units = function(self, tpe)
	if self.current.equipment[tpe.unit] then
		-- Iterate through equipment and delete everything
		for _, item_unit in pairs(self.current.equipment[tpe.unit]) do
			self:delete_item_unit(item_unit)
		end
		-- Set equipment nil
		self.current.equipment[tpe.unit] = nil
	end
end
--[[
	Delete specific slot for character
--]]
mod.delete_slot = function(self, tpe, slot_name)
	if self.current.equipment[tpe.unit] then
		-- Iterate through equipment
		for i = #self.current.equipment[tpe.unit], 1, -1 do
			local item_unit = self.current.equipment[tpe.unit][i]
			-- Check if slot fits
			if item_unit and item_unit.slot == slot_name then
				-- Delete unit
				self:delete_item_unit(item_unit)
				-- Set equipment nil
				self.current.equipment[tpe.unit][i] = nil
			end
		end
	end
end
--[[
	Spawn equipment unit
--]]
mod.spawn = function(self, tpe, package_name, item_setting, item_data)

	-- Spawn unit
	local world = Managers.world:world("level_world")
	local item_unit = World.spawn_unit(world, package_name)
	-- Add to spawned units
	spawned_units[item_unit] = item_unit
	-- Link unit
	self:link_unit(tpe, item_unit, item_setting)

	-- Hardcoded scaling
	local grim = "units/weapons/player/wpn_grimoire_01/wpn_grimoire_01_3p"
	local tome = "units/weapons/player/wpn_side_objective_tome/wpn_side_objective_tome_01_3p"
	if package_name == grim or package_name == tome then
		Unit.set_local_scale(item_unit, 0, Vector3(0.75, 0.75, 0.75))
	end

	-- Option scaling
	local scaling = self:get("downscale_big_weapons") / 100
	if table.contains(self.definitions.big_weapons, tostring(item_data.item_type)) then
		local scale = Vector3(scaling, scaling, scaling)
		Unit.set_local_scale(item_unit, 0, scale)
	end

	return item_unit
end
--[[
	Link equipment unit
--]]
mod.link_unit = function(self, tpe, item_unit, item_setting)
	local attachment = item_setting.attachment or nil
	local world = Managers.world:world("level_world")

	if attachment then
		-- Attach unit to attachment unit
		local unit_attachments = Unit.get_data(tpe.unit, "flow_unit_attachments")
		if item_setting.test then mod:echo("unit_attachments: "..tostring(#unit_attachments)) end
		local attachment_unit = attachment and unit_attachments[attachment]
		local bones = attachment_unit and Unit.bones(attachment_unit)
		if bones then
			if item_setting.test then mod:echo("bones: "..tostring(#bones)) end
		end
		if item_setting.test then
			World.link_unit(world, item_unit, attachment_unit, mod.used_index)
		else
			World.link_unit(world, item_unit, attachment_unit, item_setting.attachment_node)
		end
	elseif Unit.has_node(tpe.unit, item_setting.node) then
		-- Attach unit to node
		local node = Unit.node(tpe.unit, item_setting.node)
		World.link_unit(world, item_unit, tpe.unit, node)
	end

	-- Set position
	local item_position = item_setting.position
	local pos_offset = item_position ~= nil and Vector3(item_position[1], item_position[2], item_position[3]) or Vector3(0,0,0)
	Unit.set_local_position(item_unit, 0, pos_offset)

	-- Set rotation
	local item_rotation = item_setting.rotation
	local rotation_offset = item_rotation ~= nil and Vector3(item_rotation[1], item_rotation[2], item_rotation[3]) or Vector3(0,0,0)
	local rotation = Quaternion.from_euler_angles_xyz(rotation_offset[1], rotation_offset[2], rotation_offset[3])
	Unit.set_local_rotation(item_unit, 0, rotation)

end
--[[
	Spawn single equipment unit
--]]
mod.get_item_setting = function(self, tpe, slot_name, item_data, left)
	local def = self.definitions
	local item_setting = nil

	-- ####### Fixes and options #######
	if slot_name == "slot_melee" or slot_name == "slot_ranged" then
		
		-- Dwarf
		if table.contains(def.dwarf_weapons, item_data.item_type) then
			local dwarf_weapon_position = self:get("dwarf_weapon_position")
			local option_backpack = 1
			local option_back = 2
			if dwarf_weapon_position == option_backpack then
				if not left then
					item_setting = def[item_data.item_type].right.backpack
				else
					item_setting = def[item_data.item_type].left.backpack
				end
			elseif dwarf_weapon_position == option_back then
				if not left then
					item_setting = def[item_data.item_type].right.back
				else
					item_setting = def[item_data.item_type].left.back
				end
			end
		end

		-- One-Handed
		if table.contains(def.one_handed, item_data.item_type) then
			local dwarf_one_handed_weapon_position = self:get("dwarf_onehand_weapon_position")
			local option_d_belt = 2
			local option_d_back = 3
			local dwarf_weapon = table.contains(def.dwarf_weapons, item_data.item_type)
			local _1h_weapon_position = self:get("onehand_weapon_position")
			local option_belt = 1
			local option_back = 2
			if _1h_weapon_position == option_belt and not dwarf_weapon or dwarf_weapon and dwarf_one_handed_weapon_position == option_d_belt then
				if not left then
					item_setting = def[item_data.item_type].right.belt
				else
					item_setting = def[item_data.item_type].left.belt
				end
			elseif _1h_weapon_position == option_back and not dwarf_weapon or dwarf_weapon and dwarf_one_handed_weapon_position == option_d_back then
				if not left then
					item_setting = def[item_data.item_type].right.back
				else
					item_setting = def[item_data.item_type].left.back
				end
			end
		end

		-- Waywatcher
		if table.contains(def.waywatcher_dual, item_data.item_type) then
			local dwarf_weapon_position = self:get("waywatcher_dualweapon_position")
			local option_belt = 1
			local option_back = 2
			if dwarf_weapon_position == option_belt then
				if not left then
					item_setting = def[item_data.item_type].right.belt
				else
					item_setting = def[item_data.item_type].left.belt
				end
			elseif dwarf_weapon_position == option_back then
				if not left then
					item_setting = def[item_data.item_type].right.back
				else
					item_setting = def[item_data.item_type].left.back
				end
			end
		end

		-- Default
		if not left then
			item_setting = item_setting or def[item_data.item_type].right
		else
			item_setting = item_setting or def[item_data.item_type].left
		end

	else
		local profile_name = self.current.profile[tpe.unit] or nil
		if profile_name then
			local key = def[item_data.key] and item_data.key or def[item_data.item_type] and item_data.item_type
			-- mod:echo(tostring(key))
			-- mod:dump(item_data, "item_data", 1)
			if not left then
				item_setting = profile_name and def[key][profile_name] and def[key][profile_name].right
				item_setting = item_setting or def[key] and def[key].right
			else
				item_setting = profile_name and def[key][profile_name] and def[key][profile_name].left
				item_setting = item_setting or def[key] and def[key].left
			end
		end
	end
	--end)

	-- Default values
	if not left then
		item_setting = item_setting or def.default.right
	else
		item_setting = item_setting or def.default.left
	end

	local replaced = false
	if not VT1 then
		-- local career_extension = ScriptUnit.extension(tpe.unit, "career_system")
		-- local career_name = career_extension._career_data.name
		local career_name = tpe:career_name()

		item_setting = item_setting[career_name] or item_setting

		if career_name == "dr_slayer" then

			-- Dual axes
			if item_data.item_type == "dr_dual_axes" or item_data.item_type == "dr_dual_wield_hammers" then
				local something_replaced = false
				if self.current.equipment[tpe.unit] then
					for _, i_unit in pairs(self.current.equipment[tpe.unit]) do
						if i_unit.replaced then
							something_replaced = true
							break
						end
					end
				end
				if not something_replaced then
					if item_setting.replace then
						if not left then
							item_setting = def[item_data.item_type].right[item_setting.replace]
						else
							item_setting = def[item_data.item_type].left[item_setting.replace]
						end
						item_setting = item_setting[career_name] or item_setting
						replaced = true
					end
				end

			-- Two handed
			elseif table.contains(def.dwarf_two_handed, item_data.item_type) then
				local another_two_handed = false
				if self.current.equipment[tpe.unit] then
					for _, i_unit in pairs(self.current.equipment[tpe.unit]) do
						if table.contains(def.dwarf_two_handed, i_unit.item_type) then
							another_two_handed = true
							break
						end
					end
				end
				if another_two_handed then
					if item_setting.replace then
						if not left then
							item_setting = def[item_data.item_type].right[item_setting.replace]
						else
							item_setting = def[item_data.item_type].left[item_setting.replace]
						end
						item_setting = item_setting[career_name] or item_setting
						replaced = true
					end
				end
			end
		end		
	end

	if item_setting.copy then
		if not left then
			item_setting = def[item_data.item_type].right[item_setting.copy]
		else
			item_setting = def[item_data.item_type].left[item_setting.copy]
		end

		if not VT1 then
			local career_extension = ScriptUnit.extension(tpe.unit, "career_system")
			local career_name = career_extension._career_data.name
	
			item_setting = item_setting[career_name] or item_setting
		end
	end

	-- Skin
	local skin = tpe:character_skin()
	if skin then
		item_setting = item_setting[skin] or item_setting
	end

	return item_setting, replaced
end
--[[
	Load equipment item
--]]
mod.load_item = function(self, tpe, slot_name, item_data, unit_name)
	local equipment = tpe.inventory_extension:equipment()
	local unit, package, replaced, material_settings = nil

	if item_data[unit_name] ~= nil then
		local item_setting, replace = self:get_item_setting(tpe, slot_name, item_data, unit_name == "left_hand_unit")
		replaced = replace

		if not VT1 and career_name then
			local career_name = tpe:career_name()
			item_setting = item_setting[career_name] or item_setting
		end

		if VT1 then
			package = item_data[unit_name].."_3p"
		else
			package = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and WeaponSkins.skins[equipment.slots[slot_name].skin][unit_name].."_3p"
			local inventory_extension = ScriptUnit.extension(tpe.unit, "inventory_system")
			local weapon_data = inventory_extension:get_slot_data(slot_name)
			material_settings = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and WeaponSkins.skins[equipment.slots[slot_name].skin].material_settings
			package = package or item_data[unit_name].."_3p"
		end

		if package then
			unit = self:spawn(tpe, package, item_setting, item_data)
			if unit and material_settings then
				GearUtils.apply_material_settings(unit, material_settings)
			end
			return unit, package, replaced
		end
	end
end
--[[
	Add single equipment item
--]]
mod.add_item = function(self, tpe, slot_name, item_data)
	if self.definitions[item_data.item_type] ~= nil then
		local right, right_pack, replaced_right = self:load_item(tpe, slot_name, item_data, "right_hand_unit")
		local left, left_pack, replaced_left = self:load_item(tpe, slot_name, item_data, "left_hand_unit")

		-- Add info to equipment
		self.current.equipment[tpe.unit] = self.current.equipment[tpe.unit] or {}
		self.current.equipment[tpe.unit][#self.current.equipment[tpe.unit]+1] = {
			right = right,
			left = left,
			slot = slot_name,
			right_pack = right_pack,
			left_pack = left_pack,
			replaced = replaced_right,
			item_type = item_data.item_type,
		}
		self.current.slot[tpe.unit] = self.current.slot[tpe.unit] or tpe.inventory_extension:equipment().wielded_slot or "slot_melee"
	elseif item_data.item_type ~= nil and item_data.item_type ~= "inventory_item" then
		self:echo(tostring(item_data.item_type).." is missing!")
	end
end
--[[
	Spawn all equipment units for a character
--]]
mod.add_all_items = function(self, tpe)
	if not self.current.equipment[tpe.unit] then
		local slots_by_name = InventorySettings.slots_by_name
		local wieldable_slots = InventorySettings.slots_by_wield_input
		for slot_name, slot in pairs(tpe.inventory_extension:equipment().slots) do
			self:add_item(tpe, slot_name, slot.item_data)
		end
	end
end
--[[
	Check if packages are loaded
--]]
-- mod.is_not_loading = function(self)
-- 	return (#Managers.package._queued_async_packages == 0 and #Managers.package._queue_order == 0)
-- end
--[[
	Set unit visibility
--]]
mod.set_equipment_visibility = function(self, unit, hide)
	if self.current.equipment[unit] then
		
		local player = Managers.player:local_player()
		if player and player.player_unit and unit == player.player_unit then
			hide = hide or self.current.firstperson
		end

		for _, equip in pairs(self.current.equipment[unit]) do
			if equip.slot == self.current.slot[unit] or hide then
				if equip.visible or equip.visible == nil then
					if equip.right ~= nil then
						Unit.set_unit_visibility(equip.right, false)
					end
					if equip.left ~= nil then
						Unit.set_unit_visibility(equip.left, false)
					end
					equip.visible = false
				end
			else
				if not equip.visible then
					if equip.right ~= nil then
						Unit.set_unit_visibility(equip.right, true)
						Unit.flow_event(equip.right, "lua_wield")
						Unit.flow_event(equip.right, "lua_unwield")
					end
					if equip.left ~= nil then
						Unit.set_unit_visibility(equip.left, true)
						Unit.flow_event(equip.left, "lua_wield")
						Unit.flow_event(equip.left, "lua_unwield")
					end
					equip.visible = true
				end
			end
		end
	end
end
--[[
	Execute wield
--]]
mod.wield_equipment = function(self, tpe, slot_name)
	self.current.slot[tpe.unit] = slot_name
	self:set_equipment_visibility(tpe.unit)
end
--[[
	Check if first person is blocked
--]]
-- mod.is_first_person_blocked = function(self, unit)
-- 	local blocked = nil
-- 	local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
-- 	if state_system ~= nil then
-- 		local state = state_system.state_machine.state_current
-- 		blocked = blocked or state.name == "dead"
-- 		blocked = blocked or state.name == "grabbed_by_pack_master"
-- 		blocked = blocked or state.name == "inspecting"
-- 		blocked = blocked or state.name == "interacting"
-- 		blocked = blocked or state.name == "knocked_down"
-- 		blocked = blocked or state.name == "leave_ledge_hanging_falling"
-- 		blocked = blocked or state.name == "leave_ledge_hanging_pull_up"
-- 		blocked = blocked or state.name == "ledge_hanging"
-- 		blocked = blocked or state.name == "pounced_down"
-- 		blocked = blocked or state.name == "waiting_for_assisted_respawn"
-- 		blocked = blocked or state.name == "catapulted"
-- 		blocked = blocked or state.name == "overcharge_exploding"
-- 	end
-- 	return blocked
-- end

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
	mod.current.firstperson = active
	mod:set_equipment_visibility(self.unit, active)
end)
--[[
    Hook inventory extensions on init
--]]
local init_inventory_extension = function(self)
	self.tpe_extension = ThirdPersonEquipmentExtension:new(self)
end
mod:hook_safe(SimpleInventoryExtension, "init", init_inventory_extension)
mod:hook_safe(SimpleHuskInventoryExtension, "init", init_inventory_extension)
--[[
    Hook all player inventories
--]]
mod.hook_all_inventories = function(self)
    if Managers and Managers.state and Managers.state.network then
        local players = Managers.player:players()
        for _, player in pairs(players) do
            local inventory_extension = ScriptUnit.extension(player.player_unit, "inventory_system")
            inventory_extension.tpe_extension = ThirdPersonEquipmentExtension:new(inventory_extension)
            inventory_extension.tpe_extension:add_all()
        end
    end
end

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