local mod = get_mod("i_dare_you")
--[[
	I dare you! - Jump continuously

    Forces victim to keep jumping.
--]]

local jump_continuously = mod:get_template()
jump_continuously.id = "jump_continuously"
jump_continuously.text = mod:localize("jump_continuously_text")
jump_continuously.reminder = mod:localize("jump_continuously_reminder")
jump_continuously.time = 0.25
jump_continuously.values.damage = 3
jump_continuously.reminder_time = 0.5
jump_continuously.states = {"jumping", "falling"}
jump_continuously.check_state_function = function(self)
    local peer_id = mod:my_peer_id()
    local unit = mod:player_unit_from_peer_id(peer_id)
    local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
    if state_system then
        local state = state_system.state_machine.state_current
        if table.contains(self.states, state.name) then
            return true
        else
            return false
        end
    end
end

return jump_continuously