local mod = get_mod("ThirdPersonEquipment")
--[[
    Third person equipment extension

    Extends simple_inventory_extension and simple_husk_inventory_extension with additional features

	Author: grasmann
--]]

-- ##### ███████╗██╗  ██╗████████╗███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗ ####################################
-- ##### ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║ ####################################
-- ##### █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║ ####################################
-- ##### ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║ ####################################
-- ##### ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║ ####################################
-- ##### ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ####################################

ThirdPersonEquipmentExtension = class(ThirdPersonEquipmentExtension)
--[[
    Initialize extension
--]]
ThirdPersonEquipmentExtension.init = function(self, inventory_extension)
    self.inventory_extension = inventory_extension
    self.unit = inventory_extension._unit
    self.link_queue = {}
    self.slots = {"slot_melee", "slot_ranged", "slot_healthkit", "slot_potion", "slot_grenade"}
    self.slot = self.inventory_extension:equipment().wielded_slot or "slot_melee"
	self.equipment = {}
	self.show = false
	self.delayed_visibility_check = false
	self.special_states = {
		"catapulted", "dead", "falling", "grabbed_by_chaos_spawn", "grabbed_by_corruptor", 
		"grabbed_by_pack_master", "grabbed_by_tentacle", "in_hanging_cage", "in_vortex", "interacting", 
		"knocked_down", "leave_ledge_hanging_falling", "leave_ledge_hanging_pull_up", "ledge_hanging", 
		"overcharge_exploding", "overpowered", "pounced_down", "waiting_for_assisted_respawn", 
	}
	self.special_states_remote_only = {
		"climbing_ladder",
	}
    -- Create hooks
    self:create_hooks()
    -- Add to list
    mod.extensions[self.unit] = self
end
--[[
    Destroy extension
--]]
ThirdPersonEquipmentExtension.destroy = function(self)
    self:destroy_hooks()
    self:remove_all()
    mod.extensions[self.unit] = nil
end
--[[
    Create inventory hooks
--]]
ThirdPersonEquipmentExtension.create_hooks = function(self)
    -- Destroy
    mod:hook(self.inventory_extension, "destroy", function(func, self, ...)
        self.tpe_extension:destroy()
        return func(self, ...)
    end)
    -- Wield
	mod:hook_safe(self.inventory_extension, "wield", function(self, slot_name)
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:wield(slot_name)
        end
    end)
    -- Add Equipment
	mod:hook_safe(self.inventory_extension, "add_equipment", function(self, slot_name, item_data)
		if type(item_data) == "string" then
			item_data = ItemMasterList[item_data]
		end
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:add(slot_name, item_data)
        end
    end)
    -- Destroy Slot
    mod:hook(self.inventory_extension, "destroy_slot", function(func, self, slot_name, ...)
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:remove(slot_name)
        end
        return func(self, slot_name, ...)
    end)
    -- Update
	mod:hook_safe(self.inventory_extension, "update", function(self)
        self.tpe_extension:update()
	end)
	-- Third Person
	mod:hook_safe(self.inventory_extension, "show_third_person_inventory", function(self, show)
		self.tpe_extension.show = show
		self.tpe_extension.delayed_visibility_check = true
	end)
end
--[[
    Disable inventory hooks
--]]
ThirdPersonEquipmentExtension.destroy_hooks = function(self)
    mod:hook_disable(self.inventory_extension, "destroy")
    mod:hook_disable(self.inventory_extension, "wield")
    mod:hook_disable(self.inventory_extension, "add_equipment")
    mod:hook_disable(self.inventory_extension, "destroy_slot")
    mod:hook_disable(self.inventory_extension, "update")
end
--[[
    Update extension
--]]
ThirdPersonEquipmentExtension.update = function(self)
	self:update_link_queue()
	if self.delayed_visibility_check then
		self:set_equipment_visibility()
		self.delayed_visibility_check = false
	end
