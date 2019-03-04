local mod = get_mod("BasicUI")
--[[
	Basic GUI
	
		Provides a screen gui and functionality to draw to it
		
	author: grasmann
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
local UIResolutionScale = UIResolutionScale or UIResolutionScale_pow2

mod.gui = nil
mod.default_world = "top_ingame_view"
mod.default_font = "hell_shark"
mod.default_font_size = 22
mod.default_font_material = "materials/fonts/gw_body_32"

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################
--[[
	Init draw
--]]
mod.init = function(self)
	if not self.gui then self:create_screen_ui() end
end
--[[
	Create screen gui
--]]
mod.create_screen_ui = function(self)
	local manager = Managers.world
	if manager:has_world(self.default_world) then
		local world = manager:world(self.default_world)
		if VT1 then
			self.gui = World.create_screen_gui(world, "immediate", "material", "materials/fonts/gw_fonts", 
				"material", "materials/ui/ui_1080p_ingame_common")
		else
			self.gui = World.create_screen_gui(world, "immediate",
				"material", "materials/fonts/gw_fonts",
				"material", "materials/ui/ui_1080p_hud_atlas_textures",
				"material", "materials/ui/ui_1080p_common")
		end
	end
end
--[[
	Destroy screen gui
--]]
mod.destroy_screen_ui = function(self)
	if self.gui then
		local top_world = Managers.world:world(self.default_world)
		World.destroy_gui(top_world, self.gui)
		self.gui = nil
	end
end

-- ####################################################################################################################
-- ##### Draw functions ###############################################################################################
-- ####################################################################################################################
--[[
	Draw rect with vectors
--]]
mod.rect_vectors = function(self, position, size, color)
	Gui.rect(self.gui, position, size, color)
end
--[[
	Draw text with vectors
--]]
mod.text_vectors = function(self, text, position, font_size, color, font)
	local font_type = font or "hell_shark"
	local font_by_resolution = UIFontByResolution({
		dynamic_font = true,
		font_type = font_type,
		font_size = font_size
	})
	local font, result_size, material = unpack(font_by_resolution)
	Gui.text(self.gui, text, font, font_size, material, position, color)
end
--[[
	Draw bitmap with vectors
--]]
mod.bitmap_uv = function(self, atlas, uv00, uv11, position, size, color)
	local atlas = atlas or "gui_hud_atlas"
	local uv00 = uv00 or Vector2(0.222656, 0.584961)
	local uv11 = uv11 or Vector2(0.25293, 0.615234)
	local position = position or Vector3(1, 1, 1)
	local size = size or Vector2(62, 62)
	local color = color or Color(255, 255, 255, 255)
	return Gui.bitmap_uv(self.gui, atlas, uv00, uv11, position, size, color)
end

-- ####################################################################################################################
-- ##### Overloaded draw functions ####################################################################################
-- ####################################################################################################################
--[[
	Draw rect
	Parameters:
		1) int:X, int:Y, int:Z, int:Width, int:Height, Color:color
		2) vector3:Position, vector2:size, Color:color
--]]
mod.rect = function(self, arg1, arg2, arg3, arg4, arg5, arg6)
	local color = Color(255, 255, 255, 255)
	if type(arg1) == "number" then
		self:rect_vectors(Vector3(arg1, arg2, arg3 or 1), Vector2(arg4, arg5), arg6 or color)
	else
		self:rect_vectors(arg1, arg2, arg3 or color)
	end
end
--[[
	Draw text
	Parameters:
		1) string:Text, int:X, int:Y, int:Z, int:font_size, Color:color, string:font
		2) string:Text, vector3:position, int:font_size, Color:color, string:font
