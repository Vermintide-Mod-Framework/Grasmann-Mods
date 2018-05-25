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


mod.character_window = nil
mod.career_window = nil

mod.profile_index = nil
mod.career_index = nil
mod.orig_profile_by_peer = nil
mod.orig_get_career = nil

--[[
	Functions
--]]
mod.get_hero_view = function(self)
	local matchmaking_manager = Managers.matchmaking
	local ingame_ui = matchmaking_manager and matchmaking_manager._ingame_ui
	local hero_view_active = ingame_ui and ingame_ui.current_view == "hero_view"
	local hero_view = hero_view_active and ingame_ui.views["hero_view"]
	return hero_view
end

mod.create_character_window = function(self)
	
	local simple_ui = get_mod("SimpleUI")
	if simple_ui and not self.character_window then
		
		local feedback = function(self)

			-- local matchmaking_manager = Managers.matchmaking
			-- local ingame_ui = matchmaking_manager and matchmaking_manager._ingame_ui
			-- local hero_view_active = ingame_ui and ingame_ui.current_view == "hero_view"
			-- local hero_view = hero_view_active and ingame_ui.views["hero_view"]
			
			local hero_view = mod:get_hero_view()
			
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
					
					mod.career_window:destroy()
					mod.career_window = nil
					mod:create_career_window(index)
					
				end)
				
			end
		end
		
		local screen_width = RESOLUTION_LOOKUP.res_w
		local screen_height = RESOLUTION_LOOKUP.res_h
		local window_size = {705, 40}
		
		self.character_window = simple_ui:create_window("ui_improvements_character", {120, screen_height - window_size[2] - 5}, window_size)
		
		local pos_x = 5
		local button = self.character_window:create_button("ui_improvements_character_soldier", {pos_x, 5}, {130, 30}, nil, "Markus Kruber", 5)
		button.on_click = feedback
		pos_x = pos_x + 130 + 5
		
		local button = self.character_window:create_button("ui_improvements_character_dwarf", {pos_x, 5}, {155, 30}, nil, "Bardin Goreksson", 3)
		button.on_click = feedback
		pos_x = pos_x + 155 + 5
		
		local button = self.character_window:create_button("ui_improvements_character_waywatcher", {pos_x, 5}, {80, 30}, nil, "Kerillian", 4)
		button.on_click = feedback
		pos_x = pos_x + 80 + 5
		
		local button = self.character_window:create_button("ui_improvements_character_witchhunter", {pos_x, 5}, {145, 30}, nil, "Victor Saltzpyre", 1)
		button.on_click = feedback
		pos_x = pos_x + 145 + 5
		
		local button = self.character_window:create_button("ui_improvements_character_wizard", {pos_x, 5}, {165, 30}, nil, "Sienna Fuegonasus", 2)
		button.on_click = feedback
		pos_x = pos_x + 165 + 5
		
		self.character_window:init()
		
	end
	
end

mod.careers = {
	{
		{
			name = "Witch Hunter Captain",
			button_width = 190,
			character_index = 1,
			career_index = 1,
		},
		{
			name = "Bounty Hunter",
			button_width = 130,
			character_index = 1,
			career_index = 2,
		},
		{
			name = "Zealot",
			button_width = 70,
			character_index = 1,
			career_index = 3,
		},
	},
	{
		{
			name = "Battle Wizard",
			button_width = 130,
			character_index = 2,
			career_index = 1,
		},
		{
			name = "Pyromancer",
			button_width = 110,
			character_index = 2,
			career_index = 2,
		},
		{
			name = "Unchained",
			button_width = 100,
			character_index = 2,
			career_index = 3,
		},
	},
	{
		{
			name = "Ranger Veteran",
			button_width = 140,
			character_index = 3,
			career_index = 1,
		},
		{
			name = "Ironbreaker",
			button_width = 110,
			character_index = 3,
			career_index = 2,
		},
		{
			name = "Slayer",
			button_width = 70,
			character_index = 3,
			career_index = 3,
		},
	},
	{
		{
			name = "Waystalker",
			button_width = 110,
			character_index = 4,
			career_index = 1,
		},
		{
			name = "Handmaiden",
			button_width = 120,
			character_index = 4,
			career_index = 2,
		},
		{
			name = "Shade",
			button_width = 70,
			character_index = 4,
			career_index = 3,
		},
	},
	{
		{
			name = "Mercenary",
			button_width = 100,
			character_index = 5,
			career_index = 1,
		},
		{
			name = "Huntsman",
			button_width = 100,
			character_index = 5,
			career_index = 2,
		},
		{
			name = "Foot Knight",
			button_width = 110,
			character_index = 5,
			career_index = 3,
		},
	},
}

