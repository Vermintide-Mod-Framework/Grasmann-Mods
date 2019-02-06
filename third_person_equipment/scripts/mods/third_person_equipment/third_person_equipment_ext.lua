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
    local player = inventory_extension.player
    --mod:echo("Creating extension for player '"..tostring(player:name()).."' ...")
    
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
    self:create_hooks()
    
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
end
--[[
    Destroy extension
--]]
ThirdPersonEquipmentExtension.destroy = function(self)
    self:destroy_hooks()
    mod:delete_units(self)
    mod.current.profile[self.unit] = nil
    mod.current.slot[self.unit] = nil
end
--[[
    Wield equipment
--]]
ThirdPersonEquipmentExtension.wield = function(self, slot_name)
    self.slot = slot_name
    mod:wield_equipment(self, slot_name)
end
--[[
    Add equipment
--]]
ThirdPersonEquipmentExtension.add = function(self, slot_name, item_data)
    mod:add_item(self, slot_name, item_data)
    mod:set_equipment_visibility(self.unit)
end
--[[
    Remove equipment
--]]
ThirdPersonEquipmentExtension.remove = function(self, slot_name)
    mod:delete_slot(self, slot_name)
end
--[[
    Reload equipment
--]]
ThirdPersonEquipmentExtension.reload = function(self)
    mod:delete_units(self)
	self:add_all()
end
--[[
    Add all equipment
--]]
ThirdPersonEquipmentExtension.add_all = function(self)
    mod:add_all_items(self)
    mod:set_equipment_visibility(self.unit)
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
