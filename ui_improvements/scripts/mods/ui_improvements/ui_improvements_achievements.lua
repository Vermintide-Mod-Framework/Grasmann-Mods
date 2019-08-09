local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Provides hotkey for okri's challenges
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.achievement_filter_buttons = {}
mod.achievement_filter = "all"

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Check if ingame ui is active
--]]
mod.is_ingame_ui_active = function(self)
    local ingame_ui = Managers.matchmaking and Managers.matchmaking._ingame_ui
	if ingame_ui and ingame_ui.current_view then
        return true
    end
    return false
end
--[[
    Reset close button pressed
--]]
-- mod.achievements_update = function(self)
--     -- Check if pressed and ingame ui not active
--     if close_pressed and not mod:is_ingame_ui_active() then

--         -- Check keybinding
--         local close_keybind = mod:get("open_achievements")
--         close_pressed = mod:is_keybinding_pressed(close_keybind)

--     end
-- end
--[[
    Set achievements filter
--]]
mod.change_achievements_filter = function(self, hero_view_state_achievements, filter)

    -- Set filter
    mod.achievement_filter = filter

    -- Update achievements menu
    local active_list_index = hero_view_state_achievements._active_list_index    
    if active_list_index then
        hero_view_state_achievements:_on_tab_list_pressed(active_list_index)
    else
        hero_view_state_achievements:_activate_tab(hero_view_state_achievements._active_tab, 
            hero_view_state_achievements._active_tab_index, hero_view_state_achievements._active_list_index)
    end

    -- Update selected state of buttons
    for _, widget in ipairs(mod.achievement_filter_buttons) do
        if widget.content.filter == filter then
            widget.content.button_hotspot.is_selected = true
        else
            widget.content.button_hotspot.is_selected = false
        end
    end

end
--[[
    Create achievements filter button
--]]
mod.create_achievements_filter_button = function(self, text, offset, filter)
    local size = {250, 42}
    local widget = UIWidgets.create_default_button("achievement_window_mask_top", size, nil, nil, text, 24, nil, "button_detail_04", 34)
    widget.content.visible = false
    widget.content.filter = filter
    widget.style.background.size = size
    widget.style.clicked_rect.size = size
    widget.style.disabled_rect.size = size
    widget.style.frame.size = size
    widget.offset = offset
    
    return UIWidget.init(widget)
end
--[[
    Update achievments filter buttons
--]]
mod.update_filter_buttons = function(self, hero_view_state_achievements)

    local num_entries = #hero_view_state_achievements._achievement_widgets

    -- Check if there are open and completed achievements
    local has_open_achievements = false
    local has_completed_achievements = false
    for i = num_entries, 1, -1 do
        local widget = hero_view_state_achievements._achievement_widgets[i]
        if not widget.content.completed then
            has_open_achievements = true
        end
        if widget.content.completed and not widget.content.claimed then
            has_completed_achievements = true
        end
    end

    -- Activate / deactivate buttons according to open and completed achievements
    if not has_open_achievements then
        mod.achievement_filter_buttons[2].content.visible = false
        if mod.achievement_filter == "open" then
            mod:change_achievements_filter(hero_view_state_achievements, "all")
        end
    else
        mod.achievement_filter_buttons[2].content.visible = true
    end
    if not has_completed_achievements then
        mod.achievement_filter_buttons[3].content.visible = false
        if mod.achievement_filter == "completed" then
            mod:change_achievements_filter(hero_view_state_achievements, "all")
        end
    else
        mod.achievement_filter_buttons[3].content.visible = true
    end

end
--[[
    Update achievments filter
--]]
mod.filter_achievements = function(self, hero_view_state_achievements)

    local num_entries = #hero_view_state_achievements._achievement_widgets

    -- Remove achievements entries based on set filter
    for i = num_entries, 1, -1 do
        local widget = hero_view_state_achievements._achievement_widgets[i]
        --mod:dump(widget.content, "content", 1)
        if mod.achievement_filter == "open" then
            if widget.content.completed or widget.content.claimed then
                table.remove(hero_view_state_achievements._achievement_widgets, i)
            end
        elseif mod.achievement_filter == "completed" then
            if not widget.content.completed or widget.content.claimed then
                table.remove(hero_view_state_achievements._achievement_widgets, i)
            end
        end
    end

    -- Update scroll bar and stuff
    hero_view_state_achievements.scroll_value = nil
    --hero_view_state_achievements:_update_scroll_height()
    hero_view_state_achievements:_update_achievements_scroll_height()
    hero_view_state_achievements:_setup_achievement_entries_animations()
	if num_entries > 0 then
		hero_view_state_achievements:_hide_empty_entries_warning()
	else
		hero_view_state_achievements:_show_empty_entries_warning()
    end

end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Close okri's challenges with open hotkey
--]]
mod:hook_safe(HeroViewStateAchievements, "_handle_input", function(self, ...)

    -- Handle achievements filter
    for _, widget in ipairs(mod.achievement_filter_buttons) do
        if self:_is_button_hover_enter(widget) then
            self:play_sound("play_gui_equipment_button_hover")
        end
        if self:_is_button_pressed(widget) then
            self:play_sound("Play_hud_hover")
            mod:change_achievements_filter(self, widget.content.filter)
        end
    end

end)
--[[
    List achievements entries
--]]
mod:hook_safe(HeroViewStateAchievements, "_on_tab_list_pressed", function(self, list_index, ignore_sound, ...)
    mod:update_filter_buttons(self)
    mod:filter_achievements(self)
end)
mod:hook_safe(HeroViewStateAchievements, "_activate_tab", function(self, widget, index, tab_list_index, ignore_sound, ...)
    mod:update_filter_buttons(self)
    mod:filter_achievements(self)
end)
--[[
    Create achievements filter buttons
--]]
mod:hook_safe(HeroViewStateAchievements, "create_ui_elements", function(self, params, ...)
    mod.achievement_filter = "all"
    mod.achievement_filter_buttons[1] = mod:create_achievements_filter_button(mod:localize("achievements_filter_all"), {110, 14, 20}, "all")
    mod.achievement_filter_buttons[1].content.button_hotspot.is_selected = true
    mod.achievement_filter_buttons[2] = mod:create_achievements_filter_button(mod:localize("achievements_filter_open"), {410, 14, 20}, "open")
    mod.achievement_filter_buttons[3] = mod:create_achievements_filter_button(mod:localize("achievements_filter_completed"), {710, 14, 20}, "completed")
end)
--[[
    Draw / animate achievements filter buttons
--]]
mod:hook_safe(HeroViewStateAchievements, "draw", function(self, input_service, dt, ...)
    local ui_renderer = self.ui_renderer
    local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
    local render_settings = self.render_settings
    
    for _, widget in ipairs(mod.achievement_filter_buttons) do
        UIWidgetUtils.animate_default_button(widget, dt)
    end

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)

    for _, widget in ipairs(mod.achievement_filter_buttons) do
        UIRenderer.draw_widget(ui_renderer, widget)
    end

    UIRenderer.end_pass(ui_renderer)
end)
--[[
    Hide buttons on summary screen
--]]
mod:hook_safe(HeroViewStateAchievements, "_on_layout_button_pressed", function(self, widget, window_widget, layout_type, ...)
    if layout_type == "summary" then
        for _, widget in ipairs(mod.achievement_filter_buttons) do
            widget.content.visible = false
        end
    else
        mod.achievement_filter_buttons[1].content.visible = true
    end
end)
