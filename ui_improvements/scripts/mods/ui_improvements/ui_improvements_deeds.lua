local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Difficulty filter for deed list
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.divider_right_2 = nil
mod.deed_widgets = {}
local saved_difficulty = "easy"
local selected_deed_width = 238
local unselected_deed_width = 46

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Create vertical divider widget
--]]
mod.create_vertical_window_divider = function(self, scenegraph_id, size)
	local widget = {
		element = {
			passes = {
				{
					texture_id = "edge",
					style_id = "edge",
					pass_type = "tiled_texture"
				},
				{
					texture_id = "edge_holder_top",
					style_id = "edge_holder_top",
					pass_type = "texture"
				},
				{
					texture_id = "edge_holder_bottom",
					style_id = "edge_holder_bottom",
					pass_type = "texture"
				}
			}
		},
		content = {
			edge = "menu_frame_09_divider_vertical",
			edge_holder_top = "menu_frame_09_divider_top",
			edge_holder_bottom = "menu_frame_09_divider_bottom"
		},
		style = {
			edge = {
				color = {255, 255, 255, 255},
				offset = {0, 6, 6},
				size = {5, size[2] - 9},
				texture_tiling_size = {5, size[2] - 9}
			},
			edge_holder_top = {
				color = {255, 255, 255, 255},
				offset = {-6, size[2] - 7, 10},
				size = {17, 9}
			},
			edge_holder_bottom = {
				color = {255, 255, 255, 255},
				offset = {-6, 3, 10},
				size = {17, 9}
			}
		},
		scenegraph_id = scenegraph_id,
		offset = {0, 0, 10}
	}

	return UIWidget.init(widget)
end
--[[
    Update difficulty widgets
--]]
mod.update_difficulty_widgets = function(self)
    local offset = 0

    for _, widget in pairs(mod.deed_widgets) do

        widget.offset[1] = offset

        if widget.content.is_selected then
            widget.style.hotspot.size = {selected_deed_width, 42}
            offset = offset + selected_deed_width
        else
            widget.style.hotspot.size = {unselected_deed_width, 42}
            offset = offset + unselected_deed_width
        end

    end