end
--[[
    Update link queue
--]]
ThirdPersonEquipmentExtension.update_link_queue = function(self)
    for _, entry in pairs(self.link_queue) do
        self:link_unit(entry.item_unit, entry.item_setting, true)
    end
end
--[[
    Wield equipment
--]]
ThirdPersonEquipmentExtension.wield = function(self, slot_name)
    self.slot = slot_name
    self:set_equipment_visibility()
end
--[[
    Check for special state where melee and ranged weapon are visible
--]]
ThirdPersonEquipmentExtension.is_special_state = function(self)
	local is_special_state = false
	local state_system = ScriptUnit.extension(self.unit, "character_state_machine_system")
	if state_system ~= nil then
		local state = state_system.state_machine.state_current
		for _, special_state in pairs(self.special_states) do
			is_special_state = is_special_state or state.name == special_state
		end
		if not is_special_state and not self:is_local_player() then
			for _, special_state in pairs(self.special_states_remote_only) do
				is_special_state = is_special_state or state.name == special_state
			end
		end
	end
	return is_special_state
end
--[[
    Set equipment visibility
--]]
ThirdPersonEquipmentExtension.set_equipment_visibility = function(self)
	local hide = not self.show
	local special_state = self:is_special_state()
	
	if self.equipment then
		for _, equip in pairs(self.equipment) do
			if not special_state and (equip.slot == self.slot or hide) then
                if equip.visible or equip.visible == nil then
                    for _, sub_unit in pairs({"right", "left"}) do
                        if equip[sub_unit] ~= nil then
                            Unit.set_unit_visibility(equip[sub_unit], false)
                        end
                    end
					equip.visible = false
				end
			else
                if not equip.visible then
                    for _, sub_unit in pairs({"right", "left"}) do
                        if equip[sub_unit] ~= nil then
                            Unit.set_unit_visibility(equip[sub_unit], true)
                            Unit.flow_event(equip[sub_unit], "lua_wield")
                            Unit.flow_event(equip[sub_unit], "lua_unwield")
                        end
                    end
					equip.visible = true
				end
			end
		end
	end
end
--[[
    Add equipment
--]]
ThirdPersonEquipmentExtension.add = function(self, slot_name, item_data)
    local equipment_info = {
        slot_name = slot_name,
        item_data = item_data,
    }
    if mod.definitions[item_data.item_type] ~= nil then
        -- Get unit info
		local right, right_pack, replaced_right = self:load_item(equipment_info, "right_hand_unit")
		local left, left_pack, replaced_left = self:load_item(equipment_info, "left_hand_unit")
		-- Add info to equipment
		self.equipment[#self.equipment+1] = {
			right = right,
			left = left,
			slot = slot_name,
			right_pack = right_pack,
			left_pack = left_pack,
			replaced = replaced_right,
			item_type = item_data.item_type,
        }
        -- Set slot
        self.slot = self.slot or tpe.inventory_extension:equipment().wielded_slot or "slot_melee"
    elseif item_data.item_type ~= nil and item_data.item_type ~= "inventory_item" then
        -- Item type not implemented
		self:echo(tostring(item_data.item_type).." is missing!")
	end
    -- Update visibility
    self:set_equipment_visibility()
end
--[[
	Add single equipment item
--]]
ThirdPersonEquipmentExtension.load_item = function(self, equipment_info, unit_name)
	local equipment = self.inventory_extension:equipment()
    local unit, package, replaced, material_settings = nil
    local slot_name = equipment_info.slot_name
    local item_data = equipment_info.item_data

	if item_data[unit_name] ~= nil then
		local item_setting, replace = self:get_item_setting(equipment_info, unit_name == "left_hand_unit")
		replaced = replace

		if not VT1 and career_name then
			local career_name = self:career_name()
			item_setting = item_setting[career_name] or item_setting
		end

		if VT1 then
			package = item_data[unit_name].."_3p"
		else
			package = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and WeaponSkins.skins[equipment.slots[slot_name].skin][unit_name].."_3p"
			local inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
			local weapon_data = inventory_extension:get_slot_data(slot_name)
			material_settings = WeaponSkins and equipment.slots[slot_name] and WeaponSkins.skins[equipment.slots[slot_name].skin] and WeaponSkins.skins[equipment.slots[slot_name].skin].material_settings
			package = package or item_data[unit_name].."_3p"
		end

		if package then
			unit = self:spawn(package, item_setting, item_data)
			if unit and material_settings then
				GearUtils.apply_material_settings(unit, material_settings)
			end
			return unit, package, replaced
		end
	end
