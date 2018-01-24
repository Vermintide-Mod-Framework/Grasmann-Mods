local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment
		- Shows equipped items on characters
		- Works with player and bots
	Issues:
		- Doesn't work after game start right away
	
	Author: grasmann
	Version: 1.1.0
--]]

-- Global to keep track of spawned units
equipment_3p_spawned_items = equipment_3p_spawned_items or {}

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "dwarf_weapon_position",
		--["widget_type"] = "dropdown",
		["widget_type"] = "stepper",
		["text"] = "Dwarf Weapon Position",
		["tooltip"] =  "Dwarf Weapon Position\n" ..
			"Choose the position of the dwarf weapons.\n\n" ..
			"-- Backpack --\n" ..
			"Weapons will be placed on the backpack.\n\n" ..
			"-- Back --\n" ..
			"Weapons will be placed on the back.",
		["value_type"] = "number",
		["options"] = {
			{text = "Backpack", value = 1},
			{text = "Back", value = 2},
		},
		["default_value"] = 1,
	},
	{
		["setting_name"] = "dwarf_onehand_weapon_position",
		--["widget_type"] = "dropdown",
		["widget_type"] = "stepper",
		["text"] = "Dwarf One-Handed Weapon Position",
		["tooltip"] =  "Dwarf One-Handed Weapon Position\n" ..
			"Choose the position of the one-handed dwarf weapons.\n\n" ..
			"-- Default --\n" ..
			"Uses dwarf weapon position.\n\n" ..
			"-- Belt --\n" ..
			"Weapons will be placed on the belt.",
		["value_type"] = "number",
		["options"] = {
			{text = "Dwarf Weapon Position", value = 1},
			{text = "Belt", value = 2},
			{text = "Back", value = 3},
		},
		["default_value"] = 1,
	},
	{
		["setting_name"] = "waywatcher_dualweapon_position",
		--["widget_type"] = "dropdown",
		["widget_type"] = "stepper",
		["text"] = "Waywatcher Dual Weapon Position",
		["tooltip"] =  "Waywatcher Dual Weapon Position\n" ..
			"Choose the position of the waywatcher dual weapons.\n\n" ..
			"-- Belt --\n" ..
			"Weapons will be placed on the belt.\n\n" ..
			"-- Back --\n" ..
			"Weapons will be placed on the back.",
		["value_type"] = "number",
		["options"] = {
			{text = "Belt", value = 1},
			{text = "Back", value = 2},
		},
		["default_value"] = 1,
	},
	{
		["setting_name"] = "onehand_weapon_position",
		--["widget_type"] = "dropdown",
		["widget_type"] = "stepper",
		["text"] = "One-Handed Weapon Position",
		["tooltip"] =  "One-Handed Weapon Position\n" ..
			"Choose the position of the one-handed weapons.\n\n" ..
			"-- Belt --\n" ..
			"Weapons will be placed on the belt.\n\n" ..
			"-- Back --\n" ..
			"Weapons will be placed on the back.",
		["value_type"] = "number",
		["options"] = {
			{text = "Belt", value = 1},
			{text = "Back", value = 2},
		},
		["default_value"] = 1,
	},
	{
		["setting_name"] = "downscale_big_weapons",
		--["widget_type"] = "slider",
		["widget_type"] = "stepper",
		["text"] = "Downscale Big Weapons",
		["tooltip"] =  "Downscale Big Weapons\n" ..
			"Downscale the biggest weapons in the game.\n\n" ..
			"Affects: Red staffs, volley crossbow, wh crossbow",
		["value_type"] = "number",
		["options"] = {
			{text = "Off", value = 100},
			{text = "Slightly", value = 90},
			{text = "More", value = 75},
			{text = "Max", value = 50},
		},
		--["range"] = {50, 100},
		["default_value"] = 75,
	},
}

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
}
--mod.options = {}

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
	if equipment_3p_spawned_items then
		for _, unit in pairs(equipment_3p_spawned_items) do
			if unit ~= nil and Unit.alive(unit) then
				local world = Managers.world:world("level_world")
				World.destroy_unit(world, unit)
			end
		end
		equipment_3p_spawned_items = {}
		self.current.equipment = {}
	end