--]]
mod.text = function(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	local color = Color(255, 255, 255, 255)
	local font_size = self.default_font_size
	local font = self.default_font
	if type(arg2) == "number" then
		self:text_vectors(arg1, Vector3(arg2, arg3, arg4 or 1), arg5 or font_size, arg6 or color, arg7 or font)
	else
		self:text_vectors(arg1, arg2, arg3 or font_size, arg4 or color, arg5 or font)
	end
end
--[[
	Create lines from string with \n
--]]
mod.to_lines = function(self, text, font_size, font_material, colors)
	local get_color = function(index)
		if #colors >= index then
			if colors[index] then
				return colors[index]
			end
		else
			return colors[#colors]
		end
		return {255, 255, 255, 255}
	end
	local _lines = {}
	local width = 0
	local height = 0
	font_size = font_size or self.default_font_size
	local index = 1
	font_material = font_material or self.default_font_material
	for line in string.gmatch(text.."\n", "([^\n]*)\n") do
		local w = self:text_width(line, font_material, font_size)
		if line == "" then line = "#" end
		if w > width then width = w end
		--local h = self:text_height(line, font_material, font_size)
		height = height + font_size --h
		_lines[#_lines+1] = {
			text = line,
			width = w,
			height = font_size, --h,
			color = get_color(index),
		}
		index = index + 1
	end
	if #_lines == 0 and #text > 0 then
		_lines[#_lines+1] = text
	end
	local result = {
		size = {width, height},
		["lines"] = _lines,
	}
	return result
end
--[[
	Draw tooltip
	Parameters:
		1) string:Text [, table:colors, int:font_size, int:line_padding, table:offset, table:padding, string:font_material]
--]]
mod.tooltip = function(self, str, colors, font_size, line_padding, offset, padding, font_material, size)
	-- Create default colors if nil
	colors = colors or 
		{Colors.get_color_table_with_alpha("cheeseburger", 255),
		Colors.get_color_table_with_alpha("white", 255),}
	-- Get mouse position
	local cursor_axis_id = stingray.Mouse.axis_id("cursor")
	local mouse = stingray.Mouse.axis(cursor_axis_id)
	-- UI
	local scale = UIResolutionScale()
	local screen_w, screen_h = UIResolution()
	-- Font
	font_size = font_size or screen_w / 100
	font_material = font_material or self.default_font_material --"materials/fonts/gw_body_32"
	-- Offset / Padding
	offset = offset or {20*scale, -20*scale}
	padding = padding or {5*scale, 5*scale, 5*scale, 5*scale}
	line_padding = line_padding or 0*scale
	-- Transform string
	local text = self:to_lines(str, font_size, font_material, colors)
	-- Transform simple text size
	if #text.lines > 0 then
		text.size[2] = text.size[2] + (#text.lines-1 * line_padding) + padding[4] + padding[1]
		text.size[1] = text.size[1] + padding[1] + padding[3]
	end
	-- Render background
	local x = mouse[1] + offset[1]
	local y = mouse[2] + offset[2]
	size = size or Vector2(text.size[1], text.size[2])
	self:rect(Vector3(x, y, 999), size, Color(200, 0, 0, 0))
	-- Render lines
	--self:echo("rofl")
	local text_x = x + padding[1]
	local text_y = y + text.size[2] - padding[2] - font_size
	--local index = 1
	local icon_size = Vector2(50*scale, 50*scale)
	local icon_x = text_x
	local icon_y = text_y - icon_size[2]
	for _, line in pairs(text.lines) do
		if line.text ~= "#" then
			local color = Color(line.color[1], line.color[2], line.color[3], line.color[4])
			self:text(line.text, Vector3(text_x, text_y, 999), font_size, color)
		end
		text_y = text_y - line.height - line_padding
	end
end
--[[
	Draw mission icon
	Parameters:
		1) vector3:position, string:text, vector2:text_offset, color:color, [vector2:size, int:font_size, string:font]
		
		text_offset:
		By default the text will be placed to the right of the icon up half its size
		The offset if set will be calculated from the middle of the icon
--]]
mod.side_mission_icon = function(self, position, text, text_offset, color, size, font_size, font, text_color)
	local atlas = "gui_hud_atlas"
	local uv00 = Vector2(0.222656, 0.584961)
	local uv11 = Vector2(0.25293, 0.615234)
	local position = position or Vector3(1, 1, 1)
	local size = size or Vector2(62, 62)
	local color = color or Color(255, 255, 255, 255)
	local id = self:bitmap_uv(atlas, uv00, uv11, position, size, color)
	if text ~= nil then
		if text_offset ~= nil then
			position = position + Vector3(text_offset[1], text_offset[2], 0)
		else
			position = position + Vector3(size[1], size[2] / 2, 0)
		end
		local font_size = font_size or self.default_font_size
		local font = self.default_font
		local text_color = text_color or color
		self:text_vectors(text, position, font_size, text_color, font)
	end
	return id, size, color
end
--[[
	Draw tome icon
	Parameters:
		1) vector3:position, color:color, vector2:size
--]]
mod.tome_icon = function(self, position, color, size)
	local icon_texture = "consumables_book_lit"
	local icon_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_texture)
	
	local atlas = "gui_generic_icons_atlas"
	local size = size or Vector2(icon_settings.size[1], icon_settings.size[2])
	local color = color or Color(255, 255, 255, 255)
	local uv00 = Vector2(icon_settings.uv00[1], icon_settings.uv00[2])
	local uv11 = Vector2(icon_settings.uv11[1], icon_settings.uv11[2])
	local position = position or Vector3(1, 1, 1)
	return self:bitmap_uv(atlas, uv00, uv11, position, size, color)
