local mod = get_mod("ThirdPersonEquipment")
--[[
	Third person equipment
		- Shows equipped items on characters
		- Works with player and bots

	Author: grasmann
--]]

-- Global to keep track of spawned units
third_person_equipment_spawned_items = third_person_equipment_spawned_items or {}
mod:dofile("scripts/mods/third_person_equipment/third_person_equipment_def")

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
	--packs = {},
}

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
	if third_person_equipment_spawned_items then
		for _, unit in pairs(third_person_equipment_spawned_items) do
			if unit ~= nil and Unit.alive(unit) then
				local world = Managers.world:world("level_world")
				World.destroy_unit(world, unit)
			end
		end
		third_person_equipment_spawned_items = {}
		self.current.equipment = {}
	end
end
--[[
	Delete specific i_unit
--]]
mod.delete_i_unit = function(self, i_unit)
	if i_unit.right ~= nil then
		third_person_equipment_spawned_items[i_unit.right] = nil
		if Unit.alive(i_unit.right) then
			local world = Managers.world:world("level_world")
			World.destroy_unit(world, i_unit.right)
		end
	end
	if i_unit.left ~= nil then
		third_person_equipment_spawned_items[i_unit.left] = nil
		if Unit.alive(i_unit.left) then
			local world = Managers.world:world("level_world")
			World.destroy_unit(world, i_unit.left)
		end
	end
end
--[[
	Delete spawned units for specific character
--]]
mod.delete_units = function(self, unit)
	if self.current.equipment[unit] then
		--self:echo("Deleting equipment for player '"..tostring(unit).."' ...")
		for _, i_unit in pairs(self.current.equipment[unit]) do
			self:delete_i_unit(i_unit)
		end
		self.current.equipment[unit] = nil
	end
end
mod.delete_slot = function(self, unit, slot_name)
	if self.current.equipment[unit] then
		for ind = #self.current.equipment[unit], 1, -1 do
			local i_unit = self.current.equipment[unit][ind]
			if i_unit.slot == slot_name then
				self:delete_i_unit(i_unit)
			end
		end

		-- for _, i_unit in pairs(self.current.equipment[unit]) do
		-- 	if i_unit.slot == slot_name then
		-- 		self:delete_i_unit(i_unit)
		-- 	end
		-- end
	end
