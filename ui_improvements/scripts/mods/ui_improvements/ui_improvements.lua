local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you switch equippment of all characters / classes in inventory

	Version: 1.2.0
--]]

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
mod.character_widgets = {}
mod.career_widgets = {}
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
	Get protrait frame for given profile and career
--]]
mod.get_portrait_frame = function(self, profile_index, career_index)
	local player_portrait_frame = "default"
	local profile = SPProfiles[profile_index]
	local career_data = profile.careers[career_index]
	local career_name = career_data.name
	local item = BackendUtils.get_loadout_item(career_name, "slot_frame")
	if item then
		local item_data = item.data
		local frame_name = item_data.temporary_template
		player_portrait_frame = frame_name or player_portrait_frame
	end
	return "portrait_"..player_portrait_frame
end
--[[
	Create character button widget
--]]
mod.create_character_button = function(self, profile_index)
	
	-- Values
	local root = {90, 230, 20}
	local size = {60, 60}
	local size_selected = {80, 80}
	local space = 10

	-- Calculate
	local pos = {root[1] + (size[1]+space)*(profile_index-1), root[2], root[3]}
	local is_selected = mod.profile_index == profile_index

	-- Current profile
	if mod.profile_index < profile_index then pos[1] = pos[1] + size_selected[1]-size[1] end

	-- Textures
	local icon_texture = SPProfiles[profile_index].hero_selection_image
	local glow_texture = "hero_icon_glow"

	local definition = {
		scenegraph_id = "hero_info_bg",
		element = {
			passes = {
				-- TEXTURES
				{
					pass_type = "texture",
					style_id = "icon",
					texture_id = "icon",
					content_check_function = function(content)
						return not content.button_hotspot.is_hover and not content.is_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "icon_hovered",
					texture_id = "icon",
					content_check_function = function(content)
						return content.button_hotspot.is_hover and not content.is_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "icon_selected",
					texture_id = "icon",
					content_check_function = function(content)
						return content.is_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "glow_selected",
					texture_id = "glow",
					content_check_function = function(content)
						return content.is_selected
					end
				},
				-- HOTSPOT
				{
					pass_type = "hotspot",
					style_id = "button_hotspot",
					content_id = "button_hotspot",
					content_check_function = function(content)
						return not content.is_selected
					end
				},
			},
		},

		content = {
			icon = icon_texture,
			glow = glow_texture,
			profile_index = profile_index,
			button_hotspot = {},
			is_selected = is_selected,
		},

		style = {
			-- TEXTURES
			icon = {
				offset = pos,
				size = size,
				color = {255, 127, 127, 127}
			},
			icon_hovered = {
				offset = {pos[1]-3, pos[2], pos[3]},
				size = {size[1]+6, size[2]+6},
				color = {255, 200, 200, 200}
			},
			icon_selected = {
				offset = pos,
				size = size_selected,
				color = {255, 255, 255, 255}
			},
			glow_selected = {
				offset = {pos[1]-35, pos[2]-35, pos[3]},
				size = {size_selected[1]+70, size_selected[2]+70},
				color = {255, 200, 200, 200}
			},
			-- HOTSPOT
			button_hotspot = {
				offset = pos,
				size = size,
			},
		},
	}

	return UIWidget.init(definition)
end
--[[
	Change character
--]]
mod.change_character = function(self, profile_index)
	local hero_view = mod:get_hero_view()

	if hero_view and mod.profile_index ~= profile_index then

		local ingame_ui_context = hero_view.ingame_ui_context

		-- Set selected profile index
		mod.profile_index = profile_index

		-- Backup orig profile function
		if not mod.orig_profile_by_peer then
			mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
		end

		-- Set selected career index
		local profile_settings = SPProfiles[profile_index]
		local display_name = profile_settings.display_name
		local hero_attributes = Managers.backend:get_interface("hero_attributes")
		local career_index = not mod.orig_get_career and hero_attributes:get(display_name, "career") or mod.orig_get_career(hero_attributes, display_name, "career")
		mod.career_index = career_index

		-- Overwrite profile function
		ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
			return profile_index
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
		hero_view:_change_screen_by_name("overview", mod.sub_screen)

	end
