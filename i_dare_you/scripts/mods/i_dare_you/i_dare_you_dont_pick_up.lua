local mod = get_mod("i_dare_you")
--[[
	I dare you! - Don't switch equipment

    Forces victim to not switch equipment.
--]]

local pickup = 0
mod:hook(InteractionDefinitions.pickup_object.client, "stop", function(func, world, interactor_unit, interactable_unit, data, config, t, result)
    if result == InteractionResult.SUCCESS then
        local player_unit = mod:player_unit_from_peer_id(mod:my_peer_id())
        if player_unit == interactor_unit then
            local pickup_extension = ScriptUnit.extension(interactable_unit, "pickup_system")
            local pickup_settings = pickup_extension:get_pickup_settings()
            if pickup_settings.type == "ammo" or pickup_settings.type == "inventory_item" then
                pickup = pickup + 1
            end
        end
    end
    return func(world, interactor_unit, interactable_unit, data, config, t, result)
end)
mod:hook_disable(InteractionDefinitions.pickup_object.client, "stop")

local dont_pick_up = mod:get_template()
dont_pick_up.id = "dont_pick_up"
dont_pick_up.text = mod:localize("dont_pick_up_text")
dont_pick_up.reminder = mod:localize("dont_pick_up_reminder")
dont_pick_up.time = 0
dont_pick_up.values.damage = 30
dont_pick_up.reminder_time = 0
dont_pick_up.on_start = function(self)
    pickup = 0
    mod:hook_enable(InteractionDefinitions.pickup_object.client, "stop")
end
dont_pick_up.check_state_function = function(self)
    if pickup > 0 then
        pickup = pickup - 1
        return false
    end
    return true
end
dont_pick_up.on_finish = function(self)
    mod:hook_disable(InteractionDefinitions.pickup_object.client, "stop")
end

return dont_pick_up