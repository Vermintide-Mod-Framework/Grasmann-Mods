local mod = get_mod("i_dare_you")
--[[
	I dare you! - Drop the grim

    Forces victim to drop grim.
--]]

local dropped = false
mod:hook_safe(ActionThrowGrimoire, "finish", function(...)
    dropped = true
end)
mod:hook_disable(ActionThrowGrimoire, "finish")

local drop_grim = mod:get_template()
drop_grim.id = "drop_grim"
drop_grim.text = mod:localize("drop_grim_text")
drop_grim.text_color = {255, 255, 0, 0}
drop_grim.reminder = mod:localize("drop_grim_reminder")
drop_grim.time = 1
drop_grim.punishments = {"damage"}
drop_grim.values = {damage = 1}
drop_grim.reminder_time = 5
drop_grim.check_condition = function(self, selector_peer_id, victim_peer_id)
    local unit = mod:player_unit_from_peer_id(victim_peer_id)
    local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
    local slot_data = inventory_extension:get_slot_data("slot_potion")
    if slot_data and slot_data.item_template and slot_data.item_template.is_grimoire then
        return true
    end
end
drop_grim.on_start = function(self)
    dropped = false
    mod:hook_enable(ActionThrowGrimoire, "finish")
end
drop_grim.check_state_function = function(self)
    if not dropped then
        return false
    else
        mod:abort_dare("done")
        return true
    end
end
drop_grim.on_finish = function(self)
    mod:hook_disable(ActionThrowGrimoire, "finish")
end

return drop_grim