local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't switch equipment

    Forces victim to not switch equipment.
--]]

local switch = 0
mod:hook_safe(SimpleInventoryExtension, "wield", function(self)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.player == player then
        switch = switch + 1
    end
end)
mod:hook_disable(SimpleInventoryExtension, "wield")

local dont_switch_equipment = mod:get_template()
dont_switch_equipment.id = "dont_switch_equipment"
dont_switch_equipment.text = mod:localize("dont_switch_equipment_text")
dont_switch_equipment.reminder = mod:localize("dont_switch_equipment_reminder")
dont_switch_equipment.time = 0
dont_switch_equipment.values.damage = 20
dont_switch_equipment.reminder_time = 0
dont_switch_equipment.on_start = function(self)
    switch = 0
    mod:hook_enable(SimpleInventoryExtension, "wield")
end
dont_switch_equipment.check_state_function = function(self)
    if switch > 0 then
        switch = switch - 1
        return false
    end
    return true
end
dont_switch_equipment.on_finish = function(self)
    mod:hook_disable(SimpleInventoryExtension, "wield")
end

return dont_switch_equipment