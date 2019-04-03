local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't block

    Forces victim to not block.
--]]

local dont_block = mod:get_template()
dont_block.id = "dont_block"
dont_block.text = mod:localize("dont_block_text")
dont_block.reminder = mod:localize("dont_block_reminder")
dont_block.time = 0.2
dont_block.values.damage = 5
dont_block.reminder_time = 0.75
dont_block.check_state_function = function(self)
    local peer_id = mod:my_peer_id()
    local unit = mod:player_unit_from_peer_id(peer_id)
    local status_extension = ScriptUnit.has_extension(unit, "status_system")
    if status_extension then
        local is_blocking = status_extension:is_blocking()
        if is_blocking then
            return false
        end
    end
    return true
end

return dont_block