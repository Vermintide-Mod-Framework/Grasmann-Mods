local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use skill

    Forces victim to not use skill.
--]]

local push = 0
mod:hook_safe(ActionPushStagger, "client_owner_start_action", function(self, ...)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.owner_player and self.owner_player == player then
        push = push + 1
    end
end)
mod:hook_disable(ActionPushStagger, "client_owner_start_action")

local dont_push = mod:get_template()
dont_push.id = "dont_push"
dont_push.text = mod:localize("dont_push_text")
dont_push.reminder = mod:localize("dont_push_reminder")
dont_push.time = 0
dont_push.punishments = {"damage"}
dont_push.values = {damage = 15}
dont_push.reminder_time = 0
dont_push.on_start = function(self)
    mod:hook_enable(ActionPushStagger, "client_owner_start_action")
end
dont_push.check_state_function = function(self)
    if push > 0 then
        push = push - 1
        return false
    end
    return true
end
dont_push.on_finish = function(self)
    mod:hook_disable(ActionPushStagger, "client_owner_start_action")
end

return dont_push