end
--[[
	Get item settings for equipment unit
--]]
ThirdPersonEquipmentExtension.get_item_setting = function(self, equipment_info, left)
	local def = mod.definitions
    local item_setting = nil
    local slot_name = equipment_info.slot_name
    local item_data = equipment_info.item_data

	-- ####### Fixes and options #######
	if slot_name == "slot_melee" or slot_name == "slot_ranged" then
		
		-- Dwarf
		if table.contains(def.dwarf_weapons, item_data.item_type) then
			local dwarf_weapon_position = mod:get("dwarf_weapon_position")
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
			local dwarf_one_handed_weapon_position = mod:get("dwarf_onehand_weapon_position")
			local option_d_belt = 2
			local option_d_back = 3
			local dwarf_weapon = table.contains(def.dwarf_weapons, item_data.item_type)
			local _1h_weapon_position = mod:get("onehand_weapon_position")
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
			local dwarf_weapon_position = mod:get("waywatcher_dualweapon_position")
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
		local profile_name = nil
		if VT1 then
			profile_name = self:find_profile()
		else
			local career_extension = ScriptUnit.extension(self.unit, "career_system")
			profile_name = career_extension._profile_name
		end
		if profile_name then
			local key = def[item_data.key] and item_data.key or def[item_data.item_type] and item_data.item_type
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
		local career_name = self:career_name()

		item_setting = item_setting[career_name] or item_setting

		if career_name == "dr_slayer" then

			-- Dual axes
			if item_data.item_type == "dr_dual_axes" or item_data.item_type == "dr_dual_wield_hammers" then
				local something_replaced = false
				if self.equipment then
					for _, i_unit in pairs(self.equipment) do
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
				if self.equipment then
					for _, i_unit in pairs(self.equipment) do
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
			-- local career_extension = ScriptUnit.extension(tpe.unit, "career_system")
            -- local career_name = career_extension._career_data.name
            local career_name = self:career_name()
	
			item_setting = item_setting[career_name] or item_setting
		end
	end

    -- Skin
    if not VT1 then
        local skin = self:character_skin()
        if skin then
            item_setting = item_setting[skin] or item_setting
        end
    end

	return item_setting, replaced
end
--[[
	Spawn equipment unit
--]]
ThirdPersonEquipmentExtension.spawn = function(self, package_name, item_setting, item_data)
	-- Spawn unit
	local world = Managers.world:world("level_world")
	local item_unit = World.spawn_unit(world, package_name)
    -- Add to spawned units
    mod.spawned_units[item_unit] = item_unit
	-- Link unit
	self:link_unit(item_unit, item_setting)

	-- Hardcoded scaling
	local grim = "units/weapons/player/wpn_grimoire_01/wpn_grimoire_01_3p"
	local tome = "units/weapons/player/wpn_side_objective_tome/wpn_side_objective_tome_01_3p"
	if package_name == grim or package_name == tome then
		Unit.set_local_scale(item_unit, 0, Vector3(0.75, 0.75, 0.75))
	end

	-- Option scaling
	local scaling = mod:get("downscale_big_weapons") / 100
	if table.contains(mod.definitions.big_weapons, tostring(item_data.item_type)) then
		local scale = Vector3(scaling, scaling, scaling)
		Unit.set_local_scale(item_unit, 0, scale)
	end

	return item_unit
