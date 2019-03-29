local mod = get_mod("i_dare_you")
--[[
	I dare you!

	Dare List and dare API.
	Dare API to register dares from other mods.
--]]

local test_keys = false
local test_keys_skip = {"look", "move", "move_controller"}

mod.registered_key_checks = {}
mod.register_key_check = function(self, key_names, callback)
	for _, key_name in pairs(key_names) do
		self.registered_key_checks[#self.registered_key_checks+1] = {
			key_name = key_name,
			callback = callback,
		}
	end
end
mod:hook(PlayerInputExtension, "get", function(func, self, input_key, ...)
	local value = func(self, input_key, ...)
	if value then
		for _, key_check in pairs(mod.registered_key_checks) do
			if key_check.key_name == input_key then key_check.callback() end
		end
		if test_keys and not table.contains(test_keys_skip, input_key) then
			mod:echo(input_key)
		end
	end
    return value
end)

mod.dare_types = {
	state = 1,
	action = 2,
}

mod.punishment_types = {
	damage = 1,
}

mod.template_dare = {
	-- Data
	id = "template_dare",
	text = "template_dare",
	text_color = {255, 255, 255, 255},
	reminder = "template_dare_reminder",
	fallible = true,
	type = mod.dare_types.state,
	is_finishing = false,
	punishments = {
		"damage",
	},
	values = {
        damage = 5,
	},
	started = false,
	-- Timers
	timer = 0,
	time = 1,
	length = 30,
	reminder_timer = 0,
    reminder_time = 2,
	-- Functions
	check_condition = function(self, selector_peer_id, victim_peer_id)
		return true
	end,
	start = function(self)
		self.started = true
		self.timer = 0
		self.reminder_timer = 0
		self:on_start()
	end,
	on_start = function(self)
	end,
	check_state_function = function(self)
		return true
	end,
	trigger_action_function = function(self)
		self:punish()
	end,
	update = function(self, dt)
		if not self.is_finishing then
			local peer_id = mod:my_peer_id()
            local unit = mod:player_unit_from_peer_id(peer_id)
			if mod:is_peer_id_alive(peer_id) then
				if not self:check_state_function() then
					-- State timer
					self.timer = self.timer + dt
					if self.timer >= self.time then
						-- Punish!
						self.timer = 0
						self:punish()
					end
					-- Reminder timer
					self.reminder_timer = self.reminder_timer + dt
					if self.reminder_timer >= self.reminder_time then
						-- Remind!
						self.reminder_timer = 0
						mod:remind_dare()
					end
				else
					-- Good
					self.timer = 0
                    self.reminder_timer = 0
				end
			else
				mod:abort_dare("death")
			end
		end
		self:on_update()
	end,
	on_update = function(self)
	end,
	finish = function(self)
		self:on_finish()
	end,
	on_finish = function(self)
	end,
	punish = function(self)
		local rnd = math.random(1, #self.punishments)
        local punishment = self.punishments[rnd]
		local value = self.values[punishment]
		if punishment == "damage" then
			mod:add_damage(value)
		end
	end,
}

mod.get_template = function(self)
	return table.clone(self.template_dare)
end

mod.register_dare = function(self, dare)

end

local dares = {
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_jump_continuously"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_stay_on_ground"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_block"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_dodge"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_use_melee"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_use_ranged"),
	-- {
	-- 	id = "reverse_camera",
	-- 	text = "reverse_camera",
	-- 	fallible = false,
	-- 	punishment = "none",
	-- },
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_quick_switch"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_use_skill"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_push"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_drop_grim"),
	mod:dofile("scripts/mods/i_dare_you/i_dare_you_dont_use_item"),
	-- {
	-- 	id = "dont_do_headshots",
	-- 	text = "dont_do_headshots",
	-- 	fallible = true,
	-- 	punishment = "damage",
	-- },
	-- {
	-- 	id = "fight_invisible_enemies",
	-- 	text = "dont_do_headshots",
	-- 	fallible = false,
	-- 	punishment = "damage",
	-- },
}

return dares
