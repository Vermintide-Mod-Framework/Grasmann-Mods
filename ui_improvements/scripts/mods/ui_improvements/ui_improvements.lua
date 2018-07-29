local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Collection of UI improvements

	Version: 1.5.0
--]]

mod:dofile("scripts/mods/ui_improvements/ui_improvements_switch")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_items")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_crafting")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_cosmetics")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_loot")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_deeds")
mod:dofile("scripts/mods/ui_improvements/ui_improvements_achievements")

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.actual_profile_index = nil
mod.profile_index = nil
mod.actual_career_index = nil
mod.career_index = nil
mod.orig_profile_by_peer = nil
mod.orig_get_career = nil
mod.sub_screen = "equipment"
mod.crafting_animation_running = false
mod.window_settings = {
	loadout = "equipment",
	talents = "talents",
	crafting = "forge",
	cosmetics_loadout = "cosmetics",
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Get hero view and check if view is open
--]]
mod.get_hero_view = function(self)
	local matchmaking_manager = Managers.matchmaking
	local ingame_ui = matchmaking_manager and matchmaking_manager._ingame_ui
	local hero_view_active = ingame_ui and ingame_ui.current_view == "hero_view"
	local hero_view = hero_view_active and ingame_ui.views["hero_view"]

	return hero_view
end
--[[
	Reopen hero view
--]]
mod.reopen_hero_view = function(self)
	local hero_view = mod:get_hero_view()
	hero_view:_change_screen_by_name("overview", mod.sub_screen)
end
--[[
	Overwrite profile and career functions
--]]
mod.overwrite_functions = function(self, overwrite)
	local hero_view = mod:get_hero_view()
	local ingame_ui_context = hero_view.ingame_ui_context

	if overwrite then

		-- Backup orig profile function
		if not mod.orig_profile_by_peer then
			mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
		end

		-- Overwrite profile function
		ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
			return mod.profile_index or mod.orig_profile_by_peer(self, peer_id, local_player_id)
		end

		-- Backup original career function
		if not mod.orig_get_career then
			mod.orig_get_career = Managers.backend._interfaces["hero_attributes"].get
		end

		-- Overwrite career function
		Managers.backend._interfaces["hero_attributes"].get = function(self, hero_name, attribute_name)
			if attribute_name == "career" then
				return mod.career_index or mod.orig_get_career(self, hero_name, attribute_name)
			end
			return mod.orig_get_career(self, hero_name, attribute_name)
		end

	else

		-- Reset profile function
		if mod.orig_profile_by_peer then
			ingame_ui_context.profile_synchronizer.profile_by_peer = mod.orig_profile_by_peer
			mod.orig_profile_by_peer = nil
		end

		-- Reset career function
		if mod.orig_get_career then
			Managers.backend._interfaces["hero_attributes"].get = mod.orig_get_career
			mod.orig_get_career = nil
		end

	end
end
--[[
	Check if player is in inn
--]]
mod.is_in_inn = function(self)
	-- Check game mode key
	local game_mode_key = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_key()
	if game_mode_key == "inn" then
		return true
	end
	-- False
	return false
end
--[[
	Disable controls
--]]
mod.disable_controls = function(self, disable)
	self:disable_switch_controls(disable)
	self:disable_crafting_controls(disable)
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Set current sub screen in hero view
--]]
mod:hook_safe(HeroViewStateOverview, "_change_window", function(self, window_index_, window_name, ...)
	mod.sub_screen = mod.window_settings[window_name] or mod.sub_screen
end)
--[[
	Create window when opening hero view
--]]
mod:hook_safe(HeroView, "on_enter", function(self, menu_state_name, ...)
	-- Only process when overview
	if menu_state_name ~= "overview" then
		return
	end
	-- Set values
	local player = Managers.player:local_player()
	mod.actual_profile_index = player:profile_index()
	mod.profile_index = mod.actual_profile_index
	mod.actual_career_index = player:career_index()
	mod.career_index = mod.actual_career_index
end)
--[[
	Reset values
--]]
mod:hook(HeroView, "on_exit", function(func, ...)
	-- Reset values
	mod.profile_index = nil
	mod.career_index = nil
	mod.actual_profile_index = nil
	mod.actual_career_index = nil
	-- Orig function
	func(...)
end)

-- ##### ██████╗ ███████╗██████╗ ██╗   ██╗ ██████╗  ###################################################################
-- ##### ██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝  ###################################################################
-- ##### ██║  ██║█████╗  ██████╔╝██║   ██║██║  ███╗ ###################################################################
-- ##### ██║  ██║██╔══╝  ██╔══██╗██║   ██║██║   ██║ ###################################################################
-- ##### ██████╔╝███████╗██████╔╝╚██████╔╝╚██████╔╝ ###################################################################
-- ##### ╚═════╝ ╚══════╝╚═════╝  ╚═════╝  ╚═════╝  ###################################################################
--[[
	Simulate crafting in modded realm
--]]
-- mod:hook(PlayFabRequestQueue, "enqueue", function(func, self, request, success_callback, send_eac_challenge, ...)
-- 	send_eac_challenge = false
-- 	func(self, request, success_callback, send_eac_challenge, ...)
-- end)
-- mod:hook(PlayFabRequestQueue, "playfab_request_success_cb", function(func, self, success_callback, result, ...)
-- 	local entry = self._active_entry
-- 	local request = entry.request
-- 	local function_result = result.FunctionResult

-- 	self._active_entry = nil
-- 	success_callback(result)
-- end)
--[[
	Make loot chest interactible in modded realm
--]]
-- mod:hook(InteractionDefinitions.loot_access.client, "can_interact", function(func, interactor_unit, interactable_unit, data, config, ...)
-- 	return true
-- end)
