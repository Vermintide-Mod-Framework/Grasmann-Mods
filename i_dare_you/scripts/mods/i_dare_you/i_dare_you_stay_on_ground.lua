local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't jump

    Forces victim to not jump.
--]]

local stay_on_ground = mod:get_template()
stay_on_ground.id = "stay_on_ground"
stay_on_ground.text = mod:localize("stay_on_ground_text")
stay_on_ground.reminder_jump = mod:localize("stay_on_ground_reminder_jump")
stay_on_ground.reminder_fall = mod:localize("stay_on_ground_reminder_fall")
stay_on_ground.reminder = stay_on_ground.reminder_jump
stay_on_ground.time = 0.1
stay_on_ground.punishments = {"damage"}
stay_on_ground.values = {damage = 4}
stay_on_ground.reminder_time = 0
stay_on_ground.states = {"jumping", "falling"}
stay_on_ground.check_state_function = function(self)
    local peer_id = mod:my_peer_id()
    local unit = mod:player_unit_from_peer_id(peer_id)
    local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
    if state_system then
        local state = state_system.state_machine.state_current
        if table.contains(self.states, state.name) then
            if state.name == "jumping" then
                self.reminder = stay_on_ground.reminder_jump
            elseif state.name == "falling" then
                self.reminder = stay_on_ground.reminder_fall
            end
            return false
        else
            return true
        end
    end
end

return stay_on_ground