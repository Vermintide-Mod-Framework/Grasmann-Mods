local mod = get_mod("i_dare_you")
--[[
	I dare you!

	Lets you and your friends dare each other with insidious concequences.
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

-- Scale
local UIResolutionScale = UIResolutionScale or function()
	return RESOLUTION_LOOKUP.scale
end

-- Debugging
local debug = mod:get("debug")
--local test_dare = "dont_pick_up"

-- Load dares
mod.dares = mod:dofile("scripts/mods/i_dare_you/i_dare_you_dares")

--local test_dares = table.clone(mod.dares)

--local test_punishment = "catapult"

-- Persistent Data
mod:persistent_table("data", {
	-- Peer IDs
	selector_peer_id = nil,
	victim_peer_id = nil,
	-- Dare choices
	dares = {},
	punishments = {},
	all_id = nil,
	is_selecting = false,
	selection = false,
	-- Selected dare
	all = false,
	selected_dare = nil,
	punishment = nil,
	active_dare = nil,
	dare_time = 30,
	dare_running = false,
	deactivate_on_assisted_respawn = false,
	-- Settings
	active = nil,
	mode = 1,
	allow_inn = false,
	activate_dare_1 = nil,
	activate_dare_2 = nil,
	activate_dare_3 = nil,
	in_mission = false,
	-- Users
	mod_users = {},
})
mod.data = mod:persistent_table("data")
mod.data.mod_users = {}
if debug then
	mod.data.active_dare = nil
end

-- ##### ██╗███╗   ██╗██████╗ ██╗   ██╗████████╗ ######################################################################
-- ##### ██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝ ######################################################################
-- ##### ██║██╔██╗ ██║██████╔╝██║   ██║   ██║    ######################################################################
-- ##### ██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║    ######################################################################
-- ##### ██║██║ ╚████║██║     ╚██████╔╝   ██║    ######################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝    ######################################################################
--[[
	Test player knockdown
--]]
mod.test_player_knockdown = function(held)
	mod:network_send("request_punishment_server", mod:server_peer_id(), 9999)
end
--[[
	Input functions used by chat commands and hotkeys
--]]
mod.activate_dare_1 = function(held, automatic)
	mod:activate_dare(1, automatic)
end
mod.activate_dare_2 = function(held, automatic)
	mod:activate_dare(2, automatic)
end
mod.activate_dare_3 = function(held, automatic)
	mod:activate_dare(3, automatic)
end
mod.activate_random_dare = function(held, automatic)
	local rnd = math.random(1, #mod.data.dares)
	mod:activate_dare(rnd, automatic)
end
--[[
	Evaluating input functions
--]]
mod.activate_dare = function(self, id, automatic)
	if self.data.is_selecting or automatic then
		if self.data.dares[id] then
			self.data.selected_dare = self.data.dares[id].id
			self.data.punishment = self.data.punishments[id]
			self.data.is_selecting = false
			local server_peer_id = self:server_peer_id()
			self:network_send("dare_selected_server", server_peer_id, self.data.selected_dare, mod.data.all_id == id, self.data.punishment)
		end
	end
end
--[[
	Start server
--]]
mod.start_server = function()
	if mod:is_server() then
		mod.server:stop()
		mod.server:start()
	end
end
mod.stop_server = function()
	if mod:is_server() then
		mod.server:stop()
	end
end
--[[
	Chat commands
--]]
mod:command("start_server", "Start I dare You! server.", mod.start_server)
mod:command("stop_server", "Stop I dare You! server.", mod.stop_server)
mod:command("dare1", "Choose dare 1.", mod.activate_dare_1)
mod:command("dare2", "Choose dare 2.", mod.activate_dare_2)
mod:command("dare3", "Choose dare 3.", mod.activate_dare_3)

-- ##### ██████╗ ██████╗  ██████╗  ██████╗ █████╗ ██╗     ██╗     ███████╗ ############################################
-- ##### ██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔══██╗██║     ██║     ██╔════╝ ############################################
-- ##### ██████╔╝██████╔╝██║█████╗██║     ███████║██║     ██║     ███████╗ ############################################
-- ##### ██╔══██╗██╔═══╝ ██║╚════╝██║     ██╔══██║██║     ██║     ╚════██║ ############################################
-- ##### ██║  ██║██║     ╚██████╗ ╚██████╗██║  ██║███████╗███████╗███████║ ############################################
-- ##### ╚═╝  ╚═╝╚═╝      ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ############################################
--[[
	Handshake to see if mod is active
	Clients receive this from server
--]]
mod:network_register("handshake_client", function(sender)
	-- "sender" is server
	mod:network_send("handshake_server", sender, mod.data.active)
end)
--[[
	Handshake reply
	Server receives this from clients
--]]
mod:network_register("handshake_server", function(sender, active)
	if debug then
		if active then mod:echo("Joined user '"..tostring(sender).."' has mod active!")
		else mod:echo("Joined user '"..tostring(sender).."' has mod NOT active!") end
	end
	if active then
		mod.server:add_mod_user(sender)
	end
end)
--[[
	Reset UI
	Everyone receives this from server
--]]
mod:network_register("reset_ui_client", function(sender, state_name)
	state_name = state_name or "idle"
	mod.ui:set_state(state_name)
end)
--[[
	Server was started
	Clients receive this from server
--]]
mod:network_register("start_server_client", function(sender)
	mod.ui:set_state("start_server_grow")
end)
--[[
	Start dare selection
	Everyone receives this from server
--]]
mod:network_register("start_dare_selection_client", function(sender, selector_peer_id, victim_peer_id, dares, time, all_id, punishments)
	if debug then
		mod:echo("Selector:'"..tostring(selector_peer_id).."'")
		mod:echo("Victim:'"..tostring(victim_peer_id).."'")
		local dare_list = ""
		for i, dare in pairs(dares) do
			dare_list = dare_list..dare
			if i < #dares then dare_list = dare_list..", " end
		end
		mod:echo("Dares:'"..dare_list.."'")
	end
	mod.data.selector_peer_id = selector_peer_id
	mod.data.victim_peer_id = victim_peer_id
	local active_dares = {}
	for _, dare in pairs(dares) do
		active_dares[#active_dares+1] = mod:get_dare(dare)
	end
	mod.data.dares = active_dares
	mod.data.punishments = punishments
	mod.data.all_id = all_id
	mod:echo("Received all id:'"..tostring(all_id).."'")
	mod.ui:start_selection(time)
end)
--[[
	Dare was selected by selector
	Server receives this from clients
--]]
mod:network_register("dare_selected_server", function(sender, dare_name, all, punishment)
	local check_dare = mod:get_dare(dare_name)
	if check_dare then
		if debug then
			mod:echo("Dare '"..dare_name.."' valid!")
		end
		local time = mod:get(dare_name.."_dare_length") or 30
		if all then
			if debug then mod:echo("Activate dare for everyone!") end
		end
		local punishment = punishment or "damage"
		mod:network_send("dare_selected_client", "all", mod.data.selector_peer_id, mod.data.victim_peer_id, dare_name, time, all, punishment)
		mod.server:set_state("countdown")
	else
		if debug then
			mod:echo("Dare '"..dare_name.."' invalid!")
		end
	end
end)
--[[
	Dare was selected
	Clients receive this from server
--]]
mod:network_register("dare_selected_client", function(sender, selector_peer_id, victim_peer_id, dare_name, time, all, punishment)
	if debug then
		mod:echo("Selector:'"..tostring(selector_peer_id).."'")
		mod:echo("Victim:'"..tostring(victim_peer_id).."'")
		mod:echo("Selected dare:'"..dare_name.."'")
		mod:echo("Time of dare: '"..tostring(time).."'")
	end
	mod.data.selector_peer_id = selector_peer_id
	mod.data.victim_peer_id = victim_peer_id
	mod.data.is_selecting = false
	mod.data.selection = false
	mod.data.selected_dare = dare_name
	mod.data.punishment = punishment
	if debug then
		mod:echo("Selected punishment: '"..punishment.."'")
	end
	mod.data.dare_time = time
	mod.data.all = all
	if mod:is_victim() then
		mod:set_dare(dare_name, time)
	end
	mod.ui:set_state("show_selection")
end)
--[[
	Start dare on client
	Clients receive this from server
--]]
mod:network_register("start_dare_client", function(sender, dare_name, time)
	if mod:is_server() then
		-- Special options
		mod.data.deactivate_on_assisted_respawn = mod:get(dare_name.."_deactivate_on_assisted_respawn")
		if mod.data.deactivate_on_assisted_respawn then
			if debug then
				mod:echo("Dare '"..dare_name.."' not effective during assisted respawn")
			end
		end
	end
	if mod:is_victim() then
		if debug then
			mod:echo("Dare '"..dare_name.."' started.")
		end
		--mod:set_dare(dare_name, time)
		mod:start_dare()
	end
	mod.data.dare_time = time
	mod.data.dare_running = true
	mod.ui:set_state("waiting", time)
end)
--[[
	Sync active dare running time
	Clients receive this from server
--]]
mod:network_register("sync_time_client", function(sender, time)
	if debug then
		mod:echo("Dare time synced to '"..tostring(time).."'.")
	end
	mod.data.dare_time = time
end)
--[[
	Dare finished
	Server receives this from clients
--]]
mod:network_register("dare_finished_server", function(sender, reason)
	if not mod.data.all then
		if debug then
			mod:echo("Dare finished! Reason:'"..reason.."'")
		end
		mod:network_send("dare_finished_client", "all", reason)
		mod.server:set_state("selection")
	end
end)
--[[
	Dare finished
	Clients receive this from server
--]]
mod:network_register("dare_finished_client", function(sender, reason)
	if not mod.data.all or reason ~= "death" then
		if debug then
			mod:echo("Dare finished! Reason:'"..reason.."'")
		end
		if mod:is_victim() or mod.data.active_dare then
			mod:finish_dare()
		end
		mod.data.dare_running = false
		mod.data.all = false
	end
end)
--[[
	Request punishment
	Server receives this from clients
--]]
mod:network_register("request_punishment_server", function(sender, value)
	local skip_punishment = (mod.data.deactivate_on_assisted_respawn and mod:is_helping_assisted_respawn(sender))
	if not skip_punishment then
		local unit = mod:player_unit_from_peer_id(sender)
		if unit then
			-- Do special punishment
			if value then
				if debug then
					mod:echo("Player '"..sender.."' requested punishment of '"..tostring(value).."'!")
				end
				DamageUtils.add_damage_network(unit, unit, value, "full", "forced", nil, Vector3(0, 0, 1), "debug")
				return
			end
			-- Get punishment and value
			local dare = mod:get_dare(mod.data.selected_dare)
			local value = dare.values[mod.data.punishment]
			-- Random hit_direction
			local unit_position = Unit.world_position(unit, 0)
			local damage_position = unit_position + Vector3(math.random(-100, 100), math.random(-100, 100), 0)
			local random_hit_direction = Vector3.normalize(unit_position - damage_position)
			if debug then
				mod:echo("Player '"..sender.."' requested punishment '"..mod.data.punishment.."' of '"..tostring(value).."'!")
			end
			-- Apply punishment
			if mod.data.punishment == "damage" then
				local health_extension = ScriptUnit.has_extension(unit, "health_system")
				if health_extension and health_extension:is_alive() then
					DamageUtils.add_damage_network(unit, unit, value, "full", "forced", nil, random_hit_direction, "debug")
				end
			elseif mod.data.punishment == "catapult" then
				local velocity = value * random_hit_direction
				Vector3.set_z(velocity, value / 2)
				StatusUtils.set_catapulted_network(unit, true, velocity)
			end
			--DamageUtils.add_damage_network(unit, unit, value, "full", "forced", nil, Vector3(0, 0, 1), "debug")
			--DamageUtils.add_damage_network(target_unit, attacker_unit, damage, "torso", action.damage_type, nil, damage_direction, damage_source, nil, nil, nil, action.hit_react_type)
		end
	end
end)
--[[
	User deactivated mod
--]]
mod:network_register("user_deactivated_mod", function(sender)
	if mod:is_server() then
		mod.server:remove_mod_user(sender)
	end
end)
--[[
	User activates mod
--]]
mod:network_register("user_activated_mod", function(sender)
	if mod:is_server() then
		mod.server:add_mod_user(sender)
	end
end)

-- #####  █████╗  ██████╗████████╗██╗██╗   ██╗███████╗    ██████╗  █████╗ ██████╗ ███████╗ ############################
-- ##### ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ############################
-- ##### ███████║██║        ██║   ██║██║   ██║█████╗      ██║  ██║███████║██████╔╝█████╗   ############################
-- ##### ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝      ██║  ██║██╔══██║██╔══██╗██╔══╝   ############################
-- ##### ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗    ██████╔╝██║  ██║██║  ██║███████╗ ############################
-- ##### ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ############################
--[[
	Get dare from table by name
--]]
mod.get_dare = function(self, dare_name)
	for _, dare in pairs(self.dares) do
		if dare.id == dare_name then
			return dare
		end
	end
	return nil
end
--[[
	Set active dare and start it
--]]
mod.set_dare = function(self, dare_name, time)
	local dare = self:get_dare(dare_name)
	dare.started = false
	dare.length = time or 30
	self.data.active_dare = dare
	--self:start_dare()
end
--[[
	Start active dare
--]]
mod.start_dare = function(self)
	if self.data.active_dare then
		if self.data.active_dare.start then self.data.active_dare:start() end
	end
end
--[[
	Update active dare
--]]
mod.update_dare = function(self, dt)
	if self.data.active_dare and self.data.active_dare.started then
		self.data.active_dare.length = self.data.active_dare.length - dt
		if self.data.active_dare.update then self.data.active_dare:update(dt) end
	end
end
--[[
	Abort active dare with a reason
--]]
mod.abort_dare = function(self, reason)
	if not mod.data.all then
		self:network_send("dare_finished_server", self:server_peer_id(), reason)
	end
end
--[[
	Finish active dare
--]]
mod.finish_dare = function(self)
	if self.data.active_dare then
		if self.data.active_dare.finish then self.data.active_dare:finish() end
		self.data.active_dare = nil
	end
end
--[[
	Trigger dare reminder in UI
--]]
mod.remind_dare = function(self)
	self.ui:remind()
end
--[[
	Add damage as punishment
--]]
mod.request_punishment = function(self, value)
	self:network_send("request_punishment_server", self:server_peer_id())
end

mod.punishment_text = function(self, punishment)
	return self.punishment_types[punishment]
end

-- ##### ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗  ############################################################
-- ##### ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗ ############################################################
-- ##### ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝ ############################################################
-- ##### ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗ ############################################################
-- ##### ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║ ############################################################
-- ##### ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝ ############################################################
--[[
	Server mechanics
--]]
mod.server = {
	state = nil,
	timer = 0,
	show_title = false,
	--mod_users = {},
	--[[
		Start server system
	--]]
	start = function(self)
		mod:network_send("reset_ui_client", "all")
		mod:network_send("dare_finished_client", "all", "server_start")
		if mod:has_enough_players() and not mod:is_in_inn() and self:has_enough_activated_dares() then
			if mod.data.in_mission and not test_dares then
				--mod:echo(mod:localize("start_i_dare_you"))
				self.show_title = true,
				self:set_state("init")
			end
		else
			self:stop()
		end
	end,
	start_soft = function(self)
		if self.state and self.state.id == 0 then
			self:start()
		end
	end,
	--[[
		Stop server
	--]]
	stop = function(self)
		mod:network_send("reset_ui_client", "all")
		mod:network_send("dare_finished_client", "all", "server_shutdown")
		if not mod:has_enough_players() then
			if debug then mod:echo(mod:localize("error_not_enough_players")) end
		end
		if mod:is_in_inn() then
			if debug then mod:echo(mod:localize("error_in_inn")) end
		end
		if not self:has_enough_activated_dares() then
			mod:echo(mod:localize("error_not_enough_dares"))
		end
		self:set_state("idle")
	end,
	--[[
		Check if server needs to be stopped
	--]]
	check = function(self)
		if not mod:has_enough_players() then
			self:stop()
		end
	end,
	--[[
		Add mod user
	--]]
	add_mod_user = function(self, peer_id)
		--mod.data.mod_users[#mod.data.mod_users+1] = peer_id
		if not self:get_user_index(peer_id) then
			table.insert(mod.data.mod_users, peer_id)
		end
		if debug then
			mod:dump(mod.data.mod_users, "mod.data.mod_users", 2)
		end
		if self.state and self.state.id == 0 then
			self:start()
		end
	end,
	--[[
		Get user index
	--]]
	get_user_index = function(self, peer_id)
		for i, user_peer_id in pairs(mod.data.mod_users) do
			if user_peer_id == peer_id then
				return i
			end
		end
		return nil
	end,
	--[[
		Remove mod user
	--]]
	remove_mod_user = function(self, peer_id)
		local index = self:get_user_index(peer_id)
		if index then
			--mod.data.mod_users[peer_id] = nil
			table.remove(mod.data.mod_users, index)
			if debug then
				mod:dump(mod.data.mod_users, "mod.data.mod_users", 2)
			end
			self:check()
		end
	end,
	--[[
		Server states
	--]]
	states = {
		idle = {
			id = 0,
			time = 0,
			start = function(self)
			end,
			finish = function(self)
			end,
		},
		init = {
			id = 1,
			time = 10,
			title_in = 5,
			start = function(self)
			end,
			update = function(self, dt)
				if mod.server.show_title and mod.server.timer >= self.title_in then
					mod.server.show_title = false
					mod:network_send("start_server_client", "all")
				end
			end,
			finish = function(self)
				mod.server:set_state("selection")
			end,
		},
		waiting = {
			id = 2,
			time = 30,
			sync_in = 5,
			sync_timer = 0,
			start = function(self)
				self.sync_timer = 0
			end,
			update = function(self, dt)
				self.sync_timer = self.sync_timer + dt
				if self.sync_timer >= self.sync_in then
					local time_left = self.time - mod.server.timer
					mod:network_send("sync_time_client", "all", time_left)
					self.sync_timer = 0
				end
			end,
			finish = function(self)
				mod:network_send("dare_finished_client", "all", "time")
				mod.server:set_state("selection")
			end,
		},
		selection = {
			id = 3,
			time = 11,
			start = function(self)
				local selector_peer_id = mod:random_player()
				local victim_peer_id = mod:random_player()
				if mod.data.mode < 3 or #mod.data.mod_users > 1 then
					victim_peer_id = mod:random_player(selector_peer_id)
				end
				if selector_peer_id and victim_peer_id then
					local dares, all_id, punishments = mod.server:get_random_dares(selector_peer_id, victim_peer_id)
					if dares then
						local time = mod:get("selection_time")
						mod:network_send("start_dare_selection_client", "all", selector_peer_id, victim_peer_id, dares, time, all_id, punishments)
					end
				else
					if mod:has_enough_players() then
						if debug then mod:echo("Not enough players alive!") end
						mod.server:set_state("waiting_for_something")
					else
						mod.server:stop()
					end
				end
			end,
			finish = function(self)
				if debug then
					mod:echo("automatic selection!")
				end
				-- local rnd = math.random(1, 3)
				-- mod["activate_dare_"..tostring(rnd)](nil, true)
				mod.activate_random_dare(nil, true)
				mod.server:set_state("countdown")
			end,
		},
		countdown = {
			id = 4,
			time = 5,
			start = function(self)
			end,
			finish = function(self)
				local time = mod:get(mod.data.selected_dare.."_dare_length")
				mod:network_send("start_dare_client", "all", mod.data.selected_dare, time)
				mod.server:set_state("waiting", time)
			end,
		},
		waiting_for_something = {
			id = 5,
			time = 5,
			start = function(self)
				mod:network_send("reset_ui_client", "all")
				mod:network_send("dare_finished_client", "all", "not_enough_players")
			end,
			finish = function(self)
				if debug then mod:echo("Parameters don't meet conditions. We're waiting!") end
				mod.server:set_state("selection")
			end,
		}
	},
	--[[
		Get list of available dares
	--]]
	get_available_dares = function(self, selector_peer_id, victim_peer_id)
		local available_dares = {}
		for _, dare in pairs(mod.dares) do
			if mod:get(dare.id) then
				if not dare.check_condition or dare:check_condition(selector_peer_id, victim_peer_id) then
					available_dares[#available_dares+1] = dare.id
				end
			else
				if debug then mod:echo("Dare '"..dare.id.."' is deactivated") end
			end
		end
		return available_dares
	end,
	--[[
		Get activated dares
	--]]
	has_enough_activated_dares = function(self)
		local activated_dares = 0
		for _, dare in pairs(mod.dares) do
			if mod:get(dare.id) then
				activated_dares = activated_dares + 1
			end
		end
		if activated_dares > 2 then
			return true
		end
		return false
	end,
	--[[
		Get available punishments for a dare
	--]]
	get_available_punishments = function(self, dare_name)
		local available_punishments = {}
		local dare = mod:get_dare(dare_name)
		if dare then
			for _, punishment in pairs(dare.punishments) do
				local common_option = mod:get("punishment_"..punishment)
				local specific_option = mod:get(dare.id.."_allow_"..punishment)
				if punishment == "damage" or (common_option and specific_option) then
					available_punishments[#available_punishments+1] = punishment
				else
					if debug then
						if not common_option then mod:echo("Punishment '"..punishment.."' deactivated.") end
						if not specific_option then mod:echo("Punishment '"..punishment.."' deactivated for dare "..dare_name.."'.") end
					end
				end
			end
		end
		return available_punishments
	end,
	--[[
		Get set of random dares
	--]]
	get_random_dares = function(self, selector_peer_id, victim_peer_id)
		--local available_dares = table.clone(mod.dares)
		local available_dares = self:get_available_dares(selector_peer_id, victim_peer_id)
		if #available_dares < 1 then
			-- mod:echo(mod:localize("error_not_enough_dares"))
			-- self:stop()
			self:set_state("waiting_for_something")
			return
		end
		local dares = {}
		local punishments = {}
		local all_rolled = false
		local all_id = nil
		local max_dares = 3
		if #available_dares < 3 then max_dares = #available_dares end
		for i = 1, max_dares do
			local rnd = math.random(1, #available_dares)
			--dares[#dares+1] = available_dares[rnd].id --table.clone(available_dares[rnd])
			local dare_name = available_dares[rnd]
			-- Roll party dare
			if not all_rolled and mod:get("all_players") then
				all_rolled = self:roll_all_chance(dare_name)
				if all_rolled then all_id = #dares+1 end
			end
			dares[#dares+1] = dare_name
			table.remove(available_dares, rnd)
			-- Roll punishment
			local available_punishments = self:get_available_punishments(dare_name)
			local rnd = math.random(1, #available_punishments)
			local punishment = available_punishments[rnd]
			punishments[#punishments+1] = punishment
			if test_punishment then
				if table.contains(available_punishments, test_punishment) then
					punishments[#punishments] = test_punishment
				end
			end
		end
		--mod:dump(dares, "dares", 1)
		if test_dare then
			local found = false
			for _, dare in pairs(dares) do
				if dare == test_dare then
					found = true
					break
				end
			end
			if found == false then
				local dare = mod:get_dare(test_dare)
				if mod:get(test_dare) then
					if not dare.check_condition or dare:check_condition(selector_peer_id, victim_peer_id) then
						local rnd = math.random(1, 3)
						dares[rnd] = test_dare

						local available_punishments = self:get_available_punishments(test_dare)
						local p_rnd = math.random(1, #available_punishments)
						local punishment = available_punishments[p_rnd]
						punishments[rnd] = punishment
						if test_punishment then
							if table.contains(available_punishments, test_punishment) then
								punishments[rnd] = test_punishment
							end
						end

						mod:echo("Added test dare '"..test_dare.."' with punishment '"..punishment.."'!")
					end
				else
					if debug then mod:echo("Dare '"..dare.id.."' is deactivated") end
				end
			end
		end
		return dares, all_id, punishments
	end,
	--[[
		Roll for a chance to affect the whole team
	--]]
	roll_all_chance = function(self, dare_name)
		local dare = mod:get_dare(dare_name)
		local all_pass = true
		for _, peer_id in pairs(mod.data.mod_users) do
			if not dare:check_condition(nil, peer_id) then
				all_pass = false
				break
			end
		end
		if all_pass then
			local rnd = math.random(1, 100)
			if rnd <= mod:get("all_players_chance") then
				return true
			end
		end
		return false
	end,
	--[[
		Set server state
	--]]
	set_state = function(self, state_name, time)
		local state = self.states[state_name]
		if state then
			if debug then mod:echo("State '"..state_name.."' started!") end
			self.state = state
			if self.state.id == 1 then
				self.state.time = mod:get("initial_time") or 10
			elseif self.state.id == 2 then
				self.state.time = time or 30
			elseif self.state.id == 3 then
				self.state.time = mod:get("selection_time") + 1 or 11
			end
			self.timer = 0
			self.state:start()
		else
			mod:echo("Unknown State '"..state_name.."'!")
		end
	end,
	--[[
		Update server mechanics
	--]]
	update = function(self, dt)
		-- If state is nil return
		if not self.state then
			return
		end
		-- Evaluate state
		if self.state == self.states.idle then
			return
		else
			self.timer = self.timer + dt
			if self.timer >= self.state.time then
				self.state:finish()
			elseif self.state.update then
				self.state:update(dt)
			end
		end
	end,
}

-- ##### ██╗   ██╗██╗     ██████╗ ██████╗ ██████╗ ███████╗ ############################################################
-- ##### ██║   ██║██║    ██╔════╝██╔═══██╗██╔══██╗██╔════╝ ############################################################
-- ##### ██║   ██║██║    ██║     ██║   ██║██║  ██║█████╗   ############################################################
-- ##### ██║   ██║██║    ██║     ██║   ██║██║  ██║██╔══╝   ############################################################
-- ##### ╚██████╔╝██║    ╚██████╗╚██████╔╝██████╔╝███████╗ ############################################################
-- #####  ╚═════╝ ╚═╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝ ############################################################
--[[
	UI mechanics
--]]
mod.ui = {
	state = nil,
	timer = 0,
	widgets = {},
	countdown = 0,
	selection_time = 10,
	ui_renderer = nil,
	--[[
		UI states
	--]]
	states = {
		idle = {
			render = {},
			name = "idle",
			time = 0,
			start = function(self)
			end,
			finish = function(self)
			end,
		},
		start_server_grow = {
			render = { "mod_title" },
			name = "start_server_grow",
			mod_title = {
				start_size = 0,
				finish_size = 120,
				update_size = true,
				start_offset = {0, 0, 0},
				fade_in = true,
				fade_in_time = 0.5,
				text = "mod_title",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
				mod:play_sound_effect("Play_career_ability_bardin_ranger_enter")
			end,
			finish = function(self)
				mod.ui:set_state("start_server_pop")
			end,
		},
		start_server_pop = {
			render = { "mod_title" },
			name = "start_server_pop",
			mod_title = {
				start_size = 120,
				finish_size = 80,
				update_size = true,
				start_offset = {0, 0, 0},
				text = "mod_title",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
				mod:play_sound_effect("Play_career_ability_kerillian_shade_enter")
			end,
			finish = function(self)
				mod.ui:set_state("start_server_fade")
			end,
		},
		start_server_fade = {
			render = { "mod_title" },
			name = "start_server_fade",
			mod_title = {
				start_size = 80,
				start_offset = {0, 0, 0},
				fade_out = true,
				fade_out_time = 3,
				text = "mod_title",
			},
			time = 3,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("idle")
			end,
		},
		waiting = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "active_countdown" },
			name = "waiting",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "active_countdown",
				update_text = true,
				apply_text_size = "left",
			},
			time = 30,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
			end,
		},
		reminder_grow = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "reminder", "active_countdown" },
			name = "reminder_grow",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			reminder = {
				start_size = 0,
				finish_size = 120,
				update_size = true,
				start_offset = {0, 0, 0},
				fade_in = true,
				fade_in_time = 0.5,
				text = "reminder",
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "active_countdown",
				update_text = true,
				apply_text_size = "left",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("reminder_pop")
			end,
		},
		reminder_pop = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "reminder", "active_countdown" },
			name = "reminder_pop",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			reminder = {
				start_size = 120,
				finish_size = 80,
				update_size = true,
				start_offset = {0, 0, 0},
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "active_countdown",
				update_text = true,
				apply_text_size = "left",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
				mod:play_sound_effect("Play_hud_headshot")
			end,
			finish = function(self)
				mod.ui:set_state("reminder_fade")
			end,
		},
		reminder_fade = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "reminder", "active_countdown" },
			name = "reminder_fade",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			reminder = {
				start_size = 80,
				start_offset = {0, 0, 0},
				fade_out = true,
				fade_out_time = 2,
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "active_countdown",
				update_text = true,
				apply_text_size = "left",
			},
			time = 2,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("waiting")
			end,
		},
		waiting_fade = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "active_countdown" },
			name = "waiting_fade",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				fade_out = true,
				fade_out_time = 0.5,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				fade_out = true,
				fade_out_time = 0.5,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				fade_out = true,
				fade_out_time = 0.5,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				fade_out = true,
				fade_out_time = 0.5,
				apply_text_size = "left",
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "0",
				fade_out = true,
				fade_out_time = 0.5,
				apply_text_size = "left",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("selection_grow")
			end,
		},
		selection_grow = {
			render = { "title_incoming_dare", "title_choose_dare" },
			name = "selection_grow",
			title_incoming_dare = {
				start_size = 0,
				finish_size = 120,
				update_size = true,
				start_offset = {0, 0, 0},
				fade_in = true,
				fade_in_time = 0.5,
				text = "title",
			},
			title_choose_dare = {
				start_size = 0,
				finish_size = 120,
				update_size = true,
				start_offset = {0, 0, 0},
				fade_in = true,
				fade_in_time = 0.5,
				text = "title",
			},
			time = 0.5,
			start = function(self)
				mod.data.selection = true
				mod.ui:init_state()
			end,
			-- update = function(self)
			-- 	mod.ui:update_state()
			-- end,
			finish = function(self)
				mod.ui:set_state("selection_pop")
			end,
		},
		selection_pop = {
			render = { "title_incoming_dare", "title_choose_dare" },
			name = "selection_pop",
			title_incoming_dare = {
				start_size = 120,
				finish_size = 80,
				update_size = true,
				start_offset = {0, 0, 0},
				text = "title",
			},
			title_choose_dare = {
				start_size = 120,
				finish_size = 80,
				update_size = true,
				start_offset = {0, 0, 0},
				text = "title",
			},
			time = 0.25,
			start = function(self)
				mod.ui:init_state()
				mod:play_sound_effect("Play_hud_headshot")
			end,
			finish = function(self)
				mod.ui:set_state("selection_move_up")
			end,
		},
		selection_move_up = {
			render = { "title_incoming_dare", "title_choose_dare" },
			name = "selection_move_up",
			title_incoming_dare = {
				start_offset = {0, 0, 0},
				finish_offset = {0, 400, 0},
				update_offset = true,
				start_size = 80,
				text = "title",
			},
			title_choose_dare = {
				start_offset = {0, 0, 0},
				finish_offset = {0, 400, 0},
				update_offset = true,
				start_size = 80,
				text = "title",
			},
			time = 0.25,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("waiting_for_input")
			end,
		},
		waiting_for_input = {
			render = { "title_incoming_dare", "title_choose_dare", "victim_name", "dare_1", "dare_2", "dare_3", "counter" },
			name = "waiting_for_input",
			title_incoming_dare = {
				start_offset = {0, 400, 0},
				start_size = 80,
				text = "title",
			},
			title_choose_dare = {
				start_offset = {0, 400, 0},
				start_size = 80,
				text = "title",
			},
			victim_name = {
				start_offset = {0, 350, 0},
				start_size = 40,
				text = "victim_name",
				fade_in = true,
				fade_in_time = 0.5,
			},
			dare_1 = {
				start_offset = {0, -320, 0},
				start_size = 30,
				text = "dare_1_hotkey",
				fade_in = true,
				fade_in_time = 0.5,
			},
			dare_2 = {
				start_offset = {0, -360, 0},
				start_size = 30,
				text = "dare_2_hotkey",
				fade_in = true,
				fade_in_time = 0.5,
			},
			dare_3 = {
				start_offset = {0, -400, 0},
				start_size = 30,
				text = "dare_3_hotkey",
				fade_in = true,
				fade_in_time = 0.5,
			},
			counter = {
				start_offset = {0, -280, 0},
				start_size = 30,
				text = "time",
				update_text = true,
				fade_in = true,
				fade_in_time = 0.5,
			},
			time = 10,
			start = function(self)
				mod.ui:init_state()
				if mod.is_selector() then
					mod.data.is_selecting = true
					-- Random choice
					if mod:get("random_choice") then
						mod.activate_random_dare(nil)
					end
				end
			end,
			finish = function(self)
				-- if mod:is_selector() then
				-- 	if mod.data.is_selecting then
				-- 		-- Time's up -> random choice
				-- 		local rnd = math.random(1, 3)
				-- 		mod["activate_dare_"..tostring(rnd)]()
				-- 		--mod.data.is_selecting = false
				-- 	end
				-- end
				-- mod.ui:set_state("show_selection")
			end,
		},
		show_selection = {
			render = { "title_incoming_dare", "title_choose_dare", "victim_name", "dare_1", "dare_2", "dare_3" },
			name = "show_selection",
			title_incoming_dare = {
				start_offset = {0, 400, 0},
				start_size = 80,
				fade_out = true,
				fade_out_time = 0.5,
				text = "title",
			},
			title_choose_dare = {
				start_offset = {0, 400, 0},
				start_size = 80,
				fade_out = true,
				fade_out_time = 0.5,
				text = "title",
			},
			victim_name = {
				start_offset = {0, 350, 0},
				finish_offset = {0, -40, 0},
				update_offset = true,
				start_size = 40,
				finish_size = 40,
				update_size = true,
				text = "victim_name",
			},
			dare_1 = {
				start_offset = {0, -320, 0},
				finish_offset = {0, 0, 0},
				update_offset = true,
				start_size = 30,
				finish_size = 60,
				update_size = true,
				text = "dare_1",
				fade_out = true,
				fade_out_time = 0.5,
			},
			dare_2 = {
				start_offset = {0, -360, 0},
				finish_offset = {0, 0, 0},
				update_offset = true,
				start_size = 30,
				finish_size = 60,
				update_size = true,
				text = "dare_2",
				fade_out = true,
				fade_out_time = 0.5,
			},
			dare_3 = {
				start_offset = {0, -400, 0},
				finish_offset = {0, 0, 0},
				update_offset = true,
				start_size = 30,
				finish_size = 60,
				update_size = true,
				text = "dare_3",
				fade_out = true,
				fade_out_time = 0.5,
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
				mod:play_sound_effect("Play_hud_headshot")
			end,
			finish = function(self)
				mod.ui:set_state("move_selection")
			end,
		},
		move_selection = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name" },
			name = "move_selection",
			victim_name = {
				start_offset = {0, -40, 0},
				finish_offset = {950, -40, 0},
				update_offset = true,
				start_size = 40,
				finish_size = 24,
				update_size = true,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {0, 0, 0},
				finish_offset = {950, 0, 0},
				update_offset = true,
				start_size = 60,
				finish_size = 30,
				update_size = true,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {0, 0, 0},
				finish_offset = {950, 0, 0},
				update_offset = true,
				start_size = 60,
				finish_size = 30,
				update_size = true,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {0, 0, 0},
				finish_offset = {950, 0, 0},
				update_offset = true,
				start_size = 60,
				finish_size = 30,
				update_size = true,
				apply_text_size = "left",
			},
			time = 0.5,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				--mod.ui:set_state("countdown_1")
				mod.ui:start_countdown(3)
			end,
		},
		countdown_1 = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "countdown" },
			name = "countdown_1",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			countdown = {
				start_offset = {0, 0, 0},
				start_size = 0,
				finish_size = 180,
				update_size = true,
				fade_in = true,
				fade_in_time = 0.75,
				text = "countdown",
			},
			time = 0.75,
			start = function(self)
				mod.ui:init_state()
			end,
			finish = function(self)
				mod.ui:set_state("countdown_1_pop")
			end,
		},
		countdown_1_pop = {
			render = { "dare_1", "dare_2", "dare_3", "victim_name", "countdown", "active_countdown" },
			name = "countdown_1_pop",
			victim_name = {
				start_offset = {950, -40, 0},
				start_size = 24,
				apply_text_size = "left",
			},
			dare_1 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_2 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			dare_3 = {
				start_offset = {950, 0, 0},
				start_size = 30,
				apply_text_size = "left",
			},
			countdown = {
				start_offset = {0, 0, 0},
				start_size = 180,
				finish_size = 120,
				update_size = true,
				fade_out = true,
				fade_out_time = 0.25,
			},
			active_countdown = {
				start_offset = {950, 40, 0},
				start_size = 24,
				text = "active_countdown",
				update_text = true,
				fade_in = true,
				fade_in_time = 0.5,
				apply_text_size = "left",
			},
			time = 0.25,
			start = function(self)
				mod.ui:init_state()
				if mod.ui.countdown > 0 then
					mod:play_sound_effect("Play_career_ability_kerillian_shade_enter")
				else
					mod:play_sound_effect("Play_career_ability_kruber_charge_hit_player")
				end
			end,
			finish = function(self)
				if mod.ui.countdown > 0 then
					mod.ui.countdown = mod.ui.countdown - 1
					mod.ui:set_state("countdown_1")
				else
					mod.ui:set_state("waiting")
				end
			end,
		},
	},
	--[[
		Start dare selection
	--]]
	start_selection = function(self, time)
		local name = self.state.name
		self.selection_time = time or 10
		if name == "waiting" or name == "reminder_grow" 
			or name == "reminder_pop" or name == "reminder_fade" then
			self:set_state("waiting_fade")
		else
			self:set_state("selection_grow")
		end
	end,
	--[[
		Start dare countdown
	--]]
	start_countdown = function(self, count)
		self.countdown = count
		self:set_state("countdown_1")
	end,
	--[[
		Check if dare reminder is visible
	--]]
	is_reminding = function(self)
		return self.state.name == "reminder_grow"
			or self.state.name == "reminder_pop"
			or self.state.name == "reminder_fade"
	end,
	--[[
		Show dare reminder
	--]]
	remind = function(self)
		if not self:is_reminding() then
			self:set_state("reminder_grow")
		end
	end,
	--[[
		Create widgets for UI
	--]]
	create_widgets = function(self)
		self.widgets = {}
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("title_incoming_dare", mod:localize("incoming_dare"), nil, nil, mod.is_not_selector)
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("title_choose_dare", mod:localize("choose_dare"), nil, nil, mod.is_selector)
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("mod_title", mod:localize("start_i_dare_you"))
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("reminder", "N/A")
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("countdown", "N/A")
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("active_countdown", "N/A")
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("victim_name", "N/A", 60, {0, 350, 0})
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("counter", "N/A", 30, {0, -280, 0})
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("dare_1", "N/A", 30, {0, -320, 0}, mod.is_selecting_or_selected)
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("dare_2", "N/A", 30, {0, -360, 0}, mod.is_selecting_or_selected)
		self.widgets[#self.widgets+1] = mod:create_simple_text_widget("dare_3", "N/A", 30, {0, -400, 0}, mod.is_selecting_or_selected)
	end,
	--[[
		Init state with defined start values
	--]]
	init_state = function(self)
		if self.state then
			for _, widget in pairs(self.widgets) do
				local animation = self.state[widget.content.id]
				if animation then
					widget.style.text.font_size = animation.start_size
					widget.style.text_shadow.font_size = animation.start_size
					widget.offset = self:apply_scale_to_offset(animation.start_offset)
					if animation.text then
						local found = false
						for i = 1, 3 do
							if animation.text == "dare_"..tostring(i) or (animation.text == "dare_"..tostring(i).."_hotkey" and not mod.is_selector()) then
								if mod.data.dares[i] then
									widget.content.text = string.format("%s ( %s )", mod.data.dares[i].text, mod:punishment_text(mod.data.punishments[i]))
									widget.style.text.text_color = mod.data.dares[i].text_color
									widget.content.dare_id = mod.data.dares[i].id
								else
									widget.content.text = ""
								end
								if mod.data.all_id == i then
									widget.style.text.text_color = {255, 255, 255, 0}
								end
								found = true
							elseif animation.text == "dare_"..tostring(i).."_hotkey" and mod.is_selector() then
								if mod.data.dares[i] then
									widget.content.text = string.format("%s: %s ( %s )", mod.data["activate_dare_"..tostring(i)], mod.data.dares[i].text, mod:punishment_text(mod.data.punishments[i]))
									widget.style.text.text_color = mod.data.dares[i].text_color
									widget.content.dare_id = mod.data.dares[i].id
								else
									widget.content.text = ""
								end
								if mod.data.all_id == i then
									widget.style.text.text_color = {255, 255, 255, 0}
								end
								found = true
							end
						end

						if animation.text == "victim_name" then
							local name = mod:localize("yourself")
							if mod.data.all then
								name = mod:localize("everybody")
								widget.style.text.text_color = {255, 255, 255, 0}
							elseif not mod:is_victim() then
								name = mod:player_name_from_peer_id(mod.data.victim_peer_id)
								widget.style.text.text_color = {255, 255, 255, 255}
							else
								widget.style.text.text_color = {255, 255, 0, 0}
							end
							widget.content.text = string.format(mod:localize("for_text"), name)
						elseif animation.text == "title" then
							if not mod.is_selector() then
								widget.style.text.text_color = {255, 255, 255, 255}
							else
								widget.style.text.text_color = {255, 255, 0, 0}
							end
						elseif animation.text == "mod_title" then
							widget.content.text = mod:localize("start_i_dare_you")
						-- elseif animation.text == "dare_1" or (animation.text == "dare_1_hotkey" and not mod.is_selector()) then
						-- 	if mod.data.dares[1] then
						-- 		widget.content.text = string.format("%s ( %s )", mod.data.dares[1].text, mod:punishment_text(mod.data.punishments[1]))
						-- 		widget.style.text.text_color = mod.data.dares[1].text_color
						-- 		widget.content.dare_id = mod.data.dares[1].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 1 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						-- elseif animation.text == "dare_1_hotkey" and mod.is_selector() then
						-- 	if mod.data.dares[1] then
						-- 		widget.content.text = string.format("%s: %s ( %s )", mod.data.activate_dare_1, mod.data.dares[1].text, mod:punishment_text(mod.data.punishments[1]))
						-- 		widget.style.text.text_color = mod.data.dares[1].text_color
						-- 		widget.content.dare_id = mod.data.dares[1].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 1 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						-- elseif animation.text == "dare_2" or (animation.text == "dare_2_hotkey" and not mod.is_selector()) then
						-- 	if mod.data.dares[2] then
						-- 		--widget.content.text = mod.data.dares[2].text
						-- 		widget.content.text = string.format("%s ( %s )", mod.data.dares[2].text, mod:punishment_text(mod.data.punishments[2]))
						-- 		widget.style.text.text_color = mod.data.dares[2].text_color
						-- 		widget.content.dare_id = mod.data.dares[2].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 2 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						-- elseif animation.text == "dare_2_hotkey" and mod.is_selector() then
						-- 	if mod.data.dares[2] then
						-- 		--widget.content.text = string.format("%s: %s", mod.data.activate_dare_2, mod.data.dares[2].text)
						-- 		widget.content.text = string.format("%s: %s ( %s )", mod.data.activate_dare_2, mod.data.dares[2].text, mod:punishment_text(mod.data.punishments[2]))
						-- 		widget.style.text.text_color = mod.data.dares[2].text_color
						-- 		widget.content.dare_id = mod.data.dares[2].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 2 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						-- elseif animation.text == "dare_3" or (animation.text == "dare_3_hotkey" and not mod.is_selector()) then
						-- 	if mod.data.dares[3] then
						-- 		--widget.content.text = mod.data.dares[3].text
						-- 		widget.content.text = string.format("%s ( %s )", mod.data.dares[3].text, mod:punishment_text(mod.data.punishments[3]))
						-- 		widget.style.text.text_color = mod.data.dares[3].text_color
						-- 		widget.content.dare_id = mod.data.dares[3].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 3 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						-- elseif animation.text == "dare_3_hotkey" and mod.is_selector() then
						-- 	if mod.data.dares[3] then
						-- 		--widget.content.text = string.format("%s: %s", mod.data.activate_dare_3, mod.data.dares[3].text)
						-- 		widget.content.text = string.format("%s: %s ( %s )", mod.data.activate_dare_3, mod.data.dares[3].text, mod:punishment_text(mod.data.punishments[3]))
						-- 		widget.style.text.text_color = mod.data.dares[3].text_color
						-- 		widget.content.dare_id = mod.data.dares[3].id
						-- 	else
						-- 		widget.content.text = ""
						-- 	end
						-- 	if mod.data.all_id == 3 then
						-- 		widget.style.text.text_color = {255, 255, 255, 0}
						-- 	end
						elseif animation.text == "time" then
							widget.content.text = self.state.time
						elseif animation.text == "reminder" then
							widget.content.text = mod.data.active_dare.reminder or "N/A"
						elseif animation.text == "countdown" then
							if self.countdown > 0 then
								widget.content.text = self.countdown
							elseif self.countdown <= 0 then
								widget.content.text = "Go!"
							end
						elseif animation.text == "active_countdown" then
							widget.content.text = string.format("%i", mod.data.dare_time + 1)
						elseif not found then
							widget.content.text = animation.text
						end
					end
					if animation.fade_in then
						if UIWidget.has_animation(widget) then UIWidget.stop_animations(widget) end
						local color = widget.style.text.text_color
						UIWidget.animate(widget, UIAnimation.init(UIAnimation.function_by_time, color, 1, 0, 255, animation.fade_in_time, math.easeInCubic))
						local color = widget.style.text_shadow.text_color
						UIWidget.animate(widget, UIAnimation.init(UIAnimation.function_by_time, color, 1, 0, 255, animation.fade_in_time, math.easeInCubic))
					end
					if animation.fade_out then
						if not widget.content.dare_id or widget.content.dare_id ~= mod.data.selected_dare then
							if UIWidget.has_animation(widget) then UIWidget.stop_animations(widget) end
							local color = widget.style.text.text_color
							UIWidget.animate(widget, UIAnimation.init(UIAnimation.function_by_time, color, 1, 255, 0, animation.fade_out_time, math.easeInCubic))
							local color = widget.style.text_shadow.text_color
							UIWidget.animate(widget, UIAnimation.init(UIAnimation.function_by_time, color, 1, 255, 0, animation.fade_out_time, math.easeInCubic))
						end
					end
					if animation.apply_text_size and not animation.update_offset then
						if self.ui_renderer then
							local add_offset = {0, 0, 0}
							local font, scaled_font_size = UIFontByResolution(widget.style.text)
							local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, widget.content.text, font[1], scaled_font_size)
							if animation.apply_text_size == "left" then
								add_offset[1] =  -(text_width / 2)
							elseif animation.apply_text_size == "right" then
								add_offset[1] = text_width / 2
							end
							widget.offset = self:apply_scale_to_offset(animation.start_offset, add_offset)
						end
					end
				end
			end
		end
	end,
	--[[
		Update UI
	--]]
	update = function(self, dt, ui_renderer)
		self.ui_renderer = ui_renderer
		if self.state then
			if mod.data.dare_running then
				mod.data.dare_time = mod.data.dare_time - dt
			end
			self.timer = self.timer + dt
			if self.timer >= self.state.time then
				self.state:finish()
			else
				-- Function
				if self.state.update then
					self.state:update()
				end
				-- Animation
				for _, widget in pairs(self.widgets) do
					local animation = self.state[widget.content.id]
					if animation then
						if not widget.content.dare_id or widget.content.dare_id == mod.data.selected_dare then
							if animation.update_size then
								local time = self.timer / self.state.time
								local size = math.lerp(animation.start_size, animation.finish_size, time)
								widget.style.text.font_size = size
								widget.style.text_shadow.font_size = size
							end
							if animation.update_offset then
								local time = self.timer / self.state.time
								local x_pos = math.lerp(animation.start_offset[1], animation.finish_offset[1], time)
								local y_pos = math.lerp(animation.start_offset[2], animation.finish_offset[2], time)
								local z_pos = math.lerp(animation.start_offset[3], animation.finish_offset[3], time)
								--widget.offset = {x_pos, y_pos, z_pos}
								widget.offset = self:apply_scale_to_offset({x_pos, y_pos, z_pos})
							end
						end
						if animation.update_text then
							if animation.text == "time" then
								widget.content.text = string.format("%i", self.state.time - self.timer + 1)
							elseif animation.text == "active_countdown" then
								widget.content.text = string.format("%i", mod.data.dare_time + 1)
							end
						end
						if animation.apply_text_size and (animation.update_offset or animation.update_text) then
							if self.ui_renderer then
								local add_offset = {0, 0, 0}
								local font, scaled_font_size = UIFontByResolution(widget.style.text)
								local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, widget.content.text, font[1], scaled_font_size)
								local time = self.timer / self.state.time
								local apply = math.lerp(0, text_width / 2, time)
								if animation.update_text then
									widget.offset = self:apply_scale_to_offset(animation.start_offset)
									apply = text_width / 2
								end
								if animation.apply_text_size == "left" then
									add_offset[1] = -apply
								elseif animation.apply_text_size == "right" then
									add_offset[1] = apply
								end
								widget.offset = self:apply_scale_to_offset(widget.offset, add_offset)
							end
						end
					end
				end
			end
		end
	end,
	--[[
		Apply hud scaling
	--]]
	apply_scale_to_offset = function(self, offset, add_offset)
		local add_offset = add_offset or {0, 0, 0}
		local new_offset = {offset[1] + add_offset[1], offset[2] + add_offset[2], offset[3]}
		if UISettings.use_custom_hud_scale then
			local mult = 2 - (UISettings.hud_scale * 0.01)
			new_offset = {offset[1] * mult, offset[2] * mult, offset[3]}
		end
		return new_offset
	end,
	--[[
		Set a state
	--]]
	set_state = function(self, state_name, time)
		local state = self.states[state_name]
		if state then
			if debug then mod:echo("UIState '"..state_name.."' started!") end
			self.state = state
			if self.state.name == "waiting" then
				self.state.time = time or 30
			elseif self.state.name == "waiting_for_input" then
				self.state.time = self.selection_time
			end
			self.timer = 0
			self.state:start()
		else
			mod:echo("Unknown UIState '"..state_name.."'!")
		end
	end,
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Create a simple text widget
--]]
mod.create_simple_text_widget = function(self, id, text, size, offset, content_check, scenegraph_id)
	local scenegraph_id = scenegraph_id or "i_dare_you"
	local offset = offset or {0, 0, 0}
	local size = size or 80
	local widget = {
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text",
					content_check_function = content_check or function(content)
						return true
					end,
				},
				{
					style_id = "text_shadow",
					pass_type = "text",
					text_id = "text",
					content_check_function = content_check or function(content)
						return true
					end,
				},
			},
		},
		content = {
			text = text,
			id = id,
		},
		style = {
			text = {
				font_size = size,
				--word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {0, 0, 2},
			},
			text_shadow = {
				font_size = size,
				--word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("black", 255),
				offset = {2, -2, 1},
			},
		},
		scenegraph_id = scenegraph_id,
		offset = offset,
	}
	return UIWidget.init(widget)
