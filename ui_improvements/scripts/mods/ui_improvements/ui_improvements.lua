local mod = get_mod("ui_improvements")

-- Everything here is optional. You can remove unused parts.
local mod_data = {
	name = "ui_improvements",               -- Readable mod name
	description = "ui_improvements description",  -- Mod description
	is_togglable = true,            -- If the mod can be enabled/disabled
	is_mutator = false,             -- If the mod is mutator
	mutator_settings = {},          -- Extra settings, if it's mutator
	options_widgets = {				-- Widget settings for the mod options menu
		{
			["setting_name"] = "checkbox",
			["widget_type"] = "checkbox",
			["text"] = "Checkbox",
			["tooltip"] = "Checkbox\n" ..
						"Line_1\n\n" ..
						"Line_2\n\n" ..
						"Line_3",
			["default_value"] = true
		}
	},
}

mod:initialize_data(mod_data)


mod.window = nil
mod.profile_index = nil
mod.career_index = nil
mod.orig_profile_by_peer = nil

--[[
	Functions
--]]
mod.create_window = function(self)
	
	local simple_ui = get_mod("SimpleUI")
	if simple_ui and not self.window then
		
		local feedback = function(self)

			local matchmaking_manager = Managers.matchmaking
			local ingame_ui = matchmaking_manager and matchmaking_manager._ingame_ui
			local hero_view_active = ingame_ui and ingame_ui.current_view == "hero_view"
			local hero_view = hero_view_active and ingame_ui.views["hero_view"]
			
			if hero_view then
				mod:pcall(function()

					local ingame_ui_context = hero_view.ingame_ui_context
					local index = self.params
					mod.profile_index = index
					
					-- Backup orig profile function
					if not mod.orig_profile_by_peer then
						mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
					end
					
					local profile_settings = SPProfiles[index]
					local display_name = profile_settings.display_name
					local hero_attributes = Managers.backend:get_interface("hero_attributes")
					local career_index = hero_attributes:get(display_name, "career")
					mod.career_index = career_index
					
					-- Overwrite profile function
					ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
						return index
					end
					
					-- Reopen view
					--hero_view:init(ingame_ui_context)
					hero_view:_change_screen_by_index(1)
	
				end)
				
			end
		end
		
		local screen_width = RESOLUTION_LOOKUP.res_w
		local screen_height = RESOLUTION_LOOKUP.res_h
		local window_size = {545, 40}
		
		self.window = simple_ui:create_window("ui_improvements_hero_view", {screen_width / 3, screen_height - window_size[2]}, window_size)
		
		local button = self.window:create_button("ui_improvements_hero_view_soldier", {5, 5}, {100, 30}, nil, "Soldier", 5)
		button.on_click = feedback
		
		local button = self.window:create_button("ui_improvements_hero_view_dwarf", {110, 5}, {100, 30}, nil, "Dwarf", 3)
		button.on_click = feedback
		
		local button = self.window:create_button("ui_improvements_hero_view_waywatcher", {220, 5}, {100, 30}, nil, "Waywatcher", 4)
		button.on_click = feedback
		
		local button = self.window:create_button("ui_improvements_hero_view_witchhunter", {330, 5}, {100, 30}, nil, "Witchhunter", 1)
		button.on_click = feedback
		
		local button = self.window:create_button("ui_improvements_hero_view_wizard", {440, 5}, {100, 30}, nil, "Wizard", 2)
		button.on_click = feedback
		
		self.window:init()
		
	end
	
end



mod.reload_window = function(self)
	self:destroy_window()
	self:create_window()
end

mod.destroy_window = function(self)
	if self.window then
		self.window:destroy()
		self.window = nil
	end
end

--[[
	Hooks
--]]

-- mod:hook("SimpleInventoryExtension._spawn_resynced_loadout", function(func, self, equipment_to_spawn)
	-- local player = Managers.player:local_player()
	-- if mod.profile_index and mod.profile_index ~= player:profile_index() then
		-- return
	-- end
	-- if mod.career_index and mod.career_index ~= player:career_index() then
		-- return
	-- end
	-- func(self, equipment_to_spawn)
-- end)

-- mod:hook("SimpleInventoryExtension._update_resync_loadout", function(func, self)
	-- local player = Managers.player:local_player()
	-- if mod.profile_index and mod.profile_index ~= player:profile_index() then
		-- return
	-- end
	-- if mod.career_index and mod.career_index ~= player:career_index() then
		-- return
	-- end
	-- func(self)
-- end)

mod:hook("ItemGridUI._get_items_by_filter", function(func, self, item_filter)
	local player = Managers.player:local_player()
	
	local orig_profile_index, orig_career_index = nil
	
	if mod.profile_index then
		orig_profile_index = player.profile_index
		local profile = mod.profile_index
		player.profile_index = function(self)
			return profile or orig_profile_index(self)
		end
	end
	
	if mod.career_index then
		orig_career_index = player.career_index
		local career = mod.career_index
		player.career_index = function(self)
			return career or orig_career_index(self)
		end
	end
	
	-- Orig function
	local items = func(self, item_filter)
	
	if orig_profile_index then
		player.profile_index = orig_profile_index
	end
	if orig_career_index then
		player.career_index = orig_career_index
	end
	
	return items
end)

-- mod:hook("Items.get_filtered_items", function(func, self, filter, params)
	-- local items = func(self, filter, params)
	-- mod:dump(params, "params", 1)
	-- return items
-- end)

mod:hook("HeroWindowInventory.on_enter", function(func, self, params, offset)
	-- Orig function
	func(self, params, offset)
	
	mod:echo("lol")
end)

mod:hook("HeroWindowLoadoutInventory.on_enter", function(func, self, params, offset)
	-- Orig function
	func(self, params, offset)
	
	--mod:echo(tostring(params.profile_index))
	--mod:dump(params, "params", 1)
end)

mod:hook("HeroView.on_enter", function(func, self, menu_state_name, menu_sub_state_name)
	-- Orig function
	func(self, menu_state_name, menu_sub_state_name)
	-- Reload window
	mod:reload_window()
end)

mod:hook("HeroView.unsuspend", function(func, self)
	-- Orig function
	func(self)
	-- Reload window
	mod:reload_window()
end)

mod:hook("HeroView.on_exit", function(func, self)
	-- Reset profile function
	if mod.orig_profile_by_peer then
		self.ingame_ui_context.profile_synchronizer.profile_by_peer = mod.orig_profile_by_peer
		mod.orig_profile_by_peer = nil
	end
	mod.profile_index = nil
	mod.career_index = nil
	-- Orig function
	func(self)
	-- Destroy window
	mod:destroy_window()
end)

--[[
	Callback
--]]

-- Call on every update to mods
mod.update = function(dt)
	return
end

-- Call when all mods are being unloaded
mod.on_unload = function()
	return
end

-- Call when game state changes (e.g. StateLoading -> StateIngame)
mod.on_game_state_changed = function(status, state)
	return
end

-- Call when setting is changed in mod settings
mod.on_setting_changed = function(setting_name)
	return
end

-- Call when governing settings checkbox is unchecked
mod.on_disabled = function(is_first_call)
	mod:disable_all_hooks()
end

-- Call when governing settings checkbox is checked
mod.on_enabled = function(is_first_call)
	mod:enable_all_hooks()
end


--[[
	Execution
--]]


