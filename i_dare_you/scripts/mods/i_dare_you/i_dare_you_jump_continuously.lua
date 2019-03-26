local mod = get_mod("i_dare_you")
--[[
	I dare you! - Jump continuously

    Forces victim to keep jumping.
--]]

return {
    id = "jump_continuously",
    text = mod:localize("jump_continuously_text"),
    reminder = mod:localize("jump_continuously_reminder"),
    reminder_timer = 0,
    reminder_time = 2,
    fallible = true,
    punishments = {
        "damage",
    },
    values = {
        damage = 5,
    },
    states = {
        "jumping",
        "falling",
    },
    timer = 0,
    time = 0.25,
    is_finishing = false,
    start = function(self)
        self.timer = 0
    end,
    update = function(self, dt)
        if not self.is_finishing then
            local peer_id = mod:my_peer_id()
            local unit = mod:player_unit_from_peer_id(peer_id)
            if mod:is_peer_id_alive(peer_id) then
                local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
                if state_system then
                    local state = state_system.state_machine.state_current
                    if table.contains(self.states, state.name) then
                        -- Good!
                        self.timer = 0
                        self.reminder_timer = 0
                        --mod:echo("Good!")
                    else
                        -- Count
                        self.timer = self.timer + dt
                        if self.timer >= self.time then
                            -- Bad!
                            self.timer = 0
                            self:punish()
                        end
                        -- Reminder
                        self.reminder_timer = self.reminder_timer + dt
                        if self.reminder_timer >= self.reminder_time then
                            -- Remind
                            self.reminder_timer = 0
                            mod:remind_dare()
                        end
                    end
                end
            else
                mod:abort_dare("death")
            end
        end
    end,
    finish = function(self)
    end,
    punish = function(self)
        local rnd = math.random(1, #self.punishments)
        local punishment = self.punishments[rnd]
        local value = self.values[punishment]
        mod:echo("Punishment! Type:'"..punishment.."' Value:'"..tostring(value).."'")
        mod:add_damage(value)
    end,
}