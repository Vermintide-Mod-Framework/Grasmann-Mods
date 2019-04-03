local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use ranged

    Forces victim to not use ranged.
--]]

local dont_use_ranged = mod:get_template()
dont_use_ranged.id = "dont_use_ranged"
dont_use_ranged.text = mod:localize("dont_use_ranged_text")
dont_use_ranged.reminder = mod:localize("dont_use_ranged_reminder")
dont_use_ranged.time = 0.2
dont_use_ranged.values.damage = 5
dont_use_ranged.reminder_time = 1
dont_use_ranged.check_condition = function(self, selector_peer_id, victim_peer_id)
    -- Make sure character isn't a slayer
    local unit = mod:player_unit_from_peer_id(victim_peer_id)
    local career_extension = ScriptUnit.extension(unit, "career_system")
    if career_extension:career_name() == "dr_slayer" then
        return false
    end
    return true
end
dont_use_ranged.check_state_function = function(self)
    local peer_id = mod:my_peer_id()
    local unit = mod:player_unit_from_peer_id(peer_id)
    local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
    local wielded_slot_name = inventory_extension:get_wielded_slot_name()
    if wielded_slot_name == "slot_ranged" then
        return false
    end
    return true
end

return dont_use_ranged