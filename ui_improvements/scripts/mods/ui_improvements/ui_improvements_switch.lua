local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you switch equippment of all characters / classes in inventory
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.button_order = {4, 5, 2, 3, 1}
mod.character_widgets = {}
mod.career_widgets = {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Check if a career is unlocked
--]]
mod.career_unlocked = function(self, profile_index, career_index)
	local unlocked = false

	local profile_settings = SPProfiles[profile_index]
	local hero_name = profile_settings.display_name

	local career = profile_settings.careers[career_index]

	local hero_attributes = Managers.backend:get_interface("hero_attributes")
	local hero_experience = hero_attributes:get(hero_name, "experience") or 0
	local hero_level = ExperienceSettings.get_level(hero_experience)

	local is_career_unlocked = career:is_unlocked_function(hero_name, hero_level)

	return is_career_unlocked
end
--[[
	Get protrait frame for given profile and career
--]]
mod.get_portrait_frame = function(self, profile_index, career_index)
	local player_portrait_frame = "portrait_frame_0000"

	local profile = SPProfiles[profile_index]
	local career_data = profile.careers[career_index]
	local career_name = career_data.name
	local item = BackendUtils.get_loadout_item(career_name, "slot_frame")

	if item then
		local item_data = item.data
		local frame_name = item_data.key
		local frame_texture = UIPlayerPortraitFrameSettings[frame_name][1].texture
		player_portrait_frame = frame_texture or player_portrait_frame
	end

	mod:debug("Retrieved portrait " .. tostring(player_portrait_frame) .. "\tProfile " .. profile_index .. "\tCareer " .. career_index)
	return player_portrait_frame
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

	local p_index = mod.button_order[profile_index]
	local mp_index = mod.button_order[mod.profile_index]

	-- Calculate
	local pos = {root[1] + (size[1]+space)*(p_index-1), root[2], root[3]}
	local is_selected = mod.profile_index == profile_index

	-- Current profile
	if mp_index < p_index then pos[1] = pos[1] + size_selected[1]-size[1] end

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
			disable_button = false,
		},

		style = {
			-- TEXTURES
			icon = {
				offset = {0, 0, 0},
				size = size,
				color = {255, 127, 127, 127}
			},
			icon_hovered = {
				offset = {-3, 0, 0},
				size = {size[1]+6, size[2]+6},
				color = {255, 200, 200, 200}
			},
			icon_selected = {
				offset = {0, 0, 0},
				size = size_selected,
				color = {255, 255, 255, 255}
			},
			glow_selected = {
				offset = {-35, -35, 0},
				size = {size_selected[1]+70, size_selected[2]+70},
				color = {255, 200, 200, 200}
			},
			-- HOTSPOT
			button_hotspot = {
				offset = {0, 0, 0},
				size = size,
			},
		},
		offset = pos,
	}

	return UIWidget.init(definition)
end
--[[
	Change character
--]]
mod.change_character = function(self, profile_index)
	mod:debug("Changing character to " .. profile_index)
	if mod.profile_index ~= profile_index then

		-- Set selected profile index
		mod.profile_index = profile_index

		-- Set selected career index
		local profile_settings = SPProfiles[profile_index]
		local display_name = profile_settings.display_name
		local hero_attributes = Managers.backend:get_interface("hero_attributes")
		local career_index = not mod.orig_get_career and hero_attributes:get(display_name, "career") or mod.orig_get_career(hero_attributes, display_name, "career")
		mod.career_index = career_index
		mod:debug("Got career index for change: " .. career_index)

		-- Delete career widgets ( because not all characters have the same amount of careers now )
		mod.career_widgets = {}

		-- Overwrite functions
        mod:overwrite_functions(true)

		-- Reopen view
        self:reopen_hero_view()
		
		-- Reset functions
        mod:overwrite_functions(false)

	end
end
--[[
	Create career button widget
--]]
mod.create_career_button = function(self, profile_index, career_index)
	mod:debug("Creating career button. Profile " .. profile_index .. "\tCareer " .. career_index)
	-- Values
	local root = {200, 40, 20}
	local size = {60, 70}
	local space = 50
	if #SPProfiles[profile_index].careers == 4 then
		root = {170, 40, 20}
		space = 30
	end

	-- Calculate
	local pos = {root[1] + (size[1]+space)*(career_index-1), root[2], root[3]}
	local is_selected = mod.career_index == career_index

	-- Textures
	local career_settings = SPProfiles[profile_index].careers[career_index]
	local portrait_texture = "small_"..career_settings.portrait_image
	local portrait_frame_texture = self:get_portrait_frame(profile_index, career_index)
	local frame_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(portrait_frame_texture)
	local frame_size = {frame_settings.size[1] / 1.55, frame_settings.size[2] / 1.55}
	--local frame_pos = {pos[1] - frame_size[1]/2 + size[1]/2, pos[2] - 5, pos[3]}
	local frame_pos = {size[1]/2 - frame_size[1]/2, -5, 0}

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
			disable_button = false,
		},

		style = {
			-- TEXTURES
			portrait = {
				offset = {0, 0, 0},
				size = size,
				color = {255, 127, 127, 127}
			},
			portrait_hovered = {
				offset = {-3, 0, 0},
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
				offset = {0, 0, 0},
				size = size,
			},
		},
		offset = pos,
	}

	return UIWidget.init(definition)
