local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use item

    Forces victim to not use item.
--]]

local item = 0
mod:hook_safe(ActionHealingDraught, "finish", function(self, reason)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.owner_player and self.owner_player == player then
        item = item + 1
    end
end)
mod:hook_disable(ActionHealingDraught, "finish")

mod:hook_safe(ActionPotion, "finish", function(self, new_action, t)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.owner_player and self.owner_player == player then
        item = item + 1
    end
end)
mod:hook_disable(ActionPotion, "finish")

mod:hook(WeaponUnitExtension, "_finish_action", function(func, self, reason, data)
    local owner_player = Managers.player:unit_owner(self.owner_unit)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if owner_player and owner_player == player then
        -- Grenade
        if data and data.action and data.action.impact_data and data.action.impact_data.grenade then
            item = item + 1
        end
        local action = self.current_action_settings
        if action and action.lookup_data and action.lookup_data.item_template_name == "first_aid_kit_02" then
            if reason == "action_complete" then
                item = item + 1
            end
        end
    end
    return func(self, reason, data)
end)
mod:hook_disable(WeaponUnitExtension, "_finish_action")

local dont_use_item = mod:get_template()
dont_use_item.id = "dont_use_item"
dont_use_item.text = mod:localize("dont_use_item_text")
dont_use_item.reminder = mod:localize("dont_use_item_reminder")
dont_use_item.time = 0
dont_use_item.values.damage = 30
dont_use_item.reminder_time = 0
dont_use_item.on_start = function(self)
    item = 0
    mod:hook_enable(ActionHealingDraught, "finish")
    mod:hook_enable(ActionPotion, "finish")
    mod:hook_enable(WeaponUnitExtension, "_finish_action")
end
local get_item_name = function(inventory_extension, slot_name)
	local slot_data = inventory_extension:get_slot_data(slot_name)
	local item_data = slot_data and slot_data.item_data
	local item_name = item_data and item_data.name
	return item_name
end
dont_use_item.check_condition = function(self, selector_peer_id, victim_peer_id)
    local unit = mod:player_unit_from_peer_id(victim_peer_id)
    local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
    if inventory_extension then
        local healthkit = get_item_name(inventory_extension, "slot_healthkit")
        local potion = get_item_name(inventory_extension, "slot_potion")
        local grenade = get_item_name(inventory_extension, "slot_grenade")
        local healthkit_slot = healthkit and healthkit ~= "wpn_side_objective_tome_01"
        local potion_slot = potion and potion ~= "wpn_grimoire_01"
        if healthkit_slot or potion_slot or grenade then
            return true
        end
    end
    return false
end
dont_use_item.check_state_function = function(self)
    if item > 0 then
        item = item - 1
        return false
    end
    return true
end
dont_use_item.on_finish = function(self)
    mod:hook_disable(ActionHealingDraught, "finish")
    mod:hook_disable(ActionPotion, "finish")
    mod:hook_disable(WeaponUnitExtension, "_finish_action")
end

return dont_use_item