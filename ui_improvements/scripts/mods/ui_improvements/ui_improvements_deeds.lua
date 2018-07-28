local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you switch equippment of all characters / classes in inventory

	Version: 1.3.1
--]]

mod.deed_widgets = {}

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

mod.create_difficulty_checkbox = function(self, scenegraph_id, difficulty, offset)

    local icon = DifficultySettings[difficulty].display_image
    local text = Localize(DifficultySettings[difficulty].display_name)
    local font_size = 14
    local icon_size = {38, 38}
    local is_selected = difficulty == "hardest"
    
    local widget = {
		element = {
			passes = {
				{
					texture_id = "icon",
					style_id = "icon",
					pass_type = "texture",
                },
                {
					texture_id = "icon",
					style_id = "icon_selected",
                    pass_type = "texture",
                    content_check_function = function(content)
						return content.is_selected
					end,
                },
                {
					style_id = "text",
					pass_type = "text",
                    text_id = "text",
                    content_check_function = function(content)
						return content.is_selected
					end,
				},
			}
		},
		content = {
            icon = icon,
            text = text or "n/a",
            is_selected = is_selected,
		},
		style = {
			icon = {
				color = {200, 127, 127, 127},
				offset = {0, 4, 6},
				size = icon_size,
            },
            icon_selected = {
				color = {255, 255, 255, 255},
				offset = {0, 4, 6},
				size = icon_size,
            },
            text = {
				upper_case = true,
				-- horizontal_alignment = "center",
				-- vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				default_text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				select_text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {icon_size[1], icon_size[2]/2-6, 0},
				--size = size,
			},
		},
		scenegraph_id = scenegraph_id,
		offset = {offset+10, 0, 10},
    }
    
    return UIWidget.init(widget)
end

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[

--]]
--StartGameWindowMutatorGrid.on_enter = function (self, params, offset)
mod:hook_safe(StartGameWindowMutatorGrid, "on_enter", function(self, params, offset, ...)
    --mod:echo("rofl")
end)

--StartGameWindowMutatorGrid.create_ui_elements = function (self, params, offset)
mod:hook_safe(StartGameWindowMutatorGrid, "create_ui_elements", function (self, params, offset)
    local button_size = {213, 42}
    local edge_size = {0, 42}
    local text_area_size = {213, 42}

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
    mod.deed_widgets[1] = mod:create_vertical_window_divider("page_button_next", edge_size)

    -- test
    mod.deed_widgets[2] = mod:create_difficulty_checkbox("page_button_next", "normal", 0)
    mod.deed_widgets[3] = mod:create_difficulty_checkbox("page_button_next", "hard", 40)
    mod.deed_widgets[4] = mod:create_difficulty_checkbox("page_button_next", "harder", 80)
    mod.deed_widgets[5] = mod:create_difficulty_checkbox("page_button_next", "hardest", 120)
    
end)

--StartGameWindowMutatorGrid.draw = function (self, dt)
mod:hook(StartGameWindowMutatorGrid, "draw", function(func, self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:window_input_service()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

    for _, widget in ipairs(self._widgets) do
        if not widget.content.invis then
            UIRenderer.draw_widget(ui_renderer, widget)
        end
	end

	local active_node_widgets = self._active_node_widgets

	if active_node_widgets then
        for _, widget in ipairs(active_node_widgets) do
            if not widget.content.invis then
                UIRenderer.draw_widget(ui_renderer, widget)
            end
		end
    end
    
    -- Render
    for _, widget in pairs(mod.deed_widgets) do
        UIRenderer.draw_widget(ui_renderer, widget)
    end

	UIRenderer.end_pass(ui_renderer)
end)
