local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you switch equippment of all characters / classes in inventory

	Version: 1.1.1
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
-- Custom theme for highlighting
mod.simple_ui = nil
mod.basic_ui = nil
mod.new_character_window = nil
mod.new_career_window = nil
mod.actual_profile_index = nil
mod.profile_index = nil
mod.actual_career_index = nil
mod.career_index = nil
mod.orig_profile_by_peer = nil
mod.orig_get_career = nil
mod.sub_screen = "equipment"
mod.reload_loot = false
mod.characters = {
	{
		name = "Victor Saltzpyre",
		button_width = 145,
		character_index = 1,
		texture = "hero_icon_wh",
		size = {
			60,
			60,
		},
		position = {
			10,
			10,
		},
		hovered = false,
		selected = false,
	},
	{
		name = "Sienna Fuegonasus",
		button_width = 165,
		character_index = 2,
		texture = "hero_icon_bw",
		size = {
			60,
			60,
		},
		position = {
			10,
			10,
		},
		hovered = false,
		selected = false,
	},
	{
		name = "Bardin Goreksson",
		button_width = 155,
		character_index = 3,
		texture = "hero_icon_dr",
		size = {
			60,
			60,
		},
		position = {
			10,
			10,
		},
		hovered = false,
		selected = false,
	},
	{
		name = "Kerillian",
		button_width = 80,
		character_index = 4,
		texture = "hero_icon_ww",
		size = {
			60,
			60,
		},
		position = {
			10,
			10,
		},
		hovered = false,
		selected = false,
	},
	{
		name = "Markus Kruber",
		button_width = 130,
		character_index = 5,
		texture = "hero_icon_es",
		size = {
			60,
			60,
		},
		position = {
			10,
			10,
		},
		hovered = false,
		selected = false,
	},
}
mod.careers = {
	{
		{
			name = "Witch Hunter Captain",
			button_width = 190,
			character_index = 1,
			career_index = 1,
			texture = "small_unit_frame_portrait_victor_captain",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Bounty Hunter",
			button_width = 130,
			character_index = 1,
			career_index = 2,
			texture = "small_unit_frame_portrait_victor_bountyhunter",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Zealot",
			button_width = 70,
			character_index = 1,
			career_index = 3,
			texture = "small_unit_frame_portrait_victor_zealot",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
	},
	{
		{
			name = "Battle Wizard",
			button_width = 130,
			character_index = 2,
			career_index = 1,
			texture = "small_unit_frame_portrait_sienna_adept",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Pyromancer",
			button_width = 110,
			character_index = 2,
			career_index = 2,
			texture = "small_unit_frame_portrait_sienna_scholar",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Unchained",
			button_width = 100,
			character_index = 2,
			career_index = 3,
			texture = "small_unit_frame_portrait_sienna_unchained",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
	},
	{
		{
			name = "Ranger Veteran",
			button_width = 140,
			character_index = 3,
			career_index = 1,
			texture = "small_unit_frame_portrait_bardin_ranger",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Ironbreaker",
			button_width = 110,
			character_index = 3,
			career_index = 2,
			texture = "small_unit_frame_portrait_bardin_ironbreaker",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Slayer",
			button_width = 70,
			character_index = 3,
			career_index = 3,
			texture = "small_unit_frame_portrait_bardin_slayer",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
	},
	{
		{
			name = "Waystalker",
			button_width = 110,
			character_index = 4,
			career_index = 1,
			texture = "small_unit_frame_portrait_kerillian_waywatcher",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Handmaiden",
			button_width = 120,
			character_index = 4,
			career_index = 2,
			texture = "small_unit_frame_portrait_kerillian_maidenguard",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Shade",
			button_width = 70,
			character_index = 4,
			career_index = 3,
			texture = "small_unit_frame_portrait_kerillian_shade",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
	},
	{
		{
			name = "Mercenary",
			button_width = 100,
			character_index = 5,
			career_index = 1,
			texture = "small_unit_frame_portrait_kruber_mercenary",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Huntsman",
			button_width = 100,
			character_index = 5,
			career_index = 2,
			texture = "small_unit_frame_portrait_kruber_huntsman",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
		{
			name = "Foot Knight",
			button_width = 110,
			character_index = 5,
			career_index = 3,
			texture = "small_unit_frame_portrait_kruber_knight",
			size = {
				60,
				60,
			},
			position = {
				10,
				10,
			},
			hovered = false,
		},
	},
}
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
	Get bottom left corner of hero view
--]]
mod.get_hero_view_bottom_left_corner = function(self)
	local scale = UIResolutionScale()
	local size = UISettings.game_start_windows.large_window_size
	size = {size[1] * scale, size[2] * scale}
	local screen = {1920 * scale, 1080 * scale}
	local position = {screen[1]/2 - size[1]/2, screen[2]/2 - size[2]/2}
	return position
end
--[[
	Play sound
--]]
mod.play_sound = function(self, sound_name)
	local hero_view = self:get_hero_view()
	hero_view:play_sound(sound_name)
end
--[[
	Check if a career is unlocked
--]]
mod.career_unlocked = function(self, profile_index, career_index)
	local unlocked = false

	local profile_settings = SPProfiles[profile_index]
	local display_name = profile_settings.display_name

	local hero_attributes = Managers.backend:get_interface("hero_attributes")
	local hero_experience = hero_attributes:get(display_name, "experience") or 0
	local hero_level = ExperienceSettings.get_level(hero_experience)

	local career_name = SPProfiles[profile_index].careers[career_index].name

	unlocked = ProgressionUnlocks.is_unlocked_for_profile(career_name, display_name, hero_level)

	return unlocked
end
--[[
	Create character selection window
--]]
mod.create_character_window = function(self)

	local feedback = function(self)
		local hero_view = mod:get_hero_view()

		if hero_view and mod.profile_index ~= self.params then

			local ingame_ui_context = hero_view.ingame_ui_context

			-- Set selected profile index
			local index = self.params
			mod.profile_index = index

			-- Backup orig profile function
			if not mod.orig_profile_by_peer then
				mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
			end

			-- Set selected career index
			local profile_settings = SPProfiles[index]
			local display_name = profile_settings.display_name
			local hero_attributes = Managers.backend:get_interface("hero_attributes")
			local career_index = not mod.orig_get_career and hero_attributes:get(display_name, "career") or mod.orig_get_career(hero_attributes, display_name, "career")
			mod.career_index = career_index

			-- Overwrite profile function
			ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
				return index
			end

			-- Backup original career function
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

			-- Reopen view
			--hero_view:_change_screen_by_index(mod.window_index)
			hero_view:_change_screen_by_name("overview", mod.sub_screen)

			-- Reload character window
			mod.new_character_window:destroy()
			mod.new_character_window = nil
			mod:create_character_window()

			-- Reload career window
			mod.new_career_window:destroy()
			mod.new_career_window = nil
			mod:create_career_window(index)

		end
	end

	local hover_enter = function(self)
		mod.characters[self.params].hovered = true
		if mod.profile_index ~= self.params then
			mod:play_sound("Play_hud_hover")
		end
	end

	local hover_exit = function(self)
		mod.characters[self.params].hovered = false
	end

	if mod.simple_ui and not self.new_character_window then

		local scale = UIResolutionScale()
		local screen_width, screen_height = UIResolution()
		local window_size = {350, 80}
		local hero_view_pos = self:get_hero_view_bottom_left_corner()
		--local window_position = {-700, 415}
		local window_position = {hero_view_pos[1] + 140, hero_view_pos[2] + 880}
		local player = Managers.player:local_player()
		local profile_index = player:profile_index()

		-- Create window
		self.new_character_window = mod.simple_ui:create_window("ui_improvements_character_new", window_position, window_size)

		-- Create buttons
		local pos_x = 5
		for _, character in pairs(self.characters) do
			character.size = {60, 60}
			character.selected = false
			character.hovered = false
			if mod.profile_index == character.character_index then
				character.size = {80, 80}
				character.selected = true
			end
			local button = self.new_character_window:create_button("ui_improvements_character_"..character.name, {pos_x, 5}, character.size, nil, character.name, character.character_index)
			button.visible = false
			button.on_click = feedback
			button.on_hover_enter = hover_enter
			button.on_hover_exit = hover_exit

			character.position = {pos_x, 5}

			pos_x = pos_x + character.size[1] + 5
		end

		self.new_character_window.on_hover_enter = function(window)
			window:focus()
		end

		-- Initialize window
		self.new_character_window.transparent = true
		self.new_character_window:init()
	end

end
--[[
	Create career selection window
--]]
mod.create_career_window = function(self, profile_index)

	local feedback = function(self)
		local hero_view = mod:get_hero_view()

		if hero_view then

			local ingame_ui_context = hero_view.ingame_ui_context

			-- Set selected profile index
			local index = self.params[1]
			mod.profile_index = index

			-- Set selected career index
			local career_index = self.params[2]
			mod.career_index = career_index

			-- Backup orig profile function
			if not mod.orig_profile_by_peer then
				mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
			end

			-- Overwrite profile function
			ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
				return index
			end

			-- Backup original career function
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

			-- Reopen view
			--hero_view:_change_screen_by_index(mod.window_index)
			hero_view:_change_screen_by_name("overview", mod.sub_screen)

			-- Reload career window
			mod.new_career_window:destroy()
			mod.new_career_window = nil
			mod:create_career_window(index)

		end
	end

	local hover_enter = function(self)
		mod.careers[self.params[1]][self.params[2]].hovered = true
		mod:play_sound("Play_hud_hover")
	end

	local hover_exit = function(self)
		mod.careers[self.params[1]][self.params[2]].hovered = false
	end

	if mod.simple_ui and not self.new_career_window then

		-- Get real career index
		local player = Managers.player:local_player()
		local career_index = player:career_index()
		local careers = self.careers[profile_index]

		-- Get some shit
		local scale = UIResolutionScale()
		local screen_width, screen_height = UIResolution()
		local window_size = {300, 100}
		local hero_view_pos = self:get_hero_view_bottom_left_corner()
		--local window_position = {-600, 225}
		local window_position = {hero_view_pos[1] + 260, hero_view_pos[2] + 680}

		-- Create window
		self.new_career_window = mod.simple_ui:create_window("ui_improvements_career", window_position, window_size)
		--self.new_career_window.position = {360*scale, screen_height - 315*scale}

		if careers then
			local pos_x = 5
			local index = 1
			for _, career in pairs(careers) do
				local size = {((window_size[1]-15)/3), (window_size[2])-10}
				local career_unlocked = self:career_unlocked(mod.profile_index, index)
				if index ~= mod.career_index and career_unlocked then
					local button = self.new_career_window:create_button("ui_improvements_career_"..career.name, {pos_x, 5}, size, nil, career.name, {career.character_index, career.career_index})
					button.visible = false
					button.on_click = feedback
					button.on_hover_enter = hover_enter
					button.on_hover_exit = hover_exit
				end
				career.hovered = false
				career.position = {pos_x, 5}
				career.size = size
				pos_x = pos_x + size[1] + 5
				index = index + 1
			end
		end

		self.new_career_window.on_hover_enter = function(window)
			window:focus()
		end

		-- Initialize window
		self.new_career_window.transparent = true
		self.new_career_window:init()

	end

end
--[[
	Reload windows
--]]
mod.reload_windows = function(self)
	self:destroy_windows()
	-- Character
	self:create_character_window()
	-- Career
	local player = Managers.player:local_player()
	local profile_index = player:profile_index()
	self:create_career_window(profile_index)
end
--[[
	Destroy windows
--]]
mod.destroy_windows = function(self)
	if self.new_character_window then
		self.new_character_window:destroy()
		self.new_character_window = nil
	end
	if self.new_career_window then
		self.new_career_window:destroy()
		self.new_career_window = nil
	end
end
--[[
	Render character icons
--]]
mod.render_character_icons = function(self)
	if self.new_character_window then
		local scale = UIResolutionScale()
		for _, c in pairs(self.characters) do
			local ts = UIAtlasHelper.get_atlas_settings_by_texture_name(c.texture)
			local uv00 = Vector2(ts.uv00[1], ts.uv00[2])
			local uv11 = Vector2(ts.uv11[1], ts.uv11[2])
			local size = Vector2(c.size[1]*scale, c.size[2]*scale)
			local offset = {self.new_character_window.position[1], self.new_character_window.position[2]}
			local pos = Vector2(c.position[1]*scale + offset[1], c.position[2]*scale + offset[2])
			local color = Color(255, 100, 100, 100)
			if c.selected or c.hovered then
				color = Color(255, 255, 255, 255)
			end
			self.basic_ui:bitmap_uv("gui_icons_atlas", uv00, uv11, pos, size, color)
		end
	end
end
--[[
	Render career icons
--]]
mod.render_career_icons = function(self)
	if self.new_career_window then
		local scale = UIResolutionScale()
		for _, c in pairs(self.careers[self.profile_index]) do
			local career_unlocked = self:career_unlocked(c.character_index, c.career_index)
			if c.career_index ~= self.career_index and career_unlocked then
				local color = Color(255, 100, 100, 100)
				if c.hovered then
					color = Color(255, 255, 255, 255)
				end

				local ts = UIAtlasHelper.get_atlas_settings_by_texture_name(c.texture)
				local uv00 = Vector2(ts.uv00[1], ts.uv00[2])
				local uv11 = Vector2(ts.uv11[1], ts.uv11[2])
				local size = Vector2(ts.size[1]*scale, ts.size[2]*scale)
				local offset = {self.new_career_window.position[1], self.new_career_window.position[2]}
				local pos = Vector2(c.position[1]*scale + offset[1], c.position[2]*scale + offset[2])
				self.basic_ui:bitmap_uv("gui_hud_atlas", uv00, uv11, pos, size, color)

				local player_portrait_frame = "default"
	 			local profile = SPProfiles[c.character_index]
	 			local career_data = profile.careers[c.career_index]
	 			local career_name = career_data.name
	 			local item = BackendUtils.get_loadout_item(career_name, "slot_frame")

	 			if item then
	 				local item_data = item.data
	 				local frame_name = item_data.temporary_template
	 				player_portrait_frame = frame_name or player_portrait_frame
	 			end

	 			local ts = UIAtlasHelper.get_atlas_settings_by_texture_name("portrait_"..player_portrait_frame)
	 			local uv00 = Vector2(ts.uv00[1], ts.uv00[2])
	 			local uv11 = Vector2(ts.uv11[1], ts.uv11[2])
	 			local _size = Vector2((ts.size[1]*scale) / 1.55, (ts.size[2]*scale) / 1.55)
	 			local _pos = Vector3(pos[1] - (_size[1] - size[1])/2, pos[2]-5, 1)
	 			self.basic_ui:bitmap_uv("gui_hud_atlas", uv00, uv11, _pos, _size, color)

			end
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Delete windows when opening loot window
--]]
mod:hook_safe(HeroViewStateLoot, "on_enter", function()
	mod:destroy_windows()
end)
--[[
	Set current sub screen in hero view
--]]
mod:hook_safe(HeroViewStateOverview, "_change_window", function(self, window_index_, window_name)
	mod.sub_screen = mod.window_settings[window_name] or mod.sub_screen
end)
--[[
	Render correct item tooltips
--]]
mod:hook(UIPasses.item_tooltip, "draw", function(func, ...)
	local player = Managers.player:local_player()
	local orig_profile_index, orig_career_index

	-- Overwrite profile function
	orig_profile_index = player.profile_index
	player.profile_index = function(self)
		return mod.profile_index or orig_profile_index(self)
	end

	-- Overwrite career function
	orig_career_index = player.career_index
	player.career_index = function(self)
		return mod.career_index or orig_career_index(self)
	end

	-- Original function
	func(...)

	-- Reset functions
	player.profile_index = orig_profile_index
	player.career_index = orig_career_index

end)
--[[
	Prevent equipment to be destroyed and spawned when not active character
--]]
mod:hook(SimpleInventoryExtension, "create_equipment_in_slot", function(func, ...)
	-- If different character or career selected cancel process
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
		return
	end
	-- Continue with original function
	func(...)
end)
--[[
	Prevent hat to be destroyed and spawned when not active character
--]]
mod:hook(PlayerUnitAttachmentExtension, "create_attachment_in_slot", function(func, ...)
	-- If different character or career selected cancel process
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
		return
	end
	-- Continue with original function
	func(...)
end)
--[[
	Prevent skin to be destroyed and spawned when not active character
--]]
mod:hook(IngameUI, "respawn", function(func, self, ...)
	-- If different character or career selected cancel process
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
		return
	end
	-- Continue with original function
	func(self, ...)
end)
--[[
	Get correct items for selected character
--]]
mod:hook(ItemGridUI, "_get_items_by_filter", function(func, self, ...)
	local player = Managers.player:local_player()
	local orig_profile_index, orig_career_index

	-- Backup profile function
	orig_profile_index = player.profile_index
	player.profile_index = function(self)
		return mod.profile_index or orig_profile_index(self)
	end

	-- Backup career function
	orig_career_index = player.career_index
	player.career_index = function(self)
		return mod.career_index or orig_career_index(self)
	end

	-- Orig function
	local items = func(self, ...)

	-- Reset functions
	player.profile_index = orig_profile_index
	player.career_index = orig_career_index

	return items
end)
--[[
	Create window when opening hero view
--]]
mod:hook(HeroView, "on_enter", function(func, self, menu_state_name, ...)
	func(self, menu_state_name, ...)

	-- Cancel process when achievements ( okris challenges ) opened
	if menu_state_name ~= "overview" then
		return
	end

	-- Set values
	local player = Managers.player:local_player()
	mod.actual_profile_index = player:profile_index()
	mod.profile_index = mod.actual_profile_index
	mod.actual_career_index = player:career_index()
	mod.career_index = mod.actual_career_index

	-- Reload window
	mod:reload_windows()
end)
--[[
	Create window when unsuspending hero view
--]]
mod:hook_safe(HeroView, "unsuspend", function()
	-- Reload window
	mod:reload_windows()
end)
--[[
	Destroy window when closing hero view
--]]
mod:hook(HeroView, "on_exit", function(func, self)
	-- Reset profile function
	if mod.orig_profile_by_peer then
		self.ingame_ui_context.profile_synchronizer.profile_by_peer = mod.orig_profile_by_peer
		mod.orig_profile_by_peer = nil
	end
	-- Reset career function
	if mod.orig_get_career then
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
	Update position of default hero protrait
--]]
mod:hook(HeroWindowOptions, "_update_hero_portrait_frame", function(func, self, ...)
	func(self, ...)

	local offset = {
		{ x = -180, },
		{ x = -80, },
		{ x = 30, },
	}

	mod:pcall(function()
		mod:dump(self._portrait_widget, "self._portrait_widget", 2)
	end)

	self._portrait_widget.offset[1] = offset[mod.career_index].x
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Get mod references when everything is loaded
--]]
mod.on_all_mods_loaded = function()
	mod.simple_ui = get_mod("SimpleUI")
	mod.basic_ui = get_mod("BasicUI")
end
--[[
	Render stuff
--]]
mod.update = function(dt)
	mod:render_character_icons()
	mod:render_career_icons()
end
