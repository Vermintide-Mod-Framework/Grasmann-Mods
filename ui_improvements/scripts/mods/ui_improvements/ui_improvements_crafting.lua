local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Displays seperate buttons for every crafting page

	Version: 1.2.0
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.craft_page = nil
mod.dont_save_craft_page = false
mod.craft_button_widgets = {}
mod.button_list = {
    "Salvage Items",
    "Craft Item",
    "Re-Roll Properties",
    "Re-Roll Trait",
    "Upgrade Item",
    "Extract Illusion",
    "Apply Illusion",
    "Convert Dust",
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Create crafting button
--]]
mod.create_craft_button = function(self, index, text)

	local border = 3
	local move_table = {
		{0, 3, 0}, {1, 3, border}, {0, 2, 0}, {1, 2, border},
		{0, 1, 0}, {1, 1, border}, {0, 0, 0}, {1, 0, border},
	}
	local size = {254, 30}
	local root = {4, 5, 10}
	local pos = {root[1] + move_table[index][3] + size[1]*move_table[index][1], root[2] + (size[2]+border)*move_table[index][2], root[3]}
	local font_size = 14

	local definition = {
		scenegraph_id = "window_top",
		element = {
			passes = {
				-- TEXTURES
				{
					texture_id = "background_fade",
					style_id = "background_fade",
					pass_type = "texture",
				},
				{
					texture_id = "hover_glow",
					style_id = "hover_glow",
					pass_type = "texture",
					content_check_function = function(content)
						return content.button_hotspot.is_hover
					end,
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text",
					content_check_function = function(content)
						return not content.button_hotspot.is_hover
					end,
				},
				{
					style_id = "text_glow",
					pass_type = "text",
					text_id = "text",
					content_check_function = function(content)
						return content.button_hotspot.is_hover
					end,
				},
				{
					style_id = "text_shadow",
					pass_type = "text",
					text_id = "text",
				},
				{
					texture_id = "glass",
					style_id = "glass_top",
					pass_type = "texture",
				},
				{
					texture_id = "glass",
					style_id = "glass_bottom",
					pass_type = "texture",
				},
				-- {
				-- 	texture_id = "button_left",
				-- 	style_id = "button_left",
				-- 	pass_type = "texture",
				-- },
				-- {
				-- 	texture_id = "button_right",
				-- 	style_id = "button_right",
				-- 	pass_type = "texture",
				-- },
				{
					texture_id = "divider_bottom",
					style_id = "divider_bottom",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[1] == 0 and content.move_table[2] == 0
					end,
				},
				{
					texture_id = "divider_left",
					style_id = "divider_left",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[1] == 0 --or content.move_table[2] < 3
					end,
				},
				{
					texture_id = "divider_right",
					style_id = "divider_right",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[1] == 1 --or content.move_table[2] < 3
					end,
				},
				{
					texture_id = "divider_top",
					style_id = "divider_top",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[2] == 3 and content.move_table[1] == 0
					end,
				},
				{
					texture_id = "divider_middle",
					style_id = "divider_middle",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[2] < 3 and content.move_table[1] == 0
					end,
				},
				{
					texture_id = "divider",
					style_id = "divider",
					pass_type = "texture",
				},
				{
					texture_id = "divider_vertical",
					style_id = "divider_vertical",
					pass_type = "texture",
					content_check_function = function(content)
						return content.move_table[1] == 0
					end,
				},
				-- HOTSPOT
				{
					style_id = "background",
					pass_type = "hotspot",
					content_id = "button_hotspot",
				},
			},
		},

		content = {
			glass = "button_glass_02",
			background_fade = "button_bg_fade",
			hover_glow = "button_state_default",
			button_left = "button_detail_05_left",
			button_right = "button_detail_05_right",
			text = text or "n/a",
			button_hotspot = {},
			index = index,

			move_table = move_table[index],
			divider_bottom = "menu_frame_09_divider_bottom",
			divider_left = "menu_frame_09_divider_left",
			divider_right = "menu_frame_09_divider_right",
			divider_top = "menu_frame_09_divider_top",
			divider_middle = "menu_frame_09_divider_middle",
			divider = "menu_frame_09_divider",
			divider_vertical = "menu_frame_09_divider_vertical",
		},

		style = {
			-- TEXTURES
			background = {
				color = {255, 150, 150, 150},
				--offset = pos,
				offset = {0, 0, 0},
				size = size,
			},
			background_fade = {
				color = {255, 255, 255, 255},
				--offset = pos,
				offset = {0, 0, 0},
				size = size,
			},
			hover_glow = {
				color = {200, 255, 255, 255},
				--offset = pos,
				offset = {0, 0, 0},
				size = {size[1], math.min(size[2] - 5, 80)},
			},
			text = {
				upper_case = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				default_text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				select_text_color = Colors.get_color_table_with_alpha("white", 255),
				--offset = pos,
				offset = {0, 0, 0},
				size = size,
			},
			text_glow = {
				upper_case = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("white", 255),
				default_text_color = Colors.get_color_table_with_alpha("white", 255),
				select_text_color = Colors.get_color_table_with_alpha("white", 255),
				--offset = pos,
				offset = {0, 0, 0},
				size = size,
			},
			text_shadow = {
				upper_case = true,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("black", 255),
				default_text_color = Colors.get_color_table_with_alpha("black", 255),
				--offset = {pos[1], pos[2], pos[3]-1},
				offset = {0, 0, -1},
				size = size,
			},
			glass_top = {
				color = {255, 255, 255, 255},
				--offset = {pos[1], pos[2]+15, pos[3]+4},
				offset = {0, 19, pos[3]+4},
				size = {size[1], 11},
			},
			glass_bottom = {
				color = {100, 255, 255, 255},
				--offset = {pos[1], pos[2]-3, pos[3]+4},
				offset = {0, -8, pos[3]+4},
				size = {size[1], 11},
			},
			-- button_left = {
			-- 	color = {255, 255, 255, 255},
			-- 	--offset = {pos[1], pos[2]+15, pos[3]+4},
			-- 	offset = {0, 0, pos[3]+1},
			-- 	size = {10, size[2]},
			-- },
			-- button_right = {
			-- 	color = {255, 255, 255, 255},
			-- 	offset = {size[1]-10, 0, pos[3]+1},
			-- 	size = {10, size[2]},
			-- },
			divider_bottom = {
				color = {255, 255, 255, 255},
				offset = {size[1]-7, -2, pos[3]+5},
				size = {17, 9},
			},
			divider_left = {
				color = {255, 255, 255, 255},
				offset = {-1, size[2]-7, pos[3]+5},
				size = {9, 17},
			},
			divider_right = {
				color = {255, 255, 255, 255},
				offset = {size[1]-8+move_table[index][1], size[2]-7, pos[3]+5},
				size = {9, 17},
			},
			divider_top = {
				color = {255, 255, 255, 255},
				offset = {size[1]-7, size[2]-7, pos[3]+5},
				size = {17, 9},
			},
			divider_middle = {
				color = {255, 255, 255, 255},
				offset = {size[1]-7, size[2]-7, pos[3]+5},
				size = {17, 17},
			},
			divider = {
				color = {255, 255, 255, 255},
				offset = {-1, size[2]-1, pos[3]+4},
				size = {size[1]+3, 5},
			},
			divider_vertical = {
				color = {255, 255, 255, 255},
				offset = {size[1]-1, 0, pos[3]+4},
				size = {5, size[2]},
			},
		},

		offset = pos,

	}

	return UIWidget.init(definition)
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Create crafting buttons
--]]
mod:hook_safe(HeroWindowCrafting, "create_ui_elements", function(self, params, offset, ...)
	
	-- If crafting buttons not activated exit
	if not mod:get("crafting_buttons") then return end

	-- Create crafting buttons
	for n, text in pairs(mod.button_list) do
		mod.craft_button_widgets[n] = mod:create_craft_button(n, text)
	end

end)
--[[
    Draw crafting buttons
--]]
mod:hook_safe(HeroWindowCrafting, "draw", function(self, dt, ...)

	-- If crafting buttons not activated exit
	if not mod:get("crafting_buttons") then return end

	-- Get some shit
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
    local input_service = self.parent:window_input_service()
    
	-- Begin drawing
    UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
    
	-- Render buttons
	for _, widget in pairs(mod.craft_button_widgets) do
		UIRenderer.draw_widget(ui_top_renderer, widget)
    end
    
	-- End drawing
    UIRenderer.end_pass(ui_top_renderer)
    
end)
--[[
    Hide description text on crafting window - make room for buttons
    Save selected crafting recipe
--]]
mod:hook_safe(HeroWindowCrafting, "_change_recipe_page", function(self, current_page, ...)

	-- If crafting buttons activated remove description
	if mod:get("crafting_buttons") then
		self._widgets_by_name.description_text.content.text = ""
	end
	
	-- Save opened crafting page
	if not mod.dont_save_craft_page then
		mod.craft_page = current_page
	end

end)
--[[
    Check for button press
    Change crafting recipe
--]]
mod:hook_safe(HeroWindowCrafting, "post_update", function(self, dt, t, ...)
	-- Iterate through crafting buttons
	for _, widget in pairs(mod.craft_button_widgets) do
		-- Check if button is pressed
		if self:_is_button_pressed(widget) then
			-- Open crafting page
			self:_play_sound("play_gui_craft_recipe_next")
			self:_change_recipe_page(widget.content.index)
		end
	end
end)
--[[
    Handle hover sound
--]]
mod:hook_safe(HeroWindowCrafting, "update", function(self, dt, t, ...)
	-- Iterate through crafting buttons
	for _, widget in pairs(mod.craft_button_widgets) do
		-- Check if button is hovered
		if widget.content.button_hotspot.on_hover_enter then
			-- Play hover sound
			self:_play_sound("play_gui_equipment_button_hover")
		end
	end
end)
--[[
    Change to saved crafting recipe on enter
--]]
mod:hook(HeroWindowCrafting, "on_enter", function(func, self, params, offset, ...)

	-- Prevent saved craft page to be overwritten
	mod.dont_save_craft_page = true
	func(self, params, offset, ...)
	mod.dont_save_craft_page = false

	-- Open saved craft page
	if mod.craft_page and mod:get("remember_categories") then
		self:_change_recipe_page(mod.craft_page)
	end

end)