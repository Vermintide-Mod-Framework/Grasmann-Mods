local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't tag enemies

    Forces victim to not tag enemies.
--]]

local ping = 0
mod:hook(ContextAwarePingExtension, "ping_attempt", function(func, self, unit, ...)
    local result = func(self, unit, ...)
    local player_unit = mod:player_unit_from_peer_id(mod:my_peer_id())
    if result and unit == player_unit then
        ping = ping + 1
    end
    return result
end)
mod:hook_disable(ContextAwarePingExtension, "ping_attempt")

local dont_ping = mod:get_template()
dont_ping.id = "dont_ping"
dont_ping.text = mod:localize("dont_ping_text")
dont_ping.reminder = mod:localize("dont_ping_reminder")
dont_ping.time = 0
dont_ping.values.damage = 35
dont_ping.reminder_time = 0
dont_ping.on_start = function(self)
    ping = 0
    mod:hook_enable(ContextAwarePingExtension, "ping_attempt")
end
dont_ping.check_state_function = function(self)
    if ping > 0 then
        ping = ping - 1
        return false
    end
    return true
end
dont_ping.on_finish = function(self)
    mod:hook_disable(ContextAwarePingExtension, "ping_attempt")
end

return dont_ping