mod.create_career_window = function(self, profile_index)

	local simple_ui = get_mod("SimpleUI")
	if simple_ui and not self.career_window then
		
		local feedback = function(self)

			-- local matchmaking_manager = Managers.matchmaking
			-- local ingame_ui = matchmaking_manager and matchmaking_manager._ingame_ui
			-- local hero_view_active = ingame_ui and ingame_ui.current_view == "hero_view"
			-- local hero_view = hero_view_active and ingame_ui.views["hero_view"]
			
			local hero_view = mod:get_hero_view()
			
			if hero_view then
				mod:pcall(function()

					local ingame_ui_context = hero_view.ingame_ui_context
					local index = self.params[1]
					mod.profile_index = index
					
					-- Backup orig profile function
					if not mod.orig_profile_by_peer then
						mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
					end
					
					-- local profile_settings = SPProfiles[index]
					-- local display_name = profile_settings.display_name
					-- local hero_attributes = Managers.backend:get_interface("hero_attributes")
					local career_index = self.params[2] --hero_attributes:get(display_name, "career")
					mod.career_index = career_index
					
					-- Overwrite profile function
					ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
						return index
					end
					
					if not mod.orig_get_career then
						mod.orig_get_career = Managers.backend._interfaces["hero_attributes"].get
					end
					
					-- Overwrite career function
					Managers.backend._interfaces["hero_attributes"].get = function(self, hero_name, attribute_name)
						if attribute_name == "career" then
							return career_index
						end
						return mod.orig_get_career(self, hero_name, attribute_name)
					end
					
					-- mod:hook("BackendInterfaceHeroAttributes.get", function(func, self, hero_name, attribute_name)
						-- if attribute_name == "career" then
							-- return career_index
						-- end
						-- return func(self, hero_name, attribute_name)
					-- end)
					
					-- Reopen view
					--hero_view:init(ingame_ui_context)
					hero_view:_change_screen_by_index(1)
					
					mod.career_window:destroy()
					mod.career_window = nil
					mod:create_career_window(index)
					
				end)
				
			end
		end
		
		local screen_width = RESOLUTION_LOOKUP.res_w
		local screen_height = RESOLUTION_LOOKUP.res_h
		local window_size = {500, 40}
		
		self.career_window = simple_ui:create_window("ui_improvements_career", {120, screen_height - window_size[2] - 45}, window_size)
		
		local careers = self.careers[profile_index]
		
		if careers then
			
			local pos_x = 5
			local window_width = 5
			
			for _, career in pairs(careers) do
				
				--self:echo(career.name)
				local button = self.career_window:create_button("ui_improvements_career_"..career.name, {pos_x, 5}, {career.button_width, 30}, nil, career.name, {career.character_index, career.career_index})
				button.on_click = feedback
				pos_x = pos_x + career.button_width + 5
				window_width = window_width + career.button_width + 5
				
			end
			
			self.career_window.size[1] = window_width
			
		else
		
			self:echo("nope")
			self:echo("index: "..tostring(profile_index))
			
		end
		
		self.career_window:init()
		
	end
	
end

mod.reload_windows = function(self)
	self:destroy_windows()
	-- Character
	self:create_character_window()
	-- Career
	local player = Managers.player:local_player()
	local profile_index = player:profile_index()
	self:create_career_window(profile_index)
end

mod.destroy_windows = function(self)
	if self.character_window then
		self.character_window:destroy()
		self.character_window = nil
	end
	if self.career_window then
		self.career_window:destroy()
		self.career_window = nil
	end
end

--[[
	Hooks
--]]

--[[
	Prevent equipment to be destroyed and spawned when not active character
--]]
mod:hook("SimpleInventoryExtension.create_equipment_in_slot", function(func, self, slot_id, backend_id)
	local player = Managers.player:local_player()
	if mod.profile_index and mod.profile_index ~= player:profile_index() then
		return
	end
	if mod.career_index and mod.career_index ~= player:career_index() then
		return
	end
	func(self, slot_id, backend_id)
end)
--[[
	Get items for selected character
--]]
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
--[[
	Create window when opening hero view
--]]
mod:hook("HeroView.on_enter", function(func, self, menu_state_name, menu_sub_state_name)
	-- Orig function
	func(self, menu_state_name, menu_sub_state_name)
	-- Reload window
	mod:reload_windows()
end)
--[[
	Create window when unsuspending hero view
--]]
mod:hook("HeroView.unsuspend", function(func, self)
	-- Orig function
	func(self)
	-- Reload window
	mod:reload_windows()
end)
--[[
	Destroy window when closing hero view
--]]
mod:hook("HeroView.on_exit", function(func, self)
	-- Reset profile function
	if mod.orig_profile_by_peer then
		self.ingame_ui_context.profile_synchronizer.profile_by_peer = mod.orig_profile_by_peer
		mod.orig_profile_by_peer = nil
	end
	-- Reset career function
	if not mod.orig_get_career then
		Managers.backend._interfaces["hero_attributes"].get = mod.orig_get_career
		mod.orig_get_career = nil
	end
	mod.profile_index = nil
	mod.career_index = nil
	-- Orig function
	func(self)
	-- Destroy window
	mod:destroy_windows()
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


