local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't dodge

    Forces victim to not dodge.
--]]

local dodge = 0
mod:hook_safe(PlayerCharacterStateDodging, "start_dodge", function(self)
    local player_unit = mod:player_unit_from_peer_id(mod:my_peer_id())
    if player_unit == self.unit then
        dodge = dodge + 1
    end
end)
mod:hook_disable(PlayerCharacterStateDodging, "start_dodge")

local dont_dodge = mod:get_template()
dont_dodge.id = "dont_dodge"
dont_dodge.text = mod:localize("dont_dodge_text")
dont_dodge.reminder = mod:localize("dont_dodge_reminder")
dont_dodge.time = 0
dont_dodge.punishments = {"damage"}
dont_dodge.values = {damage = 15}
dont_dodge.reminder_time = 0
dont_dodge.on_start = function(self)
    dodge = 0
    mod:hook_enable(PlayerCharacterStateDodging, "start_dodge")
end
dont_dodge.check_state_function = function(self)
    if dodge > 0 then
        dodge = dodge - 1
        return false
    end
    return true
end
dont_dodge.on_finish = function(self)
    mod:hook_disable(PlayerCharacterStateDodging, "start_dodge")
end

return dont_dodge