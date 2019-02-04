local mod = get_mod("ThirdPersonEquipment")
--[[
	Third person equipment extension

	Author: grasmann
--]]

third_person_equipment_spawned_units = third_person_equipment_spawned_units or {}
local loaded_units = third_person_equipment_spawned_units

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
    local player = inventory_extension.player
    mod:echo("Creating extension for player '"..tostring(player:name()).."' ...")
    
    -- Values
    self.inventory_extension = inventory_extension
    self.unit = inventory_extension._unit
    self.player = player
    self.slots = {"slot_melee", "slot_ranged", "slot_healthkit", "slot_potion", "slot_grenade"}
    self.slot = self.inventory_extension:equipment().wielded_slot or "slot_melee"
    self.equipment = {}
    
    -- lol
    local profile_synchronizer = Managers.state.network.profile_synchronizer
    local profile_index = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
    mod.current.profile[self.unit] = SPProfiles[profile_index].unit_name

    -- Create hooks
    -- Destroy
    mod:hook(inventory_extension, "destroy", function(func, self, ...)
        self.tpe_extension:destroy()
        return func(self, ...)
    end)
    -- Wield
    mod:hook_safe(inventory_extension, "wield", function(self, slot_name)
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:wield(slot_name)
        end
    end)
    -- Add Equipment
    mod:hook_safe(inventory_extension, "add_equipment", function(self, slot_name, item_data)
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:add(slot_name, item_data)
        end
    end)
    -- Destroy Slot
    mod:hook(inventory_extension, "destroy_slot", function(func, self, slot_name, ...)
        if table.contains(self.tpe_extension.slots, slot_name) then
            self.tpe_extension:remove(slot_name)
        end
        return func(self, slot_name, ...)
    end)
    -- Update
    mod:hook_safe(inventory_extension, "update", function(self)
        self.tpe_extension:update()
    end)
end

--[[
    Update extension
--]]
ThirdPersonEquipmentExtension.update = function(self)
end

--[[
    Destroy extension
--]]
ThirdPersonEquipmentExtension.destroy = function(self)
    --mod:echo("Destroying ext player: '"..tostring(self.player:name()).."' ...")
    mod:delete_units(self.unit)
end

--[[
    Wield equipment
--]]
ThirdPersonEquipmentExtension.wield = function(self, slot_name)
    --mod:echo("Wield slot '"..slot_name.."'")
    self.slot = slot_name
    mod:wield_equipment(self.unit, slot_name)
end

--[[
    Add equipment
--]]
ThirdPersonEquipmentExtension.add = function(self, slot_name, item_data)
    --mod:echo("Creating '"..slot_name.."' player: '"..tostring(self.player:name()).."' ...")
    --self:load_equipment(slot_name, item_data)
    mod:add_item(self.unit, slot_name, item_data, skin)
    -- lol
    mod.current.slot[self.unit] = mod.current.slot[self.unit] or self.inventory_extension:equipment().wielded_slot or "slot_melee"
    --mod:dump(self.equipment, "self.equipment", 4)
    --mod:set_equipment_visibility(self.unit)
end

--[[
    Remove equipment
--]]
ThirdPersonEquipmentExtension.remove = function(self, slot_name)
    --mod:echo("Destroy '"..slot_name.."' player: '"..tostring(self.player:name()).."' ...")
    mod:delete_slot(self.unit, slot_name)
    --mod:dump(mod.current.equipment, "mod.current.equipment", 4)
end

--[[
    Add all equipment
--]]
ThirdPersonEquipmentExtension.add_all = function(self)
    --mod:echo("Add all items for player: '"..tostring(self.player:name()).."' ...")
    mod:add_all_items(self.unit)
    --mod:dump(mod.current.equipment, "mod.current.equipment", 4)
    mod:set_equipment_visibility(self.unit)
end
