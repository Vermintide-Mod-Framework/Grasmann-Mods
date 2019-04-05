local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension

	author: grasmann
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.score_rows = 11
mod.custom_entries = {
	list = {},
	register = function(self, id, text, type, callback)
		local entry = self:get(id)
		if not entry then
			self:add(id, text, type, callback)
		else
			mod:echo("Entry '"..id.."' has already been registered!")
		end
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
mod.scrollbar = {
	size = {},
	scenegraph_id = "scrollbar",
	widget = nil,
	start_index = 1,
	end_index = mod.score_rows,
	is_hovered = function(self)
		return self.widget.content.scroll_bar_info.is_hover
	end,
	is_held = function(self)
		return self.widget.content.scroll_bar_info.is_held
	end,
	set = function(self)
		local rows = #mod.scores
		if rows < 1 then rows = 1 end
		local percentage = mod.score_rows / rows
		self.widget.content.scroll_bar_info.bar_height_percentage = percentage
	end,
	update = function(self, dt)
		local heighest_start_index = #mod.scores - (mod.score_rows - 1)
		local step = 1 / (heighest_start_index)
		local value = self.widget.content.scroll_bar_info.value
		local start_index = math.ceil(value / step)
		if start_index < 1 then start_index = 1 end
		if start_index > heighest_start_index then start_index = heighest_start_index end
		local end_index = start_index + (mod.score_rows - 1)
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
mod.scores = {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Create scrollbar
--]]
mod.create_scrollbar = function(self)
	local definition = UIWidgets.create_scrollbar(mod.scrollbar.scenegraph_id, mod.scrollbar.size)
	return UIWidget.init(definition)
end
--[[
	Register a score entry

	id			: Identifier for the row 				- must be unique
	text		: Display text in the middle 			- readable text
	type		: Highscore type 'highest'/'lowest'/nil	- Decides where to put the circle
	callback	: Function to receive values from 		- function(player_index)
--]]
mod.register_entry = function(self, id, text, type, callback)
	self.custom_entries:register(id, text, type, callback)
end
--[[
	Testfunctions
--]]
mod.get_test_values = function(player_index)
	return math.random(1, 100)
end
mod.create_test_entries = function(self)
	self:register_entry("test_lowest", "Test Lowest 1", "lowest", self.get_test_values)
	self:register_entry("test_highest", "Test Highest 1", "highest", self.get_test_values)
	self:register_entry("test_none", "Test None", nil, self.get_test_values)
	self:register_entry("test_lowest_2", "Test Lowest 2", "lowest", self.get_test_values)
	self:register_entry("test_highest_2", "Test Highest 2", "highest", self.get_test_values)
	self:register_entry("test_highest_2", "Test Highest 3", "highest", self.get_test_values) -- will already be in list
	for i = 1, 100 do
		local rnd = math.random(1, 2)
		local type = "lowest"
		if rnd == 2 then type = "highest" end
		self:register_entry("test_many_"..i, "Test Many "..i, type, self.get_test_values)
	end
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
	local player_score_size = {250, 580 - start}
	local size = {8, player_score_size[2]}
	local position = {-4, 0, 5}
	-- Change scenegraph
	scenegraph.scrollbar = {
		vertical_alignment = "bottom",
		parent = "scores_topics",
		horizontal_alignment = "right",
		size = size,
		position = position,
	}
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
	-- create widgets
	mod.scrollbar.widget = mod:create_scrollbar()
	-- create widgets
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
			local line_suffix = "_"..total_row_index
			local score_text_name = "score_text"..line_suffix
			local row_name = "row_bg"..line_suffix
			local row_content = self._widgets_by_name.scores_topics.content[row_name]
			row_content[score_text_name] = mod.scores[group_row_index].text
			for player_index = 1, 4 do
				local line_suffix = "_"..total_row_index
				local score_text_name = "score_text"..line_suffix
				local row_name = "row_bg"..line_suffix
				local row_content = self._score_widgets[player_index].content[row_name]
				row_content[score_text_name] = mod.scores[group_row_index][player_index].score
				row_content.has_highscore = mod.scores[group_row_index][player_index].has_highscore
			end
			total_row_index = total_row_index + 1
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
	mod:dump(mod.scores, "mod.scores", 3)
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
	Register score entries in on_all_mods_loaded
	Prevents load order issues
--]]
mod.on_all_mods_loaded = function()
	mod:create_test_entries()
end
--[[
	Deactivate UISceneGraph hook
--]]
mod.on_enabled = function(is_first_call)
	if is_first_call then
		mod:hook_disable(UISceneGraph, "init_scenegraph")
	end
end
