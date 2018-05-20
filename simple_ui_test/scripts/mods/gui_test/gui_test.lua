local mod = get_mod("gui_test")
--[[
	Author: UnShame
	Updates: grasmann
	
	Small test window for simple ui
	
	Version: 2.0.0
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.window = nil

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Create window
--]]
mod.create_window = function(self)
	local window_size = {170, 330}
	local window_position = {500, 500}
	local simple_ui = get_mod("SimpleUI")
	
	self.window = simple_ui:create_window("test", window_position, window_size)

	self.window:create_title("title", "Window Title")
	self.window:create_close_button("close")
	
	local button = self.window:create_button("button", {10, 50}, {150, 30}, nil, "Test Button")
	button:set("on_click", function()
		mod:echo("Button Clicked")
	end)
	
	local textbox = self.window:create_textbox("textbox", {10, 90}, {150, 30}, nil, "", "Test...")
	textbox:set("on_text_changed", function()
		mod:echo("Text Changed")
	end)
	
	self.window:create_label("label", {10, 130},  {150, 30}, nil, "Test label")
	
	local dropdown1 = self.window:create_dropdown("dropdown", {10, 170},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, nil, 1, true)
	dropdown1:set("on_index_changed", function()
		mod:echo("Index changed")
	end)
	
	local dropdown2 = self.window:create_dropdown("dropdown1", {10, 210},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, nil, 2)
	dropdown2:set("on_index_changed", function()
		mod:echo("Index changed")
	end)
	
	local checkbox = self.window:create_checkbox("button", {10, 250}, {30, 30}, nil, "Checkbox", true)
	checkbox:set("on_value_changed", function()
		mod:echo("Test checkbox")
	end)
	
	self.window:init()
end
--[[
	Destroy window
--]]
mod.destroy_window = function(self)
	if self.window then
		self.window:destroy()
		self.window = nil
	end
end
--[[
	Reload window
--]]
mod.reload_window = function(self)
	self:destroy_window()
	self:create_window()
end

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	On enable
--]]
mod.on_enabled = function(initial_call)
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
if VT1 then

	mod:hook("InventoryView.on_enter", function(func, ...)
		mod:reload_window()
		return func(...)
	end)
	
	mod:hook("InventoryView.unsuspend", function(func, ...)
		mod:reload_window()
		return func(...)
	end)
	
	mod:hook("InventoryView.on_exit", function(func, ...)
		mod:destroy_window()
		return func(...)
	end)
	
else

	mod:hook("HeroView.on_enter", function(func, ...)
		mod:reload_window()
		return func(...)
	end)
	
	mod:hook("HeroView.unsuspend", function(func, ...)
		mod:reload_window()
		return func(...)
	end)
	
	mod:hook("HeroView.on_exit", function(func, ...)
		mod:destroy_window()
		return func(...)
	end)
	
end