end
--[[
	Spawn equipment unit
--]]
mod.spawn = function(self, package_name, unit, item_setting, item_data)
	local s_unit = nil
	--if Unit.has_node(unit, item_setting.node) then
		local world = Managers.world:world("level_world")
		-- local node = Unit.node(unit, item_setting.node)
		-- local attachment = item_setting.attachment or nil

		-- local unit_attachments = Unit.get_data(unit, "flow_unit_attachments")
		-- mod:echo("unit_attachments: "..tostring(#unit_attachments))
		-- local attachment_unit = attachment and unit_attachments[attachment]
		-- local bones = attachment_unit and Unit.bones(attachment_unit)
		-- if bones then
		-- 	mod:echo("bones: "..tostring(#bones))
		-- end
		
		s_unit = World.spawn_unit(world, package_name)
		third_person_equipment_spawned_items[s_unit] = s_unit
		self:link_unit(unit, s_unit, item_setting)

		-- if not attachment or not attachment_unit then
		-- 	s_unit = World.spawn_unit(world, package_name)
		-- 	World.link_unit(world, s_unit, unit, node)
		-- 	third_person_equipment_spawned_items[s_unit] = s_unit
		-- else
		-- 	mod:pcall(function()
		-- 	s_unit = World.spawn_unit(world, package_name)
		-- 	World.link_unit(world, s_unit, attachment_unit, item_setting.attachment_node)
		-- 	third_person_equipment_spawned_items[s_unit] = s_unit
		-- 	end)
		-- end

		-- local i_pos = item_setting.position
		-- local pos_offset = i_pos ~= nil and Vector3(i_pos[1], i_pos[2], i_pos[3]) or Vector3(0,0,0)
		-- Unit.set_local_position(s_unit, 0, pos_offset)

		-- local i_rot = item_setting.rotation
		-- local rot_offset = i_rot ~= nil and Vector3(i_rot[1], i_rot[2], i_rot[3]) or Vector3(0,0,0)
		-- local rotation = Quaternion.from_euler_angles_xyz(rot_offset[1], rot_offset[2], rot_offset[3])
		-- Unit.set_local_rotation(s_unit, 0, rotation)

		-- Hardcoded scaling
		local grim = "units/weapons/player/wpn_grimoire_01/wpn_grimoire_01_3p"
		local tome = "units/weapons/player/wpn_side_objective_tome/wpn_side_objective_tome_01_3p"
		if package_name == grim or package_name == tome then
			Unit.set_local_scale(s_unit, 0, Vector3(0.75, 0.75, 0.75))
		end

		-- Option scaling
		local scaling = self:get("downscale_big_weapons") / 100
		if table.contains(self.definitions.big_weapons, tostring(item_data.item_type)) then
			local scale = Vector3(scaling, scaling, scaling)
			Unit.set_local_scale(s_unit, 0, scale)
		end
	--end

	return s_unit
end

mod.link_unit = function(self, unit, s_unit, item_setting)
	local attachment = item_setting.attachment or nil
	local world = Managers.world:world("level_world")

	if attachment then

		local unit_attachments = Unit.get_data(unit, "flow_unit_attachments")
		if item_setting.test then mod:echo("unit_attachments: "..tostring(#unit_attachments)) end
		local attachment_unit = attachment and unit_attachments[attachment]
		local bones = attachment_unit and Unit.bones(attachment_unit)
		if bones then
			if item_setting.test then mod:echo("bones: "..tostring(#bones)) end
		end

		if item_setting.test then
			World.link_unit(world, s_unit, attachment_unit, mod.used_index)
		else
			World.link_unit(world, s_unit, attachment_unit, item_setting.attachment_node)
		end
		

	elseif Unit.has_node(unit, item_setting.node) then

		local node = Unit.node(unit, item_setting.node)
		World.link_unit(world, s_unit, unit, node)

	-- else
	-- 	mod:echo("Node = '"..tostring(item_setting.node).."'")
	end

	local i_pos = item_setting.position
	local pos_offset = i_pos ~= nil and Vector3(i_pos[1], i_pos[2], i_pos[3]) or Vector3(0,0,0)
	Unit.set_local_position(s_unit, 0, pos_offset)

	local i_rot = item_setting.rotation
	local rot_offset = i_rot ~= nil and Vector3(i_rot[1], i_rot[2], i_rot[3]) or Vector3(0,0,0)
	local rotation = Quaternion.from_euler_angles_xyz(rot_offset[1], rot_offset[2], rot_offset[3])
	Unit.set_local_rotation(s_unit, 0, rotation)

end

--[[
	Spawn single equipment unit
--]]
mod.get_item_setting = function(self, unit, slot_name, item_data, left, skin)
	local def = self.definitions
	local item_setting = nil

	-- ####### Fixes and options #######
	if slot_name == "slot_melee" or slot_name == "slot_ranged" then
		--self:echo(tostring(item_data.item_type))
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
		local profile_name = self.current.profile[unit] or nil
		if profile_name then
			local key = def[item_data.key] and item_data.key or def[item_data.item_type] and item_data.item_type
			mod:echo(tostring(key))
			mod:dump(item_data, "item_data", 1)
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
		local career_extension = ScriptUnit.extension(unit, "career_system")
		local career_name = career_extension._career_data.name

		item_setting = item_setting[career_name] or item_setting

		if career_name == "dr_slayer" then

			-- Dual axes
			if item_data.item_type == "dr_dual_axes" then
				local something_replaced = false
				if self.current.equipment[unit] then
					for _, i_unit in pairs(self.current.equipment[unit]) do
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
				if self.current.equipment[unit] then
					for _, i_unit in pairs(self.current.equipment[unit]) do
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
			local career_extension = ScriptUnit.extension(unit, "career_system")
			local career_name = career_extension._career_data.name
	
			item_setting = item_setting[career_name] or item_setting
		end
	end

	-- Skin
	if skin then
		item_setting = item_setting[skin] or item_setting
	end

	return item_setting, replaced
end
--[[
	Add single equipment item
--]]
mod.add_item = function(self, unit, slot_name, item_data, skin)
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)

	local career_name = nil
	if not VT1 then
		local career_extension = ScriptUnit.extension(unit, "career_system")
		career_name = career_extension._career_data.name
	end

	if self.definitions[item_data.item_type] ~= nil then
		local right, left, right_pack, left_pack = nil
		local replaced = nil
		local material_settings = nil
		if item_data.right_hand_unit ~= nil then
			local item_setting, replace = self:get_item_setting(unit, slot_name, item_data, nil, skin)
			replaced = replace

			if not VT1 and career_name then
				item_setting = item_setting[career_name] or item_setting
			end

			if VT1 then
				right_pack = item_data.right_hand_unit.."_3p"
			else
				right_pack = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and
					WeaponSkins.skins[equipment.slots[slot_name].skin].right_hand_unit.."_3p"

				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				local weapon_data = inventory_extension:get_slot_data(slot_name)
				material_settings = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and
					WeaponSkins.skins[equipment.slots[slot_name].skin].material_settings

				right_pack = right_pack or item_data.right_hand_unit.."_3p"
			end

			if right_pack then
				right = self:spawn(right_pack, unit, item_setting, item_data)
				if right and material_settings then
					GearUtils.apply_material_settings(right, material_settings)
				end	
			end
		end
		
		material_settings = nil
		if item_data.left_hand_unit ~= nil then
			local item_setting, replace = self:get_item_setting(unit, slot_name, item_data, true, skin)
			replaced = replace

			if not VT1 and career_name then
				item_setting = item_setting[career_name] or item_setting
			end

			if VT1 then
				left_pack = item_data.left_hand_unit.."_3p"
			else
				left_pack = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and
					WeaponSkins.skins[equipment.slots[slot_name].skin].left_hand_unit.."_3p"

				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				local weapon_data = inventory_extension:get_slot_data(slot_name)
				material_settings = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and
					WeaponSkins.skins[equipment.slots[slot_name].skin].material_settings

				left_pack = left_pack or item_data.left_hand_unit.."_3p"
			end

			if left_pack then
				left = self:spawn(left_pack, unit, item_setting, item_data)
				if left and material_settings then
					GearUtils.apply_material_settings(left, material_settings)
				end	
			end
		end

		self.current.equipment[unit] = self.current.equipment[unit] or {}
		self.current.equipment[unit][#self.current.equipment[unit]+1] = {
			right = right,
			left = left,
			slot = slot_name,
			right_pack = right_pack,
			left_pack = left_pack,
			replaced = replaced,
			item_type = item_data.item_type,
		}
	elseif item_data.item_type ~= nil and item_data.item_type ~= "inventory_item" then
		--self:echo(tostring(item_data.item_type).." is missing!")
	end
end
--[[
	Spawn all equipment units for a character
--]]
mod.add_all_items = function(self, unit)
	if not self.current.equipment[unit] then
		--mod:echo("SimpleInventoryExtension._spawn_attached_units")
		local slots_by_name = InventorySettings.slots_by_name
		local wieldable_slots = InventorySettings.slots_by_wield_input
		if ScriptUnit.has_extension(unit, "inventory_system") then
			--self:echo("Creating equipment for player '"..tostring(unit).."' ...")
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local equipment = inventory_extension.equipment(inventory_extension)
			local cosmetic_extension = ScriptUnit.extension(unit, "cosmetic_system")
			local skin = cosmetic_extension:get_equipped_skin().name
			--self:echo(skin)
			for name, slot in pairs(equipment.slots) do
				self:add_item(unit, name, slot.item_data, skin)
			end
			self.current.slot[unit] = self.current.slot[unit] or equipment.wielded_slot or "slot_melee"
		end
	end
end
--[[
	Check if packages are loaded
--]]
mod.is_not_loading = function(self)
	return (#Managers.package._queued_async_packages == 0 and #Managers.package._queue_order == 0)
end
--[[
	Set unit visibility
--]]
mod.set_equipment_visibility = function(self, unit, hide)
	if self.current.equipment[unit] then

		local player = Managers.player:local_player()
		if player and player.player_unit and unit == player.player_unit then
			hide = hide or self.current.firstperson
		-- 	self:set_equipment_visibility(unit, self.current.firstperson)
		-- else
		-- 	self:set_equipment_visibility(unit)
			--mod:echo("hide:"..tostring(hide))
		end

		--hide = hide or self.current.firstperson
		for _, equip in pairs(self.current.equipment[unit]) do
			-- mod:echo("Current slot:"..tostring(self.current.slot[unit]))
			-- mod:echo("Current slot:"..tostring(equip.visible))
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
mod.wield_equipment = function(self, unit, slot_name)
	self.current.slot[unit] = slot_name
	self:set_equipment_visibility(unit)
end
--[[
	Create items if needed
--]]
mod.create_items_if_needed = function(self)
	if Managers and Managers.state and Managers.state.network then
		local players = Managers.player:human_and_bot_players()
		for k, player in pairs(players) do
			if player then
				local player_unit = player.player_unit
				if player_unit ~= nil and not self.current.equipment[player_unit] then
					--self:echo("Trying to create equipment for player '"..tostring(player_unit).."' ...")
					local profile_synchronizer = Managers.state.network.profile_synchronizer
					local profile_index = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
					if profile_index ~= nil then
						self.current.profile[player_unit] = SPProfiles[profile_index].unit_name

						if ScriptUnit.has_extension(player_unit, "health_system") and ScriptUnit.has_extension(player_unit, "status_system") then
							local health_extension = ScriptUnit.extension(player_unit, "health_system")
							local status_extension = ScriptUnit.extension(player_unit, "status_system")
							local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
							if is_alive and self:is_not_loading() then
								self:add_all_items(player_unit)
								self:set_equipment_visibility(player_unit)
							end
						end
					end
				end
			end
		end
		-- First person
		-- local player = Managers.player:local_player()
		-- if player and player.player_unit then
		-- 	-- local first_person_extension = ScriptUnit.extension(player.player_unit, "first_person_system")
		-- 	-- if first_person_extension then
		-- 	-- 	mod:echo(tostring(first_person_extension.first_person_mode))
		-- 	-- 	mod:set_equipment_visibility(player.player_unit, first_person_extension.first_person_mode)
		-- 	-- end

		-- 	-- local third_person_mod = get_mod("ThirdPerson")
		-- 	-- local third_person = third_person_mod and not third_person_mod.firstperson or self:is_first_person_blocked(player.player_unit) or false
		-- 	if not mod.current.firstperson == not third_person then
		-- 		self:set_equipment_visibility(player.player_unit, not third_person)
		-- 		mod:echo(tostring(third_person))
		-- 		mod.current.firstperson = not third_person
		-- 	end
		-- end
	end
end
--[[
	Check if first person is blocked
--]]
mod.is_first_person_blocked = function(self, unit)
	local blocked = nil
	local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
	if state_system ~= nil then
		local state = state_system.state_machine.state_current
		blocked = blocked or state.name == "dead"
		blocked = blocked or state.name == "grabbed_by_pack_master"
		blocked = blocked or state.name == "inspecting"
		blocked = blocked or state.name == "interacting"
		blocked = blocked or state.name == "knocked_down"
		blocked = blocked or state.name == "leave_ledge_hanging_falling"
		blocked = blocked or state.name == "leave_ledge_hanging_pull_up"
		blocked = blocked or state.name == "ledge_hanging"
		blocked = blocked or state.name == "pounced_down"
		blocked = blocked or state.name == "waiting_for_assisted_respawn"
		blocked = blocked or state.name == "catapulted"
		blocked = blocked or state.name == "overcharge_exploding"
	end
	return blocked
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook_safe(PlayerUnitFirstPerson, "set_first_person_mode", function(self, active, override, ...)
	mod.current.firstperson = active
	mod:set_equipment_visibility(self.unit, active)
end)

--[[
	Wield equipment hooks
--]]
mod:hook_safe(SimpleInventoryExtension, "wield", function(self, slot_name)
	mod:wield_equipment(self._unit, slot_name)
end)
mod:hook_safe(SimpleHuskInventoryExtension, "wield", function(self, slot_name)
	mod:wield_equipment(self._unit, slot_name)
end)

--[[
	Despawn equipment
--]]
mod:hook_safe(SimpleInventoryExtension, "destroy_slot", function(self, slot_name, allow_destroy_weapon)
	mod:delete_units(self._unit)
end)
mod:hook_safe(SimpleInventoryExtension, "destroy", function(self)
	mod:delete_units(self._unit)
end)
mod:hook_safe(SimpleHuskInventoryExtension, "destroy_slot", function(self, slot_name)
	mod:delete_units(self._unit)
end)
mod:hook_safe(SimpleHuskInventoryExtension, "destroy", function(self)
	mod:delete_units(self._unit)
end)
mod:hook_safe(PlayerUnitHealthExtension, "die", function(self)
	mod:delete_units(self.unit)
end)

--[[
	Unloading packages
--]]
mod:hook(PackageManager, "unload", function(func, self, package_name, ...)
	for unit, equip in pairs(mod.current.equipment) do
		for _, i_unit in pairs(equip) do
			if i_unit.right_pack and i_unit.right_pack == package_name then mod:delete_units(unit) end
			if i_unit.left_pack and i_unit.left_pack == package_name then mod:delete_units(unit) end
		end
	end

	return func(self, package_name, ...)
end)
--[[
	Delete equipment on host character change in vt2
--]]
if not VT1 then
	-- mod:hook(PlayerManager, "rpc_to_client_spawn_player", function(func, ...)
	-- 	mod:delete_all_units()
	-- 	func(...)
	-- end)
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
				mod:delete_units(unit)
			end
		end
	end
	-- Dwarf one-handed weapons
	if setting_name == "dwarf_onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "dwarf_ranger" then
				mod:delete_units(unit)
			end
		end
	end
	-- Waywatcher dual weapons
	if setting_name == "waywatcher_dualweapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "way_watcher" then
				mod:delete_units(unit)
			end
		end
	end
	-- One-handed weapons
	if setting_name == "onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			mod:delete_units(unit)
		end
	end
	-- Downscale big weapons
	if setting_name == "downscale_big_weapons" then
		for unit, name in pairs(mod.current.profile) do
			mod:delete_units(unit)
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
	--mod:create_items_if_needed()
	-- local player = Managers.player:local_player()
	-- if player then
	-- 	-- local bones = Unit.bones(player.player_unit)
	-- 	-- for _, bone in pairs(bones) do
	-- 	-- 	mod:echo(bone)
	-- 	-- end
		
	-- 	-- mod:pcall(function()
	-- 	-- 	local actor_count = Unit.num_actors(player.player_unit)
	-- 	-- 	mod:echo(tostring(actor_count))
	-- 	-- 	for i = 1, actor_count do
	-- 	-- 		local actor = Unit.actor(player.player_unit, i)
	-- 	-- 		mod:echo(tostring(actor.node))
	-- 	-- 	end
	-- 	-- end)

	-- 	mod:echo(tostring(Unit.has_node(player.player_unit, "a_hanging_trophy_2")))

	-- end
end
--[[
	Mod update
--]]
mod.update = function(dt)
	if mod:is_enabled() then
		mod:create_items_if_needed()
	end
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:delete_all_units()