end
--[[
	Create career button widget
--]]
mod.create_career_button = function(self, profile_index, career_index)

	-- Values
	local root = {200, 40, 20}
	local size = {60, 70}
	local space = 50

	-- Calculate
	local pos = {root[1] + (size[1]+space)*(career_index-1), root[2], root[3]}
	local is_selected = mod.career_index == career_index

	-- Textures
	local career_settings = SPProfiles[profile_index].careers[career_index]
	local portrait_texture = "small_"..career_settings.portrait_image
	local portrait_frame_texture = self:get_portrait_frame(profile_index, career_index)
	local frame_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(portrait_frame_texture)
	local frame_size = {frame_settings.size[1] / 1.55, frame_settings.size[2] / 1.55}
	local frame_pos = {pos[1] - frame_size[1]/2 + size[1]/2, pos[2] - 5, pos[3]}

	local definition = {
		scenegraph_id = "hero_info_bg",
		element = {
			passes = {
				-- TEXTURES
				{
					pass_type = "texture",
					style_id = "portrait",
					texture_id = "portrait",
					content_check_function = function(content)
						return not content.button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "portrait_hovered",
					texture_id = "portrait",
					content_check_function = function(content)
						return content.button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "portrait_frame",
					texture_id = "portrait_frame",
					content_check_function = function(content)
						return not content.button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "portrait_frame_hovered",
					texture_id = "portrait_frame",
					content_check_function = function(content)
						return content.button_hotspot.is_hover
					end
				},
				-- HOTSPOT
				{
					pass_type = "hotspot",
					style_id = "button_hotspot",
					content_id = "button_hotspot",
				},
			},
		},

		content = {
			portrait = portrait_texture,
			portrait_frame = portrait_frame_texture,
			profile_index = profile_index,
			career_index = career_index,
			button_hotspot = {},
			is_selected = is_selected,
		},

		style = {
			-- TEXTURES
			portrait = {
				offset = pos,
				size = size,
				color = {255, 127, 127, 127}
			},
			portrait_hovered = {
				offset = {pos[1]-3, pos[2], pos[3]},
				size = {size[1]+6, size[2]+6},
				color = {255, 255, 255, 255}
			},
			portrait_frame = {
				offset = frame_pos,
				size = frame_size,
				color = {255, 127, 127, 127}
			},
			portrait_frame_hovered = {
				offset = {frame_pos[1]-3, frame_pos[2], frame_pos[3]},
				size = {frame_size[1]+6, frame_size[2]+6},
				color = {255, 255, 255, 255}
			},
			-- HOTSPOT
			button_hotspot = {
				offset = pos,
				size = size,
			},
		},
	}

	return UIWidget.init(definition)
end
--[[
	Change career
--]]
mod.change_career = function(self, profile_index, career_index)
	local hero_view = mod:get_hero_view()

	if hero_view then

		local ingame_ui_context = hero_view.ingame_ui_context

		-- Set selected profile index
		mod.profile_index = profile_index

		-- Set selected career index
		mod.career_index = career_index

		-- Backup orig profile function
		if not mod.orig_profile_by_peer then
			mod.orig_profile_by_peer = ingame_ui_context.profile_synchronizer.profile_by_peer
		end

		-- Overwrite profile function
		ingame_ui_context.profile_synchronizer.profile_by_peer = function(self, peer_id, local_player_id)
			return profile_index
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
		hero_view:_change_screen_by_name("overview", mod.sub_screen)

	end
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
	Destroy window when closing hero view
--]]
mod:hook(HeroView, "on_exit", function(func, self, ...)
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
	func(self, ...)
end)
--[[
	Update position of default hero protrait
--]]
mod:hook_safe(HeroWindowOptions, "_update_hero_portrait_frame", function(self, ...)
	local offset = {
		{ x = -180, },
		{ x = -80, },
		{ x = 30, },
	}
	self._portrait_widget.offset[1] = offset[mod.career_index].x
end)
--[[
	Create widgets
--]]
mod:hook_safe(HeroWindowOptions, "create_ui_elements", function(self, ...)
	-- Character buttons
	for p = 1, 5 do
		mod.character_widgets[p] = mod:create_character_button(p)
	end
	-- Career buttons
	for c = 1, 3 do
		mod.career_widgets[c] = mod:create_career_button(mod.profile_index, c)
	end
end)
--[[
	Draw button widgets
--]]
mod:hook_safe(HeroWindowOptions, "draw", function(self, dt, ...)
	-- Get some shit
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:window_input_service()
	-- Begin drawing
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	-- Character buttons
	for _, widget in pairs(mod.character_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end
	-- Career buttons
	for _, widget in pairs(mod.career_widgets) do
		local career_unlocked = mod:career_unlocked(widget.content.profile_index, widget.content.career_index)
		if widget.content.career_index ~= mod.career_index and career_unlocked then
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end
	-- End drawing
	UIRenderer.end_pass(ui_renderer)
end)
--[[
	Handle hover effects
--]]
mod:hook_safe(HeroWindowOptions, "update", function(self, ...)
	-- Character buttons
	for _, widget in pairs(mod.character_widgets) do
		if self:_is_button_hover_enter(widget) then
			if mod.profile_index ~= widget.content.profile_index then
				self:_play_sound("play_gui_equipment_button_hover")
			end
		end
	end
	-- Career buttons
	for _, widget in pairs(mod.career_widgets) do
		if self:_is_button_hover_enter(widget) then
			self:_play_sound("play_gui_equipment_button_hover")
		end
	end
end)
--[[
	Handle button press
--]]
mod:hook_safe(HeroWindowOptions, "post_update", function(self, ...)
	if not mod.crafting_animation_running then
		-- Character buttons
		for _, widget in pairs(mod.character_widgets) do
			if self:_is_button_pressed(widget) then
				mod:change_character(widget.content.profile_index)
			end
		end
		-- Career buttons
		for _, widget in pairs(mod.career_widgets) do
			if self:_is_button_pressed(widget) then
				mod:change_career(widget.content.profile_index, widget.content.career_index)
			end
		end
	end
end)
--[[
	Check if crafting animations are running
--]]
mod:hook_safe(HeroWindowCrafting, "_update_animations", function(self, ...)
	mod.crafting_animation_running = #self._animations == 0
end)
--[[
	Open chest for other heroes
--]]
mod:hook(HeroViewStateLoot, "_open_chest", function(func, self, ...)
	-- Change hero name
	self.hero_name = SPProfiles[mod.profile_index].display_name
	-- Original function
	func(self, ...)
end)
