end
--[[
	Delete specific i_unit
--]]
mod.delete_i_unit = function(self, i_unit)
	if i_unit.right ~= nil then
		equipment_3p_spawned_items[i_unit.right] = nil
		if Unit.alive(i_unit.right) then
			local world = Managers.world:world("level_world")
			World.destroy_unit(world, i_unit.right)
		end
	end
	if i_unit.left ~= nil then
		equipment_3p_spawned_items[i_unit.left] = nil
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
		for _, i_unit in pairs(self.current.equipment[unit]) do
			mod:delete_i_unit(i_unit)
		end
		self.current.equipment[unit] = nil
	end
end
--[[
	Spawn equipment unit
--]]
mod.spawn = function(self, package_name, unit, item_setting)
	local s_unit = nil
	local world = Managers.world:world("level_world")
	local node = Unit.node(unit, item_setting.node)
	
	s_unit = World.spawn_unit(world, package_name)
	World.link_unit(world, s_unit, unit, node)
	equipment_3p_spawned_items[s_unit] = s_unit
	
	local i_pos = item_setting.position
	local pos_offset = i_pos ~= nil and Vector3(i_pos[1], i_pos[2], i_pos[3]) or Vector3(0,0,0)
	Unit.teleport_local_position(s_unit, 0, pos_offset)
	
	local i_rot = item_setting.rotation
	local rot_offset = i_rot ~= nil and Vector3(i_rot[1], i_rot[2], i_rot[3]) or Vector3(0,0,0)
	local rotation = Quaternion.from_euler_angles_xyz(rot_offset[1], rot_offset[2], rot_offset[3])
	Unit.teleport_local_rotation(s_unit, 0, rotation) 
	
	-- Hardcoded scaling
	local grim = "units/weapons/player/wpn_grimoire_01/wpn_grimoire_01_3p"
	local tome = "units/weapons/player/wpn_side_objective_tome/wpn_side_objective_tome_01_3p"
	if package_name == grim or package_name == tome then
		Unit.teleport_local_scale(s_unit, 0, Vector3(0.75, 0.75, 0.75))
	end
	-- Option scaling
	local scaling = self:get("downscale_big_weapons") / 100
	local staff = "units/weapons/player/wpn_brw_staff_06/wpn_brw_staff_06_3p"
	local volley1 = "units/weapons/player/wpn_wh_repeater_crossbow_t1/wpn_wh_repeater_crossbow_t1_3p"
	local volley2 = "units/weapons/player/wpn_wh_repeater_crossbow_t2/wpn_wh_repeater_crossbow_t2_3p"
	local volley3 = "units/weapons/player/wpn_wh_repeater_crossbow_t3/wpn_wh_repeater_crossbow_t3_3p"
	local xbow1 = "units/weapons/player/wpn_empire_crossbow_t1/wpn_empire_crossbow_tier1_3p"
	local xbow2 = "units/weapons/player/wpn_empire_crossbow_t2/wpn_empire_crossbow_tier2_3p"
	local xbow3 = "units/weapons/player/wpn_empire_crossbow_t3/wpn_empire_crossbow_tier3_3p"
	local repeat1 = "units/weapons/player/wpn_empire_pistol_repeater/wpn_empire_pistol_repeater_t1_3p"
	local repeat2 = "units/weapons/player/wpn_empire_pistol_repeater/wpn_empire_pistol_repeater_t2_3p"
	local repeat3 = "units/weapons/player/wpn_empire_pistol_repeater/wpn_empire_pistol_repeater_t3_3p"
	if package_name == volley1 or package_name == volley2 or package_name == volley3 or
			package_name == xbow1 or package_name == xbow2 or package_name == xbow3 or 
			package_name == repeat1 or package_name == repeat2 or package_name == repeat3 then
		local z_scale = scaling >= 0.75 and scaling - 0.25 or scaling
		local scale = Vector3(scaling, scaling, z_scale)
		Unit.teleport_local_scale(s_unit, 0, scale)
	end
	if package_name == staff then
		local scale = Vector3(scaling, scaling, scaling)
		Unit.teleport_local_scale(s_unit, 0, scale)
	end

	return s_unit