end
--[[
	Link equipment unit
--]]
ThirdPersonEquipmentExtension.link_unit = function(self, item_unit, item_setting, queue)

	local attachment = item_setting.attachment or nil
	local world = Managers.world:world("level_world")

	if attachment then
		-- Attach unit to attachment unit
        local unit_attachments = Unit.get_data(self.unit, "flow_unit_attachments")
        if unit_attachments and #unit_attachments > 0 then
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
        elseif not queue then
            -- In case attachement flow units are missing
            -- Send to link queue
            self.link_queue[item_unit] = {
                item_unit = item_unit,
                item_setting = item_setting,
            }
            return
        end
	elseif Unit.has_node(self.unit, item_setting.node) then
		-- Attach unit to node
		local node = Unit.node(self.unit, item_setting.node)
		World.link_unit(world, item_unit, self.unit, node)
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

    -- In case of link queue remove from queue
    if queue and self.link_queue[item_unit] then
        self.link_queue[item_unit] = nil
    end

end
--[[
    Reload equipment
--]]
ThirdPersonEquipmentExtension.reload = function(self)
    self:remove_all()
	self:add_all()
end
--[[
    Add all equipment
--]]
ThirdPersonEquipmentExtension.add_all = function(self)
    local slots_by_name = InventorySettings.slots_by_name
    local wieldable_slots = InventorySettings.slots_by_wield_input
    for slot_name, slot in pairs(self.inventory_extension:equipment().slots) do
        self:add(slot_name, slot.item_data)
    end

	if not self:is_local_player() then
		self.show = true
	end
    self:set_equipment_visibility()
end
--[[
    Remove equipment
--]]
ThirdPersonEquipmentExtension.remove = function(self, slot_name)
    if self.equipment then
        -- Iterate through equipment
        for i = #self.equipment, 1, -1 do
            local item_unit = self.equipment[i]
            -- Check if slot fits
            if item_unit and item_unit.slot == slot_name then
			    -- Delete unit
                self:delete_item_unit(item_unit, "right")
                self:delete_item_unit(item_unit, "left")
				-- Set equipment nil
				self.equipment[i] = nil
            end
        end
    end
end
--[[
    Remove all equipment
--]]
ThirdPersonEquipmentExtension.remove_all = function(self)
    if self.equipment then
        -- Iterate through equipment and delete everything
        for _, item_unit in pairs(self.equipment) do
            self:delete_item_unit(item_unit, "right")
            self:delete_item_unit(item_unit, "left")
        end
        self.equipment = {}
    end
end
--[[
    Delete equipment units
--]]
ThirdPersonEquipmentExtension.delete_item_unit = function(self, item_unit, sub_unit)
    local world = Managers.world:world("level_world")
    if item_unit[sub_unit] ~= nil then
        mod.spawned_units[item_unit[sub_unit]] = nil
        if Unit.alive(item_unit[sub_unit]) then
            World.destroy_unit(world, item_unit[sub_unit])
        end
    end
end
--[[
    Get career name
--]]
ThirdPersonEquipmentExtension.career_name = function(self)
    local career_extension = ScriptUnit.extension(self.unit, "career_system")
    local career_name = career_extension._career_data.name
    return career_name
end
--[[
    Get skin name
--]]
ThirdPersonEquipmentExtension.character_skin = function(self)
    local cosmetic_extension = ScriptUnit.extension(self.unit, "cosmetic_system")
    local skin = cosmetic_extension:get_equipped_skin().name
    return skin
end
--[[
    Check if extension is on local player
--]]
ThirdPersonEquipmentExtension.is_local_player = function(self)
    local player = Managers.player:local_player()
    if player and player.player_unit and self.unit == player.player_unit then
        return true
    end
    return false
end
--[[
	Find profile
--]]
ThirdPersonEquipmentExtension.find_profile = function(self)
	if Managers and Managers.state and Managers.state.network then
        local players = Managers.player:players()
		for _, player in pairs(players) do
			if player.player_unit == self.unit then
				local index = player.profile_index
				local name = SPProfiles[index].display_name
				return name
			end
		end
	end
	return nil
end
