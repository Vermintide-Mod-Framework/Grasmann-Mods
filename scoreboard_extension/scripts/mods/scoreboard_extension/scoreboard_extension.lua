local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension

	Extends number of rows in the scoreboard
	Adds support for a scrollbar in the scoreboard with autoscroll

	author: grasmann
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.scores = {}
--[[
	Scoreboard row extension
--]]
mod.scoreboard = {
	rows_default = 11,
	row_height = 40,
	rows = mod:get("extend"),
	extension = function(self)
		return (self.rows - self.rows_default) * self.row_height
	end,
	player_score_size_default = {250, 580},
	player_score_size = function(self)
		local extension = self:extension()
		return {self.player_score_size_default[1], self.player_score_size_default[2] + extension}
	end,
}
--[[
	Custom entry structure
--]]
mod.custom_entries = {
	list = {},
	register = function(self, id, text, type, callback)
		local entry = self:get(id)
		if not entry then
			self:add(id, text, type, callback)
			return true
		else
			mod:echo("Entry '"..id.."' has already been registered!")
		end
		return false
	end,
	add = function(self, id, text, type, callback)
		local entry = {
			id = id,
			text = text,
			type = type,
			callback = callback,
		}
		self.list[#self.list+1] = entry
	end,
	get = function(self, id)
		for _, entry in pairs(self.list) do
			if entry.id == id then
				return entry
			end
		end
		return nil
	end,
}
--[[
	Scrollbar mechanics
--]]
mod.scrollbar = {
	automatic = false,
	timer = 0,
	start_over_time = 2,
	initial_timer = 0,
	size = {},
	scenegraph_id = "scrollbar",
	widget = nil,
	start_index = 1,
	--end_index = mod.score_rows, --mod.scoreboard.rows
	end_index = mod.scoreboard.rows,
	is_hovered = function(self)
		return self.widget.content.scroll_bar_info.is_hover
	end,
	is_held = function(self)
		return self.widget.content.scroll_bar_info.is_held
	end,
	create = function(self)
		local definition = UIWidgets.create_scrollbar(self.scenegraph_id, self.size)
		self.widget = UIWidget.init(definition)
	end,
	set = function(self)
		local rows = #mod.scores
		if rows < 1 then rows = 1 end
		--local percentage = mod.score_rows / rows --mod.scoreboard.rows
		local percentage = mod.scoreboard.rows / rows
		if percentage >= 1 then
			self.widget.content.visible = false
		end
		self.widget.content.scroll_bar_info.bar_height_percentage = percentage
		self.automatic = mod:get("autoscroll")
		if self.automatic and mod:get("direction") == "bottom_to_top" then
			self.widget.content.scroll_bar_info.value = 1
		end
		self.timer = 0
		self.initial_timer = 0
	end,
	update = function(self, dt)
		--local heighest_start_index = #mod.scores - (mod.score_rows - 1) --mod.scoreboard.rows
		local heighest_start_index = #mod.scores - (mod.scoreboard.rows - 1)
		local step = 1 / (heighest_start_index)
		local value = self.widget.content.scroll_bar_info.value
		local start_index = math.ceil(value / step)
		if start_index < 1 then start_index = 1 end
		if start_index > heighest_start_index then start_index = heighest_start_index end
		--local end_index = start_index + (mod.score_rows - 1) --mod.scoreboard.rows
		local end_index = start_index + (mod.scoreboard.rows - 1)
		local change = false
		if self.start_index ~= start_index then
			change = true
			self.start_index = start_index
			self.end_index = end_index
		end
		return change, start_index, end_index
	end,
	scroll = function(self, dt, input_service)
		local scroll_axis = input_service:get("scroll_axis")
		if scroll_axis[2] == 0 and self.automatic and not self:is_held() then
			local value = self.widget.content.scroll_bar_info.value
			if (mod:get("direction") == "bottom_to_top" and value > 0) or (mod:get("direction") == "top_to_bottom" and value < 1) then
				if self.initial_timer >= mod:get("initial_time") then
					if mod:get("direction") == "bottom_to_top" then
						scroll_axis = Vector3(0, 0.05, 0)
					else
						scroll_axis = Vector3(0, -0.05, 0)
					end
				else
					self.initial_timer = self.initial_timer + dt
				end
			elseif mod:get("loop") then
				self.timer = self.timer + dt
				if self.timer >= mod:get("loop_time") then
					if mod:get("direction") == "bottom_to_top" then
						self.widget.content.scroll_bar_info.value = 1
					else
						self.widget.content.scroll_bar_info.value = 0
					end
					self.timer = 0
				end
			end
		elseif scroll_axis[2] ~= 0 or self:is_held() then
			self.automatic = false
		end
		if scroll_axis then
			local sensitivity = 3
			local scroll_value = (scroll_axis[2] * dt) * sensitivity
			if scroll_value ~= 0 then
				--mod:echo("Scroll value '"..tostring(scroll_value).."'")
				local value = self.widget.content.scroll_bar_info.value
				if scroll_value > 0 then
					value = value - scroll_value
					if value < 0 then value = 0 end
				elseif scroll_value < 0 then
					value = value + scroll_value*-1
					if value > 1 then value = 1 end
				end
				self.widget.content.scroll_bar_info.value = value
			end
		end
	end,
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Register a score entry

	id			: Identifier for the row 				- must be unique
	text		: Display text in the middle 			- readable text
	type		: Highscore type 'highest'/'lowest'/nil	- Decides where to put the circle
	callback	: Function to receive values from 		- function(player_index)
--]]
mod.register_entry = function(self, id, text, type, callback)
	return self.custom_entries:register(id, text, type, callback)
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Inject scenegraph element for scrollbar
--]]
mod:hook(UISceneGraph, "init_scenegraph", function(func, scenegraph, ...)
	-- Size and position
	local start = 80
	--local player_score_size = {250, 580}
	local extension = mod.scoreboard:extension()
	local player_score_size = mod.scoreboard:player_score_size()
	local size = {8, player_score_size[2] - start}
	local position = {-4, 0, 5}
	-- Change scenegraph
	scenegraph.scrollbar = {
		vertical_alignment = "bottom",
		parent = "scores_topics",
		horizontal_alignment = "right",
		size = size,
		position = position,
	}
	-- Add rows
	scenegraph.scores_topics.size[2] = player_score_size[2]
	scenegraph.scores_topics.position[2] = -50 + extension / 2
	for player_index = 1, 4 do
		scenegraph["player_panel_"..player_index].size = player_score_size
		scenegraph["player_panel_"..player_index].position[2] = -50 + extension / 2
	end
	-- Scrollbar size
	mod.scrollbar.size = size
	-- Return
	return func(scenegraph, ...)
end)
mod:hook_disable(UISceneGraph, "init_scenegraph")
--[[
	Create scrollbar and modify scenegraph
--]]
mod:hook(EndViewStateScore, "create_ui_elements", function(func, self, params, ...)
	mod:hook_enable(UISceneGraph, "init_scenegraph")

	local result = func(self, params, ...)

	-- Change widgets
	local MAX_SCORE_PANEL_ROWS = 20
	local player_score_size = mod.scoreboard:player_score_size()
	local topics_hover_length = 1400 + player_score_size[1]
	-- Score topics
	local scores_topics = UIWidgets.create_score_topics("scores_topics", {350, player_score_size[2]}, topics_hover_length, MAX_SCORE_PANEL_ROWS)
	local new_widget = UIWidget.init(scores_topics)
	self._widgets_by_name.scores_topics = new_widget
	for i, widget in pairs(self._widgets) do
		if widget.content.num_rows then
			self._widgets[i] = new_widget
			break
		end
	end
	-- Panels
	local score_widget_definitions = {
		player_score_1 = UIWidgets.create_score_entry("player_panel_1", player_score_size, MAX_SCORE_PANEL_ROWS, "left"),
		player_score_2 = UIWidgets.create_score_entry("player_panel_2", player_score_size, MAX_SCORE_PANEL_ROWS),
		player_score_3 = UIWidgets.create_score_entry("player_panel_3", player_score_size, MAX_SCORE_PANEL_ROWS, "left"),
		player_score_4 = UIWidgets.create_score_entry("player_panel_4", player_score_size, MAX_SCORE_PANEL_ROWS)
	}
	self._score_widgets = {
		UIWidget.init(score_widget_definitions.player_score_1),
		UIWidget.init(score_widget_definitions.player_score_2),
		UIWidget.init(score_widget_definitions.player_score_3),
		UIWidget.init(score_widget_definitions.player_score_4)
	}
	-- Create Scrollbar
	mod.scrollbar:create()

	mod:hook_disable(UISceneGraph, "init_scenegraph")
	return result
end)
--[[
	Update scrolling
--]]
mod:hook_safe(EndViewStateScore, "update", function(self, dt, t)
	-- Scrollwheel
	local input_service = self.input_manager:get_service("end_of_level")
	mod.scrollbar:scroll(dt, input_service)
	-- Update scoreboard
	local change, start_index, end_index = mod.scrollbar:update(dt)
	if change then
		--mod:echo("Scroll change! Start: '"..tostring(start_index).."' End: '"..tostring(end_index).."'")
		local total_row_index = 2
		for group_row_index = start_index, end_index do
			if mod.scores[group_row_index] then
				local line_suffix = "_"..total_row_index
				local score_text_name = "score_text"..line_suffix
				local row_name = "row_bg"..line_suffix
				local row_content = self._widgets_by_name.scores_topics.content[row_name]
				row_content[score_text_name] = mod.scores[group_row_index].text
				row_content.has_score = true
				for player_index = 1, 4 do
					local line_suffix = "_"..total_row_index
					local score_text_name = "score_text"..line_suffix
					local row_name = "row_bg"..line_suffix
					local row_content = self._score_widgets[player_index].content[row_name]
					row_content[score_text_name] = mod.scores[group_row_index][player_index].score
					row_content.has_highscore = mod.scores[group_row_index][player_index].has_highscore
					row_content.has_background = total_row_index % 2 == 0
					row_content.has_score = true
				end
				total_row_index = total_row_index + 1
			end
		end
	end
end)
--[[
	Draw scrollbar
--]]
mod:hook_safe(EndViewStateScore, "draw", function(self, input_service, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local render_settings = self.render_settings
	local input_service = self.input_manager:get_service("end_of_level")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)
	-- Render scrollbar
	UIRenderer.draw_widget(ui_renderer, mod.scrollbar.widget)
	-- Render scrollbar
	UIRenderer.end_pass(ui_renderer)
end)
--[[
	Catch score setup and fill score list
--]]
mod:hook_safe(EndViewStateScore, "_setup_score_panel", function(self, score_panel_scores, player_names)
	local total_row_index = 2
	mod.scores = {}
	-- Grab default rows
	for group_name, group_data in pairs(score_panel_scores) do
		for group_row_index, score_data in ipairs(group_data) do
			-- Create list entry for row
			mod.scores[group_row_index] = {
				text = Localize(score_data.display_text),
			}
			for player_index, player_score in ipairs(score_data.player_scores) do
				local line_suffix = "_"..total_row_index
				local row_name = "row_bg"..line_suffix
				local row_content = self._score_widgets[player_index].content[row_name]
				-- Save player score to list
				mod.scores[group_row_index][player_index] = {
					score = player_score,
					has_highscore = row_content.has_highscore,
				}
			end
			total_row_index = total_row_index + 1
		end
	end
	-- Handle custom entries
	for _, entry in pairs(mod.custom_entries.list) do
		local index = #mod.scores + 1
		mod.scores[index] = {
			text = entry.text,
		}
		-- Get scores
		local scores = {}
		local highest = -math.huge
		local lowest = math.huge
		for player_index = 1, 4 do
			scores[player_index] = entry.callback(player_index)
			if scores[player_index] < lowest then
				lowest = scores[player_index]
			end
			if scores[player_index] > highest then
				highest = scores[player_index]
			end
		end
		-- Add to list
		for player_index = 1, 4 do
			local has_highscore = false
			if entry.type == "lowest" and scores[player_index] == lowest then
				has_highscore = true
			elseif entry.type == "highest" and scores[player_index] == highest then
				has_highscore = true
			end
			mod.scores[index][player_index] = {
				score = scores[player_index],
				has_highscore = has_highscore,
			}
		end
	end
	-- Fill additional rows
	--for row = total_row_index, mod.score_rows+1 do --mod.scoreboard.rows
	for row = total_row_index, mod.scoreboard.rows+1 do
		if mod.scores[row-1] then
			local line_suffix = "_"..row
			local score_text_name = "score_text"..line_suffix
			local row_name = "row_bg"..line_suffix
			local row_content = self._widgets_by_name.scores_topics.content[row_name]
			row_content[score_text_name] = mod.scores[row-1].text
			row_content.has_score = true
			for player_index = 1, 4 do
				local line_suffix = "_"..row
				local score_text_name = "score_text"..line_suffix
				local row_name = "row_bg"..line_suffix
				local row_content = self._score_widgets[player_index].content[row_name]
				row_content[score_text_name] = mod.scores[row-1][player_index].score
				row_content.has_highscore = mod.scores[row-1][player_index].has_highscore
				row_content.has_background = row % 2 == 0
				row_content.has_score = true
			end
		end
	end
	-- Set scrollbar
	mod.scrollbar:set()
end)
--[[
	Take away focus from score lines if scrollbar hovered or held
--]]
mod:hook(EndViewStateScore, "_update_entry_hover", function(func, self, ...)
	if mod.scrollbar:is_hovered() or mod.scrollbar:is_held() then
		local content = self._widgets_by_name.scores_topics.content
		for i = 1, content.num_rows, 1 do
			local line_suffix = "_" .. i
			local row_hotspot_name = "hotspot".."_"..i
			local line_hotspot = content[row_hotspot_name]
			if line_hotspot then
				line_hotspot.is_hover = false
			end
		end
	end
	return func(self, ...)
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Settings changed
--]]
mod.on_setting_changed = function(setting_id)
	if setting_id == "extend" then
		-- mod.score_rows = mod:get("extend")
		mod.scoreboard.rows = mod:get("extend")
	end