end
--[[
	Spawn single equipment unit
--]]
mod.get_item_setting = function(self, unit, slot_name, item_data, left)
	local def = mod.definitions
	local item_setting = nil
	
	-- ####### Fixes and options #######
	--mod:pcall(function()
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
		local profile_name = self.current.profile[unit] or nil
		if profile_name then
			if not left then
				item_setting = profile_name and def[item_data.item_type][profile_name] and def[item_data.item_type][profile_name].right
				item_setting = item_setting or def[item_data.item_type] and def[item_data.item_type].right
			else
				item_setting = profile_name and def[item_data.item_type][profile_name] and def[item_data.item_type][profile_name].left
				item_setting = item_setting or def[item_data.item_type] and def[item_data.item_type].left
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
	
	return item_setting
end
--[[
	Add single equipment item
--]]
mod.add_item = function(self, unit, slot_name, item_data)
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)
	
	if mod.definitions[item_data.item_type] ~= nil then
		local right, left, right_pack, left_pack = nil
		if item_data.right_hand_unit ~= nil then
			local item_setting = self:get_item_setting(unit, slot_name, item_data)
			if item_setting.node ~= nil then
				right_pack = item_data.right_hand_unit.."_3p"
				right = self:spawn(right_pack, unit, item_setting)
			else
				mod:echo(slot_name)
			end
		end
		if item_data.left_hand_unit ~= nil then
			local item_setting = self:get_item_setting(unit, slot_name, item_data, true)
			if item_setting.node ~= nil then
				left_pack = item_data.left_hand_unit.."_3p"
				left = self:spawn(left_pack, unit, item_setting)
			else
				mod:echo(slot_name)
			end
		end
		
		self.current.equipment[unit] = self.current.equipment[unit] or {}
		self.current.equipment[unit][#self.current.equipment[unit]+1] = {
			right = right,
			left = left,
			slot = slot_name,
			right_pack = right_pack,
			left_pack = left_pack,
		}
	end
end
--[[
	Spawn all equipment units for a character
--]]
mod.add_all_items = function(self, unit)
	if not self.current.equipment[unit] then
		local slots_by_name = InventorySettings.slots_by_name
		local wieldable_slots = InventorySettings.slots_by_wield_input
		if ScriptUnit.has_extension(unit, "inventory_system") then
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local equipment = inventory_extension.equipment(inventory_extension)
			for name, slot in pairs(equipment.slots) do
				mod:add_item(unit, name, slot.item_data)
			end
			self.current.slot[unit] = self.current.slot[unit] or equipment.wielded_slot or "slot_melee"
			self:set_equipment_visibility(unit)
		end
	end