end
--[[
    Create difficulty widget
--]]
mod.create_difficulty_button = function(self, scenegraph_id, difficulty, is_selected)

    local root = {0, 0, 0}
    local start_pos = {5, 6, 2}
    local icon = DifficultySettings[difficulty].display_image
    local text = Localize(DifficultySettings[difficulty].display_name)
    if difficulty == "easy" then
        icon = "loot_chest_icon"
        text = mod:localize("deed_filter_all")
    end
    local font_size = 16
    local icon_size = {32, 32}
    
    local widget = {
		element = {
			passes = {
                -- Background
                {
					style_id = "background_solid",
                    pass_type = "rect",
                    content_check_function = function(content)
						return not content.is_selected
					end,
                },
                {
					style_id = "background_solid_selected",
                    pass_type = "rect",
                    content_check_function = function(content)
						return content.is_selected
					end,
				},
                -- Icon
				{
					texture_id = "icon",
					style_id = "icon",
                    pass_type = "texture",
                    content_check_function = function(content)
						return not content.is_selected
					end,
                },
                {
					texture_id = "icon",
					style_id = "icon_hovered",
                    pass_type = "texture",
                    content_check_function = function(content)
						return not content.is_selected and content.button_hotspot.is_hover
					end,
                },
                {
					texture_id = "icon",
					style_id = "icon_selected",
                    pass_type = "texture",
                    content_check_function = function(content)
						return content.is_selected
					end,
                },
                -- Text
                {
					style_id = "text",
					pass_type = "text",
                    text_id = "text",
                    content_check_function = function(content)
						return content.is_selected
					end,
                },
                -- {
				-- 	style_id = "text_glow",
				-- 	pass_type = "text",
				-- 	text_id = "text",
				-- 	content_check_function = function(content)
				-- 		return content.is_selected
				-- 	end,
                -- },
                {
					style_id = "text_shadow",
					pass_type = "text",
					text_id = "text",
				},
                -- Hotspot
                {
					style_id = "hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
                },
                -- Button
                {
					texture_id = "background_fade",
					style_id = "background_fade",
                    pass_type = "texture",
                    content_check_function = function(content)
						return not content.is_selected
					end,
                },
                {
					texture_id = "background_fade",
					style_id = "background_fade_selected",
                    pass_type = "texture",
                    content_check_function = function(content)
						return content.is_selected
					end,
                },
                {
					texture_id = "hover_glow",
					style_id = "hover_glow",
					pass_type = "texture",
					content_check_function = function(content)
						return not content.is_selected and content.button_hotspot.is_hover
					end,
                },
                {
					texture_id = "hover_glow",
					style_id = "hover_glow_selected",
					pass_type = "texture",
					content_check_function = function(content)
						return content.is_selected
					end,
                },
                {
					texture_id = "glass",
					style_id = "glass_top",
                    pass_type = "texture",
                    content_check_function = function(content)
						return not content.is_selected
					end,
                },
                {
					texture_id = "glass",
					style_id = "glass_top_selected",
                    pass_type = "texture",
                    content_check_function = function(content)
						return content.is_selected
					end,
				},
				{
					texture_id = "glass",
					style_id = "glass_bottom",
                    pass_type = "texture",
                    content_check_function = function(content)
						return not content.is_selected
					end,
                },
                {
					texture_id = "glass",
					style_id = "glass_bottom_selected",
                    pass_type = "texture",
                    content_check_function = function(content)
						return content.is_selected
					end,
				},
                -- Edge
                {
					texture_id = "edge",
					style_id = "edge",
					pass_type = "tiled_texture",
				},
				{
					texture_id = "edge_holder_top",
					style_id = "edge_holder_top",
					pass_type = "texture",
				},
				{
					texture_id = "edge_holder_bottom",
					style_id = "edge_holder_bottom",
					pass_type = "texture",
				},
			}
		},
		content = {
            icon = icon,
            text = text or "n/a",
            button_hotspot = {},
            is_selected = is_selected,
            difficulty = difficulty,
            background_fade = "button_bg_fade",
            edge = "menu_frame_09_divider_vertical",
			edge_holder_top = "menu_frame_09_divider_top",
            edge_holder_bottom = "menu_frame_09_divider_bottom",
            hover_glow = "button_state_default",
            glass = "button_glass_02",
		},
		style = {
            -- Background
            background_solid = {
				color = {255, 0, 0, 0},
				offset = {0, 0, 1},
				size = {unselected_deed_width, 42},
            },
            background_solid_selected = {
				color = {255, 0, 0, 0},
				offset = {0, 0, 1},
				size = {selected_deed_width, 42},
			},
            -- Icon
			icon = {
				color = {200, 127, 127, 127},
				offset = {start_pos[1]+5, start_pos[2]+1, 6},
				size = icon_size,
            },
            icon_hovered = {
				color = {255, 200, 200, 200},
				offset = {start_pos[1]+5, start_pos[2]+1, 6},
				size = icon_size,
            },
            icon_selected = {
				color = {255, 255, 255, 255},
				offset = {start_pos[1]+5, start_pos[2]+1, 6},
				size = icon_size,
            },
            -- Text
            text = {
				upper_case = true,
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				default_text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				select_text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {icon_size[1] + 15, 12, 2},
            },
			text_shadow = {
				upper_case = true,
				word_wrap = true,
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("black", 255),
				default_text_color = Colors.get_color_table_with_alpha("black", 255),
				offset = {icon_size[1] + 15, 12, 1},
			},
            -- Hotspot
            hotspot = {
                offset = start_pos,
                size = {unselected_deed_width, 42},
            },
            -- Button
            background_fade = {
				color = {255, 255, 255, 255},
				offset = {5, 6, 2},
				size = {unselected_deed_width, 42},
            },
            background_fade_selected = {
				color = {255, 255, 255, 255},
				offset = {5, 6, 2},
				size = {selected_deed_width, 42},
            },
            hover_glow = {
				color = {200, 255, 255, 255},
				offset = {0, 0, 8},
				size = {unselected_deed_width, math.min(38 - 5, 80)},
            },
            hover_glow_selected = {
				color = {200, 255, 255, 255},
				offset = {0, 0, 8},
				size = {selected_deed_width, math.min(38 - 5, 80)},
            },
            glass_top = {
				color = {255, 255, 255, 255},
				offset = {0, 31, 8},
				size = {unselected_deed_width, 11},
            },
            glass_top_selected = {
				color = {255, 255, 255, 255},
				offset = {0, 31, 8},
				size = {selected_deed_width, 11},
			},
			glass_bottom = {
				color = {100, 255, 255, 255},
				offset = {0, -3, 8},
				size = {unselected_deed_width, 11},
            },
            glass_bottom_selected = {
				color = {100, 255, 255, 255},
				offset = {0, -3, 8},
				size = {selected_deed_width, 11},
			},
            -- Edge
            edge = {
				color = {255, 255, 255, 255},
				offset = {0, 6, 20},
				size = {5, 38},
				texture_tiling_size = {5, 38},
			},
			edge_holder_top = {
				color = {255, 255, 255, 255},
				offset = {-6, 42 - 7, 20},
				size = {17, 9},
			},
			edge_holder_bottom = {
				color = {255, 255, 255, 255},
				offset = {-6, 3, 20},
				size = {17, 9},
			},
		},
		scenegraph_id = scenegraph_id,
		offset = {root[1], root[2], root[3]},
    }
    
    return UIWidget.init(widget)
