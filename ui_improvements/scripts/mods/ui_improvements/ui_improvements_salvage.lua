local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Allows for multiple pages of items to be salvaged
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.button_previous = nil
mod.text_area = nil
mod.button_next = nil
mod.salvage_controls = {}

mod.all_salvage_items = {}
mod.salvage_pages = 1
mod.active_salvage_page = 1

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Create ui elements
--]]
mod.create_salvage_element = function(self, element, offset)
    local window_default_settings = UISettings.game_start_windows
    local window_size = window_default_settings.size
    local size = {window_size[1]/3, 42}

    local text = ""
    if element == "previous" then
        text = "Previous"
    elseif element == "next" then
        text = "Next"
    elseif element == "text" then
        text = "1/1"
    end

    local widget = {}
    if element == "previous" or element == "next" then
        widget = UIWidgets.create_simple_window_button("item_grid", size, text, 16)
        widget.style.background.size = size
        widget.style.clicked_rect.size = size
        widget.style.disabled_rect.size = size
        widget.style.title_text.size = size
        widget.style.title_text_disabled.size = size
        widget.style.title_text_shadow.size = size
        widget.offset = offset
    elseif element == "text" then
        widget = {
            element = {
                passes = {
                    {
                        style_id = "text",
                        pass_type = "text",
                        text_id = "text",
                    },
                    {
                        style_id = "background_solid",
                        pass_type = "rect",
                    },
                },
            },
            content = {
                text = text or "n/a",
            },
            style = {
                background_solid = {
                    color = {255, 0, 0, 0},
                    offset = {6, 0, offset[3]},
                    size = size,
                },
                text = {
                    upper_case = true,
                    horizontal_alignment = "center",
                    vertical_alignment = "center",
                    font_type = "hell_shark",
                    font_size = 20,
                    text_color = Colors.get_color_table_with_alpha("white", 255),
                    default_text_color = Colors.get_color_table_with_alpha("white", 255),
                    select_text_color = Colors.get_color_table_with_alpha("white", 255),
                    offset = {5, 2, offset[3]+1},
                    size = size,
                },
            },
            scenegraph_id = "item_grid",
            offset = offset,
        }
    end

    local passes = widget.element.passes
    local content = widget.content
    local style = widget.style

    if element == "previous" then
        passes[#passes+1] = {
            texture_id = "divider_left",
            style_id = "divider_left",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_left",
            style_id = "divider_left_2",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_bottom",
            style_id = "divider_bottom",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_top",
            style_id = "divider_top",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider_2",
            pass_type = "texture",
        }
        content.divider_left = "menu_frame_09_divider_left"
        content.divider_bottom = "menu_frame_09_divider_bottom"
        content.divider_top = "menu_frame_09_divider_top"
        content.divider = "menu_frame_09_divider"
        style.divider_left = {
            color = {255, 255, 255, 255},
            offset = {-1, size[2]-5, offset[3]+2},
            size = {9, 17},
        }
        style.divider_left_2 = {
            color = {255, 255, 255, 255},
            offset = {-1, -6, offset[3]+2},
            size = {9, 17},
        }
        style.divider_bottom = {
            color = {255, 255, 255, 255},
            offset = {size[1]-7, 3, offset[3]+2},
            size = {17, 9},
        }
        style.divider_top = {
            color = {255, 255, 255, 255},
            offset = {size[1]-7, size[2]-6, offset[3]+2},
            size = {17, 9},
        }
        style.divider = {
            color = {255, 255, 255, 255},
            offset = {0, size[2]+1, offset[3]+1},
            size = {size[1], 5},
        }
        style.divider_2 = {
            color = {255, 255, 255, 255},
            offset = {0, 0, offset[3]+1},
            size = {size[1], 5},
        }
    elseif element == "next" then
        passes[#passes+1] = {
            texture_id = "divider_bottom",
            style_id = "divider_bottom",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_top",
            style_id = "divider_top",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_right",
            style_id = "divider_right",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_right",
            style_id = "divider_right_2",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider_2",
            pass_type = "texture",
        }
        content.divider_bottom = "menu_frame_09_divider_bottom"
        content.divider_top = "menu_frame_09_divider_top"
        content.divider = "menu_frame_09_divider"
        content.divider_right = "menu_frame_09_divider_right"
        style.divider_bottom = {
            color = {255, 255, 255, 255},
            offset = {-7, 3, offset[3]+2},
            size = {17, 9},
        }
        style.divider_top = {
            color = {255, 255, 255, 255},
            offset = {-7, size[2]-6, offset[3]+2},
            size = {17, 9},
        }
        style.divider_right = {
            color = {255, 255, 255, 255},
            offset = {size[1]-10, size[2]-5, offset[3]+2},
            size = {9, 17},
        }
        style.divider_right_2 = {
            color = {255, 255, 255, 255},
            offset = {size[1]-10, -6, offset[3]+2},
            size = {9, 17},
        }
        style.divider = {
            color = {255, 255, 255, 255},
            offset = {0, size[2]+1, offset[3]+1},
            size = {size[1], 5},
        }
        style.divider_2 = {
            color = {255, 255, 255, 255},
            offset = {0, 0, offset[3]+1},
            size = {size[1], 5},
        }
    elseif element == "text" then
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider",
            style_id = "divider_2",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_vertical",
            style_id = "divider_vertical",
            pass_type = "texture",
        }
        passes[#passes+1] = {
            texture_id = "divider_vertical",
            style_id = "divider_vertical_2",
            pass_type = "texture",
        }
        content.divider = "menu_frame_09_divider"
        content.divider_vertical = "menu_frame_09_divider_vertical"
        style.divider = {
            color = {255, 255, 255, 255},
            offset = {0, size[2]+1, offset[3]+1},
            size = {size[1]+2, 5},
        }
        style.divider_2 = {
            color = {255, 255, 255, 255},
            offset = {0, 0, offset[3]+1},
            size = {size[1]+2, 5},
        }
        style.divider_vertical = {
            color = {255, 255, 255, 255},
            offset = {size[1]+1, 3, offset[3]+1},
            size = {5, size[2]-2},
        }
        style.divider_vertical_2 = {
            color = {255, 255, 255, 255},
            offset = {7, 3, offset[3]+1},
            size = {5, size[2]-2},
        }
    end

    return UIWidget.init(widget)