end
--[[
	Get a random player
--]]
mod.random_player = function(self, except_peer_id)
	if Managers and Managers.state and Managers.state.network then
		-- Compile list of possible players
		local possible_peer_ids = {}
		for _, peer_id in pairs(self.data.mod_users) do
			-- Make sure peer_id is usable
			if not except_peer_id or peer_id ~= except_peer_id then
				-- Make sure player is alive
				if self:is_peer_id_alive(peer_id) then
					possible_peer_ids[#possible_peer_ids+1] = peer_id
				end
			end
		end
		-- Choose random player
		local rnd_peer_id = math.random(1, #possible_peer_ids)
		return possible_peer_ids[rnd_peer_id]
	end
	return nil
end
--[[
	Check if in inn / keep
--]]
mod.is_in_inn = function(self)
	return LevelHelper:current_level_settings().level_id == "inn_level" --and not debug
end
--[[
	Check if server
--]]
mod.is_server = function(self)
	if Managers and Managers.state and Managers.state.network then
		return Managers.state.network.is_server
	end
	return false
end
--[[
	Check if victim
--]]
mod.is_victim = function(self)
	return self.data.victim_peer_id == self:my_peer_id() or self.data.all
end
--[[
	Check if selector
--]]
mod.is_selector = function()
	return mod.data.selector_peer_id == mod:my_peer_id()
end
--[[
	Check if not selector
--]]
mod.is_not_selector = function()
	return mod.data.selector_peer_id ~= mod:my_peer_id()
end
--[[
	Get player name from peer_id
--]]
mod.player_name_from_peer_id = function(self, peer_id)
	local player = Managers.player:player_from_peer_id(peer_id)
	return player:name()
end
--[[
	Get player unit from peer_id
--]]
mod.player_unit_from_peer_id = function(self, peer_id)
	local player = Managers.player:player_from_peer_id(peer_id)
	return player.player_unit
end
--[[
	Check if peer_id is alive
--]]
mod.is_peer_id_alive = function(self, peer_id)
	local unit = self:player_unit_from_peer_id(peer_id)
	if unit and Unit.alive(unit) then
		local health_extension = ScriptUnit.extension(unit, "health_system")
		if health_extension and health_extension:is_alive() then
			local status_extension = ScriptUnit.extension(unit, "status_system")
			if status_extension then
				local respawned = status_extension:is_ready_for_assisted_respawn() --or status_extension:is_assisted_respawning()
				if not respawned then
					if status_extension:is_assisted_respawning() then
						if debug then mod:echo("ERROR OCCURED: is_assisted_respawning = "..tostring(status_extension:is_assisted_respawning())) end
					end
					local knocked_down = status_extension:is_knocked_down()
					if not knocked_down then
						return true
					else
						if debug then mod:echo("Player '"..peer_id.."' skipped because is knocked down.") end	
					end
				else
					if debug then mod:echo("Player '"..peer_id.."' skipped because of respawn.") end
				end
			end
		else
			if debug then mod:echo("Player '"..peer_id.."' skipped because dead.") end
		end
	else
		if debug then mod:echo("Player '"..peer_id.."' skipped because unit doesn't exist.") end
	end
	return false
end
--[[
	Get local peer_id
--]]
mod.my_peer_id = function(self)
	local local_player = Managers.player:local_player()
	return local_player and local_player.peer_id
end
--[[
	Get server peer_id
--]]
mod.server_peer_id = function(self)
	if self:is_server() then return self:my_peer_id() end
	return Managers.state.network.network_transmit.server_peer_id
end
--[[
	Check if selecting or selected dare_id
--]]
mod.is_selecting_or_selected = function(content)
	if mod.data.selection or content.dare_id == mod.data.selected_dare then
		return true
	end
	return false
end
--[[
	Check if there are enough mod users to play
--]]
mod.has_enough_players = function(self)
	local player_count = #Managers.player:players()
	local users = self.data.mod_users
	local party = #self.data.mod_users == player_count and #self.data.mod_users > 1
	local minimum = #self.data.mod_users >= 2
	local alone = #self.data.mod_users >= 1
	return (self.data.mode == 1 and party) or (self.data.mode == 2 and minimum) or (self.data.mode == 3 and alone)
end
--[[
	Get hotkey string representation
--]]
mod.hotkey_string = function(self, hotkey_table)
	local hotkey_string = ""
	for i=#hotkey_table, 1, -1 do
		hotkey_string = hotkey_string..string.upper(hotkey_table[i])
		if i > 1 then hotkey_string = hotkey_string.." + " end
	end
	return hotkey_string
end
--[[
	Play sound effect
--]]
mod.play_sound_effect = function(self, sound_event)
	local player_unit = mod:player_unit_from_peer_id(mod:my_peer_id())
	if player_unit and mod:get("sound_effects") then
		local first_person_extension = ScriptUnit.extension(player_unit, "first_person_system")
		if first_person_extension then
			first_person_extension:play_hud_sound_event(sound_event)
		end
	end
end
--[[
	Check if peer_id is interacting in assisted respawn
--]]
mod.is_helping_assisted_respawn = function(self, peer_id)
    local unit = mod:player_unit_from_peer_id(peer_id)
    local interactor_extension = ScriptUnit.extension(unit, "interactor_system")
    if interactor_extension then
		local interacting, interaction_type = interactor_extension:is_interacting()
		if not interaction_type then
			-- Husk
			interaction_type = interactor_extension.interaction_context.interaction_type
		end
        if interacting and (interaction_type == "assisted_respawn" or interaction_type == "revive") then
			return true
		else
			if debug then mod:echo(interaction_type) end
        end
    end
    return false
end
--[[
	Check if enough players are alive / not knocked down
--]]
mod.has_enough_players_alive = function(self)
	if mod:has_enough_players() then
		local player_count = 0
		for _, peer_id in pairs(mod.data.mod_users) do
			if mod:is_peer_id_alive(peer_id) then
				player_count = player_count + 1
			end
		end
		if player_count > 0 then
			return true
		end
	end
	return false
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
-- --[[
-- 	Abort dare when player is knocked down
-- --]]
-- mod:hook_safe(PlayerCharacterStateKnockedDown, "on_enter", function(self, unit, input, dt, context, t, previous_state, params)
-- 	local player_unit = mod:player_unit_from_peer_id(mod:my_peer_id())
-- 	if player_unit == self.unit then
-- 		if mod.data.active_dare then
-- 			mod:abort_dare("knocked_down")
-- 		end
-- 	end
-- end)
--[[
	Catch moment when cutscene is over to start server
--]]
mod:hook_safe(CutsceneUI, "set_player_input_enabled", function(self, enabled)
	if enabled and mod:is_server() then
		mod.data.in_mission = true
		mod.server:start()
	end
end)
--[[
	Inject scenegraph element
--]]
mod:hook(UISceneGraph, "init_scenegraph", function(func, scenegraph, ...)
	scenegraph.i_dare_you = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		scale = "hud_scale_fit",
		parent = "root",
		size = { 1920, 1080 },
        position = { 0, 0, 0 },
	}

	return func(scenegraph, ...)
end)
mod:hook_disable(UISceneGraph, "init_scenegraph")
--[[
	Inject scenegraph into buff_ui and observer_ui
--]]
local create_ui_elements = function(func, self, ...)
	mod:hook_enable(UISceneGraph, "init_scenegraph")
	local result = func(self, ...)
	--mod.ui:create_widgets()
	mod:hook_disable(UISceneGraph, "init_scenegraph")
	return result
end
mod:hook(BuffUI, "_create_ui_elements", create_ui_elements)
--mod:hook(UnitFrameUI, "_create_ui_elements", create_ui_elements)
--[[
	Update widgets
--]]
local update_widgets = function(self, dt)
	mod.ui:update(dt, self.ui_renderer)
end
mod:hook_safe(BuffUI, "update", update_widgets)
--mod:hook_safe(UnitFrameUI, "update", update_widgets)
--[[
	Draw widgets
--]]
local draw_widgets = function(self, dt)
	if mod.ui.state then
		local ui_renderer = self.ui_renderer
		local ui_scenegraph = self.ui_scenegraph
		local input_service = self.input_manager:get_service("ingame_menu")
		
		-- Draw widgets
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
		for _, widget in pairs(mod.ui.widgets) do
			if table.contains(mod.ui.state.render, widget.content.id) then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
		UIRenderer.end_pass(ui_renderer)
	end
end
mod:hook_safe(BuffUI, "draw", draw_widgets)
--mod:hook_safe(UnitFrameUI, "draw", draw_widgets)
--[[
	On player death / knockdown check for enough players alive
--]]
local check_alive_players = function()
	if mod:is_server() then
		if debug then
			mod:echo("PlayerUnitHealthExtension check players!")
		end
		if not mod:has_enough_players_alive() then
			mod.server:set_state("waiting_for_something")
		end
	end
end
mod:hook_safe(PlayerUnitHealthExtension, "knock_down", check_alive_players)
mod:hook_safe(PlayerUnitHealthExtension, "die", check_alive_players)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Player joined the game
--]]
mod.on_user_joined = function(player)
	if mod:is_server() then
		if debug then
			mod:echo("User joined game!")
			mod:echo("Asking joined user if mod is active...")
			mod:echo("PeerID:'"..tostring(player.peer_id).."'")
		end
		mod:network_send("handshake_client", player.peer_id)
	end
