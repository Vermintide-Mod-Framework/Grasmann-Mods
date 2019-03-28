local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use item

    Forces victim to not use item.
--]]

local item = 0
mod:hook_safe(ActionHealingDraught, "finish", function(self, reason)
    item = item + 1
end)
mod:hook_disable(ActionHealingDraught, "finish")

mod:hook_safe(ActionPotion, "client_owner_start_action", function(self, new_action, t)
    item = item + 1
end)
mod:hook_disable(ActionPotion, "client_owner_start_action")

mod:hook(WeaponUnitExtension, "_finish_action", function(func, self, reason, data)
    -- Grenade
    if data and data.action and data.action.impact_data and data.action.impact_data.grenade then
        item = item + 1
    end
    local action = self.current_action_settings
    if action and action.lookup_data and action.lookup_data.item_template_name == "first_aid_kit_02" then
        item = item + 1
    end
    return func(self, reason, data)
end)
mod:hook_disable(WeaponUnitExtension, "_finish_action")

local dont_use_item = mod:get_template()
dont_use_item.id = "dont_use_item"
dont_use_item.text = mod:localize("dont_use_item_text")
dont_use_item.reminder = mod:localize("dont_use_item_reminder")
dont_use_item.time = 0
dont_use_item.punishments = {"damage"}
dont_use_item.values = {damage = 30}
dont_use_item.reminder_time = 0
dont_use_item.on_start = function(self)
    mod:hook_enable(ActionHealingDraught, "finish")
    mod:hook_enable(ActionPotion, "client_owner_start_action")
    mod:hook_enable(WeaponUnitExtension, "_finish_action")
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
    mod:hook_disable(ActionPotion, "client_owner_start_action")
    mod:hook_disable(WeaponUnitExtension, "_finish_action")
end

return dont_use_item