end
--[[
    Update ui elements
--]]
mod.update_salvage_elements = function(self)

    local page = self.active_salvage_page
    local pages = self.salvage_pages

    -- Text
    self.text_area.content.text = tostring(page).."/"..tostring(pages)

    -- Previous
    if page > 1 then
        self.button_previous.content.button_hotspot.disable_button = false
    else
        self.button_previous.content.button_hotspot.disable_button = true
    end

    -- Next
    if page < pages then
        self.button_next.content.button_hotspot.disable_button = false
    else
        self.button_next.content.button_hotspot.disable_button = true
    end

end
--[[
    Get count of required salvage pages
--]]
mod.required_salvage_pages = function(self)
    local pages = math.ceil(#self.all_salvage_items / 9)
    return pages > 0 and pages or 1
end
--[[
    Get salvage items for specific page
--]]
mod.get_page_items = function(self, page)
    local start_index = ((page-1) * 9) + 1
    local entries = {}
    for e = start_index, start_index + 8 do
        if self.all_salvage_items[e] then
            entries[#entries+1] = self.all_salvage_items[e]
        end
    end
    return entries
end
--[[
    Remove salvage item by backend id
--]]
mod.remove_salvage_item = function(self, backend_id)
    local found_index = nil
    for index, entry in pairs(self.all_salvage_items) do
        if entry.backend_id == backend_id then
            found_index = index
            break
        end
    end
    if found_index then
        table.remove(self.all_salvage_items, found_index)
    end
end
--[[
    Change current salvage page
--]]
mod.change_salvage_page = function(self, craft_page_salvage, requested_page)
    if requested_page then
        if requested_page > 0 and requested_page <= mod.salvage_pages then
            -- Clear
            craft_page_salvage._item_grid:clear_item_grid()
            table.clear(craft_page_salvage._craft_items)

            -- Populate grid
            local page_entries = mod:get_page_items(requested_page)
            for index, entry in pairs(page_entries) do
                craft_page_salvage._craft_items[index] = entry.backend_id

                local item_interface = Managers.backend:get_interface("items")
                local item = entry.backend_id and item_interface:get_item_from_id(entry.backend_id)

                craft_page_salvage._item_grid:add_item_to_slot_index(index, item, entry.specific_amount)
            end
            
            mod.active_salvage_page = requested_page
            mod:update_salvage_elements()
        end
    end
end
--[[
    Activate / deactivate feature
--]]
mod.set_salvage_activated = function(self)
    if mod:get("salvage_pages") then
        mod:hook_enable(CraftPageSalvage, "create_ui_elements")
        mod:hook_enable(CraftPageSalvage, "draw")
        mod:hook_enable(CraftPageSalvage, "_add_craft_item")
        mod:hook_enable(CraftPageSalvage, "_remove_craft_item")
        mod:hook_enable(CraftPageSalvage, "on_exit")
        mod:hook_enable(CraftPageSalvage, "_handle_input")
    else
        mod:hook_disable(CraftPageSalvage, "create_ui_elements")
        mod:hook_disable(CraftPageSalvage, "draw")
        mod:hook_disable(CraftPageSalvage, "_add_craft_item")
        mod:hook_disable(CraftPageSalvage, "_remove_craft_item")
        mod:hook_disable(CraftPageSalvage, "on_exit")
        mod:hook_disable(CraftPageSalvage, "_handle_input")
    end
end

mod.reset_salvage_pages = function(self)
    mod.all_salvage_items = {}
    mod.salvage_pages = 1
    mod.active_salvage_page = 1
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Create controls
--]]
mod:hook_safe(CraftPageSalvage, "create_ui_elements", function(self, params, ...)

    local item_grid = self._widgets_by_name["item_grid"]
    item_grid.offset[2] = item_grid.offset[2] + 20
    local item_grid_bg = self._widgets_by_name["item_grid_bg"]
    item_grid_bg.offset[2] = item_grid_bg.offset[2] + 20

    mod.button_previous = mod:create_salvage_element("previous", {-75, -20, 30})
    mod.button_previous.content.button_hotspot.disable_button = true
    mod.salvage_controls[1] = mod.button_previous
    mod.text_area = mod:create_salvage_element("text", {90, -20, 30})
    mod.salvage_controls[2] = mod.text_area
    mod.button_next = mod:create_salvage_element("next", {265, -20, 30})
    mod.button_next.content.button_hotspot.disable_button = true
    mod.salvage_controls[3] = mod.button_next

    mod:update_salvage_elements()
end)
--[[
    Draw controls
--]]
mod:hook_safe(CraftPageSalvage, "draw", function(self, dt, ...)
    local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.super_parent:window_input_service()

    UIWidgetUtils.animate_default_button(mod.salvage_controls[1], dt)
    UIWidgetUtils.animate_default_button(mod.salvage_controls[3], dt)

	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

    for _, widget in pairs(mod.salvage_controls) do
        UIRenderer.draw_widget(ui_top_renderer, widget)
    end

	UIRenderer.end_pass(ui_top_renderer)
end)
--[[
    Add an item
--]]
mod:hook(CraftPageSalvage, "_add_craft_item", function(func, self, backend_id, slot_index, ignore_sound, specific_amount, ...)

    if backend_id then
        -- Add salvage item to collection
        mod.all_salvage_items[#mod.all_salvage_items+1] = {backend_id = backend_id, specific_amount = specific_amount}
    end

    -- Check if enough pages and switch to last one
    if mod.salvage_pages < mod:required_salvage_pages() then
        mod.salvage_pages = mod.salvage_pages + 1
        mod:change_salvage_page(self, mod.salvage_pages)
    else
        mod:change_salvage_page(self, mod.salvage_pages)
    end

    if backend_id then
        -- Lock item in item grid
        self.super_parent:set_disabled_backend_id(backend_id, true)

        -- Activate salvage button if items
        if #mod.all_salvage_items > 0 then
            self:_set_craft_button_disabled(false)
        end

        -- Sound
        if not ignore_sound then
            self:_play_sound("play_gui_craft_item_drop")
        end
    end

end)
--[[
    Remove an item
--]]
mod:hook(CraftPageSalvage, "_remove_craft_item", function(func, self, backend_id, slot_index, ...)

    if backend_id then
        -- Remove salvage item from collection
        mod:remove_salvage_item(backend_id)
    end

    -- Check if pages have to be removed
    if mod.salvage_pages > mod:required_salvage_pages() then
        mod.salvage_pages = mod:required_salvage_pages()
        if mod.active_salvage_page > mod.salvage_pages then
            mod:change_salvage_page(self, mod.salvage_pages)
        end
    else
        mod:change_salvage_page(self, mod.active_salvage_page)
    end

    if backend_id then
        -- Unlock item in item grid
        self.super_parent:set_disabled_backend_id(backend_id, false)

        -- Deactivate button if no salvage items
        if #mod.all_salvage_items == 0 then
            self:_set_craft_button_disabled(true)
        end

        -- Sound
        self:_play_sound("play_gui_craft_item_drag")
    end

end)
--[[
    Reset values on exit
--]]
mod:hook_safe(CraftPageSalvage, "on_exit", function(self, params, ...)
    mod.all_salvage_items = {}
    mod.salvage_pages = 1
    mod.active_salvage_page = 1
end)
--[[
    Handle input
--]]
mod:hook_safe(CraftPageSalvage, "_handle_input", function(self, dt, t, ...)
    -- Hover effect
    if self:_is_button_hovered(mod.button_previous) or self:_is_button_hovered(mod.button_next) then
        self:_play_sound("play_gui_equipment_button_hover")
    end
    -- Previous
    if self:_is_button_pressed(mod.button_previous) then
        self:_play_sound("play_gui_craft_recipe_next")
        mod:change_salvage_page(self, mod.active_salvage_page - 1)
    end
    -- Next
    if self:_is_button_pressed(mod.button_next) then
        self:_play_sound("play_gui_craft_recipe_next")
        mod:change_salvage_page(self, mod.active_salvage_page + 1)
    end
end)
--[[
    Set real list of salvage items before crafting on backend
--]]
mod:hook_safe(CraftPageSalvage, "_handle_craft_input_progress", function(self, progress, ...)
    if progress == 1 then
        table.clear(self._craft_items)
        for _, entry in pairs(mod.all_salvage_items) do
            self._craft_items[#self._craft_items+1] = entry.backend_id
        end
    end
end)

--HeroWindowCrafting.craft = function (self, items, recipe_override)
mod:hook(HeroWindowCrafting, "craft", function(func, self, items, recipe_override, ...)
    
    local result = func(self, items, recipe_override, ...)

    -- Disable switch controls
    mod:disable_controls(true)

    return result
end)

-- --CraftPageSalvage.on_craft_completed = function (self)
-- mod:hook_safe(CraftPageSalvage, "on_craft_completed", function(self, ...)
    
-- end)