end
--[[
	Change career
--]]
mod.change_career = function(self, profile_index, career_index)
	mod:debug("Changing career. Profile " .. profile_index .. "\tCareer " .. career_index)

	-- Set selected profile index
	mod.profile_index = profile_index

	-- Set selected career index
	mod.career_index = career_index

	-- Overwrite functions
	mod:overwrite_functions(true)

	-- Reopen view
	self:reopen_hero_view()

	-- Reset functions
	mod:overwrite_functions(false)

end
--[[
	Disable controls
--]]
mod.disable_switch_controls = function(self, disable)
	-- Disable character buttons
	for _, widget in pairs(mod.character_widgets) do
		widget.content.disable_button = disable
	end
	-- Disable career buttons
	for _, widget in pairs(mod.career_widgets) do
		widget.content.disable_button = disable
	end
end
--[[
	Get profile and career indices
--]]
mod.get_profile_data = function(self)
	local player = Managers.player:local_player()
	self.actual_profile_index = self.actual_profile_index or player:profile_index()
	self.profile_index = self.profile_index or self.actual_profile_index
	self.actual_career_index = self.actual_career_index or player:career_index()
	self.career_index = self.career_index or self.actual_career_index
end
--[[
	Delete profile and career indices
--]]
mod.delete_profile_data = function(self)
	self.profile_index = nil
	self.career_index = nil
	self.actual_profile_index = nil
	self.actual_career_index = nil
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Update position of default hero protrait
--]]
mod:hook_safe(HeroWindowOptions, "_update_hero_portrait_frame", function(self, ...)
	local offset = {
		{ x = -180, },
		{ x = -80, },
		{ x = 30, },
	}
	if #SPProfiles[mod.profile_index].careers == 4 then
		offset = {
			{ x = -220, },
			{ x = -130, },
			{ x = -40, },
			{ x = 40, },
		}
	end
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
	for c = 1, 4 do
		if SPProfiles[mod.profile_index].careers[c] then
			mod.career_widgets[c] = mod:create_career_button(mod.profile_index, c)
		else
			mod.career_widgets[c] = nil
		end
	end

	-- Debug
	-- self._widgets_by_name.game_option_3.content.button_hotspot.disable_button = false
	-- self._widgets_by_name.game_option_5.content.button_hotspot.disable_button = false
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
		if not widget.content.disable_button and self:_is_button_hover_enter(widget) then
			if mod.profile_index ~= widget.content.profile_index then
				self:_play_sound("play_gui_equipment_button_hover")
			end
		end
	end
	-- Career buttons
	for _, widget in pairs(mod.career_widgets) do
		if not widget.content.disable_button and self:_is_button_hover_enter(widget) then
			self:_play_sound("play_gui_equipment_button_hover")
		end
	end
end)
--[[
	Handle button press
--]]
mod:hook_safe(HeroWindowOptions, "post_update", function(self, ...)
	--if not mod.crafting_animation_running then
		-- Character buttons
		for _, widget in pairs(mod.character_widgets) do
			if not widget.content.disable_button and self:_is_button_pressed(widget) then
				mod:change_character(widget.content.profile_index)
			end
		end
		-- Career buttons
		for _, widget in pairs(mod.career_widgets) do
			if not widget.content.disable_button and self:_is_button_pressed(widget) then
				mod:debug("Attempting to switch to profile ".. widget.content.profile_index .. " career ".. widget.content.career_index)
				mod:change_career(widget.content.profile_index, widget.content.career_index)
			end
		end
	--end
end)
--[[
	Prevent player respawn after skin change
--]]
mod:hook(HeroViewStateOverview, "update_skin_sync", function(func, self, ...)
	-- If different character or career selected only update backend and menu
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
		self.skin_sync_id = self.skin_sync_id + 1
		return
	end
	-- Continue with original function
	func(self, ...)
end)
--[[
	Prevent item spawns when changing equipment
--]]
mod:hook(HeroViewStateOverview, "_set_loadout_item", function(func, self, item, strict_slot_name, ...)
	-- If different character or career selected only update backend and menu
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then

		local rarity_index = {common = 2, plentiful = 1, exotic = 4, rare = 3, unique = 5}
		--local slot_type = strict_slot_name or item.data.slot_type
		local slot, slot_type = nil
		if strict_slot_name then
			slot = InventorySettings.slots_by_name[strict_slot_name]
			slot_type = slot.type
		else
			slot_type = item.data.slot_type
			slot = self:_get_slot_by_type(slot_type)
		end
		--local slot = self:_get_slot_by_type(slot_type)
		local profile = SPProfiles[mod.profile_index]
		local career_name = profile.careers[mod.career_index].name
		local backend_items = Managers.backend:get_interface("items")

		backend_items:set_loadout_item(item.backend_id, career_name, slot.name)

		self.loadout_sync_id = self.loadout_sync_id + 1
		self.inventory_sync_id = self.inventory_sync_id + 1
		self.skin_sync_id = self.skin_sync_id + 1
		local highest_rarity = self.statistics_db:get_persistent_stat(self._stats_id, "highest_equipped_rarity", slot_type)
		local item_rarity = rarity_index[item.rarity]
		if item_rarity and highest_rarity < item_rarity then
			self.statistics_db:set_stat(self._stats_id, "highest_equipped_rarity", slot_type, item_rarity)
		end

		return
	end
	-- Continue with original function
	func(self, item, strict_slot_name, ...)
end)
