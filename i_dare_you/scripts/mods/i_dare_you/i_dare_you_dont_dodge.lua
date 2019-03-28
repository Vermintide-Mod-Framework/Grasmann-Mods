local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't dodge

    Forces victim to not dodge.
--]]

local dont_dodge = mod:get_template()
dont_dodge.id = "dont_dodge"
dont_dodge.text = mod:localize("dont_dodge_text")
dont_dodge.reminder = mod:localize("dont_dodge_reminder")
dont_dodge.time = 0.25
dont_dodge.punishments = {"damage"}
dont_dodge.values = {damage = 15}
dont_dodge.reminder_time = 0
dont_dodge.check_state_function = function(self)
    local peer_id = mod:my_peer_id()
    local unit = mod:player_unit_from_peer_id(peer_id)
    local status_extension = ScriptUnit.has_extension(unit, "status_system")
    if status_extension then
        local is_dodging = status_extension:get_is_dodging()
        if is_dodging then
            return false
        else
            return true
        end
    end
end

return dont_dodge