end
--[[
	Player left the game
--]]
mod.on_user_left = function(player)
	if mod:is_server() then
		if debug then
			mod:echo("User left game!")
			mod:echo("PeerID:'"..tostring(player.peer_id).."'")
		end
		mod.server:remove_mod_user(player.peer_id)
	end
end
--[[
	Update cycle
--]]
mod.update = function(dt)
	if mod:is_server() then
		mod.server:update(dt)
	end
	mod:update_dare(dt)
	if test_dares then
		mod:update_test_dares(dt)
	end
end
--[[
	Mod unload
--]]
mod.on_unload = function(exit_game)
end
--[[
	Gamestate change
--]]
mod.on_game_state_changed = function(status, state)
	if mod.data.active and mod:is_server() then
		-- Add self to mod users
		if state == "StateIngame" and status == "enter" then
			-- if not mod:is_in_inn() or debug then
			-- 	--mod.server:set_state("init")
			-- 	mod.server:start()
			-- else
			-- 	--mod.server:set_state("idle")
			-- 	mod.server:stop()
			-- end
		elseif state == "StateIngame" and status == "exit" then
			--mod.server:set_state("idle")
			mod.data.in_mission = false
			mod.server:stop()
		end
		mod.server:add_mod_user(mod:my_peer_id())
	end
