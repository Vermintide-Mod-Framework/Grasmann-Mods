local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't use quick switch

    Forces victim to not use quick switch.
--]]

local skip_one = false
local quick_switch = 0
mod:register_key_check({"wield_switch"}, function()
    if not skip_one then
        quick_switch = quick_switch + 1
        skip_one = true
    else
        skip_one = false
    end
end)

local dont_quick_switch = mod:get_template()
dont_quick_switch.id = "dont_quick_switch"
dont_quick_switch.text = mod:localize("dont_quick_switch_text")
dont_quick_switch.reminder = mod:localize("dont_quick_switch_reminder")
dont_quick_switch.time = 0
dont_quick_switch.punishments = {"damage"}
dont_quick_switch.values = {damage = 15}
dont_quick_switch.reminder_time = 0
dont_quick_switch.check_state_function = function(self)
    if quick_switch > 0 then
        quick_switch = quick_switch - 1
        return false
    else
        return true
    end
end

return dont_quick_switch