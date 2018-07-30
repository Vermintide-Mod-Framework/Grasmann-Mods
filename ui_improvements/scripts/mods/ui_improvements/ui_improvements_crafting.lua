local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Displays seperate buttons for every crafting page

	Version: 1.5.1
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
local saved_index = 1
local dont_save = false
mod.craft_button_widgets = {}
mod.button_list = {
	mod:localize("crafting_button_salvage"),
	mod:localize("crafting_button_craft"),
	mod:localize("crafting_button_properties"),
	mod:localize("crafting_button_trait"),
	mod:localize("crafting_button_upgrade"),
	mod:localize("crafting_button_extract_illusion"),
	mod:localize("crafting_button_apply_illusion"),
	mod:localize("crafting_button_convert_dust"),
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
	local size = {254, 28}
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
					style_id = "background_solid",
					pass_type = "rect",
				},
				{
					texture_id = "hover_glow",
					style_id = "hover_glow",
					pass_type = "texture",
					content_check_function = function(content)
						return content.button_hotspot.is_hover or saved_index == content.index
					end,
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text",
					content_check_function = function(content)
						return not content.button_hotspot.is_hover or saved_index == content.index
					end,
				},
				{
					style_id = "text_glow",
					pass_type = "text",
					text_id = "text",
					content_check_function = function(content)
						return content.button_hotspot.is_hover or saved_index == content.index
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
			disable_button = false,
		},

		style = {
			-- TEXTURES
			background = {
				color = {255, 150, 150, 150},
				offset = {0, 0, 0},
				size = size,
			},
			background_solid = {
				color = {127, 0, 0, 0},
				offset = {0, 0, pos[3]-10},
				size = size,
			},
			background_fade = {
				color = {255, 255, 255, 255},
				offset = {0, 0, 0},
				size = size,
			},
			hover_glow = {
				color = {200, 255, 255, 255},
				offset = {0, 0, pos[3]+4},
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
				offset = {0, 0, 0},
				size = size,
			},
			text_shadow = {
				upper_case = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("black", 255),
				default_text_color = Colors.get_color_table_with_alpha("black", 255),
				offset = {0, 0, -1},
				size = size,
			},
			glass_top = {
				color = {255, 255, 255, 255},
				offset = {0, size[2]-12, pos[3]+4},
				size = {size[1], 11},
			},
			glass_bottom = {
				color = {100, 255, 255, 255},
				offset = {0, -8, pos[3]+4},
				size = {size[1], 11},
			},
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
				offset = {size[1]-7, size[2]-8, pos[3]+5},
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
--[[
	Disable controls
--]]
mod.disable_crafting_controls = function(self, disable)
	for _, widget in pairs(mod.craft_button_widgets) do
		widget.content.disable_button = disable
	end
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
mod:hook_safe(HeroWindowCrafting, "create_ui_elements", function(...)
	
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
	if not dont_save then
		saved_index = current_page
	end

end)
--[[
    Check for button press
    Change crafting recipe
--]]
mod:hook_safe(HeroWindowCrafting, "post_update", function(self, ...)
	-- Iterate through crafting buttons
	for _, widget in pairs(mod.craft_button_widgets) do
		-- Check if button is pressed
		if not widget.content.disable_button and self:_is_button_pressed(widget) then
			-- Open crafting page
			self:_play_sound("play_gui_craft_recipe_next")
			self:_change_recipe_page(widget.content.index)
		end
	end
end)
--[[
    Handle hover sound
--]]
mod:hook_safe(HeroWindowCrafting, "update", function(self, ...)
	-- Iterate through crafting buttons
	for _, widget in pairs(mod.craft_button_widgets) do
		-- Check if button is hovered
		if not widget.content.disable_button and widget.content.button_hotspot.on_hover_enter then
			-- Play hover sound
			self:_play_sound("play_gui_equipment_button_hover")
		end
	end
end)
--[[
    Change to saved crafting recipe on enter
--]]
mod:hook(HeroWindowCrafting, "on_enter", function(func, self, ...)

	-- Prevent saved craft page to be overwritten
	dont_save = true
	func(self, ...)
	dont_save = false

	-- Open saved craft page
	if saved_index and mod:get("remember_categories") then
		self:_change_recipe_page(saved_index)
	end

end)
--[[
	Disable controls on craft
--]]
mod:hook_safe(HeroWindowCrafting, "craft", function(...)
	mod:disable_controls(true)
end)
--[[
	Enable controls after craft
--]]
mod:hook(HeroWindowCrafting, "_update_craft_end_time", function(func, self, ...)
	
	-- Check if craft end time running
	local is_waiting = false
	if self._craft_end_duration then is_waiting = true end

	-- Original function
	func(self, ...)

	-- Check if craft end time reached and enable controls
	if is_waiting and not self._craft_end_duration then
		mod:disable_controls(false)
	end

end)
--[[
	Remove digit limit for crafting material panel
--]]
mod:hook_safe(HeroWindowInventory, "_update_crafting_material_panel", function(self, ...)
	local backend_items = Managers.backend:get_interface("items")
	local material_order = UISettings.crafting_material_order
	local index = 1

	for index, item_key in ipairs(material_order) do
		local item_filter = "item_key == " .. item_key
		local items = backend_items:get_filtered_items(item_filter)
		local item = items and items[1]
		local backend_id = item and item.backend_id
		local amount = (backend_id and backend_items:get_item_amount(backend_id)) or 0
		local widget = self._widgets_by_name["material_text_" .. index]
		local amount_text = tostring(amount)
		widget.content.text = amount_text
	end

end)
