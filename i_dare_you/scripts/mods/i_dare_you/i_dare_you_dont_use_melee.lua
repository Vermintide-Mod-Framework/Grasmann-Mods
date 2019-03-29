local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use melee

    Forces victim to not use melee.
--]]

local melee_attacks = 0
mod:hook_safe(ActionMeleeStart, "client_owner_start_action", function(self, new_action, t, chain_action_data, power_level, action_init_data)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.owner_player and self.owner_player == player then
        melee_attacks = melee_attacks + 1
    end
end)
mod:hook_disable(ActionMeleeStart, "client_owner_start_action")

local dont_use_melee = mod:get_template()
dont_use_melee.id = "dont_use_melee"
dont_use_melee.text = mod:localize("dont_use_melee_text")
dont_use_melee.reminder = mod:localize("dont_use_melee_reminder")
dont_use_melee.time = 0
dont_use_melee.punishments = {"damage"}
dont_use_melee.values = {damage = 15}
dont_use_melee.reminder_time = 0
dont_use_melee.on_start = function(self)
    melee_attacks = 0
    mod:hook_enable(ActionMeleeStart, "client_owner_start_action")
end
dont_use_melee.check_state_function = function(self)
    if melee_attacks > 0 then
        melee_attacks = melee_attacks - 1
        return false
    end
    return true
end
dont_use_melee.on_finish = function(self)
    mod:hook_disable(ActionMeleeStart, "client_owner_start_action")
end

return dont_use_melee