end
--[[
	Setting change
--]]
mod.on_setting_changed = function(setting_name)
	if setting_name == "active" then
		-- Save setting to variable
		mod.data.active = mod:get("active")
		-- Check if allowed to change setting
		if mod:is_in_inn() then
			-- We're in the inn, so it's allowed
			if not mod.data.active then
				if debug then mod:echo("Deactivate!") end
				mod:network_send("user_deactivated_mod", mod:server_peer_id())
			else
				if debug then mod:echo("Activate!") end
				mod:network_send("user_activated_mod", mod:server_peer_id())
			end
		else
			-- Check if server
			if not mod:is_server() then
				if not mod.data.active then
					-- We're in a mission, so it's punishment time
					if debug then mod:echo("Die!") end
					mod:network_send("request_punishment_server", mod:server_peer_id(), 9999)
					mod:set("active", true)
					mod.data.active = true
				end
			else
				if not mod.data.active then
					mod.server:stop()
				else
					mod.server:start()
				end
			end
		end

	elseif setting_name == "mode" then
		-- Save setting to variable
		mod.data.mode = mod:get("mode")
		-- Restart server
		if mod:is_server() then mod.server:start() end

	elseif setting_name == "activate_dare_1" then
		-- Save setting to variable
		mod.data.activate_dare_1 = mod:hotkey_string(mod:get("activate_dare_1"))

	elseif setting_name == "activate_dare_2" then
		-- Save setting to variable
		mod.data.activate_dare_2 = mod:hotkey_string(mod:get("activate_dare_2"))

	elseif setting_name == "activate_dare_3" then
		-- Save setting to variable
		mod.data.activate_dare_3 = mod:hotkey_string(mod:get("activate_dare_3"))
	elseif setting_name == "activate_random_dare" then
	elseif setting_name == "start_server" then
	elseif setting_name == "stop_server" then
	elseif setting_name == "debug" then
		debug = mod:get("debug")
	elseif setting_name == "initial_time" then
	elseif setting_name == "selection_time" then
	elseif setting_name == "random_choice" then
	elseif setting_name == "sound_effects" then
	elseif setting_name == "all_players" then
	elseif setting_name == "all_players_chance" then
	else
		if not mod:is_in_inn() then
			mod.server:start_soft()
		end
	end