end
--[[
	Deactivate UISceneGraph hook
--]]
mod.on_enabled = function(is_first_call)
	if is_first_call then
		mod:hook_disable(UISceneGraph, "init_scenegraph")
	end
end

-- ##### ████████╗███████╗███████╗████████╗ ██████╗ ██████╗ ██████╗ ███████╗ ##########################################
-- ##### ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝██╔════╝██╔═══██╗██╔══██╗██╔════╝ ##########################################
-- #####    ██║   █████╗  ███████╗   ██║   ██║     ██║   ██║██║  ██║█████╗   ##########################################
-- #####    ██║   ██╔══╝  ╚════██║   ██║   ██║     ██║   ██║██║  ██║██╔══╝   ##########################################
-- #####    ██║   ███████╗███████║   ██║   ╚██████╗╚██████╔╝██████╔╝███████╗ ##########################################
-- #####    ╚═╝   ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝ ##########################################
--[[
	Testfunctions
--]]
-- mod.get_test_values = function(player_index)
-- 	return math.random(1, 100)
-- end
-- mod.create_test_entries = function(self)
-- 	self:register_entry("test_lowest", "Test Lowest 1", "lowest", self.get_test_values)
-- 	self:register_entry("test_highest", "Test Highest 1", "highest", self.get_test_values)
-- 	self:register_entry("test_none", "Test None", nil, self.get_test_values)
-- 	self:register_entry("test_lowest_2", "Test Lowest 2", "lowest", self.get_test_values)
-- 	self:register_entry("test_highest_2", "Test Highest 2", "highest", self.get_test_values)
-- 	self:register_entry("test_highest_2", "Test Highest 3", "highest", self.get_test_values) -- will already be in list
-- 	-- for i = 1, 100 do
-- 	-- 	local rnd = math.random(1, 2)
-- 	-- 	local type = "lowest"
-- 	-- 	if rnd == 2 then type = "highest" end
-- 	-- 	self:register_entry("test_many_"..i, "Test Many "..i, type, self.get_test_values)
-- 	-- end
-- end
--[[
	Register score entries in on_all_mods_loaded
	Prevents load order issues
--]]
-- mod.on_all_mods_loaded = function()
-- 	mod:create_test_entries()
-- end