end
--[[
    Filter item grid
--]]
mod.filter_item_grid = function(self, mutator_grid, difficulty)

    -- Filter items
    local item_filter = "slot_type == deed"
    local item_grid = mutator_grid._item_grid
    item_grid:change_item_filter(item_filter, true)

    --if difficulty == "easy" then return end

    local items = {}

    if difficulty ~= "easy" then
        for _, item in pairs(item_grid._items) do
            if item.data.difficulties[1] == difficulty then
                items[#items+1] = item
            end
        end

        item_grid._items = items
    end

    local num_slots = item_grid._widget.content.slots
    local num_items = #items
    local total_pages = math.max(math.ceil(num_items / num_slots), 1)
    item_grid._total_item_pages = total_pages

    item_grid:set_item_page(1)

    -- Select first deed if any
    local first_item = item_grid:get_item_in_slot(1, 1)
    if first_item then
        mutator_grid.parent:set_selected_heroic_deed_backend_id(first_item.backend_id)
    end

end
--[[
    Set difficulty widget
--]]
mod.activate_difficulty = function(self, difficulty)
    for _, widget in pairs(mod.deed_widgets) do
        if widget.content.difficulty == difficulty then
            for _, widget in pairs(mod.deed_widgets) do
                widget.content.is_selected = false
            end
            widget.content.is_selected = true
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
--[[
    Load saved difficulty on enter
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "on_enter", function(self, ...)
    if saved_difficulty and mod:get("remember_categories") then
        if mod:activate_difficulty(saved_difficulty) then
            mod:update_difficulty_widgets()
            mod:filter_item_grid(self, saved_difficulty)
        end
    end
end)
--[[
    Manipulate default widgets and create mod widgets
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "create_ui_elements", function(self, ...)
    local button_size = {213, 42}
    local edge_size = {0, 42}

    -- Button previous
    local button_previous_style = self._widgets_by_name.page_button_previous.style
    button_previous_style["glass_bottom"].size[1] = button_size[1]
    button_previous_style["glass_top"].size[1] = button_size[1]
    button_previous_style["background_fade"].size[1] = button_size[1]
    button_previous_style["hover_glow"].size[1] = button_size[1]
    button_previous_style["title_text_disabled"].size = button_size
    button_previous_style["title_text_shadow"].size = button_size
    button_previous_style["title_text"].size = button_size

    -- Button edge left
    local button_edge_left = self._widgets_by_name.page_button_edge_left
    button_edge_left.offset[1] = -button_size[1]

    -- Text area
    local page_text_area = self._widgets_by_name.page_text_area
    page_text_area.offset[1] = -button_size[1]
    local page_text_left = self._widgets_by_name.page_text_left
    page_text_left.offset[1] = -button_size[1]
    local page_text_right = self._widgets_by_name.page_text_right
    page_text_right.offset[1] = -button_size[1]
    local page_text_center = self._widgets_by_name.page_text_center
    page_text_center.offset[1] = -button_size[1]

    -- Button edge right
    local button_edge_right = self._widgets_by_name.page_button_edge_right
    button_edge_right.offset[1] = -button_size[1]

    -- Button next
    local button_next_style = self._widgets_by_name.page_button_next.style
    button_next_style["glass_bottom"].size[1] = button_size[1]
    button_next_style["glass_top"].size[1] = button_size[1]
    button_next_style["background_fade"].size[1] = button_size[1]
    button_next_style["hover_glow"].size[1] = button_size[1]
    button_next_style["title_text_disabled"].size = button_size
    button_next_style["title_text_shadow"].size = button_size
    button_next_style["title_text"].size = button_size
    local button_next = self._widgets_by_name.page_button_next
    button_next.offset[1] = -button_size[1]

    -- Button edge right #2
    mod.divider_right_2 = mod:create_vertical_window_divider("page_button_next", edge_size)

    -- test
    mod.deed_widgets[1] = mod:create_difficulty_button("page_button_next", "easy", true)
    mod.deed_widgets[2] = mod:create_difficulty_button("page_button_next", "normal")
    mod.deed_widgets[3] = mod:create_difficulty_button("page_button_next", "hard")
    mod.deed_widgets[4] = mod:create_difficulty_button("page_button_next", "harder")
    mod.deed_widgets[5] = mod:create_difficulty_button("page_button_next", "hardest")

end)
--[[
    Handle draw widgets
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "draw", function(self, dt, ...)
    local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
    local input_service = self.parent:window_input_service()

    -- Update widgets
    mod:update_difficulty_widgets()

    -- Draw widgets
    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
    UIRenderer.draw_widget(ui_renderer, mod.divider_right_2)
    for _, widget in pairs(mod.deed_widgets) do
        UIRenderer.draw_widget(ui_renderer, widget)
    end
    UIRenderer.end_pass(ui_renderer)

end)
--[[
    Handle input
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "update", function(self, ...)
    for _, widget in pairs(mod.deed_widgets) do

        -- Handle hover effect
        if not widget.content.is_selected and self:_is_button_hovered(widget) then
            self:_play_sound("play_gui_equipment_button_hover")
        end

        -- Handle button press
        if not widget.content.is_selected and self:_is_button_pressed(widget) then

            -- Deactivate widgets
            for _, widget in pairs(mod.deed_widgets) do
                widget.content.is_selected = false
            end

            -- Activate pressed widget
            widget.content.is_selected = true
            self:_play_sound("play_gui_craft_recipe_next")

            -- Update appearance
            mod:update_difficulty_widgets()

            -- Save difficulty
            saved_difficulty = widget.content.difficulty

            -- Filter item grid
            mod:filter_item_grid(self, widget.content.difficulty)

        end
        
    end
end)


