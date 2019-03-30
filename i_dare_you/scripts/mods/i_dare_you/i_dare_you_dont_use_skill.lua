local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use skill

    Forces victim to not use skill.
--]]

local career_skill = 0
mod:hook(CareerExtension, "start_activated_ability_cooldown", function(func, self, ...)
    local player = Managers.player:player_from_peer_id(mod:my_peer_id())
    if self.player and self.player == player then
        if not self._initial_cooldown then
            career_skill = career_skill + 1
        end
    end
    return func(self, ...)
end)
mod:hook_disable(CareerExtension, "start_activated_ability_cooldown")

local dont_use_skill = mod:get_template()
dont_use_skill.id = "dont_use_skill"
dont_use_skill.text = mod:localize("dont_use_skill_text")
dont_use_skill.reminder = mod:localize("dont_use_skill_reminder")
dont_use_skill.time = 0
dont_use_skill.punishments = {"damage"}
dont_use_skill.values = {damage = 25}
dont_use_skill.reminder_time = 0
dont_use_skill.on_start = function(self)
    mod:hook_enable(CareerExtension, "start_activated_ability_cooldown")
end
dont_use_skill.check_state_function = function(self)
    if career_skill > 0 then
        career_skill = career_skill - 1
        return false
    end
    return true
end
dont_use_skill.on_finish = function(self)
    mod:hook_disable(CareerExtension, "start_activated_ability_cooldown")
end

return dont_use_skill