end
--[[
	Check if packages are loaded
--]]
mod.is_not_loading = function()
	return (#Managers.package._queued_async_packages == 0 and #Managers.package._queue_order == 0)
end
--[[
	Set unit visibility
--]]
mod.set_equipment_visibility = function(self, unit, hide)
	if self.current.equipment[unit] then
		for _, equip in pairs(self.current.equipment[unit]) do
			if equip.slot == self.current.slot[unit] or hide then
				if equip.right ~= nil then
					Unit.set_unit_visibility(equip.right, false)
				end
				if equip.left ~= nil then
					Unit.set_unit_visibility(equip.left, false)
				end
			else
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
	Function from third person to check if forced third person is active
--]]
mod.is_first_person_blocked = function(self, unit)
	local blocked = false
	if ScriptUnit.has_extension(unit, "character_state_machine_system") then
		local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
		if state_system ~= nil then
			blocked = blocked or state_system.state_machine.state_current.name == "dead"
			blocked = blocked or state_system.state_machine.state_current.name == "grabbed_by_pack_master"
			blocked = blocked or state_system.state_machine.state_current.name == "inspecting"
			blocked = blocked or state_system.state_machine.state_current.name == "interacting"
			blocked = blocked or state_system.state_machine.state_current.name == "knocked_down"
			--blocked = blocked or state_system.state_machine.state_current.name == "leave_ledge_hanging_falling"
			--blocked = blocked or state_system.state_machine.state_current.name == "leave_ledge_hanging_pull_up"
			blocked = blocked or state_system.state_machine.state_current.name == "ledge_hanging"
			blocked = blocked or state_system.state_machine.state_current.name == "pounced_down"
			blocked = blocked or state_system.state_machine.state_current.name == "waiting_for_assisted_respawn"
		end
	end
	return blocked
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Wield equipment hooks
--]]
mod:hook("InventorySystem.rpc_wield_equipment", function(func, self, sender, go_id, slot_id)
	func(self, sender, go_id, slot_id)
	if not mod:is_suspended() then
		local unit = self.unit_storage:unit(go_id)
		local slot_name = NetworkLookup.equipment_slots[slot_id]
		mod:wield_equipment(unit, slot_name)
	end
end)
mod:hook("SimpleInventoryExtension.wield", function(func, self, slot_name)
	func(self, slot_name)
	if not mod:is_suspended() then
		mod:wield_equipment(self._unit, slot_name)
	end
end)
mod:hook("SimpleHuskInventoryExtension.wield", function(func, self, slot_name)
	func(self, slot_name)
	if not mod:is_suspended() then
		mod:wield_equipment(self._unit, slot_name)
	end
end)
--[[
	Despawn equipment
--]]
mod:hook("SimpleInventoryExtension.destroy_slot", function(func, self, slot_name, allow_destroy_weapon)
	func(self, slot_name, allow_destroy_weapon)
	if not mod:is_suspended() then
		mod:delete_units(self._unit)
	end
end)
mod:hook("SimpleHuskInventoryExtension.destroy_slot", function(func, self, slot_name)
	func(self, slot_name)
	if not mod:is_suspended() then
		mod:delete_units(self._unit)
	end
end)
mod:hook("PlayerUnitHealthExtension.die", function(func, self, damage_type)
	func(self, damage_type)
	if not mod:is_suspended() then
		mod:delete_units(self.unit)
	end
end)
--[[
	Unloading packages
--]]
mod:hook("PackageManager.unload", function(func, self, package_name, ...)
	if not mod:is_suspended() then
		for unit, equip in pairs(mod.current.equipment) do
			for _, i_unit in pairs(equip) do
				if i_unit.right_pack and i_unit.right_pack == package_name then
					mod:delete_units(unit)
				end
				if i_unit.left_pack and i_unit.left_pack == package_name then
					mod:delete_units(unit)
				end
			end
		end
	end
	return func(self, package_name, ...)
end)
mod:hook("MatchmakingManager.update", function(func, self, dt, t)
	func(self, dt, t)
	if not mod:is_suspended() then
		local players = Managers.player:human_and_bot_players()
		for k, player in pairs(players) do
			if player then
				local player_unit = player.player_unit
				if player_unit ~= nil then
				
					local profile_synchronizer = Managers.state.network.profile_synchronizer
					local profile_index = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
					if profile_index ~= nil then
						mod.current.profile[player_unit] = SPProfiles[profile_index].unit_name

						if ScriptUnit.has_extension(player_unit, "health_system") and ScriptUnit.has_extension(player_unit, "status_system") then
							local health_extension = ScriptUnit.extension(player_unit, "health_system")
							local status_extension = ScriptUnit.extension(player_unit, "status_system")
							local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
							if is_alive and mod.is_not_loading() and mod.current.profile[player_unit] and not mod.current.equipment[player_unit] then
								mod:add_all_items(player_unit)
								-- -- wield
								-- local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
								-- local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
								-- mod:wield_equipment(player_unit, slot_name)
							end
						end
					end
				end
			end
		end
		-- First person
		local player = Managers.player:local_player()
		if player then
			local third_person_mod = get_mod("ThirdPerson")
			local third_person = third_person_mod and not third_person_mod.firstperson.value or mod:is_first_person_blocked(player.player_unit) or false
			mod:set_equipment_visibility(player.player_unit, not third_person)
		end
	else
		mod:delete_all_units()
	end
end)
--[[
	Inventory synchronizer hook
--]]
mod:hook("InventoryPackageSynchronizer.set_inventory_list", function(func, self, profile_index, inventory_list, inventory_list_first_person)
	if not mod:is_suspended() then
		local players = Managers.player:human_and_bot_players()
		for k, player in pairs(players) do
			local profile_synchronizer = Managers.state.network.profile_synchronizer
			local profile_index_ = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
			if profile_index == profile_index_ then
				mod:delete_units(player.player_unit)
			end
		end
	end
	func(self, profile_index, inventory_list, inventory_list_first_person)
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Setting changed
--]]
mod.setting_changed = function(setting_name)
	-- Dwarf weapons
	if setting_name == "dwarf_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "dwarf_ranger" then mod:delete_units(unit) end
		end
	end
	-- Dwarf one-handed weapons
	if setting_name == "dwarf_onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "dwarf_ranger" then mod:delete_units(unit) end
		end
	end
	-- Waywatcher dual weapons
	if setting_name == "waywatcher_dualweapon_position" then
		for unit, name in pairs(mod.current.profile) do
			if name == "wood_elf" then mod:delete_units(unit) end
		end
	end
	-- One-handed weapons
	if setting_name == "onehand_weapon_position" then
		for unit, name in pairs(mod.current.profile) do mod:delete_units(unit) end
	end
	-- Downscale big weapons
	if setting_name == "downscale_big_weapons" then
		for unit, name in pairs(mod.current.profile) do mod:delete_units(unit) end
	end