end
--[[
	Mod disable
--]]
mod.on_disabled = function(is_first_call)
end
--[[
	Mod enable
--]]
mod.on_enabled = function(is_first_call)
end
--[[
	When all mods are loaded
--]]
mod.on_all_mods_loaded = function()
	-- Widgets
	mod.ui:create_widgets()
	-- Set settings
	mod.data.active = mod:get("active")
	mod.data.mode = mod:get("mode")
	--mod.data.allow_inn = mod:get("allow_inn")
	--mod:dump(mod:get("activate_dare_1"), "activate_dare_1", 2)
	mod.data.activate_dare_1 = mod:hotkey_string(mod:get("activate_dare_1"))
	mod.data.activate_dare_2 = mod:hotkey_string(mod:get("activate_dare_2"))
	mod.data.activate_dare_3 = mod:hotkey_string(mod:get("activate_dare_3"))
	-- Add local player to list
	if mod:is_server() then
		mod.server:add_mod_user(mod:my_peer_id())
	end
end

-- ##### ████████╗███████╗███████╗████████╗    ██████╗  █████╗ ██████╗ ███████╗███████╗ ###############################
-- ##### ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝ ###############################
-- #####    ██║   █████╗  ███████╗   ██║       ██║  ██║███████║██████╔╝█████╗  ███████╗ ###############################
-- #####    ██║   ██╔══╝  ╚════██║   ██║       ██║  ██║██╔══██║██╔══██╗██╔══╝  ╚════██║ ###############################
-- #####    ██║   ███████╗███████║   ██║       ██████╔╝██║  ██║██║  ██║███████╗███████║ ###############################
-- #####    ╚═╝   ╚══════╝╚══════╝   ╚═╝       ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝ ###############################
--[[
	Start test dares
--]]
mod.start_test_dares = function(self)
	for _, dare in pairs(test_dares) do
		if mod:get(dare.id) then
			dare.active = true
			dare.testing = true
			dare:start()
		end
	end
end
--[[
	Update test dares
--]]
mod.update_test_dares = function(self, dt)
	for _, dare in pairs(test_dares) do
		if dare.active then
			dare:update(dt)
		end
	end
end
--[[
	Init test dares
	Reset skill cooldown
--]]
if test_dares then
	local unit = mod:player_unit_from_peer_id(mod:my_peer_id())
	local career_extension = ScriptUnit.extension(unit, "career_system")
	if career_extension then
		career_extension:reduce_activated_ability_cooldown_percent(100)
	end
	mod:start_test_dares()
end
--[[
	Knock down / kill bots for tests
--]]
--local test_bots = true
if test_bots then
	local bots = Managers.player and Managers.player:bots()
	if bots then
		for _, bot in pairs(bots) do
			local unit = bot.player_unit
			DamageUtils.add_damage_network(unit, unit, 9999, "full", "forced", nil, Vector3(0, 0, 1), "debug")
		end
	end
end
