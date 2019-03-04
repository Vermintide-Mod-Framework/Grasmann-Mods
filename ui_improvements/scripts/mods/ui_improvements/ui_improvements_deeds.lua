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
mod.save_deed_difficulty = function(self, difficulty)
    mod.deeds.groups.difficulty.value = difficulty
    mod.deeds.groups.difficulty.saved = difficulty
end
mod.save_deed_rarity = function(self, rarity)
    mod.deeds.groups.rarity.value = rarity
    mod.deeds.groups.rarity.saved = rarity
end
mod.save_deed_mutator = function(self, mutator)
    mod.deeds.groups.mutator.value = mutator
    mod.deeds.groups.mutator.saved = mutator
end
mod.save_deed_mission = function(self, mission)
    mod.deeds.groups.mission.value = mission
    mod.deeds.groups.mission.saved = mission
end

mod.deeds = {
    widgets = {},
    groups = {
        difficulty = {
            value = "all",
            saved = "all",
            position = {0, 0},
            width = 0.5,
            height = 36,
            vertical_divider = true,
            horizontal_divider = true,
            get_list = function(self)
                local difficulties = {}
                for _, name in pairs(DefaultDifficulties) do
                    difficulties[#difficulties+1] = name
                end
                return difficulties
            end,
            get_size = function(self, size, element_height)
                local element_height = element_height or mod.deeds.element_height
                return {size - element_height*#self:get_list(), element_height}
            end,
            get_data = function(self, value)
                if value == "all" then
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                else
                    return Localize(DifficultySettings[value].display_name), DifficultySettings[value].display_image
                end
            end,
            create_button = function(self, scenegraph_id, difficulty, is_selected, root, size)
                local text, icon = self:get_data(difficulty)
                return mod:create_deed_button("window", text, icon, "difficulty", difficulty, is_selected, root, size, "save_deed_difficulty")
            end,
        },
        rarity = {
            value = "all",
            saved = "all",
            position = {0.5, 0},
            width = 0.5,
            height = 36,
            --horizontal_divider = true,
            icons = {
                common = "icon_deed_cataclysm_01",
                rare = "icon_deed_cataclysm_02",
                exotic = "icon_deed_cataclysm_03",
            },
            get_list = function(self)
                local rarities = {
                    "common",
                    "rare",
                    "exotic",
                }
                return rarities
            end,
            get_size = function(self, size, element_height)
                local element_height = element_height or mod.deeds.element_height
                return {size - element_height*#self:get_list(), element_height}
            end,
            get_data = function(self, value)
                if value == "all" then
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                else
                    return value, self.icons[value]
                end
            end,
            create_button = function(self, scenegraph_id, rarity, is_selected, root, size)
                local text, icon = self:get_data(rarity)
                return mod:create_deed_button("window", text, icon, "rarity", rarity, is_selected, root, size, "save_deed_rarity")
            end,
        },
        mutator = {
            value = "all",
            saved = "all",
            position = {0, 1},
            width = 1,
            height = 36,
            horizontal_divider = true,
            list = {
                "whiterun",
                "no_pickups",
                "specials_frequency",
                "player_dot",
                "powerful_elites",
                "instant_death",
                "no_respawn",
                "hordes_galore",
                "elite_run",
                "no_ammo",
            },
            get_list = function(self)
                local mutators = {}
                local mutator_settings = mod:dofile("scripts/settings/mutator_settings")
                for name, mut in pairs(mutator_settings) do
                    if table.contains(self.list, name) then
                        mutators[#mutators+1] = name
                    end
                end
                return mutators
            end,
            get_size = function(self, size, element_height)
                local element_height = element_height or mod.deeds.element_height
                return {size - element_height*#self:get_list(), element_height}
            end,
            get_data = function(self, value)
                if value == "all" then
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                else
                    local mutator_settings = mod:dofile("scripts/settings/mutator_settings")
                    for name, mut in pairs(mutator_settings) do
                        if name == value then
                            return Localize(mut.display_name), mut.icon
                        end
                    end
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                end
            end,
            create_button = function(self, scenegraph_id, mutator, is_selected, root, size)
                local text, icon = self:get_data(mutator)
                return mod:create_deed_button("window", text, icon, "mutator", mutator, is_selected, root, size, "save_deed_mutator")
            end,
        },
        mission = {
            value = "all",
            saved = "all",
            position = {0, 2},
            width = 1,
            height = 36,
            horizontal_divider = true,
            list = {
                "act_1",
                "act_2",
                "act_3",
                "act_4",
                "act_bogenhafen",
            },
            get_list = function(self)
                local acts = {}
                for name, level in pairs(LevelSettings) do
                    if level.act and level.game_mode == "adventure" then
                        if not acts[level.act] then acts[level.act] = {} end
                        acts[level.act][#acts[level.act]+1] = {name, level}
                    end
                end
                local missions = {}
                for _, name in pairs(self.list) do
                    local act = acts[name]
                    for i = 1, #act do
                        for _, m in pairs(act) do
                            if m[2].act_unlock_order == i-1 then
                                missions[#missions+1] = m[1]
                            end
                        end
                    end
                end
                return missions
            end,
            get_size = function(self, size, element_height)
                local element_height = element_height or mod.deeds.element_height
                return {size - element_height*#self:get_list(), element_height}
            end,
            get_data = function(self, value)
                if value == "all" then
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                else
                    for name, mission_data in pairs(LevelSettings) do
                        if value == name then
                            return Localize(mission_data.display_name), mission_data.level_image
                        end
                    end
                    return mod:localize("deed_filter_all"), "loot_chest_icon"
                end
            end,
            create_button = function(self, scenegraph_id, mission, is_selected, root, size)
                local text, icon = self:get_data(mission)
                return mod:create_deed_button("window", text, icon, "mission", mission, is_selected, root, size, "save_deed_mission")
            end,
        },
    },
    element_height = 36,
    label_width = 160,
    create_ui_widgets = function(self, group, index, label_width)
        local window_width = 1060
        local list = group:get_list()
        group.height = mod.deeds.element_height
        local size = group:get_size((window_width*group.width) - label_width, group.height)
        group.short = size[2]
        group.long = size[1]
        group.start = index
        return list, size
    end,
    finish_ui_widgets = function(self, group, index)
        group.length = index - group.start
    end
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Create horizontal divider widget
--]]
mod.create_horizontal_window_divider = function(self, scenegraph_id, size, root)
    local widget = {
		element = {
			passes = {
				{
					texture_id = "edge",
					style_id = "edge",
					pass_type = "tiled_texture"
				},
				{
					texture_id = "edge_holder_left",
					style_id = "edge_holder_left",
					pass_type = "texture"
				},
				{
					texture_id = "edge_holder_right",
					style_id = "edge_holder_right",
					pass_type = "texture"
				}
			}
		},
		content = {
			edge = "menu_frame_09_divider",
			edge_holder_left = "menu_frame_09_divider_left",
			edge_holder_right = "menu_frame_09_divider_right"
		},
		style = {
			edge = {
				color = {255, 255, 255, 255},
				offset = {6, 6, 6},
				size = {size[1] - 9, 5},
				texture_tiling_size = {size[1] - 9, 5}
			},
			edge_holder_right = {
				color = {255, 255, 255, 255},
				offset = {size[1] - 7, 0, 10},
				size = {9, 17}
			},
			edge_holder_left = {
				color = {255, 255, 255, 255},
				offset = {3, 0, 10},
				size = {9, 17}
			}
		},
		scenegraph_id = scenegraph_id,
		offset = root,
	}

	return UIWidget.init(widget)
end
--[[
    Create vertical divider widget
--]]
mod.create_vertical_window_divider = function(self, scenegraph_id, size, root)
	local widget = {
		element = {
			passes = {
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
			},
		},
		content = {
			edge = "menu_frame_09_divider_vertical",
			edge_holder_top = "menu_frame_09_divider_top",
			edge_holder_bottom = "menu_frame_09_divider_bottom",
		},
		style = {
			edge = {
				color = {255, 255, 255, 255},
				offset = {0, 6, 6},
				size = {5, size[2] - 9},
				texture_tiling_size = {5, size[2] - 9},
			},
			edge_holder_top = {
				color = {255, 255, 255, 255},
				offset = {-6, size[2] - 7, 10},
				size = {17, 9},
			},
			edge_holder_bottom = {
				color = {255, 255, 255, 255},
				offset = {-6, 3, 10},
				size = {17, 9},
			},
		},
		scenegraph_id = scenegraph_id,
		offset = root,
	}

	return UIWidget.init(widget)
end
--[[
    Create a label
--]]
mod.create_label = function(self, scenegraph_id, text, root, size)

    local size = size or {mod.deeds.label_width, mod.deeds.element_height}

    local widget = {
        element = {
			passes = {
                -- Background
                {
                    style_id = "background_solid",
                    pass_type = "rect",
                },
                -- Text
                {
					style_id = "text",
					pass_type = "text",
                    text_id = "text",
                },
                {
					style_id = "text_shadow",
					pass_type = "text",
					text_id = "text",
				},
            },
        },
        content = {
            text = text or "n/a",
        },
        style = {
            -- Background
            background_solid = {
                color = {255, 0, 0, 0},
                offset = {0, 0, 1},
                size = size,
            },
            -- Text
            text = {
				upper_case = true,
				font_type = "hell_shark",
				font_size = font_size or 18,
				text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				default_text_color = Colors.get_color_table_with_alpha("font_button_normal", 255),
				select_text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {10, 10, 2},
            },
			text_shadow = {
				upper_case = true,
				word_wrap = true,
				font_type = "hell_shark",
				font_size = font_size or 18,
				text_color = Colors.get_color_table_with_alpha("black", 255),
				default_text_color = Colors.get_color_table_with_alpha("black", 255),
				offset = {10, 10, 1},
			},
        },
        scenegraph_id = scenegraph_id,
		offset = {root[1], root[2], root[3]},
    }

    return UIWidget.init(widget)
end
--[[
    Create filter widget
--]]
mod.create_deed_button = function(self, scenegraph_id, text, icon, tag, value, is_selected, root, size, callback, height)

    root = root or {0, 0, 0}
    local start_pos = root --{5, 6, 2}
    icon = icon or "loot_chest_icon"
    text = text or "nope"
    height = height or mod.deeds.element_height
    -- if difficulty == "easy" then
    --     icon = "loot_chest_icon"
    --     text = mod:localize("deed_filter_all")
    -- else
    --     icon = DifficultySettings[difficulty].display_image
    --     text = Localize(DifficultySettings[difficulty].display_name)
    -- end
    local font_size = 16
    local icon_size = {height-10, height-10}
    local long = size[1]
    local short = size[2]

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
                    content_check_function = function(content)
						return content.is_selected
					end,
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
            tag = tag or "",
            value = value or nil,
            background_fade = "button_bg_fade",
            edge = "menu_frame_09_divider_vertical",
			edge_holder_top = "menu_frame_09_divider_top",
            edge_holder_bottom = "menu_frame_09_divider_bottom",
            hover_glow = "button_state_default",
            glass = "button_glass_02",
            origin = root,
            callback = callback,
		},
		style = {
            -- Background
            background_solid = {
				color = {255, 0, 0, 0},
				offset = {0, 0, 1},
				size = {short, height},
            },
            background_solid_selected = {
				color = {255, 0, 0, 0},
				offset = {0, 0, 1},
				size = {long, height},
			},
            -- Icon
			icon = {
				color = {200, 127, 127, 127},
				offset = {8, 8, 6},
				size = icon_size,
            },
            icon_hovered = {
				color = {255, 200, 200, 200},
				offset = {8, 8, 6},
				size = icon_size,
            },
            icon_selected = {
				color = {255, 255, 255, 255},
				offset = {8, 8, 6},
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
				offset = {icon_size[1] + font_size, icon_size[2]/2 - font_size/2 + 5, 2},
            },
			text_shadow = {
				upper_case = true,
				word_wrap = true,
				font_type = "hell_shark",
				font_size = font_size or 24,
				text_color = Colors.get_color_table_with_alpha("black", 255),
				default_text_color = Colors.get_color_table_with_alpha("black", 255),
				offset = {icon_size[1] + font_size, icon_size[2]/2 - font_size/2 + 5, 1},
			},
            -- Hotspot
            hotspot = {
                offset = {0, 0, 0},
                size = {short, height},
            },
            -- Button
            background_fade = {
				color = {255, 255, 255, 255},
				offset = {0, 0, 0},
				size = {short, height},
            },
            background_fade_selected = {
				color = {255, 255, 255, 255},
				offset = {0, 0, 0},
				size = {long, height},
            },
            hover_glow = {
				color = {200, 255, 255, 255},
				offset = {0, 5, 8},
				size = {short, math.min(38 - 5, 80)},
            },
            hover_glow_selected = {
				color = {200, 255, 255, 255},
				offset = {0, 5, 8},
				size = {long, math.min(38 - 5, 80)},
            },
            glass_top = {
				color = {255, 255, 255, 255},
				offset = {0, height-9, 8},
				size = {short, 11},
            },
            glass_top_selected = {
				color = {255, 255, 255, 255},
				offset = {0, height-9, 8},
				size = {long, 11},
			},
			glass_bottom = {
				color = {100, 255, 255, 255},
				offset = {0, -1, 8},
				size = {short, 11},
            },
            glass_bottom_selected = {
				color = {100, 255, 255, 255},
				offset = {0, -1, 8},
				size = {long, 11},
			},
            -- Edge
            edge = {
				color = {255, 255, 255, 255},
				offset = {0, 5, 20},
				size = {5, height-5},
				texture_tiling_size = {5, height-5},
			},
			edge_holder_top = {
				color = {255, 255, 255, 255},
				offset = {-6, height - 5, 20},
				size = {17, 9},
			},
			edge_holder_bottom = {
				color = {255, 255, 255, 255},
				offset = {-6, 5, 20},
				size = {17, 9},
			},
		},
		scenegraph_id = scenegraph_id,
		offset = {root[1], root[2], root[3]},
    }
    
    return UIWidget.init(widget)
end
--[[
    Create difficulty button
--]]
-- mod.create_difficulty_button = function(self, scenegraph_id, difficulty, is_selected, root, size)
--     local text, icon = self.deeds.groups.difficulty:get_data(difficulty)
--     return mod:create_deed_button("window", text, icon, "difficulty", difficulty, is_selected, root, size, "save_deed_difficulty")
-- end
--[[
    Create rarity button
--]]
-- mod.create_rarity_button = function(self, scenegraph_id, rarity, is_selected, root, size)
--     local text, icon = self.deeds.groups.rarity:get_data(rarity)
--     return mod:create_deed_button("window", text, icon, "rarity", rarity, is_selected, root, size, "save_deed_rarity")
-- end
--[[
    Create mutator button
--]]
-- mod.create_mutator_button = function(self, scenegraph_id, mutator, is_selected, root, size)
--     local text, icon = self.deeds.groups.mutator:get_data(mutator)
--     return mod:create_deed_button("window", text, icon, "mutator", mutator, is_selected, root, size, "save_deed_mutator")
-- end
--[[
    Create mission button
--]]
-- mod.create_mission_button = function(self, scenegraph_id, mission, is_selected, root, size)
--     local text, icon = self.deeds.groups.mission:get_data(mission)
--     return mod:create_deed_button("window", text, icon, "mission", mission, is_selected, root, size, "save_deed_mission")
-- end
--[[
    Update difficulty widgets
--]]
mod.update_widget_group = function(self, group, value)
    local offset = 0

    if value then
        for i = group.start, group.start + group.length do
            local widget = self.deeds.widgets[i]
            if widget.content.value == value then
                widget.content.is_selected = true
            else
                widget.content.is_selected = false
            end
        end
    end

    for i = group.start, group.start + group.length do
        local widget = self.deeds.widgets[i]
        if widget then
            widget.offset[1] = widget.content.origin[1] + offset
            if widget.content.is_selected then
                widget.style.hotspot.size = {group.long, group.height}
                offset = offset + group.long
            else
                widget.style.hotspot.size = {group.short, group.height}
                offset = offset + group.short
            end
        end
    end
end
--[[
    Filter item grid
--]]
mod.filter_item_grid = function(self, mutator_grid)

    -- Filter items
    local item_filter = "slot_type == deed"
    local item_grid = mutator_grid._item_grid
    item_grid:change_item_filter(item_filter, true)

    local difficulty = mod.deeds.groups.difficulty.value
    local rarity = mod.deeds.groups.rarity.value
    local mutator = mod.deeds.groups.mutator.value
    local mission = mod.deeds.groups.mission.value

    local items = {}

    for _, item in pairs(item_grid._items) do
        local diff = (difficulty == "all" or item.data.difficulties[1] == difficulty)
        local rare = (rarity == "all" or item.rarity == rarity)
        local mut = (mutator == "all")
        local mission = (mission == "all" or item.level_key == mission)
        for _, name in pairs(item.data.mutators) do
            if name == mutator then
                mut = true
                break
            end
        end
        if diff and rare and mut and mission then
            items[#items+1] = item
        end
    end

    item_grid._items = items

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
    Create a deed filter group
--]]

mod.create_deed_group = function(self, name, start, length, size, height)
    for grp_name, group in pairs(mod.deeds.groups) do
        if grp_name == name then
            group.start = start
            group.length = length
            group.short = size[2]
            group.long = size[1]
            group.height = height or mod.deeds.element_height
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
    Load saved difficulty on enter
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "on_enter", function(self, ...)

    -- mod.deeds.groups.difficulty.value = "all"
    -- if mod.deeds.groups.difficulty.saved and mod:get("remember_categories") then
    --     mod.deeds.groups.difficulty.value = mod.deeds.groups.difficulty.saved
    --     mod:update_widget_group(mod.deeds.groups.difficulty, mod.deeds.groups.difficulty.value)
    -- end
    -- mod.deeds.groups.rarity.value = "all"
    -- if mod.deeds.groups.rarity.saved and mod:get("remember_categories") then
    --     mod.deeds.groups.rarity.value = mod.deeds.groups.rarity.saved
    --     mod:update_widget_group(mod.deeds.groups.rarity, mod.deeds.groups.rarity.value)
    -- end
    -- mod.deeds.groups.mutator.value = "all"
    -- if mod.deeds.groups.mutator.saved and mod:get("remember_categories") then
    --     mod.deeds.groups.mutator.value = mod.deeds.groups.mutator.saved
    --     mod:update_widget_group(mod.deeds.groups.mutator, mod.deeds.groups.mutator.value)
    -- end

    --mod:filter_item_grid(self)

    -- Lower row count from 8 to 7
    local rows = 7
    local item_grid = self._item_grid._widget.content
    if item_grid then
        item_grid.rows = rows
        item_grid.slots = rows * item_grid.columns
    end

    -- Hide additional page arrow buttons and text
    local styles = self._item_grid._widget.style
    if styles then
        styles.page_arrow_left.offset[3] = -10
        styles.page_arrow_right.offset[3] = -10
        styles.page_text.offset[3] = -10
    end

    --mod:dump(, "_item_grid", 1)
end)
--[[
    Manipulate default widgets and create mod widgets
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "create_ui_elements", function(self, ...)
    local window_width = 1059
    local label_width = mod.deeds.label_width
    local element_height = mod.deeds.element_height
    local pos_y = mod.deeds.element_height+4
    local index = 1
    --local group_index = 1

    local rofl = true
    if rofl then
    local base_y = mod.deeds.element_height+4
    for name, group in pairs(mod.deeds.groups) do
        local pos_x = window_width*group.position[1]
        local pos_y = base_y + element_height*group.position[2]

        -- Label
        mod.deeds.widgets[index] = mod:create_label("window", name, {pos_x, pos_y, 2})
        index = index + 1
        pos_x = pos_x + label_width

        -- Start creating widgets
        local list, size = mod.deeds:create_ui_widgets(group, index, label_width)

        -- All
        mod.deeds.widgets[index] = group:create_button("window", "all", true, {pos_x, pos_y, 2}, size)
        index = index + 1

        -- Options
        for _, name in pairs(list) do
            mod.deeds.widgets[index] = group:create_button("window", name, false, {pos_x, pos_y, 2}, size)
            index = index + 1
        end

        mod.deeds:finish_ui_widgets(group, index-1)

        mod:update_widget_group(group)

        if group.vertical_divider then
            mod.deeds.widgets[index] = mod:create_vertical_window_divider("window", {0, element_height}, {window_width*group.width, pos_y+2, 12})
            index = index + 1
        end
        if group.horizontal_divider then
            pos_y = pos_y + element_height
            mod.deeds.widgets[index] = mod:create_horizontal_window_divider("window", {window_width, 0}, {0, pos_y-4, 12})
            index = index + 1
        end
    end
    end

    -- --local lol = true
    -- if lol then
    -- -- ##### Difficulty ###############################################################################################
    -- -- Label
    -- mod.deeds.widgets[index] = mod:create_label("window", "Difficulty", {0, pos_y, 2})
    -- index = index + 1
    -- -- List
    -- local difficulties = mod.deeds.groups.difficulty:get_list()
    -- local size = mod.deeds.groups.difficulty:get_size(window_width/2 - label_width, element_height)
    -- local start = index
    -- local pos_x = label_width
    -- -- All
    -- mod.deeds.widgets[index] = mod.deeds.groups.difficulty:create_button("window", "all", true, {pos_x, pos_y, 2}, size)
    -- index = index + 1
    -- -- Generated
    -- for _, name in pairs(DefaultDifficulties) do
    --     mod.deeds.widgets[index] = mod.deeds.groups.difficulty:create_button("window", name, false, {pos_x, pos_y, 2}, size)
    --     index = index + 1
    -- end
    -- -- Group
    -- mod:create_deed_group("difficulty", start, index-start-1, size)
    -- --mod.deeds.groups[group_index] = mod:create_deed_group("difficulty", start, index-start-1, size)
    -- --group_index = group_index + 1

    -- -- Vertical Divider
    -- mod.deeds.widgets[index] = mod:create_vertical_window_divider("window", {0, element_height}, {window_width/2, pos_y+2, 12})
    -- index = index + 1

    -- -- ##### Rarity ###################################################################################################
    -- -- Label
    -- mod.deeds.widgets[index] = mod:create_label("window", "Rarity", {window_width/2, pos_y, 2})
    -- index = index + 1
    -- -- List
    -- local rarities = mod.deeds.groups.rarity:get_list()
    -- local size = mod.deeds.groups.rarity:get_size(window_width/2 - label_width, element_height)
    -- local start = index
    -- local pos_x = window_width/2 + label_width
    -- -- All
    -- mod.deeds.widgets[index] = mod.deeds.groups.rarity:create_button("window", "all", true, {pos_x, pos_y, 2}, size)
    -- index = index + 1
    -- -- Generated
    -- for _, name in pairs(rarities) do
    --     mod.deeds.widgets[index] = mod.deeds.groups.rarity:create_button("window", name, nil, {pos_x, pos_y, 2}, size)
    --     index = index + 1
    -- end
    -- -- Group
    -- mod:create_deed_group("rarity", start, index-start-1, size)
    -- -- mod.deeds.groups[group_index] = mod:create_deed_group("rarity", start, index-start-1, size)
    -- -- group_index = group_index + 1
    
    -- -- Line up and divider
    -- pos_y = pos_y + element_height
    -- mod.deeds.widgets[index] = mod:create_horizontal_window_divider("window", {window_width, 0}, {0, pos_y-4, 12})
    -- index = index + 1

    -- -- ##### Mutator ##################################################################################################
    -- -- Label
    -- mod.deeds.widgets[index] = mod:create_label("window", "Mutator", {0, pos_y, 2})
    -- index = index + 1
    -- -- List
    -- local mutators = mod.deeds.groups.mutator:get_list()
    -- local size = mod.deeds.groups.mutator:get_size(window_width - label_width, element_height)
    -- local start = index
    -- local pos_x = label_width
    -- -- All
    -- mod.deeds.widgets[index] = mod.deeds.groups.mutator:create_button("window", "all", true, {pos_x, pos_y, 2}, size)
    -- index = index + 1
    -- -- Generated
    -- for _, name in pairs(mutators) do
    --     mod.deeds.widgets[index] = mod.deeds.groups.mutator:create_button("window", name, nil, {pos_x, pos_y, 2}, size)
    --     index = index + 1
    -- end
    -- -- Group
    -- mod:create_deed_group("mutator", start, index-start-1, size)
    -- -- mod.deeds.groups[group_index] = mod:create_deed_group("mutator", start, index-start-1, size)
    -- -- group_index = group_index + 1

    -- -- Line up and divider-
    -- pos_y = pos_y + element_height
    -- mod.deeds.widgets[index] = mod:create_horizontal_window_divider("window", {window_width, 0}, {0, pos_y-4, 12})
    -- index = index + 1
    
    -- -- ##### Map ######################################################################################################
    -- -- Label
    -- mod.deeds.widgets[index] = mod:create_label("window", "Mission", {0, pos_y, 2})
    -- index = index + 1
    -- -- List
    -- local missions = mod.deeds.groups.mission:get_list()
    -- local size = mod.deeds.groups.mission:get_size(window_width - label_width, element_height)
    -- local start = index
    -- local pos_x = label_width
    -- -- All
    -- mod.deeds.widgets[index] = mod.deeds.groups.mission:create_button("window", "all", true, {pos_x, pos_y, 2}, size)
    -- index = index + 1
    -- -- Generated
    -- for _, name in pairs(missions) do
    --     mod.deeds.widgets[index] = mod.deeds.groups.mission:create_button("window", name, nil, {pos_x, pos_y, 2}, size)
    --     index = index + 1
    -- end
    -- -- Group
    -- mod:create_deed_group("mission", start, index-start-1, size)
    -- -- mod.deeds.groups[group_index] = mod:create_deed_group("mission", start, index-start-1, size)
    -- -- group_index = group_index + 1

    -- -- Line up and divider-
    -- pos_y = pos_y + element_height
    -- mod.deeds.widgets[index] = mod:create_horizontal_window_divider("window", {window_width, 0}, {0, pos_y-4, 12})
    -- index = index + 1

    -- -- Update groups
    -- for _, group in pairs(mod.deeds.groups) do
    --     mod:update_widget_group(group)
    -- end
    -- end

end)
--[[
    Handle draw widgets
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "draw", function(self, dt, ...)
    local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
    local input_service = self.parent:window_input_service()

    -- Draw widgets
    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
    for _, widget in pairs(mod.deeds.widgets) do
        UIRenderer.draw_widget(ui_renderer, widget)
    end
    UIRenderer.end_pass(ui_renderer)

end)
--[[
    Handle input
--]]
mod:hook_safe(StartGameWindowMutatorGrid, "update", function(self, ...)
    for _, widget in pairs(mod.deeds.widgets) do

        if widget.content.button_hotspot then

            -- Handle hover effect
            if not widget.content.is_selected and self:_is_button_hovered(widget) then
                self:_play_sound("play_gui_equipment_button_hover")
            end

            -- Handle button press
            if not widget.content.is_selected and self:_is_button_pressed(widget) then

                for name, group in pairs(mod.deeds.groups) do
                    if name == widget.content.tag then

                        -- Deactivate widgets
                        for w = group.start, group.start + group.length do
                            mod.deeds.widgets[w].content.is_selected = false
                        end

                        -- Activate pressed widget
                        widget.content.is_selected = true
                        self:_play_sound("play_gui_craft_recipe_next")
                        
                        -- Update appearance
                        mod:update_widget_group(group)

                        -- -- Save difficulty
                        -- saved_difficulty = widget.content.difficulty
                        if widget.content.callback then
                            mod[widget.content.callback](mod, widget.content.value)
                        end

                        -- Filter item grid
                        mod:filter_item_grid(self)

                    end
                end
            end          
        end
    end
end)