end
--[[
	Draw grim icon
	Parameters:
		1) vector3:position, color:color, vector2:size
--]]
mod.grim_icon = function(self, position, color, size)
	local icon_texture = "consumables_grimoire_lit"
	local icon_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_texture)

	local atlas = "gui_generic_icons_atlas"
	local size = size or Vector2(icon_settings.size[1], icon_settings.size[2])
	local color = color or Color(255, 255, 255, 255)
	local uv00 = Vector2(icon_settings.uv00[1], icon_settings.uv00[2])
	local uv11 = Vector2(icon_settings.uv11[1], icon_settings.uv11[2])
	local position = position or Vector3(1, 1, 1)
	return self:bitmap_uv(atlas, uv00, uv11, position, size, color)
end
--[[
	Draw texture
	Parameters:
		1) string:texture_name, vector3:position, color:color, vector2:size, string:atlas
--]]
mod.draw_icon = function(self, icon_texture, position, color, size, atlas)
	local icon_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_texture)

	local atlas = atlas or "gui_generic_icons_atlas"
	local size = size or Vector2(icon_settings.size[1], icon_settings.size[2])
	local color = color or Color(255, 255, 255, 255)
	local uv00 = Vector2(icon_settings.uv00[1], icon_settings.uv00[2])
	local uv11 = Vector2(icon_settings.uv11[1], icon_settings.uv11[2])
	local position = position or Vector3(1, 1, 1)
	return self:bitmap_uv(atlas, uv00, uv11, position, size, color)
end

-- ##### ██╗███╗   ██╗███████╗ ██████╗  ###############################################################################
-- ##### ██║████╗  ██║██╔════╝██╔═══██╗ ###############################################################################
-- ##### ██║██╔██╗ ██║█████╗  ██║   ██║ ###############################################################################
-- ##### ██║██║╚██╗██║██╔══╝  ██║   ██║ ###############################################################################
-- ##### ██║██║ ╚████║██║     ╚██████╔╝ ###############################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝  ###############################################################################
--[[
	Get width of a text with the given font and font size
--]]
mod.text_width = function(self, text, font, font_size)
	local text_extent_min, text_extent_max = Gui.text_extents(self.gui, text, font or self.default_font, font_size or self.default_font_size)
	local text_width = text_extent_max[1] - text_extent_min[1]
	return text_width
end
--[[
	Get height of a text with the given font and font size
--]]
mod.text_height = function(self, text, font, font_size)
	local text_extent_min, text_extent_max = Gui.text_extents(self.gui, text, font or self.default_font, font_size or self.default_font_size)
	local text_height = text_extent_max[2] - text_extent_min[2]
	return text_height
end

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Game state change
--]]
mod.on_game_state_changed = function(status, state)
	if status == "enter" and state == "StateIngame" then mod:init() end
end
--[[
	On enable
--]]
mod.on_enabled = function(initial_call)
end
--[[
	On unload
--]]
mod.on_unload = function(exit_game)
	mod:destroy_screen_ui()
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
if Managers.world then
	if not mod.gui then
		mod:init()
	end
end
