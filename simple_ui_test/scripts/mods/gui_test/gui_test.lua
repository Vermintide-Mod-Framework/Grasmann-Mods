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

	local button = self.window:create_button("button", {10, 50}, {150, 30}, nil, "Test Button", "button 1")
	button.on_click = function(button)
		mod:echo("Button '"..button.params.."' Clicked")
	end

	local textbox = self.window:create_textbox("textbox", {10, 90}, {150, 30}, nil, "", "Test...")
	textbox.on_text_changed = function(textbox)
		mod:echo("Text Changed '"..textbox.text.."'")
	end

	self.window:create_label("label", {10, 130},  {150, 30}, nil, "Test label")

	local dropdown1 = self.window:create_dropdown("dropdown", {10, 170},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, "dropdown 1", 1, true)
	dropdown1.on_index_changed = function(dropdown1)
		mod:echo("Index of '"..dropdown1.params.."' changed")
	end

	local dropdown2 = self.window:create_dropdown("dropdown1", {10, 210},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, "dropdown 2", 2)
	dropdown2.on_index_changed = function(dropdown2)
		mod:echo("Index of '"..dropdown2.params.."' changed")
	end

	local checkbox = self.window:create_checkbox("button", {10, 250}, {30, 30}, nil, "Checkbox", true, "checkbox 1")
	checkbox.on_value_changed = function(checkbox)
		mod:echo("Value of '"..checkbox.params.."' changed")
	end

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

	mod:hook(InventoryView, "on_enter", function(func, ...)
		mod:reload_window()
		return func(...)
	end)

	mod:hook(InventoryView, "unsuspend", function(func, ...)
		mod:reload_window()
		return func(...)
	end)

	mod:hook(InventoryView, "on_exit", function(func, ...)
		mod:destroy_window()
		return func(...)
	end)

else

	mod:hook(HeroView, "on_enter", function(func, ...)
		mod:reload_window()
		return func(...)
	end)

	mod:hook(HeroView, "unsuspend", function(func, ...)
		mod:reload_window()
		return func(...)
	end)

	mod:hook(HeroView, "on_exit", function(func, ...)
		mod:destroy_window()
		return func(...)
	end)

end