end
--[[
	Mod Suspended
--]]
mod.suspended = function()
	mod:delete_all_units()
end
--[[
	Mod Unsuspended
--]]
mod.unsuspended = function()
	local players = Managers.player:human_and_bot_players()
	for k, player in pairs(players) do
		mod:add_all_items(player.player_unit)
	end
end
--[[
	Mod update
--]]
-- mod.update = function(dt)
	-- if not mod:is_suspended() then
		-- local players = Managers.player:human_and_bot_players()
		-- for k, player in pairs(players) do
			-- if player then
				-- local player_unit = player.player_unit
				-- if player_unit ~= nil then
				
					-- local profile_synchronizer = Managers.state.network.profile_synchronizer
					-- local profile_index = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
					-- if profile_index ~= nil then
						-- mod.current.profile[player_unit] = SPProfiles[profile_index].unit_name

						-- if ScriptUnit.has_extension(player_unit, "health_system") and ScriptUnit.has_extension(player_unit, "status_system") then
							-- local health_extension = ScriptUnit.extension(player_unit, "health_system")
							-- local status_extension = ScriptUnit.extension(player_unit, "status_system")
							-- local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
							-- if is_alive and mod.is_not_loading() and mod.current.profile[player_unit] and not mod.current.equipment[player_unit] then
								-- mod:add_all_items(player_unit)
								-- -- wield
								-- local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
								-- local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
								-- mod:wield_equipment(player_unit, slot_name)
							-- end
						-- end
					-- end
				-- end
			-- end
		-- end
		-- -- First person
		-- local player = Managers.player:local_player()
		-- if player then
			-- local third_person_mod = get_mod("ThirdPerson")
			-- local third_person = third_person_mod and not third_person_mod.firstperson.value or mod:is_first_person_blocked(player.player_unit) or false
			-- mod:set_equipment_visibility(player.player_unit, not third_person)
		-- end
	-- else
		-- mod:delete_all_units()
	-- end
-- end

-- Delete
mod:delete_all_units()
mod:create_options(options_widgets, true, "Third Person Equipment", "Mod description")